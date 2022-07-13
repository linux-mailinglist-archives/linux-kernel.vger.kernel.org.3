Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E64572FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiGMH4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiGMH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:56:12 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFC2DA590
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:56:11 -0700 (PDT)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oBXE4-0000JP-RV; Wed, 13 Jul 2022 09:56:04 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>, Joe Perches <joe@perches.com>
Subject: [PATCH] staging: r8188eu: fall back to random mac address
Date:   Wed, 13 Jul 2022 09:55:52 +0200
Message-Id: <20220713075552.140927-1-martin@kaiser.cx>
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

Call eth_random_addr to generate a random mac address if we cannot load
the mac address from the efuses.

Do not use a constant mac address as fallback. This may create conflicts
if we have several r8188eu devices on the network.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 68d012a442a8..8902dda7b8d8 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -912,11 +912,10 @@ unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 
 static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool AutoLoadFail)
 {
-	u8 sMacAddr[6] = {0x00, 0xE0, 0x4C, 0x81, 0x88, 0x02};
 	struct eeprom_priv *eeprom = &adapt->eeprompriv;
 
 	if (AutoLoadFail) {
-		memcpy(eeprom->mac_addr, sMacAddr, ETH_ALEN);
+		eth_random_addr(eeprom->mac_addr);
 	} else {
 		/* Read Permanent MAC address */
 		memcpy(eeprom->mac_addr, &hwinfo[EEPROM_MAC_ADDR_88EU], ETH_ALEN);
-- 
2.30.2

