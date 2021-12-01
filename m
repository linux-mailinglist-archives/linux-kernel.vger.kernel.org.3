Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A22C464D59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349103AbhLAL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbhLAL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:59:03 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C8C061574;
        Wed,  1 Dec 2021 03:55:42 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s37so13656784pga.9;
        Wed, 01 Dec 2021 03:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAxdzonf+786j6Tm6BUZ1QfXIqaLTEogVLBffouzA18=;
        b=BKsNRqf4PouAuuBbNTdr3C/1usdTCgD92/NGKlhe6J/+a0SRyMlFDKCokXLThs7JFf
         xC0zzqye23vcQB8gR2LXtDjAAudYq/Z2TcrE2sGlFSsj9Spg7bxrMCzmwds/Hhcl1bo4
         9q2g5TA7yz03R/tJiKFNqVpMCV0iv6ivSmEcIc85hjOpUVjDoQj/3MWknXiomxPRpBjB
         iniaLGcqZGHC0VBMNmqYINz4cp2/NXKqZdaNGOYNVWdPYWLPE81tyNTTO02fXcWUK6i9
         nvtPwUwSqx5+m+wFh1pgmFQlkkUpgGuZoCjd6/H6zC9OoSPv7GPS1F4uxfgoh72AF0y1
         S+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAxdzonf+786j6Tm6BUZ1QfXIqaLTEogVLBffouzA18=;
        b=uUkP7wJ3H4SzQj2oSRClaGG8qxydB8t04RkQDu0m1asle9PmytwPQuDp6tfaW9dXif
         mtL9zsjICbxlb1UOwZvbO4jKcFGctZrf2lTYtl+mWnzGB+Eax26VFllARucREjgZAu8g
         qqjlTDEQ7jwTVGVqzwR6N+tVu1Rq20MTRzvBLoQmRD6Kowk4gOe3A+dODIIm+nXpJr5v
         W1AWOlW/yxRiZ6+fZKk55aVmvLXb1AcyTmDW4roMS8P7QbK3+w5DD87O2pOvVYrdpVwl
         RsG7+h6ZqSu0aNEOGE/SadaqPPx31ZY1uzwZtvFG8WnMikoGCCsZ9cOpkPQ1t3WDB7mI
         Uv0g==
X-Gm-Message-State: AOAM531gqZQ4iDsB23eQRnlariNwNr4ZzeiJax56BdE9t4rcnVWxEmjT
        C/UbA1bHw1soix1I77wNILo=
X-Google-Smtp-Source: ABdhPJzQTg2s7Eey0l8i7taTv00NMdQFxltJ7EuGTrJV1INYJHetXkXdH97E/6HqtOA2V//dNm6nsQ==
X-Received: by 2002:a63:8448:: with SMTP id k69mr4311455pgd.509.1638359742027;
        Wed, 01 Dec 2021 03:55:42 -0800 (PST)
Received: from keqing-virtualbox.mshome.net ([92.119.178.3])
        by smtp.gmail.com with ESMTPSA id w20sm27657906pfu.146.2021.12.01.03.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 03:55:41 -0800 (PST)
From:   Desmond Lim <peckishrine@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        peckishrine@gmail.com, kinglongmee@gmail.com
Subject: [PATCH] HID: sigmamicro: Fix modifier keys for SiGma Micro based keyboards
Date:   Wed,  1 Dec 2021 19:51:17 +0800
Message-Id: <20211201115117.3002-1-peckishrine@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the report descriptor from SIGMACHIP USB Keyboard (1c4f:0059)
to make modifier keys work.

Signed-off-by: Desmond Lim <peckishrine@gmail.com>
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 drivers/hid/Kconfig          | 10 ++++++++
 drivers/hid/Makefile         |  1 +
 drivers/hid/hid-ids.h        |  1 +
 drivers/hid/hid-sigmamicro.c | 45 ++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)
 create mode 100644 drivers/hid/hid-sigmamicro.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 9f5435b55949..724dd0f35d3c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -970,6 +970,16 @@ config HID_SEMITEK
 	- Woo-dy
 	- X-Bows Nature/Knight
 
+config HID_SIGMAMICRO
+	tristate "SiGma Micro based keyboards"
+	depends on HID
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

