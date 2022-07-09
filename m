Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2512B56CACE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiGIRKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiGIRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:22 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9502211C06
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:21 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADyD-0005n0-Cb; Sat, 09 Jul 2022 19:10:17 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/14] staging: r8188eu: always initialise efuse buffer with 0xff
Date:   Sat,  9 Jul 2022 19:09:52 +0200
Message-Id: <20220709171000.180481-7-martin@kaiser.cx>
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

If BOOT_FROM_EEPROM is set, efuse_buf is not initialised before it is
passed to functions that read from it.

The buffer will be filled with 0x00 in this case like all local variables.
However, the parsing functions expect the buffer to be filled with 0xFF if
reading eeprom/efuse data failed. Fill the buffer with 0xFF before we try
to read the data.

Please note that this problem existed before we started using a local
buffer. Adapter->eeprompriv->efuse_eeprom_data was allocated as a part of
struct adapter by a vzalloc call in rtw_usb_if1_init.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 807d8ce8cbfc..258ab963cf8a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -940,14 +940,12 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 
 	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
 
-	if (!(eeValue & BOOT_FROM_EEPROM)) {
-		if (eeprom->bautoload_fail_flag) {
-			memset(efuse_buf, 0xFF, sizeof(efuse_buf));
-		} else {
-			rtl8188e_EfusePowerSwitch(Adapter, true);
-			rtl8188e_ReadEFuse(Adapter, 0, EFUSE_MAP_LEN_88E, efuse_buf);
-			rtl8188e_EfusePowerSwitch(Adapter, false);
-		}
+	memset(efuse_buf, 0xFF, sizeof(efuse_buf));
+
+	if (!(eeValue & BOOT_FROM_EEPROM) && !eeprom->bautoload_fail_flag) {
+		rtl8188e_EfusePowerSwitch(Adapter, true);
+		rtl8188e_ReadEFuse(Adapter, 0, EFUSE_MAP_LEN_88E, efuse_buf);
+		rtl8188e_EfusePowerSwitch(Adapter, false);
 	}
 
 	/* parse the eeprom/efuse content */
-- 
2.30.2

