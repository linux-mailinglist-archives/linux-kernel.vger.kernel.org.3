Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B32539332
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345269AbiEaOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244389AbiEaOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:33:46 -0400
Received: from mail.boiledscript.com (unknown [192.151.158.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921583B574;
        Tue, 31 May 2022 07:33:45 -0700 (PDT)
Received: from localhost (unknown [192.168.203.1])
        by mail.boiledscript.com (Postfix) with ESMTP id EEB8C300A0B;
        Tue, 31 May 2022 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultrarare.space;
        s=dkim; t=1654007624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WeyBJFxfzhp6yVpjOleBwXM4j2bOSsmFV0MaQsQ8qHo=;
        b=YXuIG7y2FUa0CFSBfxStiTJOU2Cq4t+F2LzfScfeNU0rqkygF9+L4ooRjbhCXzH6C21edz
        oD2gO+525vU715u1cKNnO7r7SEtEMDFuo4qenbGaIq0VPSE5TEaJ8A1qMOpxn6elIuicP8
        9a0xtNYwUJdM1CsLjApXzFUX8GHnp8kLMBi01ZlneZCZJLysN2TYYBaDShSkfyUa9VaiTv
        LuqtyHeNxB+7fRqKTSq3aNONl+xjaycoDr/ULz6JyMbOf4XH6d/7iOK6gJT/z1vxS9zEWH
        ON+n993qIDeJxcJqjZJDDCI06Ge7MaUfJW540A36asYIIX2nOelzwCOXjFmS7g==
Date:   Tue, 31 May 2022 22:33:30 +0800
From:   Hilton Chain <hako@ultrarare.space>
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     bryancain3@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2] HID: apple: Workaround for non-Apple keyboards
Message-ID: <20220531223330.3d63e2fe@ultrarare.space>
In-Reply-To: <20220531221102.7bd7da7d@ultrarare.space>
References: <20220529180230.17e9a0f9@ultrarare.space>
        <20220529182036.10226-1-jose.exposito89@gmail.com>
        <20220530083752.1973a905@ultrarare.space>
        <20220530061812.GA10391@elementary>
        <20220531221102.7bd7da7d@ultrarare.space>
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

There's a bunch of non-Apple keyboard misuses Apple's vendor and product
id, causing hid_apple to be served for them. However they can't handle the
default fnmode.

This commit adds an array of non-Apple keyboards' device names, together
with a function apple_is_non_apple_keyboard() to identify and create
exception for them.

Signed-off-by: Hilton Chain <hako@ultrarare.space>
---
 drivers/hid/hid-apple.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 42a568902f49..4429b25ae3d8 100644
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
@@ -313,6 +317,29 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
 	{ }
 };
 
+static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
+	{ "SONiX USB DEVICE" },
+	{ "Keychron" },
+	{ }
+};
+
+static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
+{
+	unsigned long i;
+	unsigned long non_apple_total = sizeof(non_apple_keyboards) /
+					sizeof(struct apple_non_apple_keyboard);
+
+	for (i = 0; i < non_apple_total; i++) {
+		char *non_apple = non_apple_keyboards[i].name;
+
+		if (non_apple && strlen(non_apple) &&
+				strncmp(hdev->name, non_apple, strlen(non_apple)) == 0)
+			return true;
+	}
+
+	return false;
+}
+
 static inline void apple_setup_key_translation(struct input_dev *input,
 		const struct apple_key_translation *table)
 {
@@ -363,7 +390,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}
 
 	if (fnmode == 3) {
-		real_fnmode = (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1;
+		real_fnmode = (asc->quirks & APPLE_IS_NON_APPLE) ? 2 : 1;
 	} else {
 		real_fnmode = fnmode;
 	}
@@ -667,11 +694,12 @@ static int apple_input_configured(struct hid_device *hdev,
 	if ((asc->quirks & APPLE_HAS_FN) && !asc->fn_found) {
 		hid_info(hdev, "Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling\n");
 		asc->quirks &= ~APPLE_HAS_FN;
-	}
 
-	if (strncmp(hdev->name, "Keychron", 8) == 0) {
-		hid_info(hdev, "Keychron keyboard detected; function keys will default to fnmode=2 behavior\n");
-		asc->quirks |= APPLE_IS_KEYCHRON;
+		if (apple_is_non_apple_keyboard(hdev)) {
+			hid_info(hdev,
+				"Non-apple keyboard detected; function keys will default to fnmode=2 behavior\n");
+			asc->quirks |= APPLE_IS_NON_APPLE;
+		}
 	}
 
 	return 0;

base-commit: 8ab2afa23bd197df47819a87f0265c0ac95c5b6a
-- 
2.36.1

