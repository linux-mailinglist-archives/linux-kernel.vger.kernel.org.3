Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2523A4C2F88
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiBXPZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiBXPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:24:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4EA722502E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:24:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1399ED1;
        Thu, 24 Feb 2022 07:24:28 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 139BE3F66F;
        Thu, 24 Feb 2022 07:24:27 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Remove clear channel call on the TX channel
Date:   Thu, 24 Feb 2022 15:24:04 +0000
Message-Id: <20220224152404.12877-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SCMI transports whose channels are based on a shared resource the TX
channel area has to be acquired by the agent before placing the desired
command into the channel and it will be then relinquished by the platform
once the related reply has been made available into the channel.
On an RX channel the logic is reversed with the platform acquiring the
channel area and the agent reliquishing it once done by calling the
scmi_clear_channel() helper.

As a consequence, even in case of error, the agent must never try to clear
a TX channel from its side: restrict the existing clear channel call on the
the reply path only to delayed responses since they are indeed coming from
the RX channel.

Fixes: e9b21c96181c ("firmware: arm_scmi: Make .clear_channel optional")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Applies on sudeep/for-next/scmi/fixes on top of

commit 1ba603f56568 firmware: arm_scmi: Remove space in MODULE_ALIAS name
---
 drivers/firmware/arm_scmi/driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d76bab3aaac4..e815b8f98739 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -652,7 +652,8 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 
 	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
-		scmi_clear_channel(info, cinfo);
+		if (MSG_XTRACT_TYPE(msg_hdr) == MSG_TYPE_DELAYED_RESP)
+			scmi_clear_channel(info, cinfo);
 		return;
 	}
 
-- 
2.17.1

