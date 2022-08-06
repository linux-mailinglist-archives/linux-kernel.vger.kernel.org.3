Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6822558B80D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiHFT4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiHFT4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:56:00 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7850A6437
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:55:59 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPtp-0004Tu-Rb; Sat, 06 Aug 2022 21:55:53 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/13] staging: r8188eu: summarize endpoint-related settings
Date:   Sat,  6 Aug 2022 21:55:32 +0200
Message-Id: <20220806195540.777390-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806195540.777390-1-martin@kaiser.cx>
References: <20220806195540.777390-1-martin@kaiser.cx>
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

rtl8188eu_interface_configure calls _ConfigNormalChipOutEP_8188E and
Hal_MappingOutPipe.

Both of these functions make some settings based on the number of
out endpoints on the 8188eu chip. We can merge both of them into
rtl8188eu_interface_configure and summarize the common code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 55 +++++++----------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 8be93c44c903..603108a5d794 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -13,28 +13,6 @@
 #include "../include/usb_osintf.h"
 #include "../include/HalPwrSeqCmd.h"
 
-static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
-{
-	struct hal_data_8188e *haldata = &adapt->haldata;
-
-	switch (NumOutPipe) {
-	case	3:
-		haldata->OutEpQueueSel = TX_SELE_HQ | TX_SELE_LQ | TX_SELE_NQ;
-		haldata->OutEpNumber = 3;
-		break;
-	case	2:
-		haldata->OutEpQueueSel = TX_SELE_HQ | TX_SELE_NQ;
-		haldata->OutEpNumber = 2;
-		break;
-	case	1:
-		haldata->OutEpQueueSel = TX_SELE_HQ;
-		haldata->OutEpNumber = 1;
-		break;
-	default:
-		break;
-	}
-}
-
 static void one_out_pipe(struct adapter *adapter)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
@@ -122,33 +100,34 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 	}
 }
 
-static int Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
+int rtl8188eu_interface_configure(struct adapter *adapt)
 {
-	struct registry_priv *pregistrypriv = &adapter->registrypriv;
+	struct registry_priv *pregistrypriv = &adapt->registrypriv;
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	bool wifi_cfg = pregistrypriv->wifi_spec;
 
-	switch (numoutpipe) {
-	case 2:
-		two_out_pipe(adapter, wifi_cfg);
-		break;
+	switch (pdvobjpriv->RtNumOutPipes) {
 	case 3:
-		three_out_pipe(adapter, wifi_cfg);
+		haldata->OutEpQueueSel = TX_SELE_HQ | TX_SELE_LQ | TX_SELE_NQ;
+		haldata->OutEpNumber = 3;
+		three_out_pipe(adapt, wifi_cfg);
+		break;
+	case 2:
+		haldata->OutEpQueueSel = TX_SELE_HQ | TX_SELE_NQ;
+		haldata->OutEpNumber = 2;
+		two_out_pipe(adapt, wifi_cfg);
 		break;
 	case 1:
-		one_out_pipe(adapter);
+		haldata->OutEpQueueSel = TX_SELE_HQ;
+		haldata->OutEpNumber = 1;
+		one_out_pipe(adapt);
 		break;
 	default:
 		return -ENXIO;
 	}
-	return 0;
-}
 
-int rtl8188eu_interface_configure(struct adapter *adapt)
-{
-	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapt);
-
-	_ConfigNormalChipOutEP_8188E(adapt, pdvobjpriv->RtNumOutPipes);
-	return Hal_MappingOutPipe(adapt, pdvobjpriv->RtNumOutPipes);
+	return 0;
 }
 
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
-- 
2.30.2

