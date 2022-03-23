Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF64E4D97
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbiCWHu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242194AbiCWHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:50:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AB86FF6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:49:14 -0700 (PDT)
Received: from dslb-178-004-173-157.178.004.pools.vodafone-ip.de ([178.4.173.157] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nWvjy-0003JV-0M; Wed, 23 Mar 2022 08:49:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/7] staging: r8188eu: use standard mechanisms for control frames
Date:   Wed, 23 Mar 2022 08:48:55 +0100
Message-Id: <20220323074859.177425-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220323074859.177425-1-martin@kaiser.cx>
References: <20220323074859.177425-1-martin@kaiser.cx>
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

Use defines and macros from ieee80211.h to check for control frames and
to define control frame subtypes.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c       |  3 ++-
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  3 ++-
 drivers/staging/r8188eu/include/wifi.h        | 21 ++++++-------------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index fa0ae1c1187b..f1983f3ff9f3 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -801,9 +801,10 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->rx_data;
+	__le16 fc = *(__le16 *)pframe;
 	/* uint len = precv_frame->len; */
 
-	if (GetFrameType(pframe) != WIFI_CTRL_TYPE)
+	if (!ieee80211_is_ctl(fc))
 		return _FAIL;
 
 	/* receive the frames that ra(a1) is my address */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index 9bf7a9248026..7e50a42b6f75 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -113,12 +113,13 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe, struct phy_stat
 	struct hal_data_8188e *pHalData = &padapter->haldata;
 	struct phy_info *pPHYInfo  = &pattrib->phy_info;
 	u8 *wlanhdr = precvframe->rx_data;
+	__le16 fc = *(__le16 *)wlanhdr;
 	struct odm_per_pkt_info	pkt_info;
 	u8 *sa = NULL;
 	struct sta_priv *pstapriv;
 	struct sta_info *psta;
 
-	pkt_info.bPacketMatchBSSID = ((!IsFrameTypeCtrl(wlanhdr)) &&
+	pkt_info.bPacketMatchBSSID = ((!ieee80211_is_ctl(fc)) &&
 		!pattrib->icv_err && !pattrib->crc_err &&
 		!memcmp(get_hdr_bssid(wlanhdr),
 		 get_bssid(&padapter->mlmepriv), ETH_ALEN));
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 299553351246..47b73fde2006 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -13,7 +13,6 @@
 #define WLAN_SSID_MAXLEN	32
 
 enum WIFI_FRAME_TYPE {
-	WIFI_CTRL_TYPE =	(BIT(2)),
 	WIFI_DATA_TYPE =	(BIT(3)),
 	WIFI_QOS_DATA_TYPE	= (BIT(7)|BIT(3)),	/*  QoS Data */
 };
@@ -34,13 +33,12 @@ enum WIFI_FRAME_SUBTYPE {
 	WIFI_ACTION         = (BIT(7) | BIT(6) | BIT(4) | IEEE80211_FTYPE_MGMT),
 
 	/*  below is for control frame */
-	WIFI_PSPOLL         = (BIT(7) | BIT(5) | WIFI_CTRL_TYPE),
-	WIFI_RTS            = (BIT(7) | BIT(5) | BIT(4) | WIFI_CTRL_TYPE),
-	WIFI_CTS            = (BIT(7) | BIT(6) | WIFI_CTRL_TYPE),
-	WIFI_ACK            = (BIT(7) | BIT(6) | BIT(4) | WIFI_CTRL_TYPE),
-	WIFI_CFEND          = (BIT(7) | BIT(6) | BIT(5) | WIFI_CTRL_TYPE),
-	WIFI_CFEND_CFACK    = (BIT(7) | BIT(6) | BIT(5) | BIT(4) |
-	WIFI_CTRL_TYPE),
+	WIFI_PSPOLL         = (BIT(7) | BIT(5) | IEEE80211_FTYPE_CTL),
+	WIFI_RTS            = (BIT(7) | BIT(5) | BIT(4) | IEEE80211_FTYPE_CTL),
+	WIFI_CTS            = (BIT(7) | BIT(6) | IEEE80211_FTYPE_CTL),
+	WIFI_ACK            = (BIT(7) | BIT(6) | BIT(4) | IEEE80211_FTYPE_CTL),
+	WIFI_CFEND          = (BIT(7) | BIT(6) | BIT(5) | IEEE80211_FTYPE_CTL),
+	WIFI_CFEND_CFACK    = (BIT(7) | BIT(6) | BIT(5) | BIT(4) | IEEE80211_FTYPE_CTL),
 
 	/*  below is for data frame */
 	WIFI_DATA           = (0 | WIFI_DATA_TYPE),
@@ -340,13 +338,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 	return sa;
 }
 
-static inline bool IsFrameTypeCtrl(unsigned char *pframe)
-{
-	if (WIFI_CTRL_TYPE == GetFrameType(pframe))
-		return true;
-	else
-		return false;
-}
 /*-----------------------------------------------------------------------------
 			Below is for the security related definition
 ------------------------------------------------------------------------------*/
-- 
2.30.2

