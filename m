Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E012F58B7FE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiHFTng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiHFTne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:43:34 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15073892
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:43:32 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPhj-0004Ne-Tu; Sat, 06 Aug 2022 21:43:23 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: txpktbuf_bndy does not depend on wifi_spec
Date:   Sat,  6 Aug 2022 21:43:04 +0200
Message-Id: <20220806194304.777059-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
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

Remove the if clause that sets txpktbuf_bndy. Both branches set the same
value.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 12 ++----------
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  6 ------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index efb529bb4c8a..8b36fb56076e 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -567,7 +567,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 {
 	u8 value8 = 0;
 	u16  value16;
-	u8 txpktbuf_bndy;
 	u32 status = _SUCCESS;
 	int res;
 	struct hal_data_8188e *haldata = &Adapter->haldata;
@@ -600,13 +599,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/*  HW GPIO pin. Before PHY_RFConfig8192C. */
 	/*  2010/08/26 MH If Efuse does not support sective suspend then disable the function. */
 
-	if (!pregistrypriv->wifi_spec) {
-		txpktbuf_bndy = TX_PAGE_BOUNDARY_88E;
-	} else {
-		/*  for WMM */
-		txpktbuf_bndy = WMM_NORMAL_TX_PAGE_BOUNDARY_88E;
-	}
-
 	_InitQueueReservedPage(Adapter);
 	_InitQueuePriority(Adapter);
 	_InitPageBoundary(Adapter);
@@ -647,9 +639,9 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	if (status == _FAIL)
 		goto exit;
 
-	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
+	_InitTxBufferBoundary(Adapter, TX_PAGE_BOUNDARY_88E);
 
-	status =  InitLLTTable(Adapter, txpktbuf_bndy);
+	status =  InitLLTTable(Adapter, TX_PAGE_BOUNDARY_88E);
 	if (status == _FAIL)
 		goto exit;
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 5cd62b216720..fdc187f4deaa 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -51,12 +51,6 @@
 
 #define TX_PAGE_BOUNDARY_88E (TX_TOTAL_PAGE_NUMBER_88E + 1)
 
-/* Note: For Normal Chip Setting ,modify later */
-#define WMM_NORMAL_TX_TOTAL_PAGE_NUMBER			\
-	TX_TOTAL_PAGE_NUMBER_88E  /* 0xA9 , 0xb0=>176=>22k */
-#define WMM_NORMAL_TX_PAGE_BOUNDARY_88E			\
-	(WMM_NORMAL_TX_TOTAL_PAGE_NUMBER + 1) /* 0xA9 */
-
 #include "HalVerDef.h"
 #include "hal_com.h"
 
-- 
2.30.2

