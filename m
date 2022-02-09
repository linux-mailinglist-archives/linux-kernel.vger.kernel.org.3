Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3594AEA31
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiBIGR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:17:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243063AbiBIGLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:11:54 -0500
X-Greylist: delayed 1846 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 22:11:03 PST
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9FE00E16F;
        Tue,  8 Feb 2022 22:11:01 -0800 (PST)
Received: from relay12.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 4895AC439F;
        Wed,  9 Feb 2022 05:28:24 +0000 (UTC)
Received: (Authenticated sender: frank@zago.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C4DA0200002;
        Wed,  9 Feb 2022 05:28:19 +0000 (UTC)
From:   frank zago <frank@zago.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        frank zago <frank@zago.net>
Subject: [PATCH] HID: Add support for Mega World controller force feedback
Date:   Tue,  8 Feb 2022 23:28:07 -0600
Message-Id: <20220209052807.138007-1-frank@zago.net>
X-Mailer: git-send-email 2.32.0
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

This patch adds support for one of the several Mega World USB game
controller with integrated force feedback. It is a HID based
memory-less game controller, with a weak motor on the left, and a
strong one on the right.

Signed-off-by: frank zago <frank@zago.net>
---
 drivers/hid/Kconfig         |  14 ++++
 drivers/hid/Makefile        |   1 +
 drivers/hid/hid-ids.h       |   3 +
 drivers/hid/hid-megaworld.c | 136 ++++++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+)
 create mode 100644 drivers/hid/hid-megaworld.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f5544157576c..2344830d3680 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -684,6 +684,20 @@ config HID_MAYFLASH
 	Say Y here if you have HJZ Mayflash PS3 game controller adapters
 	and want to enable force feedback support.
 
+config HID_MEGAWORLD
+	tristate "Mega World based game controller support"
+	depends on HID
+	help
+	  Say Y here if you have a Mega World based game controller.
+
+config MEGAWORLD_FF
+	bool "Mega World based game controller force feedback support"
+	depends on HID_MEGAWORLD
+	select INPUT_FF_MEMLESS
+	help
+	  Say Y here if you have a Mega World based game controller and want
+	  to have force feedback support for it.
+
 config HID_REDRAGON
 	tristate "Redragon keyboards"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 6d3e630e81af..4f333881560e 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_HID_MAGICMOUSE)	+= hid-magicmouse.o
 obj-$(CONFIG_HID_MALTRON)	+= hid-maltron.o
 obj-$(CONFIG_HID_MCP2221)	+= hid-mcp2221.o
 obj-$(CONFIG_HID_MAYFLASH)	+= hid-mf.o
+obj-$(CONFIG_HID_MEGAWORLD)	+= hid-megaworld.o
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
 obj-$(CONFIG_HID_MULTITOUCH)	+= hid-multitouch.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 85975031389b..2588d933c2b5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -860,6 +860,9 @@
 #define USB_VENDOR_ID_MCS		0x16d0
 #define USB_DEVICE_ID_MCS_GAMEPADBLOCK	0x0bcc
 
+#define USB_VENDOR_MEGAWORLD		0x07b5
+#define USB_DEVICE_ID_MEGAWORLD_GAMEPAD	0x0312
+
 #define USB_VENDOR_ID_MGE		0x0463
 #define USB_DEVICE_ID_MGE_UPS		0xffff
 #define USB_DEVICE_ID_MGE_UPS1		0x0001
diff --git a/drivers/hid/hid-megaworld.c b/drivers/hid/hid-megaworld.c
new file mode 100644
index 000000000000..3ac247d7bd54
--- /dev/null
+++ b/drivers/hid/hid-megaworld.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Vibration support for Mega World controllers
+ *
+ * Copyright 2022 Frank Zago
+ *
+ * Derived from hid-zpff.c:
+ *   Copyright (c) 2005, 2006 Anssi Hannula <anssi.hannula@gmail.com>
+ */
+
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "hid-ids.h"
+
+#ifdef CONFIG_MEGAWORLD_FF
+
+struct mwctrl_device {
+	struct hid_report *report;
+	s32 *weak;
+	s32 *strong;
+};
+
+static int mwctrl_play(struct input_dev *dev, void *data,
+		       struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct mwctrl_device *mwctrl = data;
+
+	*mwctrl->strong = effect->u.rumble.strong_magnitude >> 8;
+	*mwctrl->weak = effect->u.rumble.weak_magnitude >> 8;
+
+	hid_hw_request(hid, mwctrl->report, HID_REQ_SET_REPORT);
+
+	return 0;
+}
+
+static int mwctrl_init(struct hid_device *hid)
+{
+	struct mwctrl_device *mwctrl;
+	struct hid_report *report;
+	struct hid_input *hidinput;
+	struct input_dev *dev;
+	int i, error;
+
+	if (list_empty(&hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
+	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+	dev = hidinput->input;
+
+	for (i = 0; i < 4; i++) {
+		report = hid_validate_values(hid, HID_OUTPUT_REPORT, 0, i, 1);
+		if (!report)
+			return -ENODEV;
+	}
+
+	mwctrl = kzalloc(sizeof(struct mwctrl_device), GFP_KERNEL);
+	if (!mwctrl)
+		return -ENOMEM;
+
+	set_bit(FF_RUMBLE, dev->ffbit);
+
+	error = input_ff_create_memless(dev, mwctrl, mwctrl_play);
+	if (error) {
+		kfree(mwctrl);
+		return error;
+	}
+
+	mwctrl->report = report;
+
+	/* Field 0 is always 2, and field 1 is always 0. The original
+	 * windows driver has a 5 bytes command, where the 5th byte is
+	 * a repeat of the 3rd byte, however the device has only 4
+	 * fields. It could be a bug in the driver, or there is a
+	 * different device that needs it.
+	 */
+	report->field[0]->value[0] = 0x02;
+
+	mwctrl->strong = &report->field[2]->value[0];
+	mwctrl->weak = &report->field[3]->value[0];
+
+	return 0;
+}
+
+#else
+
+static int mwctrl_init(struct hid_device *hid)
+{
+	return 0;
+}
+
+#endif
+
+static int mwctrl_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	ret = mwctrl_init(hdev);
+	if (ret)
+		hid_hw_stop(hdev);
+
+	return ret;
+}
+
+static const struct hid_device_id mwctrl_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_MEGAWORLD,
+			 USB_DEVICE_ID_MEGAWORLD_GAMEPAD) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, mwctrl_devices);
+
+static struct hid_driver mwctrl_driver = {
+	.name = "megaworld",
+	.id_table = mwctrl_devices,
+	.probe = mwctrl_probe,
+};
+
+module_hid_driver(mwctrl_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.32.0

