Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F704898D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbiAJMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245654AbiAJMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:46:54 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72853C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:46:53 -0800 (PST)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6u4X-0007Td-Ii; Mon, 10 Jan 2022 13:46:49 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/9] staging: r8188eu: remove unused function parameter
Date:   Mon, 10 Jan 2022 13:46:32 +0100
Message-Id: <20220110124638.6909-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220110124638.6909-1-martin@kaiser.cx>
References: <20220110124638.6909-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_ConfigRFWithHeaderFile does not use its content parameter.
Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c     | 1 -
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c  | 2 +-
 drivers/staging/r8188eu/include/odm_HWConfig.h | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index d5212a166dd2..a62af532ac82 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -363,7 +363,6 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
 }
 
 enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm,
-					   enum rf_radio_path content,
 					   enum rf_radio_path rfpath)
 {
 	if (rfpath == RF_PATH_A)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 7474db05e8af..a5c94be95ccb 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -399,7 +399,7 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	udelay(1);/* PlatformStallExecution(1); */
 
 	/*----Initialize RF fom connfiguration file----*/
-	if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, RF_PATH_A, RF_PATH_A))
+	if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, RF_PATH_A))
 		rtStatus = _FAIL;
 
 	/*----Restore RFENV control type----*/;
diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
index 3ed265e00ac1..efc809354720 100644
--- a/drivers/staging/r8188eu/include/odm_HWConfig.h
+++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
@@ -96,7 +96,6 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *pDM_Odm,
 			struct adapter *adapt);
 
 enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *pDM_Odm,
-					   enum rf_radio_path Content,
 					   enum rf_radio_path eRFPath);
 
 enum HAL_STATUS ODM_ConfigBBWithHeaderFile(struct odm_dm_struct *pDM_Odm,
-- 
2.30.2

