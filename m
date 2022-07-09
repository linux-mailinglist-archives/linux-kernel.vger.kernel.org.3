Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD056CAC9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGIRK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGIRKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:21 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C83F11C06
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:20 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADyB-0005n0-Ow; Sat, 09 Jul 2022 19:10:15 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/14] staging: r8188eu: merge EFUSE_ShadowMapUpdate with its caller
Date:   Sat,  9 Jul 2022 19:09:50 +0200
Message-Id: <20220709171000.180481-5-martin@kaiser.cx>
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

Merge the EFUSE_ShadowMapUpdate function into ReadAdapterInfo8188EU, which
is the only caller.

Merging the two functions makes it clearer that eeprom->efuse_eeprom_data
is in fact a temporary buffer that stores info read from efuses.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 30 ---------------------
 drivers/staging/r8188eu/hal/usb_halinit.c   | 11 ++++++--
 drivers/staging/r8188eu/include/rtw_efuse.h |  2 --
 3 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 8005ed8d3a20..df9534dd25cb 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -72,33 +72,3 @@ ReadEFuseByte(
 
 	/* FIXME: return an error to caller */
 }
-
-/*-----------------------------------------------------------------------------
- * Function:	EFUSE_ShadowMapUpdate
- *
- * Overview:	Transfer current EFUSE content to shadow init and modify map.
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 11/13/2008	MHC		Create Version 0.
- *
- *---------------------------------------------------------------------------*/
-void EFUSE_ShadowMapUpdate(struct adapter *pAdapter)
-{
-	struct eeprom_priv *pEEPROM = &pAdapter->eeprompriv;
-
-	if (pEEPROM->bautoload_fail_flag) {
-		memset(pEEPROM->efuse_eeprom_data, 0xFF, EFUSE_MAP_LEN_88E);
-		return;
-	}
-
-	rtl8188e_EfusePowerSwitch(pAdapter, true);
-	rtl8188e_ReadEFuse(pAdapter, 0, EFUSE_MAP_LEN_88E, pEEPROM->efuse_eeprom_data);
-	rtl8188e_EfusePowerSwitch(pAdapter, false);
-}
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 2bfd9751c685..18c2817bf1e3 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -939,8 +939,15 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 
 	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
 
-	if (!(eeValue & BOOT_FROM_EEPROM))
-		EFUSE_ShadowMapUpdate(Adapter);
+	if (!(eeValue & BOOT_FROM_EEPROM)) {
+		if (eeprom->bautoload_fail_flag) {
+			memset(eeprom->efuse_eeprom_data, 0xFF, EFUSE_MAP_LEN_88E);
+		} else {
+			rtl8188e_EfusePowerSwitch(Adapter, true);
+			rtl8188e_ReadEFuse(Adapter, 0, EFUSE_MAP_LEN_88E, eeprom->efuse_eeprom_data);
+			rtl8188e_EfusePowerSwitch(Adapter, false);
+		}
+	}
 
 	/* parse the eeprom/efuse content */
 	Hal_EfuseParseIDCode88E(Adapter, eeprom->efuse_eeprom_data);
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 2daf69f554d5..3d688a0e6dfb 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -8,6 +8,4 @@
 
 void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf);
 
-void EFUSE_ShadowMapUpdate(struct adapter *adapter);
-
 #endif
-- 
2.30.2

