Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB72B4883A3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiAHMuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiAHMuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:50:25 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF4C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:50:24 -0800 (PST)
Received: from dslb-188-097-214-229.188.097.pools.vodafone-ip.de ([188.97.214.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6BAr-0005EJ-3S; Sat, 08 Jan 2022 13:50:21 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 11/12] staging: r8188eu: remove HAL_*_ENABLE defines
Date:   Sat,  8 Jan 2022 13:49:58 +0100
Message-Id: <20220108124959.313215-12-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108124959.313215-1-martin@kaiser.cx>
References: <20220108124959.313215-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HAL_(MAC|BB|RF)_ENABLE are always set. Remove the defines and the
checks where they are used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 21cb505036b7..cc8f8c7d0734 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -13,10 +13,6 @@
 #include "../include/usb_osintf.h"
 #include "../include/Hal8188EPwrSeq.h"
 
-#define		HAL_MAC_ENABLE	1
-#define		HAL_BB_ENABLE		1
-#define		HAL_RF_ENABLE		1
-
 static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
 {
 	struct hal_data_8188e *haldata = &adapt->haldata;
@@ -640,32 +636,26 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	Adapter->pwrctrlpriv.bFwCurrentInPSMode = false;
 	haldata->LastHMEBoxNum = 0;
 
-#if (HAL_MAC_ENABLE == 1)
 	status = PHY_MACConfig8188E(Adapter);
 	if (status == _FAIL) {
 		DBG_88E(" ### Failed to init MAC ......\n ");
 		goto exit;
 	}
-#endif
 
 	/*  */
 	/* d. Initialize BB related configurations. */
 	/*  */
-#if (HAL_BB_ENABLE == 1)
 	status = PHY_BBConfig8188E(Adapter);
 	if (status == _FAIL) {
 		DBG_88E(" ### Failed to init BB ......\n ");
 		goto exit;
 	}
-#endif
 
-#if (HAL_RF_ENABLE == 1)
 	status = PHY_RFConfig8188E(Adapter);
 	if (status == _FAIL) {
 		DBG_88E(" ### Failed to init RF ......\n ");
 		goto exit;
 	}
-#endif
 
 	status = rtl8188e_iol_efuse_patch(Adapter);
 	if (status == _FAIL) {
-- 
2.30.2

