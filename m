Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC05A622A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiH3Lim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiH3LiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:38:07 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1711636D6;
        Tue, 30 Aug 2022 04:36:35 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id A7F8140012;
        Tue, 30 Aug 2022 11:36:19 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [v2 3/5] HID: logitech-hidpp: Remove special-casing of Bluetooth devices
Date:   Tue, 30 Aug 2022 13:36:13 +0200
Message-Id: <20220830113615.4414-3-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830113615.4414-1-hadess@hadess.net>
References: <20220830113615.4414-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the Logitech Bluetooth devices are probed for HID++
support, remove the handling of those 2 devices without any quirks, as
they're duplicates.
---
 drivers/hid/hid-logitech-hidpp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 641c897bf714..98ebedb73d98 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4350,13 +4350,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX5500 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
 	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
-	{ /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
-	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
 	{ /* MX Master mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
 	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ /* MX Ergo trackball over Bluetooth */
-	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01d) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
 	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
 	{ /* MX Master 3 mouse over Bluetooth */
-- 
2.37.2

