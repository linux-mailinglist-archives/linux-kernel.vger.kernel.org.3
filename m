Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A234AE0F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385045AbiBHSh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiBHShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:37:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F7C061579;
        Tue,  8 Feb 2022 10:37:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so1803333wme.1;
        Tue, 08 Feb 2022 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFTo/bi+FjWLNEXhekC/MI3dMk+TubwGuk6yd0dpJGU=;
        b=kiwXSfLsrQfkGXvJ7u+3BTLh8Fcruy6Dz1BVftSQVcfGbjRNmavlyTm7omSEKy50Wj
         bpUIaKp1lb529BdXhTnrYZSqOUzmMBYwN+uxUp+QxGeBYUBcl0CH9n3+UK9RwJGd80Xy
         9ehirjizBu2j5EHIsxF8yiuRgCswq//ZKLHAnakvXH/KMcXPSYOIsraO96a/T7Qavpc+
         gOvH8qG9OisNBZA/gV3N2sD2Ny89eYPiAO3V0w8gO9HJJyuyYT6dDZm2h0F3TQWB2h8a
         Q8xamO+Wp1IpncPU8ilyYvIZ7aMlv0SSRkJmSJawl6RIGakpALSjQVZcq1svY4Z3KBPl
         rVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFTo/bi+FjWLNEXhekC/MI3dMk+TubwGuk6yd0dpJGU=;
        b=DDWh79JGqKAeEjM0pApTZDYvfJEoexLXs/SyKSzFmShrUG0sw97PryVfWfcrIv/bTa
         YIHeg6UX54RYRtWv64i0ZCDZvQHvRixJt50/rF6yzYsIXuPcsUg7lBSl8IhjstSPo/L9
         QvvecwlTp0cpiDi3bC2OR7MaDe11P9Umnv2DGRPvUOa+kKd8fzKy0e70KVlZaaYwHPWo
         ZhiTQL42nrw5a6DlwZGjZSmOBFNORB+VGZiRaUstESqf1RrBdHsfwWMM3TG9lYSrc1EZ
         3K7tPm3WlVR/VCbjvYx9Gga7h7fOiowHq7xpZ9DSufTfbd82nVD5dZ/nTwSaR/6WSC60
         VG1Q==
X-Gm-Message-State: AOAM530R6YHyVz4jAVFTT/xXUfBVvKOx73P9quLTo6lzIBKPck3i0cA+
        bvKFKcsb7djAyjUh8IsfJ/s=
X-Google-Smtp-Source: ABdhPJxwpFPd8NjSVfFji4x1ADJbmOdeyIXwd1HIXa+5Zx6tcA/BS2T1SRS9Z62RzwrT00NVD62afA==
X-Received: by 2002:a05:600c:3ac5:: with SMTP id d5mr2137484wms.107.1644345433388;
        Tue, 08 Feb 2022 10:37:13 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id l20sm2945308wmq.22.2022.02.08.10.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:37:13 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 3/3] HID: apple: Magic Keyboard 2015 FN key mapping
Date:   Tue,  8 Feb 2022 19:37:04 +0100
Message-Id: <20220208183704.40101-4-jose.exposito89@gmail.com>
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

The Magic Keyboard 2015 function key mapping was not present and the
default mapping was used.
While this worked for most keys, the F5 and F6 keys were sending
KEY_KBDILLUMDOWN and KEY_KBDILLUMUP; however, the keyboard is not
backlited.

Add a custom translation table for the keyboard leaving F5 and F6
unassigned to mimic the default behavior on macOS.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-apple.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index c140146e2370..4a458e7fab42 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -97,6 +97,26 @@ static const struct apple_key_translation magic_keyboard_alu_fn_keys[] = {
 	{ }
 };
 
+static const struct apple_key_translation magic_keyboard_2015_fn_keys[] = {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_ENTER,	KEY_INSERT },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
+	{ KEY_F3,	KEY_SCALE,          APPLE_FLAG_FKEY },
+	{ KEY_F4,	KEY_DASHBOARD,      APPLE_FLAG_FKEY },
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
@@ -282,6 +302,9 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO ||
 		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS)
 			table = magic_keyboard_alu_fn_keys;
+		else if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2015 ||
+			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2015)
+			table = magic_keyboard_2015_fn_keys;
 		else if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021 ||
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021 ||
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021)
@@ -500,6 +523,7 @@ static void apple_setup_input(struct input_dev *input)
 	apple_setup_key_translation(input, powerbook_numlock_keys);
 	apple_setup_key_translation(input, apple_iso_keyboard);
 	apple_setup_key_translation(input, magic_keyboard_alu_fn_keys);
+	apple_setup_key_translation(input, magic_keyboard_2015_fn_keys);
 	apple_setup_key_translation(input, apple2021_fn_keys);
 
 	if (swap_fn_leftctrl)
-- 
2.25.1

