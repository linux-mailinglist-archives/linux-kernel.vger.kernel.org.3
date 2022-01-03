Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5324837CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiACT4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiACT4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:56:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B2C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:56:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z29so139774804edl.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtEKiy6xNGZNwE2D6KEFEyA0O32/Ck1CHInWfyjmo1Q=;
        b=TxMymPfXclmZSRW5rLmFgcoHayBBJBxNwUxa6NzZ2aSjdTxveJQYC/LaWCtPCR5qcT
         uclFhch+OJgQhovVHnWW86Jg7d9XNGvEzCuiUKxjJCteh8/CZYITSrGz47F85USALFa+
         f8DcUxYEerfJRZK4mU8LjgGaj4vwBYvnNZhQ8UMhffwx37XDcghO52PKwztTARmk/U6T
         jcDYLJYtdwJGqlNpGajqt6bagCmdE6dnFKfeJA2sYE+TSWk/VTLGmivfvAR7LUwG8/GX
         0zJiHOpTzDTlROlLNEM403XEVWq+lLdOkYl3OkPSQGI7HFYLZwvYhjlLlAW4nGFVyXuK
         vzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtEKiy6xNGZNwE2D6KEFEyA0O32/Ck1CHInWfyjmo1Q=;
        b=AQXFj11CyiG9KV98ZOsh50SL+wJqLs29Hxs1Nb+3LP39XBbVwRgeA1OTTgUBpzpKga
         B17P79lbtNTsDhjhzwyYdr5VnV3/xy/99Ant1M6yUCriFnNbIFSt7fzGzEKSmbuSkqSc
         dbaLWhlI9X4fdd8GPxySkFuabhkaaXvQzeCUwY0TXISe4z/S5ospPcIxoz9kCUnrZYTl
         EfBH+kj9i38h2/p1AVqdZGzlqKgF7JhyPk6GIDUc/4exOSepFptANPnHV0/JMVHcg3RR
         67Da7xgo+cJ/Bd8m+BiOl/cM9Gis+BNZrzR4Hd2nR/nGJbnXzhbtQDwYWmOYegvGn4CW
         MZcg==
X-Gm-Message-State: AOAM532BITGtH4nqIMrh8Y+cBXDmDR4xiuyRqKczzvsItgw/yh3vjW8S
        3wX3pQIp8meopSraD0en8HQ=
X-Google-Smtp-Source: ABdhPJzX9i8fIlAOCYFLfyRy3hS/yoEdP8qtF+Ss9HTnpQpM3KTKAKQAiKZD2JmLXoWt3ugDC9+kVQ==
X-Received: by 2002:a17:906:c14f:: with SMTP id dp15mr39534760ejc.267.1641239766620;
        Mon, 03 Jan 2022 11:56:06 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:56:06 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 54/56] staging: r8188eu: rename camelcase GetAddr2Ptr to get_addr_2_ptr
Date:   Mon,  3 Jan 2022 20:02:29 +0100
Message-Id: <20220103190326.363960-55-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetAddr2Ptr into get_addr_2_ptr

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 46 ++++++++++-----------
 drivers/staging/r8188eu/core/rtw_p2p.c      |  6 +--
 drivers/staging/r8188eu/core/rtw_recv.c     | 10 ++---
 drivers/staging/r8188eu/include/wifi.h      |  8 ++--
 4 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index af65774ed936..491cba1a007a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -414,7 +414,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	struct mlme_handler *ptable;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 *pframe = precv_frame->rx_data;
-	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(pframe));
+	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, get_addr_2_ptr(pframe));
 
 	if (get_frame_type(pframe) != WIFI_MGT_TYPE)
 		return;
@@ -569,7 +569,7 @@ unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_PROVISION_DIS_REQ)) {
 		if (pwdinfo->tx_prov_disc_info.benable) {
-			if (!memcmp(pwdinfo->tx_prov_disc_info.peerIFAddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
+			if (!memcmp(pwdinfo->tx_prov_disc_info.peerIFAddr, get_addr_2_ptr(pframe), ETH_ALEN)) {
 				if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_CLIENT)) {
 					pwdinfo->tx_prov_disc_info.benable = false;
 					issue_p2p_provision_request(padapter,
@@ -587,7 +587,7 @@ unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_ING)) {
 		if (pwdinfo->nego_req_info.benable) {
 			DBG_88E("[%s] P2P State is GONEGO ING!\n", __func__);
-			if (!memcmp(pwdinfo->nego_req_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
+			if (!memcmp(pwdinfo->nego_req_info.peerDevAddr, get_addr_2_ptr(pframe), ETH_ALEN)) {
 				pwdinfo->nego_req_info.benable = false;
 				issue_p2p_GO_request(padapter, pwdinfo->nego_req_info.peerDevAddr);
 			}
@@ -595,7 +595,7 @@ unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_INVITE_REQ)) {
 		if (pwdinfo->invitereq_info.benable) {
 			DBG_88E("[%s] P2P_STATE_TX_INVITE_REQ!\n", __func__);
-			if (!memcmp(pwdinfo->invitereq_info.peer_macaddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
+			if (!memcmp(pwdinfo->invitereq_info.peer_macaddr, get_addr_2_ptr(pframe), ETH_ALEN)) {
 				pwdinfo->invitereq_info.benable = false;
 				issue_p2p_invitation_request(padapter, pwdinfo->invitereq_info.peer_macaddr);
 			}
@@ -652,7 +652,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 		}
 
 		if (((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
-			psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+			psta = rtw_get_stainfo(pstapriv, get_addr_2_ptr(pframe));
 			if (psta) {
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
@@ -669,7 +669,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 				process_p2p_ps_ie(padapter, (pframe + WLAN_HDR_A3_LEN), (len - WLAN_HDR_A3_LEN));
 			}
 		} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
-			psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+			psta = rtw_get_stainfo(pstapriv, get_addr_2_ptr(pframe));
 			if (psta) {
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
@@ -691,7 +691,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 				update_TSF(pmlmeext, pframe, len);
 
 				/* report sta add event */
-				report_add_sta_event(padapter, GetAddr2Ptr(pframe), cam_idx);
+				report_add_sta_event(padapter, get_addr_2_ptr(pframe), cam_idx);
 			}
 		}
 	}
@@ -722,7 +722,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	DBG_88E("+OnAuth\n");
 
-	sa = GetAddr2Ptr(pframe);
+	sa = get_addr_2_ptr(pframe);
 
 	auth_mode = psecuritypriv->dot11AuthAlgrthm;
 	seq = le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + 2));
@@ -985,7 +985,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		return _FAIL;
 	}
 
-	pstat = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+	pstat = rtw_get_stainfo(pstapriv, get_addr_2_ptr(pframe));
 	if (pstat == (struct sta_info *)NULL) {
 		status = _RSON_CLS2_;
 		goto asoc_class2_error;
@@ -1375,7 +1375,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 asoc_class2_error:
 
-	issue_deauth(padapter, (void *)GetAddr2Ptr(pframe), status);
+	issue_deauth(padapter, (void *)get_addr_2_ptr(pframe), status);
 
 	return _FAIL;
 
@@ -1508,9 +1508,9 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 
 		netdev_dbg(padapter->pnetdev,
 			   "ap recv deauth reason code(%d) sta:%pM\n",
-			   reason, GetAddr2Ptr(pframe));
+			   reason, get_addr_2_ptr(pframe));
 
-		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+		psta = rtw_get_stainfo(pstapriv, get_addr_2_ptr(pframe));
 		if (psta) {
 			u8 updated = 0;
 
@@ -1583,9 +1583,9 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 
 		netdev_dbg(padapter->pnetdev,
 			   "ap recv disassoc reason code(%d) sta:%pM\n",
-			   reason, GetAddr2Ptr(pframe));
+			   reason, get_addr_2_ptr(pframe));
 
-		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+		psta = rtw_get_stainfo(pstapriv, get_addr_2_ptr(pframe));
 		if (psta) {
 			u8 updated = 0;
 
@@ -1630,7 +1630,7 @@ unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_f
 
 	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
 
-	psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+	psta = rtw_get_stainfo(pstapriv, get_addr_2_ptr(pframe));
 
 	if (!psta)
 		goto exit;
@@ -1688,7 +1688,7 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 		if (!(pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS))
 			return _SUCCESS;
 
-	addr = GetAddr2Ptr(pframe);
+	addr = get_addr_2_ptr(pframe);
 	psta = rtw_get_stainfo(pstapriv, addr);
 
 	if (!psta)
@@ -3782,10 +3782,10 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		/*	Commented by Kurt 20120113 */
 		/*	Get peer_dev_addr here if peer doesn't issue prov_disc frame. */
 		if (!memcmp(pwdinfo->rx_prov_disc_info.peerDevAddr, empty_addr, ETH_ALEN))
-			memcpy(pwdinfo->rx_prov_disc_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN);
+			memcpy(pwdinfo->rx_prov_disc_info.peerDevAddr, get_addr_2_ptr(pframe), ETH_ALEN);
 
 		result = process_p2p_group_negotation_req(pwdinfo, frame_body, len);
-		issue_p2p_GO_response(padapter, GetAddr2Ptr(pframe), frame_body, len, result);
+		issue_p2p_GO_response(padapter, get_addr_2_ptr(pframe), frame_body, len, result);
 
 		/*	Commented by Albert 20110718 */
 		/*	No matter negotiating or negotiation failure, the driver should set up the restore P2P state timer. */
@@ -3800,7 +3800,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 			_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
 			pwdinfo->nego_req_info.benable = false;
 			result = process_p2p_group_negotation_resp(pwdinfo, frame_body, len);
-			issue_p2p_GO_confirm(pwdinfo->padapter, GetAddr2Ptr(pframe), result);
+			issue_p2p_GO_confirm(pwdinfo->padapter, get_addr_2_ptr(pframe), result);
 			if (P2P_STATUS_SUCCESS == result) {
 				if (rtw_p2p_role(pwdinfo) == P2P_ROLE_CLIENT) {
 					pwdinfo->p2p_info.operation_ch[0] = pwdinfo->peer_operating_ch;
@@ -3940,7 +3940,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 			DBG_88E("[%s] status_code = %d\n", __func__, status_code);
 
 			pwdinfo->inviteresp_info.token = frame_body[7];
-			issue_p2p_invitation_response(padapter, GetAddr2Ptr(pframe), pwdinfo->inviteresp_info.token, status_code);
+			issue_p2p_invitation_response(padapter, get_addr_2_ptr(pframe), pwdinfo->inviteresp_info.token, status_code);
 		}
 		break;
 	case P2P_INVIT_RESP: {
@@ -3990,7 +3990,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	case P2P_PROVISION_DISC_REQ:
 		DBG_88E("[%s] Got Provisioning Discovery Request Frame\n", __func__);
 		process_p2p_provdisc_req(pwdinfo, pframe, len);
-		memcpy(pwdinfo->rx_prov_disc_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN);
+		memcpy(pwdinfo->rx_prov_disc_info.peerDevAddr, get_addr_2_ptr(pframe), ETH_ALEN);
 
 		/* 20110902 Kurt */
 		/* Add the following statement to avoid receiving duplicate prov disc req. such that pre_p2p_state would be covered. */
@@ -4965,7 +4965,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	*(fctrl) = 0;
 
 	memcpy((void *)get_addr_1_ptr(pwlanhdr), pstat->hwaddr, ETH_ALEN);
-	memcpy((void *)GetAddr2Ptr(pwlanhdr), myid(&padapter->eeprompriv), ETH_ALEN);
+	memcpy((void *)get_addr_2_ptr(pwlanhdr), myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy((void *)GetAddr3Ptr(pwlanhdr), get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
 	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
@@ -6321,7 +6321,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 
 	if (val16 & BIT(0)) {
 		bssid->InfrastructureMode = Ndis802_11Infrastructure;
-		memcpy(bssid->MacAddress, GetAddr2Ptr(pframe), ETH_ALEN);
+		memcpy(bssid->MacAddress, get_addr_2_ptr(pframe), ETH_ALEN);
 	} else {
 		bssid->InfrastructureMode = Ndis802_11IBSS;
 		memcpy(bssid->MacAddress, GetAddr3Ptr(pframe), ETH_ALEN);
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 558646db06b3..4723c66ec18b 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -963,7 +963,7 @@ u32 process_p2p_devdisc_req(struct wifidirect_info *pwdinfo, u8 *pframe, uint le
 	}
 
 	/* issue Device Discoverability Response */
-	issue_p2p_devdisc_resp(pwdinfo, GetAddr2Ptr(pframe), status, dialogToken);
+	issue_p2p_devdisc_resp(pwdinfo, get_addr_2_ptr(pframe), status, dialogToken);
 
 	return (status == P2P_STATUS_SUCCESS) ? true : false;
 }
@@ -1001,7 +1001,7 @@ u8 process_p2p_provdisc_req(struct wifidirect_info *pwdinfo,  u8 *pframe, uint l
 				memcpy(pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req, "pad", 3);
 				break;
 			}
-			issue_p2p_provision_resp(pwdinfo, GetAddr2Ptr(pframe), frame_body, uconfig_method);
+			issue_p2p_provision_resp(pwdinfo, get_addr_2_ptr(pframe), frame_body, uconfig_method);
 		}
 	}
 	DBG_88E("[%s] config method = %s\n", __func__, pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req);
@@ -1439,7 +1439,7 @@ u8 process_p2p_presence_req(struct wifidirect_info *pwdinfo, u8 *pframe, uint le
 
 	/* todo: check NoA attribute */
 
-	issue_p2p_presence_resp(pwdinfo, GetAddr2Ptr(pframe), status, dialogToken);
+	issue_p2p_presence_resp(pwdinfo, get_addr_2_ptr(pframe), status, dialogToken);
 
 	return true;
 }
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 9d8da5ec8948..3aad16af3a60 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -632,7 +632,7 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 		}
 	} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
 		memcpy(pattrib->dst, get_addr_1_ptr(ptr), ETH_ALEN);
-		memcpy(pattrib->src, GetAddr2Ptr(ptr), ETH_ALEN);
+		memcpy(pattrib->src, get_addr_2_ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->bssid, GetAddr3Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
 		memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
@@ -719,7 +719,7 @@ static int ap2sta_data_frame(
 	} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE) &&
 		   check_fwstate(pmlmepriv, _FW_LINKED)) {
 		memcpy(pattrib->dst, get_addr_1_ptr(ptr), ETH_ALEN);
-		memcpy(pattrib->src, GetAddr2Ptr(ptr), ETH_ALEN);
+		memcpy(pattrib->src, get_addr_2_ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->bssid, GetAddr3Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
 		memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
@@ -833,7 +833,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 		struct sta_info *psta = NULL;
 
 		aid = get_aid(pframe);
-		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+		psta = rtw_get_stainfo(pstapriv, get_addr_2_ptr(pframe));
 
 		if (!psta || psta->aid != aid)
 			return _FAIL;
@@ -941,7 +941,7 @@ static int validate_recv_mgnt_frame(struct adapter *padapter,
 		return _SUCCESS;
 
 	/* for rx pkt statistics */
-	psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(precv_frame->rx_data));
+	psta = rtw_get_stainfo(&padapter->stapriv, get_addr_2_ptr(precv_frame->rx_data));
 	if (psta) {
 		psta->sta_stats.rx_mgnt_pkts++;
 		if (get_frame_subtype(precv_frame->rx_data) == WIFI_BEACON) {
@@ -1008,7 +1008,7 @@ static int validate_recv_data_frame(struct adapter *adapter,
 		break;
 	case 3:
 		memcpy(pattrib->ra, get_addr_1_ptr(ptr), ETH_ALEN);
-		memcpy(pattrib->ta, GetAddr2Ptr(ptr), ETH_ALEN);
+		memcpy(pattrib->ta, get_addr_2_ptr(ptr), ETH_ALEN);
 		ret = _FAIL;
 		break;
 	default:
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 4d4db68b967e..9ce45d31e16d 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -252,7 +252,7 @@ enum WIFI_REG_DOMAIN {
 
 #define get_addr_1_ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 4))
 
-#define GetAddr2Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 10))
+#define get_addr_2_ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 10))
 
 #define GetAddr3Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 16))
 
@@ -295,13 +295,13 @@ static inline unsigned char *get_sa(unsigned char *pframe)
 
 	switch (to_fr_ds) {
 	case 0x00:	/*  ToDs=0, FromDs=0 */
-		sa = GetAddr2Ptr(pframe);
+		sa = get_addr_2_ptr(pframe);
 		break;
 	case 0x01:	/*  ToDs=0, FromDs=1 */
 		sa = GetAddr3Ptr(pframe);
 		break;
 	case 0x02:	/*  ToDs=1, FromDs=0 */
-		sa = GetAddr2Ptr(pframe);
+		sa = get_addr_2_ptr(pframe);
 		break;
 	default:	/*  ToDs=1, FromDs=1 */
 		sa = GetAddr4Ptr(pframe);
@@ -320,7 +320,7 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 		sa = GetAddr3Ptr(pframe);
 		break;
 	case 0x01:	/*  ToDs=0, FromDs=1 */
-		sa = GetAddr2Ptr(pframe);
+		sa = get_addr_2_ptr(pframe);
 		break;
 	case 0x02:	/*  ToDs=1, FromDs=0 */
 		sa = get_addr_1_ptr(pframe);
-- 
2.25.1

