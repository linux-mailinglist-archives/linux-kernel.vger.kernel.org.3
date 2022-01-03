Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8E848379F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiACTgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiACTga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:36:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B4C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:36:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id q14so131850739edi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkBCem7AfWkwYLA2jSzBncQYkb4W5EBJcwzkV+pYnXg=;
        b=YSGTxfykdhGoKuq0nb0GLPn63Oc6REBKwVr9Tn8picwlNHUa7yOZ6rNa64wt9DuyCm
         YlH01QbaKjhXvijlZS027ECwNW/6qCp+FrwvGXhPQeH6FK0eHYsd923MZDNbazM0wKZl
         aDWf+VxRKcvKQ2KBf62+1qs33qeUA+De2TI0m8RyopURklCN3rBPQpUEZCppZK3j674l
         BVuYLqvFjwHFuMqUC90Au1XB0d7hkkPHmnlaIEVa6VKWWFR/4LGWdTrSnWTCvTyaxAe7
         pbU2UrfqYEH1CgL16iehVwjHxASx3buSQN8OYz6PHrpDJ8xxRlWIZmiXJRQBSOt+Q0aL
         PhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkBCem7AfWkwYLA2jSzBncQYkb4W5EBJcwzkV+pYnXg=;
        b=N0REF17w7P5fnxKufSKocdnYS2kQNbYPCXm+GM0mqeYn7t16c6V2eWX6V4Rx4ehHEI
         nZrmXIliAS+VRKapN+SD1upOWIOJqJHJDI60FCpr/+FRF5KMbiywCC85pgQ3uYujazRX
         ELEfGIZ2l0ddDa5dOm24wawb+Eu27rGLe/uh1QHV05D5Ik+EUmsxGGxbci6QD9kNEiEC
         byBeqSHbOfJbwO35nYZigPwE0V1aQACuiFaWwXtUKxN03DJnnARzqpUme8wHsrcAVuDO
         hLngdSV0DQTuGZcr6k4S5JTke9/9C1uc+Q5Qbq8kaz5FgLBcqUVBuBDhKEjbqs1mD5GF
         pTkw==
X-Gm-Message-State: AOAM5300TcvGFZRP0D6/BtnZwo9UqzJL9wuoVED/FQ21DmO2cBO35m+G
        K+GRDrhplqX/GI51qHsFFzE=
X-Google-Smtp-Source: ABdhPJzlZW8sHHCkBJX2kk3Nm9mNb1igKIYfnu/8pneM2jcAqT92fo6aWC8rHAcnFxcEfjxh/iUr6A==
X-Received: by 2002:a17:906:71cc:: with SMTP id i12mr38598250ejk.457.1641238588220;
        Mon, 03 Jan 2022 11:36:28 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:36:27 -0800 (PST)
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
Subject: [PATCH 33/56] staging: r8188eu: rename camelcase SetFrameSubType to set_frame_subtype
Date:   Mon,  3 Jan 2022 20:02:08 +0100
Message-Id: <20220103190326.363960-34-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro SetFrameSubType into set_frame_subtype.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 38 ++++++++++-----------
 drivers/staging/r8188eu/core/rtw_p2p.c      |  8 ++---
 drivers/staging/r8188eu/core/rtw_xmit.c     |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c  | 10 +++---
 drivers/staging/r8188eu/include/wifi.h      |  2 +-
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 0e7e7143b5fc..d11d9a21a0e1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1797,7 +1797,7 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -2133,7 +2133,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -2491,7 +2491,7 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -2653,7 +2653,7 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -2899,7 +2899,7 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -3091,7 +3091,7 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -3205,7 +3205,7 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(fctrl, WIFI_PROBERSP);
+	set_frame_subtype(fctrl, WIFI_PROBERSP);
 
 	pattrib->hdrlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = pattrib->hdrlen;
@@ -3461,7 +3461,7 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_PROBEREQ);
+	set_frame_subtype(pframe, WIFI_PROBEREQ);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -4349,7 +4349,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
 	/* pmlmeext->mgnt_seq++; */
-	SetFrameSubType(pframe, WIFI_BEACON);
+	set_frame_subtype(pframe, WIFI_BEACON);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -4565,7 +4565,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(fctrl, WIFI_PROBERSP);
+	set_frame_subtype(fctrl, WIFI_PROBERSP);
 
 	pattrib->hdrlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = pattrib->hdrlen;
@@ -4718,7 +4718,7 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_PROBEREQ);
+	set_frame_subtype(pframe, WIFI_PROBEREQ);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -4835,7 +4835,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_AUTH);
+	set_frame_subtype(pframe, WIFI_AUTH);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -4971,7 +4971,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	if ((pkt_type == WIFI_ASSOCRSP) || (pkt_type == WIFI_REASSOCRSP))
-		SetFrameSubType(pwlanhdr, pkt_type);
+		set_frame_subtype(pwlanhdr, pkt_type);
 	else
 		return;
 
@@ -5101,7 +5101,7 @@ void issue_assocreq(struct adapter *padapter)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ASSOCREQ);
+	set_frame_subtype(pframe, WIFI_ASSOCREQ);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -5420,7 +5420,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_DATA_NULL);
+	set_frame_subtype(pframe, WIFI_DATA_NULL);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -5540,7 +5540,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_QOS_DATA_NULL);
+	set_frame_subtype(pframe, WIFI_QOS_DATA_NULL);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr_qos);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr_qos);
@@ -5645,7 +5645,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_DEAUTH);
+	set_frame_subtype(pframe, WIFI_DEAUTH);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -5757,7 +5757,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -5895,7 +5895,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index aa739ae86d22..98b9d38ee59f 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -147,7 +147,7 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -206,7 +206,7 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -276,7 +276,7 @@ static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr,
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -353,7 +353,7 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	set_frame_subtype(pframe, WIFI_ACTION);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index e182f63b6c6b..16760806bd65 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -723,7 +723,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 
 	memset(hdr, 0, WLANHDR_OFFSET);
 
-	SetFrameSubType(fctrl, pattrib->subtype);
+	set_frame_subtype(fctrl, pattrib->subtype);
 
 	if (pattrib->subtype & WIFI_DATA_TYPE) {
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 8fb4789d9e65..50b9fd72f6ff 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -228,7 +228,7 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
-	SetFrameSubType(pframe, WIFI_BEACON);
+	set_frame_subtype(pframe, WIFI_BEACON);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
 	pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -306,7 +306,7 @@ static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 	set_pwr_mgt(fctrl);
-	SetFrameSubType(pframe, WIFI_PSPOLL);
+	set_frame_subtype(pframe, WIFI_PSPOLL);
 
 	/*  AID. */
 	SetDuration(pframe, (pmlmeinfo->aid | 0xc000));
@@ -369,7 +369,7 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	if (bQoS) {
 		struct rtw_ieee80211_hdr_3addr_qos *pwlanqoshdr;
 
-		SetFrameSubType(pframe, WIFI_QOS_DATA_NULL);
+		set_frame_subtype(pframe, WIFI_QOS_DATA_NULL);
 
 		pwlanqoshdr = (struct rtw_ieee80211_hdr_3addr_qos *)pframe;
 		SetPriority(&pwlanqoshdr->qc, AC);
@@ -377,7 +377,7 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 
 		pktlen = sizeof(struct rtw_ieee80211_hdr_3addr_qos);
 	} else {
-		SetFrameSubType(pframe, WIFI_DATA_NULL);
+		set_frame_subtype(pframe, WIFI_DATA_NULL);
 
 		pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 	}
@@ -407,7 +407,7 @@ static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u
 	memcpy(pwlanhdr->addr3, bssid, ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, 0);
-	SetFrameSubType(fctrl, WIFI_PROBERSP);
+	set_frame_subtype(fctrl, WIFI_PROBERSP);
 
 	pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 	pframe += pktlen;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 4e000ff8d58a..7997eb290b4f 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -210,7 +210,7 @@ enum WIFI_REG_DOMAIN {
 #define get_frame_subtype(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(7) |\
 	 BIT(6) | BIT(5) | BIT(4) | BIT(3) | BIT(2)))
 
-#define SetFrameSubType(pbuf, type) \
+#define set_frame_subtype(pbuf, type) \
 	do {    \
 		*(__le16 *)(pbuf) &= cpu_to_le16(~(BIT(7) | BIT(6) |	\
 		 BIT(5) | BIT(4) | BIT(3) | BIT(2))); \
-- 
2.25.1

