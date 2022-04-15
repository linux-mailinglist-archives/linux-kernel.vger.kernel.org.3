Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE57750204E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348578AbiDOCMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348567AbiDOCME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:12:04 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE08FD2B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:09:34 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 15 Apr
 2022 10:09:34 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 15 Apr
 2022 10:09:32 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <gregkh@linuxfoundation.org>, <davem@davemloft.net>,
        <dan.carpenter@oracle.com>, <len.baker@gmx.com>,
        <dave@stgolabs.net>, <edumazet@google.com>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH V2] staging: rtl8192e: Fix signedness bug in rtllib_rx_assoc_resp()
Date:   Fri, 15 Apr 2022 10:09:31 +0800
Message-ID: <1649988571-19923-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function rtllib_rx_assoc_resp () unsigned errcode receive auth_parse()'s
errcode -ENOMEM.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: reduce return random value; print its own error message.

 drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 82bf05eb1cbf..8a0961e64a8c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1764,7 +1764,7 @@ static void rtllib_softmac_check_all_nets(struct rtllib_device *ieee)
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
 
-static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
+static inline s16 auth_parse(struct net_device *dev, struct sk_buff *skb,
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
@@ -1787,7 +1787,7 @@ static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
 				return -ENOMEM;
 		}
 	}
-	return le16_to_cpu(a->status);
+	return a->status;
 }
 
 static int auth_rq_parse(struct net_device *dev, struct sk_buff *skb, u8 *dest)
@@ -2282,7 +2282,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 
 static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 {
-	u16 errcode;
+	s16 errcode;
 	u8 *challenge;
 	int chlen = 0;
 	bool bSupportNmode = true, bHalfSupportNmode = false;
@@ -2292,8 +2292,8 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 	if (errcode) {
 		ieee->softmac_stats.rx_auth_rs_err++;
 		netdev_info(ieee->dev,
-			    "Authentication response status code 0x%x",
-			    errcode);
+			    "Authentication response status code %d",
+			    le16_to_cpu(errcode));
 		rtllib_associate_abort(ieee);
 		return;
 	}
-- 
2.7.4

