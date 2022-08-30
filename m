Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87605A64A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiH3N0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiH3NZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:25:56 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DAB6B175;
        Tue, 30 Aug 2022 06:25:54 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 0251B2000E;
        Tue, 30 Aug 2022 13:25:51 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [v4 2/5] HID: logitech-hidpp: Enable HID++ for all the Logitech Bluetooth devices
Date:   Tue, 30 Aug 2022 15:25:46 +0200
Message-Id: <20220830132549.7240-2-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830132549.7240-1-hadess@hadess.net>
References: <20220830132549.7240-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe for HID++ support over Bluetooth for all the Logitech Bluetooth
devices. As Logitech doesn't have a list of Bluetooth devices that
support HID++ over Bluetooth, probe every device. The HID++ driver
will fall back to plain HID if the device does not support HID++,
or to a another device-specific driver if it is part of the
unhandled_hidpp_devices array, used in the match function.

Note that this change might cause upower to export 2 batteries for
certain Bluetooth LE devices which export their battery information
through the Bluetooth BATT profile. This particular bug is tracked at:
https://gitlab.freedesktop.org/upower/upower/-/issues/166

Tested with a Logitech Signature M650 mouse, over Bluetooth

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 68f9e9d207f4..641c897bf714 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4219,6 +4219,21 @@ static void hidpp_remove(struct hid_device *hdev)
 	mutex_destroy(&hidpp->send_mutex);
 }
 
+static const struct hid_device_id unhandled_hidpp_devices[] = {
+	/* Logitech Harmony Adapter for PS3, handled in hid-sony */
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
+	/* Handled in hid-generic */
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD) },
+	{}
+};
+
+static bool hidpp_match(struct hid_device *hdev,
+			bool ignore_special_driver)
+{
+	/* Refuse to handle devices handled by other HID drivers */
+	return !hid_match_id(hdev, unhandled_hidpp_devices);
+}
+
 #define LDJ_DEVICE(product) \
 	HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE, \
 		   USB_VENDOR_ID_LOGITECH, (product))
@@ -4347,6 +4362,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX Master 3 mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023),
 	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+
+	{ /* And try to enable HID++ for all the Logitech Bluetooth devices */
+	  HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_ANY, USB_VENDOR_ID_LOGITECH, HID_ANY_ID) },
 	{}
 };
 
@@ -4360,6 +4378,7 @@ static const struct hid_usage_id hidpp_usages[] = {
 static struct hid_driver hidpp_driver = {
 	.name = "logitech-hidpp-device",
 	.id_table = hidpp_devices,
+	.match = hidpp_match,
 	.report_fixup = hidpp_report_fixup,
 	.probe = hidpp_probe,
 	.remove = hidpp_remove,
-- 
2.37.2

