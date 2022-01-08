Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA5748839C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiAHMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiAHMuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:50:18 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E8C06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:50:17 -0800 (PST)
Received: from dslb-188-097-214-229.188.097.pools.vodafone-ip.de ([188.97.214.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6BAi-0005EJ-Ec; Sat, 08 Jan 2022 13:50:12 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/12] staging: r8188eu: ODM_MAC_EDCA_TURBO is always set
Date:   Sat,  8 Jan 2022 13:49:48 +0100
Message-Id: <20220108124959.313215-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108124959.313215-1-martin@kaiser.cx>
References: <20220108124959.313215-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ODM_MAC_EDCA_TURBO flag is always set for chips that are supported by
this driver. Remove the flag and the one place where it's checked.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c         | 3 ---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 1 -
 drivers/staging/r8188eu/include/odm.h     | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index d8fa587ff286..77ece1950b63 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -563,9 +563,6 @@ static void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
 	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	if (!(pDM_Odm->SupportAbility & ODM_MAC_EDCA_TURBO))
-		return;
-
 	if (pregpriv->wifi_spec == 1)
 		goto dm_CheckEdcaTurbo_EXIT;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index bd6eb3878060..5118d0e3045b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -56,7 +56,6 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	pdmpriv->InitODMFlag = ODM_BB_FA_CNT |
 				ODM_BB_RSSI_MONITOR |
 				ODM_BB_CCK_PD |
-				ODM_MAC_EDCA_TURBO |
 				ODM_RF_CALIBRATION |
 				ODM_RF_TX_PWR_TRACK;
 	if (hal_data->AntDivCfg)
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 23a151c558dc..616a862180b2 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -154,9 +154,6 @@ enum odm_ability_def {
 	ODM_BB_ANT_DIV			= BIT(6),
 	ODM_BB_PWR_TRA			= BIT(8),
 
-	/*  MAC DM section BIT 16-23 */
-	ODM_MAC_EDCA_TURBO		= BIT(16),
-
 	/*  RF ODM section BIT 24-31 */
 	ODM_RF_TX_PWR_TRACK		= BIT(24),
 	ODM_RF_CALIBRATION		= BIT(26),
-- 
2.30.2

