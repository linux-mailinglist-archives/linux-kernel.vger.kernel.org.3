Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEF34898D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245652AbiAJMrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245667AbiAJMq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:46:57 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95393C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:46:56 -0800 (PST)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6u4a-0007Td-Kc; Mon, 10 Jan 2022 13:46:52 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/9] staging: r8188eu: relay errors from ODM_ReadAndConfig_...
Date:   Mon, 10 Jan 2022 13:46:35 +0100
Message-Id: <20220110124638.6909-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220110124638.6909-1-martin@kaiser.cx>
References: <20220110124638.6909-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the ODM_ReadAndConfig_... functions return an error status.
Update their callers to process these return values.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 2f0752418fe2..5ec9a04be26b 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -360,22 +360,22 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
 
 enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm)
 {
-	ODM_ReadAndConfig_RadioA_1T_8188E(dm_odm);
-
-	return HAL_STATUS_SUCCESS;
+	return ODM_ReadAndConfig_RadioA_1T_8188E(dm_odm);
 }
 
 enum HAL_STATUS ODM_ConfigBBWithHeaderFile(struct odm_dm_struct *dm_odm,
 					   enum odm_bb_config_type config_tp)
 {
-	if (config_tp == CONFIG_BB_PHY_REG)
-		ODM_ReadAndConfig_PHY_REG_1T_8188E(dm_odm);
-	else if (config_tp == CONFIG_BB_AGC_TAB)
-		ODM_ReadAndConfig_AGC_TAB_1T_8188E(dm_odm);
-	else if (config_tp == CONFIG_BB_PHY_REG_PG)
+	if (config_tp == CONFIG_BB_PHY_REG) {
+		return ODM_ReadAndConfig_PHY_REG_1T_8188E(dm_odm);
+	} else if (config_tp == CONFIG_BB_AGC_TAB) {
+		return ODM_ReadAndConfig_AGC_TAB_1T_8188E(dm_odm);
+	} else if (config_tp == CONFIG_BB_PHY_REG_PG) {
 		ODM_ReadAndConfig_PHY_REG_PG_8188E(dm_odm);
+		return HAL_STATUS_SUCCESS;
+	}
 
-	return HAL_STATUS_SUCCESS;
+	return HAL_STATUS_FAILURE;
 }
 
 enum HAL_STATUS ODM_ConfigMACWithHeaderFile(struct odm_dm_struct *dm_odm)
-- 
2.30.2

