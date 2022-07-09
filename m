Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27FE56CAD2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiGIRKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGIRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:19 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E159412093
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:17 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADyA-0005n0-2L; Sat, 09 Jul 2022 19:10:14 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 02/14] staging: r8188eu: remove EepromOrEfuse from struct eeprom_priv
Date:   Sat,  9 Jul 2022 19:09:48 +0200
Message-Id: <20220709171000.180481-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220709171000.180481-1-martin@kaiser.cx>
References: <20220709171000.180481-1-martin@kaiser.cx>
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

The EepromOrEfuse flag in struct eeprom_priv is used only in the
ReadAdapterInfo8188EU function. We can remove EepromOrEfuse from struct
eeprom_priv.

As the meaning of EepromOrEfuse isn't obvious, there is a macro
is_boot_from_eeprom that's used for checking the value. We don't need the
macro, writing the check as !(eeValue & BOOT_FROM_EEPROM) makes it clear
what is checked.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c    | 3 +--
 drivers/staging/r8188eu/include/hal_intf.h   | 2 --
 drivers/staging/r8188eu/include/rtw_eeprom.h | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 1a08de85a6ae..2bfd9751c685 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -937,10 +937,9 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 	if (res)
 		return;
 
-	eeprom->EepromOrEfuse		= (eeValue & BOOT_FROM_EEPROM);
 	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
 
-	if (!is_boot_from_eeprom(Adapter))
+	if (!(eeValue & BOOT_FROM_EEPROM))
 		EFUSE_ShadowMapUpdate(Adapter);
 
 	/* parse the eeprom/efuse content */
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index b81144932d9a..fc972d65189f 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -21,8 +21,6 @@ enum hw_variables {
 
 typedef s32 (*c2h_id_filter)(u8 id);
 
-#define is_boot_from_eeprom(adapter) (adapter->eeprompriv.EepromOrEfuse)
-
 void rtl8188eu_interface_configure(struct adapter *adapt);
 void ReadAdapterInfo8188EU(struct adapter *Adapter);
 void rtl8188eu_init_default_value(struct adapter *adapt);
diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
index d8d48ace356c..40c61f7a03be 100644
--- a/drivers/staging/r8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -12,7 +12,6 @@
 struct eeprom_priv {
 	u8		bautoload_fail_flag;
 	u8		mac_addr[ETH_ALEN] __aligned(2); /* PermanentAddress */
-	u8		EepromOrEfuse;
 	u8		efuse_eeprom_data[HWSET_MAX_SIZE_512] __aligned(4);
 };
 
-- 
2.30.2

