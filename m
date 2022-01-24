Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F2249A82D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316787AbiAYC6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415279AbiAYBAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:00:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D80C06B5A0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:24 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so472692wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSl+GWpZgbOvu+Z8d+u+l/9OgfLS6nzeCNeEr6MFNe4=;
        b=etCPZ67C1PRyUomAK1stuGWle78/Gzh3/aYVCCUgyMMUNux1LMReFUemElsc3qTfwO
         pbJnw8c3TqTjWib6vbtb8WjxFLyLia1u2WfS8k5mQZ3/AQJ9SsgE064Co6WfGEGS1WLQ
         H9/x/OD5DsUSMFfjjVk313Dy29/41DuQR+7p68YEMxdJcnqYklek0XQVzoC4D0ZbsTw8
         gNma2UNmb5woflP6IBP/mREAmOcM6OdIg4vS1VRnkd5ixVlG0nJTA0UyAwr9ctcamI5I
         KVCTTQdf/agmD/T5n48wG9be5TnEm1JgTB4+4ieWmq71DzNGmMkegyWqyEtOClq3BEXQ
         gyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSl+GWpZgbOvu+Z8d+u+l/9OgfLS6nzeCNeEr6MFNe4=;
        b=mnDaaMbxo29q/yHq9TnlpKOE4iuFFIuunCH9Ipgf9qIk37U6a2jrYdL0GHOhjeS76A
         7Yfvof2OGdhDqYLf3PM5uae/W6YFC1JsmHWlhmf+YkPdW0LECn25be6Dau6sr/DIAt+P
         Wm0Qku3StYHOIoL4vw6cpEsnlh/u+m/rZi2wPzvbKJvVduGwbFNysO1v8+uzNP1D2wYF
         1Qt17g3keR/QtpSOu8uUmeKPubyAS5mlcKonGylU0jfHhCevyD9GJZWC53nBfyH09UjZ
         ckcyEMnIBhqm14ttBfdkhkUcprF89iBBn6gMcl0NAxllHo0EVMrFE9KCL/mo+P7e5VLs
         +PPA==
X-Gm-Message-State: AOAM5326DqR05QEF//zJGNf3dw/QTy63n3RlA642SVidVaLaZdZqKpXT
        PSRHl4I74XNpW+sHEWYdWMA8vA==
X-Google-Smtp-Source: ABdhPJyBLEMdDgUnYW01Apu868/75yGoz1qo48GYuMqPN458VOHfg9IzUpqB9yOPZon8aOEozMM9ZA==
X-Received: by 2002:a05:600c:3c9c:: with SMTP id bg28mr375473wmb.190.1643064262414;
        Mon, 24 Jan 2022 14:44:22 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id i3sm15010613wru.33.2022.01.24.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:44:21 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 02/10] staging: r8188eu: remove smaller sets of DBG_88E calls from core dir
Date:   Mon, 24 Jan 2022 22:44:07 +0000
Message-Id: <20220124224415.831-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124224415.831-1-phil@philpotter.co.uk>
References: <20220124224415.831-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from the core directory, other than those in
core/rtw_mlme_ext.c, as this contains over 100 on its own so will be
done in a separate patch for ease of review. These calls do not conform
to kernel coding standards and are superfluous. Also restructure where
appropriate to remove no longer needed code left behind by removal of
these calls. This will allow the eventual removal of the DBG_88E macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ap.c        | 108 +------------------
 drivers/staging/r8188eu/core/rtw_cmd.c       |   4 +-
 drivers/staging/r8188eu/core/rtw_ieee80211.c |  37 +------
 drivers/staging/r8188eu/core/rtw_ioctl_set.c |  10 +-
 drivers/staging/r8188eu/core/rtw_iol.c       |  10 +-
 drivers/staging/r8188eu/core/rtw_mlme.c      |  54 +---------
 drivers/staging/r8188eu/core/rtw_p2p.c       |  61 ++---------
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   |  35 +-----
 drivers/staging/r8188eu/core/rtw_recv.c      |  73 ++-----------
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   |   6 --
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 102 +++++-------------
 drivers/staging/r8188eu/core/rtw_xmit.c      |  38 ++-----
 12 files changed, 66 insertions(+), 472 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 1675e2e8439c..6a4870c95faa 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -179,9 +179,6 @@ void	expire_timeout_chk(struct adapter *padapter)
 				list_del_init(&psta->auth_list);
 				pstapriv->auth_list_cnt--;
 
-				DBG_88E("auth expire %6ph\n",
-					psta->hwaddr);
-
 				spin_unlock_bh(&pstapriv->auth_list_lock);
 
 				spin_lock_bh(&pstapriv->sta_hash_lock);
@@ -249,18 +246,13 @@ void	expire_timeout_chk(struct adapter *padapter)
 			list_del_init(&psta->asoc_list);
 			pstapriv->asoc_list_cnt--;
 
-			DBG_88E("asoc expire %pM, state = 0x%x\n", (psta->hwaddr), psta->state);
 			updated = ap_free_sta(padapter, psta, true, WLAN_REASON_DEAUTH_LEAVING);
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
 			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
-			    padapter->xmitpriv.free_xmitframe_cnt < (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2)) {
-				DBG_88E("%s sta:%pM, sleepq_len:%u, free_xmitframe_cnt:%u, asoc_list_cnt:%u, clear sleep_q\n", __func__,
-					(psta->hwaddr), psta->sleepq_len,
-					padapter->xmitpriv.free_xmitframe_cnt,
-					pstapriv->asoc_list_cnt);
+			    padapter->xmitpriv.free_xmitframe_cnt <
+			    (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2))
 				wakeup_sta_to_xmit(padapter, psta);
-			}
 		}
 	}
 
@@ -288,19 +280,16 @@ void	expire_timeout_chk(struct adapter *padapter)
 
 			psta->keep_alive_trycnt++;
 			if (ret == _SUCCESS) {
-				DBG_88E("asoc check, sta(%pM) is alive\n", (psta->hwaddr));
 				psta->expire_to = pstapriv->expire_to;
 				psta->keep_alive_trycnt = 0;
 				continue;
 			} else if (psta->keep_alive_trycnt <= 3) {
-				DBG_88E("ack check for asoc expire, keep_alive_trycnt =%d\n", psta->keep_alive_trycnt);
 				psta->expire_to = 1;
 				continue;
 			}
 
 			psta->keep_alive_trycnt = 0;
 
-			DBG_88E("asoc expire %pM, state = 0x%x\n", (psta->hwaddr), psta->state);
 			spin_lock_bh(&pstapriv->asoc_list_lock);
 			list_del_init(&psta->asoc_list);
 			pstapriv->asoc_list_cnt--;
@@ -380,9 +369,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 
 		tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
 
-		DBG_88E("%s => mac_id:%d , raid:%d , bitmap = 0x%x, arg = 0x%x\n",
-			__func__, psta->mac_id, raid, tx_ra_bitmap, arg);
-
 		/* bitmap[0:27] = tx_rate_bitmap */
 		/* bitmap[28:31]= Rate Adaptive id */
 		/* arg[0:4] = macid */
@@ -396,8 +382,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		psta->raid = raid;
 		psta->init_rate = init_rate;
 
-	} else {
-		DBG_88E("station aid %d exceed the max number\n", psta->aid);
 	}
 }
 
@@ -455,7 +439,6 @@ void update_bmc_sta(struct adapter *padapter)
 			arg = psta->mac_id & 0x1f;
 			arg |= BIT(7);
 			tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
-			DBG_88E("update_bmc_sta, mask = 0x%x, arg = 0x%x\n", tx_ra_bitmap, arg);
 
 			/* bitmap[0:27] = tx_rate_bitmap */
 			/* bitmap[28:31]= Rate Adaptive id */
@@ -473,8 +456,6 @@ void update_bmc_sta(struct adapter *padapter)
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
 
-	} else {
-		DBG_88E("add_RATid_bmc_sta error!\n");
 	}
 }
 
@@ -496,7 +477,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 	u16 ap_cap_info;
 
 	psta->mac_id = psta->aid + 1;
-	DBG_88E("%s\n", __func__);
 
 	/* ap mode */
 	rtl8188e_SetHalODMVar(padapter, psta, true);
@@ -552,11 +532,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
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
@@ -566,8 +541,6 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 	unsigned char *p, *ie = pnetwork->IEs;
 	u32 len = 0;
 
-	DBG_88E("%s, ERP_enable =%d\n", __func__, pmlmeinfo->ERP_enable);
-
 	if (!pmlmeinfo->ERP_enable)
 		return;
 
@@ -591,31 +564,6 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
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
@@ -628,8 +576,6 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	unsigned char *ie = pnetwork->IEs;
 	u32 ielen = pnetwork->IELength;
 
-	DBG_88E("%s\n", __func__);
-
 	pwps_ie = rtw_get_wps_ie(ie + _FIXED_IE_LENGTH_, ielen - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 	if (!pwps_ie || wps_ielen == 0)
@@ -673,18 +619,10 @@ static void update_bcn_p2p_ie(struct adapter *padapter)
 
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
-	else
-		DBG_88E("unknown OUI type!\n");
 }
 
 void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
@@ -704,24 +642,12 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
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
@@ -759,9 +685,6 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	if (pmlmepriv->htpriv.ht_option)
 		return 0;
 
-	DBG_88E("%s current operation mode = 0x%X\n",
-		__func__, pmlmepriv->ht_op_mode);
-
 	if (!(pmlmepriv->ht_op_mode & HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT) &&
 	    pmlmepriv->num_sta_ht_no_gf) {
 		pmlmepriv->ht_op_mode |=
@@ -811,9 +734,6 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 		op_mode_changes++;
 	}
 
-	DBG_88E("%s new operation mode = 0x%X changes =%d\n",
-		__func__, pmlmepriv->ht_op_mode, op_mode_changes);
-
 	return op_mode_changes;
 }
 
@@ -928,9 +848,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 	if (psta->flags & WLAN_STA_HT) {
 		u16 ht_capab = le16_to_cpu(psta->htpriv.ht_cap.cap_info);
 
-		DBG_88E("HT: STA %pM HT Capabilities Info: 0x%04x\n",
-			(psta->hwaddr), ht_capab);
-
 		if (psta->no_ht_set) {
 			psta->no_ht_set = 0;
 			pmlmepriv->num_sta_no_ht--;
@@ -941,9 +858,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->no_ht_gf_set = 1;
 				pmlmepriv->num_sta_ht_no_gf++;
 			}
-			DBG_88E("%s STA %pM - no greenfield, num of non-gf stations %d\n",
-				   __func__, (psta->hwaddr),
-				   pmlmepriv->num_sta_ht_no_gf);
 		}
 
 		if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH_20_40) == 0) {
@@ -951,20 +865,12 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->ht_20mhz_set = 1;
 				pmlmepriv->num_sta_ht_20mhz++;
 			}
-			DBG_88E("%s STA %pM - 20 MHz HT, num of 20MHz HT STAs %d\n",
-				   __func__, (psta->hwaddr),
-				   pmlmepriv->num_sta_ht_20mhz);
 		}
 	} else {
 		if (!psta->no_ht_set) {
 			psta->no_ht_set = 1;
 			pmlmepriv->num_sta_no_ht++;
 		}
-		if (pmlmepriv->htpriv.ht_option) {
-			DBG_88E("%s STA %pM - no HT, num of non-HT stations %d\n",
-				__func__, (psta->hwaddr),
-				pmlmepriv->num_sta_no_ht);
-		}
 	}
 
 	if (rtw_ht_operation_update(padapter) > 0) {
@@ -974,8 +880,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 
 	/* update associcated stations cap. */
 	associated_clients_update(padapter,  beacon_updated);
-
-	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
 }
 
 u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
@@ -1038,8 +942,6 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 
 	/* update associcated stations cap. */
 
-	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
-
 	return beacon_updated;
 }
 
@@ -1093,8 +995,6 @@ int rtw_sta_flush(struct adapter *padapter)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
-
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return ret;
 
@@ -1236,8 +1136,6 @@ void stop_ap_mode(struct adapter *padapter)
 	}
 	spin_unlock_bh(&pacl_node_q->lock);
 
-	DBG_88E("%s, free acl_node_queue, num =%d\n", __func__, pacl_list->num);
-
 	rtw_sta_flush(padapter);
 
 	/* free_assoc_sta_resources */
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 297d59508a05..14ccf1b86c8d 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -945,10 +945,8 @@ static void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 	u32 txdma_status;
 
 	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
-	if (txdma_status != 0x00) {
-		DBG_88E("%s REG_TXDMA_STATUS:0x%08x\n", __func__, txdma_status);
+	if (txdma_status != 0x00)
 		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
-	}
 	/* total xmit irp = 4 */
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index ad87954bdeb4..62354c3194bd 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -653,13 +653,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	/* first 3 bytes in vendor specific information element are the IEEE
 	 * OUI of the vendor. The following byte is used a vendor specific
 	 * sub-type. */
-	if (elen < 4) {
-		if (show_errors) {
-			DBG_88E("short vendor specific information element ignored (len=%lu)\n",
-				(unsigned long)elen);
-		}
+	if (elen < 4)
 		return -1;
-	}
 
 	oui = RTW_GET_BE24(pos);
 	switch (oui) {
@@ -674,11 +669,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->wpa_ie_len = elen;
 			break;
 		case WME_OUI_TYPE: /* this is a Wi-Fi WME info. element */
-			if (elen < 5) {
-				DBG_88E("short WME information element ignored (len=%lu)\n",
-					(unsigned long)elen);
+			if (elen < 5)
 				return -1;
-			}
 			switch (pos[4]) {
 			case WME_OUI_SUBTYPE_INFORMATION_ELEMENT:
 			case WME_OUI_SUBTYPE_PARAMETER_ELEMENT:
@@ -690,8 +682,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 				elems->wme_tspec_len = elen;
 				break;
 			default:
-				DBG_88E("unknown WME information element ignored (subtype=%d len=%lu)\n",
-					pos[4], (unsigned long)elen);
 				return -1;
 			}
 			break;
@@ -701,8 +691,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->wps_ie_len = elen;
 			break;
 		default:
-			DBG_88E("Unknown Microsoft information element ignored (type=%d len=%lu)\n",
-				pos[3], (unsigned long)elen);
 			return -1;
 		}
 		break;
@@ -714,14 +702,10 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->vendor_ht_cap_len = elen;
 			break;
 		default:
-			DBG_88E("Unknown Broadcom information element ignored (type=%d len=%lu)\n",
-				pos[3], (unsigned long)elen);
 			return -1;
 		}
 		break;
 	default:
-		DBG_88E("unknown vendor specific information element ignored (vendor OUI %02x:%02x:%02x len=%lu)\n",
-			pos[0], pos[1], pos[2], (unsigned long)elen);
 		return -1;
 	}
 	return 0;
@@ -752,13 +736,8 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 		elen = *pos++;
 		left -= 2;
 
-		if (elen > left) {
-			if (show_errors) {
-				DBG_88E("IEEE 802.11 element parse failed (id=%d elen=%d left=%lu)\n",
-					id, elen, (unsigned long)left);
-			}
+		if (elen > left)
 			return ParseFailed;
-		}
 
 		switch (id) {
 		case WLAN_EID_SSID:
@@ -839,10 +818,6 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 			break;
 		default:
 			unknown++;
-			if (!show_errors)
-				break;
-			DBG_88E("IEEE 802.11 element parse ignored unknown element (id=%d elen=%d)\n",
-				id, elen);
 			break;
 		}
 		left -= elen;
@@ -890,12 +865,8 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 		ether_addr_copy(mac, mac_addr);
 	}
 
-	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
+	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac))
 		eth_random_addr(mac_addr);
-		DBG_88E("MAC Address from efuse error, assign random one !!!\n");
-	}
-
-	DBG_88E("rtw_macaddr_cfg MAC Address  = %pM\n", mac_addr);
 }
 
 /**
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 82795be79a52..f84a997bb4de 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -120,7 +120,6 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	DBG_88E("Set BSSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		goto handle_tkip_countermeasure;
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
@@ -190,12 +189,10 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	DBG_88E("Set SSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		goto handle_tkip_countermeasure;
-	} else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
+	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 		goto release_mlme_lock;
-	}
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		if ((pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength) &&
@@ -275,8 +272,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	if (*pold_state != networktype) {
 		spin_lock_bh(&pmlmepriv->lock);
 
-		/* DBG_88E("change mode, old_mode =%d, new_mode =%d, fw_state = 0x%x\n", *pold_state, networktype, get_fwstate(pmlmepriv)); */
-
 		if (*pold_state == Ndis802_11APMode) {
 			/* change to other mode from Ndis802_11APMode */
 			cur_network->join_res = -1;
@@ -359,7 +354,6 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 		res = true;
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
-			DBG_88E(FUNC_ADPT_FMT": scan deny\n", FUNC_ADPT_ARG(padapter));
 			indicate_wx_scan_complete_event(padapter);
 			return _SUCCESS;
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 7e78b47c1284..05d779a098d4 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -11,14 +11,11 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
 	struct xmit_priv	*pxmitpriv = &adapter->xmitpriv;
 
 	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
-	if (!xmit_frame) {
-		DBG_88E("%s rtw_alloc_xmitframe return null\n", __func__);
+	if (!xmit_frame)
 		return NULL;
-	}
 
 	xmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
 	if (!xmitbuf) {
-		DBG_88E("%s rtw_alloc_xmitbuf return null\n", __func__);
 		rtw_free_xmitframe(pxmitpriv, xmit_frame);
 		return NULL;
 	}
@@ -48,11 +45,8 @@ int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds, u32 cmd_len
 	ori_len = buf_offset + pattrib->pktlen;
 
 	/* check if the io_buf can accommodate new cmds */
-	if (ori_len + cmd_len + 8 > MAX_XMITBUF_SZ) {
-		DBG_88E("%s %u is large than MAX_XMITBUF_SZ:%u, can't accommodate new cmds\n",
-			__func__, ori_len + cmd_len + 8, MAX_XMITBUF_SZ);
+	if (ori_len + cmd_len + 8 > MAX_XMITBUF_SZ)
 		return _FAIL;
-	}
 
 	memcpy(xmit_frame->buf_addr + buf_offset + pattrib->pktlen, IOL_cmds, cmd_len);
 	pattrib->pktlen += cmd_len;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 394e8a5ce03c..d78ec2b2e15d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -616,10 +616,8 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 		}
 	}
 
-	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0)) {
-		DBG_88E("desired_encmode: %d, privacy: %d\n", desired_encmode, privacy);
+	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0))
 		bselected = false;
-	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
@@ -734,8 +732,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 				rtw_indicate_connect(adapter);
 			} else {
-				DBG_88E("try_to_join, but select scanning queue fail, to_roaming:%d\n",
-					pmlmepriv->to_roaming);
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
 					    _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)) {
@@ -909,7 +905,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.MacAddress);
 
 	if (psta) { /* update ptarget_sta */
-		DBG_88E("%s\n", __func__);
 		psta->aid  = pnetwork->join_res;
 		psta->mac_id = 0;
 		/* sta mode */
@@ -969,8 +964,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network  *cur_network = &pmlmepriv->cur_network;
 
-	DBG_88E("%s\n", __func__);
-
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
 	/*  some IEs in pnetwork is wrong, so we should use ptarget_wlan IEs */
@@ -1196,7 +1189,6 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	/* to do: init sta_info variable */
 	psta->qos_option = 0;
 	psta->mac_id = (uint)pstassoc->cam_id;
-	DBG_88E("%s\n", __func__);
 	/* for ad-hoc mode */
 	rtl8188e_SetHalODMVar(adapter, psta, true);
 	rtw_sta_media_status_rpt(adapter, psta, 1);
@@ -1239,8 +1231,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	else
 		mac_id = pstadel->mac_id;
 
-	DBG_88E("%s(mac_id=%d)=%pM\n", __func__, mac_id, pstadel->macaddr);
-
 	if (mac_id >= 0) {
 		u16 media_status;
 		media_status = (mac_id << 8) | 0; /*   MACID|OPMODE:0 means disconnect */
@@ -1330,8 +1320,6 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	int do_join_r;
 
-	DBG_88E("%s, fw_state=%x\n", __func__, get_fwstate(pmlmepriv));
-
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 		return;
 
@@ -1341,15 +1329,11 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 		while (1) {
 			pmlmepriv->to_roaming--;
 			if (rtw_to_roaming(adapter) != 0) { /* try another */
-				DBG_88E("%s try another roaming\n", __func__);
 				do_join_r = rtw_do_join(adapter);
-				if (_SUCCESS != do_join_r) {
-					DBG_88E("%s roaming do_join return %d\n", __func__, do_join_r);
+				if (do_join_r != _SUCCESS)
 					continue;
-				}
 				break;
 			} else {
-				DBG_88E("%s We've try roaming but fail\n", __func__);
 				rtw_indicate_disconnect(adapter);
 				break;
 			}
@@ -1370,7 +1354,6 @@ void rtw_scan_timeout_handler (struct adapter *adapter)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	DBG_88E(FUNC_ADPT_FMT" fw_state=%x\n", FUNC_ADPT_ARG(adapter), get_fwstate(pmlmepriv));
 	spin_lock_bh(&pmlmepriv->lock);
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	spin_unlock_bh(&pmlmepriv->lock);
@@ -1385,7 +1368,6 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 	if (pmlmepriv->scan_interval > 0) {
 		pmlmepriv->scan_interval--;
 		if (pmlmepriv->scan_interval == 0) {
-			DBG_88E("%s\n", __func__);
 			rtw_set_802_11_bssid_list_scan(padapter, NULL, 0);
 			pmlmepriv->scan_interval = SCAN_INTERVAL;/*  30*2 sec = 60sec */
 		}
@@ -1475,15 +1457,6 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 		*candidate = competitor;
 		updated = true;
 	}
-	if (updated) {
-		DBG_88E("[by_bssid:%u][assoc_ssid:%s]new candidate: %s(%pM rssi:%d\n",
-			pmlmepriv->assoc_by_bssid,
-			pmlmepriv->assoc_ssid.Ssid,
-			(*candidate)->network.Ssid.Ssid,
-			(*candidate)->network.MacAddress,
-			(int)(*candidate)->network.Rssi);
-		DBG_88E("[to_roaming:%u]\n", rtw_to_roaming(adapter));
-	}
 
 exit:
 	return updated;
@@ -1520,19 +1493,12 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
 	}
 	if (!candidate) {
-		DBG_88E("%s: return _FAIL(candidate==NULL)\n", __func__);
 		ret = _FAIL;
 		goto exit;
-	} else {
-		DBG_88E("%s: candidate: %s(%pM ch:%u)\n", __func__,
-			candidate->network.Ssid.Ssid, candidate->network.MacAddress,
-			candidate->network.Configuration.DSConfig);
 	}
 
 	/*  check for situation of  _FW_LINKED */
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-		DBG_88E("%s: _FW_LINKED while ask_for_joinbss!!!\n", __func__);
-
 		rtw_disassoc_cmd(adapter, 0, true);
 		rtw_indicate_disconnect(adapter);
 		rtw_free_assoc_resources(adapter, 0);
@@ -1542,10 +1508,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	if (supp_ant_div) {
 		u8 cur_ant;
 		GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &cur_ant);
-		DBG_88E("#### Opt_Ant_(%s), cur_Ant(%s)\n",
-			(2 == candidate->network.PhyInfo.Optimum_antenna) ? "A" : "B",
-			(2 == cur_ant) ? "A" : "B"
-		);
 	}
 
 	ret = rtw_joinbss_cmd(adapter, candidate);
@@ -1617,8 +1579,6 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
 	psetkeyparm->set_tx = set_tx;
 	pmlmepriv->key_mask |= BIT(psetkeyparm->keyid);
-	DBG_88E("==> rtw_set_key algorithm(%x), keyid(%x), key_mask(%x)\n",
-		psetkeyparm->algorithm, psetkeyparm->keyid, pmlmepriv->key_mask);
 
 	switch (psetkeyparm->algorithm) {
 	case _WEP40_:
@@ -1970,8 +1930,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 	if ((!pmlmeinfo->HT_info_enable) || (!pmlmeinfo->HT_caps_enable))
 		return;
 
-	DBG_88E("+rtw_update_ht_cap()\n");
-
 	/* maybe needs check if ap supports rx ampdu. */
 	if ((!phtpriv->ampdu_enable) && (pregistrypriv->ampdu_enable == 1)) {
 		if (pregistrypriv->wifi_spec == 1)
@@ -2021,8 +1979,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 
 	/*  Config SM Power Save setting */
 	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & 0x0C) >> 2;
-	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		DBG_88E("%s(): WLAN_HT_CAP_SM_PS_STATIC\n", __func__);
 
 	/*  Config current HT Protection mode. */
 	pmlmeinfo->HT_protection = pmlmeinfo->HT_info.infos[1] & 0x3;
@@ -2057,7 +2013,6 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
 		if (0 == issued) {
-			DBG_88E("rtw_issue_addbareq_cmd, p=%d\n", priority);
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
 			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
@@ -2085,9 +2040,6 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 		pnetwork = &pmlmepriv->cur_network;
 
 	if (0 < rtw_to_roaming(padapter)) {
-		DBG_88E("roaming from %s(%pM length:%d\n",
-			pnetwork->network.Ssid.Ssid, pnetwork->network.MacAddress,
-			pnetwork->network.Ssid.SsidLength);
 		memcpy(&pmlmepriv->assoc_ssid, &pnetwork->network.Ssid, sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
@@ -2097,13 +2049,11 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 			if (_SUCCESS == do_join_r) {
 				break;
 			} else {
-				DBG_88E("roaming do_join return %d\n", do_join_r);
 				pmlmepriv->to_roaming--;
 
 				if (0 < pmlmepriv->to_roaming) {
 					continue;
 				} else {
-					DBG_88E("%s(%d) -to roaming fail, indicate_disconnect\n", __func__, __LINE__);
 					rtw_indicate_disconnect(padapter);
 					break;
 				}
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 7b30b9b64b41..96e3bc20718c 100644
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
@@ -826,17 +818,12 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 
 	p2p_ie = rtw_get_p2p_ie(ies, ies_len, NULL, &p2p_ielen);
 
-	if (!p2p_ie) {
-		DBG_88E("[%s] P2P IE not Found!!\n", __func__);
+	if (!p2p_ie)
 		status_code =  P2P_STATUS_FAIL_INVALID_PARAM;
-	} else {
-		DBG_88E("[%s] P2P IE Found!!\n", __func__);
-	}
 
 	while (p2p_ie) {
 		/* Check P2P Capability ATTR */
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_CAPABILITY, (u8 *)&le_tmp, (uint *)&attr_contentlen)) {
-			DBG_88E("[%s] Got P2P Capability Attr!!\n", __func__);
 			cap_attr = le16_to_cpu(le_tmp);
 			psta->dev_cap = cap_attr & 0xff;
 		}
@@ -845,7 +832,6 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 
 		/* Check P2P Device Info ATTR */
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_DEVICE_INFO, NULL, (uint *)&attr_contentlen)) {
-			DBG_88E("[%s] Got P2P DEVICE INFO Attr!!\n", __func__);
 			pattr_content = kzalloc(attr_contentlen, GFP_KERNEL);
 			pbuf = pattr_content;
 			if (pattr_content) {
@@ -1004,7 +990,6 @@ u8 process_p2p_provdisc_req(struct wifidirect_info *pwdinfo,  u8 *pframe, uint l
 			issue_p2p_provision_resp(pwdinfo, GetAddr2Ptr(pframe), frame_body, uconfig_method);
 		}
 	}
-	DBG_88E("[%s] config method = %s\n", __func__, pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req);
 	return true;
 }
 
@@ -1083,7 +1068,6 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 				memcpy(pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req, "pbc", 3);
 		}
 	} else {
-		DBG_88E("[%s] WPS IE not Found!!\n", __func__);
 		result = P2P_STATUS_FAIL_INCOMPATIBLE_PARAM;
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 		return result;
@@ -1101,7 +1085,6 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 	p2p_ie = rtw_get_p2p_ie(ies, ies_len, NULL, &p2p_ielen);
 
 	if (!p2p_ie) {
-		DBG_88E("[%s] P2P IE not Found!!\n", __func__);
 		result = P2P_STATUS_FAIL_INCOMPATIBLE_PARAM;
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 	}
@@ -1119,7 +1102,6 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_ING);
 
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GO_INTENT, &attr_content, &attr_contentlen)) {
-			DBG_88E("[%s] GO Intent = %d, tie = %d\n", __func__, attr_content >> 1, attr_content & 0x01);
 			pwdinfo->peer_intent = attr_content;	/*	include both intent and tie breaker values. */
 
 			if (pwdinfo->intent == (pwdinfo->peer_intent >> 1)) {
@@ -1157,7 +1139,6 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 			ch_num_inclusioned = rtw_p2p_ch_inclusion(&padapter->mlmeextpriv, peer_ch_list, peer_ch_num, ch_list_inclusioned);
 
 			if (ch_num_inclusioned == 0) {
-				DBG_88E("[%s] No common channel in channel list!\n", __func__);
 				result = P2P_STATUS_FAIL_NO_COMMON_CH;
 				rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 				break;
@@ -1173,17 +1154,15 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 						peer_operating_ch = operatingch_info[4];
 
 					if (rtw_p2p_is_channel_list_ok(peer_operating_ch,
-							       ch_list_inclusioned, ch_num_inclusioned)) {
+								       ch_list_inclusioned,
+								       ch_num_inclusioned))
 						/**
 						 *	Change our operating channel as peer's for compatibility.
 						 */
 						pwdinfo->operating_channel = peer_operating_ch;
-						DBG_88E("[%s] Change op ch to %02x as peer's\n", __func__, pwdinfo->operating_channel);
-					} else {
+					else
 						/*  Take first channel of ch_list_inclusioned as operating channel */
 						pwdinfo->operating_channel = ch_list_inclusioned[0];
-						DBG_88E("[%s] Change op ch to %02x\n", __func__, pwdinfo->operating_channel);
-					}
 				}
 			}
 		}
@@ -1210,7 +1189,6 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 
 	if (rtw_get_wps_ie(ies, ies_len, NULL, &wps_ielen)) {
 	} else {
-		DBG_88E("[%s] WPS IE not Found!!\n", __func__);
 		result = P2P_STATUS_FAIL_INCOMPATIBLE_PARAM;
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 	}
@@ -1233,7 +1211,6 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 		while (p2p_ie) {	/*	Found the P2P IE. */
 			rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_STATUS, &attr_content, &attr_contentlen);
 			if (attr_contentlen == 1) {
-				DBG_88E("[%s] Status = %d\n", __func__, attr_content);
 				if (attr_content == P2P_STATUS_SUCCESS) {
 					/*	Do nothing. */
 				} else {
@@ -1259,7 +1236,6 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 			attr_content = 0x00;
 			attr_contentlen = 0;
 			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GO_INTENT, &attr_content, &attr_contentlen)) {
-				DBG_88E("[%s] GO Intent = %d, tie = %d\n", __func__, attr_content >> 1, attr_content & 0x01);
 				pwdinfo->peer_intent = attr_content;	/*	include both intent and tie breaker values. */
 
 				if (pwdinfo->intent == (pwdinfo->peer_intent >> 1)) {
@@ -1296,20 +1272,16 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 			/*	Try to get the operation channel information */
 
 			attr_contentlen = 0;
-			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH, operatingch_info, &attr_contentlen)) {
-				DBG_88E("[%s] Peer's operating channel = %d\n", __func__, operatingch_info[4]);
+			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH,
+						     operatingch_info, &attr_contentlen))
 				pwdinfo->peer_operating_ch = operatingch_info[4];
-			}
 
 			/*	Try to get the channel list information */
 			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_CH_LIST, pwdinfo->channel_list_attr, &pwdinfo->channel_list_attr_len)) {
-				DBG_88E("[%s] channel list attribute found, len = %d\n", __func__,  pwdinfo->channel_list_attr_len);
-
 				peer_ch_num = rtw_p2p_get_peer_ch_list(pwdinfo, pwdinfo->channel_list_attr, pwdinfo->channel_list_attr_len, peer_ch_list);
 				ch_num_inclusioned = rtw_p2p_ch_inclusion(&padapter->mlmeextpriv, peer_ch_list, peer_ch_num, ch_list_inclusioned);
 
 				if (ch_num_inclusioned == 0) {
-					DBG_88E("[%s] No common channel in channel list!\n", __func__);
 					result = P2P_STATUS_FAIL_NO_COMMON_CH;
 					rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 					break;
@@ -1325,21 +1297,16 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 							peer_operating_ch = operatingch_info[4];
 
 						if (rtw_p2p_is_channel_list_ok(peer_operating_ch,
-						    ch_list_inclusioned, ch_num_inclusioned)) {
+						    ch_list_inclusioned, ch_num_inclusioned))
 							/**
 							 *	Change our operating channel as peer's for compatibility.
 							 */
 							pwdinfo->operating_channel = peer_operating_ch;
-							DBG_88E("[%s] Change op ch to %02x as peer's\n", __func__, pwdinfo->operating_channel);
-						} else {
+						else
 							/*  Take first channel of ch_list_inclusioned as operating channel */
 							pwdinfo->operating_channel = ch_list_inclusioned[0];
-							DBG_88E("[%s] Change op ch to %02x\n", __func__, pwdinfo->operating_channel);
-						}
 					}
 				}
-			} else {
-				DBG_88E("[%s] channel list attribute not found!\n", __func__);
 			}
 
 			/*	Try to get the group id information if peer is GO */
@@ -1376,7 +1343,6 @@ u8 process_p2p_group_negotation_confirm(struct wifidirect_info *pwdinfo, u8 *pfr
 		pwdinfo->negotiation_dialog_token = 1;
 		rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_STATUS, &attr_content, &attr_contentlen);
 		if (attr_contentlen == 1) {
-			DBG_88E("[%s] Status = %d\n", __func__, attr_content);
 			result = attr_content;
 
 			if (attr_content == P2P_STATUS_SUCCESS) {
@@ -1410,16 +1376,14 @@ u8 process_p2p_group_negotation_confirm(struct wifidirect_info *pwdinfo, u8 *pfr
 		attr_contentlen = 0;
 		memset(groupid, 0x00, 38);
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GROUP_ID, groupid, &attr_contentlen)) {
-			DBG_88E("[%s] Ssid = %s, ssidlen = %zu\n", __func__, &groupid[ETH_ALEN], strlen(&groupid[ETH_ALEN]));
 			memcpy(pwdinfo->groupid_info.go_device_addr, &groupid[0], ETH_ALEN);
 			memcpy(pwdinfo->groupid_info.ssid, &groupid[6], attr_contentlen - ETH_ALEN);
 		}
 
 		attr_contentlen = 0;
-		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH, operatingch_info, &attr_contentlen)) {
-			DBG_88E("[%s] Peer's operating channel = %d\n", __func__, operatingch_info[4]);
+		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH,
+					     operatingch_info, &attr_contentlen))
 			pwdinfo->peer_operating_ch = operatingch_info[4];
-		}
 
 		/* Get the next P2P IE */
 		p2p_ie = rtw_get_p2p_ie(p2p_ie + p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
@@ -1655,7 +1619,6 @@ void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state)
 			if (pwdinfo->ctwindow > 0) {
 				if (pwrpriv->smart_ps != 0) {
 					pwrpriv->smart_ps = 0;
-					DBG_88E("%s(): Enter CTW, change SmartPS\n", __func__);
 					SetHwReg8188EU(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&padapter->pwrctrlpriv.pwr_mode));
 				}
 			}
@@ -1725,7 +1688,6 @@ static void reset_ch_sitesurvey_timer_process(struct timer_list *t)
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
 		return;
 
-	DBG_88E("[%s] In\n", __func__);
 	/*	Reset the operation channel information */
 	pwdinfo->rx_invitereq_info.operation_ch[0] = 0;
 	pwdinfo->rx_invitereq_info.scan_op_ch_only = 0;
@@ -1739,7 +1701,6 @@ static void reset_ch_sitesurvey_timer_process2(struct timer_list *t)
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
 		return;
 
-	DBG_88E("[%s] In\n", __func__);
 	/*	Reset the operation channel information */
 	pwdinfo->p2p_info.operation_ch[0] = 0;
 	pwdinfo->p2p_info.scan_op_ch_only = 0;
@@ -1779,8 +1740,6 @@ static void pre_tx_scan_timer_process(struct timer_list *t)
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_INVITE_REQ)) {
 		if (pwdinfo->invitereq_info.benable)
 			p2p_protocol_wk_cmd(adapter, P2P_PRE_TX_INVITEREQ_PROCESS_WK);
-	} else {
-		DBG_88E("[%s] p2p_state is %d, ignore!!\n", __func__, rtw_p2p_state(pwdinfo));
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index a0651015e97c..ac54d002a95e 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -25,7 +25,6 @@ void ips_enter(struct adapter *padapter)
 	pwrpriv->ips_mode = pwrpriv->ips_mode_req;
 
 	pwrpriv->ips_enter_cnts++;
-	DBG_88E("==>ips_enter cnts:%d\n", pwrpriv->ips_enter_cnts);
 	if (rf_off == pwrpriv->change_rfpwrstate) {
 		pwrpriv->bpower_saving = true;
 
@@ -54,14 +53,12 @@ int ips_leave(struct adapter *padapter)
 		pwrpriv->bips_processing = true;
 		pwrpriv->change_rfpwrstate = rf_on;
 		pwrpriv->ips_leave_cnts++;
-		DBG_88E("==>ips_leave cnts:%d\n", pwrpriv->ips_leave_cnts);
 
 		result = rtw_ips_pwr_up(padapter);
 		if (result == _SUCCESS)
 			pwrpriv->rf_pwrstate = rf_on;
 
 		if ((_WEP40_ == psecuritypriv->dot11PrivacyAlgrthm) || (_WEP104_ == psecuritypriv->dot11PrivacyAlgrthm)) {
-			DBG_88E("==>%s, channel(%d), processing(%x)\n", __func__, padapter->mlmeextpriv.cur_channel, pwrpriv->bips_processing);
 			set_channel_bwmode(padapter, padapter->mlmeextpriv.cur_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 			for (keyid = 0; keyid < 4; keyid++) {
 				if (pmlmepriv->key_mask & BIT(keyid)) {
@@ -73,7 +70,6 @@ int ips_leave(struct adapter *padapter)
 			}
 		}
 
-		DBG_88E("==> ips_leave.....LED(0x%08x)...\n", rtw_read32(padapter, 0x4c));
 		pwrpriv->bips_processing = false;
 
 		pwrpriv->bkeepfwalive = false;
@@ -124,7 +120,6 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 void rtw_ps_processor(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	pwrpriv->ps_processing = true;
 
@@ -138,7 +133,6 @@ void rtw_ps_processor(struct adapter *padapter)
 		goto exit;
 
 	if ((pwrpriv->rf_pwrstate == rf_on) && ((pwrpriv->pwr_state_check_cnts % 4) == 0)) {
-		DBG_88E("==>%s .fw_state(%x)\n", __func__, get_fwstate(pmlmepriv));
 		pwrpriv->change_rfpwrstate = rf_off;
 
 		ips_enter(padapter);
@@ -176,10 +170,10 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 		return false;
 	if (pwrpriv->bInSuspend)
 		return false;
-	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && !padapter->securitypriv.binstallGrpkey) {
-		DBG_88E("Group handshake still in progress !!!\n");
+	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X &&
+	    !padapter->securitypriv.binstallGrpkey)
 		return false;
-	}
+
 	return true;
 }
 
@@ -203,14 +197,12 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
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
@@ -245,13 +237,11 @@ s32 LPS_RF_ON_check(struct adapter *padapter, u32 delay_ms)
 
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
@@ -276,7 +266,6 @@ void LPS_Enter(struct adapter *padapter)
 		if (pwrpriv->LpsIdleCount >= 2) { /*   4 Sec */
 			if (pwrpriv->pwr_mode == PS_MODE_ACTIVE) {
 				pwrpriv->bpower_saving = true;
-				DBG_88E("%s smart_ps:%d\n", __func__, pwrpriv->smart_ps);
 				/* For Tenda W311R IOT issue */
 				rtw_set_ps_mode(padapter, pwrpriv->power_mgnt,
 						pwrpriv->smart_ps, 0x40);
@@ -375,13 +364,8 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		pwrpriv->ips_deny_time = jiffies + rtw_ms_to_systime(ips_deffer_ms);
 
 	if (pwrpriv->ps_processing) {
-		DBG_88E("%s wait ps_processing...\n", __func__);
 		while (pwrpriv->ps_processing && rtw_get_passing_time_ms(start) <= 3000)
 			msleep(10);
-		if (pwrpriv->ps_processing)
-			DBG_88E("%s wait ps_processing timeout\n", __func__);
-		else
-			DBG_88E("%s wait ps_processing done\n", __func__);
 	}
 
 	/* System suspend is not allowed to wakeup */
@@ -390,10 +374,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		       (rtw_get_passing_time_ms(start) <= 3000 ||
 		       (rtw_get_passing_time_ms(start) <= 500)))
 				msleep(10);
-		if (pwrpriv->bInSuspend)
-			DBG_88E("%s wait bInSuspend timeout\n", __func__);
-		else
-			DBG_88E("%s wait bInSuspend done\n", __func__);
 	}
 
 	/* I think this should be check in IPS, LPS, autosuspend functions... */
@@ -402,9 +382,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		goto exit;
 	}
 	if (rf_off == pwrpriv->rf_pwrstate) {
-		DBG_88E("%s call ips_leave....\n", __func__);
 		if (_FAIL ==  ips_leave(padapter)) {
-			DBG_88E("======> ips_leave fail.............\n");
 			ret = _FAIL;
 			goto exit;
 		}
@@ -413,11 +391,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
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
@@ -455,11 +428,9 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
 
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
index 51a13262a226..615cf5b885db 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -243,7 +243,6 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 	struct recv_frame *pending_frame;
 	while ((pending_frame = rtw_alloc_recvframe(&adapter->recvpriv.uc_swdec_pending_queue))) {
 		rtw_free_recvframe(pending_frame, &adapter->recvpriv.free_recv_queue);
-		DBG_88E("%s: dequeue uc_swdec_pending_queue\n", __func__);
 		cnt++;
 	}
 
@@ -275,7 +274,6 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 
 				if (!psecuritypriv) {
 					res = _FAIL;
-					DBG_88E("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n");
 					goto exit;
 				}
 			} else {
@@ -304,12 +302,8 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 				if (is_multicast_ether_addr(prxattrib->ra) && prxattrib->key_index != pmlmeinfo->key_index)
 					brpt_micerror = false;
 
-				if ((prxattrib->bdecrypted) && (brpt_micerror)) {
+				if ((prxattrib->bdecrypted) && (brpt_micerror))
 					rtw_handle_tkip_mic_err(adapter, (u8)is_multicast_ether_addr(prxattrib->ra));
-					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
-				} else {
-					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
-				}
 				res = _FAIL;
 			} else {
 				/* mic checked ok */
@@ -339,8 +333,6 @@ static struct recv_frame *decryptor(struct adapter *padapter, struct recv_frame
 		prxattrib->key_index = (((iv[3]) >> 6) & 0x3);
 
 		if (prxattrib->key_index > WEP_KEYS) {
-			DBG_88E("prxattrib->key_index(%d)>WEP_KEYS\n", prxattrib->key_index);
-
 			switch (prxattrib->encrypt) {
 			case _WEP40_:
 			case _WEP104_:
@@ -688,10 +680,8 @@ static int ap2sta_data_frame(
 		if (!memcmp(pattrib->bssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		    !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
-			if (!bmcast) {
-				DBG_88E("issue_deauth to the nonassociated ap=%pM for the reason(7)\n", (pattrib->bssid));
+			if (!bmcast)
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
-			}
 
 			ret = _FAIL;
 			goto exit;
@@ -739,11 +729,8 @@ static int ap2sta_data_frame(
 	} else {
 		if (!memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && (!bmcast)) {
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
-			if (!*psta) {
-				DBG_88E("issue_deauth to the ap =%pM for the reason(7)\n", (pattrib->bssid));
-
+			if (!*psta)
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
-			}
 		}
 
 		ret = _FAIL;
@@ -774,8 +761,6 @@ static int sta2ap_data_frame(struct adapter *adapter,
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
 		if (!*psta) {
-			DBG_88E("issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
-
 			issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 
 			ret = RTW_RX_HANDLED;
@@ -800,7 +785,6 @@ static int sta2ap_data_frame(struct adapter *adapter,
 			ret = RTW_RX_HANDLED;
 			goto exit;
 		}
-		DBG_88E("issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
 		issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 		ret = RTW_RX_HANDLED;
 		goto exit;
@@ -865,7 +849,6 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 			return _FAIL;
 
 		if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
-			DBG_88E("%s alive check-rx ps-poll\n", __func__);
 			psta->expire_to = pstapriv->expire_to;
 			psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
 		}
@@ -905,15 +888,11 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 				}
 			} else {
 				if (pstapriv->tim_bitmap & BIT(psta->aid)) {
-					if (psta->sleepq_len == 0) {
-						DBG_88E("no buffered packets to xmit\n");
-
+					if (psta->sleepq_len == 0)
 						/* issue nulldata with More data bit = 0 to indicate we have no buffered packets */
 						issue_nulldata(padapter, psta->hwaddr, 0, 0, 0);
-					} else {
-						DBG_88E("error!psta->sleepq_len=%d\n", psta->sleepq_len);
+					else
 						psta->sleepq_len = 0;
-					}
 
 					pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
@@ -1082,7 +1061,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	u8 type;
 	u8 subtype;
 	int retval = _SUCCESS;
-	u8 bDumpRxPkt;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	u8 *ptr = precv_frame->rx_data;
 	u8  ver = (unsigned char)(*ptr) & 0x3;
@@ -1114,37 +1092,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	pattrib->privacy = GetPrivacy(ptr);
 	pattrib->order = GetOrder(ptr);
 
-	/* Dump rx packets */
-	GetHalDefVar8188EUsb(adapter, HAL_DEF_DBG_DUMP_RXPKT, &bDumpRxPkt);
-	if (bDumpRxPkt == 1) {/* dump all rx packets */
-		int i;
-		DBG_88E("#############################\n");
-
-		for (i = 0; i < 64; i = i + 8)
-			DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr + i),
-				*(ptr + i + 1), *(ptr + i + 2), *(ptr + i + 3), *(ptr + i + 4), *(ptr + i + 5), *(ptr + i + 6), *(ptr + i + 7));
-		DBG_88E("#############################\n");
-	} else if (bDumpRxPkt == 2) {
-		if (type == WIFI_MGT_TYPE) {
-			int i;
-			DBG_88E("#############################\n");
-
-			for (i = 0; i < 64; i = i + 8)
-				DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr + i),
-					*(ptr + i + 1), *(ptr + i + 2), *(ptr + i + 3), *(ptr + i + 4), *(ptr + i + 5), *(ptr + i + 6), *(ptr + i + 7));
-			DBG_88E("#############################\n");
-		}
-	} else if (bDumpRxPkt == 3) {
-		if (type == WIFI_DATA_TYPE) {
-			int i;
-			DBG_88E("#############################\n");
-
-			for (i = 0; i < 64; i = i + 8)
-				DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr + i),
-					*(ptr + i + 1), *(ptr + i + 2), *(ptr + i + 3), *(ptr + i + 4), *(ptr + i + 5), *(ptr + i + 6), *(ptr + i + 7));
-			DBG_88E("#############################\n");
-		}
-	}
 	switch (type) {
 	case WIFI_MGT_TYPE: /* mgnt */
 		validate_recv_mgnt_frame(adapter, precv_frame);
@@ -1444,10 +1391,8 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		/* Offset 12 denote 2 mac address */
 		nSubframe_Length = RTW_GET_BE16(pdata + 12);
 
-		if (a_len < ETH_HLEN + nSubframe_Length) {
-			DBG_88E("nRemain_Length is %d and nSubframe_Length is : %d\n", a_len, nSubframe_Length);
+		if (a_len < ETH_HLEN + nSubframe_Length)
 			goto exit;
-		}
 
 		/* move the data point to data content */
 		pdata += ETH_HLEN;
@@ -1466,17 +1411,14 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 				sub_skb->len = nSubframe_Length;
 				skb_set_tail_pointer(sub_skb, nSubframe_Length);
 			} else {
-				DBG_88E("skb_clone() Fail!!! , nr_subframes=%d\n", nr_subframes);
 				break;
 			}
 		}
 
 		subframes[nr_subframes++] = sub_skb;
 
-		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
-			DBG_88E("ParseSubframe(): Too many Subframes! Packets dropped!\n");
+		if (nr_subframes >= MAX_SUBFRAME_COUNT)
 			break;
-		}
 
 		pdata += nSubframe_Length;
 		a_len -= nSubframe_Length;
@@ -1870,7 +1812,6 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 		     psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPAPSK &&
 		     !psecuritypriv->busetkipkey) {
 			rtw_enqueue_recvframe(rframe, &padapter->recvpriv.uc_swdec_pending_queue);
-			DBG_88E("%s: no key, enqueue uc_swdec_pending_queue\n", __func__);
 			if (recvpriv->free_recvframe_cnt < NR_RECVFRAME / 4) {
 				/* to prevent from recvframe starvation,
 				 * get recvframe from uc_swdec_pending_queue to
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 54561ff239a0..b785ce816a56 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -103,17 +103,11 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 {
 	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
 
-	if (!stainfo_offset_valid(offset))
-		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
-
 	return offset;
 }
 
 inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
 {
-	if (!stainfo_offset_valid(offset))
-		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
-
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index d40669c21fc1..b923d5abd94b 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -335,9 +335,6 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 {
 	u8 center_ch;
 
-	if (padapter->bNotifyChannelChange)
-		DBG_88E("[%s] ch = %d, offset = %d, bwmode = %d\n", __func__, channel, channel_offset, bwmode);
-
 	if ((bwmode == HT_CHANNEL_WIDTH_20) ||
 	    (channel_offset == HAL_PRIME_CHNL_OFFSET_DONT_CARE)) {
 		/* SelectChannel(padapter, channel); */
@@ -572,8 +569,6 @@ void WMMOnAssocRsp(struct adapter *padapter)
 			edca[XMIT_VO_QUEUE] = acParm;
 			break;
 		}
-
-		DBG_88E("WMM(%x): %x, %x\n", ACI, ACM, acParm);
 	}
 
 	if (padapter->registrypriv.acm_method == 1)
@@ -608,10 +603,8 @@ void WMMOnAssocRsp(struct adapter *padapter)
 		}
 	}
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < 4; i++)
 		pxmitpriv->wmm_para_seq[i] = inx[i];
-		DBG_88E("wmm_para_seq(%d): %d\n", i, pxmitpriv->wmm_para_seq[i]);
-	}
 }
 
 static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
@@ -758,8 +751,6 @@ void HTOnAssocRsp(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable)) {
 		pmlmeinfo->HT_enable = 1;
 	} else {
@@ -857,16 +848,11 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	len = packet_len - sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	if (len > MAX_IE_SZ) {
-		DBG_88E("%s IE too long for survey event\n", __func__);
+	if (len > MAX_IE_SZ)
 		return _FAIL;
-	}
 
-	if (memcmp(cur_network->network.MacAddress, pbssid, 6)) {
-		DBG_88E("Oops: rtw_check_network_encrypt linked but recv other bssid bcn\n%pM %pM\n",
-			(pbssid), (cur_network->network.MacAddress));
+	if (memcmp(cur_network->network.MacAddress, pbssid, 6))
 		return true;
-	}
 
 	bssid = kzalloc(sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
 	if (!bssid)
@@ -902,11 +888,6 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
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
@@ -920,27 +901,20 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 			bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
 			p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
-			if (pht_info) {
-					bcn_channel = pht_info->primary_channel;
-			} else { /* we don't find channel IE, so don't check it */
-					DBG_88E("Oops: %s we don't find channel IE, so don't check it\n", __func__);
-					bcn_channel = Adapter->mlmeextpriv.cur_channel;
-			}
-	}
-	if (bcn_channel != Adapter->mlmeextpriv.cur_channel) {
-			DBG_88E("%s beacon channel:%d cur channel:%d disconnect\n", __func__,
-				bcn_channel, Adapter->mlmeextpriv.cur_channel);
-			goto _mismatch;
+			if (pht_info)
+				bcn_channel = pht_info->primary_channel;
+			else /* we don't find channel IE, so don't check it */
+				bcn_channel = Adapter->mlmeextpriv.cur_channel;
 	}
+	if (bcn_channel != Adapter->mlmeextpriv.cur_channel)
+		goto _mismatch;
 
 	/* checking SSID */
 	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
-	if (!p) {
-		DBG_88E("%s marc: cannot find SSID for survey event\n", __func__);
+	if (!p)
 		hidden_ssid = true;
-	} else {
+	else
 		hidden_ssid = false;
-	}
 
 	if ((NULL != p) && (false == hidden_ssid && (*(p + 1)))) {
 		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
@@ -952,10 +926,9 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
 	    bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
-		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
-			DBG_88E("%s(), SSID is not match return FAIL\n", __func__);
+		if (bssid->Ssid.Ssid[0] != '\0' &&
+		    bssid->Ssid.SsidLength != 0) /* not hidden ssid */
 			goto _mismatch;
-		}
 	}
 
 	/* check encryption info */
@@ -966,10 +939,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	else
 		bssid->Privacy = 0;
 
-	if (cur_network->network.Privacy != bssid->Privacy) {
-		DBG_88E("%s(), privacy is not match return FAIL\n", __func__);
+	if (cur_network->network.Privacy != bssid->Privacy)
 		goto _mismatch;
-	}
 
 	rtw_get_sec_ie(bssid->IEs, bssid->IELength, NULL, &rsn_len, NULL, &wpa_len);
 
@@ -982,10 +953,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 			encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
 
-	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol) {
-		DBG_88E("%s(): enctyp is not match , return FAIL\n", __func__);
+	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol)
 		goto _mismatch;
-	}
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
 		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength - 12);
@@ -998,17 +967,12 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 				rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is_8021x);
 		}
 
-		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
-			DBG_88E("%s pairwise_cipher(%x:%x) or group_cipher(%x:%x) is not match , return FAIL\n", __func__,
-				pairwise_cipher, cur_network->BcnInfo.pairwise_cipher,
-				group_cipher, cur_network->BcnInfo.group_cipher);
+		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher ||
+		    group_cipher != cur_network->BcnInfo.group_cipher)
 			goto _mismatch;
-		}
 
-		if (is_8021x != cur_network->BcnInfo.is_8021x) {
-			DBG_88E("%s authentication is not match , return FAIL\n", __func__);
+		if (is_8021x != cur_network->BcnInfo.is_8021x)
 			goto _mismatch;
-		}
 	}
 
 	kfree(bssid);
@@ -1257,39 +1221,27 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
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
-				if (!ralink_vendor_flag) {
+				if (!ralink_vendor_flag)
 					ralink_vendor_flag = 1;
-				} else {
-					DBG_88E("link to Ralink AP\n");
+				else
 					return HT_IOT_PEER_RALINK;
-				}
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
-				if (ralink_vendor_flag) {
-					DBG_88E("link to Tenda W311R AP\n");
+				if (ralink_vendor_flag)
 					return HT_IOT_PEER_TENDA;
-				} else {
-					DBG_88E("Capture EPIGRAM_OUI\n");
-				}
 			} else {
 				break;
 			}
@@ -1301,16 +1253,12 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 		i += (pIE->Length + 2);
 	}
 
-	if (ralink_vendor_flag && !epigram_vendor_flag) {
-		DBG_88E("link to Ralink AP\n");
+	if (ralink_vendor_flag && !epigram_vendor_flag)
 		return HT_IOT_PEER_RALINK;
-	} else if (ralink_vendor_flag && epigram_vendor_flag) {
-		DBG_88E("link to Tenda W311R AP\n");
+	else if (ralink_vendor_flag && epigram_vendor_flag)
 		return HT_IOT_PEER_TENDA;
-	} else {
-		DBG_88E("link to new AP\n");
+	else
 		return HT_IOT_PEER_UNKNOWN;
-	}
 }
 
 void update_IOT_info(struct adapter *padapter)
@@ -1518,13 +1466,11 @@ int rtw_handle_dualmac(struct adapter *adapter, bool init)
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
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index fc71884685bb..eebadb0bee5b 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -372,7 +372,6 @@ u8	qos_acm(u8 acm_mask, u8 priority)
 			change_priority = 5;
 		break;
 	default:
-		DBG_88E("qos_acm(): invalid pattrib->priority: %d!!!\n", priority);
 		break;
 	}
 
@@ -487,7 +486,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	if (psta) {
 		pattrib->mac_id = psta->mac_id;
-		/* DBG_88E("%s ==> mac_id(%d)\n", __func__, pattrib->mac_id); */
 		pattrib->psta = psta;
 	} else {
 		/*  if we cannot get psta => drop the pkt */
@@ -892,10 +890,8 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	if (!psta)
 		return _FAIL;
 
-	if (!pxmitframe->buf_addr) {
-		DBG_88E("==> %s buf_addr == NULL\n", __func__);
+	if (!pxmitframe->buf_addr)
 		return _FAIL;
-	}
 
 	pbuf_start = pxmitframe->buf_addr;
 
@@ -904,7 +900,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	mem_start = pbuf_start +	hw_hdr_offset;
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
-		DBG_88E("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -1001,7 +996,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	}
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
-		DBG_88E("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -1131,10 +1125,8 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		pxmitbuf->priv_data = NULL;
 		/* pxmitbuf->ext_tag = true; */
 
-		if (pxmitbuf->sctx) {
-			DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 
 	spin_unlock_irqrestore(&pfree_queue->lock, flags);
@@ -1169,8 +1161,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 	struct __queue *pfree_xmitbuf_queue = &pxmitpriv->free_xmitbuf_queue;
 	unsigned long flags;
 
-	/* DBG_88E("+rtw_alloc_xmitbuf\n"); */
-
 	spin_lock_irqsave(&pfree_xmitbuf_queue->lock, flags);
 
 	if (list_empty(&pfree_xmitbuf_queue->queue)) {
@@ -1188,10 +1178,8 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 	if (pxmitbuf) {
 		pxmitpriv->free_xmitbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
-		if (pxmitbuf->sctx) {
-			DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, flags);
 
@@ -1206,10 +1194,8 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 	if (!pxmitbuf)
 		return _FAIL;
 
-	if (pxmitbuf->sctx) {
-		DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
+	if (pxmitbuf->sctx)
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_FREE);
-	}
 
 	if (pxmitbuf->ext_tag) {
 		rtw_free_xmitbuf_ext(pxmitpriv, pxmitbuf);
@@ -1477,7 +1463,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	if (!psta) {
 		res = _FAIL;
-		DBG_88E("rtw_xmit_classifier: psta == NULL\n");
 		goto exit;
 	}
 
@@ -1722,10 +1707,8 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	s32 res;
 
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (!pxmitframe) {
-		DBG_88E("DBG_TX_DROP_FRAME %s no more pxmitframe\n", __func__);
+	if (!pxmitframe)
 		return -1;
-	}
 
 	rcu_read_lock();
 	br_port = rcu_dereference(padapter->pnetdev->rx_handler_data);
@@ -2145,13 +2128,11 @@ int rtw_sctx_wait(struct submit_ctx *sctx)
 	int status = 0;
 
 	expire = sctx->timeout_ms ? msecs_to_jiffies(sctx->timeout_ms) : MAX_SCHEDULE_TIMEOUT;
-	if (!wait_for_completion_timeout(&sctx->done, expire)) {
+	if (!wait_for_completion_timeout(&sctx->done, expire))
 		/* timeout, do something?? */
 		status = RTW_SCTX_DONE_TIMEOUT;
-		DBG_88E("%s timeout\n", __func__);
-	} else {
+	else
 		status = sctx->status;
-	}
 
 	if (status == RTW_SCTX_DONE_SUCCESS)
 		ret = _SUCCESS;
@@ -2177,8 +2158,7 @@ static bool rtw_sctx_chk_waring_status(int status)
 void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
-		if (rtw_sctx_chk_waring_status(status))
-			DBG_88E("%s status:%d\n", __func__, status);
+		rtw_sctx_chk_waring_status(status);
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
 		*sctx = NULL;
@@ -2202,6 +2182,4 @@ void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status)
 
 	if (pxmitpriv->ack_tx)
 		rtw_sctx_done_err(&pack_tx_ops, status);
-	else
-		DBG_88E("%s ack_tx not set\n", __func__);
 }
-- 
2.34.1

