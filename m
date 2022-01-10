Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEFF4898D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbiAJMr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245705AbiAJMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:47:02 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FEEC06175C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:47:00 -0800 (PST)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6u4d-0007Td-Ux; Mon, 10 Jan 2022 13:46:56 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 9/9] staging: r8188eu: merge ODM_ConfigBBWithHeaderFile with its callers
Date:   Mon, 10 Jan 2022 13:46:38 +0100
Message-Id: <20220110124638.6909-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220110124638.6909-1-martin@kaiser.cx>
References: <20220110124638.6909-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_ConfigBBWithHeaderFile is a "multiplexer" for ODM_ReadAndConfig_...
functions. It's called only from phy_BB8188E_Config_ParaFile.

We can remove ODM_ConfigBBWithHeaderFile and call the
ODM_ReadAndConfig_... functions directly.

ODM_ReadAndConfig_PHY_REG_PG_8188E does not return an error status,
there's no need for a check.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c     | 15 ---------------
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c  |  8 +++-----
 drivers/staging/r8188eu/include/odm_HWConfig.h |  3 ---
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 1c3074fc6be4..dcc38b036280 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -362,18 +362,3 @@ enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm)
 {
 	return ODM_ReadAndConfig_RadioA_1T_8188E(dm_odm);
 }
-
-enum HAL_STATUS ODM_ConfigBBWithHeaderFile(struct odm_dm_struct *dm_odm,
-					   enum odm_bb_config_type config_tp)
-{
-	if (config_tp == CONFIG_BB_PHY_REG) {
-		return ODM_ReadAndConfig_PHY_REG_1T_8188E(dm_odm);
-	} else if (config_tp == CONFIG_BB_AGC_TAB) {
-		return ODM_ReadAndConfig_AGC_TAB_1T_8188E(dm_odm);
-	} else if (config_tp == CONFIG_BB_PHY_REG_PG) {
-		ODM_ReadAndConfig_PHY_REG_PG_8188E(dm_odm);
-		return HAL_STATUS_SUCCESS;
-	}
-
-	return HAL_STATUS_FAILURE;
-}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 15370b674e53..0b0690dfb947 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -493,7 +493,7 @@ static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
 	/*  1. Read PHY_REG.TXT BB INIT!! */
 	/*  We will separate as 88C / 92C according to chip version */
 	/*  */
-	if (HAL_STATUS_FAILURE == ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_PHY_REG))
+	if (HAL_STATUS_FAILURE == ODM_ReadAndConfig_PHY_REG_1T_8188E(&pHalData->odmpriv))
 		rtStatus = _FAIL;
 	if (rtStatus != _SUCCESS)
 		goto phy_BB8190_Config_ParaFile_Fail;
@@ -501,16 +501,14 @@ static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
 	/*  2. If EEPROM or EFUSE autoload OK, We must config by PHY_REG_PG.txt */
 	if (!pEEPROM->bautoload_fail_flag) {
 		pHalData->pwrGroupCnt = 0;
-
-		if (HAL_STATUS_FAILURE == ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_PHY_REG_PG))
-			rtStatus = _FAIL;
+		ODM_ReadAndConfig_PHY_REG_PG_8188E(&pHalData->odmpriv);
 	}
 
 	if (rtStatus != _SUCCESS)
 		goto phy_BB8190_Config_ParaFile_Fail;
 
 	/*  3. BB AGC table Initialization */
-	if (HAL_STATUS_FAILURE == ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv,  CONFIG_BB_AGC_TAB))
+	if (HAL_STATUS_FAILURE == ODM_ReadAndConfig_AGC_TAB_1T_8188E(&pHalData->odmpriv))
 		rtStatus = _FAIL;
 
 	if (rtStatus != _SUCCESS)
diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
index 1bd6f254bf53..b37962edb2ed 100644
--- a/drivers/staging/r8188eu/include/odm_HWConfig.h
+++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
@@ -67,7 +67,4 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *pDM_Odm,
 			struct adapter *adapt);
 
 enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *pDM_Odm);
-
-enum HAL_STATUS ODM_ConfigBBWithHeaderFile(struct odm_dm_struct *pDM_Odm,
-					   enum odm_bb_config_type ConfigType);
 #endif
-- 
2.30.2

