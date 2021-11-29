Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13630462006
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359606AbhK2TSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:18:02 -0500
Received: from foss.arm.com ([217.140.110.172]:45468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243233AbhK2TPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:15:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6173C13D5;
        Mon, 29 Nov 2021 11:12:35 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5843F5A1;
        Mon, 29 Nov 2021 11:12:33 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 03/16] firmware: arm_scmi: Refactor message response path
Date:   Mon, 29 Nov 2021 19:11:43 +0000
Message-Id: <20211129191156.29322-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211129191156.29322-1-cristian.marussi@arm.com>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor code path waiting for message responses into a dedicated helper
function.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 88 +++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 568562121f64..9a8d6bfd4ebb 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -738,6 +738,61 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
 	       ktime_after(ktime_get(), stop);
 }
 
+/**
+ * scmi_wait_for_message_response  - An helper to group all the possible ways of
+ * waiting for a synchronous message response.
+ *
+ * @cinfo: SCMI channel info
+ * @xfer: Reference to the transfer being waited for.
+ *
+ * Chooses waiting strategy (sleep-waiting vs busy-waiting) depending on
+ * configuration flags like xfer->hdr.poll_completion.
+ *
+ * Return: 0 on Success, error otherwise.
+ */
+static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
+					  struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+	struct device *dev = info->dev;
+	int ret = 0, timeout_ms = info->desc->max_rx_timeout_ms;
+
+	if (xfer->hdr.poll_completion) {
+		ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
+
+		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
+		if (ktime_before(ktime_get(), stop)) {
+			unsigned long flags;
+
+			/*
+			 * Do not fetch_response if an out-of-order delayed
+			 * response is being processed.
+			 */
+			spin_lock_irqsave(&xfer->lock, flags);
+			if (xfer->state == SCMI_XFER_SENT_OK) {
+				info->desc->ops->fetch_response(cinfo, xfer);
+				xfer->state = SCMI_XFER_RESP_OK;
+			}
+			spin_unlock_irqrestore(&xfer->lock, flags);
+		} else {
+			dev_err(dev,
+				"timed out in resp(caller: %pS) - polling\n",
+				(void *)_RET_IP_);
+			ret = -ETIMEDOUT;
+		}
+	} else {
+		/* And we wait for the response. */
+		if (!wait_for_completion_timeout(&xfer->done,
+						 msecs_to_jiffies(timeout_ms))) {
+			dev_err(dev, "timed out in resp(caller: %pS)\n",
+				(void *)_RET_IP_);
+			ret = -ETIMEDOUT;
+		}
+	}
+
+	return ret;
+}
+
 /**
  * do_xfer() - Do one transfer
  *
@@ -752,7 +807,6 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		   struct scmi_xfer *xfer)
 {
 	int ret;
-	int timeout;
 	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
 	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 	struct device *dev = info->dev;
@@ -796,37 +850,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		return ret;
 	}
 
-	if (xfer->hdr.poll_completion) {
-		ktime_t stop = ktime_add_ms(ktime_get(),
-					    info->desc->max_rx_timeout_ms);
-
-		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
-		if (ktime_before(ktime_get(), stop)) {
-			unsigned long flags;
-
-			/*
-			 * Do not fetch_response if an out-of-order delayed
-			 * response is being processed.
-			 */
-			spin_lock_irqsave(&xfer->lock, flags);
-			if (xfer->state == SCMI_XFER_SENT_OK) {
-				info->desc->ops->fetch_response(cinfo, xfer);
-				xfer->state = SCMI_XFER_RESP_OK;
-			}
-			spin_unlock_irqrestore(&xfer->lock, flags);
-		} else {
-			ret = -ETIMEDOUT;
-		}
-	} else {
-		/* And we wait for the response. */
-		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
-		if (!wait_for_completion_timeout(&xfer->done, timeout)) {
-			dev_err(dev, "timed out in resp(caller: %pS)\n",
-				(void *)_RET_IP_);
-			ret = -ETIMEDOUT;
-		}
-	}
-
+	ret = scmi_wait_for_message_response(cinfo, xfer);
 	if (!ret && xfer->hdr.status)
 		ret = scmi_to_linux_errno(xfer->hdr.status);
 
-- 
2.17.1

