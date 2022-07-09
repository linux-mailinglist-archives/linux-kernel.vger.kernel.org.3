Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B109A56CACA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiGIRKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGIRK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:27 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F89120BF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:25 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADyC-0005n0-Im; Sat, 09 Jul 2022 19:10:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/14] staging: r8188eu: use a local buffer for efuse data
Date:   Sat,  9 Jul 2022 19:09:51 +0200
Message-Id: <20220709171000.180481-6-martin@kaiser.cx>
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

The efuse_eeprom_data array in struct eeprom_priv is used only by
ReadAdapterInfo8188EU. We can remove efuse_eeprom_data and use a local
buffer instead.

Use EFUSE_MAP_LEN_88E as buffer size. Its value is the same as
HWSET_MAX_SIZE_512. The functions that access the buffer use
EFUSE_MAP_LEN_88E for its size.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c    | 23 ++++++++++----------
 drivers/staging/r8188eu/include/rtw_eeprom.h |  3 ---
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 18c2817bf1e3..807d8ce8cbfc 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -929,6 +929,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 {
 	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
 	struct led_priv *ledpriv = &Adapter->ledpriv;
+	u8 efuse_buf[EFUSE_MAP_LEN_88E] __aligned(4);
 	u8 eeValue;
 	int res;
 
@@ -941,24 +942,24 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 
 	if (!(eeValue & BOOT_FROM_EEPROM)) {
 		if (eeprom->bautoload_fail_flag) {
-			memset(eeprom->efuse_eeprom_data, 0xFF, EFUSE_MAP_LEN_88E);
+			memset(efuse_buf, 0xFF, sizeof(efuse_buf));
 		} else {
 			rtl8188e_EfusePowerSwitch(Adapter, true);
-			rtl8188e_ReadEFuse(Adapter, 0, EFUSE_MAP_LEN_88E, eeprom->efuse_eeprom_data);
+			rtl8188e_ReadEFuse(Adapter, 0, EFUSE_MAP_LEN_88E, efuse_buf);
 			rtl8188e_EfusePowerSwitch(Adapter, false);
 		}
 	}
 
 	/* parse the eeprom/efuse content */
-	Hal_EfuseParseIDCode88E(Adapter, eeprom->efuse_eeprom_data);
-	Hal_EfuseParseMACAddr_8188EU(Adapter, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
-
-	Hal_ReadPowerSavingMode88E(Adapter, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
-	Hal_ReadTxPowerInfo88E(Adapter, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
-	rtl8188e_EfuseParseChnlPlan(Adapter, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
-	Hal_EfuseParseXtal_8188E(Adapter, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
-	Hal_ReadAntennaDiversity88E(Adapter, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
-	Hal_ReadThermalMeter_88E(Adapter, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	Hal_EfuseParseIDCode88E(Adapter, efuse_buf);
+	Hal_EfuseParseMACAddr_8188EU(Adapter, efuse_buf, eeprom->bautoload_fail_flag);
+
+	Hal_ReadPowerSavingMode88E(Adapter, efuse_buf, eeprom->bautoload_fail_flag);
+	Hal_ReadTxPowerInfo88E(Adapter, efuse_buf, eeprom->bautoload_fail_flag);
+	rtl8188e_EfuseParseChnlPlan(Adapter, efuse_buf, eeprom->bautoload_fail_flag);
+	Hal_EfuseParseXtal_8188E(Adapter, efuse_buf, eeprom->bautoload_fail_flag);
+	Hal_ReadAntennaDiversity88E(Adapter, efuse_buf, eeprom->bautoload_fail_flag);
+	Hal_ReadThermalMeter_88E(Adapter, efuse_buf, eeprom->bautoload_fail_flag);
 
 	ledpriv->bRegUseLed = true;
 }
diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
index 0a8792428927..94d735b1d0db 100644
--- a/drivers/staging/r8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -7,12 +7,9 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define	HWSET_MAX_SIZE_512		512
-
 struct eeprom_priv {
 	u8		bautoload_fail_flag;
 	u8		mac_addr[ETH_ALEN] __aligned(2); /* PermanentAddress */
-	u8		efuse_eeprom_data[HWSET_MAX_SIZE_512] __aligned(4);
 };
 
 #endif  /* __RTL871X_EEPROM_H__ */
-- 
2.30.2

