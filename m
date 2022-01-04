Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B8648463A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiADQuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiADQur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:50:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D59CC061785;
        Tue,  4 Jan 2022 08:50:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v7so77303574wrv.12;
        Tue, 04 Jan 2022 08:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qkRyZwwwvuFV2iTyBghAYS+hboYnE7R/cOKdtqbNnzQ=;
        b=cfrHVWcmKgHS25weZcQRTRhDYb6y9dtFc/U8dRiicmRs3OWCz9gueVm1R8f8r1IobA
         GX0U/6VePS3vNGv8n7DoGhVZdax1d5yqYEjOnuZa6tsxaseNjc70jf69DmoWkTNuOct2
         wYTi4QsXMuo8QO07nnjQwYhWDf7BZJB/XNnsdUIRsOvcCSQNnpjO/L8UxZqxU76uMkfp
         vjmLH/bR83jtRW2nmuYrfKDd7N7P6HHseGrCcUpCsMGerBykdmR9gDXpiYXHhRkKaF+p
         JlkntTtcF6gsGo+unlBhel8v+6fSYV8yRmQmCvHkOUZUT8UkDpCJx1KEmIIKHtYAEFOM
         RPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkRyZwwwvuFV2iTyBghAYS+hboYnE7R/cOKdtqbNnzQ=;
        b=vXfdV5YN3GcHxWnfI7mBGhsEASze0Tmdt3fskMhW/CNjY9tFOdsE00xvhmQd2MMy9I
         mAuRCOrqixuRb7Q+zZeARP+R0MkNR3aiBUnL4ICM+FJy1q+icdzHpiz2mz9eJ/ySwWPj
         EJ6yIEqSL28IKB3byFbiUI9te3xbj99MO4QbzOpA2eIAYT0B8cif4Kl945kKi3hYT5jG
         YtafEFII1I3qdU1vAKYx7Oir2a4W/qK+e9WM5p9MIZ478uvTnocXtyoWJHDHlkNIgqYs
         ymPXo1nT+MkERtcyD+WUlIQ06Y8fVzjpw9vQyzEppq557Z5UBRpeEVbIkYYtz5/30OLm
         uMEw==
X-Gm-Message-State: AOAM531zlB2qahNBQsL3hLk98w12cDnjyXv7v0lvgTDcQFw75JlUPvC1
        cxoNWVnro95WxZ6PGOIJCmA=
X-Google-Smtp-Source: ABdhPJzTjjwZCnF268yPf+Kz4Z3Izx70sFV4Q43tyjgppysrDpXjPBDgmMQIGJod8LX/zAe1WzjwhQ==
X-Received: by 2002:adf:9f02:: with SMTP id l2mr44357561wrf.617.1641315045900;
        Tue, 04 Jan 2022 08:50:45 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id j85sm417696wmj.3.2022.01.04.08.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 08:50:45 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexhenrie24@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 3/3] HID: apple: Magic Keyboard 2015 FN key mapping
Date:   Tue,  4 Jan 2022 17:50:33 +0100
Message-Id: <20220104165033.29421-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104165033.29421-1-jose.exposito89@gmail.com>
References: <20220104165033.29421-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
index bea752da4ac3..d0f23da11dfd 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -91,6 +91,26 @@ static const struct apple_key_translation magic_keyboard_alu_fn_keys[] = {
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
 static const struct apple_key_translation macbookair_fn_keys[] = {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -254,6 +274,9 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO ||
 		    hid->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS)
 			table = magic_keyboard_alu_fn_keys;
+		else if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2015 ||
+			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2015)
+			table = magic_keyboard_2015_fn_keys;
 		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
 			table = macbookair_fn_keys;
@@ -407,6 +430,7 @@ static void apple_setup_input(struct input_dev *input)
 	apple_setup_key_translation(input, powerbook_numlock_keys);
 	apple_setup_key_translation(input, apple_iso_keyboard);
 	apple_setup_key_translation(input, magic_keyboard_alu_fn_keys);
+	apple_setup_key_translation(input, magic_keyboard_2015_fn_keys);
 
 	if (swap_fn_leftctrl)
 		apple_setup_key_translation(input, swapped_fn_leftctrl_keys);
-- 
2.25.1

