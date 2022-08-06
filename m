Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C858B807
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiHFT4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiHFT4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:56:02 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A6165F8
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:56:01 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPtq-0004Tu-QA; Sat, 06 Aug 2022 21:55:54 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/13] staging: r8188eu: remove OutEpNumber
Date:   Sat,  6 Aug 2022 21:55:33 +0200
Message-Id: <20220806195540.777390-7-martin@kaiser.cx>
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

Remove the OutEpNumber component of struct hal_data_8188e.
RtNumOutPipes in struct dvobj_priv stores the same info.

Update the only place where OutEpNumber is read.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 7 ++-----
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 603108a5d794..664028c14141 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -110,17 +110,14 @@ int rtl8188eu_interface_configure(struct adapter *adapt)
 	switch (pdvobjpriv->RtNumOutPipes) {
 	case 3:
 		haldata->OutEpQueueSel = TX_SELE_HQ | TX_SELE_LQ | TX_SELE_NQ;
-		haldata->OutEpNumber = 3;
 		three_out_pipe(adapt, wifi_cfg);
 		break;
 	case 2:
 		haldata->OutEpQueueSel = TX_SELE_HQ | TX_SELE_NQ;
-		haldata->OutEpNumber = 2;
 		two_out_pipe(adapt, wifi_cfg);
 		break;
 	case 1:
 		haldata->OutEpQueueSel = TX_SELE_HQ;
-		haldata->OutEpNumber = 1;
 		one_out_pipe(adapt);
 		break;
 	default:
@@ -358,9 +355,9 @@ static void _InitNormalChipThreeOutEpPriority(struct adapter *Adapter)
 
 static void _InitQueuePriority(struct adapter *Adapter)
 {
-	struct hal_data_8188e *haldata = &Adapter->haldata;
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(Adapter);
 
-	switch (haldata->OutEpNumber) {
+	switch (pdvobjpriv->RtNumOutPipes) {
 	case 1:
 		_InitNormalChipOneOutEpPriority(Adapter);
 		break;
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index fdc187f4deaa..ff0a4ce19dde 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -150,7 +150,6 @@ struct hal_data_8188e {
 	u8	TRxAntDivType;
 
 	u8	OutEpQueueSel;
-	u8	OutEpNumber;
 
 	struct P2P_PS_Offload_t	p2p_ps_offload;
 
-- 
2.30.2

