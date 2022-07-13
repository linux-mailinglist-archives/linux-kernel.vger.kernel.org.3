Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B40572FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiGMH6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiGMH6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:58:38 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C226965F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:58:36 -0700 (PDT)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oBXGR-0000L8-TX; Wed, 13 Jul 2022 09:58:31 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: r888eu: use dynamic allocation for efuse buffer
Date:   Wed, 13 Jul 2022 09:58:04 +0200
Message-Id: <20220713075804.140986-1-martin@kaiser.cx>
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

Use kmalloc to allocate the efuse buffer in ReadAdapterInfo8188EU and
free it on exit. This is better than using a 512 byte array on the stack.

It's ok to drop the __aligned(4) qualifier. kmalloc aligns to
ARCH_KMALLOC_MINALIGN, this is at least 8 bytes.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 8902dda7b8d8..421fe7c40390 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -926,7 +926,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 {
 	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
 	struct led_priv *ledpriv = &Adapter->ledpriv;
-	u8 efuse_buf[EFUSE_MAP_LEN_88E] __aligned(4);
+	u8 *efuse_buf;
 	u8 eeValue;
 	int res;
 
@@ -937,7 +937,10 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 
 	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
 
-	memset(efuse_buf, 0xFF, sizeof(efuse_buf));
+	efuse_buf = kmalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
+	if (!efuse_buf)
+		return;
+	memset(efuse_buf, 0xFF, EFUSE_MAP_LEN_88E);
 
 	if (!(eeValue & BOOT_FROM_EEPROM) && !eeprom->bautoload_fail_flag) {
 		rtl8188e_EfusePowerSwitch(Adapter, true);
@@ -957,6 +960,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 	Hal_ReadThermalMeter_88E(Adapter, efuse_buf, eeprom->bautoload_fail_flag);
 
 	ledpriv->bRegUseLed = true;
+	kfree(efuse_buf);
 }
 
 static void ResumeTxBeacon(struct adapter *adapt)
-- 
2.30.2

