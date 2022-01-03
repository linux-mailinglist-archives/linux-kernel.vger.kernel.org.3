Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CFA48379E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiACTff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiACTfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:35:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB51C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:35:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so139596106edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q60Y2ZU4KjMyN9CVACLTkSUsRlZZ5k6NDg3gofPn8tQ=;
        b=XDVAms3tVDA+S7wz5/snL+tcXTLOToU7dY8UQcdpzzfd9qxTEoiCO0C3bk5v3EDUwU
         CW94d4kc0Axt8vbjiBTha0/snPn0wlcnhxiLchsbcJzX9JYnWCX5graRuiVPx09ANdgZ
         v5DXJ74gEUAmWsmISgM81rY+OXtWjpQRCdthcoKkOXsEeriHgeDZNsvc089HJ8BAasb4
         SxX47JFIX9GZKEzKArEiY4EyLIO7xiuW3HJ6RuYAAQrIahRBI+kECiaKSvGZZFahpquI
         NlgRFO0ll0LhKEABO8wZ/SrrvhwyO7RaEzNuEdiFPVP7eqTKy/1vOGx7WHfcmgx6KXGy
         izsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q60Y2ZU4KjMyN9CVACLTkSUsRlZZ5k6NDg3gofPn8tQ=;
        b=T819x4ObodnjGDY5C5OIgWt2HlryADL0saJSGOOc7ZRYL6SQk3gRApj06G7b5QgnA+
         U8rBIUKOL3KaYLjjLCaagEhSU0AvIzhbQ7t8xRh37ljD3hf06e1lI00IGk8biBm9r81g
         twpM5iEo08dpTh+dLFpr6TtIjxgWsC/A5RuCDZt7OvuBQKCgt/PCwwRV8MRIZlpwPvlo
         9Uc/I5MRgFcWCBuj0YSchbsRx2T2mr+MPOq3gT0O0Ehhd5lo9l6QMrKADCkSiyCKv+xg
         VIufZdU95hEXHpApdksejb1Pw3LU9oMT+LFP1tScC9CVQJin+3eOZiiAjJMWlFizgabL
         7v+Q==
X-Gm-Message-State: AOAM531svJ+6CBa/pxawjvUW3aXYXGy5tlwOqDjX75a01W5T07M0NfC9
        vFsee6ikwdXVyXoVycQFhIk=
X-Google-Smtp-Source: ABdhPJy1aYhQzb0EsvGxbLeH9phdTwF2fi32uDOwFnH3/agm2CJhGCxg/W/KwvcfYZ8H9m/+XHMpIA==
X-Received: by 2002:aa7:cb09:: with SMTP id s9mr6691880edt.379.1641238532359;
        Mon, 03 Jan 2022 11:35:32 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:35:31 -0800 (PST)
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
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 32/56] staging: r8188eu: rename camelcase GetFrameSubType to get_frame_subtype
Date:   Mon,  3 Jan 2022 20:02:07 +0100
Message-Id: <20220103190326.363960-33-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetFrameSubType into get_frame_subtype.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  8 ++++----
 drivers/staging/r8188eu/core/rtw_p2p.c        |  2 +-
 drivers/staging/r8188eu/core/rtw_recv.c       | 18 +++++++++---------
 drivers/staging/r8188eu/core/rtw_security.c   |  4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  2 +-
 drivers/staging/r8188eu/include/wifi.h        |  2 +-
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 5d0901f72cd8..0e7e7143b5fc 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -426,7 +426,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	ptable = mlme_sta_tbl;
 
-	index = GetFrameSubType(pframe) >> 4;
+	index = get_frame_subtype(pframe) >> 4;
 
 	if (index > 13)
 		return;
@@ -443,7 +443,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 		psta->RxMgmtFrameSeqNum = precv_frame->attrib.seq_num;
 	}
 
-	switch (GetFrameSubType(pframe)) {
+	switch (get_frame_subtype(pframe)) {
 	case WIFI_AUTH:
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 			ptable->func = &OnAuth;
@@ -970,7 +970,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
-	frame_type = GetFrameSubType(pframe);
+	frame_type = get_frame_subtype(pframe);
 	if (frame_type == WIFI_ASSOCREQ) {
 		reassoc = 0;
 		ie_offset = _ASOCREQ_IE_OFFSET_;
@@ -6217,7 +6217,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 
 	memset(bssid, 0, sizeof(struct wlan_bssid_ex));
 
-	subtype = GetFrameSubType(pframe);
+	subtype = get_frame_subtype(pframe);
 
 	if (subtype == WIFI_BEACON) {
 		bssid->Reserved[0] = 1;
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 7b30b9b64b41..aa739ae86d22 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -815,7 +815,7 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 	if (!rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO))
 		return P2P_STATUS_FAIL_REQUEST_UNABLE;
 
-	frame_type = GetFrameSubType(pframe);
+	frame_type = get_frame_subtype(pframe);
 	if (frame_type == WIFI_ASSOCREQ)
 		ie_offset = _ASOCREQ_IE_OFFSET_;
 	else /*  WIFI_REASSOCREQ */
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 9902adf99142..8fd2ae89d7eb 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -707,10 +707,10 @@ static int ap2sta_data_frame(
 			goto exit;
 		}
 
-		/* if ((GetFrameSubType(ptr) & WIFI_QOS_DATA_TYPE) == WIFI_QOS_DATA_TYPE) { */
+		/* if ((get_frame_subtype(ptr) & WIFI_QOS_DATA_TYPE) == WIFI_QOS_DATA_TYPE) { */
 		/*  */
 
-		if (GetFrameSubType(ptr) & BIT(6)) {
+		if (get_frame_subtype(ptr) & BIT(6)) {
 			/* No data, will not indicate to upper layer, temporily count it here */
 			count_rx_stats(adapter, precv_frame, *psta);
 			ret = RTW_RX_HANDLED;
@@ -784,11 +784,11 @@ static int sta2ap_data_frame(struct adapter *adapter,
 
 		process_pwrbit_data(adapter, precv_frame);
 
-		if ((GetFrameSubType(ptr) & WIFI_QOS_DATA_TYPE) == WIFI_QOS_DATA_TYPE) {
+		if ((get_frame_subtype(ptr) & WIFI_QOS_DATA_TYPE) == WIFI_QOS_DATA_TYPE) {
 			process_wmmps_data(adapter, precv_frame);
 		}
 
-		if (GetFrameSubType(ptr) & BIT(6)) {
+		if (get_frame_subtype(ptr) & BIT(6)) {
 			/* No data, will not indicate to upper layer, temporily count it here */
 			count_rx_stats(adapter, precv_frame, *psta);
 			ret = RTW_RX_HANDLED;
@@ -827,7 +827,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 		return _FAIL;
 
 	/* only handle ps-poll */
-	if (GetFrameSubType(pframe) == WIFI_PSPOLL) {
+	if (get_frame_subtype(pframe) == WIFI_PSPOLL) {
 		u16 aid;
 		u8 wmmps_ac = 0;
 		struct sta_info *psta = NULL;
@@ -944,11 +944,11 @@ static int validate_recv_mgnt_frame(struct adapter *padapter,
 	psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(precv_frame->rx_data));
 	if (psta) {
 		psta->sta_stats.rx_mgnt_pkts++;
-		if (GetFrameSubType(precv_frame->rx_data) == WIFI_BEACON) {
+		if (get_frame_subtype(precv_frame->rx_data) == WIFI_BEACON) {
 			psta->sta_stats.rx_beacon_pkts++;
-		} else if (GetFrameSubType(precv_frame->rx_data) == WIFI_PROBEREQ) {
+		} else if (get_frame_subtype(precv_frame->rx_data) == WIFI_PROBEREQ) {
 			psta->sta_stats.rx_probereq_pkts++;
-		} else if (GetFrameSubType(precv_frame->rx_data) == WIFI_PROBERSP) {
+		} else if (get_frame_subtype(precv_frame->rx_data) == WIFI_PROBERSP) {
 			if (!memcmp(padapter->eeprompriv.mac_addr, GetAddr1Ptr(precv_frame->rx_data), ETH_ALEN))
 				psta->sta_stats.rx_probersp_pkts++;
 			else if (is_broadcast_mac_addr(GetAddr1Ptr(precv_frame->rx_data)) ||
@@ -1101,7 +1101,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	}
 
 	type =  get_frame_type(ptr);
-	subtype = GetFrameSubType(ptr); /* bit(7)~bit(2) */
+	subtype = get_frame_subtype(ptr); /* bit(7)~bit(2) */
 
 	pattrib->to_fr_ds = get_tofr_ds(ptr);
 
diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 42ff5fd5ddad..e8d2242b92ea 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -973,7 +973,7 @@ static int aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 	u8 padded_buffer[16];
 	u8 mic[8];
 	uint	frtype  = get_frame_type(pframe);
-	uint	frsubtype  = GetFrameSubType(pframe);
+	uint	frsubtype  = get_frame_subtype(pframe);
 
 	frsubtype = frsubtype >> 4;
 
@@ -1167,7 +1167,7 @@ static int aes_decipher(struct adapter *padapter, u8 *key, uint hdrlen,
 
 /*	uint	offset = 0; */
 	uint	frtype  = get_frame_type(pframe);
-	uint	frsubtype  = GetFrameSubType(pframe);
+	uint	frsubtype  = get_frame_subtype(pframe);
 
 	frsubtype = frsubtype >> 4;
 
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index d40669c21fc1..5f4c9d61511e 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -872,7 +872,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	if (!bssid)
 		return _FAIL;
 
-	subtype = GetFrameSubType(pframe) >> 4;
+	subtype = get_frame_subtype(pframe) >> 4;
 
 	if (subtype == WIFI_BEACON)
 		bssid->Reserved[0] = 1;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index 90d426199f52..9ffb1af5d846 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -150,7 +150,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe, struct phy_stat
 				  myid(&padapter->eeprompriv), ETH_ALEN));
 
 	pkt_info.bPacketBeacon = pkt_info.bPacketMatchBSSID &&
-				 (GetFrameSubType(wlanhdr) == WIFI_BEACON);
+				 (get_frame_subtype(wlanhdr) == WIFI_BEACON);
 
 	if (pkt_info.bPacketBeacon) {
 		if (check_fwstate(&padapter->mlmepriv, WIFI_STATION_STATE))
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 7053185667a5..4e000ff8d58a 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -207,7 +207,7 @@ enum WIFI_REG_DOMAIN {
 #define get_frame_type(pbuf)				\
 	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(3) | BIT(2)))
 
-#define GetFrameSubType(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(7) |\
+#define get_frame_subtype(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(7) |\
 	 BIT(6) | BIT(5) | BIT(4) | BIT(3) | BIT(2)))
 
 #define SetFrameSubType(pbuf, type) \
-- 
2.25.1

