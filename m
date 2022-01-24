Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77854497CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiAXKEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:04:33 -0500
Received: from foss.arm.com ([217.140.110.172]:56024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235062AbiAXKEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:04:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64F9D6D;
        Mon, 24 Jan 2022 02:04:12 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78A773F73B;
        Mon, 24 Jan 2022 02:04:10 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH 3/6] firmware: arm_scmi: Support optional system wide atomic_threshold
Date:   Mon, 24 Jan 2022 10:03:38 +0000
Message-Id: <20220124100341.41191-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124100341.41191-1-cristian.marussi@arm.com>
References: <20220124100341.41191-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An SCMI agent can be configured system-wide with a well-defined atomic
threshold: only SCMI synchronous command whose latency has been advertised
by the SCMI platform to be lower or equal to this configured threshold will
be considered for atomic operations, when requested and supported by the
underlying transport at all.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 27 ++++++++++++++++++++++++---
 include/linux/scmi_protocol.h      |  5 ++++-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index dc972a54e93e..d2ac6291b84b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -131,6 +131,12 @@ struct scmi_protocol_instance {
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @active_protocols: IDR storing device_nodes for protocols actually defined
  *		      in the DT and confirmed as implemented by fw.
+ * @atomic_threshold: Optional system wide DT-configured threshold, expressed
+ *		      in microseconds, for atomic operations.
+ *		      Only SCMI synchronous commands reported by the platform
+ *		      to have an execution latency lesser-equal to the threshold
+ *		      should be considered for atomic mode operation: such
+ *		      decision is finally left up to the SCMI drivers.
  * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
@@ -149,6 +155,7 @@ struct scmi_info {
 	struct mutex protocols_mtx;
 	u8 *protocols_imp;
 	struct idr active_protocols;
+	unsigned int atomic_threshold;
 	void *notify_priv;
 	struct list_head node;
 	int users;
@@ -1409,15 +1416,22 @@ static void scmi_devm_protocol_put(struct scmi_device *sdev, u8 protocol_id)
  * SCMI instance is configured as atomic.
  *
  * @handle: A reference to the SCMI platform instance.
+ * @atomic_threshold: An optional return value for the system wide currently
+ *		      configured threshold for atomic operations.
  *
  * Return: True if transport is configured as atomic
  */
-static bool scmi_is_transport_atomic(const struct scmi_handle *handle)
+static bool scmi_is_transport_atomic(const struct scmi_handle *handle,
+				     unsigned int *atomic_threshold)
 {
+	bool ret;
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
-	return info->desc->atomic_enabled &&
-		is_transport_polling_capable(info);
+	ret = info->desc->atomic_enabled && is_transport_polling_capable(info);
+	if (ret && atomic_threshold)
+		*atomic_threshold = info->atomic_threshold;
+
+	return ret;
 }
 
 static inline
@@ -1957,6 +1971,13 @@ static int scmi_probe(struct platform_device *pdev)
 	handle->version = &info->version;
 	handle->devm_protocol_get = scmi_devm_protocol_get;
 	handle->devm_protocol_put = scmi_devm_protocol_put;
+
+	/* System wide atomic threshold for atomic ops .. if any */
+	if (!of_property_read_u32(np, "atomic_threshold",
+				  &info->atomic_threshold))
+		dev_info(dev,
+			 "SCMI System wide atomic threshold set to %d us\n",
+			 info->atomic_threshold);
 	handle->is_transport_atomic = scmi_is_transport_atomic;
 
 	if (desc->ops->link_supplier) {
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 9f895cb81818..fdf6bd83cc59 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -619,6 +619,8 @@ struct scmi_notify_ops {
  *			 be interested to know if they can assume SCMI
  *			 command transactions associated to this handle will
  *			 never sleep and act accordingly.
+ *			 An optional atomic threshold value could be returned
+ *			 where configured.
  * @notify_ops: pointer to set of notifications related operations
  */
 struct scmi_handle {
@@ -629,7 +631,8 @@ struct scmi_handle {
 		(*devm_protocol_get)(struct scmi_device *sdev, u8 proto,
 				     struct scmi_protocol_handle **ph);
 	void (*devm_protocol_put)(struct scmi_device *sdev, u8 proto);
-	bool (*is_transport_atomic)(const struct scmi_handle *handle);
+	bool (*is_transport_atomic)(const struct scmi_handle *handle,
+				    unsigned int *atomic_threshold);
 
 	const struct scmi_notify_ops *notify_ops;
 };
-- 
2.17.1

