Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104484A8D18
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353993AbiBCUSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354005AbiBCUSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:18:09 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA17DC061741
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:18:09 -0800 (PST)
Received: from dslb-188-096-149-005.188.096.pools.vodafone-ip.de ([188.96.149.5] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nFiYK-0004N1-Vn; Thu, 03 Feb 2022 21:18:01 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] staging: r8188eu: simplify error handling in phy_BB8188E_Config_ParaFile
Date:   Thu,  3 Feb 2022 21:17:45 +0100
Message-Id: <20220203201745.251826-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203201745.251826-1-martin@kaiser.cx>
References: <20220203201745.251826-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify error handling in phy_BB8188E_Config_ParaFile. Exit immediately
when there's an error, do not jump to the end of the function. We do not
have anything to clean up before we return.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index accbd08d4fd1..8279768201b7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -487,16 +487,13 @@ static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
 {
 	struct eeprom_priv *pEEPROM = &Adapter->eeprompriv;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
-	int			rtStatus = _SUCCESS;
 
 	/*  */
 	/*  1. Read PHY_REG.TXT BB INIT!! */
 	/*  We will separate as 88C / 92C according to chip version */
 	/*  */
 	if (HAL_STATUS_FAILURE == ODM_ReadAndConfig_PHY_REG_1T_8188E(&pHalData->odmpriv))
-		rtStatus = _FAIL;
-	if (rtStatus != _SUCCESS)
-		goto phy_BB8190_Config_ParaFile_Fail;
+		return _FAIL;
 
 	/*  2. If EEPROM or EFUSE autoload OK, We must config by PHY_REG_PG.txt */
 	if (!pEEPROM->bautoload_fail_flag) {
@@ -506,11 +503,9 @@ static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
 
 	/*  3. BB AGC table Initialization */
 	if (HAL_STATUS_FAILURE == ODM_ReadAndConfig_AGC_TAB_1T_8188E(&pHalData->odmpriv))
-		rtStatus = _FAIL;
+		return _FAIL;
 
-phy_BB8190_Config_ParaFile_Fail:
-
-	return rtStatus;
+	return _SUCCESS;
 }
 
 int
-- 
2.30.2

