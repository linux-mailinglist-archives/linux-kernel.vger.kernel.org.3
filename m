Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70841585ACF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiG3OkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 10:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiG3Oj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 10:39:59 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11D617AA2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 07:39:56 -0700 (PDT)
Received: from dslb-188-104-059-172.188.104.pools.vodafone-ip.de ([188.104.59.172] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oHnd9-0004pM-KF; Sat, 30 Jul 2022 16:39:51 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] staging: r8188eu: handle errors from ReadAdapterInfo8188EU
Date:   Sat, 30 Jul 2022 16:39:37 +0200
Message-Id: <20220730143939.671951-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220730143939.671951-1-martin@kaiser.cx>
References: <20220730143939.671951-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ReadAdapterInfo8188EU to return 0 for success or a negative
error code. If rtw_read8 fails, we can just relay the error it returns.

Update rtw_usb_if1_init to check the return value from
ReadAdapterInfo8188EU. For now, rtw_usb_if1_init does not yet pass errors
from ReadAdapterInfo8188EU on to its caller.

Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 7 ++++---
 drivers/staging/r8188eu/include/hal_intf.h | 2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c  | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index ff074d246dab..efb529bb4c8a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -922,7 +922,7 @@ static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool
 	}
 }
 
-void ReadAdapterInfo8188EU(struct adapter *Adapter)
+int ReadAdapterInfo8188EU(struct adapter *Adapter)
 {
 	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
 	struct led_priv *ledpriv = &Adapter->ledpriv;
@@ -933,13 +933,13 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 	/* check system boot selection */
 	res = rtw_read8(Adapter, REG_9346CR, &eeValue);
 	if (res)
-		return;
+		return res;
 
 	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
 
 	efuse_buf = kmalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
 	if (!efuse_buf)
-		return;
+		return -ENOMEM;
 	memset(efuse_buf, 0xFF, EFUSE_MAP_LEN_88E);
 
 	if (!(eeValue & BOOT_FROM_EEPROM) && !eeprom->bautoload_fail_flag) {
@@ -961,6 +961,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 
 	ledpriv->bRegUseLed = true;
 	kfree(efuse_buf);
+	return 0;
 }
 
 void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index ab6856d8a090..3ed5b7e031cd 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -11,7 +11,7 @@
 typedef s32 (*c2h_id_filter)(u8 id);
 
 void rtl8188eu_interface_configure(struct adapter *adapt);
-void ReadAdapterInfo8188EU(struct adapter *Adapter);
+int ReadAdapterInfo8188EU(struct adapter *Adapter);
 void rtl8188eu_init_default_value(struct adapter *adapt);
 void rtl8188e_SetHalODMVar(struct adapter *Adapter, void *pValue1, bool bSet);
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index cc2b44f60c46..e1a0447fd1e7 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -332,7 +332,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	rtl8188eu_interface_configure(padapter);
 
 	/* step read efuse/eeprom data and get mac_addr */
-	ReadAdapterInfo8188EU(padapter);
+	if (ReadAdapterInfo8188EU(padapter) < 0)
+		goto handle_dualmac;
 
 	/* step 5. */
 	if (rtw_init_drv_sw(padapter) == _FAIL)
-- 
2.30.2

