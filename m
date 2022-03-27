Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF644E8943
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiC0SMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiC0SLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:11:49 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D8F34656
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:10:03 -0700 (PDT)
Received: from dslb-178-004-173-219.178.004.pools.vodafone-ip.de ([178.4.173.219] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nYXKx-00019B-Mc; Sun, 27 Mar 2022 20:09:59 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 4/9] staging: r8188eu: use standard mechanisms for data frames
Date:   Sun, 27 Mar 2022 20:09:39 +0200
Message-Id: <20220327180944.712545-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220327180944.712545-1-martin@kaiser.cx>
References: <20220323074859.177425-1-martin@kaiser.cx>
 <20220327180944.712545-1-martin@kaiser.cx>
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

Use defines and macros from ieee80211.h to check for data frames and
to define data frame subtypes.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c |  5 +++--
 drivers/staging/r8188eu/core/rtw_xmit.c |  4 ++--
 drivers/staging/r8188eu/include/wifi.h  | 17 ++++++++---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 7735fbe6fa72..341aca28b97f 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1283,8 +1283,9 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 	psta_addr = pfhdr->attrib.ta;
 	psta = rtw_get_stainfo(pstapriv, psta_addr);
 	if (!psta) {
-		u8 type = GetFrameType(pfhdr->rx_data);
-		if (type != WIFI_DATA_TYPE) {
+		__le16 fc = *(__le16 *)pfhdr->rx_data;
+
+		if (ieee80211_is_data(fc)) {
 			psta = rtw_get_bcmc_stainfo(padapter);
 			pdefrag_q = &psta->sta_recvpriv.defrag_q;
 		} else {
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index c2a550e7250e..781dc80ff9ed 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -497,7 +497,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	pattrib->pkt_hdrlen = ETH_HLEN;/* pattrib->ether_type == 0x8100) ? (14 + 4): 14; vlan tag */
 
 	pattrib->hdrlen = WLAN_HDR_A3_LEN;
-	pattrib->subtype = WIFI_DATA_TYPE;
+	pattrib->subtype = IEEE80211_FTYPE_DATA;
 	pattrib->priority = 0;
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE | WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE)) {
@@ -717,7 +717,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 
 	SetFrameSubType(fctrl, pattrib->subtype);
 
-	if (pattrib->subtype & WIFI_DATA_TYPE) {
+	if (pattrib->subtype & IEEE80211_FTYPE_DATA) {
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 			/* to_ds = 1, fr_ds = 0; */
 			/* Data transfer to AP */
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 47b73fde2006..c71334f3986a 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -13,7 +13,6 @@
 #define WLAN_SSID_MAXLEN	32
 
 enum WIFI_FRAME_TYPE {
-	WIFI_DATA_TYPE =	(BIT(3)),
 	WIFI_QOS_DATA_TYPE	= (BIT(7)|BIT(3)),	/*  QoS Data */
 };
 
@@ -41,14 +40,14 @@ enum WIFI_FRAME_SUBTYPE {
 	WIFI_CFEND_CFACK    = (BIT(7) | BIT(6) | BIT(5) | BIT(4) | IEEE80211_FTYPE_CTL),
 
 	/*  below is for data frame */
-	WIFI_DATA           = (0 | WIFI_DATA_TYPE),
-	WIFI_DATA_CFACK     = (BIT(4) | WIFI_DATA_TYPE),
-	WIFI_DATA_CFPOLL    = (BIT(5) | WIFI_DATA_TYPE),
-	WIFI_DATA_CFACKPOLL = (BIT(5) | BIT(4) | WIFI_DATA_TYPE),
-	WIFI_DATA_NULL      = (BIT(6) | WIFI_DATA_TYPE),
-	WIFI_CF_ACK         = (BIT(6) | BIT(4) | WIFI_DATA_TYPE),
-	WIFI_CF_POLL        = (BIT(6) | BIT(5) | WIFI_DATA_TYPE),
-	WIFI_CF_ACKPOLL     = (BIT(6) | BIT(5) | BIT(4) | WIFI_DATA_TYPE),
+	WIFI_DATA           = (0 | IEEE80211_FTYPE_DATA),
+	WIFI_DATA_CFACK     = (BIT(4) | IEEE80211_FTYPE_DATA),
+	WIFI_DATA_CFPOLL    = (BIT(5) | IEEE80211_FTYPE_DATA),
+	WIFI_DATA_CFACKPOLL = (BIT(5) | BIT(4) | IEEE80211_FTYPE_DATA),
+	WIFI_DATA_NULL      = (BIT(6) | IEEE80211_FTYPE_DATA),
+	WIFI_CF_ACK         = (BIT(6) | BIT(4) | IEEE80211_FTYPE_DATA),
+	WIFI_CF_POLL        = (BIT(6) | BIT(5) | IEEE80211_FTYPE_DATA),
+	WIFI_CF_ACKPOLL     = (BIT(6) | BIT(5) | BIT(4) | IEEE80211_FTYPE_DATA),
 	WIFI_QOS_DATA_NULL	= (BIT(6) | WIFI_QOS_DATA_TYPE),
 };
 
-- 
2.30.2

