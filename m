Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90524B7C32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245311AbiBPBHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:07:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245277AbiBPBH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297FBC7916
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:16 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v12so858415wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtCkjxp6cTPKQb+Nsysc9H27MvJPw8Uk/TMHdrWhoaw=;
        b=Ex2ZDXWZEFayR995gPdPhFI2wO/rRpG1BRXcAlsPBqASjbxb+S0H2ZCpflbtUSTQTO
         /fuav78AzBU+FrZ0mIlJGmGOEEdWPVLuH2tjuKHJa6N8l2FC82SFib0Sy50DfIGdyBjv
         BZfpyjyaJB18Yps69YTpnNdsLIxZ1QUhUH8sMt29V9WU/kDcEP8ZZ2vREIPXsVJGXjTA
         fInm0wfCE6mdmzsCYU9z6gS7g+YmGfOwOe3raSmATGQwEcx5mJT4h89j0ii6FE/ytXOZ
         qmp1CosO07KdjVTvialjDufuAPaDRKaREXdg0fpRIog7Djj751HM6yxDQCgU6hGNeEdc
         VZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtCkjxp6cTPKQb+Nsysc9H27MvJPw8Uk/TMHdrWhoaw=;
        b=lM1w0x3HkglO39Cpf4QmZyPOS97erQMNDvJW+e80tRiCjP1tnWH+1j+xFBn7M53nsx
         FJ95EISkpYEuPVAqukQajdcmGSXkHiysyz5CclJa6Rb1cuoIdVAAkGy7GNvJiMcS++6R
         11zG/PWqTETj/48YrvLD2QOKv2rJ7VwbW90weue6S0qNenCcA1QcrkngenXRtPW3dXjx
         fYajfimsJZT1kHsPkh54epMHS9G0ZbYEK0ODlnIpThKcqycM2gM2TAZQtuS3xuycCnf/
         bM7f5jkRAH3R1mMWBEA4JXsF7l2vszwFXEhNDk4dJCFmwW4lKWGRpay6cT/SL5JUMJUy
         N+UQ==
X-Gm-Message-State: AOAM531yxnfJMJSnKIGqRUkS/gCOYFM2r3k3uqC3xYvHdIG8KbCsrWXr
        c7LwaCBVQHtT2mi39vyJQx+E7HS2FdYv3rgp
X-Google-Smtp-Source: ABdhPJxMhxnL2f8NkJVwZjeiVfQUFzJmIYxzvCFqXvjraU1gAWfEKQeH0Y7UUY3aDfAhhutfD5hWIw==
X-Received: by 2002:a05:6000:1a8e:b0:1e3:8f6:dc44 with SMTP id f14-20020a0560001a8e00b001e308f6dc44mr387684wry.57.1644973634499;
        Tue, 15 Feb 2022 17:07:14 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:13 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 04/15] staging: r8188eu: remove DBG_88E calls from core subdir
Date:   Wed, 16 Feb 2022 01:06:58 +0000
Message-Id: <20220216010709.791-5-phil@philpotter.co.uk>
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

Remove all remaining DBG_88E calls from the core subdirectory. After some
thought, it makes more sense to just entirely strip all of these calls,
so that debugging code in the driver can be more consistent and useful
going forwards.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_fw.c        | 10 -----
 drivers/staging/r8188eu/core/rtw_p2p.c       | 35 -----------------
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 30 ++-------------
 drivers/staging/r8188eu/core/rtw_recv.c      | 36 ++----------------
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 40 +-------------------
 5 files changed, 8 insertions(+), 143 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index ce0e4e3b21f9..6d07927397de 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -191,10 +191,8 @@ static int fw_free_to_go(struct adapter *padapter)
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
 	if (counter >= POLLING_READY_TIMEOUT_COUNT) {
-		DBG_88E("%s: chksum report fail! REG_MCUFWDL:0x%08x\n", __func__, value32);
 		return _FAIL;
 	}
-	DBG_88E("%s: Checksum report OK! REG_MCUFWDL:0x%08x\n", __func__, value32);
 
 	value32 = rtw_read32(padapter, REG_MCUFWDL);
 	value32 |= MCUFWDL_RDY;
@@ -208,13 +206,11 @@ static int fw_free_to_go(struct adapter *padapter)
 	do {
 		value32 = rtw_read32(padapter, REG_MCUFWDL);
 		if (value32 & WINTINI_RDY) {
-			DBG_88E("%s: Polling FW ready success!! REG_MCUFWDL:0x%08x\n", __func__, value32);
 			return _SUCCESS;
 		}
 		udelay(5);
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
-	DBG_88E("%s: Polling FW ready fail!! REG_MCUFWDL:0x%08x\n", __func__, value32);
 	return _FAIL;
 }
 
@@ -306,20 +302,14 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 		if (ret == _SUCCESS ||
 		    (rtw_get_passing_time_ms(fwdl_start_time) > 500 && write_fw_retry++ >= 3))
 			break;
-
-		DBG_88E("%s write_fw_retry:%u, time after fwdl_start_time:%ums\n",
-			__func__, write_fw_retry, rtw_get_passing_time_ms(fwdl_start_time)
-		);
 	}
 	fw_download_enable(padapter, false);
 	if (ret != _SUCCESS) {
-		DBG_88E("DL Firmware failed!\n");
 		goto exit;
 	}
 
 	ret = fw_free_to_go(padapter);
 	if (ret != _SUCCESS) {
-		DBG_88E("DL Firmware failed!\n");
 		goto exit;
 	}
 
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 50b4fca869a7..8f4bad399bc4 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -30,8 +30,6 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
 	struct adapter *padapter = pwdinfo->padapter;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_88E("%s\n", __func__);
-
 	pdata_attr = kzalloc(MAX_P2P_IE_LEN, GFP_KERNEL);
 
 	pstart = pdata_attr;
@@ -123,8 +121,6 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
 	u8	oui_subtype = P2P_GO_DISC_REQUEST;
 	u8	dialogToken = 0;
 
-	DBG_88E("[%s]\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		return;
@@ -182,8 +178,6 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 	u8 p2pie[8] = { 0x00 };
 	u32 p2pielen = 0;
 
-	DBG_88E("[%s]\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		return;
@@ -329,8 +323,6 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 	u8 noa_attr_content[32] = { 0x00 };
 	u32 p2pielen = 0;
 
-	DBG_88E("[%s]\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		return;
@@ -827,16 +819,13 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 	p2p_ie = rtw_get_p2p_ie(ies, ies_len, NULL, &p2p_ielen);
 
 	if (!p2p_ie) {
-		DBG_88E("[%s] P2P IE not Found!!\n", __func__);
 		status_code =  P2P_STATUS_FAIL_INVALID_PARAM;
 	} else {
-		DBG_88E("[%s] P2P IE Found!!\n", __func__);
 	}
 
 	while (p2p_ie) {
 		/* Check P2P Capability ATTR */
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_CAPABILITY, (u8 *)&le_tmp, (uint *)&attr_contentlen)) {
-			DBG_88E("[%s] Got P2P Capability Attr!!\n", __func__);
 			cap_attr = le16_to_cpu(le_tmp);
 			psta->dev_cap = cap_attr & 0xff;
 		}
@@ -845,7 +834,6 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 
 		/* Check P2P Device Info ATTR */
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_DEVICE_INFO, NULL, (uint *)&attr_contentlen)) {
-			DBG_88E("[%s] Got P2P DEVICE INFO Attr!!\n", __func__);
 			pattr_content = kzalloc(attr_contentlen, GFP_KERNEL);
 			pbuf = pattr_content;
 			if (pattr_content) {
@@ -1004,7 +992,6 @@ u8 process_p2p_provdisc_req(struct wifidirect_info *pwdinfo,  u8 *pframe, uint l
 			issue_p2p_provision_resp(pwdinfo, GetAddr2Ptr(pframe), frame_body, uconfig_method);
 		}
 	}
-	DBG_88E("[%s] config method = %s\n", __func__, pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req);
 	return true;
 }
 
@@ -1083,7 +1070,6 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 				memcpy(pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req, "pbc", 3);
 		}
 	} else {
-		DBG_88E("[%s] WPS IE not Found!!\n", __func__);
 		result = P2P_STATUS_FAIL_INCOMPATIBLE_PARAM;
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 		return result;
@@ -1101,7 +1087,6 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 	p2p_ie = rtw_get_p2p_ie(ies, ies_len, NULL, &p2p_ielen);
 
 	if (!p2p_ie) {
-		DBG_88E("[%s] P2P IE not Found!!\n", __func__);
 		result = P2P_STATUS_FAIL_INCOMPATIBLE_PARAM;
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 	}
@@ -1119,7 +1104,6 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_ING);
 
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GO_INTENT, &attr_content, &attr_contentlen)) {
-			DBG_88E("[%s] GO Intent = %d, tie = %d\n", __func__, attr_content >> 1, attr_content & 0x01);
 			pwdinfo->peer_intent = attr_content;	/*	include both intent and tie breaker values. */
 
 			if (pwdinfo->intent == (pwdinfo->peer_intent >> 1)) {
@@ -1157,7 +1141,6 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 			ch_num_inclusioned = rtw_p2p_ch_inclusion(&padapter->mlmeextpriv, peer_ch_list, peer_ch_num, ch_list_inclusioned);
 
 			if (ch_num_inclusioned == 0) {
-				DBG_88E("[%s] No common channel in channel list!\n", __func__);
 				result = P2P_STATUS_FAIL_NO_COMMON_CH;
 				rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 				break;
@@ -1178,11 +1161,9 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 						 *	Change our operating channel as peer's for compatibility.
 						 */
 						pwdinfo->operating_channel = peer_operating_ch;
-						DBG_88E("[%s] Change op ch to %02x as peer's\n", __func__, pwdinfo->operating_channel);
 					} else {
 						/*  Take first channel of ch_list_inclusioned as operating channel */
 						pwdinfo->operating_channel = ch_list_inclusioned[0];
-						DBG_88E("[%s] Change op ch to %02x\n", __func__, pwdinfo->operating_channel);
 					}
 				}
 			}
@@ -1210,7 +1191,6 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 
 	if (rtw_get_wps_ie(ies, ies_len, NULL, &wps_ielen)) {
 	} else {
-		DBG_88E("[%s] WPS IE not Found!!\n", __func__);
 		result = P2P_STATUS_FAIL_INCOMPATIBLE_PARAM;
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 	}
@@ -1233,7 +1213,6 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 		while (p2p_ie) {	/*	Found the P2P IE. */
 			rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_STATUS, &attr_content, &attr_contentlen);
 			if (attr_contentlen == 1) {
-				DBG_88E("[%s] Status = %d\n", __func__, attr_content);
 				if (attr_content == P2P_STATUS_SUCCESS) {
 					/*	Do nothing. */
 				} else {
@@ -1259,7 +1238,6 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 			attr_content = 0x00;
 			attr_contentlen = 0;
 			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GO_INTENT, &attr_content, &attr_contentlen)) {
-				DBG_88E("[%s] GO Intent = %d, tie = %d\n", __func__, attr_content >> 1, attr_content & 0x01);
 				pwdinfo->peer_intent = attr_content;	/*	include both intent and tie breaker values. */
 
 				if (pwdinfo->intent == (pwdinfo->peer_intent >> 1)) {
@@ -1297,19 +1275,16 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 
 			attr_contentlen = 0;
 			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH, operatingch_info, &attr_contentlen)) {
-				DBG_88E("[%s] Peer's operating channel = %d\n", __func__, operatingch_info[4]);
 				pwdinfo->peer_operating_ch = operatingch_info[4];
 			}
 
 			/*	Try to get the channel list information */
 			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_CH_LIST, pwdinfo->channel_list_attr, &pwdinfo->channel_list_attr_len)) {
-				DBG_88E("[%s] channel list attribute found, len = %d\n", __func__,  pwdinfo->channel_list_attr_len);
 
 				peer_ch_num = rtw_p2p_get_peer_ch_list(pwdinfo, pwdinfo->channel_list_attr, pwdinfo->channel_list_attr_len, peer_ch_list);
 				ch_num_inclusioned = rtw_p2p_ch_inclusion(&padapter->mlmeextpriv, peer_ch_list, peer_ch_num, ch_list_inclusioned);
 
 				if (ch_num_inclusioned == 0) {
-					DBG_88E("[%s] No common channel in channel list!\n", __func__);
 					result = P2P_STATUS_FAIL_NO_COMMON_CH;
 					rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 					break;
@@ -1330,16 +1305,13 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 							 *	Change our operating channel as peer's for compatibility.
 							 */
 							pwdinfo->operating_channel = peer_operating_ch;
-							DBG_88E("[%s] Change op ch to %02x as peer's\n", __func__, pwdinfo->operating_channel);
 						} else {
 							/*  Take first channel of ch_list_inclusioned as operating channel */
 							pwdinfo->operating_channel = ch_list_inclusioned[0];
-							DBG_88E("[%s] Change op ch to %02x\n", __func__, pwdinfo->operating_channel);
 						}
 					}
 				}
 			} else {
-				DBG_88E("[%s] channel list attribute not found!\n", __func__);
 			}
 
 			/*	Try to get the group id information if peer is GO */
@@ -1376,7 +1348,6 @@ u8 process_p2p_group_negotation_confirm(struct wifidirect_info *pwdinfo, u8 *pfr
 		pwdinfo->negotiation_dialog_token = 1;
 		rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_STATUS, &attr_content, &attr_contentlen);
 		if (attr_contentlen == 1) {
-			DBG_88E("[%s] Status = %d\n", __func__, attr_content);
 			result = attr_content;
 
 			if (attr_content == P2P_STATUS_SUCCESS) {
@@ -1408,14 +1379,12 @@ u8 process_p2p_group_negotation_confirm(struct wifidirect_info *pwdinfo, u8 *pfr
 		attr_contentlen = 0;
 		memset(groupid, 0x00, 38);
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GROUP_ID, groupid, &attr_contentlen)) {
-			DBG_88E("[%s] Ssid = %s, ssidlen = %zu\n", __func__, &groupid[ETH_ALEN], strlen(&groupid[ETH_ALEN]));
 			memcpy(pwdinfo->groupid_info.go_device_addr, &groupid[0], ETH_ALEN);
 			memcpy(pwdinfo->groupid_info.ssid, &groupid[6], attr_contentlen - ETH_ALEN);
 		}
 
 		attr_contentlen = 0;
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH, operatingch_info, &attr_contentlen)) {
-			DBG_88E("[%s] Peer's operating channel = %d\n", __func__, operatingch_info[4]);
 			pwdinfo->peer_operating_ch = operatingch_info[4];
 		}
 
@@ -1653,7 +1622,6 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 			if (pwdinfo->ctwindow > 0) {
 				if (pwrpriv->smart_ps != 0) {
 					pwrpriv->smart_ps = 0;
-					DBG_88E("%s(): Enter CTW, change SmartPS\n", __func__);
 					SetHwReg8188EU(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&padapter->pwrctrlpriv.pwr_mode));
 				}
 			}
@@ -1723,7 +1691,6 @@ static void reset_ch_sitesurvey_timer_process(struct timer_list *t)
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
 		return;
 
-	DBG_88E("[%s] In\n", __func__);
 	/*	Reset the operation channel information */
 	pwdinfo->rx_invitereq_info.operation_ch[0] = 0;
 	pwdinfo->rx_invitereq_info.scan_op_ch_only = 0;
@@ -1737,7 +1704,6 @@ static void reset_ch_sitesurvey_timer_process2(struct timer_list *t)
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
 		return;
 
-	DBG_88E("[%s] In\n", __func__);
 	/*	Reset the operation channel information */
 	pwdinfo->p2p_info.operation_ch[0] = 0;
 	pwdinfo->p2p_info.scan_op_ch_only = 0;
@@ -1778,7 +1744,6 @@ static void pre_tx_scan_timer_process(struct timer_list *t)
 		if (pwdinfo->invitereq_info.benable)
 			p2p_protocol_wk_cmd(adapter, P2P_PRE_TX_INVITEREQ_PROCESS_WK);
 	} else {
-		DBG_88E("[%s] p2p_state is %d, ignore!!\n", __func__, rtw_p2p_state(pwdinfo));
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index ff35685eaa12..db7074bf5741 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -26,7 +26,6 @@ void ips_enter(struct adapter *padapter)
 	pwrpriv->ips_mode = pwrpriv->ips_mode_req;
 
 	pwrpriv->ips_enter_cnts++;
-	DBG_88E("==>ips_enter cnts:%d\n", pwrpriv->ips_enter_cnts);
 	if (rf_off == pwrpriv->change_rfpwrstate) {
 		pwrpriv->bpower_saving = true;
 
@@ -55,7 +54,6 @@ int ips_leave(struct adapter *padapter)
 		pwrpriv->bips_processing = true;
 		pwrpriv->change_rfpwrstate = rf_on;
 		pwrpriv->ips_leave_cnts++;
-		DBG_88E("==>ips_leave cnts:%d\n", pwrpriv->ips_leave_cnts);
 
 		result = rtw_ips_pwr_up(padapter);
 		if (result == _SUCCESS) {
@@ -63,7 +61,6 @@ int ips_leave(struct adapter *padapter)
 		}
 
 		if ((_WEP40_ == psecuritypriv->dot11PrivacyAlgrthm) || (_WEP104_ == psecuritypriv->dot11PrivacyAlgrthm)) {
-			DBG_88E("==>%s, channel(%d), processing(%x)\n", __func__, padapter->mlmeextpriv.cur_channel, pwrpriv->bips_processing);
 			set_channel_bwmode(padapter, padapter->mlmeextpriv.cur_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 			for (keyid = 0; keyid < 4; keyid++) {
 				if (pmlmepriv->key_mask & BIT(keyid)) {
@@ -75,7 +72,6 @@ int ips_leave(struct adapter *padapter)
 			}
 		}
 
-		DBG_88E("==> ips_leave.....LED(0x%08x)...\n", rtw_read32(padapter, 0x4c));
 		pwrpriv->bips_processing = false;
 
 		pwrpriv->bkeepfwalive = false;
@@ -126,7 +122,6 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 void rtw_ps_processor(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	pwrpriv->ps_processing = true;
 
@@ -140,7 +135,6 @@ void rtw_ps_processor(struct adapter *padapter)
 		goto exit;
 
 	if ((pwrpriv->rf_pwrstate == rf_on) && ((pwrpriv->pwr_state_check_cnts % 4) == 0)) {
-		DBG_88E("==>%s .fw_state(%x)\n", __func__, get_fwstate(pmlmepriv));
 		pwrpriv->change_rfpwrstate = rf_off;
 
 		ips_enter(padapter);
@@ -179,7 +173,6 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 	if (pwrpriv->bInSuspend)
 		return false;
 	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && !padapter->securitypriv.binstallGrpkey) {
-		DBG_88E("Group handshake still in progress !!!\n");
 		return false;
 	}
 	return true;
@@ -205,14 +198,12 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 	/* if (pwrpriv->pwr_mode == PS_MODE_ACTIVE) */
 	if (ps_mode == PS_MODE_ACTIVE) {
 		if (pwdinfo->opp_ps == 0) {
-			DBG_88E("rtw_set_ps_mode: Leave 802.11 power save\n");
 			pwrpriv->pwr_mode = ps_mode;
 			SetHwReg8188EU(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
 			pwrpriv->bFwCurrentInPSMode = false;
 		}
 	} else {
 		if (PS_RDY_CHECK(padapter)) {
-			DBG_88E("%s: Enter 802.11 power save\n", __func__);
 			pwrpriv->bFwCurrentInPSMode = true;
 			pwrpriv->pwr_mode = ps_mode;
 			pwrpriv->smart_ps = smart_ps;
@@ -247,13 +238,11 @@ s32 LPS_RF_ON_check(struct adapter *padapter, u32 delay_ms)
 
 		if (padapter->bSurpriseRemoved) {
 			err = -2;
-			DBG_88E("%s: device surprise removed!!\n", __func__);
 			break;
 		}
 
 		if (rtw_get_passing_time_ms(start_time) > delay_ms) {
 			err = -1;
-			DBG_88E("%s: Wait for FW LPS leave more than %u ms!!!\n", __func__, delay_ms);
 			break;
 		}
 		rtw_usleep_os(100);
@@ -278,7 +267,6 @@ void LPS_Enter(struct adapter *padapter)
 		if (pwrpriv->LpsIdleCount >= 2) { /*   4 Sec */
 			if (pwrpriv->pwr_mode == PS_MODE_ACTIVE) {
 				pwrpriv->bpower_saving = true;
-				DBG_88E("%s smart_ps:%d\n", __func__, pwrpriv->smart_ps);
 				/* For Tenda W311R IOT issue */
 				rtw_set_ps_mode(padapter, pwrpriv->power_mgnt,
 						pwrpriv->smart_ps, 0x40);
@@ -377,13 +365,12 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		pwrpriv->ips_deny_time = jiffies + rtw_ms_to_systime(ips_deffer_ms);
 
 	if (pwrpriv->ps_processing) {
-		DBG_88E("%s wait ps_processing...\n", __func__);
 		while (pwrpriv->ps_processing && rtw_get_passing_time_ms(start) <= 3000)
 			msleep(10);
 		if (pwrpriv->ps_processing)
-			DBG_88E("%s wait ps_processing timeout\n", __func__);
+			;
 		else
-			DBG_88E("%s wait ps_processing done\n", __func__);
+			;
 	}
 
 	/* System suspend is not allowed to wakeup */
@@ -393,9 +380,9 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		       (rtw_get_passing_time_ms(start) <= 500)))
 				msleep(10);
 		if (pwrpriv->bInSuspend)
-			DBG_88E("%s wait bInSuspend timeout\n", __func__);
+			;
 		else
-			DBG_88E("%s wait bInSuspend done\n", __func__);
+			;
 	}
 
 	/* I think this should be check in IPS, LPS, autosuspend functions... */
@@ -404,9 +391,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		goto exit;
 	}
 	if (rf_off == pwrpriv->rf_pwrstate) {
-		DBG_88E("%s call ips_leave....\n", __func__);
 		if (_FAIL ==  ips_leave(padapter)) {
-			DBG_88E("======> ips_leave fail.............\n");
 			ret = _FAIL;
 			goto exit;
 		}
@@ -415,11 +400,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 	/* TODO: the following checking need to be merged... */
 	if (padapter->bDriverStopped || !padapter->bup ||
 	    !padapter->hw_init_completed) {
-		DBG_88E("%s: bDriverStopped=%d, bup=%d, hw_init_completed =%u\n"
-			, caller
-			, padapter->bDriverStopped
-			, padapter->bup
-			, padapter->hw_init_completed);
 		ret = false;
 		goto exit;
 	}
@@ -457,11 +437,9 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
 
 	if (mode == IPS_NORMAL || mode == IPS_LEVEL_2) {
 		rtw_ips_mode_req(pwrctrlpriv, mode);
-		DBG_88E("%s %s\n", __func__, mode == IPS_NORMAL ? "IPS_NORMAL" : "IPS_LEVEL_2");
 		return 0;
 	} else if (mode == IPS_NONE) {
 		rtw_ips_mode_req(pwrctrlpriv, mode);
-		DBG_88E("%s %s\n", __func__, "IPS_NONE");
 		if ((padapter->bSurpriseRemoved == 0) && (_FAIL == rtw_pwr_wakeup(padapter)))
 			return -EFAULT;
 	} else {
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index acc0dd87b62e..0f8f757de02a 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -240,7 +240,6 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 	struct recv_frame *pending_frame;
 	while ((pending_frame = rtw_alloc_recvframe(&adapter->recvpriv.uc_swdec_pending_queue))) {
 		rtw_free_recvframe(pending_frame, &adapter->recvpriv.free_recv_queue);
-		DBG_88E("%s: dequeue uc_swdec_pending_queue\n", __func__);
 		cnt++;
 	}
 
@@ -272,7 +271,6 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 
 				if (!psecuritypriv) {
 					res = _FAIL;
-					DBG_88E("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n");
 					goto exit;
 				}
 			} else {
@@ -303,9 +301,7 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 
 				if ((prxattrib->bdecrypted) && (brpt_micerror)) {
 					rtw_handle_tkip_mic_err(adapter, (u8)is_multicast_ether_addr(prxattrib->ra));
-					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
 				} else {
-					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
 				}
 				res = _FAIL;
 			} else {
@@ -336,8 +332,6 @@ static struct recv_frame *decryptor(struct adapter *padapter, struct recv_frame
 		prxattrib->key_index = (((iv[3]) >> 6) & 0x3);
 
 		if (prxattrib->key_index > WEP_KEYS) {
-			DBG_88E("prxattrib->key_index(%d)>WEP_KEYS\n", prxattrib->key_index);
-
 			switch (prxattrib->encrypt) {
 			case _WEP40_:
 			case _WEP104_:
@@ -686,7 +680,6 @@ static int ap2sta_data_frame(
 		    !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
 			if (!bmcast) {
-				DBG_88E("issue_deauth to the nonassociated ap=%pM for the reason(7)\n", (pattrib->bssid));
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 			}
 
@@ -737,8 +730,6 @@ static int ap2sta_data_frame(
 		if (!memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && (!bmcast)) {
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
 			if (!*psta) {
-				DBG_88E("issue_deauth to the ap =%pM for the reason(7)\n", (pattrib->bssid));
-
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 			}
 		}
@@ -771,8 +762,6 @@ static int sta2ap_data_frame(struct adapter *adapter,
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
 		if (!*psta) {
-			DBG_88E("issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
-
 			issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 
 			ret = RTW_RX_HANDLED;
@@ -797,7 +786,6 @@ static int sta2ap_data_frame(struct adapter *adapter,
 			ret = RTW_RX_HANDLED;
 			goto exit;
 		}
-		DBG_88E("issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
 		issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 		ret = RTW_RX_HANDLED;
 		goto exit;
@@ -862,7 +850,6 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 			return _FAIL;
 
 		if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
-			DBG_88E("%s alive check-rx ps-poll\n", __func__);
 			psta->expire_to = pstapriv->expire_to;
 			psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
 		}
@@ -903,12 +890,9 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 			} else {
 				if (pstapriv->tim_bitmap & BIT(psta->aid)) {
 					if (psta->sleepq_len == 0) {
-						DBG_88E("no buffered packets to xmit\n");
-
 						/* issue nulldata with More data bit = 0 to indicate we have no buffered packets */
 						issue_nulldata(padapter, psta->hwaddr, 0, 0, 0);
 					} else {
-						DBG_88E("error!psta->sleepq_len=%d\n", psta->sleepq_len);
 						psta->sleepq_len = 0;
 					}
 
@@ -1115,31 +1099,21 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	GetHalDefVar8188EUsb(adapter, HAL_DEF_DBG_DUMP_RXPKT, &bDumpRxPkt);
 	if (bDumpRxPkt == 1) {/* dump all rx packets */
 		int i;
-		DBG_88E("#############################\n");
 
 		for (i = 0; i < 64; i = i + 8)
-			DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr + i),
-				*(ptr + i + 1), *(ptr + i + 2), *(ptr + i + 3), *(ptr + i + 4), *(ptr + i + 5), *(ptr + i + 6), *(ptr + i + 7));
-		DBG_88E("#############################\n");
+			;
 	} else if (bDumpRxPkt == 2) {
 		if (type == WIFI_MGT_TYPE) {
 			int i;
-			DBG_88E("#############################\n");
 
 			for (i = 0; i < 64; i = i + 8)
-				DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr + i),
-					*(ptr + i + 1), *(ptr + i + 2), *(ptr + i + 3), *(ptr + i + 4), *(ptr + i + 5), *(ptr + i + 6), *(ptr + i + 7));
-			DBG_88E("#############################\n");
+				;
 		}
 	} else if (bDumpRxPkt == 3) {
 		if (type == WIFI_DATA_TYPE) {
 			int i;
-			DBG_88E("#############################\n");
-
 			for (i = 0; i < 64; i = i + 8)
-				DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr + i),
-					*(ptr + i + 1), *(ptr + i + 2), *(ptr + i + 3), *(ptr + i + 4), *(ptr + i + 5), *(ptr + i + 6), *(ptr + i + 7));
-			DBG_88E("#############################\n");
+				;
 		}
 	}
 	switch (type) {
@@ -1446,7 +1420,6 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		nSubframe_Length = RTW_GET_BE16(pdata + 12);
 
 		if (a_len < ETH_HLEN + nSubframe_Length) {
-			DBG_88E("nRemain_Length is %d and nSubframe_Length is : %d\n", a_len, nSubframe_Length);
 			goto exit;
 		}
 
@@ -1467,7 +1440,6 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 				sub_skb->len = nSubframe_Length;
 				skb_set_tail_pointer(sub_skb, nSubframe_Length);
 			} else {
-				DBG_88E("skb_clone() Fail!!! , nr_subframes=%d\n", nr_subframes);
 				break;
 			}
 		}
@@ -1475,7 +1447,6 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		subframes[nr_subframes++] = sub_skb;
 
 		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
-			DBG_88E("ParseSubframe(): Too many Subframes! Packets dropped!\n");
 			break;
 		}
 
@@ -1871,7 +1842,6 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 		     psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPAPSK &&
 		     !psecuritypriv->busetkipkey) {
 			rtw_enqueue_recvframe(rframe, &padapter->recvpriv.uc_swdec_pending_queue);
-			DBG_88E("%s: no key, enqueue uc_swdec_pending_queue\n", __func__);
 			if (recvpriv->free_recvframe_cnt < NR_RECVFRAME / 4) {
 				/* to prevent from recvframe starvation,
 				 * get recvframe from uc_swdec_pending_queue to
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index c6288c2d5f33..abc2386dc8d9 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -335,7 +335,7 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 	u8 center_ch;
 
 	if (padapter->bNotifyChannelChange)
-		DBG_88E("[%s] ch = %d, offset = %d, bwmode = %d\n", __func__, channel, channel_offset, bwmode);
+		;
 
 	if ((bwmode == HT_CHANNEL_WIDTH_20) ||
 	    (channel_offset == HAL_PRIME_CHNL_OFFSET_DONT_CARE)) {
@@ -572,8 +572,6 @@ void WMMOnAssocRsp(struct adapter *padapter)
 			edca[XMIT_VO_QUEUE] = acParm;
 			break;
 		}
-
-		DBG_88E("WMM(%x): %x, %x\n", ACI, ACM, acParm);
 	}
 
 	if (padapter->registrypriv.acm_method == 1)
@@ -610,7 +608,6 @@ void WMMOnAssocRsp(struct adapter *padapter)
 
 	for (i = 0; i < 4; i++) {
 		pxmitpriv->wmm_para_seq[i] = inx[i];
-		DBG_88E("wmm_para_seq(%d): %d\n", i, pxmitpriv->wmm_para_seq[i]);
 	}
 }
 
@@ -758,8 +755,6 @@ void HTOnAssocRsp(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable)) {
 		pmlmeinfo->HT_enable = 1;
 	} else {
@@ -858,13 +853,10 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	len = packet_len - sizeof(struct rtw_ieee80211_hdr_3addr);
 
 	if (len > MAX_IE_SZ) {
-		DBG_88E("%s IE too long for survey event\n", __func__);
 		return _FAIL;
 	}
 
 	if (memcmp(cur_network->network.MacAddress, pbssid, 6)) {
-		DBG_88E("Oops: rtw_check_network_encrypt linked but recv other bssid bcn\n%pM %pM\n",
-			(pbssid), (cur_network->network.MacAddress));
 		return true;
 	}
 
@@ -902,11 +894,6 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	}
 	if (ht_cap_info != cur_network->BcnInfo.ht_cap_info ||
 	    ((ht_info_infos_0 & 0x03) != (cur_network->BcnInfo.ht_info_infos_0 & 0x03))) {
-			DBG_88E("%s bcn now: ht_cap_info:%x ht_info_infos_0:%x\n", __func__,
-				ht_cap_info, ht_info_infos_0);
-			DBG_88E("%s bcn link: ht_cap_info:%x ht_info_infos_0:%x\n", __func__,
-				cur_network->BcnInfo.ht_cap_info, cur_network->BcnInfo.ht_info_infos_0);
-			DBG_88E("%s bw mode change, disconnect\n", __func__);
 			/* bcn_info_update */
 			cur_network->BcnInfo.ht_cap_info = ht_cap_info;
 			cur_network->BcnInfo.ht_info_infos_0 = ht_info_infos_0;
@@ -923,20 +910,16 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 			if (pht_info) {
 					bcn_channel = pht_info->primary_channel;
 			} else { /* we don't find channel IE, so don't check it */
-					DBG_88E("Oops: %s we don't find channel IE, so don't check it\n", __func__);
 					bcn_channel = Adapter->mlmeextpriv.cur_channel;
 			}
 	}
 	if (bcn_channel != Adapter->mlmeextpriv.cur_channel) {
-			DBG_88E("%s beacon channel:%d cur channel:%d disconnect\n", __func__,
-				bcn_channel, Adapter->mlmeextpriv.cur_channel);
 			goto _mismatch;
 	}
 
 	/* checking SSID */
 	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 	if (!p) {
-		DBG_88E("%s marc: cannot find SSID for survey event\n", __func__);
 		hidden_ssid = true;
 	} else {
 		hidden_ssid = false;
@@ -953,7 +936,6 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
 	    bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
 		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
-			DBG_88E("%s(), SSID is not match return FAIL\n", __func__);
 			goto _mismatch;
 		}
 	}
@@ -967,7 +949,6 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 		bssid->Privacy = 0;
 
 	if (cur_network->network.Privacy != bssid->Privacy) {
-		DBG_88E("%s(), privacy is not match return FAIL\n", __func__);
 		goto _mismatch;
 	}
 
@@ -983,7 +964,6 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol) {
-		DBG_88E("%s(): enctyp is not match , return FAIL\n", __func__);
 		goto _mismatch;
 	}
 
@@ -999,14 +979,10 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 		}
 
 		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
-			DBG_88E("%s pairwise_cipher(%x:%x) or group_cipher(%x:%x) is not match , return FAIL\n", __func__,
-				pairwise_cipher, cur_network->BcnInfo.pairwise_cipher,
-				group_cipher, cur_network->BcnInfo.group_cipher);
 			goto _mismatch;
 		}
 
 		if (is_8021x != cur_network->BcnInfo.is_8021x) {
-			DBG_88E("%s authentication is not match , return FAIL\n", __func__);
 			goto _mismatch;
 		}
 	}
@@ -1257,38 +1233,29 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 		case _VENDOR_SPECIFIC_IE_:
 			if ((!memcmp(pIE->data, ARTHEROS_OUI1, 3)) ||
 			    (!memcmp(pIE->data, ARTHEROS_OUI2, 3))) {
-				DBG_88E("link to Artheros AP\n");
 				return HT_IOT_PEER_ATHEROS;
 			} else if ((!memcmp(pIE->data, BROADCOM_OUI1, 3)) ||
 				   (!memcmp(pIE->data, BROADCOM_OUI2, 3))) {
-				DBG_88E("link to Broadcom AP\n");
 				return HT_IOT_PEER_BROADCOM;
 			} else if (!memcmp(pIE->data, MARVELL_OUI, 3)) {
-				DBG_88E("link to Marvell AP\n");
 				return HT_IOT_PEER_MARVELL;
 			} else if (!memcmp(pIE->data, RALINK_OUI, 3)) {
 				if (!ralink_vendor_flag) {
 					ralink_vendor_flag = 1;
 				} else {
-					DBG_88E("link to Ralink AP\n");
 					return HT_IOT_PEER_RALINK;
 				}
 			} else if (!memcmp(pIE->data, CISCO_OUI, 3)) {
-				DBG_88E("link to Cisco AP\n");
 				return HT_IOT_PEER_CISCO;
 			} else if (!memcmp(pIE->data, REALTEK_OUI, 3)) {
-				DBG_88E("link to Realtek 96B\n");
 				return HT_IOT_PEER_REALTEK;
 			} else if (!memcmp(pIE->data, AIRGOCAP_OUI, 3)) {
-				DBG_88E("link to Airgo Cap\n");
 				return HT_IOT_PEER_AIRGO;
 			} else if (!memcmp(pIE->data, EPIGRAM_OUI, 3)) {
 				epigram_vendor_flag = 1;
 				if (ralink_vendor_flag) {
-					DBG_88E("link to Tenda W311R AP\n");
 					return HT_IOT_PEER_TENDA;
 				} else {
-					DBG_88E("Capture EPIGRAM_OUI\n");
 				}
 			} else {
 				break;
@@ -1302,13 +1269,10 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 	}
 
 	if (ralink_vendor_flag && !epigram_vendor_flag) {
-		DBG_88E("link to Ralink AP\n");
 		return HT_IOT_PEER_RALINK;
 	} else if (ralink_vendor_flag && epigram_vendor_flag) {
-		DBG_88E("link to Tenda W311R AP\n");
 		return HT_IOT_PEER_TENDA;
 	} else {
-		DBG_88E("link to new AP\n");
 		return HT_IOT_PEER_UNKNOWN;
 	}
 }
@@ -1518,13 +1482,11 @@ int rtw_handle_dualmac(struct adapter *adapter, bool init)
 	if (init) {
 		if (!pbuddy_padapter) {
 			pbuddy_padapter = adapter;
-			DBG_88E("%s(): pbuddy_padapter == NULL, Set pbuddy_padapter\n", __func__);
 		} else {
 			adapter->pbuddy_adapter = pbuddy_padapter;
 			pbuddy_padapter->pbuddy_adapter = adapter;
 			/*  clear global value */
 			pbuddy_padapter = NULL;
-			DBG_88E("%s(): pbuddy_padapter exist, Exchange Information\n", __func__);
 		}
 	} else {
 		pbuddy_padapter = NULL;
-- 
2.34.1

