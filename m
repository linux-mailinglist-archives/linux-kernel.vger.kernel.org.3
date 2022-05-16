Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B68528611
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbiEPNzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbiEPNyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:54:38 -0400
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C74377CE;
        Mon, 16 May 2022 06:54:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 8FCA846002A;
        Mon, 16 May 2022 16:49:01 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mtDHU4i6qgiO; Mon, 16 May 2022 16:48:59 +0300 (EEST)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 2605A46002B;
        Mon, 16 May 2022 16:48:57 +0300 (EEST)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] can: kvaser_usb: Mark Mini PCIe 2xHS as supporting error counters
Date:   Mon, 16 May 2022 16:47:40 +0300
Message-Id: <20220516134748.3724796-5-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 0bfd:0124 Kvaser Mini PCI Express 2xHS (FW 4.18.778) seems to support
TX/RX error counters in exactly the same way (via unsolicited cmd 106 on
bus errors and via cmd 20 when queried with cmd 19) as 0bfd:0017 Kvaser
Memorator Professional HS/HS (FW 2.0.50), but only the latter has
KVASER_USB_HAS_TXRX_ERRORS set to enable do_get_berr_counter().

Enable error counter retrieval for Kvaser Mini PCI Express 2xHS, too.

Fixes: 71873a9b38d1 ("can: kvaser_usb: Add support for more Kvaser Leaf v2 devices")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>

---

I'm not really sure what KVASER_USB_HAS_TXRX_ERRORS means, exactly,
w.r.t. device behavior, though, i.e. how does a device without it behave.


 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 47bff40c36b6..7388fdca9079 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -165,7 +165,8 @@ static const struct usb_device_id kvaser_usb_table[] = {
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_HS_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_LIGHT_2HS_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_2HS_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_2HS_PRODUCT_ID),
+		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_R_V2_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_R_V2_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID) },
-- 
2.34.1

