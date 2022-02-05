Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3274AA85E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 12:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351738AbiBELiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 06:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345136AbiBELh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 06:37:56 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F15C061353
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 03:37:56 -0800 (PST)
Received: from dslb-188-104-059-100.188.104.pools.vodafone-ip.de ([188.104.59.100] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGJO4-0005c9-L0; Sat, 05 Feb 2022 12:37:52 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/8] staging: r8188eu: RfRegChnlVal[1] is set but not used
Date:   Sat,  5 Feb 2022 12:37:39 +0100
Message-Id: <20220205113741.379070-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220205113741.379070-1-martin@kaiser.cx>
References: <20220205113741.379070-1-martin@kaiser.cx>
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

RfRegChnlVal[1] in hal_data_8188e is set but not used. This driver needs
only one RfRegChnlVal setting. Replace the array with a single u32.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c  | 4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c  | 8 ++++----
 drivers/staging/r8188eu/hal/usb_halinit.c      | 3 +--
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 6e26359bdda7..cd82452238e0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -724,8 +724,8 @@ static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 	/* s2. RF dependent command - CmdID_RF_WriteReg, param1=RF_CHNLBW, param2=channel */
 	param1 = RF_CHNLBW;
 	param2 = channel;
-	pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffffc00) | param2);
-	rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+	pHalData->RfRegChnlVal = ((pHalData->RfRegChnlVal & 0xfffffc00) | param2);
+	rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal);
 }
 
 void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index ea847ec39e13..2d5d04b384d1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -50,12 +50,12 @@ void rtl8188e_PHY_RF6052SetBandwidth(struct adapter *Adapter,
 
 	switch (Bandwidth) {
 	case HT_CHANNEL_WIDTH_20:
-		pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffff3ff) | BIT(10) | BIT(11));
-		rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+		pHalData->RfRegChnlVal = ((pHalData->RfRegChnlVal & 0xfffff3ff) | BIT(10) | BIT(11));
+		rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal);
 		break;
 	case HT_CHANNEL_WIDTH_40:
-		pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffff3ff) | BIT(10));
-		rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+		pHalData->RfRegChnlVal = ((pHalData->RfRegChnlVal & 0xfffff3ff) | BIT(10));
+		rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal);
 		break;
 	default:
 		break;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index f21b910bd88d..e8bc4a115a2b 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -668,8 +668,7 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write16(Adapter, REG_PKT_BE_BK_LIFE_TIME, 0x0400);	/*  unit: 256us. 256ms */
 
 	/* Keep RfRegChnlVal for later use. */
-	haldata->RfRegChnlVal[0] = rtl8188e_PHY_QueryRFReg(Adapter, (enum rf_radio_path)0, RF_CHNLBW, bRFRegOffsetMask);
-	haldata->RfRegChnlVal[1] = rtl8188e_PHY_QueryRFReg(Adapter, (enum rf_radio_path)1, RF_CHNLBW, bRFRegOffsetMask);
+	haldata->RfRegChnlVal = rtl8188e_PHY_QueryRFReg(Adapter, (enum rf_radio_path)0, RF_CHNLBW, bRFRegOffsetMask);
 
 	_BBTurnOnBlock(Adapter);
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index c323476f5936..c6472d13e069 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -143,7 +143,7 @@ struct hal_data_8188e {
 
 	struct bb_reg_def PHYRegDef[2];	/* Radio A/B */
 
-	u32	RfRegChnlVal[2];
+	u32	RfRegChnlVal;
 
 	/* for host message to fw */
 	u8	LastHMEBoxNum;
-- 
2.30.2

