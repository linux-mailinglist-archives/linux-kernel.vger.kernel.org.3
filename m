Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80A04EFE53
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 06:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbiDBED0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 00:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiDBEDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 00:03:23 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE53D192581
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 21:01:29 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 2 Apr 2022
 20:11:54 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Sat, 2 Apr
 2022 12:01:26 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Corey Minyard <minyard@acm.org>
CC:     Haowen Bai <baihaowen@meizu.com>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] ipmi: ssif: potential NULL dereference in msg_done_handler()
Date:   Sat, 2 Apr 2022 12:01:20 +0800
Message-ID: <1648872080-9605-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <94f5e266-4412-cf45-9ac3-bbe78477f0c4@meizu.com>
References: <94f5e266-4412-cf45-9ac3-bbe78477f0c4@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-123.meizu.com (172.16.1.123) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msg could be null without checking null and return, but still dereference
msg->rsp[2] and will lead to a null pointer trigger.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: check msg both cases that also uses msg; add logs;

 drivers/char/ipmi/ipmi_ssif.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index f199cc194844..eb6bdd44b69e 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -758,8 +758,11 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 	switch (ssif_info->ssif_state) {
 	case SSIF_NORMAL:
 		ipmi_ssif_unlock_cond(ssif_info, flags);
-		if (!msg)
+		if (!msg) {
+			dev_dbg(&ssif_info->client->dev,
+				"msg was null, case SSIF_NORMAL\n");
 			break;
+		}
 
 		if (result < 0)
 			return_hosed_msg(ssif_info, msg);
@@ -814,6 +817,13 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		break;
 
 	case SSIF_GETTING_EVENTS:
+		if (!msg) {
+			ipmi_ssif_unlock_cond(ssif_info, flags);
+			dev_dbg(&ssif_info->client->dev,
+				"msg was null, case SSIF_GETTING_EVENTS\n");
+			break;
+		}
+
 		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
 			/* Error getting event, probably done. */
 			msg->done(msg);
@@ -838,6 +848,13 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		break;
 
 	case SSIF_GETTING_MESSAGES:
+		if (!msg) {
+			ipmi_ssif_unlock_cond(ssif_info, flags);
+			dev_dbg(&ssif_info->client->dev,
+				"msg was null, case SSIF_GETTING_MESSAGES\n");
+			break;
+		}
+
 		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
 			/* Error getting event, probably done. */
 			msg->done(msg);
-- 
2.7.4

