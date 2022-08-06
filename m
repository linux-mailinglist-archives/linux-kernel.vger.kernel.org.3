Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3407E58B804
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiHFTz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiHFTz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:55:57 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32B6410
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:55:55 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPtm-0004Tu-9y; Sat, 06 Aug 2022 21:55:50 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/13] staging: r8188eu: Hal_MappingOutPipe should return an int
Date:   Sat,  6 Aug 2022 21:55:28 +0200
Message-Id: <20220806195540.777390-2-martin@kaiser.cx>
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

Update the Hal_MappingOutPipe function to return 0 for success or -EXNIO
if the caller requested more than the number of available endpoints.
This error code is also used by usb_find_common_endpoints if a requested
endpoint was not found.

Unlike a boolean return value, a negative error code can be returned to
external functions that call the r8188eu driver, e.g. to the caller of our
probe function.

HalUsbSetQueuePipeMapping8188EUsb passes the return value of
Hal_MappingOutPipe on to its caller. We have to change its return type
from bool to int as well.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/hal_com.c     | 8 +++-----
 drivers/staging/r8188eu/hal/usb_halinit.c | 2 +-
 drivers/staging/r8188eu/include/hal_com.h | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index 6a1cdc67335b..d24e0e5924eb 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -225,11 +225,10 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 	}
 }
 
-bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
+int Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
 {
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
 	bool wifi_cfg = pregistrypriv->wifi_spec;
-	bool result = true;
 
 	switch (numoutpipe) {
 	case 2:
@@ -242,10 +241,9 @@ bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
 		one_out_pipe(adapter);
 		break;
 	default:
-		result = false;
-		break;
+		return -ENXIO;
 	}
-	return result;
+	return 0;
 }
 
 /*
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 8b36fb56076e..ba068e6fd9fb 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -35,7 +35,7 @@ static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
 	}
 }
 
-static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumOutPipe)
+static int HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumOutPipe)
 {
 
 	_ConfigNormalChipOutEP_8188E(adapt, NumOutPipe);
diff --git a/drivers/staging/r8188eu/include/hal_com.h b/drivers/staging/r8188eu/include/hal_com.h
index d7e333f6ce39..3dfb61e64ee0 100644
--- a/drivers/staging/r8188eu/include/hal_com.h
+++ b/drivers/staging/r8188eu/include/hal_com.h
@@ -143,7 +143,7 @@ u8 MRateToHwRate(u8 rate);
 
 void HalSetBrateCfg(struct adapter *Adapter, u8 *mBratesOS, u16 *pBrateCfg);
 
-bool Hal_MappingOutPipe(struct adapter *pAdapter, u8 NumOutPipe);
+int Hal_MappingOutPipe(struct adapter *pAdapter, u8 NumOutPipe);
 
 s32 c2h_evt_read(struct adapter *adapter, u8 *buf);
 
-- 
2.30.2

