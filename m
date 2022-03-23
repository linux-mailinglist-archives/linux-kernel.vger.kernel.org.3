Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14B34E4D98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242342AbiCWHvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiCWHup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:50:45 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F470050
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:49:16 -0700 (PDT)
Received: from dslb-178-004-173-157.178.004.pools.vodafone-ip.de ([178.4.173.157] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nWvjz-0003JV-LJ; Wed, 23 Mar 2022 08:49:11 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/7] staging: r8188eu: use standard mechanisms for qos data frames
Date:   Wed, 23 Mar 2022 08:48:57 +0100
Message-Id: <20220323074859.177425-6-martin@kaiser.cx>
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

Use defines and macros from ieee80211.h to check for qos data frames and
to mark a frame as qos data.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 4 ++--
 drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 6 +-----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 7b1c83e502f0..cad7cbb92d07 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -749,6 +749,7 @@ static int sta2ap_data_frame(struct adapter *adapter,
 	struct	sta_priv *pstapriv = &adapter->stapriv;
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	u8 *ptr = precv_frame->rx_data;
+	__le16 fc = *(__le16 *)ptr;
 	unsigned char *mybssid  = get_bssid(pmlmepriv);
 	int ret = _SUCCESS;
 
@@ -769,9 +770,8 @@ static int sta2ap_data_frame(struct adapter *adapter,
 
 		process_pwrbit_data(adapter, precv_frame);
 
-		if ((GetFrameSubType(ptr) & WIFI_QOS_DATA_TYPE) == WIFI_QOS_DATA_TYPE) {
+		if (ieee80211_is_data_qos(fc))
 			process_wmmps_data(adapter, precv_frame);
-		}
 
 		if (GetFrameSubType(ptr) & BIT(6)) {
 			/* No data, will not indicate to upper layer, temporily count it here */
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 781dc80ff9ed..aede8ef8b098 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -399,7 +399,7 @@ static void set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 
 	pattrib->priority = user_prio;
 	pattrib->hdrlen = WLAN_HDR_A3_QOS_LEN;
-	pattrib->subtype = WIFI_QOS_DATA_TYPE;
+	pattrib->subtype = IEEE80211_STYPE_QOS_DATA | IEEE80211_FTYPE_DATA;
 }
 
 static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct pkt_attrib *pattrib)
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index c71334f3986a..2e42b4b48c25 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -12,10 +12,6 @@
 #define WLAN_HDR_A3_QOS_LEN	26
 #define WLAN_SSID_MAXLEN	32
 
-enum WIFI_FRAME_TYPE {
-	WIFI_QOS_DATA_TYPE	= (BIT(7)|BIT(3)),	/*  QoS Data */
-};
-
 enum WIFI_FRAME_SUBTYPE {
 	/*  below is for mgt frame */
 	WIFI_ASSOCREQ       = (0 | IEEE80211_FTYPE_MGMT),
@@ -48,7 +44,7 @@ enum WIFI_FRAME_SUBTYPE {
 	WIFI_CF_ACK         = (BIT(6) | BIT(4) | IEEE80211_FTYPE_DATA),
 	WIFI_CF_POLL        = (BIT(6) | BIT(5) | IEEE80211_FTYPE_DATA),
 	WIFI_CF_ACKPOLL     = (BIT(6) | BIT(5) | BIT(4) | IEEE80211_FTYPE_DATA),
-	WIFI_QOS_DATA_NULL	= (BIT(6) | WIFI_QOS_DATA_TYPE),
+	WIFI_QOS_DATA_NULL	= (BIT(6) | IEEE80211_STYPE_QOS_DATA | IEEE80211_FTYPE_DATA),
 };
 
 enum WIFI_REASON_CODE	{
-- 
2.30.2

