Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B0556CAD1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiGIRKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiGIRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:22 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A2120BA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:21 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADyE-0005n0-5a; Sat, 09 Jul 2022 19:10:18 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/14] staging: r8188eu: use memcpy for fallback mac address
Date:   Sat,  9 Jul 2022 19:09:53 +0200
Message-Id: <20220709171000.180481-8-martin@kaiser.cx>
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

Use memcpy to store the fallback mac address in eeprom->mac_addr. Do not
copy byte by byte.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 258ab963cf8a..5151cded145b 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -912,13 +912,11 @@ unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 
 static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool AutoLoadFail)
 {
-	u16 i;
 	u8 sMacAddr[6] = {0x00, 0xE0, 0x4C, 0x81, 0x88, 0x02};
 	struct eeprom_priv *eeprom = &adapt->eeprompriv;
 
 	if (AutoLoadFail) {
-		for (i = 0; i < 6; i++)
-			eeprom->mac_addr[i] = sMacAddr[i];
+		memcpy(eeprom->mac_addr, sMacAddr, ETH_ALEN);
 	} else {
 		/* Read Permanent MAC address */
 		memcpy(eeprom->mac_addr, &hwinfo[EEPROM_MAC_ADDR_88EU], ETH_ALEN);
-- 
2.30.2

