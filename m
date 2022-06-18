Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A37550562
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiFRODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiFRNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 09:55:50 -0400
Received: from mail.boiledscript.com (unknown [192.151.158.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1AE6B;
        Sat, 18 Jun 2022 06:55:48 -0700 (PDT)
Date:   Sat, 18 Jun 2022 21:51:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultrarare.space;
        s=dkim; t=1655560545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Kv5mC6jQ5gTh6n1bufpeX0V6kjPD+1etBWuVflNyfk=;
        b=bnkkphdtYtVlXd+hDZKYOaxkpj17lDM+3nS4y49ALbXsVLb/LGd+ayIFXcSWD5UF06vpz2
        YqfQU6G3MhQGQQrlo3+9rh5CKktamrPOkhvDtyLmg8Q26bLRBF64859g73GJvdz/oxkZUh
        znRLLZeI0JoenhC7g4E1urxvn+eJmhqoXPO/SkS8Hz9/i6c5W0tPR23+0aKRdXBFiFRHhI
        mX0krbeDYp8u1YCsrlP+9WkwvSmgm58nOpe9sAuOHnSZ3Czt69MYk42lKXhUFTSWhqOTVl
        +jDgtQmOJV+YpbbyiNRbX23CUVoxOavw+cBsQf8PnnzgMVAngqrDE6q80fEpIA==
From:   Hilton Chain <hako@ultrarare.space>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Bryan Cain <bryancain3@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v6] HID: apple: Properly handle function keys on non-Apple 
 keyboard
Message-ID: <20220618214603.24bf8828@dorphine>
In-Reply-To: <nycvar.YFH.7.76.2206081154160.10851@cbobk.fhfr.pm>
References: <20220529182036.10226-1-jose.exposito89@gmail.com>
 <20220530083752.1973a905@ultrarare.space>
 <20220530061812.GA10391@elementary>
 <20220531221102.7bd7da7d@ultrarare.space>
 <20220531223330.3d63e2fe@ultrarare.space>
 <20220531172053.GA10651@elementary>
 <CAPnXWxG8gbe1arQK9kBtwM1Xcta+wreTN742kgtBBr1v0ewKug@mail.gmail.com>
 <7f67ac07b8bd37d5817cd151674cc6b0@ultrarare.space>
 <20220601072651.242ce08a@ultrarare.space>
 <20220601121737.1226ffea@ultrarare.space>
 <20220601174956.GA10418@elementary>
 <20220602161219.152be32d@ultrarare.space>
 <nycvar.YFH.7.76.2206081154160.10851@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +
Authentication-Results: mail.boiledscript.com;
        auth=pass smtp.mailfrom=hako@ultrarare.space
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit extends fa33382c7f74 ("HID: apple: Properly handle function
keys on Keychron keyboards") by adding an array of known non-Apple
keyboards' device names, and the function apple_is_non_apple_keyboard()
to identify and create exception for them.

Signed-off-by: Hilton Chain <hako@ultrarare.space>
---

V5 -> V6: Add "GANSS" to the exception list.

I just found out my keyboard would use another name in bluetooth mode, as I
forgot to test this scenario... Sorry for the inconvenience!


drivers/hid/hid-apple.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 42a568902f492..3cf8eafe00b7b 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -36,7 +36,7 @@
 #define APPLE_NUMLOCK_EMULATION	BIT(8)
 #define APPLE_RDESC_BATTERY	BIT(9)
 #define APPLE_BACKLIGHT_CTL	BIT(10)
-#define APPLE_IS_KEYCHRON	BIT(11)
+#define APPLE_IS_NON_APPLE	BIT(11)

 #define APPLE_FLAG_FKEY		0x01

@@ -65,6 +65,10 @@ MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and left Control keys. "
 		"(For people who want to keep PC keyboard muscle memory. "
 		"[0] = as-is, Mac layout, 1 = swapped, PC layout)");

+struct apple_non_apple_keyboard {
+	char *name;
+};
+
 struct apple_sc_backlight {
 	struct led_classdev cdev;
 	struct hid_device *hdev;
@@ -313,6 +317,27 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
 	{ }
 };

+static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
+	{ "SONiX USB DEVICE" },
+	{ "GANSS" },
+	{ "Keychron" },
+	{ "AONE" }
+};
+
+static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
+		char *non_apple = non_apple_keyboards[i].name;
+
+		if (strncmp(hdev->name, non_apple, strlen(non_apple)) == 0)
+			return true;
+	}
+
+	return false;
+}
+
 static inline void apple_setup_key_translation(struct input_dev *input,
 		const struct apple_key_translation *table)
 {
@@ -363,7 +388,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}

 	if (fnmode == 3) {
-		real_fnmode = (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1;
+		real_fnmode = (asc->quirks & APPLE_IS_NON_APPLE) ? 2 : 1;
 	} else {
 		real_fnmode = fnmode;
 	}
@@ -669,9 +694,9 @@ static int apple_input_configured(struct hid_device *hdev,
 		asc->quirks &= ~APPLE_HAS_FN;
 	}

-	if (strncmp(hdev->name, "Keychron", 8) == 0) {
-		hid_info(hdev, "Keychron keyboard detected; function keys will default to fnmode=2 behavior\n");
-		asc->quirks |= APPLE_IS_KEYCHRON;
+	if (apple_is_non_apple_keyboard(hdev)) {
+		hid_info(hdev, "Non-apple keyboard detected; function keys will default to fnmode=2 behavior\n");
+		asc->quirks |= APPLE_IS_NON_APPLE;
 	}

 	return 0;

base-commit: 4b35035bcf80ddb47c0112c4fbd84a63a2836a18
--
2.36.1
