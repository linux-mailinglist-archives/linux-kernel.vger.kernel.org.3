Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3354F4D41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581794AbiDEXk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573273AbiDESlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:41:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA8D20BEF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:39:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb5980c4f8so607227b3.23
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kpZJZ6BC0teJcS/Va/HLoxzrjVYiRhmbSvuUm1Ha8sQ=;
        b=ZdvRyRnPU8Kh82lplK03SdRZOePvmaw21DelWV1zTSqS/wjCkoUIYoY61x69HDa0BB
         BkENG+5p3VPqwecV9yEgRiRisNcnE3VeVVW7AOScnZd4XupmdoHFS5S2gKJLzE7GHY6A
         zGXVjMCER8dEsCVSRHsmmtEvVKuVyK3GMttUBmYSjf/DRoGPcWgyJ5rDCC+Ru+9zo5Sw
         1rj0cV0XTVzlX93A55tOHgnaoeRzXzMAf01FQGmrjBjD9UtlB3cKC05sNClQc/ugUTWR
         4mJGO2ekgPApmCPfGhow69H81wYKXuudrt6rJEg4wFn2YrxJLtcu2iCzeQjtlpzeUEdN
         /yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kpZJZ6BC0teJcS/Va/HLoxzrjVYiRhmbSvuUm1Ha8sQ=;
        b=IiwCt5cgNEL0Uvh7IQEK7m9TqvVQ2rzvTYE2S5ephqzMUqpgY68QZ8f9STdp1aiqcl
         w51Qt+UeDuQ56j0/FrquGsUMus/creff+YvAZVCmH6FaC1PHAe3iBJSP4TDBoKxZGPwk
         N9+cjCYliXxZ/zs1QJRpG0SPNIsOu8AulrHQguvyWciHiheL7Wmb5keuZhEtc6cd0AXq
         b4Jin2EeNchTaaeMYkrXx5MXsTjHg8J6+VWheLrS9AlJoDsYm4msfxuCi5/Ud3P+R49F
         vZhA7k6SJsyVgMZ51GFhHEJrwl7CC0pUs4RvsTUmfByiVk7gUQBIHRelRJoTI9M8W++L
         TvyA==
X-Gm-Message-State: AOAM530tc2Qz8ApGr16fpwyuEJ+T0kQEUwl37iOtZlPxpPHbcNAuib+7
        HyopgpAQQ3ZTCiCgKtK1hNEsNI218WOYQ+M=
X-Google-Smtp-Source: ABdhPJzp+IkXPL1X2MLlP92SbOMwqwQY57HoLXPf85DlePcIcZmNDwM+GbgvJ2bvPWH0yqVKexXNR2xK3S7Rwsc=
X-Received: from pceballos.nyc.corp.google.com ([2620:0:1003:510:9936:68aa:f9b7:b13b])
 (user=pceballos job=sendgmr) by 2002:a05:690c:821:b0:2eb:5d96:2709 with SMTP
 id by1-20020a05690c082100b002eb5d962709mr3929236ywb.147.1649183996466; Tue,
 05 Apr 2022 11:39:56 -0700 (PDT)
Date:   Tue,  5 Apr 2022 14:39:53 -0400
Message-Id: <20220405183953.2094007-1-pceballos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH] HID: Driver for Google Hangouts Meet Speakermic
From:   Pablo Ceballos <pceballos@google.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc:     Pablo Ceballos <pceballos@google.com>
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
2.35.1.1094.g7c7d902a7c-goog

