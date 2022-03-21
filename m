Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2374E31E4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353378AbiCUUfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353386AbiCUUf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:35:28 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD13EBB8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:34:03 -0700 (PDT)
Received: from dslb-094-219-034-255.094.219.pools.vodafone-ip.de ([94.219.34.255] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nWOj1-0003ce-7M; Mon, 21 Mar 2022 21:33:59 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/6] staging: r8188eu: refactor dm func set and clear
Date:   Mon, 21 Mar 2022 21:30:31 +0100
Message-Id: <20220321203031.143486-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220321203031.143486-1-martin@kaiser.cx>
References: <20220321203031.143486-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code to set and clear "dm functions".

The only remaining callers of Switch_DM_Func use
Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true) or
Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false).

Remove Switch_DM_Func and call SetHwReg8188EU directly.

For HW_VAR_DM_FUNC_SET, the parameter is always DYNAMIC_ALL_FUNC_ENABLE.
This operation resets podmpriv->SupportAbility to the initial value.
Rename HW_VAR_DM_FUNC_SET to HW_VAR_DM_FUNC_RESET and drop the unused
else branch.

For HW_VAR_DM_FUNC_CLR, the parameter is always DYNAMIC_FUNC_DISABLE
(0x00). We can set podmpriv->SupportAbility to 0 directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    |  6 +++---
 drivers/staging/r8188eu/core/rtw_wlan_util.c   |  8 --------
 drivers/staging/r8188eu/hal/usb_halinit.c      | 10 +++-------
 drivers/staging/r8188eu/include/hal_intf.h     |  2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  1 -
 5 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 10d5f1222936..96e8d346588b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6721,7 +6721,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	}
 
 	/* turn on dynamic functions */
-	Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
+	SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_RESET, NULL);
 
 	/*  update IOT-releated issue */
 	update_IOT_info(padapter);
@@ -7122,7 +7122,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 
 		/* disable dynamic functions, such as high power, DIG */
 		Save_DM_Func_Flag(padapter);
-		Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false);
+		SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_CLR, NULL);
 
 		/* cancel link timer */
 		_cancel_timer_ex(&pmlmeext->link_timer);
@@ -7391,7 +7391,7 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	if ((pmlmeext->sitesurvey_res.state == SCAN_START) || (pmlmeext->sitesurvey_res.state == SCAN_TXNULL)) {
 		/* disable dynamic functions, such as high power, DIG */
 		Save_DM_Func_Flag(padapter);
-		Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false);
+		SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_CLR, NULL);
 
 		/* config the initial gain under scanning, need to write the BB registers */
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 2d495a756abf..5a1eede57458 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -276,14 +276,6 @@ void Restore_DM_Func_Flag(struct adapter *padapter)
 	SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
 }
 
-void Switch_DM_Func(struct adapter *padapter, u32 mode, u8 enable)
-{
-	if (enable)
-		SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_SET, (u8 *)(&mode));
-	else
-		SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_CLR, (u8 *)(&mode));
-}
-
 void Set_MSR(struct adapter *padapter, u8 type)
 {
 	u8 val8;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 11dc8834acac..789ad11170b2 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1148,15 +1148,11 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		else
 			podmpriv->SupportAbility = podmpriv->BK_SupportAbility;
 		break;
-	case HW_VAR_DM_FUNC_SET:
-		if (*((u32 *)val) == DYNAMIC_ALL_FUNC_ENABLE) {
-			podmpriv->SupportAbility =	pdmpriv->InitODMFlag;
-		} else {
-			podmpriv->SupportAbility |= *((u32 *)val);
-		}
+	case HW_VAR_DM_FUNC_RESET:
+		podmpriv->SupportAbility = pdmpriv->InitODMFlag;
 		break;
 	case HW_VAR_DM_FUNC_CLR:
-		podmpriv->SupportAbility &= *((u32 *)val);
+		podmpriv->SupportAbility = 0;
 		break;
 	case HW_VAR_AC_PARAM_BE:
 		haldata->AcParam_BE = ((u32 *)(val))[0];
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 3cededa4dcfc..6f661c4af358 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -22,7 +22,7 @@ enum hw_variables {
 	HW_VAR_BCN_VALID,
 	HW_VAR_DM_FLAG,
 	HW_VAR_DM_FUNC_OP,
-	HW_VAR_DM_FUNC_SET,
+	HW_VAR_DM_FUNC_RESET,
 	HW_VAR_DM_FUNC_CLR,
 	HW_VAR_AC_PARAM_BE,
 	HW_VAR_ACM_CTRL,
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 9092e775fc5d..3dde2bd0d77a 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -410,7 +410,6 @@ void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen);
 
 void Save_DM_Func_Flag(struct adapter *padapter);
 void Restore_DM_Func_Flag(struct adapter *padapter);
-void Switch_DM_Func(struct adapter *padapter, u32 mode, u8 enable);
 
 void Set_MSR(struct adapter *padapter, u8 type);
 
-- 
2.30.2

