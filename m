Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EDD58B80B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiHFT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiHFTz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:55:57 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF96437
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:55:56 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPtn-0004Tu-6C; Sat, 06 Aug 2022 21:55:51 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 02/13] staging: r8188eu: process HalUsbSetQueuePipeMapping8188EUsb's return value
Date:   Sat,  6 Aug 2022 21:55:29 +0200
Message-Id: <20220806195540.777390-3-martin@kaiser.cx>
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

At the moment, HalUsbSetQueuePipeMapping8188EUsb returns an error status
to rtl8188eu_interface_configure, where this status is discarded.

Pass the error status from rtl8188eu_interface_configure to
rtw_usb_if1_init and handle it there.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 4 ++--
 drivers/staging/r8188eu/include/hal_intf.h | 2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c  | 4 +++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index ba068e6fd9fb..839841f90d29 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -42,11 +42,11 @@ static int HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumOutPip
 	return Hal_MappingOutPipe(adapt, NumOutPipe);
 }
 
-void rtl8188eu_interface_configure(struct adapter *adapt)
+int rtl8188eu_interface_configure(struct adapter *adapt)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapt);
 
-	HalUsbSetQueuePipeMapping8188EUsb(adapt, pdvobjpriv->RtNumOutPipes);
+	return HalUsbSetQueuePipeMapping8188EUsb(adapt, pdvobjpriv->RtNumOutPipes);
 }
 
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 3ed5b7e031cd..fd8e792958ce 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -10,7 +10,7 @@
 
 typedef s32 (*c2h_id_filter)(u8 id);
 
-void rtl8188eu_interface_configure(struct adapter *adapt);
+int rtl8188eu_interface_configure(struct adapter *adapt);
 int ReadAdapterInfo8188EU(struct adapter *Adapter);
 void rtl8188eu_init_default_value(struct adapter *adapt);
 void rtl8188e_SetHalODMVar(struct adapter *Adapter, void *pValue1, bool bSet);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index db91f72dd40f..2b330104a55d 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -330,7 +330,9 @@ static int rtw_usb_if1_init(struct dvobj_priv *dvobj, struct usb_interface *pusb
 	rtl8188e_read_chip_version(padapter);
 
 	/* step usb endpoint mapping */
-	rtl8188eu_interface_configure(padapter);
+	ret = rtl8188eu_interface_configure(padapter);
+	if (ret)
+		goto handle_dualmac;
 
 	/* step read efuse/eeprom data and get mac_addr */
 	ret = ReadAdapterInfo8188EU(padapter);
-- 
2.30.2

