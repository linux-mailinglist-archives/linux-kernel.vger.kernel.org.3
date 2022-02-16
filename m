Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E2A4B7C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245302AbiBPBHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:07:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbiBPBH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:28 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC9AC6836
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:15 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n8so279326wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFGZy8ThiinWc6PWDmNQOV91AZCSxdikWfRq8CGSK00=;
        b=Oe2VFX5a6VqbAuMSKGTApfHHupl6ZEn5YQw19VEKcImEoPsXlEKA/k6+aUOa3qmy4F
         balWvWdXFxyjcnnDeYfODF0iFpo+1jaxOXSqqWlHoPRsqqW/Kk6ThtOCZFchYB+/RhTb
         Gh8HtjMyBW2pMX1xGIRtzFRKi9LWlNnjcp3C21P/Cmu9L4ql9nfD1jLAp2AhhQk9FQyP
         NgxM27Lz/OwIr0jai+iVY41yqQJ9XyC70WifyJdIb/kIOLqg2R2/qCFqde4HHSZER+c3
         oynpYnwekbQA+5ddJiIH4fII3vazsja+Tbc1fDr1/Ib9E3p1XXGih0AwouGpAuhKnYuD
         /Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFGZy8ThiinWc6PWDmNQOV91AZCSxdikWfRq8CGSK00=;
        b=AdtVnV8MAkJECn0hdzxA0Zw9xZk1CRMzSjwiylvaumxY9pvzp5iZbuNUVT0sjLcDTM
         OA/H+lc0d2zQsxKtdejMAXvfX2B3k5RvNcDvJS4M4FnJ+A24ByXHwx3468AUWCDYzSOA
         ItJiZ3u9DiF1+3xlU71ob5J1Hh1ktZcK7xT7xMp9xLSnh8CLMmBUbwUl/naLCztWVl6o
         uvyL2sziImCTlpfuiLSgsfAuHP5y+xPK2ymkKLxQAVzEKnbiij6XdvsVPDAQgf8Ef4mp
         /SiT748YvOzj1ZaDIrPIyAHfCPyXcNNHIUGxBf0hDhlZrwaxDGxmY0J8ia8KIHi+CcgR
         XE3A==
X-Gm-Message-State: AOAM531W+4nAyBgPGHsGmcigxhwy/Njfhg0f/fYkJIGIocGFslRUwUIN
        GolmzelM9zJgiH3Dxg9wJXHa/Q==
X-Google-Smtp-Source: ABdhPJwnRGXg/YuN9GT9HiMROuMm2eOXpmJFagCEuw3EiTFwXnVKd6Q1Q8v+dQ8CJsW7PaliUOZPwQ==
X-Received: by 2002:a1c:7419:0:b0:37b:b96e:81a6 with SMTP id p25-20020a1c7419000000b0037bb96e81a6mr5237404wmc.8.1644973633434;
        Tue, 15 Feb 2022 17:07:13 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:12 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 03/15] staging: r8188eu: remove converted DBG_88E calls from core/rtw_mlme_ext.c
Date:   Wed, 16 Feb 2022 01:06:57 +0000
Message-Id: <20220216010709.791-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216010709.791-1-phil@philpotter.co.uk>
References: <20220216010709.791-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all the netdev_dbg/pr_debug calls that were previously converted
from DBG_88E inside core/rtw_mlme_ext.c. Due to the sheer number of
lines, this patch is separated out for ease of review. After some thought,
it makes more sense to just entirely strip all of these calls, so that
debugging code in the driver can be more consistent and useful going
forwards.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 283 +-------------------
 1 file changed, 14 insertions(+), 269 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 6c354383c1d2..4c557c279818 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -315,9 +315,6 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 	memset(channel_set, 0, sizeof(struct rt_channel_info) * MAX_CHANNEL_NUM);
 
 	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE) {
-		netdev_dbg(padapter->pnetdev,
-			   "ChannelPlan ID %x error !!!!!\n",
-			   ChannelPlan);
 		return chanset_size;
 	}
 
@@ -438,9 +435,6 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 		if (GetRetry(pframe)) {
 			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum) {
 				/* drop the duplicate management frame */
-				netdev_dbg(padapter->pnetdev,
-					   "Drop duplicate management frame with seq_num=%d.\n",
-					   precv_frame->attrib.seq_num);
 				return;
 			}
 		}
@@ -577,8 +571,6 @@ unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame
 		return _SUCCESS;
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_ING)) {
 		if (pwdinfo->nego_req_info.benable) {
-			netdev_dbg(padapter->pnetdev,
-				   "P2P State is GONEGO ING!\n");
 			if (!memcmp(pwdinfo->nego_req_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
 				pwdinfo->nego_req_info.benable = false;
 				issue_p2p_GO_request(padapter, pwdinfo->nego_req_info.peerDevAddr);
@@ -586,8 +578,6 @@ unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame
 		}
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_INVITE_REQ)) {
 		if (pwdinfo->invitereq_info.benable) {
-			netdev_dbg(padapter->pnetdev,
-				   "P2P_STATE_TX_INVITE_REQ!\n");
 			if (!memcmp(pwdinfo->invitereq_info.peer_macaddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
 				pwdinfo->invitereq_info.benable = false;
 				issue_p2p_invitation_request(padapter, pwdinfo->invitereq_info.peer_macaddr);
@@ -717,17 +707,12 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	seq = le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + 2));
 	algorithm = le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN));
 
-	netdev_dbg(padapter->pnetdev, "auth alg=%x, seq=%X\n", algorithm, seq);
-
 	if (auth_mode == 2 && psecuritypriv->dot11PrivacyAlgrthm != _WEP40_ &&
 	    psecuritypriv->dot11PrivacyAlgrthm != _WEP104_)
 		auth_mode = 0;
 
 	if ((algorithm > 0 && auth_mode == 0) ||	/*  rx a shared-key auth but shared not enabled */
 	    (algorithm == 0 && auth_mode == 1)) {	/*  rx a open-system auth but shared-key is enabled */
-		netdev_dbg(padapter->pnetdev,
-			   "auth rejected due to bad alg [alg=%d, auth_mib=%d] %02X%02X%02X%02X%02X%02X\n",
-			   algorithm, auth_mode, sa[0], sa[1], sa[2], sa[3], sa[4], sa[5]);
 
 		status = _STATS_NO_SUPP_ALG_;
 
@@ -742,12 +727,8 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	pstat = rtw_get_stainfo(pstapriv, sa);
 	if (!pstat) {
 		/*  allocate a new one */
-		netdev_dbg(padapter->pnetdev,
-			   "going to alloc stainfo for sa=%pM\n", sa);
 		pstat = rtw_alloc_stainfo(pstapriv, sa);
 		if (!pstat) {
-			netdev_dbg(padapter->pnetdev,
-				   "Exceed the upper limit of supported clients...\n");
 			status = _STATS_UNABLE_HANDLE_STA_;
 			goto auth_fail;
 		}
@@ -778,9 +759,6 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 		pstat->expire_to = pstapriv->auth_to;
 
 	if ((pstat->auth_seq + 1) != seq) {
-		netdev_dbg(padapter->pnetdev,
-			   "(1)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-			   seq, pstat->auth_seq + 1);
 		status = _STATS_OUT_OF_AUTH_SEQ_;
 		goto auth_fail;
 	}
@@ -792,9 +770,6 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			pstat->expire_to = pstapriv->assoc_to;
 			pstat->authalg = algorithm;
 		} else {
-			netdev_dbg(padapter->pnetdev,
-				   "(2)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-				   seq, pstat->auth_seq + 1);
 			status = _STATS_OUT_OF_AUTH_SEQ_;
 			goto auth_fail;
 		}
@@ -808,14 +783,11 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			pstat->auth_seq = 2;
 		} else if (seq == 3) {
 			/* checking for challenging txt... */
-			netdev_dbg(padapter->pnetdev, "checking for challenging txt...\n");
 
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
 			if (!p || ie_len <= 0) {
-				netdev_dbg(padapter->pnetdev,
-					   "auth rejected because challenge failure!(1)\n");
 				status = _STATS_CHALLENGE_FAIL_;
 				goto auth_fail;
 			}
@@ -826,15 +798,10 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 				/*  challenging txt is correct... */
 				pstat->expire_to =  pstapriv->assoc_to;
 			} else {
-				netdev_dbg(padapter->pnetdev,
-					   "auth rejected because challenge failure!\n");
 				status = _STATS_CHALLENGE_FAIL_;
 				goto auth_fail;
 			}
 		} else {
-			netdev_dbg(padapter->pnetdev,
-				   "(3)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-				   seq, pstat->auth_seq + 1);
 			status = _STATS_OUT_OF_AUTH_SEQ_;
 			goto auth_fail;
 		}
@@ -887,8 +854,6 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 	status	= le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
 	if (status != 0) {
-		netdev_dbg(padapter->pnetdev,
-			   "clnt auth fail, status: %d\n", status);
 		if (status == 13) { /*  pmlmeinfo->auth_algo == dot11AuthAlgrthm_Auto) */
 			if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
 				pmlmeinfo->auth_algo = dot11AuthAlgrthm_Open;
@@ -942,7 +907,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	u16 capab_info;
 	struct rtw_ieee802_11_elems elems;
 	struct sta_info	*pstat;
-	unsigned char		reassoc, *p, *pos, *wpa_ie;
+	unsigned char		*p, *pos, *wpa_ie;
 	unsigned char WMM_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
 	int		i, ie_len, wpa_ie_len, left;
 	unsigned char		supportRate[16];
@@ -967,17 +932,12 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 	frame_type = GetFrameSubType(pframe);
 	if (frame_type == WIFI_ASSOCREQ) {
-		reassoc = 0;
 		ie_offset = _ASOCREQ_IE_OFFSET_;
 	} else { /*  WIFI_REASSOCREQ */
-		reassoc = 1;
 		ie_offset = _REASOCREQ_IE_OFFSET_;
 	}
 
 	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset) {
-		netdev_dbg(padapter->pnetdev,
-			   "handle_assoc(reassoc=%d) - too short payload (len=%lu)\n",
-			   reassoc, (unsigned long)pkt_len);
 		return _FAIL;
 	}
 
@@ -1009,9 +969,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	/* now parse all ieee802_11 ie to point to elems */
 	if (rtw_ieee802_11_parse_elems(pos, left, &elems, 1) == ParseFailed ||
 	    !elems.ssid) {
-		netdev_dbg(padapter->pnetdev,
-			   "STA %pM sent invalid association request\n",
-			   pstat->hwaddr);
 		status = _STATS_FAILURE_;
 		goto OnAssocReqFail;
 	}
@@ -1040,8 +997,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	/*  check if the supported rate is ok */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SUPPORTEDRATES_IE_, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 	if (!p) {
-		netdev_dbg(padapter->pnetdev,
-			   "Rx a sta assoc-req which supported rate is empty!\n");
 		/*  use our own rate set as statoin used */
 		/* memcpy(supportRate, AP_BSSRATE, AP_BSSRATE_LEN); */
 		/* supportRateNum = AP_BSSRATE_LEN; */
@@ -1131,15 +1086,11 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
 	if (!wpa_ie) {
 		if (elems.wps_ie) {
-			netdev_dbg(padapter->pnetdev,
-				   "STA included WPS IE in (Re)Association Request - assume WPS is used\n");
 			pstat->flags |= WLAN_STA_WPS;
 			/* wpabuf_free(sta->wps_ie); */
 			/* sta->wps_ie = wpabuf_alloc_copy(elems.wps_ie + 4, */
 			/*				elems.wps_ie_len - 4); */
 		} else {
-			netdev_dbg(padapter->pnetdev,
-				   "STA did not include WPA/RSN IE in (Re)Association Request - possible WPS use\n");
 			pstat->flags |= WLAN_STA_MAYBE_WPS;
 		}
 
@@ -1152,8 +1103,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 				rtw_get_wps_attr_content(pmlmepriv->wps_beacon_ie, pmlmepriv->wps_beacon_ie_len, WPS_ATTR_SELECTED_REGISTRAR, &selected_registrar, NULL);
 
 				if (!selected_registrar) {
-					netdev_dbg(padapter->pnetdev,
-						   "selected_registrar is false , or AP is not ready to do WPS\n");
 
 					status = _STATS_UNABLE_HANDLE_STA_;
 
@@ -1165,9 +1114,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		int copy_len;
 
 		if (psecuritypriv->wpa_psk == 0) {
-			netdev_dbg(padapter->pnetdev,
-				   "STA %pM: WPA/RSN IE in association request, but AP don't support WPA/RSN\n",
-				   pstat->hwaddr);
 
 			status = WLAN_STATUS_INVALID_IE;
 
@@ -1175,8 +1121,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		}
 
 		if (elems.wps_ie) {
-			netdev_dbg(padapter->pnetdev,
-				   "STA included WPS IE in (Re)Association Request - WPS is used\n");
 			pstat->flags |= WLAN_STA_WPS;
 			copy_len = 0;
 		} else {
@@ -1261,9 +1205,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	if ((pstat->flags & WLAN_STA_HT) &&
 	    ((pstat->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
 	    (pstat->wpa_pairwise_cipher & WPA_CIPHER_TKIP))) {
-		netdev_dbg(padapter->pnetdev,
-			   "HT: %pM tried to use TKIP with HT association\n",
-			   pstat->hwaddr);
 
 		/* status = WLAN_STATUS_CIPHER_REJECTED_PER_POLICY; */
 		/* goto OnAssocReqFail; */
@@ -1308,7 +1249,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 	/* get a unique AID */
 	if (pstat->aid > 0) {
-		netdev_dbg(padapter->pnetdev, "old AID %d\n", pstat->aid);
 	} else {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
 			if (!pstapriv->sta_aid[pstat->aid - 1])
@@ -1318,16 +1258,11 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		if (pstat->aid > pstapriv->max_num_sta) {
 			pstat->aid = 0;
 
-			netdev_dbg(padapter->pnetdev,
-				   "no room for more AIDs\n");
-
 			status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
 
 			goto OnAssocReqFail;
 		} else {
 			pstapriv->sta_aid[pstat->aid - 1] = pstat;
-			netdev_dbg(padapter->pnetdev,
-				   "allocate new AID=(%d)\n", pstat->aid);
 		}
 	}
 
@@ -1362,8 +1297,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 			issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
 
 		/* 2 - report to upper layer */
-		netdev_dbg(padapter->pnetdev,
-			   "indicate_sta_join_event to upper layer - hostapd\n");
 		rtw_indicate_sta_assoc_event(padapter, pstat);
 
 		/* 3-(1) report sta add event */
@@ -1417,8 +1350,6 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	/* status */
 	status = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 2));
 	if (status > 0) {
-		netdev_dbg(padapter->pnetdev,
-			   "assoc reject, status code: %d\n", status);
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		res = -4;
 		goto report_assoc_result;
@@ -1498,8 +1429,6 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
-	netdev_dbg(padapter->pnetdev, "Reason code(%d)\n", reason);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
@@ -1565,8 +1494,6 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
-	netdev_dbg(padapter->pnetdev, "Reason code(%d)\n", reason);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
@@ -1652,7 +1579,7 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	struct recv_reorder_ctrl *preorder_ctrl;
 	unsigned char		*frame_body;
 	unsigned char		category, action;
-	unsigned short	tid, status, reason_code = 0;
+	unsigned short	tid, status;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->rx_data;
@@ -1678,7 +1605,6 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 		if (!pmlmeinfo->HT_enable)
 			return _SUCCESS;
 		action = frame_body[1];
-		netdev_dbg(padapter->pnetdev, "action=%d\n", action);
 		switch (action) {
 		case RTW_WLAN_ACTION_ADDBA_REQ: /* ADDBA request */
 			memcpy(&pmlmeinfo->ADDBA_req, &frame_body[2], sizeof(struct ADDBA_request));
@@ -1693,8 +1619,6 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 			status = get_unaligned_le16(&frame_body[3]);
 			tid = ((frame_body[5] >> 2) & 0x7);
 			if (status == 0) {	/* successful */
-				netdev_dbg(padapter->pnetdev,
-					   "agg_enable for TID=%d\n", tid);
 				psta->htpriv.agg_enable_bitmap |= 1 << tid;
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			} else {
@@ -1705,17 +1629,12 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 			if ((frame_body[3] & BIT(3)) == 0) {
 				psta->htpriv.agg_enable_bitmap &= ~(1 << ((frame_body[3] >> 4) & 0xf));
 				psta->htpriv.candidate_tid_bitmap &= ~(1 << ((frame_body[3] >> 4) & 0xf));
-				reason_code = get_unaligned_le16(&frame_body[4]);
 			} else if ((frame_body[3] & BIT(3)) == BIT(3)) {
 				tid = (frame_body[3] >> 4) & 0x0F;
 				preorder_ctrl =  &psta->recvreorder_ctrl[tid];
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
 			}
-			netdev_dbg(padapter->pnetdev,
-				   "DELBA: %x(%x)\n",
-				   pmlmeinfo->agg_enable_bitmap,
-				   reason_code);
 			/* todo: how to notify the host while receiving DELETE BA */
 			break;
 		default:
@@ -2094,7 +2013,6 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	if (!pmgntframe)
 		return;
 
-	netdev_dbg(padapter->pnetdev, "result=%d\n",  result);
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
 	update_mgntframe_attrib(padapter, pattrib);
@@ -3126,18 +3044,9 @@ static u8 is_matched_in_profilelist(u8 *peermacaddr, struct profile_info *profil
 {
 	u8 i, match_result = 0;
 
-	pr_debug("peermac=%.2X %.2X %.2X %.2X %.2X %.2X\n",
-		 peermacaddr[0], peermacaddr[1], peermacaddr[2],
-		 peermacaddr[3], peermacaddr[4], peermacaddr[5]);
-
 	for (i = 0; i < P2P_MAX_PERSISTENT_GROUP_NUM; i++, profileinfo++) {
-		pr_debug("profileinfo_mac=%.2X %.2X %.2X %.2X %.2X %.2X\n",
-			 profileinfo->peermac[0], profileinfo->peermac[1],
-			 profileinfo->peermac[2], profileinfo->peermac[3],
-			 profileinfo->peermac[4], profileinfo->peermac[5]);
 		if (!memcmp(peermacaddr, profileinfo->peermac, ETH_ALEN)) {
 			match_result = 1;
-			pr_debug("Match!\n");
 			break;
 		}
 	}
@@ -3689,16 +3598,10 @@ static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 	if (GetRetry(frame)) {
 		if (token >= 0) {
 			if ((seq_ctrl == mlmeext->action_public_rxseq) && (token == mlmeext->action_public_dialog_token)) {
-				netdev_dbg(adapter->pnetdev,
-					   "seq_ctrl = 0x%x, rxseq = 0x%x, token:%d\n",
-					   seq_ctrl, mlmeext->action_public_rxseq, token);
 				return _FAIL;
 			}
 		} else {
 			if (seq_ctrl == mlmeext->action_public_rxseq) {
-				netdev_dbg(adapter->pnetdev,
-					   "seq_ctrl = 0x%x, rxseq = 0x%x\n",
-					   seq_ctrl, mlmeext->action_public_rxseq);
 				return _FAIL;
 			}
 		}
@@ -3741,7 +3644,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 
 	switch (frame_body[6]) { /* OUI Subtype */
 	case P2P_GO_NEGO_REQ:
-		netdev_dbg(padapter->pnetdev, "Got GO Nego Req Frame\n");
 		memset(&pwdinfo->groupid_info, 0x00, sizeof(struct group_id_info));
 
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_RX_PROVISION_DIS_REQ))
@@ -3753,9 +3655,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 			_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
 			/*	Restore the previous p2p state */
 			rtw_p2p_set_state(pwdinfo, rtw_p2p_pre_state(pwdinfo));
-			netdev_dbg(padapter->pnetdev,
-				   "Restore the previous p2p state to %d\n",
-				   rtw_p2p_state(pwdinfo));
 		}
 
 		/*	Commented by Kurt 20110902 */
@@ -3776,8 +3675,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		_set_timer(&pwdinfo->restore_p2p_state_timer, 5000);
 		break;
 	case P2P_GO_NEGO_RESP:
-		netdev_dbg(padapter->pnetdev, "Got GO Nego Resp Frame\n");
-
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_ING)) {
 			/*	Commented by Albert 20110425 */
 			/*	The restore timer is enabled when issuing the nego request frame of rtw_p2p_connect function. */
@@ -3797,12 +3694,9 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 			if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_FAIL))
 				_set_timer(&pwdinfo->restore_p2p_state_timer, 5000);
 		} else {
-			netdev_dbg(padapter->pnetdev,
-				   "Skipped GO Nego Resp Frame (p2p_state != P2P_STATE_GONEGO_ING)\n");
 		}
 		break;
 	case P2P_GO_NEGO_CONF:
-		netdev_dbg(padapter->pnetdev, "Got GO Nego Confirm Frame\n");
 		result = process_p2p_group_negotation_confirm(pwdinfo, frame_body, len);
 		if (P2P_STATUS_SUCCESS == result) {
 			if (rtw_p2p_role(pwdinfo) == P2P_ROLE_CLIENT) {
@@ -3816,7 +3710,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		/*	Added by Albert 2010/10/05 */
 		/*	Received the P2P Invite Request frame. */
 
-		netdev_dbg(padapter->pnetdev, "Got invite request frame!\n");
 		p2p_ie = rtw_get_p2p_ie(frame_body + _PUBLIC_ACTION_IE_OFFSET_, len - _PUBLIC_ACTION_IE_OFFSET_, NULL, &p2p_ielen);
 		if (p2p_ie) {
 			/*	Parse the necessary information from the P2P Invitation Request frame. */
@@ -3836,14 +3729,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 				/*	After having the peer interface address, the sigma can find the correct conf file for wpa_supplicant. */
 
 				if (attr_contentlen) {
-					netdev_dbg(padapter->pnetdev,
-						   "GO's BSSID = %.2X %.2X %.2X %.2X %.2X %.2X\n",
-						   pwdinfo->p2p_peer_interface_addr[0],
-						   pwdinfo->p2p_peer_interface_addr[1],
-						   pwdinfo->p2p_peer_interface_addr[2],
-						   pwdinfo->p2p_peer_interface_addr[3],
-						   pwdinfo->p2p_peer_interface_addr[4],
-						   pwdinfo->p2p_peer_interface_addr[5]);
 				}
 
 				if (invitation_flag & P2P_INVITATION_FLAGS_PERSISTENT) {
@@ -3891,8 +3776,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 							}
 						}
 					} else {
-						netdev_dbg(padapter->pnetdev,
-							   "P2P Group ID Attribute NOT FOUND!\n");
 						status_code = P2P_STATUS_FAIL_INFO_UNAVAILABLE;
 					}
 				} else {
@@ -3918,20 +3801,13 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 							status_code = P2P_STATUS_SUCCESS;
 						}
 					} else {
-						netdev_dbg(padapter->pnetdev,
-							   "P2P Group ID Attribute NOT FOUND!\n");
 						status_code = P2P_STATUS_FAIL_INFO_UNAVAILABLE;
 					}
 				}
 			} else {
-				netdev_dbg(padapter->pnetdev,
-					   "P2P Invitation Flags Attribute NOT FOUND!\n");
 				status_code = P2P_STATUS_FAIL_INFO_UNAVAILABLE;
 			}
 
-			netdev_dbg(padapter->pnetdev,
-				   "status_code = %d\n", status_code);
-
 			pwdinfo->inviteresp_info.token = frame_body[7];
 			issue_p2p_invitation_response(padapter, GetAddr2Ptr(pframe), pwdinfo->inviteresp_info.token, status_code);
 		}
@@ -3940,15 +3816,12 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		u8	attr_content = 0x00;
 		u32	attr_contentlen = 0;
 
-		netdev_dbg(padapter->pnetdev, "Got invite response frame!\n");
 		_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
 		p2p_ie = rtw_get_p2p_ie(frame_body + _PUBLIC_ACTION_IE_OFFSET_, len - _PUBLIC_ACTION_IE_OFFSET_, NULL, &p2p_ielen);
 		if (p2p_ie) {
 			rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_STATUS, &attr_content, &attr_contentlen);
 
 			if (attr_contentlen == 1) {
-				netdev_dbg(padapter->pnetdev,
-					   "Status = %d\n", attr_content);
 				pwdinfo->invitereq_info.benable = false;
 
 				if (attr_content == P2P_STATUS_SUCCESS) {
@@ -3982,8 +3855,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		process_p2p_devdisc_resp(pwdinfo, pframe, len);
 		break;
 	case P2P_PROVISION_DISC_REQ:
-		netdev_dbg(padapter->pnetdev,
-			   "Got Provisioning Discovery Request Frame\n");
 		process_p2p_provdisc_req(pwdinfo, pframe, len);
 		memcpy(pwdinfo->rx_prov_disc_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN);
 
@@ -3998,8 +3869,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	case P2P_PROVISION_DISC_RESP:
 		/*	Commented by Albert 20110707 */
 		/*	Should we check the pwdinfo->tx_prov_disc_info.bsent flag here?? */
-		netdev_dbg(padapter->pnetdev,
-			   "Got Provisioning Discovery Response Frame\n");
 		/*	Commented by Albert 20110426 */
 		/*	The restore timer is enabled when issuing the provisioing request frame in rtw_p2p_prov_disc function. */
 		_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
@@ -4154,13 +4023,11 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 
 	pmgntframe = rtw_alloc_xmitframe(pxmitpriv);
 	if (!pmgntframe) {
-		pr_debug("alloc xmitframe fail\n");
 		return NULL;
 	}
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
 	if (!pxmitbuf) {
-		pr_debug("alloc xmitbuf fail\n");
 		rtw_free_xmitframe(pxmitpriv, pmgntframe);
 		return NULL;
 	}
@@ -4182,7 +4049,6 @@ void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 
 	pmlmeext->tx_rate = rate;
-	netdev_dbg(padapter->pnetdev, "rate = %x\n", rate);
 }
 
 void update_mgntframe_attrib(struct adapter *padapter, struct pkt_attrib *pattrib)
@@ -4319,7 +4185,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
-		netdev_dbg(padapter->pnetdev, "alloc mgnt frame fail\n");
 		return;
 	}
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
@@ -4502,7 +4367,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
 
 	if ((pattrib->pktlen + TXDESC_SIZE) > 512) {
-		netdev_dbg(padapter->pnetdev, "beacon frame too large\n");
 		return;
 	}
 
@@ -4534,8 +4398,6 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
-		netdev_dbg(padapter->pnetdev,
-			   "alloc mgnt frame fail\n");
 		return;
 	}
 
@@ -4761,7 +4623,6 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 {
 	int ret;
 	int i = 0;
-	u32 start = jiffies;
 
 	do {
 		ret = _issue_probereq(padapter, pssid, da, wait_ms > 0);
@@ -4783,17 +4644,9 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			netdev_dbg(padapter->pnetdev,
-				   "to %pM, ch:%u%s, %d/%d in %u ms\n",
-				   da, rtw_get_oper_ch(padapter),
-				   ret == _SUCCESS ? ", acked" : "",
-				   i, try_cnt, rtw_get_passing_time_ms(start));
+			;
 		else
-			netdev_dbg(padapter->pnetdev,
-				   "ch:%u%s, %d/%d in %u ms\n",
-				   rtw_get_oper_ch(padapter),
-				   ret == _SUCCESS ? ", acked" : "",
-				   i, try_cnt, rtw_get_passing_time_ms(start));
+			;
 	}
 exit:
 	return ret;
@@ -5129,9 +4982,6 @@ void issue_assocreq(struct adapter *padapter)
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
 		if (pmlmeinfo->network.SupportedRates[i] == 0)
 			break;
-		netdev_dbg(padapter->pnetdev,
-			   "network.SupportedRates[%d]=%02X\n",
-			   i, pmlmeinfo->network.SupportedRates[i]);
 	}
 
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
@@ -5148,9 +4998,6 @@ void issue_assocreq(struct adapter *padapter)
 
 		if (j == sta_bssrate_len) {
 			/*  the rate is not supported by STA */
-			netdev_dbg(padapter->pnetdev,
-				   "the rate[%d]=%02X is not supported by STA!\n",
-				   i, pmlmeinfo->network.SupportedRates[i]);
 		} else {
 			/*  the rate is supported by STA */
 			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
@@ -5158,7 +5005,6 @@ void issue_assocreq(struct adapter *padapter)
 	}
 
 	bssrate_len = index;
-	netdev_dbg(padapter->pnetdev, "bssrate_len=%d\n", bssrate_len);
 
 	if (bssrate_len == 0) {
 		rtw_free_xmitbuf(pxmitpriv, pmgntframe->pxmitbuf);
@@ -5443,7 +5289,6 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 {
 	int ret;
 	int i = 0;
-	u32 start = jiffies;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
@@ -5470,17 +5315,9 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			netdev_dbg(padapter->pnetdev,
-				   "to %pM, ch:%u%s, %d/%d in %u ms\n",
-				   da, rtw_get_oper_ch(padapter),
-				   ret == _SUCCESS ? ", acked" : "",
-				   i, try_cnt, rtw_get_passing_time_ms(start));
+			;
 		else
-			netdev_dbg(padapter->pnetdev,
-				   "ch:%u%s, %d/%d in %u ms\n",
-				   rtw_get_oper_ch(padapter),
-				   ret == _SUCCESS ? ", acked" : "",
-				   i, try_cnt, rtw_get_passing_time_ms(start));
+			;
 	}
 exit:
 	return ret;
@@ -5565,7 +5402,6 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 {
 	int ret;
 	int i = 0;
-	u32 start = jiffies;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
@@ -5592,17 +5428,9 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			netdev_dbg(padapter->pnetdev,
-				   "to %pM, ch:%u%s, %d/%d in %u ms\n",
-				   da, rtw_get_oper_ch(padapter),
-				   ret == _SUCCESS ? ", acked" : "",
-				   i, try_cnt, rtw_get_passing_time_ms(start));
+			;
 		else
-			netdev_dbg(padapter->pnetdev,
-				   "ch:%u%s, %d/%d in %u ms\n",
-				   rtw_get_oper_ch(padapter),
-				   ret == _SUCCESS ? ", acked" : "",
-				   i, try_cnt, rtw_get_passing_time_ms(start));
+			;
 	}
 exit:
 	return ret;
@@ -5673,7 +5501,6 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 
 int issue_deauth(struct adapter *padapter, unsigned char *da, unsigned short reason)
 {
-	netdev_dbg(padapter->pnetdev, "to %pM\n", da);
 	return _issue_deauth(padapter, da, reason, false);
 }
 
@@ -5682,7 +5509,6 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 {
 	int ret;
 	int i = 0;
-	u32 start = jiffies;
 
 	do {
 		ret = _issue_deauth(padapter, da, reason, wait_ms > 0);
@@ -5703,17 +5529,9 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			netdev_dbg(padapter->pnetdev,
-				   "to %pM, ch:%u%s, %d/%d in %u ms\n",
-				   da, rtw_get_oper_ch(padapter),
-				   ret == _SUCCESS ? ", acked" : "",
-				   i, try_cnt, rtw_get_passing_time_ms(start));
+			;
 		else
-			netdev_dbg(padapter->pnetdev,
-				   "ch:%u%s, %d/%d in %u ms\n",
-				   rtw_get_oper_ch(padapter),
-				   ret == _SUCCESS ? ", acked" : "",
-				   i, try_cnt, rtw_get_passing_time_ms(start));
+			;
 	}
 exit:
 	return ret;
@@ -5740,10 +5558,6 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct registry_priv *pregpriv = &padapter->registrypriv;
 
-	netdev_dbg(padapter->pnetdev,
-		   "category=%d, action=%d, status=%d\n",
-		   category, action, status);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		return;
@@ -5795,10 +5609,6 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			if (psta) {
 				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07] & 0xfff) + 1;
 
-				netdev_dbg(padapter->pnetdev,
-					   "BA_starting_seqctrl=%d for TID=%d\n",
-					   start_seq, status & 0x07);
-
 				psta->BA_starting_seqctrl[status & 0x07] = start_seq;
 
 				BA_starting_seqctrl = start_seq << 4;
@@ -5987,8 +5797,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	if (initiator == 0) { /*  recipient */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
-				netdev_dbg(padapter->pnetdev,
-					   "rx agg disable tid(%d)\n", tid);
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
@@ -5997,8 +5805,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	} else if (initiator == 1) { /*  originator */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
-				netdev_dbg(padapter->pnetdev,
-					   "tx agg disable tid(%d)\n", tid);
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
@@ -6031,16 +5837,13 @@ unsigned int send_beacon(struct adapter *padapter)
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return _FAIL;
 	if (!bxmitok) {
-		netdev_dbg(padapter->pnetdev, "fail! %u ms\n",
-			   rtw_get_passing_time_ms(start));
 		return _FAIL;
 	} else {
 		u32 passing_time = rtw_get_passing_time_ms(start);
 
 		if (passing_time > 100 || issue > 3)
-			netdev_dbg(padapter->pnetdev,
-				   "success, issue:%d, poll:%d, %u ms\n",
-				   issue, poll, rtw_get_passing_time_ms(start));
+			;
+
 		return _SUCCESS;
 	}
 }
@@ -6249,16 +6052,11 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
 	if (!p) {
-		netdev_dbg(padapter->pnetdev,
-			   "marc: cannot find SSID for survey event\n");
 		return _FAIL;
 	}
 
 	if (*(p + 1)) {
 		if (len > NDIS_802_11_LENGTH_SSID) {
-			netdev_dbg(padapter->pnetdev,
-				   "IE too long (%d) for survey event\n",
-				   len);
 			return _FAIL;
 		}
 		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
@@ -6274,9 +6072,6 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
 		if (len > NDIS_802_11_LENGTH_RATES_EX) {
-			netdev_dbg(padapter->pnetdev,
-				   "IE too long (%d) for survey event\n",
-				   len);
 			return _FAIL;
 		}
 		memcpy(bssid->SupportedRates, (p + 2), len);
@@ -6286,9 +6081,6 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	p = rtw_get_ie(bssid->IEs + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
 		if (len > (NDIS_802_11_LENGTH_RATES_EX - i)) {
-			netdev_dbg(padapter->pnetdev,
-				   "IE too long (%d) for survey event\n",
-				   len);
 			return _FAIL;
 		}
 		memcpy(bssid->SupportedRates + i, (p + 2), len);
@@ -6403,7 +6195,6 @@ void start_create_ibss(struct adapter *padapter)
 			rtw_indicate_connect(padapter);
 		}
 	} else {
-		netdev_dbg(padapter->pnetdev, "invalid cap:%x\n", caps);
 		return;
 	}
 	/* update bc/mc sta_info */
@@ -6773,9 +6564,6 @@ void report_surveydone_event(struct adapter *padapter)
 	psurveydone_evt = (struct surveydone_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	psurveydone_evt->bss_cnt = pmlmeext->sitesurvey_res.bss_cnt;
 
-	netdev_dbg(padapter->pnetdev, "survey done event(%x)\n",
-		   psurveydone_evt->bss_cnt);
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -6820,8 +6608,6 @@ void report_join_res(struct adapter *padapter, int res)
 	pjoinbss_evt->network.join_res	= res;
 	pjoinbss_evt->network.aid = res;
 
-	netdev_dbg(padapter->pnetdev, "res=%d\n", res);
-
 	rtw_joinbss_event_prehandle(padapter, (u8 *)&pjoinbss_evt->network);
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
@@ -6876,8 +6662,6 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 
 	pdel_sta_evt->mac_id = mac_id;
 
-	netdev_dbg(padapter->pnetdev, "delete STA, mac_id = %d\n", mac_id);
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -6920,8 +6704,6 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	memcpy((unsigned char *)(&padd_sta_evt->macaddr), MacAddr, ETH_ALEN);
 	padd_sta_evt->cam_id = cam_idx;
 
-	netdev_dbg(padapter->pnetdev, "add STA\n");
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -7133,8 +6915,6 @@ static void _linked_rx_signal_strength_display(struct adapter *padapter)
 	GetHalDefVar8188EUsb(padapter, HW_DEF_RA_INFO_DUMP, &mac_id);
 
 	GetHalDefVar8188EUsb(padapter, HAL_DEF_UNDERCORATEDSMOOTHEDPWDB, &UndecoratedSmoothedPWDB);
-	netdev_dbg(padapter->pnetdev,
-		   "UndecoratedSmoothedPWDB:%d\n", UndecoratedSmoothedPWDB);
 }
 
 static u8 chk_ap_is_alive(struct sta_info *psta)
@@ -7159,20 +6939,14 @@ static void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
 	u8 fw_status;
 
 	if (rx_dma_status != 0x00) {
-		netdev_dbg(padapter->pnetdev, "REG_RXDMA_STATUS:0x%08x\n",
-			   rx_dma_status);
 		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
 	}
 
 	fw_status = rtw_read8(padapter, REG_FMETHR);
 	if (fw_status == 1)
-		netdev_dbg(padapter->pnetdev,
-			   "REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n",
-			   fw_status);
+		;
 	else if (fw_status == 2)
-		netdev_dbg(padapter->pnetdev,
-			   "REG_FW_STATUS (0x%02x), Condition_No_Match !!\n",
-			   fw_status);
+		;
 }
 
 void linked_status_chk(struct adapter *padapter)
@@ -7306,15 +7080,8 @@ void survey_timer_hdl(struct adapter *padapter)
 			if (!rtw_p2p_chk_state(&padapter->wdinfo, P2P_STATE_NONE)) {
 				rtw_p2p_findphase_ex_set(pwdinfo, P2P_FINDPHASE_EX_MAX);
 				pmlmeext->sitesurvey_res.channel_idx = 3;
-				netdev_dbg(padapter->pnetdev,
-					   "idx:%d, cnt:%u\n",
-					   pmlmeext->sitesurvey_res.channel_idx,
-					   pwdinfo->find_phase_state_exchange_cnt);
 			} else {
 				pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
-				netdev_dbg(padapter->pnetdev,
-					   "idx:%d\n",
-					   pmlmeext->sitesurvey_res.channel_idx);
 			}
 
 			pmlmeext->scan_abort = false;/* reset */
@@ -7344,7 +7111,6 @@ void link_timer_hdl(struct adapter *padapter)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
-		netdev_dbg(padapter->pnetdev, "no beacon while connecting\n");
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		report_join_res(padapter, -3);
 	} else if (pmlmeinfo->state & WIFI_FW_AUTH_STATE) {
@@ -7355,7 +7121,6 @@ void link_timer_hdl(struct adapter *padapter)
 			return;
 		}
 
-		netdev_dbg(padapter->pnetdev, "auth timeout and try again\n");
 		pmlmeinfo->auth_seq = 1;
 		issue_auth(padapter, NULL, 0);
 		set_link_timer(pmlmeext, REAUTH_TO);
@@ -7367,7 +7132,6 @@ void link_timer_hdl(struct adapter *padapter)
 			return;
 		}
 
-		netdev_dbg(padapter->pnetdev, "assoc timeout and try again\n");
 		issue_assocreq(padapter);
 		set_link_timer(pmlmeext, REASSOC_TO);
 	}
@@ -7558,8 +7322,6 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 						break;
 				}
 
-					netdev_dbg(padapter->pnetdev,
-						   "set ch/bw before connected\n");
 				}
 			}
 			break;
@@ -7812,29 +7574,16 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 		if (psta) {
 			ctrl = (BIT(15) | ((pparm->algorithm) << 2));
 
-			netdev_dbg(padapter->pnetdev, "enc_algorithm=%d\n",
-				   pparm->algorithm);
-
 			if ((psta->mac_id < 1) || (psta->mac_id > (NUM_STA - 4))) {
-				netdev_dbg(padapter->pnetdev,
-					   "set_stakey failed, mac_id(aid)=%d\n",
-					   psta->mac_id);
 				return H2C_REJECTED;
 			}
 
 			cam_id = (psta->mac_id + 3);/* 0~3 for default key, cmd_id = macid + 3, macid = aid+1; */
 
-			netdev_dbg(padapter->pnetdev,
-				   "Write CAM, mac_addr =%x:%x:%x:%x:%x:%x, cam_entry=%d\n",
-				   pparm->addr[0], pparm->addr[1], pparm->addr[2],
-				   pparm->addr[3], pparm->addr[4], pparm->addr[5],
-				   cam_id);
-
 			write_cam(padapter, cam_id, ctrl, pparm->addr, pparm->key);
 
 			return H2C_SUCCESS_RSP;
 		} else {
-			netdev_dbg(padapter->pnetdev, "sta has been free\n");
 			return H2C_REJECTED;
 		}
 	}
@@ -7958,7 +7707,6 @@ u8 h2c_msg_hdl(struct adapter *padapter, unsigned char *pbuf)
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	if (send_beacon(padapter) == _FAIL) {
-		netdev_dbg(padapter->pnetdev, "issue_beacon, fail!\n");
 		return H2C_PARAMETERS_ERROR;
 	} else {
 		/* tx bc/mc frames after update TIM */
@@ -8017,9 +7765,6 @@ u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf)
 
 	set_ch_parm = (struct set_ch_parm *)pbuf;
 
-	netdev_dbg(padapter->pnetdev, "ch:%u, bw:%u, ch_offset:%u\n",
-		   set_ch_parm->ch, set_ch_parm->bw, set_ch_parm->ch_offset);
-
 	pmlmeext->cur_channel = set_ch_parm->ch;
 	pmlmeext->cur_ch_offset = set_ch_parm->ch_offset;
 	pmlmeext->cur_bwmode = set_ch_parm->bw;
-- 
2.34.1

