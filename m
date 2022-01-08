Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8864148802C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiAHA4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiAHAzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:55:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89385C061746
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:55:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a5so10157748wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 16:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4A+GWVppx0k+6VayF/g4VG0q89nXb0YltNB40/MnVxg=;
        b=Svtg8stNCIN+QP8+JNBf5hDQaGtEltMSSBbwRcw/wWQvK5bR8Dvdprp6bO848xyCKu
         fnBtIG67qVVz92F/IdGGaFsy3FIwa/Eg+cgxEnQ7ObNNZeEr82hcuG/h7+UKgRFo3VPC
         NsSab/Gxk+9xIcs+kESK0jX0/4+v9O36rJ4+u8J31TSwv/y5POcJJD3PpOyx8vcYpfEB
         6o8Sd4Fb5c46LVwrlBEaXBB4IyW66H9FnGsjLbP4AVvvDLh461ko7rAEd5xCFsTwefTA
         8HeJ0RHv6qSSgM4xsImIkpJWwrghGKiJu8rrgxl4UhOl67ZS7NbQAvhXM1t0d1qJYoQR
         3A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4A+GWVppx0k+6VayF/g4VG0q89nXb0YltNB40/MnVxg=;
        b=w6QC9m2rqk3qTJfXNd/ivaU1wlBFGKVV03dGGPCJhfyDP/x4CN6O+Jkn/bv3I7Slga
         G7T5QLfNfub+kcNf9rQZzfJ797xD0KDFe2XlYKr8HrD4je5SceBJpkEr9zx1iH1K5uJe
         9S/mS8VDAQ+2+NgeatWy9aOgC/kHzQK/HCasKeK7K9+yerlA5fLLVdB2JnCXTfq9CxyG
         k4dc7YqaWqC3X3pHPnJWhSWAugOQatX5jefeFTfvMkXlcx7fKneMiGBjx6JIAun66Rol
         uZF15aUa3zNTYokb3qkaiZaWoaCoWkY55Hz4d926kfXqYdmRKYi1pW6Oqrh4auD3WqFt
         gVfQ==
X-Gm-Message-State: AOAM533JCiG+HNCyUWQOHiFx9G4t/km/Hh3fe5QFv6yWRhQxigWQCNSu
        ib/yPXiUyXeR+uXPjV4sw6dD7Q==
X-Google-Smtp-Source: ABdhPJzbjQ9eSmYw935cwgRIp0WPD5QJFMqEPxiBptxu8naW8129cLca6ZLZb0GSffKxHnF6LjD9fw==
X-Received: by 2002:adf:d226:: with SMTP id k6mr54809007wrh.243.1641603352126;
        Fri, 07 Jan 2022 16:55:52 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id c18sm238853wrn.81.2022.01.07.16.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 16:55:51 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] staging: r8188eu: convert/remove DBG_88E calls in core/rtw_ap.c
Date:   Sat,  8 Jan 2022 00:55:46 +0000
Message-Id: <20220108005550.26264-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108005550.26264-1-phil@philpotter.co.uk>
References: <20220108005550.26264-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert DBG_88E macro calls in core/rtw_ap.c to use netdev_dbg when they
may display useful information, and remove erroneous DBG_88E calls
entirely.

This leaves six empty static functions which only had DBG_88E calls,
so just remove them:

update_bcn_fixed_ie
update_bcn_htcap_ie
update_bcn_htinfo_ie
update_bcn_rsn_ie
update_bcn_wpa_ie
update_bcn_wmm_ie

also modifying the if blocks/switch cases that invoke them to no longer do
so. This goes further towards the goal of removing this non-standard
debugging code.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 145 ++++++++++----------------
 1 file changed, 56 insertions(+), 89 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 1675e2e8439c..1486ec613458 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -179,8 +179,9 @@ void	expire_timeout_chk(struct adapter *padapter)
 				list_del_init(&psta->auth_list);
 				pstapriv->auth_list_cnt--;
 
-				DBG_88E("auth expire %6ph\n",
-					psta->hwaddr);
+				netdev_dbg(padapter->pnetdev,
+					   "auth expire %6ph\n",
+					   psta->hwaddr);
 
 				spin_unlock_bh(&pstapriv->auth_list_lock);
 
@@ -249,16 +250,19 @@ void	expire_timeout_chk(struct adapter *padapter)
 			list_del_init(&psta->asoc_list);
 			pstapriv->asoc_list_cnt--;
 
-			DBG_88E("asoc expire %pM, state = 0x%x\n", (psta->hwaddr), psta->state);
+			netdev_dbg(padapter->pnetdev,
+				   "asoc expire %pM, state = 0x%x\n",
+				   (psta->hwaddr), psta->state);
 			updated = ap_free_sta(padapter, psta, true, WLAN_REASON_DEAUTH_LEAVING);
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
 			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
 			    padapter->xmitpriv.free_xmitframe_cnt < (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2)) {
-				DBG_88E("%s sta:%pM, sleepq_len:%u, free_xmitframe_cnt:%u, asoc_list_cnt:%u, clear sleep_q\n", __func__,
-					(psta->hwaddr), psta->sleepq_len,
-					padapter->xmitpriv.free_xmitframe_cnt,
-					pstapriv->asoc_list_cnt);
+				netdev_dbg(padapter->pnetdev,
+					   "sta:%pM, sleepq_len:%u, free_xmitframe_cnt:%u, asoc_list_cnt:%u, clear sleep_q\n",
+					   (psta->hwaddr), psta->sleepq_len,
+					   padapter->xmitpriv.free_xmitframe_cnt,
+					   pstapriv->asoc_list_cnt);
 				wakeup_sta_to_xmit(padapter, psta);
 			}
 		}
@@ -288,19 +292,25 @@ void	expire_timeout_chk(struct adapter *padapter)
 
 			psta->keep_alive_trycnt++;
 			if (ret == _SUCCESS) {
-				DBG_88E("asoc check, sta(%pM) is alive\n", (psta->hwaddr));
+				netdev_dbg(padapter->pnetdev,
+					   "asoc check, sta(%pM) is alive\n",
+					   (psta->hwaddr));
 				psta->expire_to = pstapriv->expire_to;
 				psta->keep_alive_trycnt = 0;
 				continue;
 			} else if (psta->keep_alive_trycnt <= 3) {
-				DBG_88E("ack check for asoc expire, keep_alive_trycnt =%d\n", psta->keep_alive_trycnt);
+				netdev_dbg(padapter->pnetdev,
+					   "ack check for asoc expire, keep_alive_trycnt =%d\n",
+					   psta->keep_alive_trycnt);
 				psta->expire_to = 1;
 				continue;
 			}
 
 			psta->keep_alive_trycnt = 0;
 
-			DBG_88E("asoc expire %pM, state = 0x%x\n", (psta->hwaddr), psta->state);
+			netdev_dbg(padapter->pnetdev,
+				   "asoc expire %pM, state = 0x%x\n",
+				   (psta->hwaddr), psta->state);
 			spin_lock_bh(&pstapriv->asoc_list_lock);
 			list_del_init(&psta->asoc_list);
 			pstapriv->asoc_list_cnt--;
@@ -380,8 +390,9 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 
 		tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
 
-		DBG_88E("%s => mac_id:%d , raid:%d , bitmap = 0x%x, arg = 0x%x\n",
-			__func__, psta->mac_id, raid, tx_ra_bitmap, arg);
+		netdev_dbg(padapter->pnetdev,
+			   "mac_id:%d, raid:%d, bitmap = 0x%x, arg = 0x%x\n",
+			   psta->mac_id, raid, tx_ra_bitmap, arg);
 
 		/* bitmap[0:27] = tx_rate_bitmap */
 		/* bitmap[28:31]= Rate Adaptive id */
@@ -397,7 +408,9 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		psta->init_rate = init_rate;
 
 	} else {
-		DBG_88E("station aid %d exceed the max number\n", psta->aid);
+		netdev_dbg(padapter->pnetdev,
+			   "station aid %d exceed the max number\n",
+			   psta->aid);
 	}
 }
 
@@ -455,7 +468,9 @@ void update_bmc_sta(struct adapter *padapter)
 			arg = psta->mac_id & 0x1f;
 			arg |= BIT(7);
 			tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
-			DBG_88E("update_bmc_sta, mask = 0x%x, arg = 0x%x\n", tx_ra_bitmap, arg);
+			netdev_dbg(padapter->pnetdev,
+				   "mask = 0x%x, arg = 0x%x\n",
+				   tx_ra_bitmap, arg);
 
 			/* bitmap[0:27] = tx_rate_bitmap */
 			/* bitmap[28:31]= Rate Adaptive id */
@@ -474,7 +489,7 @@ void update_bmc_sta(struct adapter *padapter)
 		spin_unlock_bh(&psta->lock);
 
 	} else {
-		DBG_88E("add_RATid_bmc_sta error!\n");
+		netdev_dbg(padapter->pnetdev, "add_RATid_bmc_sta error!\n");
 	}
 }
 
@@ -496,7 +511,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 	u16 ap_cap_info;
 
 	psta->mac_id = psta->aid + 1;
-	DBG_88E("%s\n", __func__);
 
 	/* ap mode */
 	rtl8188e_SetHalODMVar(padapter, psta, true);
@@ -552,11 +566,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 	spin_unlock_bh(&psta->lock);
 }
 
-static void update_bcn_fixed_ie(struct adapter *padapter)
-{
-	DBG_88E("%s\n", __func__);
-}
-
 static void update_bcn_erpinfo_ie(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -566,7 +575,7 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 	unsigned char *p, *ie = pnetwork->IEs;
 	u32 len = 0;
 
-	DBG_88E("%s, ERP_enable =%d\n", __func__, pmlmeinfo->ERP_enable);
+	netdev_dbg(padapter->pnetdev, "ERP_enable = %d\n", pmlmeinfo->ERP_enable);
 
 	if (!pmlmeinfo->ERP_enable)
 		return;
@@ -591,31 +600,6 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 	}
 }
 
-static void update_bcn_htcap_ie(struct adapter *padapter)
-{
-	DBG_88E("%s\n", __func__);
-}
-
-static void update_bcn_htinfo_ie(struct adapter *padapter)
-{
-	DBG_88E("%s\n", __func__);
-}
-
-static void update_bcn_rsn_ie(struct adapter *padapter)
-{
-	DBG_88E("%s\n", __func__);
-}
-
-static void update_bcn_wpa_ie(struct adapter *padapter)
-{
-	DBG_88E("%s\n", __func__);
-}
-
-static void update_bcn_wmm_ie(struct adapter *padapter)
-{
-	DBG_88E("%s\n", __func__);
-}
-
 static void update_bcn_wps_ie(struct adapter *padapter)
 {
 	u8 *pwps_ie = NULL, *pwps_ie_src;
@@ -628,8 +612,6 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	unsigned char *ie = pnetwork->IEs;
 	u32 ielen = pnetwork->IELength;
 
-	DBG_88E("%s\n", __func__);
-
 	pwps_ie = rtw_get_wps_ie(ie + _FIXED_IE_LENGTH_, ielen - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 	if (!pwps_ie || wps_ielen == 0)
@@ -673,18 +655,12 @@ static void update_bcn_p2p_ie(struct adapter *padapter)
 
 static void update_bcn_vendor_spec_ie(struct adapter *padapter, u8 *oui)
 {
-	DBG_88E("%s\n", __func__);
-
-	if (!memcmp(RTW_WPA_OUI, oui, 4))
-		update_bcn_wpa_ie(padapter);
-	else if (!memcmp(WMM_OUI, oui, 4))
-		update_bcn_wmm_ie(padapter);
-	else if (!memcmp(WPS_OUI, oui, 4))
+	if (!memcmp(WPS_OUI, oui, 4))
 		update_bcn_wps_ie(padapter);
 	else if (!memcmp(P2P_OUI, oui, 4))
 		update_bcn_p2p_ie(padapter);
 	else
-		DBG_88E("unknown OUI type!\n");
+		netdev_dbg(padapter->pnetdev, "unknown/unused OUI type!\n");
 }
 
 void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
@@ -704,24 +680,12 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
 
 	switch (ie_id) {
-	case 0xFF:
-		update_bcn_fixed_ie(padapter);/* 8: TimeStamp, 2: Beacon Interval 2:Capability */
-		break;
 	case _TIM_IE_:
 		update_BCNTIM(padapter);
 		break;
 	case _ERPINFO_IE_:
 		update_bcn_erpinfo_ie(padapter);
 		break;
-	case _HT_CAPABILITY_IE_:
-		update_bcn_htcap_ie(padapter);
-		break;
-	case _RSN_IE_2_:
-		update_bcn_rsn_ie(padapter);
-		break;
-	case _HT_ADD_INFO_IE_:
-		update_bcn_htinfo_ie(padapter);
-		break;
 	case _VENDOR_SPECIFIC_IE_:
 		update_bcn_vendor_spec_ie(padapter, oui);
 		break;
@@ -759,8 +723,9 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	if (pmlmepriv->htpriv.ht_option)
 		return 0;
 
-	DBG_88E("%s current operation mode = 0x%X\n",
-		__func__, pmlmepriv->ht_op_mode);
+	netdev_dbg(padapter->pnetdev,
+		   "current operation mode = 0x%X\n",
+		   pmlmepriv->ht_op_mode);
 
 	if (!(pmlmepriv->ht_op_mode & HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT) &&
 	    pmlmepriv->num_sta_ht_no_gf) {
@@ -811,8 +776,9 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 		op_mode_changes++;
 	}
 
-	DBG_88E("%s new operation mode = 0x%X changes =%d\n",
-		__func__, pmlmepriv->ht_op_mode, op_mode_changes);
+	netdev_dbg(padapter->pnetdev,
+		   "new operation mode = 0x%X changes = %d\n",
+		   pmlmepriv->ht_op_mode, op_mode_changes);
 
 	return op_mode_changes;
 }
@@ -928,8 +894,9 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 	if (psta->flags & WLAN_STA_HT) {
 		u16 ht_capab = le16_to_cpu(psta->htpriv.ht_cap.cap_info);
 
-		DBG_88E("HT: STA %pM HT Capabilities Info: 0x%04x\n",
-			(psta->hwaddr), ht_capab);
+		netdev_dbg(padapter->pnetdev,
+			   "HT: STA %pM HT Capabilities Info: 0x%04x\n",
+			   (psta->hwaddr), ht_capab);
 
 		if (psta->no_ht_set) {
 			psta->no_ht_set = 0;
@@ -941,9 +908,9 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->no_ht_gf_set = 1;
 				pmlmepriv->num_sta_ht_no_gf++;
 			}
-			DBG_88E("%s STA %pM - no greenfield, num of non-gf stations %d\n",
-				   __func__, (psta->hwaddr),
-				   pmlmepriv->num_sta_ht_no_gf);
+			netdev_dbg(padapter->pnetdev,
+				   "STA %pM - no greenfield, num of non-gf stations %d\n",
+				   (psta->hwaddr), pmlmepriv->num_sta_ht_no_gf);
 		}
 
 		if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH_20_40) == 0) {
@@ -951,9 +918,9 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->ht_20mhz_set = 1;
 				pmlmepriv->num_sta_ht_20mhz++;
 			}
-			DBG_88E("%s STA %pM - 20 MHz HT, num of 20MHz HT STAs %d\n",
-				   __func__, (psta->hwaddr),
-				   pmlmepriv->num_sta_ht_20mhz);
+			netdev_dbg(padapter->pnetdev,
+				   "STA %pM - 20 MHz HT, num of 20MHz HT STAs %d\n",
+				   (psta->hwaddr), pmlmepriv->num_sta_ht_20mhz);
 		}
 	} else {
 		if (!psta->no_ht_set) {
@@ -961,9 +928,9 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 			pmlmepriv->num_sta_no_ht++;
 		}
 		if (pmlmepriv->htpriv.ht_option) {
-			DBG_88E("%s STA %pM - no HT, num of non-HT stations %d\n",
-				__func__, (psta->hwaddr),
-				pmlmepriv->num_sta_no_ht);
+			netdev_dbg(padapter->pnetdev,
+				   "STA %pM - no HT, num of non-HT stations %d\n",
+				   (psta->hwaddr), pmlmepriv->num_sta_no_ht);
 		}
 	}
 
@@ -975,7 +942,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 	/* update associcated stations cap. */
 	associated_clients_update(padapter,  beacon_updated);
 
-	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
+	netdev_dbg(padapter->pnetdev, "updated = %d\n", beacon_updated);
 }
 
 u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
@@ -1038,7 +1005,7 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 
 	/* update associcated stations cap. */
 
-	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
+	netdev_dbg(padapter->pnetdev, "updated = %d\n", beacon_updated);
 
 	return beacon_updated;
 }
@@ -1093,8 +1060,6 @@ int rtw_sta_flush(struct adapter *padapter)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
-
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return ret;
 
@@ -1236,7 +1201,9 @@ void stop_ap_mode(struct adapter *padapter)
 	}
 	spin_unlock_bh(&pacl_node_q->lock);
 
-	DBG_88E("%s, free acl_node_queue, num =%d\n", __func__, pacl_list->num);
+	netdev_dbg(padapter->pnetdev,
+		   "free acl_node_queue, num = %d\n",
+		   pacl_list->num);
 
 	rtw_sta_flush(padapter);
 
-- 
2.33.1

