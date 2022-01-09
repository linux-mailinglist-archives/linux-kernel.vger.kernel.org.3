Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B774488CB6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiAIVym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiAIVye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:54:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89BC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 13:54:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k30so5677795wrd.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPRuMB0jxHDNDiMPDzjIW5DNAgL2LNRE1zZsfnCeADs=;
        b=sXgnP/nb9FxqdxVD3Skj7sgt4eS5leHgfZ9KDUhFFbEyljQSzyap4hp0y1A3SNNN7S
         202MujTsggWiOA8Zz9woN3dxzHClKiBOjzPVEoEhmZ9U5pEF0MJETrJXehG2vC9zMjrF
         tZlp9H8uT8C/rRmGFRf+Ux6yVvuEN7dFTehedcwPyRpW/wPy/EaF+ARdw6WuPGCVrF0r
         T+kxe9NBSqpaLQf2aap3aZdCvNBvw9pd8eUWQ2h0+Nf8hQJhpE8QYExQu8yopow6TmfR
         WcSdrgDKatvRz3DekB/QoJcQcrGCAf+9BACdxyKzcxKJiVTU/GK120QZDLRdvUrlMR30
         czpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPRuMB0jxHDNDiMPDzjIW5DNAgL2LNRE1zZsfnCeADs=;
        b=4jSZjFyOnIFk49ARGYKQXn3y9O8xJdzdmFpTdKDb+PhkGVnl2G1QefuNVRnpd8u1JD
         ssvRafUFJCfnQA/FUadqVPPZGgVp0BVihkNdgCKIz5ZJGzShPN8JEqeLnt0qcfcs0/Sv
         dhHk0QXTDQ8WwYlGLKPgUHpb8RmHnYfaxFdnthWNV/jcwD19CpUlj1pItW89JGAx8ooP
         Z6C4AJbrjNTgB4jq2NdF0gm8RE6Gv0MsjIArE23E8MeL2UumwvbrucyLvMoN/rqqERg0
         Op3wB22TERzPRNjEIGybQpV8GTruwQT0gzljJyK1VaFRyjFv7O1GpWiKOqYFzXGoQlqy
         ndNQ==
X-Gm-Message-State: AOAM532j+RBszRorxJWJMkIwNc8VjE7bvAY3RK2T1lYL8OksQ8RD8LdA
        xbDEnbF/Sd7X1L9NkS3D1RNd8A==
X-Google-Smtp-Source: ABdhPJzCG3VKkDVe5xKdRKjkEDxV42TatJAlgt8QCZWZ/Z58jwo+oBKmA67WKaol+maWKuW2JH5G+g==
X-Received: by 2002:adf:e491:: with SMTP id i17mr15381394wrm.44.1641765272524;
        Sun, 09 Jan 2022 13:54:32 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r13sm5065650wmq.28.2022.01.09.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:54:32 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] staging: r8188eu: convert DBG_88E calls in core/rtw_mlme.c
Date:   Sun,  9 Jan 2022 21:54:24 +0000
Message-Id: <20220109215427.887-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220109215427.887-1-phil@philpotter.co.uk>
References: <20220109215427.887-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DBG_88E macro calls in core/rtw_mlme.c to use netdev_dbg,
as their information may be useful to observers, and this gets the
driver closer to the point of being able to remove DBG_88E itself.
Also remove some unnecessary DBG_88E calls altogether as all they do
is print the function name.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 95 ++++++++++++++-----------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 394e8a5ce03c..189b48b17326 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -617,7 +617,9 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 	}
 
 	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0)) {
-		DBG_88E("desired_encmode: %d, privacy: %d\n", desired_encmode, privacy);
+		netdev_dbg(adapter->pnetdev,
+			   "desired_encmode: %d, privacy: %d\n",
+			   desired_encmode, privacy);
 		bselected = false;
 	}
 
@@ -734,8 +736,9 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 				rtw_indicate_connect(adapter);
 			} else {
-				DBG_88E("try_to_join, but select scanning queue fail, to_roaming:%d\n",
-					pmlmepriv->to_roaming);
+				netdev_dbg(adapter->pnetdev,
+					   "try_to_join, but select scanning queue fail, to_roaming:%d\n",
+					   pmlmepriv->to_roaming);
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
 					    _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)) {
@@ -909,7 +912,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.MacAddress);
 
 	if (psta) { /* update ptarget_sta */
-		DBG_88E("%s\n", __func__);
 		psta->aid  = pnetwork->join_res;
 		psta->mac_id = 0;
 		/* sta mode */
@@ -969,8 +971,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network  *cur_network = &pmlmepriv->cur_network;
 
-	DBG_88E("%s\n", __func__);
-
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
 	/*  some IEs in pnetwork is wrong, so we should use ptarget_wlan IEs */
@@ -1196,7 +1196,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	/* to do: init sta_info variable */
 	psta->qos_option = 0;
 	psta->mac_id = (uint)pstassoc->cam_id;
-	DBG_88E("%s\n", __func__);
+
 	/* for ad-hoc mode */
 	rtl8188e_SetHalODMVar(adapter, psta, true);
 	rtw_sta_media_status_rpt(adapter, psta, 1);
@@ -1239,7 +1239,9 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	else
 		mac_id = pstadel->mac_id;
 
-	DBG_88E("%s(mac_id=%d)=%pM\n", __func__, mac_id, pstadel->macaddr);
+	netdev_dbg(adapter->pnetdev,
+		   "(mac_id=%d)=%pM\n",
+		   mac_id, pstadel->macaddr);
 
 	if (mac_id >= 0) {
 		u16 media_status;
@@ -1330,7 +1332,7 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	int do_join_r;
 
-	DBG_88E("%s, fw_state=%x\n", __func__, get_fwstate(pmlmepriv));
+	netdev_dbg(adapter->pnetdev, "fw_state=%x\n", get_fwstate(pmlmepriv));
 
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 		return;
@@ -1341,15 +1343,19 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 		while (1) {
 			pmlmepriv->to_roaming--;
 			if (rtw_to_roaming(adapter) != 0) { /* try another */
-				DBG_88E("%s try another roaming\n", __func__);
+				netdev_dbg(adapter->pnetdev,
+					   "try another roaming\n");
 				do_join_r = rtw_do_join(adapter);
 				if (_SUCCESS != do_join_r) {
-					DBG_88E("%s roaming do_join return %d\n", __func__, do_join_r);
+					netdev_dbg(adapter->pnetdev,
+						   "roaming do_join return %d\n",
+						   do_join_r);
 					continue;
 				}
 				break;
 			} else {
-				DBG_88E("%s We've try roaming but fail\n", __func__);
+				netdev_dbg(adapter->pnetdev,
+					   "We've tried roaming but failed\n");
 				rtw_indicate_disconnect(adapter);
 				break;
 			}
@@ -1370,7 +1376,7 @@ void rtw_scan_timeout_handler (struct adapter *adapter)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	DBG_88E(FUNC_ADPT_FMT" fw_state=%x\n", FUNC_ADPT_ARG(adapter), get_fwstate(pmlmepriv));
+	netdev_dbg(adapter->pnetdev, "fw_state=%x\n", get_fwstate(pmlmepriv));
 	spin_lock_bh(&pmlmepriv->lock);
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	spin_unlock_bh(&pmlmepriv->lock);
@@ -1385,7 +1391,6 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 	if (pmlmepriv->scan_interval > 0) {
 		pmlmepriv->scan_interval--;
 		if (pmlmepriv->scan_interval == 0) {
-			DBG_88E("%s\n", __func__);
 			rtw_set_802_11_bssid_list_scan(padapter, NULL, 0);
 			pmlmepriv->scan_interval = SCAN_INTERVAL;/*  30*2 sec = 60sec */
 		}
@@ -1476,13 +1481,15 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 		updated = true;
 	}
 	if (updated) {
-		DBG_88E("[by_bssid:%u][assoc_ssid:%s]new candidate: %s(%pM rssi:%d\n",
-			pmlmepriv->assoc_by_bssid,
-			pmlmepriv->assoc_ssid.Ssid,
-			(*candidate)->network.Ssid.Ssid,
-			(*candidate)->network.MacAddress,
-			(int)(*candidate)->network.Rssi);
-		DBG_88E("[to_roaming:%u]\n", rtw_to_roaming(adapter));
+		netdev_dbg(adapter->pnetdev,
+			   "[by_bssid:%u][assoc_ssid:%s]new candidate: %s(%pM rssi:%d\n",
+			   pmlmepriv->assoc_by_bssid,
+			   pmlmepriv->assoc_ssid.Ssid,
+			   (*candidate)->network.Ssid.Ssid,
+			   (*candidate)->network.MacAddress,
+			   (int)(*candidate)->network.Rssi);
+		netdev_dbg(adapter->pnetdev,
+			   "[to_roaming:%u]\n", rtw_to_roaming(adapter));
 	}
 
 exit:
@@ -1520,18 +1527,20 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
 	}
 	if (!candidate) {
-		DBG_88E("%s: return _FAIL(candidate==NULL)\n", __func__);
+		netdev_dbg(adapter->pnetdev,
+			   "return _FAIL(candidate==NULL)\n");
 		ret = _FAIL;
 		goto exit;
 	} else {
-		DBG_88E("%s: candidate: %s(%pM ch:%u)\n", __func__,
-			candidate->network.Ssid.Ssid, candidate->network.MacAddress,
-			candidate->network.Configuration.DSConfig);
+		netdev_dbg(adapter->pnetdev, "candidate: %s(%pM ch:%u)\n",
+			   candidate->network.Ssid.Ssid, candidate->network.MacAddress,
+			   candidate->network.Configuration.DSConfig);
 	}
 
 	/*  check for situation of  _FW_LINKED */
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-		DBG_88E("%s: _FW_LINKED while ask_for_joinbss!!!\n", __func__);
+		netdev_dbg(adapter->pnetdev,
+			   "_FW_LINKED while ask_for_joinbss!!!\n");
 
 		rtw_disassoc_cmd(adapter, 0, true);
 		rtw_indicate_disconnect(adapter);
@@ -1542,10 +1551,9 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	if (supp_ant_div) {
 		u8 cur_ant;
 		GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &cur_ant);
-		DBG_88E("#### Opt_Ant_(%s), cur_Ant(%s)\n",
-			(2 == candidate->network.PhyInfo.Optimum_antenna) ? "A" : "B",
-			(2 == cur_ant) ? "A" : "B"
-		);
+		netdev_dbg(adapter->pnetdev, "Opt_Ant_(%s), cur_Ant(%s)\n",
+			   (candidate->network.PhyInfo.Optimum_antenna == 2) ? "A" : "B",
+			   (cur_ant == 2) ? "A" : "B");
 	}
 
 	ret = rtw_joinbss_cmd(adapter, candidate);
@@ -1617,8 +1625,10 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
 	psetkeyparm->set_tx = set_tx;
 	pmlmepriv->key_mask |= BIT(psetkeyparm->keyid);
-	DBG_88E("==> rtw_set_key algorithm(%x), keyid(%x), key_mask(%x)\n",
-		psetkeyparm->algorithm, psetkeyparm->keyid, pmlmepriv->key_mask);
+	netdev_dbg(adapter->pnetdev,
+		   "algorithm(%x), keyid(%x), key_mask(%x)\n",
+		   psetkeyparm->algorithm, psetkeyparm->keyid,
+		   pmlmepriv->key_mask);
 
 	switch (psetkeyparm->algorithm) {
 	case _WEP40_:
@@ -1970,8 +1980,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 	if ((!pmlmeinfo->HT_info_enable) || (!pmlmeinfo->HT_caps_enable))
 		return;
 
-	DBG_88E("+rtw_update_ht_cap()\n");
-
 	/* maybe needs check if ap supports rx ampdu. */
 	if ((!phtpriv->ampdu_enable) && (pregistrypriv->ampdu_enable == 1)) {
 		if (pregistrypriv->wifi_spec == 1)
@@ -2022,7 +2030,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 	/*  Config SM Power Save setting */
 	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & 0x0C) >> 2;
 	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		DBG_88E("%s(): WLAN_HT_CAP_SM_PS_STATIC\n", __func__);
+		netdev_dbg(padapter->pnetdev, "WLAN_HT_CAP_SM_PS_STATIC\n");
 
 	/*  Config current HT Protection mode. */
 	pmlmeinfo->HT_protection = pmlmeinfo->HT_info.infos[1] & 0x3;
@@ -2057,7 +2065,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
 		if (0 == issued) {
-			DBG_88E("rtw_issue_addbareq_cmd, p=%d\n", priority);
+			netdev_dbg(padapter->pnetdev, "p=%d\n", priority);
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
 			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
@@ -2085,9 +2093,11 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 		pnetwork = &pmlmepriv->cur_network;
 
 	if (0 < rtw_to_roaming(padapter)) {
-		DBG_88E("roaming from %s(%pM length:%d\n",
-			pnetwork->network.Ssid.Ssid, pnetwork->network.MacAddress,
-			pnetwork->network.Ssid.SsidLength);
+		netdev_dbg(padapter->pnetdev,
+			   "roaming from %s(%pM length:%d\n",
+			   pnetwork->network.Ssid.Ssid,
+			   pnetwork->network.MacAddress,
+			   pnetwork->network.Ssid.SsidLength);
 		memcpy(&pmlmepriv->assoc_ssid, &pnetwork->network.Ssid, sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
@@ -2097,13 +2107,16 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 			if (_SUCCESS == do_join_r) {
 				break;
 			} else {
-				DBG_88E("roaming do_join return %d\n", do_join_r);
+				netdev_dbg(padapter->pnetdev,
+					   "roaming do_join return %d\n",
+					   do_join_r);
 				pmlmepriv->to_roaming--;
 
 				if (0 < pmlmepriv->to_roaming) {
 					continue;
 				} else {
-					DBG_88E("%s(%d) -to roaming fail, indicate_disconnect\n", __func__, __LINE__);
+					netdev_dbg(padapter->pnetdev,
+						   "-to roaming fail, indicate_disconnect\n");
 					rtw_indicate_disconnect(padapter);
 					break;
 				}
-- 
2.33.1

