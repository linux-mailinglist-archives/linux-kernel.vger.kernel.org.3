Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5054C5EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiB0U5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiB0U5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DBC5338A3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AB611477;
        Sun, 27 Feb 2022 12:56:30 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B39573F66F;
        Sun, 27 Feb 2022 12:56:28 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 05/16] firmware: arm_scmi: Expose information on configured transport
Date:   Sun, 27 Feb 2022 20:55:57 +0000
Message-Id: <20220227205608.30812-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227205608.30812-1-cristian.marussi@arm.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common descriptor to describe transport features and expose it via
the SCMI instance handle.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 12 ++++++++++++
 include/linux/scmi_protocol.h      | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8d356d4da0bd..8c5429529946 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1966,6 +1966,7 @@ static int scmi_probe(struct platform_device *pdev)
 	struct scmi_handle *handle;
 	const struct scmi_desc *desc;
 	struct scmi_info *info;
+	struct scmi_transport_info *trans;
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node;
 
@@ -2023,6 +2024,17 @@ static int scmi_probe(struct platform_device *pdev)
 		dev_err(dev,
 			"Transport is not polling capable. Atomic mode not supported.\n");
 
+	trans = devm_kzalloc(dev, sizeof(*trans), GFP_KERNEL);
+	if (!trans)
+		return -ENOMEM;
+
+	of_property_read_string(dev->of_node, "compatible", &trans->compatible);
+	trans->is_atomic =
+		handle->is_transport_atomic(handle,
+					    &trans->atomic_threshold_us);
+	trans->max_rx_timeout_ms = info->desc->max_rx_timeout_ms;
+	handle->transport = trans;
+
 	/*
 	 * Trigger SCMI Base protocol initialization.
 	 * It's mandatory and won't be ever released/deinit until the
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index c5881d15f7d9..0b024d23a9b3 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -40,6 +40,24 @@ struct scmi_revision_info {
 	char sub_vendor_id[SCMI_MAX_STR_SIZE];
 };
 
+/**
+ * struct scmi_transport_info  - transport related information
+ *
+ * @compatible: Transport name picked from compatible string
+ * @is_atomic: True if the underlying transport can support atomic transactions
+ *	       and atomic mode is enabled.
+ * @atomic_threshold_us: Optional system wide DT-configured threshold, expressed
+ *			 in microseconds, for atomic operations.
+ * @max_rx_timeout_ms: configured maximum timeout in milliseconds for command
+ *		       replies.
+ */
+struct scmi_transport_info {
+	const char *compatible;
+	bool is_atomic;
+	unsigned int atomic_threshold_us;
+	unsigned int max_rx_timeout_ms;
+};
+
 struct scmi_clock_info {
 	char name[SCMI_MAX_STR_SIZE];
 	unsigned int enable_latency;
@@ -633,6 +651,7 @@ struct scmi_notify_ops {
  *
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
+ * @transport: pointer to the structure containing SCMI transport information
  * @devm_protocol_get: devres managed method to acquire a protocol and get specific
  *		       operations and a dedicated protocol handler
  * @devm_protocol_put: devres managed method to release a protocol
@@ -650,6 +669,7 @@ struct scmi_notify_ops {
 struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
+	struct scmi_transport_info *transport;
 
 	const void __must_check *
 		(*devm_protocol_get)(struct scmi_device *sdev, u8 proto,
-- 
2.17.1

