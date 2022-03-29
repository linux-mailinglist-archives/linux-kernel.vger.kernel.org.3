Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8674EA487
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiC2BSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiC2BSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:18:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E9D15AACB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:16:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e643f85922so132587667b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZR0p/J33EtFAH4Vb+Uo1vBAwD3OqOn7t9fZsrcDUAyY=;
        b=s8sxFHit8Ffg+vSYii0S5fJS8DvqiZ75iXPGedSy0IXRH7AmvrosuepcCA1+THRglK
         qPwv+tn+4BI/Af/MIB9b+3S+OzGIGeohxvj8dyk8Mkx15WC09AHIBZiNOrpXEC18gSab
         qAmbGUPyyo2FcM4oLOcVZXpBvFyDij1jlbNtDk4JTYg9qjGylOUxQCnE1uCJLn2eL4VS
         s1UDOxsqa82oApJ2zOV/IebwBtiXuBsbtQWmPLdk7MLQPWTDE3dTJZRL1BlUQGX8uKtL
         heFN/LpZSG+shZ0LBVMjFaVGC52G8a/HTeMHKEPUsN0LDDLYVFn+YrqiEFaql9RnWXDs
         mXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZR0p/J33EtFAH4Vb+Uo1vBAwD3OqOn7t9fZsrcDUAyY=;
        b=DwGxSWVZRwdtqFoz9ttCjFmLTOBwgG3wX54CyuYmoJn5YtqPCsRzsZwP5zMTe3qJ5N
         1usS4rF+8vV5fmfLLZ9iEZeDNE2c6U5IxfBLirP4tHzEPmBrPpthG9oEzvyAnfLTfEdb
         cp7/jkDqCTk9RLyn0SlT51rqL3WD3b/mbgHDmYaLZJjuxFc/72oY3fDRzZbUgyX62ggf
         FFtjiiXiCuBC7pWclRwS0xtI2SiiNpuoU3M0JmUjbFplxxQv6m/owGnFFKvp5/MaeWqC
         ZjHjZuj9/KExzzi6PdGOoLHdRrznPIJ5j7MM11bjGbA80ydzs108k+eDTvlphSl8HO/c
         2IjA==
X-Gm-Message-State: AOAM530TkgfdV8KtBffc2xB4W9TTyZqitag/TV9ZBmfUg7wsnBtyTSFF
        6n743fIF35GSifCvrwVOzjrYLe+ibWIkFs0=
X-Google-Smtp-Source: ABdhPJwlwtnXU3jRDpF/AlY95fkwlE6nHzU1Mg6n33Fr/qp53xvNCm6Hx7f/NbP5NVfm7TlDHWttTeTFLEe3+v0=
X-Received: from pceballos.nyc.corp.google.com ([2620:0:1003:510:a131:a916:1e0a:ee6a])
 (user=pceballos job=sendgmr) by 2002:a25:6e08:0:b0:633:6ade:e95c with SMTP id
 j8-20020a256e08000000b006336adee95cmr24858836ybc.489.1648516584439; Mon, 28
 Mar 2022 18:16:24 -0700 (PDT)
Date:   Mon, 28 Mar 2022 21:16:06 -0400
In-Reply-To: <f4932722-c577-f03c-8296-c49a8dd8b14f@infradead.org>
Message-Id: <20220329011606.860795-1-pceballos@google.com>
Mime-Version: 1.0
References: <f4932722-c577-f03c-8296-c49a8dd8b14f@infradead.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2] HID: Add driver for Google Hangouts Meet Speakermic
From:   Pablo Ceballos <pceballos@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Pablo Ceballos <pceballos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver works around a problem with the HID usage sent by this
device for the mute button. It prevents key events from being generated
for that HID usage since they would be incorrect.

Signed-off-by: Pablo Ceballos <pceballos@google.com>
---
 drivers/hid/Kconfig            | 12 ++++++++
 drivers/hid/Makefile           |  1 +
 drivers/hid/hid-google-atrus.c | 55 ++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h          |  1 +
 4 files changed, 69 insertions(+)
 create mode 100644 drivers/hid/hid-google-atrus.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f5544157576c..d4b6be827d15 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -403,6 +403,18 @@ config HOLTEK_FF
 	  Say Y here if you have a Holtek On Line Grip based game controller
 	  and want to have force feedback support for it.
 
+config HID_GOOGLE_ATRUS
+	tristate "Google Hangouts Meet Speakermic"
+	depends on USB_HID
+	help
+	This selects a driver for the Google Hangouts Meet Speakermic.
+
+	This driver works around a problem with the HID usage sent by this
+	device for the mute button. It prevents key events from being generated
+	for that HID usage since they would be incorrect.
+
+	Say Y here if you have a Google Hangouts Meet Speakermic.
+
 config HID_GOOGLE_HAMMER
 	tristate "Google Hammer Keyboard"
 	depends on USB_HID && LEDS_CLASS && CROS_EC
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 6d3e630e81af..2ee446b5b953 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
 obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
 obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
 obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
+obj-$(CONFIG_HID_GOOGLE_ATRUS)  += hid-google-atrus.o
 obj-$(CONFIG_HID_GOOGLE_HAMMER)	+= hid-google-hammer.o
 obj-$(CONFIG_HID_VIVALDI)	+= hid-vivaldi.o
 obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
diff --git a/drivers/hid/hid-google-atrus.c b/drivers/hid/hid-google-atrus.c
new file mode 100644
index 000000000000..e136c70e9425
--- /dev/null
+++ b/drivers/hid/hid-google-atrus.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  HID driver for Google Hangouts Meet Speakermic
+ *
+ *  Copyright 2022 Google LLC.
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+/*
+ * This driver handles the telephony phone mute HID usage by ignoring it. This
+ * avoids the default handling by the hid-input driver which is to map this to
+ * a KEY_MICMUTE event. The issue is that this device implements the phone mute
+ * HID usage as a toggle switch, where 1 indicates muted, and 0 indicates
+ * unmuted. However, for an EV_KEY event 1 indicates the key has been pressed
+ * and 0 indicates it has been released.
+ */
+
+static int atrus_event(struct hid_device *hid, struct hid_field *field,
+		       struct hid_usage *usage, __s32 value)
+{
+	/*
+	 * Return 1 to indicate no further processing should be done for this
+	 * usage.
+	 */
+	return 1;
+}
+
+static const struct hid_device_id atrus_devices[] = {
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_ATRUS) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, atrus_devices);
+
+static const struct hid_usage_id atrus_usages[] = {
+	/* Handle only the Telephony Phone Mute usage. */
+	{ HID_UP_TELEPHONY | 0x2f, EV_KEY, HID_ANY_ID },
+	{ HID_TERMINATOR, HID_TERMINATOR, HID_TERMINATOR }
+};
+
+static struct hid_driver atrus_driver = {
+	.name = "atrus",
+	.id_table = atrus_devices,
+	.usage_table = atrus_usages,
+	.event = atrus_event,
+};
+module_hid_driver(atrus_driver);
+
+MODULE_AUTHOR("Pablo Ceballos <pcebalos@google.com>");
+MODULE_DESCRIPTION("Google Hangouts Meet Speakermic USB HID Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 85975031389b..9f6fc5cfbeb9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -506,6 +506,7 @@
 #define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
 #define USB_DEVICE_ID_GOOGLE_DON	0x5050
 #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
+#define USB_DEVICE_ID_GOOGLE_ATRUS	0x8001
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.35.1.1021.g381101b075-goog

