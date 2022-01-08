Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D707D48839B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiAHMuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiAHMuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:50:18 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC8C061401
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:50:18 -0800 (PST)
Received: from dslb-188-097-214-229.188.097.pools.vodafone-ip.de ([188.97.214.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6BAk-0005EJ-Ay; Sat, 08 Jan 2022 13:50:14 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/12] staging: r8188eu: ODM_BB_CCK_PD is always set
Date:   Sat,  8 Jan 2022 13:49:50 +0100
Message-Id: <20220108124959.313215-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108124959.313215-1-martin@kaiser.cx>
References: <20220108124959.313215-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ODM_BB_CCK_PD flag is always set.

Remove the flag and the check if ODM_BB_CCK_PD is not set.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c         | 2 --
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 1 -
 drivers/staging/r8188eu/include/odm.h     | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 7cc9ab4b1a59..8156e4acaa09 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -416,8 +416,6 @@ static void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
 	u8 CurCCK_CCAThres;
 	struct false_alarm_stats *FalseAlmCnt = &pDM_Odm->FalseAlmCnt;
 
-	if (!(pDM_Odm->SupportAbility & ODM_BB_CCK_PD))
-		return;
 	if (pDM_Odm->bLinked) {
 		if (pDM_Odm->RSSI_Min > 25) {
 			CurCCK_CCAThres = 0xcd;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 2ff9c7d84dbf..adf87c1721ee 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -54,7 +54,6 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	int i;
 
 	pdmpriv->InitODMFlag = ODM_BB_RSSI_MONITOR |
-				ODM_BB_CCK_PD |
 				ODM_RF_CALIBRATION |
 				ODM_RF_TX_PWR_TRACK;
 	if (hal_data->AntDivCfg)
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 664e75c3a7c2..50960e7daf1d 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -149,7 +149,6 @@ enum odm_common_info_def {
 enum odm_ability_def {
 	/*  BB ODM section BIT 0-15 */
 	ODM_BB_RSSI_MONITOR		= BIT(4),
-	ODM_BB_CCK_PD			= BIT(5),
 	ODM_BB_ANT_DIV			= BIT(6),
 	ODM_BB_PWR_TRA			= BIT(8),
 
-- 
2.30.2

