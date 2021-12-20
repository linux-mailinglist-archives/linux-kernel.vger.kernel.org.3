Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C3647B40E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhLTT5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:57:40 -0500
Received: from foss.arm.com ([217.140.110.172]:34574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233249AbhLTT53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:57:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 924821042;
        Mon, 20 Dec 2021 11:57:28 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E312F3F718;
        Mon, 20 Dec 2021 11:57:26 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v8 03/11] firmware: arm_scmi: Add sync_cmds_completed_on_ret transport flag
Date:   Mon, 20 Dec 2021 19:56:38 +0000
Message-Id: <20211220195646.44498-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220195646.44498-1-cristian.marussi@arm.com>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to let the transport signal to the core if its handling of sync
command implies that, after .send_message has returned successfully, the
requested command can be assumed to be fully and completely executed on
SCMI platform side so that any possible response value is already
immediately available to be retrieved by a .fetch_response: in other words
the polling phase can be skipped in such a case and the response values
accessed straight away.

Note that all of the above applies only when polling mode of operation was
selected by the core: if instead a completion IRQ was found to be available
the normal response processing path based on completions will still be
followed.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v7 --> v8
- renaming to sync_cmds_completed_on_ret
- removed poling_capable flag, using macros
v5 --> v6
- added polling_capable helper flag
v4 --> v5
- removed RFC tag
- consider sync_cmds_atomic_replies flag when deciding if polling is to be
  supported and .poll_done() is not provided.
- reviewed commit message
---
 drivers/firmware/arm_scmi/common.h |  8 ++++++
 drivers/firmware/arm_scmi/driver.c | 40 ++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 652e5d95ee65..24b1d1ac5f12 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -409,6 +409,13 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  * @max_msg_size: Maximum size of data per message that can be handled.
  * @force_polling: Flag to force this whole transport to use SCMI core polling
  *		   mechanism instead of completion interrupts even if available.
+ * @sync_cmds_completed_on_ret: Flag to indicate that the transport assures
+ *				synchronous-command messages are atomically
+ *				completed on .send_message: no need to poll
+ *				actively waiting for a response.
+ *				Used by core internally only when polling is
+ *				selected as a waiting for reply method: i.e.
+ *				if a completion irq was found use that anyway.
  */
 struct scmi_desc {
 	int (*transport_init)(void);
@@ -418,6 +425,7 @@ struct scmi_desc {
 	int max_msg;
 	int max_msg_size;
 	const bool force_polling;
+	const bool sync_cmds_completed_on_ret;
 };
 
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index cb9fc12503f2..d4dd42ebc5e8 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -40,7 +40,14 @@
 	((__c)->no_completion_irq || (__i)->desc->force_polling)	\
 
 #define IS_TRANSPORT_POLLING_CAPABLE(__i)				\
-	((__i)->desc->ops->poll_done)
+({									\
+	bool __ret;							\
+	typeof(__i) i_ = __i;						\
+									\
+	__ret = ((i_)->desc->ops->poll_done ||				\
+			(i_)->desc->sync_cmds_completed_on_ret);	\
+	__ret;								\
+})
 
 #define IS_POLLING_ENABLED(__c, __i)					\
 ({									\
@@ -780,10 +787,28 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 				      xfer->hdr.poll_completion);
 
 	if (xfer->hdr.poll_completion) {
-		ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
+		/*
+		 * Real polling is needed only if transport has NOT declared
+		 * itself to support synchronous commands replies.
+		 */
+		if (!info->desc->sync_cmds_completed_on_ret) {
+			/*
+			 * Poll on xfer using transport provided .poll_done();
+			 * assumes no completion interrupt was available.
+			 */
+			ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
+
+			spin_until_cond(scmi_xfer_done_no_timeout(cinfo,
+								  xfer, stop));
+			if (ktime_after(ktime_get(), stop)) {
+				dev_err(dev,
+					"timed out in resp(caller: %pS) - polling\n",
+					(void *)_RET_IP_);
+				ret = -ETIMEDOUT;
+			}
+		}
 
-		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
-		if (ktime_before(ktime_get(), stop)) {
+		if (!ret) {
 			unsigned long flags;
 
 			/*
@@ -796,11 +821,6 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 				xfer->state = SCMI_XFER_RESP_OK;
 			}
 			spin_unlock_irqrestore(&xfer->lock, flags);
-		} else {
-			dev_err(dev,
-				"timed out in resp(caller: %pS) - polling\n",
-				(void *)_RET_IP_);
-			ret = -ETIMEDOUT;
 		}
 	} else {
 		/* And we wait for the response. */
@@ -835,7 +855,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	struct scmi_chan_info *cinfo;
 
 	/* Check for polling request on custom command xfers at first */
-	if (xfer->hdr.poll_completion && !info->desc->ops->poll_done) {
+	if (xfer->hdr.poll_completion && !IS_TRANSPORT_POLLING_CAPABLE(info)) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
 		return -EINVAL;
-- 
2.17.1

