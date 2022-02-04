Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6E4A95C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357321AbiBDJKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348476AbiBDJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:10:04 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B44BC061748
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:10:04 -0800 (PST)
Received: from dslb-188-096-149-005.188.096.pools.vodafone-ip.de ([188.96.149.5] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nFubQ-0002IT-EM; Fri, 04 Feb 2022 10:10:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 4/4] staging: r8188eu: remove constant variable eRFPath
Date:   Fri,  4 Feb 2022 10:09:41 +0100
Message-Id: <20220204090941.309900-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204090941.309900-1-martin@kaiser.cx>
References: <20220203203217.252156-1-martin@kaiser.cx>
 <20220204090941.309900-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the _PHY_SwChnl8192C function, eRFPath is always zero. Remove the
variable and use 0 in the code. Replace (enum rf_radio_path)0 with
RF_PATH_A.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2: no changes

 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 8279768201b7..6e26359bdda7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -712,7 +712,6 @@ void PHY_SetBWMode8188E(struct adapter *Adapter, enum ht_channel_width Bandwidth
 
 static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 {
-	u8 eRFPath = 0;
 	u32 param1, param2;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
@@ -725,8 +724,8 @@ static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 	/* s2. RF dependent command - CmdID_RF_WriteReg, param1=RF_CHNLBW, param2=channel */
 	param1 = RF_CHNLBW;
 	param2 = channel;
-	pHalData->RfRegChnlVal[eRFPath] = ((pHalData->RfRegChnlVal[eRFPath] & 0xfffffc00) | param2);
-	rtl8188e_PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal[eRFPath]);
+	pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffffc00) | param2);
+	rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
 }
 
 void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
-- 
2.30.2

