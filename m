Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64CA48F813
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiAOQ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiAOQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:55:59 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1AFC06161C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:55:58 -0800 (PST)
Received: from dslb-178-004-201-171.178.004.pools.vodafone-ip.de ([178.4.201.171] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n8mLK-0005N8-Kf; Sat, 15 Jan 2022 17:55:54 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/11] staging: r8188eu: remove _cancel_timer wrapper
Date:   Sat, 15 Jan 2022 17:55:31 +0100
Message-Id: <20220115165536.231210-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220115165536.231210-1-martin@kaiser.cx>
References: <20220115165536.231210-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the _cancel_timer wrapper function and call del_timer_sync
directly.

None of the callers needs the bcancelled variable that's populated by
_cancel_timer, these variables can be removed in the calling functions.

rtw_surveydone_event_callback calls _cancel_timer only if it believes
that the timer is currently running. We can drop this. It's safe to
call del_timer_sync when the timer is not running. The timer in question,
scan_to_timer, is used only for the site survey command (the rtw_survey
functions) so we won't be stopping it while it's in use by someone else.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_cmd.c          |  3 +--
 drivers/staging/r8188eu/core/rtw_mlme.c         | 14 ++++----------
 drivers/staging/r8188eu/core/rtw_p2p.c          |  4 +---
 drivers/staging/r8188eu/include/osdep_service.h |  6 ------
 4 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 410b5dacfaa7..266bb7db5252 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1460,7 +1460,6 @@ void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 
 void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 {
-	u8 timer_cancelled;
 	struct sta_info *psta = NULL;
 	struct wlan_network *pwlan = NULL;
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1470,7 +1469,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	if (pcmd->res != H2C_SUCCESS)
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 
-	_cancel_timer(&pmlmepriv->assoc_timer, &timer_cancelled);
+	del_timer_sync(&pmlmepriv->assoc_timer);
 
 	spin_lock_bh(&pmlmepriv->lock);
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 394e8a5ce03c..e76a11422f6f 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -674,7 +674,6 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	u8 timer_cancelled = 0;
 
 	spin_lock_bh(&pmlmepriv->lock);
 
@@ -684,16 +683,12 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 		pmlmepriv->wps_probe_req_ie = NULL;
 	}
 
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
-		timer_cancelled = 1;
-
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
-	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
 
-	if (timer_cancelled)
-		_cancel_timer(&pmlmepriv->scan_to_timer, &timer_cancelled);
+	del_timer_sync(&pmlmepriv->scan_to_timer);
 
 	spin_lock_bh(&pmlmepriv->lock);
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
@@ -1017,7 +1012,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 
 void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 {
-	u8 timer_cancelled;
 	struct sta_info *ptarget_sta = NULL, *pcur_sta = NULL;
 	struct	sta_priv *pstapriv = &adapter->stapriv;
 	struct	mlme_priv	*pmlmepriv = &adapter->mlmepriv;
@@ -1092,8 +1086,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 				rtw_indicate_connect(adapter);
 			}
 
-			/* s5. Cancle assoc_timer */
-			_cancel_timer(&pmlmepriv->assoc_timer, &timer_cancelled);
+			/* s5. Cancel assoc_timer */
+			del_timer_sync(&pmlmepriv->assoc_timer);
 		} else {
 			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			goto ignore_joinbss_callback;
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 7b30b9b64b41..50b4fca869a7 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1380,9 +1380,7 @@ u8 process_p2p_group_negotation_confirm(struct wifidirect_info *pwdinfo, u8 *pfr
 			result = attr_content;
 
 			if (attr_content == P2P_STATUS_SUCCESS) {
-				u8	bcancelled = 0;
-
-				_cancel_timer(&pwdinfo->restore_p2p_state_timer, &bcancelled);
+				del_timer_sync(&pwdinfo->restore_p2p_state_timer);
 
 				/*	Commented by Albert 20100911 */
 				/*	Todo: Need to handle the case which both Intents are the same. */
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 8ca9f86e3c9b..754691cb2b12 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -59,12 +59,6 @@ static inline void _set_timer(struct timer_list *ptimer,u32 delay_time)
 	mod_timer(ptimer , (jiffies+(delay_time*HZ/1000)));
 }
 
-static inline void _cancel_timer(struct timer_list *ptimer,u8 *bcancelled)
-{
-	del_timer_sync(ptimer);
-	*bcancelled=  true;/* true ==1; false==0 */
-}
-
 static inline int rtw_netif_queue_stopped(struct net_device *pnetdev)
 {
 	return  netif_tx_queue_stopped(netdev_get_tx_queue(pnetdev, 0)) &&
-- 
2.30.2

