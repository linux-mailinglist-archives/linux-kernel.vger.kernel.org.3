Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8514B3655
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiBLQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:18:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiBLQRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:17:55 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122BE197
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:17:51 -0800 (PST)
Received: from dslb-188-097-215-215.188.097.pools.vodafone-ip.de ([188.97.215.215] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nIv5o-0007YM-5i; Sat, 12 Feb 2022 17:17:48 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/10] staging: r8188eu: remove path parameter from phy_RFSerialWrite
Date:   Sat, 12 Feb 2022 17:17:31 +0100
Message-Id: <20220212161737.381841-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220212161737.381841-1-martin@kaiser.cx>
References: <20220212161737.381841-1-martin@kaiser.cx>
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

The only caller of phy_RFSerialWrite sets the eRFPath parameter
to RF_PATH_A. Remove the parameter and use RF_PATH_A directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 628cec40db5f..9e02855c47b2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -217,14 +217,13 @@ phy_RFSerialRead(
 static	void
 phy_RFSerialWrite(
 		struct adapter *Adapter,
-		enum rf_radio_path eRFPath,
 		u32 Offset,
 		u32 Data
 	)
 {
 	u32 DataAndAddr = 0;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
-	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef[eRFPath];
+	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef[RF_PATH_A];
 	u32 NewOffset;
 
 	/*  2009/06/17 MH We can not execute IO for power save or other accident mode. */
@@ -309,7 +308,7 @@ rtl8188e_PHY_SetRFReg(
 		Data = ((Original_Value & (~BitMask)) | (Data << BitShift));
 	}
 
-	phy_RFSerialWrite(Adapter, RF_PATH_A, RegAddr, Data);
+	phy_RFSerialWrite(Adapter, RegAddr, Data);
 }
 
 /*  */
-- 
2.30.2

