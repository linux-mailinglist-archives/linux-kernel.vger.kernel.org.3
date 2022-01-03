Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28094837D0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiACT5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiACT5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:57:04 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5EBC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:57:04 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w16so139927243edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XgaIsGzQMfglbsKXUwwYjKdrKGKssrkBCEg81V3vfrQ=;
        b=Xgf2kUE07eO0dFtG8L+s/qt+etdgLtBtZC0Vaw1HgQ8NM+l5MWsLWG7VwCaRGgmTaB
         pdqd/6OXhwExTZWc0oSDcremBPsz37xf4u27Qlfxl2I9RxRsPeWUvubz5TQBy2NEkpN9
         Pd/8N/9uIhpnuJlLXI0I568TUVzRlkt1Gz4X0tYjP1jQDfGJS0yGvtUGaIE2pCwpeJmX
         Bvmo0QFUsR7VR6Yt6MM2z+nOYMoytZ2PUt5GftofPy1nlG4p0l+03q6KON6sOq47mJZf
         MjbyoeQayDfJ+PFoaVuMQ6atzfLCC96rW2QNN7xUO6Z+4RfajAumb1TWMGguTwGdCpyF
         ybqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XgaIsGzQMfglbsKXUwwYjKdrKGKssrkBCEg81V3vfrQ=;
        b=oKAhAdq4Cvx97H0CaA0oXRT1DHaZqTL3xODYJBioiEjPnzv+TWBlMRCmY0EMXtSl3/
         yI4CaFGZ9lIFTjAiyiHyibJNcTZd2aePboeA5LRY+GhkvoA10hvF+Jo01t7JGsUjrurw
         rpMgLfILDO/RhmLBR5osdfkes61rL9nkPW20SRwzeM6UNKm+dVtf5C5qz3/gIYwkjRz3
         hkevk64qK1xLNIK5Q2vhItSZJ7by8Lq2PkrIQmx6hk4VSepe2WmuJ+EkjtmoFMc1vs2T
         xQyULbCPDZ4v8ViZxjO4A5uCeE2mv6nNLqC1jomS+3eR12ykkud2PjTlZbNmh4LhSaz9
         DihA==
X-Gm-Message-State: AOAM530WFmG+y66Ri6flBvyoynOqJFRjuRmx4zrftwyvGbToF6HRO24Q
        JxmLssgh9yWzQ7i/2PGl/U4=
X-Google-Smtp-Source: ABdhPJxPKIm2LQ5zozlODMFvRuKF8yqxyxfwa07RoFCqowYiWDwUxldIwbTM+96Hyx/zrs/3XtIV2g==
X-Received: by 2002:a17:907:9812:: with SMTP id ji18mr36287947ejc.184.1641239823019;
        Mon, 03 Jan 2022 11:57:03 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:57:02 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 55/56] staging: r8188eu: rename camelcase GetAddr3Ptr to get_addr_3_ptr
Date:   Mon,  3 Jan 2022 20:02:30 +0100
Message-Id: <20220103190326.363960-56-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetAddr3Ptr into get_addr_3_ptr

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 18 +++++++++---------
 drivers/staging/r8188eu/core/rtw_recv.c      |  4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c |  2 +-
 drivers/staging/r8188eu/include/wifi.h       | 10 +++++-----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 491cba1a007a..00c56ae5d1b1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -627,7 +627,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 		return _SUCCESS;
 	}
 
-	if (!memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)) {
+	if (!memcmp(get_addr_3_ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)) {
 		if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
 			/* we should update current network before auth, or some IE is wrong */
 			pbss = kmalloc(sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
@@ -1490,7 +1490,7 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	/* check A3 */
-	if (!(!memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
+	if (!(!memcmp(get_addr_3_ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
 		return _SUCCESS;
 
 	if (pwdinfo->rx_invitereq_info.scan_op_ch_only) {
@@ -1546,10 +1546,10 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 
 		netdev_dbg(padapter->pnetdev,
 			   "sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
-			   reason, GetAddr3Ptr(pframe), ignore_received_deauth);
+			   reason, get_addr_3_ptr(pframe), ignore_received_deauth);
 
 		if (!ignore_received_deauth)
-			receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
+			receive_disconnect(padapter, get_addr_3_ptr(pframe), reason);
 	}
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 	return _SUCCESS;
@@ -1565,7 +1565,7 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	/* check A3 */
-	if (!(!memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
+	if (!(!memcmp(get_addr_3_ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
 		return _SUCCESS;
 
 	if (pwdinfo->rx_invitereq_info.scan_op_ch_only) {
@@ -1604,9 +1604,9 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 	} else {
 		netdev_dbg(padapter->pnetdev,
 			   "ap recv disassoc reason code(%d) sta:%pM\n",
-			   reason, GetAddr3Ptr(pframe));
+			   reason, get_addr_3_ptr(pframe));
 
-		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
+		receive_disconnect(padapter, get_addr_3_ptr(pframe), reason);
 	}
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 	return _SUCCESS;
@@ -4966,7 +4966,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 
 	memcpy((void *)get_addr_1_ptr(pwlanhdr), pstat->hwaddr, ETH_ALEN);
 	memcpy((void *)get_addr_2_ptr(pwlanhdr), myid(&padapter->eeprompriv), ETH_ALEN);
-	memcpy((void *)GetAddr3Ptr(pwlanhdr), get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
+	memcpy((void *)get_addr_3_ptr(pwlanhdr), get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
 	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
@@ -6324,7 +6324,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 		memcpy(bssid->MacAddress, get_addr_2_ptr(pframe), ETH_ALEN);
 	} else {
 		bssid->InfrastructureMode = Ndis802_11IBSS;
-		memcpy(bssid->MacAddress, GetAddr3Ptr(pframe), ETH_ALEN);
+		memcpy(bssid->MacAddress, get_addr_3_ptr(pframe), ETH_ALEN);
 	}
 
 	if (val16 & BIT(4))
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 3aad16af3a60..a6ee7dd9b3e4 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -633,7 +633,7 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 	} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
 		memcpy(pattrib->dst, get_addr_1_ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->src, get_addr_2_ptr(ptr), ETH_ALEN);
-		memcpy(pattrib->bssid, GetAddr3Ptr(ptr), ETH_ALEN);
+		memcpy(pattrib->bssid, get_addr_3_ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
 		memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
 
@@ -720,7 +720,7 @@ static int ap2sta_data_frame(
 		   check_fwstate(pmlmepriv, _FW_LINKED)) {
 		memcpy(pattrib->dst, get_addr_1_ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->src, get_addr_2_ptr(ptr), ETH_ALEN);
-		memcpy(pattrib->bssid, GetAddr3Ptr(ptr), ETH_ALEN);
+		memcpy(pattrib->bssid, get_addr_3_ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
 		memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
 
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 5f4c9d61511e..8f0cd8c85391 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -844,7 +844,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	int group_cipher = 0, pairwise_cipher = 0, is_8021x = 0;
 	unsigned char *pbuf;
 	u32 wpa_ielen = 0;
-	u8 *pbssid = GetAddr3Ptr(pframe);
+	u8 *pbssid = get_addr_3_ptr(pframe);
 	u32 hidden_ssid = 0;
 	struct HT_info_element *pht_info = NULL;
 	struct ieee80211_ht_cap *pht_cap = NULL;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 9ce45d31e16d..9d8d69cc562a 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -254,7 +254,7 @@ enum WIFI_REG_DOMAIN {
 
 #define get_addr_2_ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 10))
 
-#define GetAddr3Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 16))
+#define get_addr_3_ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 16))
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
@@ -279,10 +279,10 @@ static inline unsigned char *get_da(unsigned char *pframe)
 		da = get_addr_1_ptr(pframe);
 		break;
 	case 0x02:	/*  ToDs=1, FromDs=0 */
-		da = GetAddr3Ptr(pframe);
+		da = get_addr_3_ptr(pframe);
 		break;
 	default:	/*  ToDs=1, FromDs=1 */
-		da = GetAddr3Ptr(pframe);
+		da = get_addr_3_ptr(pframe);
 		break;
 	}
 	return da;
@@ -298,7 +298,7 @@ static inline unsigned char *get_sa(unsigned char *pframe)
 		sa = get_addr_2_ptr(pframe);
 		break;
 	case 0x01:	/*  ToDs=0, FromDs=1 */
-		sa = GetAddr3Ptr(pframe);
+		sa = get_addr_3_ptr(pframe);
 		break;
 	case 0x02:	/*  ToDs=1, FromDs=0 */
 		sa = get_addr_2_ptr(pframe);
@@ -317,7 +317,7 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 
 	switch (to_fr_ds) {
 	case 0x00:	/*  ToDs=0, FromDs=0 */
-		sa = GetAddr3Ptr(pframe);
+		sa = get_addr_3_ptr(pframe);
 		break;
 	case 0x01:	/*  ToDs=0, FromDs=1 */
 		sa = get_addr_2_ptr(pframe);
-- 
2.25.1

