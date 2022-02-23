Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664CF4C1E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbiBWWKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbiBWWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:10:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A974B861
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:09:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so51149ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vPsoxmLFCGTxgUe4OFTHCzlbKt11DcygrOzYKeDdnVk=;
        b=PRUFFxCsKwskCyK8djrzZdRUxg2aUez0XnIQ3PU0O84m0VqQodnglL5EIQUJ5fdHas
         2U14yNj4V0SlRsNnyJapzMrrwLsP0A8132T+cFl02paeTiNmgFe7FleEi9rArnLc7M3/
         41t0UMnOGDP/GoPs2KoGImPtidj57XNbKhEm0G7MKcbn7SGqubp3tHRooFtj5vT3kf3n
         KUYgLgJpHe5OtYKX1If+T3kI7ElF3P9/LUX55tlS+sK1Dq7QZzBFK82g3/G72WaeBdYn
         h3UOw7joRCI5ei3Kj8yPjBwtcfdSGaQlgFHh9VLiFdLVViF53h+LNbxgTBOJHvdzepgX
         o2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vPsoxmLFCGTxgUe4OFTHCzlbKt11DcygrOzYKeDdnVk=;
        b=T83VqgeyXLUYaPUFFhv9CzUVEEMXQxrYLv/OnSa0o3scv43ZUP6OsqMr7QEriOYeA4
         8mk2vbznJfg3FXPwuBJZMMLNTNefo/oUdnobwYDPVFEQ27FdkEkoFiNrzswLJOtBGF02
         WHdK1WE65SJvaOL0m4tIGUkDRk2IOM9oly8MLMzKcLl586oLyP7EPb4zAcrmUAuU/diZ
         SA5fkafZmIE2OAOKgYTeAt1tjvWLQiMxMvtyS5ptSeLMOl9UfgJOg9HiEVDah96t9ETp
         9oq+6JVRfLK1/MrnmxQCR5oIUtwJl3H5mVXaeiTcEn6DhX7DWZRXMbKSjqMQG86yZPs0
         DSlw==
X-Gm-Message-State: AOAM533K8fZpMAszkuvUOubuT0X6Nku9x0SWlB+66bsOlJ/8zMpYC/g2
        ha/8zGpdIOz5Xc71kS47FI8I9hwd5g/+ggI=
X-Google-Smtp-Source: ABdhPJxp71N+rU6Cf2gjQnR8QMeLSwiTiIHv/NNhBYAeIKV2aAc7k+nWHK9+YVI+6TP3Y5YuJftaj+sM4dI+nVA=
X-Received: from pceballos.nyc.corp.google.com ([2620:0:1003:510:ccf7:25ec:10ba:2169])
 (user=pceballos job=sendgmr) by 2002:a81:9a41:0:b0:2ca:287c:6c65 with SMTP id
 r62-20020a819a41000000b002ca287c6c65mr1609681ywg.266.1645654176518; Wed, 23
 Feb 2022 14:09:36 -0800 (PST)
Date:   Wed, 23 Feb 2022 17:09:05 -0500
Message-Id: <20220223170301.1.I7a855580ce9f43fc2f598bdccf088c978d4af822@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] HID: Add driver for Google Hangouts Meet Speakermic
From:   Pablo Ceballos <pceballos@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
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

This driver handles the telephony phone mute HID usage by ignoring it.
This avoids the default handling by the hid-input driver which is to map
this to a KEY_MICMUTE event. The issue is that this device implements
the phone mute HID usage as a toggle switch, where 1 indicates muted,
and 0 indicates unmuted. However, for an EV_KEY event 1 indicates the
key has been pressed and 0 indicates it has been released.

Signed-off-by: Pablo Ceballos <pceballos@google.com>
---

 drivers/hid/Kconfig            |  6 +++++
 drivers/hid/Makefile           |  1 +
 drivers/hid/hid-google-atrus.c | 44 ++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h          |  1 +
 4 files changed, 52 insertions(+)
 create mode 100644 drivers/hid/hid-google-atrus.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f5544157576c9..d89c57d89a699 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -403,6 +403,12 @@ config HOLTEK_FF
 	  Say Y here if you have a Holtek On Line Grip based game controller
 	  and want to have force feedback support for it.
 
+config HID_GOOGLE_ATRUS
+	tristate "Google Hangouts Meet Speakermic"
+	depends on USB_HID
+	---help---
+	Say Y here if you have a Google Hangouts Meet Speakermic
+
 config HID_GOOGLE_HAMMER
 	tristate "Google Hammer Keyboard"
 	depends on USB_HID && LEDS_CLASS && CROS_EC
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 6d3e630e81af5..2ee446b5b953b 100644
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
index 0000000000000..938947417f119
--- /dev/null
+++ b/drivers/hid/hid-google-atrus.c
@@ -0,0 +1,44 @@
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
+static int atrus_event(struct hid_device *hid, struct hid_field *field,
+		       struct hid_usage *usage, __s32 value)
+{
+	// Return 1 to indicate no further processing should be done for this
+	// usage.
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
+	// Handle only the Telephony Phone Mute usage.
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
index 85975031389b3..9f6fc5cfbeb96 100644
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
2.35.1.574.g5d30c73bfb-goog

