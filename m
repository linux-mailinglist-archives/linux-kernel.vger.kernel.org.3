Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32523500B25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbiDNKeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiDNKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:34:41 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629859A63
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:32:16 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 14 Apr
 2022 18:32:15 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 14 Apr
 2022 18:32:14 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Staging: rtl8192u: Fix signedness bug in ieee80211_check_auth_response()
Date:   Thu, 14 Apr 2022 18:32:12 +0800
Message-ID: <1649932332-13305-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function ieee80211_check_auth_response () unsigned errcode receive auth_parse()'s
errcode -ENOMEM.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 1a43979939a8..4d060c3ec077 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1461,7 +1461,7 @@ void ieee80211_softmac_check_all_nets(struct ieee80211_device *ieee)
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
 
-static inline u16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
+static inline s16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
 {
 	struct ieee80211_authentication *a;
 	u8 *t;
@@ -1826,7 +1826,7 @@ static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
 {
 	/* default support N mode, disable halfNmode */
 	bool bSupportNmode = true, bHalfSupportNmode = false;
-	u16 errcode;
+	s16 errcode;
 	u8 *challenge;
 	int chlen = 0;
 	u32 iotAction;
-- 
2.7.4

