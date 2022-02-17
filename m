Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6C84BA0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240754AbiBQNN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:13:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBQNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:13:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3A8A2AE285
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:13:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7C22152B;
        Thu, 17 Feb 2022 05:13:01 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53AB53F66F;
        Thu, 17 Feb 2022 05:13:00 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v5 5/8] firmware: arm_scmi: Support optional system wide atomic-threshold-us
Date:   Thu, 17 Feb 2022 13:12:31 +0000
Message-Id: <20220217131234.50328-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217131234.50328-1-cristian.marussi@arm.com>
References: <20220217131234.50328-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An SCMI agent can be configured system-wide with a well-defined atomic
threshold: only SCMI synchronous command whose latency has been advertised
by the SCMI platform to be lower or equal to this configured threshold will
be considered for atomic operations, when requested and if supported by the
underlying transport at all.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- renamed DT property to atomic-threshold-us
---
 drivers/firmware/arm_scmi/driver.c | 27 ++++++++++++++++++++++++---
 include/linux/scmi_protocol.h      |  5 ++++-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 4fd5a35ffa2f..7436c475e708 100644
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
@@ -1406,15 +1413,22 @@ static void scmi_devm_protocol_put(struct scmi_device *sdev, u8 protocol_id)
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
@@ -1954,6 +1968,13 @@ static int scmi_probe(struct platform_device *pdev)
 	handle->version = &info->version;
 	handle->devm_protocol_get = scmi_devm_protocol_get;
 	handle->devm_protocol_put = scmi_devm_protocol_put;
+
+	/* System wide atomic threshold for atomic ops .. if any */
+	if (!of_property_read_u32(np, "atomic-threshold-us",
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

