Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927C856214F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiF3RcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiF3Rbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:31:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB31929CAF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:31:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7EFE1424;
        Thu, 30 Jun 2022 10:31:54 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D3803F792;
        Thu, 30 Jun 2022 10:31:53 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, lukasz.luba@arm.com,
        james.quinlan@broadcom.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 2/2] firmware: arm_scmi: Use new SCMI full message tracing
Date:   Thu, 30 Jun 2022 18:31:35 +0100
Message-Id: <20220630173135.2086631-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220630173135.2086631-1-cristian.marussi@arm.com>
References: <20220630173135.2086631-1-cristian.marussi@arm.com>
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

Add full message tracing for all transmitted and successfully received SCMI
commands, replies and notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c4e291f3fede..31afd60982f1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -661,6 +661,11 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 		smp_store_mb(xfer->priv, priv);
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
+
+	trace_scmi_msg_dump(xfer->hdr.protocol_id, xfer->hdr.id, "NOTI",
+			    xfer->hdr.seq, xfer->hdr.status,
+			    xfer->rx.buf, xfer->rx.len);
+
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
 		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts);
 
@@ -695,6 +700,12 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 		smp_store_mb(xfer->priv, priv);
 	info->desc->ops->fetch_response(cinfo, xfer);
 
+	trace_scmi_msg_dump(xfer->hdr.protocol_id, xfer->hdr.id,
+			    xfer->hdr.type == MSG_TYPE_DELAYED_RESP ?
+			    "DLYD" : "RESP",
+			    xfer->hdr.seq, xfer->hdr.status,
+			    xfer->rx.buf, xfer->rx.len);
+
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
 			   xfer->hdr.type);
@@ -828,6 +839,12 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 				xfer->state = SCMI_XFER_RESP_OK;
 			}
 			spin_unlock_irqrestore(&xfer->lock, flags);
+
+			/* Trace polled replies. */
+			trace_scmi_msg_dump(xfer->hdr.protocol_id, xfer->hdr.id,
+					    "RESP",
+					    xfer->hdr.seq, xfer->hdr.status,
+					    xfer->rx.buf, xfer->rx.len);
 		}
 	} else {
 		/* And we wait for the response. */
@@ -904,6 +921,10 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		return ret;
 	}
 
+	trace_scmi_msg_dump(xfer->hdr.protocol_id, xfer->hdr.id, "CMND",
+			    xfer->hdr.seq, xfer->hdr.status,
+			    xfer->tx.buf, xfer->tx.len);
+
 	ret = scmi_wait_for_message_response(cinfo, xfer);
 	if (!ret && xfer->hdr.status)
 		ret = scmi_to_linux_errno(xfer->hdr.status);
-- 
2.32.0

