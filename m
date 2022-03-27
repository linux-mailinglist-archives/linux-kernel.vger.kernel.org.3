Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C514E8944
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiC0SMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiC0SLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:11:49 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5E034661
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:10:04 -0700 (PDT)
Received: from dslb-178-004-173-219.178.004.pools.vodafone-ip.de ([178.4.173.219] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nYXKy-00019B-Gc; Sun, 27 Mar 2022 20:10:00 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 5/9] staging: r8188eu: use standard mechanisms for qos data frames
Date:   Sun, 27 Mar 2022 20:09:40 +0200
Message-Id: <20220327180944.712545-6-martin@kaiser.cx>
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

Use defines and macros from ieee80211.h to check for qos data frames and
to mark a frame as qos data.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 4 ++--
 drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 6 +-----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 341aca28b97f..bb67abd3ed99 100644
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

