Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B888539A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348675AbiEaX1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbiEaX1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:27:07 -0400
Received: from mail.boiledscript.com (unknown [192.151.158.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E73CDF8A;
        Tue, 31 May 2022 16:27:06 -0700 (PDT)
Received: from localhost (unknown [192.168.203.1])
        by mail.boiledscript.com (Postfix) with ESMTP id 6FAB33007FD;
        Tue, 31 May 2022 23:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultrarare.space;
        s=dkim; t=1654039623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJRtg2zH4bC6btK95Gjxl5mQyLjSrymJmT3J7j8Daa4=;
        b=S8fssuc9UwKiKp5PxdugfR1eKDGTxNvE/jbgJEwZmhJobPxAxsHpkHv08rrMmLyS+GyLpB
        6hRRdp1dukBGzBb5ZLJRxVQpvXLULKNr+ZC6/ptkuBlQnIuqYf3R1y9NTZlNtlNFhQd4Ja
        WM4rchERlATD2S/VL8VJDhqPLo2I6FmgQRpObGv5ln8dv6I5wi2Ekec0iIoCsTuGIqjsWj
        fOVkDEN+MgmLXySxqaUxFp6MtoQ1AdfDJ8NafeXhQru0Meh14/+pI6eHixoVLcBp009My0
        PHlh/AMpnYPqScm7fplqqIjMKOnnJe7bFG3FODYNIju/2Gi+vrTOpRE9okUvEQ==
Date:   Wed, 1 Jun 2022 07:26:51 +0800
From:   Hilton Chain <hako@ultrarare.space>
To:     "=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?=" <jose.exposito89@gmail.com>
Cc:     "Bryan Cain" <bryancain3@gmail.com>,
        "Jiri Kosina" <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v3] HID: apple: Properly handle function keys on non-Apple
 keyboard
Message-ID: <20220601072651.242ce08a@ultrarare.space>
In-Reply-To: <7f67ac07b8bd37d5817cd151674cc6b0@ultrarare.space>
References: <20220529180230.17e9a0f9@ultrarare.space>
        <20220529182036.10226-1-jose.exposito89@gmail.com>
        <20220530083752.1973a905@ultrarare.space>
        <20220530061812.GA10391@elementary>
        <20220531221102.7bd7da7d@ultrarare.space>
        <20220531223330.3d63e2fe@ultrarare.space>
        <20220531172053.GA10651@elementary>
        <CAPnXWxG8gbe1arQK9kBtwM1Xcta+wreTN742kgtBBr1v0ewKug@mail.gmail.com>
        <7f67ac07b8bd37d5817cd151674cc6b0@ultrarare.space>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +
Authentication-Results: mail.boiledscript.com;
        none
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
 drivers/hid/hid-apple.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 42a568902f49..7d56530d9e3a 100644
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
@@ -313,6 +317,25 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
 	{ }
 };
 
+static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
+	{ "SONiX USB DEVICE" },
+	{ "Keychron" },
+};
+
+static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
+		char *non_apple = non_apple_keyboards[i].name;
+
+		if (strlen(non_apple) && strncmp(hdev->name, non_apple, strlen(non_apple)) == 0)
+			return true;
+	}
+
+	return false;
+}
+
 static inline void apple_setup_key_translation(struct input_dev *input,
 		const struct apple_key_translation *table)
 {
@@ -363,7 +386,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}
 
 	if (fnmode == 3) {
-		real_fnmode = (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1;
+		real_fnmode = (asc->quirks & APPLE_IS_NON_APPLE) ? 2 : 1;
 	} else {
 		real_fnmode = fnmode;
 	}
@@ -669,9 +692,9 @@ static int apple_input_configured(struct hid_device *hdev,
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

base-commit: e1cbc3b96a9974746b2a80c3a6c8a0f7eff7b1b5
-- 
2.36.1

