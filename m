Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992E14898D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245707AbiAJMrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbiAJMq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:46:56 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA325C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:46:55 -0800 (PST)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6u4Z-0007Td-Ir; Mon, 10 Jan 2022 13:46:51 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/9] staging: r8188eu: replace the READ_AND_CONFIG
Date:   Mon, 10 Jan 2022 13:46:34 +0100
Message-Id: <20220110124638.6909-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220110124638.6909-1-martin@kaiser.cx>
References: <20220110124638.6909-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The READ_AND_CONFIG macro builds a function name from chip type and
table name.

Remove the macro and use the resulting function names directly. This
makes the code easier to read.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 23 ++++++++--------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index ef35e3c31794..2f0752418fe2 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -3,10 +3,6 @@
 
 #include "../include/drv_types.h"
 
-#define READ_AND_CONFIG     READ_AND_CONFIG_MP
-
-#define READ_AND_CONFIG_MP(ic, txt) (ODM_ReadAndConfig##txt##ic(dm_odm))
-
 static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 {
 	if ((AntPower <= -100) || (AntPower >= 20))
@@ -364,7 +360,7 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
 
 enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm)
 {
-	READ_AND_CONFIG(8188E, _RadioA_1T_);
+	ODM_ReadAndConfig_RadioA_1T_8188E(dm_odm);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -372,20 +368,17 @@ enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm)
 enum HAL_STATUS ODM_ConfigBBWithHeaderFile(struct odm_dm_struct *dm_odm,
 					   enum odm_bb_config_type config_tp)
 {
-	if (config_tp == CONFIG_BB_PHY_REG) {
-		READ_AND_CONFIG(8188E, _PHY_REG_1T_);
-	} else if (config_tp == CONFIG_BB_AGC_TAB) {
-		READ_AND_CONFIG(8188E, _AGC_TAB_1T_);
-	} else if (config_tp == CONFIG_BB_PHY_REG_PG) {
-		READ_AND_CONFIG(8188E, _PHY_REG_PG_);
-	}
+	if (config_tp == CONFIG_BB_PHY_REG)
+		ODM_ReadAndConfig_PHY_REG_1T_8188E(dm_odm);
+	else if (config_tp == CONFIG_BB_AGC_TAB)
+		ODM_ReadAndConfig_AGC_TAB_1T_8188E(dm_odm);
+	else if (config_tp == CONFIG_BB_PHY_REG_PG)
+		ODM_ReadAndConfig_PHY_REG_PG_8188E(dm_odm);
 
 	return HAL_STATUS_SUCCESS;
 }
 
 enum HAL_STATUS ODM_ConfigMACWithHeaderFile(struct odm_dm_struct *dm_odm)
 {
-	u8 result = HAL_STATUS_SUCCESS;
-	result = READ_AND_CONFIG(8188E, _MAC_REG_);
-	return result;
+	return ODM_ReadAndConfig_MAC_REG_8188E(dm_odm);
 }
-- 
2.30.2

