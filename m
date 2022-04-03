Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB194F0B50
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349913AbiDCQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359484AbiDCQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:47:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27FE38DA1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:45:57 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3MF-00085T-Kf; Sun, 03 Apr 2022 18:45:43 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: use ieee80211 struct for aid
Date:   Sun,  3 Apr 2022 18:45:26 +0200
Message-Id: <20220403164526.357371-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220403164526.357371-1-martin@kaiser.cx>
References: <20220403164526.357371-1-martin@kaiser.cx>
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

Remove the GetAid macro and map the frame data to a struct
ieee80211_pspoll instead. We can then read the aid component.

psta->aid is in host endianness and has a 0x3FFF mask applied. We have to
convert our read value as well and apply the mask before we compare it to
psta->aid.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 7 ++-----
 drivers/staging/r8188eu/include/wifi.h  | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index a8ab1be33cfb..9f0bb29c9c56 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -800,9 +800,8 @@ static void validate_recv_ctrl_frame(struct adapter *padapter,
 {
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	u8 *pframe = precv_frame->rx_data;
-	u16 aid;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
+	struct ieee80211_pspoll *pspoll = (struct ieee80211_pspoll *)hdr;
 	u8 wmmps_ac;
 	struct sta_info *psta;
 
@@ -814,10 +813,8 @@ static void validate_recv_ctrl_frame(struct adapter *padapter,
 	if (!ieee80211_is_pspoll(hdr->frame_control))
 		return;
 
-	aid = GetAid(pframe);
 	psta = rtw_get_stainfo(pstapriv, hdr->addr2);
-
-	if (!psta || psta->aid != aid)
+	if (!psta || psta->aid != (le16_to_cpu(pspoll->aid) & 0x3FFF))
 		return;
 
 	/* for rx pkt statistics */
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index e10cf17d6aa0..eb3cb1fb285f 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -228,8 +228,6 @@ enum WIFI_REG_DOMAIN {
 #define SetAMsdu(pbuf, amsdu)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16((amsdu & 1) << 7)
 
-#define GetAid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 2)) & 0x3fff)
-
 #define GetTid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) +	\
 			(((GetToDs(pbuf)<<1) | GetFrDs(pbuf)) == 3 ?	\
 			30 : 24))) & 0x000f)
-- 
2.30.2

