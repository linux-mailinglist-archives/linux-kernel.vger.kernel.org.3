Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23A6484639
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiADQuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiADQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:50:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD40AC061799;
        Tue,  4 Jan 2022 08:50:44 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o3so19202446wrh.10;
        Tue, 04 Jan 2022 08:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uItBLqifPHIkvaG/81UsdMNeHGIfIsL1t8XDlEwMbyg=;
        b=n82p1OthFM88wrlR/TDLGRnWyVRBm/U2x/DXkOCaF4irtzWrz2NClNCKXf7Oc4llMv
         EXuigpc7CxCBt0WNYg7UgUUqiFWh+UoLxGPWr57/N9IoNy/ZR1+/12m6A/FIkmUythcp
         uTPyHR/vrSDGYPEiq9XIHDyahwWqfl48wF2ME7OznJNZhD7ayc0Ai4nw7tYhPmCdGTCW
         gmDwh0SXUF6Zm29azJjDtMir1+/iOX/W/mKaoQDM2pGd1s+4T0QJfac+aS3VeGXQspzH
         2eA56ofu3h2XgAXTabRPm+RiJDCjOZGU4ldpiU97RrP0Iv6QYy35qZ1WVWEB9/qn0JQl
         burA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uItBLqifPHIkvaG/81UsdMNeHGIfIsL1t8XDlEwMbyg=;
        b=pcJGf4StZnEYggAIelE4aSXAS6k+uy4SgSyGyETKQUTMe4HHOiCObuBMdnQrne7OTF
         8bgH7VfokPIKIGdgXD7Nj5Jc96M1mmNj2bIkjQogAboFi2N6MoKQOO1yixSKvqC89Ta6
         xpBIMrny/FFT5wXNzEcWk3+J7pWp0i9FQWnrc3AZo5EqyCXjcyGsA+lkpAanU5emfmuJ
         Gyqv/kwlgpcXshb1h3K2K40qXp+mrMyw5+rLWFYi7BKL3ewDi7UDV8dlHVFEVMHBytS2
         zOkyUQxwWxtIUzVUzb4AiZhcu0uBe9vKF1Xmc2EdYumbpTQjrslr6sgVFXpmPLdKigqx
         pu/w==
X-Gm-Message-State: AOAM533r1eTiM7+yBCDEhThPBk2ebVep3NMLn8LxMTUL5j34cI5qz8u5
        qsIP5n/vgpEvGnSGAVMPuQ0=
X-Google-Smtp-Source: ABdhPJxbOUZpAZQyN2TLnfe6YlJBX4WOJzFI+2xwqQdIR8TZ/dS3YcNjrzpenAovy5BZyu+FFzIIDw==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr44006182wrs.270.1641315043123;
        Tue, 04 Jan 2022 08:50:43 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id j85sm417696wmj.3.2022.01.04.08.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 08:50:42 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexhenrie24@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 2/3] HID: apple: Magic Keyboard first generation FN key mapping
Date:   Tue,  4 Jan 2022 17:50:32 +0100
Message-Id: <20220104165033.29421-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104165033.29421-1-jose.exposito89@gmail.com>
References: <20220104165033.29421-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 drivers/hid/hid-apple.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index aa3d643e3615..bea752da4ac3 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -70,6 +70,27 @@ struct apple_key_translation {
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
 static const struct apple_key_translation macbookair_fn_keys[] = {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -223,7 +244,17 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}
 
 	if (fnmode) {
-		if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
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
+		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
 			table = macbookair_fn_keys;
 		else if (hid->product < 0x21d || hid->product >= 0x300)
@@ -375,6 +406,7 @@ static void apple_setup_input(struct input_dev *input)
 	apple_setup_key_translation(input, powerbook_fn_keys);
 	apple_setup_key_translation(input, powerbook_numlock_keys);
 	apple_setup_key_translation(input, apple_iso_keyboard);
+	apple_setup_key_translation(input, magic_keyboard_alu_fn_keys);
 
 	if (swap_fn_leftctrl)
 		apple_setup_key_translation(input, swapped_fn_leftctrl_keys);
-- 
2.25.1

