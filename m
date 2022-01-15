Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1C48F818
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiAOQ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiAOQ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:56:05 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A99C06173F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:56:05 -0800 (PST)
Received: from dslb-178-004-201-171.178.004.pools.vodafone-ip.de ([178.4.201.171] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n8mLQ-0005N8-GU; Sat, 15 Jan 2022 17:56:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 11/11] staging: r8188eu: remove _cancel_timer_ex wrapper
Date:   Sat, 15 Jan 2022 17:55:36 +0100
Message-Id: <20220115165536.231210-12-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220115165536.231210-1-martin@kaiser.cx>
References: <20220115165536.231210-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the _cancel_timer_ex wrapper function with a call to
del_timer_sync.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 38 +++++++++----------
 drivers/staging/r8188eu/core/rtw_p2p.c        | 10 ++---
 drivers/staging/r8188eu/core/rtw_recv.c       |  2 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  6 +--
 .../staging/r8188eu/include/osdep_service.h   |  5 ---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 16 ++++----
 7 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index a169a7a39ebc..beb3b3392387 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -389,9 +389,9 @@ void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
 		return;
 
 	if (padapter->bDriverStopped) {
-		_cancel_timer_ex(&pmlmeext->survey_timer);
-		_cancel_timer_ex(&pmlmeext->link_timer);
-		/* _cancel_timer_ex(&pmlmeext->ADDBA_timer); */
+		del_timer_sync(&pmlmeext->survey_timer);
+		del_timer_sync(&pmlmeext->link_timer);
+		/* del_timer_sync(&pmlmeext->ADDBA_timer); */
 	}
 }
 
@@ -1402,7 +1402,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)
 		return _SUCCESS;
 
-	_cancel_timer_ex(&pmlmeext->link_timer);
+	del_timer_sync(&pmlmeext->link_timer);
 
 	/* status */
 	status = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 2));
@@ -1481,7 +1481,7 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 		return _SUCCESS;
 
 	if (pwdinfo->rx_invitereq_info.scan_op_ch_only) {
-		_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
+		del_timer_sync(&pwdinfo->reset_ch_sitesurvey);
 		_set_timer(&pwdinfo->reset_ch_sitesurvey, 10);
 	}
 
@@ -1556,7 +1556,7 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 		return _SUCCESS;
 
 	if (pwdinfo->rx_invitereq_info.scan_op_ch_only) {
-		_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
+		del_timer_sync(&pwdinfo->reset_ch_sitesurvey);
 		_set_timer(&pwdinfo->reset_ch_sitesurvey, 10);
 	}
 
@@ -3737,7 +3737,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	if (rtw_action_public_decache(precv_frame, dialogToken) == _FAIL)
 		return _FAIL;
 
-	_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
+	del_timer_sync(&pwdinfo->reset_ch_sitesurvey);
 	/*	Do nothing if the driver doesn't enable the P2P function. */
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE) || rtw_p2p_chk_state(pwdinfo, P2P_STATE_IDLE))
 		return _SUCCESS;
@@ -3755,7 +3755,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_FAIL)) {
 			/*	Commented by Albert 20110526 */
 			/*	In this case, this means the previous nego fail doesn't be reset yet. */
-			_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
+			del_timer_sync(&pwdinfo->restore_p2p_state_timer);
 			/*	Restore the previous p2p state */
 			rtw_p2p_set_state(pwdinfo, rtw_p2p_pre_state(pwdinfo));
 			DBG_88E("[%s] Restore the previous p2p state to %d\n", __func__, rtw_p2p_state(pwdinfo));
@@ -3784,7 +3784,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_ING)) {
 			/*	Commented by Albert 20110425 */
 			/*	The restore timer is enabled when issuing the nego request frame of rtw_p2p_connect function. */
-			_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
+			del_timer_sync(&pwdinfo->restore_p2p_state_timer);
 			pwdinfo->nego_req_info.benable = false;
 			result = process_p2p_group_negotation_resp(pwdinfo, frame_body, len);
 			issue_p2p_GO_confirm(pwdinfo->padapter, GetAddr2Ptr(pframe), result);
@@ -3935,7 +3935,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		u32	attr_contentlen = 0;
 
 		DBG_88E("[%s] Got invite response frame!\n", __func__);
-		_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
+		del_timer_sync(&pwdinfo->restore_p2p_state_timer);
 		p2p_ie = rtw_get_p2p_ie(frame_body + _PUBLIC_ACTION_IE_OFFSET_, len - _PUBLIC_ACTION_IE_OFFSET_, NULL, &p2p_ielen);
 		if (p2p_ie) {
 			rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_STATUS, &attr_content, &attr_contentlen);
@@ -3993,7 +3993,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		DBG_88E("[%s] Got Provisioning Discovery Response Frame\n", __func__);
 		/*	Commented by Albert 20110426 */
 		/*	The restore timer is enabled when issuing the provisioing request frame in rtw_p2p_prov_disc function. */
-		_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
+		del_timer_sync(&pwdinfo->restore_p2p_state_timer);
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_RX_PROVISION_DIS_RSP);
 		process_p2p_provdisc_resp(pwdinfo, pframe);
 		_set_timer(&pwdinfo->restore_p2p_state_timer, P2P_PROVISION_TIMEOUT);
@@ -5605,7 +5605,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	if (!(rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) && (pwdinfo->rx_invitereq_info.scan_op_ch_only)) {
-		_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
+		del_timer_sync(&pwdinfo->reset_ch_sitesurvey);
 		_set_timer(&pwdinfo->reset_ch_sitesurvey, 10);
 	}
 
@@ -6454,7 +6454,7 @@ void start_clnt_auth(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	_cancel_timer_ex(&pmlmeext->link_timer);
+	del_timer_sync(&pmlmeext->link_timer);
 
 	pmlmeinfo->state &= (~WIFI_FW_AUTH_NULL);
 	pmlmeinfo->state |= WIFI_FW_AUTH_STATE;
@@ -6483,7 +6483,7 @@ void start_clnt_assoc(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	_cancel_timer_ex(&pmlmeext->link_timer);
+	del_timer_sync(&pmlmeext->link_timer);
 
 	pmlmeinfo->state &= (~(WIFI_FW_AUTH_NULL | WIFI_FW_AUTH_STATE));
 	pmlmeinfo->state |= (WIFI_FW_AUTH_SUCCESS | WIFI_FW_ASSOC_STATE);
@@ -7102,7 +7102,7 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
 		/* set MSR to no link state -> infra. mode */
 		Set_MSR(padapter, _HW_STATE_STATION_);
 
-		_cancel_timer_ex(&pmlmeext->link_timer);
+		del_timer_sync(&pmlmeext->link_timer);
 	}
 }
 
@@ -7441,7 +7441,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 		Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false);
 
 		/* cancel link timer */
-		_cancel_timer_ex(&pmlmeext->link_timer);
+		del_timer_sync(&pmlmeext->link_timer);
 
 		/* clear CAM */
 		flush_all_cam_entry(padapter);
@@ -7481,7 +7481,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 		/* clear CAM */
 		flush_all_cam_entry(padapter);
 
-		_cancel_timer_ex(&pmlmeext->link_timer);
+		del_timer_sync(&pmlmeext->link_timer);
 
 		/* set MSR to nolink -> infra. mode */
 		Set_MSR(padapter, _HW_STATE_STATION_);
@@ -7566,7 +7566,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
 	/* cancel link timer */
-	_cancel_timer_ex(&pmlmeext->link_timer);
+	del_timer_sync(&pmlmeext->link_timer);
 
 	start_clnt_join(padapter);
 
@@ -7609,7 +7609,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	flush_all_cam_entry(padapter);
 
-	_cancel_timer_ex(&pmlmeext->link_timer);
+	del_timer_sync(&pmlmeext->link_timer);
 
 	rtw_free_uc_swdec_pending_queue(padapter);
 
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 50b4fca869a7..718f67ad5ddb 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1947,11 +1947,11 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 
 		/* Disable P2P function */
 		if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
-			_cancel_timer_ex(&pwdinfo->find_phase_timer);
-			_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
-			_cancel_timer_ex(&pwdinfo->pre_tx_scan_timer);
-			_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
-			_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey2);
+			del_timer_sync(&pwdinfo->find_phase_timer);
+			del_timer_sync(&pwdinfo->restore_p2p_state_timer);
+			del_timer_sync(&pwdinfo->pre_tx_scan_timer);
+			del_timer_sync(&pwdinfo->reset_ch_sitesurvey);
+			del_timer_sync(&pwdinfo->reset_ch_sitesurvey2);
 			rtw_p2p_set_state(pwdinfo, P2P_STATE_NONE);
 			rtw_p2p_set_role(pwdinfo, P2P_ROLE_DISABLE);
 			memset(&pwdinfo->rx_prov_disc_info, 0x00, sizeof(struct rx_provdisc_req_info));
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 5438a73ba06b..318c71ed90e1 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1714,7 +1714,7 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, struct recv_frame
 		spin_unlock_bh(&ppending_recvframe_queue->lock);
 	} else {
 		spin_unlock_bh(&ppending_recvframe_queue->lock);
-		_cancel_timer_ex(&preorder_ctrl->reordering_ctrl_timer);
+		del_timer_sync(&preorder_ctrl->reordering_ctrl_timer);
 	}
 
 	return _SUCCESS;
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 54561ff239a0..6553bfa314fa 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -138,7 +138,7 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 
 				for (i = 0; i < 16; i++) {
 					preorder_ctrl = &psta->recvreorder_ctrl[i];
-					_cancel_timer_ex(&preorder_ctrl->reordering_ctrl_timer);
+					del_timer_sync(&preorder_ctrl->reordering_ctrl_timer);
 				}
 			}
 		}
@@ -276,7 +276,7 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	_rtw_init_sta_xmit_priv(&psta->sta_xmitpriv);
 	_rtw_init_sta_recv_priv(&psta->sta_recvpriv);
 
-	_cancel_timer_ex(&psta->addba_retry_timer);
+	del_timer_sync(&psta->addba_retry_timer);
 
 	/* for A-MPDU Rx reordering buffer control, cancel reordering_ctrl_timer */
 	for (i = 0; i < 16 ; i++) {
@@ -287,7 +287,7 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 		preorder_ctrl = &psta->recvreorder_ctrl[i];
 
-		_cancel_timer_ex(&preorder_ctrl->reordering_ctrl_timer);
+		del_timer_sync(&preorder_ctrl->reordering_ctrl_timer);
 
 		ppending_recvframe_queue = &preorder_ctrl->pending_recvframe_queue;
 
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index fca8f3d116c2..1e27706c50bc 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -83,11 +83,6 @@ s32  rtw_get_passing_time_ms(u32 start);
 
 void rtw_usleep_os(int us);
 
-static inline unsigned char _cancel_timer_ex(struct timer_list *ptimer)
-{
-	return del_timer_sync(ptimer);
-}
-
 static inline void flush_signals_thread(void)
 {
 	if (signal_pending (current))
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index b9f9698d70cf..aae7401367c3 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3045,7 +3045,7 @@ static int rtw_p2p_connect(struct net_device *dev,
 		memcpy(pwdinfo->nego_req_info.peerDevAddr, pnetwork->network.MacAddress, ETH_ALEN);
 		pwdinfo->nego_req_info.benable = true;
 
-		_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
+		del_timer_sync(&pwdinfo->restore_p2p_state_timer);
 		if (rtw_p2p_state(pwdinfo) != P2P_STATE_GONEGO_OK) {
 			/*	Restore to the listen state if the current p2p state is not nego OK */
 			rtw_p2p_set_state(pwdinfo, P2P_STATE_LISTEN);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index ef4ba0f22c09..3c9d5142af48 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -525,18 +525,18 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 void rtw_cancel_all_timer(struct adapter *padapter)
 {
-	_cancel_timer_ex(&padapter->mlmepriv.assoc_timer);
+	del_timer_sync(&padapter->mlmepriv.assoc_timer);
 
-	_cancel_timer_ex(&padapter->mlmepriv.scan_to_timer);
+	del_timer_sync(&padapter->mlmepriv.scan_to_timer);
 
-	_cancel_timer_ex(&padapter->mlmepriv.dynamic_chk_timer);
+	del_timer_sync(&padapter->mlmepriv.dynamic_chk_timer);
 
 	/*  cancel sw led timer */
 	rtl8188eu_DeInitSwLeds(padapter);
 
-	_cancel_timer_ex(&padapter->pwrctrlpriv.pwr_state_check_timer);
+	del_timer_sync(&padapter->pwrctrlpriv.pwr_state_check_timer);
 
-	_cancel_timer_ex(&padapter->recvpriv.signal_stat_timer);
+	del_timer_sync(&padapter->recvpriv.signal_stat_timer);
 }
 
 u8 rtw_free_drv_sw(struct adapter *padapter)
@@ -547,9 +547,9 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	{
 		struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 		if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
-			_cancel_timer_ex(&pwdinfo->find_phase_timer);
-			_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
-			_cancel_timer_ex(&pwdinfo->pre_tx_scan_timer);
+			del_timer_sync(&pwdinfo->find_phase_timer);
+			del_timer_sync(&pwdinfo->restore_p2p_state_timer);
+			del_timer_sync(&pwdinfo->pre_tx_scan_timer);
 			rtw_p2p_set_state(pwdinfo, P2P_STATE_NONE);
 		}
 	}
-- 
2.30.2

