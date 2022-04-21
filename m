Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320565094A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 03:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383638AbiDUBhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 21:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiDUBhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:37:13 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982211402B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:34:24 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 21 Apr
 2022 09:34:17 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 21 Apr
 2022 09:34:16 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V4] staging: rtl8192e: Fix signedness bug in rtllib_rx_assoc_resp()
Date:   Thu, 21 Apr 2022 09:34:14 +0800
Message-ID: <1650504854-17576-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <YmA3ttZal8Bwlp7P@kroah.com>
References: <YmA3ttZal8Bwlp7P@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtllib_rx_assoc_resp() function has a signedness bug because it's
a declared as a u16 but it return -ENOMEM.  When you look at it more
closely it returns a mix of error codes including 0xcafe, -ENOMEM, and
a->status which is WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG.  This is a mess.

Clean it up to just return standard kernel error codes.  We can print
out the a->status before returning a regular error code.  The printks
in the caller need to be adjusted as well.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: reduce return random value; print its own error message.
V2->V3: change commit message; change s16 -> int.
V3->V4: 
1. change message suggested by Dan Carpenter;
2. hold a->status in auth_parse() and return error code or 0 on success.
3. print le16_to_cpu(errcode) -> int %d.

 drivers/staging/rtl8192e/rtllib_softmac.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 82bf05eb1cbf..38ac733c3245 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1764,7 +1764,7 @@ static void rtllib_softmac_check_all_nets(struct rtllib_device *ieee)
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
 
-static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
+static inline int auth_parse(struct net_device *dev, struct sk_buff *skb,
 			     u8 **challenge, int *chlen)
 {
 	struct rtllib_authentication *a;
@@ -1773,7 +1773,7 @@ static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
 	if (skb->len <  (sizeof(struct rtllib_authentication) -
 	    sizeof(struct rtllib_info_element))) {
 		netdev_dbg(dev, "invalid len in auth resp: %d\n", skb->len);
-		return 0xcafe;
+		return -EINVAL;
 	}
 	*challenge = NULL;
 	a = (struct rtllib_authentication *) skb->data;
@@ -1787,7 +1787,13 @@ static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
 				return -ENOMEM;
 		}
 	}
-	return le16_to_cpu(a->status);
+
+	if (a->status) {
+		netdev_info(ieee->dev, "auth_parse() failed");
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int auth_rq_parse(struct net_device *dev, struct sk_buff *skb, u8 *dest)
@@ -2282,7 +2288,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 
 static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 {
-	u16 errcode;
+	int errcode;
 	u8 *challenge;
 	int chlen = 0;
 	bool bSupportNmode = true, bHalfSupportNmode = false;
@@ -2292,8 +2298,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 	if (errcode) {
 		ieee->softmac_stats.rx_auth_rs_err++;
 		netdev_info(ieee->dev,
-			    "Authentication response status code 0x%x",
-			    errcode);
+			    "Authentication response status code %d", errcode);
 		rtllib_associate_abort(ieee);
 		return;
 	}
-- 
2.7.4

