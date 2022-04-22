Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D324650AD9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443264AbiDVCNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiDVCNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:13:31 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716C3E9B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:10:39 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 22 Apr
 2022 10:10:39 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 22 Apr
 2022 10:10:37 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: rtl8192u: Fix signedness bug in ieee80211_check_auth_response()
Date:   Fri, 22 Apr 2022 10:10:35 +0800
Message-ID: <1650593435-9017-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-123.meizu.com (172.16.1.123) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ieee80211_check_auth_response() function has a signedness bug because
it's a declared as a u16 but it return -ENOMEM.  When you look at it more
closely it returns a mix of error codes including 0xcafe, -ENOMEM, and
a->status which is WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG.  This is a mess.

Clean it up to just return standard kernel error codes.  We can print
out the a->status before returning a regular error code.  The printks
in the caller need to be adjusted as well.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 4e8fbd2410a1..dfe57748a70e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1461,13 +1461,13 @@ void ieee80211_softmac_check_all_nets(struct ieee80211_device *ieee)
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
 
-static inline u16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
+static inline int auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
 {
 	struct ieee80211_authentication *a;
 	u8 *t;
 	if (skb->len < (sizeof(struct ieee80211_authentication) - sizeof(struct ieee80211_info_element))) {
 		IEEE80211_DEBUG_MGMT("invalid len in auth resp: %d\n", skb->len);
-		return 0xcafe;
+		return -EINVAL;
 	}
 	*challenge = NULL;
 	a = (struct ieee80211_authentication *)skb->data;
@@ -1482,7 +1482,12 @@ static inline u16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
 		}
 	}
 
-	return le16_to_cpu(a->status);
+	if (a->status) {
+		IEEE80211_DEBUG_MGMT("auth_parse() failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int auth_rq_parse(struct sk_buff *skb, u8 *dest)
@@ -1829,7 +1834,7 @@ static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
 {
 	/* default support N mode, disable halfNmode */
 	bool bSupportNmode = true, bHalfSupportNmode = false;
-	u16 errcode;
+	int errcode;
 	u8 *challenge;
 	int chlen = 0;
 	u32 iotAction;
@@ -1878,7 +1883,7 @@ static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
 		}
 	} else {
 		ieee->softmac_stats.rx_auth_rs_err++;
-		IEEE80211_DEBUG_MGMT("Auth response status code 0x%x", errcode);
+		IEEE80211_DEBUG_MGMT("Auth response status code %d\n", errcode);
 		ieee80211_associate_abort(ieee);
 	}
 }
-- 
2.7.4

