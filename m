Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF54B488CB8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbiAIVyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbiAIVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:54:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E544C061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 13:54:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s1so23278587wra.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 13:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ar71rnOiyHND+2RSXuI0X3MhhOkI6tAnlDxAsosXxP4=;
        b=BhpdmK3TPid4fLlnkV36Kr8IRJUI39RRao8SY8Wh3GhJ08VT5wLohDfBpsGbNOXM9q
         faLHd1gRi318URVxxbVsgNOhZs5pMkPXqeSm6gzgHbps01RzzJ6KrM7x80W6OOF5/fCN
         Qt/aYJjFnnNc7b3f7kssoQNg2Mx3CUvN3+FQ2L1N+fza8TnLnN3IrCFpIHG+y5Sx0sl2
         nGEi3eXefyFk33bSHJvRC2WfOECYMlC53IL+DyqEgi/wXrZj+xrFFgd5wyGUItZPEQ2+
         gu23+m4YI6t3Ng9N/KcVr04HUGfG/Ucr/RmHTNfN7Wd5vjEjTPLq4VGjlhONqUGkSLeP
         7huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ar71rnOiyHND+2RSXuI0X3MhhOkI6tAnlDxAsosXxP4=;
        b=hroV6DnBy713TKOXqAsMaEOrudwCjyhube6GMpp7GEmGrcUYsMeF7ve9FaamaCKz3q
         7X1h2OACvWcZKG8Dx2c1h5289zBQKpbOAkB09CpTNtJIF472MgvMNyg4wWbctzvSczGJ
         fEUyd6m6Noes/OQ0oE7Htfx06ONtC1WHaLtKCF0goNqGuuHIJ/zRoKKhNVnW5QUdR36o
         g04fWYXX4R6wE7G1miEXIwi+djlEI2KJoNK0eUf/pHKN6CXFey0CCP8tyhixLhN/WxKF
         S1MnmI3KGYjdQuHuJeiha3R8HKP6MG+JGeYDzcYiFSj1M+7hcQ0g7FHlErgB1Xz1vPJ4
         bnGg==
X-Gm-Message-State: AOAM533TzV9famo72K2Fz9ZjIk5FWuN+gLNdXyB5EllTphKu/o2CersO
        NEsMjWEwHEQgu6CIM/U/TR4b9Q==
X-Google-Smtp-Source: ABdhPJx1Bj7AJVr1KIHHladSKAuwgtI14+Sd5TejeXcUW1rq18PsYmJ5MDqbNElPPVdcgiq1Fm+f8w==
X-Received: by 2002:a05:6000:15c2:: with SMTP id y2mr17866274wry.74.1641765274385;
        Sun, 09 Jan 2022 13:54:34 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r13sm5065650wmq.28.2022.01.09.13.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:54:33 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: r8188eu: convert DBG_88E calls in core/rtw_mlme_ext.c
Date:   Sun,  9 Jan 2022 21:54:26 +0000
Message-Id: <20220109215427.887-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220109215427.887-1-phil@philpotter.co.uk>
References: <20220109215427.887-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DBG_88E macro calls in core/rtw_mlme_ext.c to use pr_debug
or netdev_dbg appropriately, as their information may be useful to
observers, and this gets the driver closer to the point of being
able to remove DBG_88E itself. Also remove some commented out
or unnecessary DBG_88E calls altogether.

Some calls are at points in the call chain where use of dev_dbg or
netdev_dbg isn't possible due to lack of device pointer, so plain
pr_debug is appropriate here.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 427 +++++++++++---------
 1 file changed, 244 insertions(+), 183 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index a9141ab1690e..3707dfe2b2ca 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -315,7 +315,9 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 	memset(channel_set, 0, sizeof(struct rt_channel_info) * MAX_CHANNEL_NUM);
 
 	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE) {
-		DBG_88E("ChannelPlan ID %x error !!!!!\n", ChannelPlan);
+		netdev_dbg(padapter->pnetdev,
+			   "ChannelPlan ID %x error !!!!!\n",
+			   ChannelPlan);
 		return chanset_size;
 	}
 
@@ -436,7 +438,9 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 		if (GetRetry(pframe)) {
 			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum) {
 				/* drop the duplicate management frame */
-				DBG_88E("Drop duplicate management frame with seq_num=%d.\n", precv_frame->attrib.seq_num);
+				netdev_dbg(padapter->pnetdev,
+					   "Drop duplicate management frame with seq_num=%d.\n",
+					   precv_frame->attrib.seq_num);
 				return;
 			}
 		}
@@ -586,7 +590,8 @@ unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame
 		return _SUCCESS;
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_ING)) {
 		if (pwdinfo->nego_req_info.benable) {
-			DBG_88E("[%s] P2P State is GONEGO ING!\n", __func__);
+			netdev_dbg(padapter->pnetdev,
+				   "P2P State is GONEGO ING!\n");
 			if (!memcmp(pwdinfo->nego_req_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
 				pwdinfo->nego_req_info.benable = false;
 				issue_p2p_GO_request(padapter, pwdinfo->nego_req_info.peerDevAddr);
@@ -594,7 +599,8 @@ unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame
 		}
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_INVITE_REQ)) {
 		if (pwdinfo->invitereq_info.benable) {
-			DBG_88E("[%s] P2P_STATE_TX_INVITE_REQ!\n", __func__);
+			netdev_dbg(padapter->pnetdev,
+				   "P2P_STATE_TX_INVITE_REQ!\n");
 			if (!memcmp(pwdinfo->invitereq_info.peer_macaddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
 				pwdinfo->invitereq_info.benable = false;
 				issue_p2p_invitation_request(padapter, pwdinfo->invitereq_info.peer_macaddr);
@@ -720,15 +726,13 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
-	DBG_88E("+OnAuth\n");
-
 	sa = GetAddr2Ptr(pframe);
 
 	auth_mode = psecuritypriv->dot11AuthAlgrthm;
 	seq = le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + 2));
 	algorithm = le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN));
 
-	DBG_88E("auth alg=%x, seq=%X\n", algorithm, seq);
+	netdev_dbg(padapter->pnetdev, "auth alg=%x, seq=%X\n", algorithm, seq);
 
 	if (auth_mode == 2 && psecuritypriv->dot11PrivacyAlgrthm != _WEP40_ &&
 	    psecuritypriv->dot11PrivacyAlgrthm != _WEP104_)
@@ -736,8 +740,9 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	if ((algorithm > 0 && auth_mode == 0) ||	/*  rx a shared-key auth but shared not enabled */
 	    (algorithm == 0 && auth_mode == 1)) {	/*  rx a open-system auth but shared-key is enabled */
-		DBG_88E("auth rejected due to bad alg [alg=%d, auth_mib=%d] %02X%02X%02X%02X%02X%02X\n",
-			algorithm, auth_mode, sa[0], sa[1], sa[2], sa[3], sa[4], sa[5]);
+		netdev_dbg(padapter->pnetdev,
+			   "auth rejected due to bad alg [alg=%d, auth_mib=%d] %02X%02X%02X%02X%02X%02X\n",
+			   algorithm, auth_mode, sa[0], sa[1], sa[2], sa[3], sa[4], sa[5]);
 
 		status = _STATS_NO_SUPP_ALG_;
 
@@ -752,10 +757,12 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	pstat = rtw_get_stainfo(pstapriv, sa);
 	if (!pstat) {
 		/*  allocate a new one */
-		DBG_88E("going to alloc stainfo for sa=%pM\n", sa);
+		netdev_dbg(padapter->pnetdev,
+			   "going to alloc stainfo for sa=%pM\n", sa);
 		pstat = rtw_alloc_stainfo(pstapriv, sa);
 		if (!pstat) {
-			DBG_88E(" Exceed the upper limit of supported clients...\n");
+			netdev_dbg(padapter->pnetdev,
+				   "Exceed the upper limit of supported clients...\n");
 			status = _STATS_UNABLE_HANDLE_STA_;
 			goto auth_fail;
 		}
@@ -786,8 +793,9 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 		pstat->expire_to = pstapriv->auth_to;
 
 	if ((pstat->auth_seq + 1) != seq) {
-		DBG_88E("(1)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-			seq, pstat->auth_seq + 1);
+		netdev_dbg(padapter->pnetdev,
+			   "(1)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
+			   seq, pstat->auth_seq + 1);
 		status = _STATS_OUT_OF_AUTH_SEQ_;
 		goto auth_fail;
 	}
@@ -799,8 +807,9 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			pstat->expire_to = pstapriv->assoc_to;
 			pstat->authalg = algorithm;
 		} else {
-			DBG_88E("(2)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-				seq, pstat->auth_seq + 1);
+			netdev_dbg(padapter->pnetdev,
+				   "(2)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
+				   seq, pstat->auth_seq + 1);
 			status = _STATS_OUT_OF_AUTH_SEQ_;
 			goto auth_fail;
 		}
@@ -814,13 +823,14 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			pstat->auth_seq = 2;
 		} else if (seq == 3) {
 			/* checking for challenging txt... */
-			DBG_88E("checking for challenging txt...\n");
+			netdev_dbg(padapter->pnetdev, "checking for challenging txt...\n");
 
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
 			if (!p || ie_len <= 0) {
-				DBG_88E("auth rejected because challenge failure!(1)\n");
+				netdev_dbg(padapter->pnetdev,
+					   "auth rejected because challenge failure!(1)\n");
 				status = _STATS_CHALLENGE_FAIL_;
 				goto auth_fail;
 			}
@@ -831,13 +841,15 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 				/*  challenging txt is correct... */
 				pstat->expire_to =  pstapriv->assoc_to;
 			} else {
-				DBG_88E("auth rejected because challenge failure!\n");
+				netdev_dbg(padapter->pnetdev,
+					   "auth rejected because challenge failure!\n");
 				status = _STATS_CHALLENGE_FAIL_;
 				goto auth_fail;
 			}
 		} else {
-			DBG_88E("(3)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-				seq, pstat->auth_seq + 1);
+			netdev_dbg(padapter->pnetdev,
+				   "(3)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
+				   seq, pstat->auth_seq + 1);
 			status = _STATS_OUT_OF_AUTH_SEQ_;
 			goto auth_fail;
 		}
@@ -877,8 +889,6 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 	u8 *pframe = precv_frame->rx_data;
 	uint pkt_len = precv_frame->len;
 
-	DBG_88E("%s\n", __func__);
-
 	/* check A1 matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -892,7 +902,8 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 	status	= le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
 	if (status != 0) {
-		DBG_88E("clnt auth fail, status: %d\n", status);
+		netdev_dbg(padapter->pnetdev,
+			   "clnt auth fail, status: %d\n", status);
 		if (status == 13) { /*  pmlmeinfo->auth_algo == dot11AuthAlgrthm_Auto) */
 			if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
 				pmlmeinfo->auth_algo = dot11AuthAlgrthm_Open;
@@ -980,8 +991,9 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	}
 
 	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset) {
-		DBG_88E("handle_assoc(reassoc=%d) - too short payload (len=%lu)"
-		       "\n", reassoc, (unsigned long)pkt_len);
+		netdev_dbg(padapter->pnetdev,
+			   "handle_assoc(reassoc=%d) - too short payload (len=%lu)\n",
+			   reassoc, (unsigned long)pkt_len);
 		return _FAIL;
 	}
 
@@ -996,8 +1008,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	left = pkt_len - (IEEE80211_3ADDR_LEN + ie_offset);
 	pos = pframe + (IEEE80211_3ADDR_LEN + ie_offset);
 
-	DBG_88E("%s\n", __func__);
-
 	/*  check if this stat has been successfully authenticated/assocated */
 	if (!((pstat->state) & WIFI_FW_AUTH_SUCCESS)) {
 		if (!((pstat->state) & WIFI_FW_ASSOC_SUCCESS)) {
@@ -1015,8 +1025,9 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	/* now parse all ieee802_11 ie to point to elems */
 	if (rtw_ieee802_11_parse_elems(pos, left, &elems, 1) == ParseFailed ||
 	    !elems.ssid) {
-		DBG_88E("STA %pM sent invalid association request\n",
-			pstat->hwaddr);
+		netdev_dbg(padapter->pnetdev,
+			   "STA %pM sent invalid association request\n",
+			   pstat->hwaddr);
 		status = _STATS_FAILURE_;
 		goto OnAssocReqFail;
 	}
@@ -1045,7 +1056,8 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	/*  check if the supported rate is ok */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SUPPORTEDRATES_IE_, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 	if (!p) {
-		DBG_88E("Rx a sta assoc-req which supported rate is empty!\n");
+		netdev_dbg(padapter->pnetdev,
+			   "Rx a sta assoc-req which supported rate is empty!\n");
 		/*  use our own rate set as statoin used */
 		/* memcpy(supportRate, AP_BSSRATE, AP_BSSRATE_LEN); */
 		/* supportRateNum = AP_BSSRATE_LEN; */
@@ -1135,17 +1147,15 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
 	if (!wpa_ie) {
 		if (elems.wps_ie) {
-			DBG_88E("STA included WPS IE in "
-				   "(Re)Association Request - assume WPS is "
-				   "used\n");
+			netdev_dbg(padapter->pnetdev,
+				   "STA included WPS IE in (Re)Association Request - assume WPS is used\n");
 			pstat->flags |= WLAN_STA_WPS;
 			/* wpabuf_free(sta->wps_ie); */
 			/* sta->wps_ie = wpabuf_alloc_copy(elems.wps_ie + 4, */
 			/*				elems.wps_ie_len - 4); */
 		} else {
-			DBG_88E("STA did not include WPA/RSN IE "
-				   "in (Re)Association Request - possible WPS "
-				   "use\n");
+			netdev_dbg(padapter->pnetdev,
+				   "STA did not include WPA/RSN IE in (Re)Association Request - possible WPS use\n");
 			pstat->flags |= WLAN_STA_MAYBE_WPS;
 		}
 
@@ -1158,7 +1168,8 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 				rtw_get_wps_attr_content(pmlmepriv->wps_beacon_ie, pmlmepriv->wps_beacon_ie_len, WPS_ATTR_SELECTED_REGISTRAR, &selected_registrar, NULL);
 
 				if (!selected_registrar) {
-					DBG_88E("selected_registrar is false , or AP is not ready to do WPS\n");
+					netdev_dbg(padapter->pnetdev,
+						   "selected_registrar is false , or AP is not ready to do WPS\n");
 
 					status = _STATS_UNABLE_HANDLE_STA_;
 
@@ -1170,8 +1181,9 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		int copy_len;
 
 		if (psecuritypriv->wpa_psk == 0) {
-			DBG_88E("STA %pM: WPA/RSN IE in association "
-			"request, but AP don't support WPA/RSN\n", pstat->hwaddr);
+			netdev_dbg(padapter->pnetdev,
+				   "STA %pM: WPA/RSN IE in association request, but AP don't support WPA/RSN\n",
+				   pstat->hwaddr);
 
 			status = WLAN_STATUS_INVALID_IE;
 
@@ -1179,9 +1191,8 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		}
 
 		if (elems.wps_ie) {
-			DBG_88E("STA included WPS IE in "
-				   "(Re)Association Request - WPS is "
-				   "used\n");
+			netdev_dbg(padapter->pnetdev,
+				   "STA included WPS IE in (Re)Association Request - WPS is used\n");
 			pstat->flags |= WLAN_STA_WPS;
 			copy_len = 0;
 		} else {
@@ -1266,8 +1277,9 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	if ((pstat->flags & WLAN_STA_HT) &&
 	    ((pstat->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
 	    (pstat->wpa_pairwise_cipher & WPA_CIPHER_TKIP))) {
-		DBG_88E("HT: %pM tried to "
-			"use TKIP with HT association\n", pstat->hwaddr);
+		netdev_dbg(padapter->pnetdev,
+			   "HT: %pM tried to use TKIP with HT association\n",
+			   pstat->hwaddr);
 
 		/* status = WLAN_STATUS_CIPHER_REJECTED_PER_POLICY; */
 		/* goto OnAssocReqFail; */
@@ -1312,7 +1324,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 	/* get a unique AID */
 	if (pstat->aid > 0) {
-		DBG_88E("  old AID %d\n", pstat->aid);
+		netdev_dbg(padapter->pnetdev, "old AID %d\n", pstat->aid);
 	} else {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
 			if (!pstapriv->sta_aid[pstat->aid - 1])
@@ -1322,14 +1334,16 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		if (pstat->aid > pstapriv->max_num_sta) {
 			pstat->aid = 0;
 
-			DBG_88E("  no room for more AIDs\n");
+			netdev_dbg(padapter->pnetdev,
+				   "no room for more AIDs\n");
 
 			status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
 
 			goto OnAssocReqFail;
 		} else {
 			pstapriv->sta_aid[pstat->aid - 1] = pstat;
-			DBG_88E("allocate new AID=(%d)\n", pstat->aid);
+			netdev_dbg(padapter->pnetdev,
+				   "allocate new AID=(%d)\n", pstat->aid);
 		}
 	}
 
@@ -1364,7 +1378,8 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 			issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
 
 		/* 2 - report to upper layer */
-		DBG_88E("indicate_sta_join_event to upper layer - hostapd\n");
+		netdev_dbg(padapter->pnetdev,
+			   "indicate_sta_join_event to upper layer - hostapd\n");
 		rtw_indicate_sta_assoc_event(padapter, pstat);
 
 		/* 3-(1) report sta add event */
@@ -1403,8 +1418,6 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	u8 *pframe = precv_frame->rx_data;
 	uint pkt_len = precv_frame->len;
 
-	DBG_88E("%s\n", __func__);
-
 	/* check A1 matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -1420,7 +1433,8 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	/* status */
 	status = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 2));
 	if (status > 0) {
-		DBG_88E("assoc reject, status code: %d\n", status);
+		netdev_dbg(padapter->pnetdev,
+			   "assoc reject, status code: %d\n", status);
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		res = -4;
 		goto report_assoc_result;
@@ -1500,7 +1514,7 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
-	DBG_88E("%s Reason code(%d)\n", __func__, reason);
+	netdev_dbg(padapter->pnetdev, "Reason code(%d)\n", reason);
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
@@ -1575,7 +1589,7 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
-	DBG_88E("%s Reason code(%d)\n", __func__, reason);
+	netdev_dbg(padapter->pnetdev, "Reason code(%d)\n", reason);
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
@@ -1614,7 +1628,6 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 
 unsigned int OnAtim(struct adapter *padapter, struct recv_frame *precv_frame)
 {
-	DBG_88E("%s\n", __func__);
 	return _SUCCESS;
 }
 
@@ -1628,8 +1641,6 @@ unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_f
 	u8 category;
 	u8 action;
 
-	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
-
 	psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 
 	if (!psta)
@@ -1682,8 +1693,6 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
 		return _SUCCESS;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		if (!(pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS))
 			return _SUCCESS;
@@ -1701,7 +1710,7 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 		if (!pmlmeinfo->HT_enable)
 			return _SUCCESS;
 		action = frame_body[1];
-		DBG_88E("%s, action=%d\n", __func__, action);
+		netdev_dbg(padapter->pnetdev, "action=%d\n", action);
 		switch (action) {
 		case RTW_WLAN_ACTION_ADDBA_REQ: /* ADDBA request */
 			memcpy(&pmlmeinfo->ADDBA_req, &frame_body[2], sizeof(struct ADDBA_request));
@@ -1716,7 +1725,8 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 			status = get_unaligned_le16(&frame_body[3]);
 			tid = ((frame_body[5] >> 2) & 0x7);
 			if (status == 0) {	/* successful */
-				DBG_88E("agg_enable for TID=%d\n", tid);
+				netdev_dbg(padapter->pnetdev,
+					   "agg_enable for TID=%d\n", tid);
 				psta->htpriv.agg_enable_bitmap |= 1 << tid;
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			} else {
@@ -1734,7 +1744,10 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
 			}
-			DBG_88E("%s(): DELBA: %x(%x)\n", __func__, pmlmeinfo->agg_enable_bitmap, reason_code);
+			netdev_dbg(padapter->pnetdev,
+				   "DELBA: %x(%x)\n",
+				   pmlmeinfo->agg_enable_bitmap,
+				   reason_code);
 			/* todo: how to notify the host while receiving DELETE BA */
 			break;
 		default:
@@ -1778,7 +1791,6 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	if (!pmgntframe)
 		return;
 
-	DBG_88E("[%s] In\n", __func__);
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
@@ -2114,7 +2126,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	if (!pmgntframe)
 		return;
 
-	DBG_88E("[%s] In, result=%d\n", __func__,  result);
+	netdev_dbg(padapter->pnetdev, "result=%d\n",  result);
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
@@ -2472,7 +2484,6 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	if (!pmgntframe)
 		return;
 
-	DBG_88E("[%s] In\n", __func__);
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
@@ -3072,7 +3083,6 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	if (!pmgntframe)
 		return;
 
-	DBG_88E("[%s] In\n", __func__);
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
@@ -3148,16 +3158,18 @@ static u8 is_matched_in_profilelist(u8 *peermacaddr, struct profile_info *profil
 {
 	u8 i, match_result = 0;
 
-	DBG_88E("[%s] peermac=%.2X %.2X %.2X %.2X %.2X %.2X\n", __func__,
-		peermacaddr[0], peermacaddr[1], peermacaddr[2], peermacaddr[3], peermacaddr[4], peermacaddr[5]);
+	pr_debug("peermac=%.2X %.2X %.2X %.2X %.2X %.2X\n",
+		 peermacaddr[0], peermacaddr[1], peermacaddr[2],
+		 peermacaddr[3], peermacaddr[4], peermacaddr[5]);
 
 	for (i = 0; i < P2P_MAX_PERSISTENT_GROUP_NUM; i++, profileinfo++) {
-		DBG_88E("[%s] profileinfo_mac=%.2X %.2X %.2X %.2X %.2X %.2X\n", __func__,
-			profileinfo->peermac[0], profileinfo->peermac[1], profileinfo->peermac[2],
-			profileinfo->peermac[3], profileinfo->peermac[4], profileinfo->peermac[5]);
+		pr_debug("profileinfo_mac=%.2X %.2X %.2X %.2X %.2X %.2X\n",
+			 profileinfo->peermac[0], profileinfo->peermac[1],
+			 profileinfo->peermac[2], profileinfo->peermac[3],
+			 profileinfo->peermac[4], profileinfo->peermac[5]);
 		if (!memcmp(peermacaddr, profileinfo->peermac, ETH_ALEN)) {
 			match_result = 1;
-			DBG_88E("[%s] Match!\n", __func__);
+			pr_debug("Match!\n");
 			break;
 		}
 	}
@@ -3709,14 +3721,16 @@ static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 	if (GetRetry(frame)) {
 		if (token >= 0) {
 			if ((seq_ctrl == mlmeext->action_public_rxseq) && (token == mlmeext->action_public_dialog_token)) {
-				DBG_88E(FUNC_ADPT_FMT" seq_ctrl = 0x%x, rxseq = 0x%x, token:%d\n",
-					FUNC_ADPT_ARG(adapter), seq_ctrl, mlmeext->action_public_rxseq, token);
+				netdev_dbg(adapter->pnetdev,
+					   "seq_ctrl = 0x%x, rxseq = 0x%x, token:%d\n",
+					   seq_ctrl, mlmeext->action_public_rxseq, token);
 				return _FAIL;
 			}
 		} else {
 			if (seq_ctrl == mlmeext->action_public_rxseq) {
-				DBG_88E(FUNC_ADPT_FMT" seq_ctrl = 0x%x, rxseq = 0x%x\n",
-					FUNC_ADPT_ARG(adapter), seq_ctrl, mlmeext->action_public_rxseq);
+				netdev_dbg(adapter->pnetdev,
+					   "seq_ctrl = 0x%x, rxseq = 0x%x\n",
+					   seq_ctrl, mlmeext->action_public_rxseq);
 				return _FAIL;
 			}
 		}
@@ -3759,7 +3773,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 
 	switch (frame_body[6]) { /* OUI Subtype */
 	case P2P_GO_NEGO_REQ:
-		DBG_88E("[%s] Got GO Nego Req Frame\n", __func__);
+		netdev_dbg(padapter->pnetdev, "Got GO Nego Req Frame\n");
 		memset(&pwdinfo->groupid_info, 0x00, sizeof(struct group_id_info));
 
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_RX_PROVISION_DIS_REQ))
@@ -3771,7 +3785,9 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 			_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
 			/*	Restore the previous p2p state */
 			rtw_p2p_set_state(pwdinfo, rtw_p2p_pre_state(pwdinfo));
-			DBG_88E("[%s] Restore the previous p2p state to %d\n", __func__, rtw_p2p_state(pwdinfo));
+			netdev_dbg(padapter->pnetdev,
+				   "Restore the previous p2p state to %d\n",
+				   rtw_p2p_state(pwdinfo));
 		}
 
 		/*	Commented by Kurt 20110902 */
@@ -3792,7 +3808,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		_set_timer(&pwdinfo->restore_p2p_state_timer, 5000);
 		break;
 	case P2P_GO_NEGO_RESP:
-		DBG_88E("[%s] Got GO Nego Resp Frame\n", __func__);
+		netdev_dbg(padapter->pnetdev, "Got GO Nego Resp Frame\n");
 
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_ING)) {
 			/*	Commented by Albert 20110425 */
@@ -3813,11 +3829,12 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 			if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_FAIL))
 				_set_timer(&pwdinfo->restore_p2p_state_timer, 5000);
 		} else {
-			DBG_88E("[%s] Skipped GO Nego Resp Frame (p2p_state != P2P_STATE_GONEGO_ING)\n", __func__);
+			netdev_dbg(padapter->pnetdev,
+				   "Skipped GO Nego Resp Frame (p2p_state != P2P_STATE_GONEGO_ING)\n");
 		}
 		break;
 	case P2P_GO_NEGO_CONF:
-		DBG_88E("[%s] Got GO Nego Confirm Frame\n", __func__);
+		netdev_dbg(padapter->pnetdev, "Got GO Nego Confirm Frame\n");
 		result = process_p2p_group_negotation_confirm(pwdinfo, frame_body, len);
 		if (P2P_STATUS_SUCCESS == result) {
 			if (rtw_p2p_role(pwdinfo) == P2P_ROLE_CLIENT) {
@@ -3831,7 +3848,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		/*	Added by Albert 2010/10/05 */
 		/*	Received the P2P Invite Request frame. */
 
-		DBG_88E("[%s] Got invite request frame!\n", __func__);
+		netdev_dbg(padapter->pnetdev, "Got invite request frame!\n");
 		p2p_ie = rtw_get_p2p_ie(frame_body + _PUBLIC_ACTION_IE_OFFSET_, len - _PUBLIC_ACTION_IE_OFFSET_, NULL, &p2p_ielen);
 		if (p2p_ie) {
 			/*	Parse the necessary information from the P2P Invitation Request frame. */
@@ -3851,10 +3868,14 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 				/*	After having the peer interface address, the sigma can find the correct conf file for wpa_supplicant. */
 
 				if (attr_contentlen) {
-					DBG_88E("[%s] GO's BSSID = %.2X %.2X %.2X %.2X %.2X %.2X\n", __func__,
-						pwdinfo->p2p_peer_interface_addr[0], pwdinfo->p2p_peer_interface_addr[1],
-						pwdinfo->p2p_peer_interface_addr[2], pwdinfo->p2p_peer_interface_addr[3],
-						pwdinfo->p2p_peer_interface_addr[4], pwdinfo->p2p_peer_interface_addr[5]);
+					netdev_dbg(padapter->pnetdev,
+						   "GO's BSSID = %.2X %.2X %.2X %.2X %.2X %.2X\n",
+						   pwdinfo->p2p_peer_interface_addr[0],
+						   pwdinfo->p2p_peer_interface_addr[1],
+						   pwdinfo->p2p_peer_interface_addr[2],
+						   pwdinfo->p2p_peer_interface_addr[3],
+						   pwdinfo->p2p_peer_interface_addr[4],
+						   pwdinfo->p2p_peer_interface_addr[5]);
 				}
 
 				if (invitation_flag & P2P_INVITATION_FLAGS_PERSISTENT) {
@@ -3902,7 +3923,8 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 							}
 						}
 					} else {
-						DBG_88E("[%s] P2P Group ID Attribute NOT FOUND!\n", __func__);
+						netdev_dbg(padapter->pnetdev,
+							   "P2P Group ID Attribute NOT FOUND!\n");
 						status_code = P2P_STATUS_FAIL_INFO_UNAVAILABLE;
 					}
 				} else {
@@ -3928,16 +3950,19 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 							status_code = P2P_STATUS_SUCCESS;
 						}
 					} else {
-						DBG_88E("[%s] P2P Group ID Attribute NOT FOUND!\n", __func__);
+						netdev_dbg(padapter->pnetdev,
+							   "P2P Group ID Attribute NOT FOUND!\n");
 						status_code = P2P_STATUS_FAIL_INFO_UNAVAILABLE;
 					}
 				}
 			} else {
-				DBG_88E("[%s] P2P Invitation Flags Attribute NOT FOUND!\n", __func__);
+				netdev_dbg(padapter->pnetdev,
+					   "P2P Invitation Flags Attribute NOT FOUND!\n");
 				status_code = P2P_STATUS_FAIL_INFO_UNAVAILABLE;
 			}
 
-			DBG_88E("[%s] status_code = %d\n", __func__, status_code);
+			netdev_dbg(padapter->pnetdev,
+				   "status_code = %d\n", status_code);
 
 			pwdinfo->inviteresp_info.token = frame_body[7];
 			issue_p2p_invitation_response(padapter, GetAddr2Ptr(pframe), pwdinfo->inviteresp_info.token, status_code);
@@ -3947,14 +3972,15 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		u8	attr_content = 0x00;
 		u32	attr_contentlen = 0;
 
-		DBG_88E("[%s] Got invite response frame!\n", __func__);
+		netdev_dbg(padapter->pnetdev, "Got invite response frame!\n");
 		_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
 		p2p_ie = rtw_get_p2p_ie(frame_body + _PUBLIC_ACTION_IE_OFFSET_, len - _PUBLIC_ACTION_IE_OFFSET_, NULL, &p2p_ielen);
 		if (p2p_ie) {
 			rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_STATUS, &attr_content, &attr_contentlen);
 
 			if (attr_contentlen == 1) {
-				DBG_88E("[%s] Status = %d\n", __func__, attr_content);
+				netdev_dbg(padapter->pnetdev,
+					   "Status = %d\n", attr_content);
 				pwdinfo->invitereq_info.benable = false;
 
 				if (attr_content == P2P_STATUS_SUCCESS) {
@@ -3988,7 +4014,8 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		process_p2p_devdisc_resp(pwdinfo, pframe, len);
 		break;
 	case P2P_PROVISION_DISC_REQ:
-		DBG_88E("[%s] Got Provisioning Discovery Request Frame\n", __func__);
+		netdev_dbg(padapter->pnetdev,
+			   "Got Provisioning Discovery Request Frame\n");
 		process_p2p_provdisc_req(pwdinfo, pframe, len);
 		memcpy(pwdinfo->rx_prov_disc_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN);
 
@@ -4003,7 +4030,8 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	case P2P_PROVISION_DISC_RESP:
 		/*	Commented by Albert 20110707 */
 		/*	Should we check the pwdinfo->tx_prov_disc_info.bsent flag here?? */
-		DBG_88E("[%s] Got Provisioning Discovery Response Frame\n", __func__);
+		netdev_dbg(padapter->pnetdev,
+			   "Got Provisioning Discovery Response Frame\n");
 		/*	Commented by Albert 20110426 */
 		/*	The restore timer is enabled when issuing the provisioing request frame in rtw_p2p_prov_disc function. */
 		_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
@@ -4094,8 +4122,6 @@ unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fra
 	uint len = precv_frame->len;
 	struct	wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("%s\n", __func__);
-
 	/* check RA matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
 		return _SUCCESS;
@@ -4160,13 +4186,13 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 
 	pmgntframe = rtw_alloc_xmitframe(pxmitpriv);
 	if (!pmgntframe) {
-		DBG_88E("%s, alloc xmitframe fail\n", __func__);
+		pr_debug("alloc xmitframe fail\n");
 		return NULL;
 	}
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
 	if (!pxmitbuf) {
-		DBG_88E("%s, alloc xmitbuf fail\n", __func__);
+		pr_debug("alloc xmitbuf fail\n");
 		rtw_free_xmitframe(pxmitpriv, pmgntframe);
 		return NULL;
 	}
@@ -4188,7 +4214,7 @@ void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 
 	pmlmeext->tx_rate = rate;
-	DBG_88E("%s(): rate = %x\n", __func__, rate);
+	netdev_dbg(padapter->pnetdev, "rate = %x\n", rate);
 }
 
 void update_mgntframe_attrib(struct adapter *padapter, struct pkt_attrib *pattrib)
@@ -4325,7 +4351,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
-		DBG_88E("%s, alloc mgnt frame fail\n", __func__);
+		netdev_dbg(padapter->pnetdev, "alloc mgnt frame fail\n");
 		return;
 	}
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
@@ -4508,13 +4534,12 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
 
 	if ((pattrib->pktlen + TXDESC_SIZE) > 512) {
-		DBG_88E("beacon frame too large\n");
+		netdev_dbg(padapter->pnetdev, "beacon frame too large\n");
 		return;
 	}
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	/* DBG_88E("issue bcn_sz=%d\n", pattrib->last_txcmdsz); */
 	if (timeout_ms > 0)
 		dump_mgntframe_and_wait(padapter, pmgntframe, timeout_ms);
 	else
@@ -4541,7 +4566,8 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
-		DBG_88E("%s, alloc mgnt frame fail\n", __func__);
+		netdev_dbg(padapter->pnetdev,
+			   "alloc mgnt frame fail\n");
 		return;
 	}
 
@@ -4789,13 +4815,17 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
+			netdev_dbg(padapter->pnetdev,
+				   "to %pM, ch:%u%s, %d/%d in %u ms\n",
+				   da, rtw_get_oper_ch(padapter),
+				   ret == _SUCCESS ? ", acked" : "",
+				   i, try_cnt, rtw_get_passing_time_ms(start));
 		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
+			netdev_dbg(padapter->pnetdev,
+				   "ch:%u%s, %d/%d in %u ms\n",
+				   rtw_get_oper_ch(padapter),
+				   ret == _SUCCESS ? ", acked" : "",
+				   i, try_cnt, rtw_get_passing_time_ms(start));
 	}
 exit:
 	return ret;
@@ -4925,7 +4955,6 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	rtw_wep_encrypt(padapter, pmgntframe);
-	DBG_88E("%s\n", __func__);
 	dump_mgntframe(padapter, pmgntframe);
 }
 
@@ -4946,8 +4975,6 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	__le16 lestatus, leval;
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("%s\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		return;
@@ -5134,7 +5161,9 @@ void issue_assocreq(struct adapter *padapter)
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
 		if (pmlmeinfo->network.SupportedRates[i] == 0)
 			break;
-		DBG_88E("network.SupportedRates[%d]=%02X\n", i, pmlmeinfo->network.SupportedRates[i]);
+		netdev_dbg(padapter->pnetdev,
+			   "network.SupportedRates[%d]=%02X\n",
+			   i, pmlmeinfo->network.SupportedRates[i]);
 	}
 
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
@@ -5151,7 +5180,9 @@ void issue_assocreq(struct adapter *padapter)
 
 		if (j == sta_bssrate_len) {
 			/*  the rate is not supported by STA */
-			DBG_88E("%s(): the rate[%d]=%02X is not supported by STA!\n", __func__, i, pmlmeinfo->network.SupportedRates[i]);
+			netdev_dbg(padapter->pnetdev,
+				   "the rate[%d]=%02X is not supported by STA!\n",
+				   i, pmlmeinfo->network.SupportedRates[i]);
 		} else {
 			/*  the rate is supported by STA */
 			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
@@ -5159,7 +5190,7 @@ void issue_assocreq(struct adapter *padapter)
 	}
 
 	bssrate_len = index;
-	DBG_88E("bssrate_len=%d\n", bssrate_len);
+	netdev_dbg(padapter->pnetdev, "bssrate_len=%d\n", bssrate_len);
 
 	if (bssrate_len == 0) {
 		rtw_free_xmitbuf(pxmitpriv, pmgntframe->pxmitbuf);
@@ -5471,13 +5502,17 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
+			netdev_dbg(padapter->pnetdev,
+				   "to %pM, ch:%u%s, %d/%d in %u ms\n",
+				   da, rtw_get_oper_ch(padapter),
+				   ret == _SUCCESS ? ", acked" : "",
+				   i, try_cnt, rtw_get_passing_time_ms(start));
 		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
+			netdev_dbg(padapter->pnetdev,
+				   "ch:%u%s, %d/%d in %u ms\n",
+				   rtw_get_oper_ch(padapter),
+				   ret == _SUCCESS ? ", acked" : "",
+				   i, try_cnt, rtw_get_passing_time_ms(start));
 	}
 exit:
 	return ret;
@@ -5497,8 +5532,6 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	DBG_88E("%s\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		goto exit;
@@ -5591,13 +5624,17 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
+			netdev_dbg(padapter->pnetdev,
+				   "to %pM, ch:%u%s, %d/%d in %u ms\n",
+				   da, rtw_get_oper_ch(padapter),
+				   ret == _SUCCESS ? ", acked" : "",
+				   i, try_cnt, rtw_get_passing_time_ms(start));
 		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
+			netdev_dbg(padapter->pnetdev,
+				   "ch:%u%s, %d/%d in %u ms\n",
+				   rtw_get_oper_ch(padapter),
+				   ret == _SUCCESS ? ", acked" : "",
+				   i, try_cnt, rtw_get_passing_time_ms(start));
 	}
 exit:
 	return ret;
@@ -5668,7 +5705,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 
 int issue_deauth(struct adapter *padapter, unsigned char *da, unsigned short reason)
 {
-	DBG_88E("%s to %pM\n", __func__, da);
+	netdev_dbg(padapter->pnetdev, "to %pM\n", da);
 	return _issue_deauth(padapter, da, reason, false);
 }
 
@@ -5698,13 +5735,17 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
+			netdev_dbg(padapter->pnetdev,
+				   "to %pM, ch:%u%s, %d/%d in %u ms\n",
+				   da, rtw_get_oper_ch(padapter),
+				   ret == _SUCCESS ? ", acked" : "",
+				   i, try_cnt, rtw_get_passing_time_ms(start));
 		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
+			netdev_dbg(padapter->pnetdev,
+				   "ch:%u%s, %d/%d in %u ms\n",
+				   rtw_get_oper_ch(padapter),
+				   ret == _SUCCESS ? ", acked" : "",
+				   i, try_cnt, rtw_get_passing_time_ms(start));
 	}
 exit:
 	return ret;
@@ -5732,7 +5773,9 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct registry_priv *pregpriv = &padapter->registrypriv;
 
-	DBG_88E("%s, category=%d, action=%d, status=%d\n", __func__, category, action, status);
+	netdev_dbg(padapter->pnetdev,
+		   "category=%d, action=%d, status=%d\n",
+		   category, action, status);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -5785,7 +5828,9 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			if (psta) {
 				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07] & 0xfff) + 1;
 
-				DBG_88E("BA_starting_seqctrl=%d for TID=%d\n", start_seq, status & 0x07);
+				netdev_dbg(padapter->pnetdev,
+					   "BA_starting_seqctrl=%d for TID=%d\n",
+					   start_seq, status & 0x07);
 
 				psta->BA_starting_seqctrl[status & 0x07] = start_seq;
 
@@ -5868,8 +5913,6 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	if (pmlmeinfo->bwmode_updated)
 		return;
 
-	DBG_88E("%s\n", __func__);
-
 	category = RTW_WLAN_CATEGORY_PUBLIC;
 	action = ACT_PUBLIC_BSSCOEXIST;
 
@@ -5994,7 +6037,8 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	if (initiator == 0) { /*  recipient */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
-				DBG_88E("rx agg disable tid(%d)\n", tid);
+				netdev_dbg(padapter->pnetdev,
+					   "rx agg disable tid(%d)\n", tid);
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
@@ -6003,7 +6047,8 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	} else if (initiator == 1) { /*  originator */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
-				DBG_88E("tx agg disable tid(%d)\n", tid);
+				netdev_dbg(padapter->pnetdev,
+					   "tx agg disable tid(%d)\n", tid);
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
@@ -6036,13 +6081,16 @@ unsigned int send_beacon(struct adapter *padapter)
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return _FAIL;
 	if (!bxmitok) {
-		DBG_88E("%s fail! %u ms\n", __func__, rtw_get_passing_time_ms(start));
+		netdev_dbg(padapter->pnetdev, "fail! %u ms\n",
+			   rtw_get_passing_time_ms(start));
 		return _FAIL;
 	} else {
 		u32 passing_time = rtw_get_passing_time_ms(start);
 
 		if (passing_time > 100 || issue > 3)
-			DBG_88E("%s success, issue:%d, poll:%d, %u ms\n", __func__, issue, poll, rtw_get_passing_time_ms(start));
+			netdev_dbg(padapter->pnetdev,
+				   "success, issue:%d, poll:%d, %u ms\n",
+				   issue, poll, rtw_get_passing_time_ms(start));
 		return _SUCCESS;
 	}
 }
@@ -6251,13 +6299,16 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
 	if (!p) {
-		DBG_88E("marc: cannot find SSID for survey event\n");
+		netdev_dbg(padapter->pnetdev,
+			   "marc: cannot find SSID for survey event\n");
 		return _FAIL;
 	}
 
 	if (*(p + 1)) {
 		if (len > NDIS_802_11_LENGTH_SSID) {
-			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
+			netdev_dbg(padapter->pnetdev,
+				   "IE too long (%d) for survey event\n",
+				   len);
 			return _FAIL;
 		}
 		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
@@ -6273,7 +6324,9 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
 		if (len > NDIS_802_11_LENGTH_RATES_EX) {
-			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
+			netdev_dbg(padapter->pnetdev,
+				   "IE too long (%d) for survey event\n",
+				   len);
 			return _FAIL;
 		}
 		memcpy(bssid->SupportedRates, (p + 2), len);
@@ -6283,7 +6336,9 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	p = rtw_get_ie(bssid->IEs + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
 		if (len > (NDIS_802_11_LENGTH_RATES_EX - i)) {
-			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
+			netdev_dbg(padapter->pnetdev,
+				   "IE too long (%d) for survey event\n",
+				   len);
 			return _FAIL;
 		}
 		memcpy(bssid->SupportedRates + i, (p + 2), len);
@@ -6400,7 +6455,7 @@ void start_create_ibss(struct adapter *padapter)
 			rtw_indicate_connect(padapter);
 		}
 	} else {
-		DBG_88E("start_create_ibss, invalid cap:%x\n", caps);
+		netdev_dbg(padapter->pnetdev, "invalid cap:%x\n", caps);
 		return;
 	}
 	/* update bc/mc sta_info */
@@ -6515,8 +6570,6 @@ unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr
 	if (!(!memcmp(MacAddr, get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
 		return _SUCCESS;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
@@ -6774,7 +6827,8 @@ void report_surveydone_event(struct adapter *padapter)
 	psurveydone_evt = (struct surveydone_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	psurveydone_evt->bss_cnt = pmlmeext->sitesurvey_res.bss_cnt;
 
-	DBG_88E("survey done event(%x)\n", psurveydone_evt->bss_cnt);
+	netdev_dbg(padapter->pnetdev, "survey done event(%x)\n",
+		   psurveydone_evt->bss_cnt);
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
@@ -6820,7 +6874,7 @@ void report_join_res(struct adapter *padapter, int res)
 	pjoinbss_evt->network.join_res	= res;
 	pjoinbss_evt->network.aid = res;
 
-	DBG_88E("report_join_res(%d)\n", res);
+	netdev_dbg(padapter->pnetdev, "res=%d\n", res);
 
 	rtw_joinbss_event_prehandle(padapter, (u8 *)&pjoinbss_evt->network);
 
@@ -6876,7 +6930,7 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 
 	pdel_sta_evt->mac_id = mac_id;
 
-	DBG_88E("report_del_sta_event: delete STA, mac_id =%d\n", mac_id);
+	netdev_dbg(padapter->pnetdev, "delete STA, mac_id = %d\n", mac_id);
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
@@ -6920,7 +6974,7 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	memcpy((unsigned char *)(&padd_sta_evt->macaddr), MacAddr, ETH_ALEN);
 	padd_sta_evt->cam_id = cam_idx;
 
-	DBG_88E("report_add_sta_event: add STA\n");
+	netdev_dbg(padapter->pnetdev, "add STA\n");
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
@@ -7048,8 +7102,6 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_CONNECT, 0);
 
 exit_mlmeext_joinbss_event_callback:
-
-	DBG_88E("=>%s\n", __func__);
 }
 
 void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *psta)
@@ -7058,8 +7110,6 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 join_type;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {/* adhoc master or sta_count>1 */
 			/* nothing to do */
@@ -7139,7 +7189,8 @@ static void _linked_rx_signal_strength_display(struct adapter *padapter)
 	GetHalDefVar8188EUsb(padapter, HW_DEF_RA_INFO_DUMP, &mac_id);
 
 	GetHalDefVar8188EUsb(padapter, HAL_DEF_UNDERCORATEDSMOOTHEDPWDB, &UndecoratedSmoothedPWDB);
-	DBG_88E("UndecoratedSmoothedPWDB:%d\n", UndecoratedSmoothedPWDB);
+	netdev_dbg(padapter->pnetdev,
+		   "UndecoratedSmoothedPWDB:%d\n", UndecoratedSmoothedPWDB);
 }
 
 static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
@@ -7164,15 +7215,20 @@ static void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
 	u8 fw_status;
 
 	if (rx_dma_status != 0x00) {
-		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
+		netdev_dbg(padapter->pnetdev, "REG_RXDMA_STATUS:0x%08x\n",
+			   rx_dma_status);
 		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
 	}
 
 	fw_status = rtw_read8(padapter, REG_FMETHR);
 	if (fw_status == 1)
-		DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
+		netdev_dbg(padapter->pnetdev,
+			   "REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n",
+			   fw_status);
 	else if (fw_status == 2)
-		DBG_88E("%s REG_FW_STATUS (0x%02x), Condition_No_Match !!\n", __func__, fw_status);
+		netdev_dbg(padapter->pnetdev,
+			   "REG_FW_STATUS (0x%02x), Condition_No_Match !!\n",
+			   fw_status);
 }
 
 void linked_status_chk(struct adapter *padapter)
@@ -7308,15 +7364,15 @@ void survey_timer_hdl(struct adapter *padapter)
 			if (!rtw_p2p_chk_state(&padapter->wdinfo, P2P_STATE_NONE)) {
 				rtw_p2p_findphase_ex_set(pwdinfo, P2P_FINDPHASE_EX_MAX);
 				pmlmeext->sitesurvey_res.channel_idx = 3;
-				DBG_88E("%s idx:%d, cnt:%u\n", __func__
-					, pmlmeext->sitesurvey_res.channel_idx
-					, pwdinfo->find_phase_state_exchange_cnt
-			);
+				netdev_dbg(padapter->pnetdev,
+					   "idx:%d, cnt:%u\n",
+					   pmlmeext->sitesurvey_res.channel_idx,
+					   pwdinfo->find_phase_state_exchange_cnt);
 			} else {
 				pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
-				DBG_88E("%s idx:%d\n", __func__
-					, pmlmeext->sitesurvey_res.channel_idx
-			);
+				netdev_dbg(padapter->pnetdev,
+					   "idx:%d\n",
+					   pmlmeext->sitesurvey_res.channel_idx);
 			}
 
 			pmlmeext->scan_abort = false;/* reset */
@@ -7346,7 +7402,7 @@ void link_timer_hdl(struct adapter *padapter)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
-		DBG_88E("link_timer_hdl:no beacon while connecting\n");
+		netdev_dbg(padapter->pnetdev, "no beacon while connecting\n");
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		report_join_res(padapter, -3);
 	} else if (pmlmeinfo->state & WIFI_FW_AUTH_STATE) {
@@ -7357,7 +7413,7 @@ void link_timer_hdl(struct adapter *padapter)
 			return;
 		}
 
-		DBG_88E("link_timer_hdl: auth timeout and try again\n");
+		netdev_dbg(padapter->pnetdev, "auth timeout and try again\n");
 		pmlmeinfo->auth_seq = 1;
 		issue_auth(padapter, NULL, 0);
 		set_link_timer(pmlmeext, REAUTH_TO);
@@ -7369,7 +7425,7 @@ void link_timer_hdl(struct adapter *padapter)
 			return;
 		}
 
-		DBG_88E("link_timer_hdl: assoc timeout and try again\n");
+		netdev_dbg(padapter->pnetdev, "assoc timeout and try again\n");
 		issue_assocreq(padapter);
 		set_link_timer(pmlmeext, REASSOC_TO);
 	}
@@ -7560,7 +7616,8 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 						break;
 				}
 
-					DBG_88E("set ch/bw before connected\n");
+					netdev_dbg(padapter->pnetdev,
+						   "set ch/bw before connected\n");
 				}
 			}
 			break;
@@ -7819,24 +7876,29 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 		if (psta) {
 			ctrl = (BIT(15) | ((pparm->algorithm) << 2));
 
-			DBG_88E("r871x_set_stakey_hdl(): enc_algorithm=%d\n", pparm->algorithm);
+			netdev_dbg(padapter->pnetdev, "enc_algorithm=%d\n",
+				   pparm->algorithm);
 
 			if ((psta->mac_id < 1) || (psta->mac_id > (NUM_STA - 4))) {
-				DBG_88E("r871x_set_stakey_hdl():set_stakey failed, mac_id(aid)=%d\n", psta->mac_id);
+				netdev_dbg(padapter->pnetdev,
+					   "set_stakey failed, mac_id(aid)=%d\n",
+					   psta->mac_id);
 				return H2C_REJECTED;
 			}
 
 			cam_id = (psta->mac_id + 3);/* 0~3 for default key, cmd_id = macid + 3, macid = aid+1; */
 
-			DBG_88E("Write CAM, mac_addr =%x:%x:%x:%x:%x:%x, cam_entry=%d\n", pparm->addr[0],
-				pparm->addr[1], pparm->addr[2], pparm->addr[3], pparm->addr[4],
-				pparm->addr[5], cam_id);
+			netdev_dbg(padapter->pnetdev,
+				   "Write CAM, mac_addr =%x:%x:%x:%x:%x:%x, cam_entry=%d\n",
+				   pparm->addr[0], pparm->addr[1], pparm->addr[2],
+				   pparm->addr[3], pparm->addr[4], pparm->addr[5],
+				   cam_id);
 
 			write_cam(padapter, cam_id, ctrl, pparm->addr, pparm->key);
 
 			return H2C_SUCCESS_RSP;
 		} else {
-			DBG_88E("r871x_set_stakey_hdl(): sta has been free\n");
+			netdev_dbg(padapter->pnetdev, "sta has been free\n");
 			return H2C_REJECTED;
 		}
 	}
@@ -7960,7 +8022,7 @@ u8 h2c_msg_hdl(struct adapter *padapter, unsigned char *pbuf)
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	if (send_beacon(padapter) == _FAIL) {
-		DBG_88E("issue_beacon, fail!\n");
+		netdev_dbg(padapter->pnetdev, "issue_beacon, fail!\n");
 		return H2C_PARAMETERS_ERROR;
 	} else {
 		/* tx bc/mc frames after update TIM */
@@ -8019,9 +8081,8 @@ u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf)
 
 	set_ch_parm = (struct set_ch_parm *)pbuf;
 
-	DBG_88E(FUNC_NDEV_FMT" ch:%u, bw:%u, ch_offset:%u\n",
-		FUNC_NDEV_ARG(padapter->pnetdev),
-		set_ch_parm->ch, set_ch_parm->bw, set_ch_parm->ch_offset);
+	netdev_dbg(padapter->pnetdev, "ch:%u, bw:%u, ch_offset:%u\n",
+		   set_ch_parm->ch, set_ch_parm->bw, set_ch_parm->ch_offset);
 
 	pmlmeext->cur_channel = set_ch_parm->ch;
 	pmlmeext->cur_ch_offset = set_ch_parm->ch_offset;
-- 
2.33.1

