Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E194898D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245673AbiAJMq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245632AbiAJMqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:46:53 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FECC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:46:52 -0800 (PST)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6u4W-0007Td-Ee; Mon, 10 Jan 2022 13:46:48 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/9] staging: r8188eu: remove a constant variable
Date:   Mon, 10 Jan 2022 13:46:31 +0100
Message-Id: <20220110124638.6909-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220110124638.6909-1-martin@kaiser.cx>
References: <20220110124638.6909-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eRFPath variable in phy_RF6052_Config_ParaFile is always 0.

Remove the variable and use 0 directly. (enum rf_radio_path)eRFPath can
be replaced with RF_PATH_A, which is defined as 0.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 7e4744989a66..7474db05e8af 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -374,12 +374,11 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	struct bb_reg_def *pPhyReg;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u32 u4RegValue = 0;
-	u8 eRFPath = 0;
 	int rtStatus = _SUCCESS;
 
 	/* Initialize RF */
 
-	pPhyReg = &pHalData->PHYRegDef[eRFPath];
+	pPhyReg = &pHalData->PHYRegDef[0];
 
 	/*----Store original RFENV control type----*/
 	u4RegValue = rtl8188e_PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV);
@@ -400,7 +399,7 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	udelay(1);/* PlatformStallExecution(1); */
 
 	/*----Initialize RF fom connfiguration file----*/
-	if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, (enum rf_radio_path)eRFPath, (enum rf_radio_path)eRFPath))
+	if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, RF_PATH_A, RF_PATH_A))
 		rtStatus = _FAIL;
 
 	/*----Restore RFENV control type----*/;
-- 
2.30.2

