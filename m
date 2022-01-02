Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B160C482C7E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 19:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiABSAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 13:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiABSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 13:00:19 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE558C061784
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 10:00:18 -0800 (PST)
Received: from dslb-188-104-058-096.188.104.pools.vodafone-ip.de ([188.104.58.96] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n459S-0005Ye-F5; Sun, 02 Jan 2022 19:00:15 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/5] staging: r8188eu: internal autosuspend is always false
Date:   Sun,  2 Jan 2022 18:59:29 +0100
Message-Id: <20220102175932.89127-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220102175932.89127-1-martin@kaiser.cx>
References: <20220102175932.89127-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bInternalAutoSuspend is always false. Remove the variable and related
checks.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 9 +--------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 4 ----
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 3 +--
 4 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 7fa4516af6ec..46e44aee587f 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -351,7 +351,6 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 
 	pwrctrlpriv->pwr_state_check_interval = RTW_PWR_STATE_CHK_INTERVAL;
 	pwrctrlpriv->pwr_state_check_cnts = 0;
-	pwrctrlpriv->bInternalAutoSuspend = false;
 	pwrctrlpriv->bInSuspend = false;
 	pwrctrlpriv->bkeepfwalive = false;
 
@@ -396,7 +395,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 	}
 
 	/* System suspend is not allowed to wakeup */
-	if ((!pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend) {
+	if (pwrpriv->bInSuspend) {
 		while (pwrpriv->bInSuspend &&
 		       (rtw_get_passing_time_ms(start) <= 3000 ||
 		       (rtw_get_passing_time_ms(start) <= 500)))
@@ -407,12 +406,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 			DBG_88E("%s wait bInSuspend done\n", __func__);
 	}
 
-	/* block??? */
-	if ((pwrpriv->bInternalAutoSuspend)  && (padapter->net_closed)) {
-		ret = _FAIL;
-		goto exit;
-	}
-
 	/* I think this should be check in IPS, LPS, autosuspend functions... */
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 		ret = _SUCCESS;
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 40032447355d..2d5298373d74 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -75,7 +75,6 @@ struct pwrctrl_priv {
 	s32		pnp_current_pwr_state;
 	u8		pnp_bstop_trx;
 
-	u8		bInternalAutoSuspend;
 	u8		bInSuspend;
 	u8		bSupportRemoteWakeup;
 	struct timer_list pwr_state_check_timer;
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index f81e26785d66..b65e44f97826 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -760,10 +760,6 @@ int netdev_close(struct net_device *pnetdev)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 
-	if (padapter->pwrctrlpriv.bInternalAutoSuspend) {
-		if (padapter->pwrctrlpriv.rf_pwrstate == rf_off)
-			padapter->pwrctrlpriv.ps_flag = true;
-	}
 	padapter->net_closed = true;
 
 	if (padapter->pwrctrlpriv.rf_pwrstate == rf_on) {
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 5c1faf01cb51..91792dfd3bbe 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -192,8 +192,7 @@ static void rtw_dev_unload(struct adapter *padapter)
 		if (padapter->intf_stop)
 			padapter->intf_stop(padapter);
 		/* s4. */
-		if (!padapter->pwrctrlpriv.bInternalAutoSuspend)
-			rtw_stop_drv_threads(padapter);
+		rtw_stop_drv_threads(padapter);
 
 		/* s5. */
 		if (!padapter->bSurpriseRemoved) {
-- 
2.30.2

