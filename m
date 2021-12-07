Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6069E46BCBB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhLGNkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhLGNkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:40:02 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AC5C061574;
        Tue,  7 Dec 2021 05:36:31 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z6so13494856pfe.7;
        Tue, 07 Dec 2021 05:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cf8+Y7rh6IUMzz1MWO0konQbE6bUG2tyfcoe4eupeDs=;
        b=lUFFTFeQY7uviiiXqIgq0o8zJITMFaUA7guaC0jQUpYg862ncfm2nTy/Jj1tKfg+h5
         9GYURNswsghn0wVv31FCRShvplshXhiMg7bXDNiSTjGedZ8B7Md6iHkyPe0RgzZ3j8wz
         UOiiLS4FeDBk/2q0xDbtjSKquLfKjucOAb/tuHEnwgWLDPGE/XtSAJ3n1rtFaK3nEd1Z
         +xMw5lgYFGm7Jg79TV8/2FtRafi7AZvpXCmfkp02KQU4b7paeYw/uBGZJHg8dgHrhTVE
         s81cPCuJbf9EZluWO69gt8d4cNVDLBXmgGFRwJuVBSCIjJKQ8cyVPdkhzDEZyq0p2Zbz
         COpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cf8+Y7rh6IUMzz1MWO0konQbE6bUG2tyfcoe4eupeDs=;
        b=tXd6vIAfSLLm8fnF7ljqpauWjWMuEA+UiC04LSv6X0W7O9txxkw+C0Q25prm7is1jL
         NPKq5UfLLW4K9g4CK+UmHwAay3j41q0SbNf3C/XvPvWDedgRjMHnfQ14qh60cov9F9Pi
         Y6fcx3cRJVEw05xJ+BcZRHBHmaDopSlgAegURNTAv20cp2JlHPEFSOMPoYbCaXWB6VU7
         av+b1faQ3gj8JC2PKAZFH75FYHBiiYSDAENr7cJFGGJ/BQVIoxqlP4hxET8z7KXPDx9n
         l1qonabw6f7LqB/GgFzVItcz6hRPoJCipwjzxmGdO5xqL0xu7YVozvMglt4SQp+exRno
         v5jw==
X-Gm-Message-State: AOAM531ARO5o1wjWF2RB1Q0adknzH73NO0sdw9ai1v0Fz4QiGtEhVHGj
        AJTdg4Tq693QtysxWotQCWg=
X-Google-Smtp-Source: ABdhPJwr1d/AvigQmQK1cYdO1PQ74sNfNw+M2HPX2ziEc72Li9w6AOnUYOwPTYNi7+dCRXCr/r7CQg==
X-Received: by 2002:a63:904a:: with SMTP id a71mr23561632pge.241.1638884191431;
        Tue, 07 Dec 2021 05:36:31 -0800 (PST)
Received: from keqing-virtualbox.mshome.net ([92.119.178.3])
        by smtp.gmail.com with ESMTPSA id d10sm16008273pfl.139.2021.12.07.05.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:36:30 -0800 (PST)
From:   Desmond Lim <peckishrine@gmail.com>
Cc:     Desmond Lim <peckishrine@gmail.com>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v2] HID: sigmamicro: Fix modifier keys for SiGma Micro based keyboards
Date:   Tue,  7 Dec 2021 21:36:00 +0800
Message-Id: <20211207133603.4947-1-peckishrine@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIGMACHIP USB Keyboard (1c4f:0059) has a problem where all the
modifier keys mapped to Shift_L.

Fix the report descriptor to make modifier keys work as expected.

Co-developed-by: Kinglong Mee <kinglongmee@gmail.com>
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
Signed-off-by: Desmond Lim <peckishrine@gmail.com>
---
Changes since v1:
 - Update commit message
 - Correct Kconfig dependency
---
 drivers/hid/Kconfig          | 10 ++++++++
 drivers/hid/Makefile         |  1 +
 drivers/hid/hid-ids.h        |  1 +
 drivers/hid/hid-sigmamicro.c | 45 ++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)
 create mode 100644 drivers/hid/hid-sigmamicro.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 9f5435b55949..5b76c56bf9a4 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -970,6 +970,16 @@ config HID_SEMITEK
 	- Woo-dy
 	- X-Bows Nature/Knight
 
+config HID_SIGMAMICRO
+	tristate "SiGma Micro based keyboards"
+	depends on USB_HID
+	help
+	  Support for keyboards that use the SiGma Micro (a.k.a SigmaChip) IC.
+
+	  Supported devices:
+	  - Landslides KR-700
+	  - Rapoo V500
+
 config HID_SONY
 	tristate "Sony PS2/3/4 accessories"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 55a6fa3eca5a..89ea7fafb66b 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_HID_RMI)		+= hid-rmi.o
 obj-$(CONFIG_HID_SAITEK)	+= hid-saitek.o
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
 obj-$(CONFIG_HID_SEMITEK)	+= hid-semitek.o
+obj-$(CONFIG_HID_SIGMAMICRO)	+= hid-sigmamicro.o
 obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
 obj-$(CONFIG_HID_SONY)		+= hid-sony.o
 obj-$(CONFIG_HID_SPEEDLINK)	+= hid-speedlink.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 96a455921c67..279410bc8fce 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1083,6 +1083,7 @@
 
 #define USB_VENDOR_ID_SIGMA_MICRO	0x1c4f
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD	0x0002
+#define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2	0x0059
 
 #define USB_VENDOR_ID_SIGMATEL		0x066F
 #define USB_DEVICE_ID_SIGMATEL_STMP3780	0x3780
diff --git a/drivers/hid/hid-sigmamicro.c b/drivers/hid/hid-sigmamicro.c
new file mode 100644
index 000000000000..eb34d6198083
--- /dev/null
+++ b/drivers/hid/hid-sigmamicro.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID driver for SiGma Micro based keyboards
+ *
+ * Copyright (c) 2016 Kinglong Mee
+ * Copyright (c) 2021 Desmond Lim
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+static __u8 *sm_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+			     unsigned int *rsize)
+{
+	switch (hdev->product) {
+	case USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2:
+		if (*rsize == 167 && rdesc[98] == 0x81 && rdesc[99] == 0x00) {
+			hid_info(hdev, "Fixing up SiGma Micro report descriptor\n");
+			rdesc[99] = 0x02;
+		}
+		break;
+	}
+	return rdesc;
+}
+
+static const struct hid_device_id sm_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, sm_devices);
+
+static struct hid_driver sm_driver = {
+	.name = "sigmamicro",
+	.id_table = sm_devices,
+	.report_fixup = sm_report_fixup,
+};
+module_hid_driver(sm_driver);
+
+MODULE_AUTHOR("Kinglong Mee <kinglongmee@gmail.com>");
+MODULE_AUTHOR("Desmond Lim <peckishrine@gmail.com>");
+MODULE_DESCRIPTION("SiGma Micro HID driver");
+MODULE_LICENSE("GPL");

base-commit: 740bebf42104d2f082514b1545a14056f3b1b56c
-- 
2.30.2

