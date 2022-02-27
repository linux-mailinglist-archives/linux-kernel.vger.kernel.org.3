Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21404C5D8D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 17:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiB0QnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 11:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiB0Qmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 11:42:51 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BCF40E7B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 08:42:15 -0800 (PST)
Received: from ipservice-092-217-088-081.092.217.pools.vodafone-ip.de ([92.217.88.81] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nOMcd-0005Z9-AI; Sun, 27 Feb 2022 17:42:11 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 5/8] staging: r8188eu: use ieee80211 helper to check for more fragments
Date:   Sun, 27 Feb 2022 17:41:44 +0100
Message-Id: <20220227164147.1168847-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220227164147.1168847-1-martin@kaiser.cx>
References: <20220218135038.908307-1-martin@kaiser.cx>
 <20220227164147.1168847-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ieee80211 helper to check the "more fragments" bit. Remove the
internal GetMFrag macro.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 3a92d261f7c3..e8da2e5bbc32 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1081,7 +1081,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	pattrib->seq_num = GetSequence(ptr);
 
 	pattrib->pw_save = GetPwrMgt(ptr);
-	pattrib->mfrag = GetMFrag(ptr);
+	pattrib->mfrag = ieee80211_has_morefrags(fc);
 	pattrib->mdata = GetMData(ptr);
 	pattrib->privacy = GetPrivacy(ptr);
 	pattrib->order = GetOrder(ptr);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 5b383c2e9880..1d703bc94fca 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -183,8 +183,6 @@ enum WIFI_REG_DOMAIN {
 #define SetMFrag(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_)
 
-#define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
-
 #define ClearMFrag(pbuf)	\
 	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_))
 
-- 
2.30.2

