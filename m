Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E836481DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhL3P2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhL3P2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:28:13 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FE3C061574;
        Thu, 30 Dec 2021 07:28:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso23446290pjb.1;
        Thu, 30 Dec 2021 07:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QfvPLF6PcDnGDYLqnhewHwh11Fjl8x4uNZYuXxJeBpo=;
        b=EOFPO61MEu5lMcanv/mDXxNqgB8uLUbb0sWYMah3/IkFEN44JNXx8IgXX1y1cRKaoZ
         V0yhbSndy2xIFKoBNS8fWafEpgjVpVIlpuiT+vpgKMtC0V9icxBDvmIIJduPg/1ZX/6N
         ztbBLPNW5idaodRpQBChG8aPWZ2nVSalruamRpE223euUfi0QQRrLpN9oXFtmxwKvgt3
         uI34msMtCLTCpdy0ksfjzQKxxDOD4DsvfxxwW5ovcRNjA1L4FedOEWg61qSS6SXwnX8M
         SYyBtozxkHGXyv15W7eVehfWR3Rt5H+wlUObjo5t/73hzVy4wwBv0id5Py4es1UJ+2Sz
         jsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QfvPLF6PcDnGDYLqnhewHwh11Fjl8x4uNZYuXxJeBpo=;
        b=eo2FkMZeczwWNMxVJOz9JAV0NhAC1gqomJ8ZjCJ308okJL1KORO906ZBNY8qd8+qVA
         B1oz6iY430CZb6v+ei1M5uMF3UQueOOIzs3nlaYDaYUHyWT5gglP/K3ZLJVkKqYw/VrY
         Dv1eomZw2u0CNyNqZE/B+YfkoRo2fcG7ZuPoEWBw5zh6j4jZby04tsgplL7nDcGr+WKP
         VNPsO7ERQ6Ih6E+FUUkA21nA7c87lP3dsAxXiZ2z8QtV7kXVSdmDqGl0jQt9v1rWk4vU
         olV2xSWV+Q63DTwXcbtBxicQKNMvNZ+C8+X2WQAUU7Q852HVIW+DREbAgqGlmMJzX8SG
         oFuw==
X-Gm-Message-State: AOAM532rAU9JbYJqtHZy2NYKoVuL6+XNUusJzg/nqDgwffJBisOofxbc
        A24KOau7JDhzKUWll7HOyNU=
X-Google-Smtp-Source: ABdhPJyLNGSf2sSMsBhoJW7f0TrNNCEbLh8argbUR+7uZN0V4/0NJnAvmf3rtdFDvjFvgNkGZTRC0g==
X-Received: by 2002:a17:90b:3509:: with SMTP id ls9mr38759927pjb.5.1640878092123;
        Thu, 30 Dec 2021 07:28:12 -0800 (PST)
Received: from localhost.localdomain ([92.119.178.3])
        by smtp.gmail.com with ESMTPSA id h1sm6794249pfi.109.2021.12.30.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:28:11 -0800 (PST)
From:   Desmond Lim <peckishrine@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Desmond Lim <peckishrine@gmail.com>,
        Kinglong Mee <kinglongmee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v3] HID: add SiGma Micro driver
Date:   Thu, 30 Dec 2021 23:27:56 +0800
Message-Id: <20211230152758.79104-1-peckishrine@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for SiGma Micro-based keyboards where all the modifier keys mapped
to Shift_L.

Co-developed-by: Kinglong Mee <kinglongmee@gmail.com>
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
Signed-off-by: Desmond Lim <peckishrine@gmail.com>
---
Changes since v2:
 - Rewrite commit title and message, and hence supersedes [1]
 - Additional verification before fixing rdesc

Changes since v1:
 - Update commit message
 - Correct Kconfig dependency

[1] https://lore.kernel.org/lkml/20211207133603.4947-1-peckishrine@gmail.com/
---
 drivers/hid/Kconfig          |  10 +++
 drivers/hid/Makefile         |   1 +
 drivers/hid/hid-ids.h        |   1 +
 drivers/hid/hid-sigmamicro.c | 130 +++++++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+)
 create mode 100644 drivers/hid/hid-sigmamicro.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a7c78ac96270..7af0d4f7d595 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -970,6 +970,16 @@ config HID_SEMITEK
 	- Woo-dy
 	- X-Bows Nature/Knight
 
+config HID_SIGMAMICRO
+	tristate "SiGma Micro-based keyboards"
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
index 19da07777d62..0b9c398ec7b8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1086,6 +1086,7 @@
 
 #define USB_VENDOR_ID_SIGMA_MICRO	0x1c4f
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD	0x0002
+#define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2	0x0059
 
 #define USB_VENDOR_ID_SIGMATEL		0x066F
 #define USB_DEVICE_ID_SIGMATEL_STMP3780	0x3780
diff --git a/drivers/hid/hid-sigmamicro.c b/drivers/hid/hid-sigmamicro.c
new file mode 100644
index 000000000000..2e7058ac0e9d
--- /dev/null
+++ b/drivers/hid/hid-sigmamicro.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID driver for SiGma Micro-based keyboards
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
+static const __u8 sm_0059_rdesc[] = {
+	0x05, 0x0c,              /* Usage Page (Consumer Devices)       0   */
+	0x09, 0x01,              /* Usage (Consumer Control)            2   */
+	0xa1, 0x01,              /* Collection (Application)            4   */
+	0x85, 0x01,              /*  Report ID (1)                      6   */
+	0x19, 0x00,              /*  Usage Minimum (0)                  8   */
+	0x2a, 0x3c, 0x02,        /*  Usage Maximum (572)                10  */
+	0x15, 0x00,              /*  Logical Minimum (0)                13  */
+	0x26, 0x3c, 0x02,        /*  Logical Maximum (572)              15  */
+	0x95, 0x01,              /*  Report Count (1)                   18  */
+	0x75, 0x10,              /*  Report Size (16)                   20  */
+	0x81, 0x00,              /*  Input (Data,Arr,Abs)               22  */
+	0xc0,                    /* End Collection                      24  */
+	0x05, 0x01,              /* Usage Page (Generic Desktop)        25  */
+	0x09, 0x80,              /* Usage (System Control)              27  */
+	0xa1, 0x01,              /* Collection (Application)            29  */
+	0x85, 0x02,              /*  Report ID (2)                      31  */
+	0x19, 0x81,              /*  Usage Minimum (129)                33  */
+	0x29, 0x83,              /*  Usage Maximum (131)                35  */
+	0x25, 0x01,              /*  Logical Maximum (1)                37  */
+	0x75, 0x01,              /*  Report Size (1)                    39  */
+	0x95, 0x03,              /*  Report Count (3)                   41  */
+	0x81, 0x02,              /*  Input (Data,Var,Abs)               43  */
+	0x95, 0x05,              /*  Report Count (5)                   45  */
+	0x81, 0x01,              /*  Input (Cnst,Arr,Abs)               47  */
+	0xc0,                    /* End Collection                      49  */
+	0x06, 0x00, 0xff,        /* Usage Page (Vendor Defined Page 1)  50  */
+	0x09, 0x01,              /* Usage (Vendor Usage 1)              53  */
+	0xa1, 0x01,              /* Collection (Application)            55  */
+	0x85, 0x03,              /*  Report ID (3)                      57  */
+	0x1a, 0xf1, 0x00,        /*  Usage Minimum (241)                59  */
+	0x2a, 0xf8, 0x00,        /*  Usage Maximum (248)                62  */
+	0x15, 0x00,              /*  Logical Minimum (0)                65  */
+	0x25, 0x01,              /*  Logical Maximum (1)                67  */
+	0x75, 0x01,              /*  Report Size (1)                    69  */
+	0x95, 0x08,              /*  Report Count (8)                   71  */
+	0x81, 0x02,              /*  Input (Data,Var,Abs)               73  */
+	0xc0,                    /* End Collection                      75  */
+	0x05, 0x01,              /* Usage Page (Generic Desktop)        76  */
+	0x09, 0x06,              /* Usage (Keyboard)                    78  */
+	0xa1, 0x01,              /* Collection (Application)            80  */
+	0x85, 0x04,              /*  Report ID (4)                      82  */
+	0x05, 0x07,              /*  Usage Page (Keyboard)              84  */
+	0x19, 0xe0,              /*  Usage Minimum (224)                86  */
+	0x29, 0xe7,              /*  Usage Maximum (231)                88  */
+	0x15, 0x00,              /*  Logical Minimum (0)                90  */
+	0x25, 0x01,              /*  Logical Maximum (1)                92  */
+	0x75, 0x01,              /*  Report Size (1)                    94  */
+	0x95, 0x08,              /*  Report Count (8)                   96  */
+	0x81, 0x00,              /*  Input (Data,Arr,Abs)               98  */
+	0x95, 0x30,              /*  Report Count (48)                  100 */
+	0x75, 0x01,              /*  Report Size (1)                    102 */
+	0x15, 0x00,              /*  Logical Minimum (0)                104 */
+	0x25, 0x01,              /*  Logical Maximum (1)                106 */
+	0x05, 0x07,              /*  Usage Page (Keyboard)              108 */
+	0x19, 0x00,              /*  Usage Minimum (0)                  110 */
+	0x29, 0x2f,              /*  Usage Maximum (47)                 112 */
+	0x81, 0x02,              /*  Input (Data,Var,Abs)               114 */
+	0xc0,                    /* End Collection                      116 */
+	0x05, 0x01,              /* Usage Page (Generic Desktop)        117 */
+	0x09, 0x06,              /* Usage (Keyboard)                    119 */
+	0xa1, 0x01,              /* Collection (Application)            121 */
+	0x85, 0x05,              /*  Report ID (5)                      123 */
+	0x95, 0x38,              /*  Report Count (56)                  125 */
+	0x75, 0x01,              /*  Report Size (1)                    127 */
+	0x15, 0x00,              /*  Logical Minimum (0)                129 */
+	0x25, 0x01,              /*  Logical Maximum (1)                131 */
+	0x05, 0x07,              /*  Usage Page (Keyboard)              133 */
+	0x19, 0x30,              /*  Usage Minimum (48)                 135 */
+	0x29, 0x67,              /*  Usage Maximum (103)                137 */
+	0x81, 0x02,              /*  Input (Data,Var,Abs)               139 */
+	0xc0,                    /* End Collection                      141 */
+	0x05, 0x01,              /* Usage Page (Generic Desktop)        142 */
+	0x09, 0x06,              /* Usage (Keyboard)                    144 */
+	0xa1, 0x01,              /* Collection (Application)            146 */
+	0x85, 0x06,              /*  Report ID (6)                      148 */
+	0x95, 0x38,              /*  Report Count (56)                  150 */
+	0x75, 0x01,              /*  Report Size (1)                    152 */
+	0x15, 0x00,              /*  Logical Minimum (0)                154 */
+	0x25, 0x01,              /*  Logical Maximum (1)                156 */
+	0x05, 0x07,              /*  Usage Page (Keyboard)              158 */
+	0x19, 0x68,              /*  Usage Minimum (104)                160 */
+	0x29, 0x9f,              /*  Usage Maximum (159)                162 */
+	0x81, 0x02,              /*  Input (Data,Var,Abs)               164 */
+	0xc0,                    /* End Collection                      166 */
+};
+
+static __u8 *sm_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+			     unsigned int *rsize)
+{
+	if (*rsize == sizeof(sm_0059_rdesc) &&
+	    !memcmp(sm_0059_rdesc, rdesc, *rsize)) {
+		hid_info(hdev, "Fixing up SiGma Micro report descriptor\n");
+		rdesc[99] = 0x02;
+	}
+	return rdesc;
+}
+
+static const struct hid_device_id sm_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO,
+			 USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2) },
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

base-commit: 03090cc76ee3298cc70bce26bbe93a0cb50e42a2
-- 
2.30.2

