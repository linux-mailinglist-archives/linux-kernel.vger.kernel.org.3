Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97555955EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiHPJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiHPJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:07:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC4BA7DF7F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:25:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59D021DB5;
        Tue, 16 Aug 2022 00:25:20 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDD443F70D;
        Tue, 16 Aug 2022 00:25:17 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, cristian.marussi@arm.com
Subject: [RFC PATCH 6/6] firmware: arm_scmi: Call Raw mode hooks from the core stack
Date:   Tue, 16 Aug 2022 08:24:50 +0100
Message-Id: <20220816072450.3120959-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220816072450.3120959-1-cristian.marussi@arm.com>
References: <20220816072450.3120959-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few call sites where, if SCMI Raw mode access had been enabled in
Kconfig, the needed SCMI Raw initialization and hooks are called.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 141a140792a5..0068a2ec3b4d 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -23,10 +23,12 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/hashtable.h>
+#include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/poll.h>
 #include <linux/processor.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
@@ -34,6 +36,8 @@
 #include "common.h"
 #include "notify.h"
 
+#include "raw_mode.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
 
@@ -133,6 +137,7 @@ struct scmi_protocol_instance {
  * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
+ * @raw: An opaque reference handle used by SCMI Raw mode.
  */
 struct scmi_info {
 	struct device *dev;
@@ -152,6 +157,7 @@ struct scmi_info {
 	void *notify_priv;
 	struct list_head node;
 	int users;
+	void *raw;
 };
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
@@ -678,6 +684,9 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 static inline void scmi_xfer_command_release(struct scmi_info *info,
 					     struct scmi_xfer *xfer)
 {
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+		scmi_raw_message_report(info->raw, xfer, SCMI_RAW_REPLY_QUEUE);
+
 	atomic_set(&xfer->busy, SCMI_XFER_FREE);
 	__scmi_xfer_put(&info->tx_minfo, xfer);
 }
@@ -744,6 +753,11 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
 			   MSG_TYPE_NOTIFICATION);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		xfer->hdr.seq = MSG_XTRACT_TOKEN(msg_hdr);
+		scmi_raw_message_report(info->raw, xfer, SCMI_RAW_NOTIF_QUEUE);
+	}
+
 	__scmi_xfer_put(minfo, xfer);
 
 	scmi_clear_channel(info, cinfo);
@@ -757,6 +771,9 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 
 	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
+		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+			scmi_raw_error_report(info->raw, msg_hdr, priv);
+
 		if (MSG_XTRACT_TYPE(msg_hdr) == MSG_TYPE_DELAYED_RESP)
 			scmi_clear_channel(info, cinfo);
 		return;
@@ -2486,6 +2503,18 @@ static int scmi_probe(struct platform_device *pdev)
 		dev_err(dev,
 			"Transport is not polling capable. Atomic mode not supported.\n");
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		struct scmi_chan_info *cinfo;
+
+		cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
+		info->raw = scmi_raw_mode_init(cinfo, info->desc,
+					       info->tx_minfo.max_msg);
+		if (IS_ERR(info->raw)) {
+			dev_err(dev, "Failed to initialize SCMI RAW Mode !\n");
+			info->raw = NULL;
+		}
+	}
+
 	/*
 	 * Trigger SCMI Base protocol initialization.
 	 * It's mandatory and won't be ever released/deinit until the
@@ -2552,6 +2581,9 @@ static int scmi_remove(struct platform_device *pdev)
 	struct scmi_info *info = platform_get_drvdata(pdev);
 	struct device_node *child;
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+		scmi_raw_mode_cleanup(info->raw);
+
 	mutex_lock(&scmi_list_mutex);
 	if (info->users)
 		ret = -EBUSY;
-- 
2.32.0

