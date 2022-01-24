Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E197B49AB35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S246420AbiAYEpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1325470AbiAYDhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:37:19 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F7CC058CAB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:50:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e8so14609791wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y6dDsBIWrIrhEblfxoIRDf/PAFI/BO3dFXA5mn8NRSw=;
        b=0MkvwBCNv/vxJDc+uT2aJPErZBakH/4R3G0lQEksF5bUUXjjHYH3Z6W2FGeNBwi2dx
         v3+d1XxjnJcxUR0mgst85+FW1hq6wlfv3WKZ+4dMyHD2z982yjqGSxRTt3r/4rJ4OW/a
         CS6JKKF37142hhXkWhbgh4ATxWxqf7EvzAtkgeJsV0PIX+sdImH0NaNglvv0Quo7GT+S
         RvBfpqngZF+5Ox+IEQN5vX9dE+tqjYg0KkJukWj1t8Ux+zAjGngDgr9GlKejF+y/rcX3
         MHunFKuQf7Ihrh4B8iYdCKS8Pxz8ZObp+kiAtA9mKua/QbHfT4NuXpt9z1fmr7BDW1Fp
         c/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y6dDsBIWrIrhEblfxoIRDf/PAFI/BO3dFXA5mn8NRSw=;
        b=53QVGB2UhxNw7mghnb28RqrUk8bdYh4273XMMgcZfA9NQExBkTKKMGoYsuNbOwxHnX
         oAjjbhLl0nWc75OP/EW7qnAd3+gbf4HVSAzc3Yr5zaqrHPqTWXhU4IxVi1FHG+BZcTqy
         nMO9nJ4/hITO3ZwxGYw/x5dnOpnLgKVyDHf5CMc+hv+xyWo6sjEcGVNs7QGqG71+PVU/
         NuthrotuZfPwo+9k3Ddik4/OLzoUQ1HIjbyEuugNgFOE0lP2HaBapnEB+0rJDQjEyXrg
         BvIVQZ65YWSSq4N4C+FSb3VZalCMQiG5twfz7NN4k+0MaWySEhoVc7mOBF/ibe5Gs41g
         6YHA==
X-Gm-Message-State: AOAM530cjIcYcQ7lqCCwi7zIhlmkRkIypgzDo6O5mp8qF4G2Jmwex6rR
        5/elg9eDox+PqQgYww+LbmsiWA==
X-Google-Smtp-Source: ABdhPJxGMHRHVoSxoCX4lHx2LW3HCnVCq3fBB9jZjnKh40oId17oyo9ipVi3dr2Pl9HK/SlrfqvkmA==
X-Received: by 2002:a5d:47a3:: with SMTP id 3mr7064765wrb.631.1643064652820;
        Mon, 24 Jan 2022 14:50:52 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id g189sm624742wme.18.2022.01.24.14.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:50:52 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 03/10] staging: r8188eu: remove DBG_88E calls from core/rtw_mlme_ext.c
Date:   Mon, 24 Jan 2022 22:50:25 +0000
Message-Id: <20220124225032.860-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124225032.860-1-phil@philpotter.co.uk>
References: <20220124225032.860-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from core/rtw_mlme_ext.c, including the commented
one, as they do not conform to kernel coding standards and are
superfluous. Also restructure where appropriate to remove no longer needed
code left behind by removal of these calls. This will allow the eventual
removal of the DBG_88E macro itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 315 ++------------------
 1 file changed, 23 insertions(+), 292 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index f99c1bcff1e9..0414b57ff8df 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -314,10 +314,8 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 
 	memset(channel_set, 0, sizeof(struct rt_channel_info) * MAX_CHANNEL_NUM);
 
-	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE) {
-		DBG_88E("ChannelPlan ID %x error !!!!!\n", ChannelPlan);
+	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
 		return chanset_size;
-	}
 
 	if (padapter->registrypriv.wireless_mode & WIRELESS_11G) {
 		b2_4GBand = true;
@@ -434,11 +432,9 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	if (psta) {
 		if (GetRetry(pframe)) {
-			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum) {
+			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum)
 				/* drop the duplicate management frame */
-				DBG_88E("Drop duplicate management frame with seq_num=%d.\n", precv_frame->attrib.seq_num);
 				return;
-			}
 		}
 		psta->RxMgmtFrameSeqNum = precv_frame->attrib.seq_num;
 	}
@@ -586,7 +582,6 @@ unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame
 		return _SUCCESS;
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_ING)) {
 		if (pwdinfo->nego_req_info.benable) {
-			DBG_88E("[%s] P2P State is GONEGO ING!\n", __func__);
 			if (!memcmp(pwdinfo->nego_req_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
 				pwdinfo->nego_req_info.benable = false;
 				issue_p2p_GO_request(padapter, pwdinfo->nego_req_info.peerDevAddr);
@@ -594,7 +589,6 @@ unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame
 		}
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_INVITE_REQ)) {
 		if (pwdinfo->invitereq_info.benable) {
-			DBG_88E("[%s] P2P_STATE_TX_INVITE_REQ!\n", __func__);
 			if (!memcmp(pwdinfo->invitereq_info.peer_macaddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
 				pwdinfo->invitereq_info.benable = false;
 				issue_p2p_invitation_request(padapter, pwdinfo->invitereq_info.peer_macaddr);
@@ -718,25 +712,18 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
-	DBG_88E("+OnAuth\n");
-
 	sa = GetAddr2Ptr(pframe);
 
 	auth_mode = psecuritypriv->dot11AuthAlgrthm;
 	seq = le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + 2));
 	algorithm = le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN));
 
-	DBG_88E("auth alg=%x, seq=%X\n", algorithm, seq);
-
 	if (auth_mode == 2 && psecuritypriv->dot11PrivacyAlgrthm != _WEP40_ &&
 	    psecuritypriv->dot11PrivacyAlgrthm != _WEP104_)
 		auth_mode = 0;
 
 	if ((algorithm > 0 && auth_mode == 0) ||	/*  rx a shared-key auth but shared not enabled */
 	    (algorithm == 0 && auth_mode == 1)) {	/*  rx a open-system auth but shared-key is enabled */
-		DBG_88E("auth rejected due to bad alg [alg=%d, auth_mib=%d] %02X%02X%02X%02X%02X%02X\n",
-			algorithm, auth_mode, sa[0], sa[1], sa[2], sa[3], sa[4], sa[5]);
-
 		status = _STATS_NO_SUPP_ALG_;
 
 		goto auth_fail;
@@ -750,10 +737,8 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	pstat = rtw_get_stainfo(pstapriv, sa);
 	if (!pstat) {
 		/*  allocate a new one */
-		DBG_88E("going to alloc stainfo for sa=%pM\n", sa);
 		pstat = rtw_alloc_stainfo(pstapriv, sa);
 		if (!pstat) {
-			DBG_88E(" Exceed the upper limit of supported clients...\n");
 			status = _STATS_UNABLE_HANDLE_STA_;
 			goto auth_fail;
 		}
@@ -784,8 +769,6 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 		pstat->expire_to = pstapriv->auth_to;
 
 	if ((pstat->auth_seq + 1) != seq) {
-		DBG_88E("(1)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-			seq, pstat->auth_seq + 1);
 		status = _STATS_OUT_OF_AUTH_SEQ_;
 		goto auth_fail;
 	}
@@ -797,8 +780,6 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			pstat->expire_to = pstapriv->assoc_to;
 			pstat->authalg = algorithm;
 		} else {
-			DBG_88E("(2)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-				seq, pstat->auth_seq + 1);
 			status = _STATS_OUT_OF_AUTH_SEQ_;
 			goto auth_fail;
 		}
@@ -812,13 +793,10 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			pstat->auth_seq = 2;
 		} else if (seq == 3) {
 			/* checking for challenging txt... */
-			DBG_88E("checking for challenging txt...\n");
-
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
 			if (!p || ie_len <= 0) {
-				DBG_88E("auth rejected because challenge failure!(1)\n");
 				status = _STATS_CHALLENGE_FAIL_;
 				goto auth_fail;
 			}
@@ -829,13 +807,10 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 				/*  challenging txt is correct... */
 				pstat->expire_to =  pstapriv->assoc_to;
 			} else {
-				DBG_88E("auth rejected because challenge failure!\n");
 				status = _STATS_CHALLENGE_FAIL_;
 				goto auth_fail;
 			}
 		} else {
-			DBG_88E("(3)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-				seq, pstat->auth_seq + 1);
 			status = _STATS_OUT_OF_AUTH_SEQ_;
 			goto auth_fail;
 		}
@@ -875,8 +850,6 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 	u8 *pframe = precv_frame->rx_data;
 	uint pkt_len = precv_frame->len;
 
-	DBG_88E("%s\n", __func__);
-
 	/* check A1 matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -890,7 +863,6 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 	status	= le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
 	if (status != 0) {
-		DBG_88E("clnt auth fail, status: %d\n", status);
 		if (status == 13) { /*  pmlmeinfo->auth_algo == dot11AuthAlgrthm_Auto) */
 			if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
 				pmlmeinfo->auth_algo = dot11AuthAlgrthm_Open;
@@ -976,11 +948,8 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		ie_offset = _REASOCREQ_IE_OFFSET_;
 	}
 
-	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset) {
-		DBG_88E("handle_assoc(reassoc=%d) - too short payload (len=%lu)"
-		       "\n", reassoc, (unsigned long)pkt_len);
+	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset)
 		return _FAIL;
-	}
 
 	pstat = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 	if (pstat == (struct sta_info *)NULL) {
@@ -993,8 +962,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	left = pkt_len - (IEEE80211_3ADDR_LEN + ie_offset);
 	pos = pframe + (IEEE80211_3ADDR_LEN + ie_offset);
 
-	DBG_88E("%s\n", __func__);
-
 	/*  check if this stat has been successfully authenticated/assocated */
 	if (!((pstat->state) & WIFI_FW_AUTH_SUCCESS)) {
 		if (!((pstat->state) & WIFI_FW_ASSOC_SUCCESS)) {
@@ -1012,8 +979,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	/* now parse all ieee802_11 ie to point to elems */
 	if (rtw_ieee802_11_parse_elems(pos, left, &elems, 1) == ParseFailed ||
 	    !elems.ssid) {
-		DBG_88E("STA %pM sent invalid association request\n",
-			pstat->hwaddr);
 		status = _STATS_FAILURE_;
 		goto OnAssocReqFail;
 	}
@@ -1042,7 +1007,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	/*  check if the supported rate is ok */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SUPPORTEDRATES_IE_, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 	if (!p) {
-		DBG_88E("Rx a sta assoc-req which supported rate is empty!\n");
 		/*  use our own rate set as statoin used */
 		/* memcpy(supportRate, AP_BSSRATE, AP_BSSRATE_LEN); */
 		/* supportRateNum = AP_BSSRATE_LEN; */
@@ -1131,20 +1095,13 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
 	if (!wpa_ie) {
-		if (elems.wps_ie) {
-			DBG_88E("STA included WPS IE in "
-				   "(Re)Association Request - assume WPS is "
-				   "used\n");
+		if (elems.wps_ie)
 			pstat->flags |= WLAN_STA_WPS;
 			/* wpabuf_free(sta->wps_ie); */
 			/* sta->wps_ie = wpabuf_alloc_copy(elems.wps_ie + 4, */
 			/*				elems.wps_ie_len - 4); */
-		} else {
-			DBG_88E("STA did not include WPA/RSN IE "
-				   "in (Re)Association Request - possible WPS "
-				   "use\n");
+		else
 			pstat->flags |= WLAN_STA_MAYBE_WPS;
-		}
 
 		/*  AP support WPA/RSN, and sta is going to do WPS, but AP is not ready */
 		/*  that the selected registrar of AP is _FLASE */
@@ -1155,8 +1112,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 				rtw_get_wps_attr_content(pmlmepriv->wps_beacon_ie, pmlmepriv->wps_beacon_ie_len, WPS_ATTR_SELECTED_REGISTRAR, &selected_registrar, NULL);
 
 				if (!selected_registrar) {
-					DBG_88E("selected_registrar is false , or AP is not ready to do WPS\n");
-
 					status = _STATS_UNABLE_HANDLE_STA_;
 
 					goto OnAssocReqFail;
@@ -1167,18 +1122,12 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		int copy_len;
 
 		if (psecuritypriv->wpa_psk == 0) {
-			DBG_88E("STA %pM: WPA/RSN IE in association "
-			"request, but AP don't support WPA/RSN\n", pstat->hwaddr);
-
 			status = WLAN_STATUS_INVALID_IE;
 
 			goto OnAssocReqFail;
 		}
 
 		if (elems.wps_ie) {
-			DBG_88E("STA included WPS IE in "
-				   "(Re)Association Request - WPS is "
-				   "used\n");
 			pstat->flags |= WLAN_STA_WPS;
 			copy_len = 0;
 		} else {
@@ -1260,16 +1209,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		goto OnAssocReqFail;
 	}
 
-	if ((pstat->flags & WLAN_STA_HT) &&
-	    ((pstat->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
-	    (pstat->wpa_pairwise_cipher & WPA_CIPHER_TKIP))) {
-		DBG_88E("HT: %pM tried to "
-			"use TKIP with HT association\n", pstat->hwaddr);
-
-		/* status = WLAN_STATUS_CIPHER_REJECTED_PER_POLICY; */
-		/* goto OnAssocReqFail; */
-	}
-
 	pstat->flags |= WLAN_STA_NONERP;
 	for (i = 0; i < pstat->bssratelen; i++) {
 		if ((pstat->bssrateset[i] & 0x7f) > 22) {
@@ -1308,9 +1247,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	/*  Customer proprietary IE */
 
 	/* get a unique AID */
-	if (pstat->aid > 0) {
-		DBG_88E("  old AID %d\n", pstat->aid);
-	} else {
+	if (pstat->aid == 0) {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
 			if (!pstapriv->sta_aid[pstat->aid - 1])
 				break;
@@ -1319,14 +1256,11 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		if (pstat->aid > pstapriv->max_num_sta) {
 			pstat->aid = 0;
 
-			DBG_88E("  no room for more AIDs\n");
-
 			status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
 
 			goto OnAssocReqFail;
 		} else {
 			pstapriv->sta_aid[pstat->aid - 1] = pstat;
-			DBG_88E("allocate new AID=(%d)\n", pstat->aid);
 		}
 	}
 
@@ -1361,7 +1295,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 			issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
 
 		/* 2 - report to upper layer */
-		DBG_88E("indicate_sta_join_event to upper layer - hostapd\n");
 		rtw_indicate_sta_assoc_event(padapter, pstat);
 
 		/* 3-(1) report sta add event */
@@ -1400,8 +1333,6 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	u8 *pframe = precv_frame->rx_data;
 	uint pkt_len = precv_frame->len;
 
-	DBG_88E("%s\n", __func__);
-
 	/* check A1 matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -1417,7 +1348,6 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	/* status */
 	status = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 2));
 	if (status > 0) {
-		DBG_88E("assoc reject, status code: %d\n", status);
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		res = -4;
 		goto report_assoc_result;
@@ -1497,8 +1427,6 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
-	DBG_88E("%s Reason code(%d)\n", __func__, reason);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
@@ -1564,8 +1492,6 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
-	DBG_88E("%s Reason code(%d)\n", __func__, reason);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
@@ -1595,7 +1521,6 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 
 unsigned int OnAtim(struct adapter *padapter, struct recv_frame *precv_frame)
 {
-	DBG_88E("%s\n", __func__);
 	return _SUCCESS;
 }
 
@@ -1609,8 +1534,6 @@ unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_f
 	u8 category;
 	u8 action;
 
-	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
-
 	psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 
 	if (!psta)
@@ -1663,8 +1586,6 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
 		return _SUCCESS;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		if (!(pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS))
 			return _SUCCESS;
@@ -1682,7 +1603,6 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 		if (!pmlmeinfo->HT_enable)
 			return _SUCCESS;
 		action = frame_body[1];
-		DBG_88E("%s, action=%d\n", __func__, action);
 		switch (action) {
 		case RTW_WLAN_ACTION_ADDBA_REQ: /* ADDBA request */
 			memcpy(&pmlmeinfo->ADDBA_req, &frame_body[2], sizeof(struct ADDBA_request));
@@ -1697,7 +1617,6 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 			status = get_unaligned_le16(&frame_body[3]);
 			tid = ((frame_body[5] >> 2) & 0x7);
 			if (status == 0) {	/* successful */
-				DBG_88E("agg_enable for TID=%d\n", tid);
 				psta->htpriv.agg_enable_bitmap |= 1 << tid;
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			} else {
@@ -1715,7 +1634,6 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
 			}
-			DBG_88E("%s(): DELBA: %x(%x)\n", __func__, pmlmeinfo->agg_enable_bitmap, reason_code);
 			/* todo: how to notify the host while receiving DELETE BA */
 			break;
 		default:
@@ -1759,7 +1677,6 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	if (!pmgntframe)
 		return;
 
-	DBG_88E("[%s] In\n", __func__);
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
@@ -2095,7 +2012,6 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	if (!pmgntframe)
 		return;
 
-	DBG_88E("[%s] In, result=%d\n", __func__,  result);
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
@@ -2453,7 +2369,6 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	if (!pmgntframe)
 		return;
 
-	DBG_88E("[%s] In\n", __func__);
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
@@ -3053,7 +2968,6 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	if (!pmgntframe)
 		return;
 
-	DBG_88E("[%s] In\n", __func__);
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
@@ -3129,16 +3043,9 @@ static u8 is_matched_in_profilelist(u8 *peermacaddr, struct profile_info *profil
 {
 	u8 i, match_result = 0;
 
-	DBG_88E("[%s] peermac=%.2X %.2X %.2X %.2X %.2X %.2X\n", __func__,
-		peermacaddr[0], peermacaddr[1], peermacaddr[2], peermacaddr[3], peermacaddr[4], peermacaddr[5]);
-
 	for (i = 0; i < P2P_MAX_PERSISTENT_GROUP_NUM; i++, profileinfo++) {
-		DBG_88E("[%s] profileinfo_mac=%.2X %.2X %.2X %.2X %.2X %.2X\n", __func__,
-			profileinfo->peermac[0], profileinfo->peermac[1], profileinfo->peermac[2],
-			profileinfo->peermac[3], profileinfo->peermac[4], profileinfo->peermac[5]);
 		if (!memcmp(peermacaddr, profileinfo->peermac, ETH_ALEN)) {
 			match_result = 1;
-			DBG_88E("[%s] Match!\n", __func__);
 			break;
 		}
 	}
@@ -3689,17 +3596,12 @@ static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 
 	if (GetRetry(frame)) {
 		if (token >= 0) {
-			if ((seq_ctrl == mlmeext->action_public_rxseq) && (token == mlmeext->action_public_dialog_token)) {
-				DBG_88E(FUNC_ADPT_FMT" seq_ctrl = 0x%x, rxseq = 0x%x, token:%d\n",
-					FUNC_ADPT_ARG(adapter), seq_ctrl, mlmeext->action_public_rxseq, token);
+			if ((seq_ctrl == mlmeext->action_public_rxseq) &&
+			    (token == mlmeext->action_public_dialog_token))
 				return _FAIL;
-			}
 		} else {
-			if (seq_ctrl == mlmeext->action_public_rxseq) {
-				DBG_88E(FUNC_ADPT_FMT" seq_ctrl = 0x%x, rxseq = 0x%x\n",
-					FUNC_ADPT_ARG(adapter), seq_ctrl, mlmeext->action_public_rxseq);
+			if (seq_ctrl == mlmeext->action_public_rxseq)
 				return _FAIL;
-			}
 		}
 	}
 
@@ -3740,7 +3642,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 
 	switch (frame_body[6]) { /* OUI Subtype */
 	case P2P_GO_NEGO_REQ:
-		DBG_88E("[%s] Got GO Nego Req Frame\n", __func__);
 		memset(&pwdinfo->groupid_info, 0x00, sizeof(struct group_id_info));
 
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_RX_PROVISION_DIS_REQ))
@@ -3752,7 +3653,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 			_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
 			/*	Restore the previous p2p state */
 			rtw_p2p_set_state(pwdinfo, rtw_p2p_pre_state(pwdinfo));
-			DBG_88E("[%s] Restore the previous p2p state to %d\n", __func__, rtw_p2p_state(pwdinfo));
 		}
 
 		/*	Commented by Kurt 20110902 */
@@ -3773,8 +3673,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		_set_timer(&pwdinfo->restore_p2p_state_timer, 5000);
 		break;
 	case P2P_GO_NEGO_RESP:
-		DBG_88E("[%s] Got GO Nego Resp Frame\n", __func__);
-
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_ING)) {
 			/*	Commented by Albert 20110425 */
 			/*	The restore timer is enabled when issuing the nego request frame of rtw_p2p_connect function. */
@@ -3793,12 +3691,9 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 			pwdinfo->negotiation_dialog_token = 1;
 			if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_FAIL))
 				_set_timer(&pwdinfo->restore_p2p_state_timer, 5000);
-		} else {
-			DBG_88E("[%s] Skipped GO Nego Resp Frame (p2p_state != P2P_STATE_GONEGO_ING)\n", __func__);
 		}
 		break;
 	case P2P_GO_NEGO_CONF:
-		DBG_88E("[%s] Got GO Nego Confirm Frame\n", __func__);
 		result = process_p2p_group_negotation_confirm(pwdinfo, frame_body, len);
 		if (P2P_STATUS_SUCCESS == result) {
 			if (rtw_p2p_role(pwdinfo) == P2P_ROLE_CLIENT) {
@@ -3812,7 +3707,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		/*	Added by Albert 2010/10/05 */
 		/*	Received the P2P Invite Request frame. */
 
-		DBG_88E("[%s] Got invite request frame!\n", __func__);
 		p2p_ie = rtw_get_p2p_ie(frame_body + _PUBLIC_ACTION_IE_OFFSET_, len - _PUBLIC_ACTION_IE_OFFSET_, NULL, &p2p_ielen);
 		if (p2p_ie) {
 			/*	Parse the necessary information from the P2P Invitation Request frame. */
@@ -3831,13 +3725,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 				/*	#> iwpriv wlan0 p2p_get peer_ifa */
 				/*	After having the peer interface address, the sigma can find the correct conf file for wpa_supplicant. */
 
-				if (attr_contentlen) {
-					DBG_88E("[%s] GO's BSSID = %.2X %.2X %.2X %.2X %.2X %.2X\n", __func__,
-						pwdinfo->p2p_peer_interface_addr[0], pwdinfo->p2p_peer_interface_addr[1],
-						pwdinfo->p2p_peer_interface_addr[2], pwdinfo->p2p_peer_interface_addr[3],
-						pwdinfo->p2p_peer_interface_addr[4], pwdinfo->p2p_peer_interface_addr[5]);
-				}
-
 				if (invitation_flag & P2P_INVITATION_FLAGS_PERSISTENT) {
 					/*	Re-invoke the persistent group. */
 
@@ -3883,7 +3770,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 							}
 						}
 					} else {
-						DBG_88E("[%s] P2P Group ID Attribute NOT FOUND!\n", __func__);
 						status_code = P2P_STATUS_FAIL_INFO_UNAVAILABLE;
 					}
 				} else {
@@ -3909,17 +3795,13 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 							status_code = P2P_STATUS_SUCCESS;
 						}
 					} else {
-						DBG_88E("[%s] P2P Group ID Attribute NOT FOUND!\n", __func__);
 						status_code = P2P_STATUS_FAIL_INFO_UNAVAILABLE;
 					}
 				}
 			} else {
-				DBG_88E("[%s] P2P Invitation Flags Attribute NOT FOUND!\n", __func__);
 				status_code = P2P_STATUS_FAIL_INFO_UNAVAILABLE;
 			}
 
-			DBG_88E("[%s] status_code = %d\n", __func__, status_code);
-
 			pwdinfo->inviteresp_info.token = frame_body[7];
 			issue_p2p_invitation_response(padapter, GetAddr2Ptr(pframe), pwdinfo->inviteresp_info.token, status_code);
 		}
@@ -3928,14 +3810,12 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		u8	attr_content = 0x00;
 		u32	attr_contentlen = 0;
 
-		DBG_88E("[%s] Got invite response frame!\n", __func__);
 		_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
 		p2p_ie = rtw_get_p2p_ie(frame_body + _PUBLIC_ACTION_IE_OFFSET_, len - _PUBLIC_ACTION_IE_OFFSET_, NULL, &p2p_ielen);
 		if (p2p_ie) {
 			rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_STATUS, &attr_content, &attr_contentlen);
 
 			if (attr_contentlen == 1) {
-				DBG_88E("[%s] Status = %d\n", __func__, attr_content);
 				pwdinfo->invitereq_info.benable = false;
 
 				if (attr_content == P2P_STATUS_SUCCESS) {
@@ -3969,7 +3849,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		process_p2p_devdisc_resp(pwdinfo, pframe, len);
 		break;
 	case P2P_PROVISION_DISC_REQ:
-		DBG_88E("[%s] Got Provisioning Discovery Request Frame\n", __func__);
 		process_p2p_provdisc_req(pwdinfo, pframe, len);
 		memcpy(pwdinfo->rx_prov_disc_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN);
 
@@ -3984,7 +3863,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	case P2P_PROVISION_DISC_RESP:
 		/*	Commented by Albert 20110707 */
 		/*	Should we check the pwdinfo->tx_prov_disc_info.bsent flag here?? */
-		DBG_88E("[%s] Got Provisioning Discovery Response Frame\n", __func__);
 		/*	Commented by Albert 20110426 */
 		/*	The restore timer is enabled when issuing the provisioing request frame in rtw_p2p_prov_disc function. */
 		_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
@@ -4075,8 +3953,6 @@ unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fra
 	uint len = precv_frame->len;
 	struct	wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("%s\n", __func__);
-
 	/* check RA matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
 		return _SUCCESS;
@@ -4140,14 +4016,11 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 	struct xmit_buf				*pxmitbuf;
 
 	pmgntframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (!pmgntframe) {
-		DBG_88E("%s, alloc xmitframe fail\n", __func__);
+	if (!pmgntframe)
 		return NULL;
-	}
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
 	if (!pxmitbuf) {
-		DBG_88E("%s, alloc xmitbuf fail\n", __func__);
 		rtw_free_xmitframe(pxmitpriv, pmgntframe);
 		return NULL;
 	}
@@ -4169,7 +4042,6 @@ void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 
 	pmlmeext->tx_rate = rate;
-	DBG_88E("%s(): rate = %x\n", __func__, rate);
 }
 
 void update_mgntframe_attrib(struct adapter *padapter, struct pkt_attrib *pattrib)
@@ -4305,10 +4177,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (!pmgntframe) {
-		DBG_88E("%s, alloc mgnt frame fail\n", __func__);
+	if (!pmgntframe)
 		return;
-	}
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
 
 	/* update attribute */
@@ -4488,14 +4358,11 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
 
-	if ((pattrib->pktlen + TXDESC_SIZE) > 512) {
-		DBG_88E("beacon frame too large\n");
+	if ((pattrib->pktlen + TXDESC_SIZE) > 512)
 		return;
-	}
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	/* DBG_88E("issue bcn_sz=%d\n", pattrib->last_txcmdsz); */
 	if (timeout_ms > 0)
 		dump_mgntframe_and_wait(padapter, pmgntframe, timeout_ms);
 	else
@@ -4521,10 +4388,8 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (!pmgntframe) {
-		DBG_88E("%s, alloc mgnt frame fail\n", __func__);
+	if (!pmgntframe)
 		return;
-	}
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -4748,7 +4613,6 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 {
 	int ret;
 	int i = 0;
-	u32 start = jiffies;
 
 	do {
 		ret = _issue_probereq(padapter, pssid, da, wait_ms > 0);
@@ -4767,17 +4631,6 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
-		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
-	}
 exit:
 	return ret;
 }
@@ -4906,7 +4759,6 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	rtw_wep_encrypt(padapter, pmgntframe);
-	DBG_88E("%s\n", __func__);
 	dump_mgntframe(padapter, pmgntframe);
 }
 
@@ -4927,8 +4779,6 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	__le16 lestatus, leval;
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("%s\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		return;
@@ -5115,7 +4965,6 @@ void issue_assocreq(struct adapter *padapter)
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
 		if (pmlmeinfo->network.SupportedRates[i] == 0)
 			break;
-		DBG_88E("network.SupportedRates[%d]=%02X\n", i, pmlmeinfo->network.SupportedRates[i]);
 	}
 
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
@@ -5130,17 +4979,12 @@ void issue_assocreq(struct adapter *padapter)
 				break;
 		}
 
-		if (j == sta_bssrate_len) {
-			/*  the rate is not supported by STA */
-			DBG_88E("%s(): the rate[%d]=%02X is not supported by STA!\n", __func__, i, pmlmeinfo->network.SupportedRates[i]);
-		} else {
+		if (j != sta_bssrate_len)
 			/*  the rate is supported by STA */
 			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
-		}
 	}
 
 	bssrate_len = index;
-	DBG_88E("bssrate_len=%d\n", bssrate_len);
 
 	if (bssrate_len == 0) {
 		rtw_free_xmitbuf(pxmitpriv, pmgntframe->pxmitbuf);
@@ -5425,7 +5269,6 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 {
 	int ret;
 	int i = 0;
-	u32 start = jiffies;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
@@ -5449,17 +5292,6 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
-		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
-	}
 exit:
 	return ret;
 }
@@ -5478,8 +5310,6 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	DBG_88E("%s\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		goto exit;
@@ -5545,7 +5375,6 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 {
 	int ret;
 	int i = 0;
-	u32 start = jiffies;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
@@ -5569,17 +5398,6 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
-		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
-	}
 exit:
 	return ret;
 }
@@ -5649,7 +5467,6 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 
 int issue_deauth(struct adapter *padapter, unsigned char *da, unsigned short reason)
 {
-	DBG_88E("%s to %pM\n", __func__, da);
 	return _issue_deauth(padapter, da, reason, false);
 }
 
@@ -5658,7 +5475,6 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 {
 	int ret;
 	int i = 0;
-	u32 start = jiffies;
 
 	do {
 		ret = _issue_deauth(padapter, da, reason, wait_ms > 0);
@@ -5676,17 +5492,6 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
-		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
-	}
 exit:
 	return ret;
 }
@@ -5713,8 +5518,6 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct registry_priv *pregpriv = &padapter->registrypriv;
 
-	DBG_88E("%s, category=%d, action=%d, status=%d\n", __func__, category, action, status);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		return;
@@ -5766,8 +5569,6 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			if (psta) {
 				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07] & 0xfff) + 1;
 
-				DBG_88E("BA_starting_seqctrl=%d for TID=%d\n", start_seq, status & 0x07);
-
 				psta->BA_starting_seqctrl[status & 0x07] = start_seq;
 
 				BA_starting_seqctrl = start_seq << 4;
@@ -5849,8 +5650,6 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	if (pmlmeinfo->bwmode_updated)
 		return;
 
-	DBG_88E("%s\n", __func__);
-
 	category = RTW_WLAN_CATEGORY_PUBLIC;
 	action = ACT_PUBLIC_BSSCOEXIST;
 
@@ -5975,7 +5774,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	if (initiator == 0) { /*  recipient */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
-				DBG_88E("rx agg disable tid(%d)\n", tid);
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
@@ -5984,7 +5782,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	} else if (initiator == 1) { /*  originator */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
-				DBG_88E("tx agg disable tid(%d)\n", tid);
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
@@ -6001,8 +5798,6 @@ unsigned int send_beacon(struct adapter *padapter)
 	int	issue = 0;
 	int poll = 0;
 
-	u32 start = jiffies;
-
 	SetHwReg8188EU(padapter, HW_VAR_BCN_VALID, NULL);
 	do {
 		issue_beacon(padapter, 100);
@@ -6017,13 +5812,8 @@ unsigned int send_beacon(struct adapter *padapter)
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return _FAIL;
 	if (!bxmitok) {
-		DBG_88E("%s fail! %u ms\n", __func__, rtw_get_passing_time_ms(start));
 		return _FAIL;
 	} else {
-		u32 passing_time = rtw_get_passing_time_ms(start);
-
-		if (passing_time > 100 || issue > 3)
-			DBG_88E("%s success, issue:%d, poll:%d, %u ms\n", __func__, issue, poll, rtw_get_passing_time_ms(start));
 		return _SUCCESS;
 	}
 }
@@ -6231,16 +6021,12 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
-	if (!p) {
-		DBG_88E("marc: cannot find SSID for survey event\n");
+	if (!p)
 		return _FAIL;
-	}
 
 	if (*(p + 1)) {
-		if (len > NDIS_802_11_LENGTH_SSID) {
-			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
+		if (len > NDIS_802_11_LENGTH_SSID)
 			return _FAIL;
-		}
 		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
 		bssid->Ssid.SsidLength = *(p + 1);
 	} else {
@@ -6253,20 +6039,16 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	i = 0;
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
-		if (len > NDIS_802_11_LENGTH_RATES_EX) {
-			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
+		if (len > NDIS_802_11_LENGTH_RATES_EX)
 			return _FAIL;
-		}
 		memcpy(bssid->SupportedRates, (p + 2), len);
 		i = len;
 	}
 
 	p = rtw_get_ie(bssid->IEs + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
-		if (len > (NDIS_802_11_LENGTH_RATES_EX - i)) {
-			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
+		if (len > (NDIS_802_11_LENGTH_RATES_EX - i))
 			return _FAIL;
-		}
 		memcpy(bssid->SupportedRates + i, (p + 2), len);
 	}
 
@@ -6381,7 +6163,6 @@ void start_create_ibss(struct adapter *padapter)
 			rtw_indicate_connect(padapter);
 		}
 	} else {
-		DBG_88E("start_create_ibss, invalid cap:%x\n", caps);
 		return;
 	}
 	/* update bc/mc sta_info */
@@ -6495,8 +6276,6 @@ unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr
 	if (!(!memcmp(MacAddr, get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
 		return _SUCCESS;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
@@ -6754,8 +6533,6 @@ void report_surveydone_event(struct adapter *padapter)
 	psurveydone_evt = (struct surveydone_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	psurveydone_evt->bss_cnt = pmlmeext->sitesurvey_res.bss_cnt;
 
-	DBG_88E("survey done event(%x)\n", psurveydone_evt->bss_cnt);
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -6800,8 +6577,6 @@ void report_join_res(struct adapter *padapter, int res)
 	pjoinbss_evt->network.join_res	= res;
 	pjoinbss_evt->network.aid = res;
 
-	DBG_88E("report_join_res(%d)\n", res);
-
 	rtw_joinbss_event_prehandle(padapter, (u8 *)&pjoinbss_evt->network);
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
@@ -6856,8 +6631,6 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 
 	pdel_sta_evt->mac_id = mac_id;
 
-	DBG_88E("report_del_sta_event: delete STA, mac_id =%d\n", mac_id);
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -6900,8 +6673,6 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	memcpy((unsigned char *)(&padd_sta_evt->macaddr), MacAddr, ETH_ALEN);
 	padd_sta_evt->cam_id = cam_idx;
 
-	DBG_88E("report_add_sta_event: add STA\n");
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -6970,7 +6741,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 		/* restore to initial setting. */
 		update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
 
-		goto exit_mlmeext_joinbss_event_callback;
+		return;
 	}
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
@@ -7026,10 +6797,6 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 		correct_TSF(padapter, pmlmeext);
 	}
 	rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_CONNECT, 0);
-
-exit_mlmeext_joinbss_event_callback:
-
-	DBG_88E("=>%s\n", __func__);
 }
 
 void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *psta)
@@ -7038,8 +6805,6 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 join_type;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {/* adhoc master or sta_count>1 */
 			/* nothing to do */
@@ -7119,7 +6884,6 @@ static void _linked_rx_signal_strength_display(struct adapter *padapter)
 	GetHalDefVar8188EUsb(padapter, HW_DEF_RA_INFO_DUMP, &mac_id);
 
 	GetHalDefVar8188EUsb(padapter, HAL_DEF_UNDERCORATEDSMOOTHEDPWDB, &UndecoratedSmoothedPWDB);
-	DBG_88E("UndecoratedSmoothedPWDB:%d\n", UndecoratedSmoothedPWDB);
 }
 
 static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
@@ -7141,18 +6905,11 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 static void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
 {
 	u32 rx_dma_status =  rtw_read32(padapter, REG_RXDMA_STATUS);
-	u8 fw_status;
 
-	if (rx_dma_status != 0x00) {
-		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
+	if (rx_dma_status != 0x00)
 		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
-	}
 
-	fw_status = rtw_read8(padapter, REG_FMETHR);
-	if (fw_status == 1)
-		DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
-	else if (fw_status == 2)
-		DBG_88E("%s REG_FW_STATUS (0x%02x), Condition_No_Match !!\n", __func__, fw_status);
+	rtw_read8(padapter, REG_FMETHR);
 }
 
 void linked_status_chk(struct adapter *padapter)
@@ -7286,15 +7043,8 @@ void survey_timer_hdl(struct adapter *padapter)
 			if (!rtw_p2p_chk_state(&padapter->wdinfo, P2P_STATE_NONE)) {
 				rtw_p2p_findphase_ex_set(pwdinfo, P2P_FINDPHASE_EX_MAX);
 				pmlmeext->sitesurvey_res.channel_idx = 3;
-				DBG_88E("%s idx:%d, cnt:%u\n", __func__
-					, pmlmeext->sitesurvey_res.channel_idx
-					, pwdinfo->find_phase_state_exchange_cnt
-			);
 			} else {
 				pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
-				DBG_88E("%s idx:%d\n", __func__
-					, pmlmeext->sitesurvey_res.channel_idx
-			);
 			}
 
 			pmlmeext->scan_abort = false;/* reset */
@@ -7324,7 +7074,6 @@ void link_timer_hdl(struct adapter *padapter)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
-		DBG_88E("link_timer_hdl:no beacon while connecting\n");
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		report_join_res(padapter, -3);
 	} else if (pmlmeinfo->state & WIFI_FW_AUTH_STATE) {
@@ -7335,7 +7084,6 @@ void link_timer_hdl(struct adapter *padapter)
 			return;
 		}
 
-		DBG_88E("link_timer_hdl: auth timeout and try again\n");
 		pmlmeinfo->auth_seq = 1;
 		issue_auth(padapter, NULL, 0);
 		set_link_timer(pmlmeext, REAUTH_TO);
@@ -7347,7 +7095,6 @@ void link_timer_hdl(struct adapter *padapter)
 			return;
 		}
 
-		DBG_88E("link_timer_hdl: assoc timeout and try again\n");
 		issue_assocreq(padapter);
 		set_link_timer(pmlmeext, REASSOC_TO);
 	}
@@ -7536,9 +7283,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 					default:
 						pmlmeext->cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 						break;
-				}
-
-					DBG_88E("set ch/bw before connected\n");
+					}
 				}
 			}
 			break;
@@ -7791,24 +7536,15 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 		if (psta) {
 			ctrl = (BIT(15) | ((pparm->algorithm) << 2));
 
-			DBG_88E("r871x_set_stakey_hdl(): enc_algorithm=%d\n", pparm->algorithm);
-
-			if ((psta->mac_id < 1) || (psta->mac_id > (NUM_STA - 4))) {
-				DBG_88E("r871x_set_stakey_hdl():set_stakey failed, mac_id(aid)=%d\n", psta->mac_id);
+			if ((psta->mac_id < 1) || (psta->mac_id > (NUM_STA - 4)))
 				return H2C_REJECTED;
-			}
 
 			cam_id = (psta->mac_id + 3);/* 0~3 for default key, cmd_id = macid + 3, macid = aid+1; */
 
-			DBG_88E("Write CAM, mac_addr =%x:%x:%x:%x:%x:%x, cam_entry=%d\n", pparm->addr[0],
-				pparm->addr[1], pparm->addr[2], pparm->addr[3], pparm->addr[4],
-				pparm->addr[5], cam_id);
-
 			write_cam(padapter, cam_id, ctrl, pparm->addr, pparm->key);
 
 			return H2C_SUCCESS_RSP;
 		} else {
-			DBG_88E("r871x_set_stakey_hdl(): sta has been free\n");
 			return H2C_REJECTED;
 		}
 	}
@@ -7932,7 +7668,6 @@ u8 h2c_msg_hdl(struct adapter *padapter, unsigned char *pbuf)
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	if (send_beacon(padapter) == _FAIL) {
-		DBG_88E("issue_beacon, fail!\n");
 		return H2C_PARAMETERS_ERROR;
 	} else {
 		/* tx bc/mc frames after update TIM */
@@ -7991,10 +7726,6 @@ u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf)
 
 	set_ch_parm = (struct set_ch_parm *)pbuf;
 
-	DBG_88E(FUNC_NDEV_FMT" ch:%u, bw:%u, ch_offset:%u\n",
-		FUNC_NDEV_ARG(padapter->pnetdev),
-		set_ch_parm->ch, set_ch_parm->bw, set_ch_parm->ch_offset);
-
 	pmlmeext->cur_channel = set_ch_parm->ch;
 	pmlmeext->cur_ch_offset = set_ch_parm->ch_offset;
 	pmlmeext->cur_bwmode = set_ch_parm->bw;
-- 
2.34.1

