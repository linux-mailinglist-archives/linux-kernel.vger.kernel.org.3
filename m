Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B44AE0F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385031AbiBHShW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384954AbiBHShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:37:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3CFC061576;
        Tue,  8 Feb 2022 10:37:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q7so4224432wrc.13;
        Tue, 08 Feb 2022 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxL5OIWqqpAy6UyfrEJShM9WIDuebK75MbARP5wirg8=;
        b=kxqrBwpPMYD3IylFIVxVsovDv6QgZDopnXwBzbdSFUPuTWFnmN/fPSdQ/wOhzZzL0e
         Fn1Q2zyjvSALllyzii9Dexno66VgYTELeoTVkd7vSTP/+k0RBpT4vhd181OJPn3LYrcl
         u0PmePCgfRijHHyhi14ahUokEiVLTawI8dwi2wZgFgiOz5POcSK67pIZbsXHT0JeS+9b
         yNBMyYRxigcoao7rlDvGb8YUW/X7nUAtecmzn4n0Uy08zCVwOFpfIIVH7R7Xlsn+tkMa
         psoEtk2As1hQOWskDU1bhZe1aYv8JVDMZQUcoObphSx1CN/FKayP2hR9rVs3cATq/F+A
         MJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxL5OIWqqpAy6UyfrEJShM9WIDuebK75MbARP5wirg8=;
        b=jRfFkVbdiRfA13OzvU2JJVfQZTYjACicNarBLE/9v18P/uJujRv+5AHDo7raX/fvgg
         w2TReYRW2t9dGVFa5RYk0qZEqHwZ0DdmuY6wwESdH7jzS4kU73N8MbTzAQEX0ZbTv6K8
         jd94wwN4ekXH5kHdiyubOLg/HQBPJxPzgCA8mmq+SYrPcw9QsLapy9/WeKnxLApR8CD/
         Xaf5qmv8P48Y8AE1/a58tXlHdyCOXnCb1LsxBlKmHsTqSUsY1H/XxRt0Dvjdon6bOQBl
         hykmV/ykpNqUjIbwZtBgCeEEyDDz/lDBMRDGZ5d3GODHCXaVlYXW9akOAEoMDD3tLjmw
         thrA==
X-Gm-Message-State: AOAM5322n/KnIuP10S/+6SXaPEQSi2SrqVC9jmjKune204rWYOP8bRVF
        vQ2YiHAVrHLyO6KVofIiBEM=
X-Google-Smtp-Source: ABdhPJz6rHCygktNsudASkjo9NK5WWFglF+Ay6wa4YTCDDsK+BrYTode4eijsA8rMH9F59ppAb5u0Q==
X-Received: by 2002:a05:6000:cf:: with SMTP id q15mr3560484wrx.536.1644345432557;
        Tue, 08 Feb 2022 10:37:12 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id l20sm2945308wmq.22.2022.02.08.10.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:37:12 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 2/3] HID: apple: Magic Keyboard first generation FN key mapping
Date:   Tue,  8 Feb 2022 19:37:03 +0100
Message-Id: <20220208183704.40101-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208183704.40101-1-jose.exposito89@gmail.com>
References: <20220208183704.40101-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function key mapping for the Magic Keyboard first generation (2007,
2009 and 2011 aluminum wireless models) was not present and the default
one was used instead.

This caused two main issues:

 - The F5 and F6 keys were sending KEY_KBDILLUMDOWN and KEY_KBDILLUMUP;
   however, the keyboard is not backlited.

 - The keyboard has the APPLE_NUMLOCK_EMULATION quirk with F6 set as
   the KEY_NUMLOCK key by "powerbook_numlock_keys". However, because F6
   was mapped to KEY_KBDILLUMUP by the default mapping it was not
   possible to switch the numlock status.
   This means that, if numlock was enabled on session startup, it was
   not possible to disable it without connecting another keyboard.

Add a custom translation table for the device leaving F5 unassigned and
using F6 as the KEY_NUMLOCK key.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-apple.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 6ca393c0a390..c140146e2370 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -76,6 +76,27 @@ struct apple_key_translation {
 	u8 flags;
 };
 
+static const struct apple_key_translation magic_keyboard_alu_fn_keys[] = {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_ENTER,	KEY_INSERT },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
+	{ KEY_F3,	KEY_SCALE,          APPLE_FLAG_FKEY },
+	{ KEY_F4,	KEY_DASHBOARD,      APPLE_FLAG_FKEY },
+	{ KEY_F6,	KEY_NUMLOCK,        APPLE_FLAG_FKEY },
+	{ KEY_F7,	KEY_PREVIOUSSONG,   APPLE_FLAG_FKEY },
+	{ KEY_F8,	KEY_PLAYPAUSE,      APPLE_FLAG_FKEY },
+	{ KEY_F9,	KEY_NEXTSONG,       APPLE_FLAG_FKEY },
+	{ KEY_F10,	KEY_MUTE,           APPLE_FLAG_FKEY },
+	{ KEY_F11,	KEY_VOLUMEDOWN,     APPLE_FLAG_FKEY },
+	{ KEY_F12,	KEY_VOLUMEUP,       APPLE_FLAG_FKEY },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
 static const struct apple_key_translation apple2021_fn_keys[] = {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -251,9 +272,19 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}
 
 	if (fnmode) {
-		if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021 ||
-		    hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021 ||
-		    hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021)
+		if (hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI ||
+		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO ||
+		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS ||
+		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI ||
+		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO ||
+		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS ||
+		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI ||
+		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO ||
+		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS)
+			table = magic_keyboard_alu_fn_keys;
+		else if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021 ||
+			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021 ||
+			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021)
 			table = apple2021_fn_keys;
 		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
@@ -468,6 +499,7 @@ static void apple_setup_input(struct input_dev *input)
 	apple_setup_key_translation(input, powerbook_fn_keys);
 	apple_setup_key_translation(input, powerbook_numlock_keys);
 	apple_setup_key_translation(input, apple_iso_keyboard);
+	apple_setup_key_translation(input, magic_keyboard_alu_fn_keys);
 	apple_setup_key_translation(input, apple2021_fn_keys);
 
 	if (swap_fn_leftctrl)
-- 
2.25.1

