Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7553735D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 03:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiE3Bma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 21:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiE3Bm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 21:42:28 -0400
Received: from mail.boiledscript.com (unknown [192.151.158.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961FFD13E;
        Sun, 29 May 2022 18:42:27 -0700 (PDT)
Received: from localhost (unknown [192.168.203.1])
        by mail.boiledscript.com (Postfix) with ESMTP id B13113007FD;
        Mon, 30 May 2022 01:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultrarare.space;
        s=dkim; t=1653874946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbjr5jPtIZSbFT/L4XEbOX84sdmNhtUofdql/o6UFQ0=;
        b=E6cE1dB2AdRfJGrHJgwwxdTw23Z8WYHbocs68f/xpOncS8ffoXaS/sOd4kn+Fvk0zjqWuK
        zLqbBS7b+Q3f3tutpBNMbqUg3qvs6Rzyk1bcSj9bxRjTAAzrm+Z3jATaqNh9nVJ4nUpU4u
        34BXvpP6Xou+9acQ4tkoLhmySqvodTZkw95QAJakjENkZU3oyutP5Fdyf+NutxTEOCmIHC
        w8jz7itwL0U5z+syuEy4qY+hudV5LYbpjp8FDsarBoxuCak9FGpBlkLGIWTS4le3YM/9Nr
        dxNQsgp7BEFILsMkfGd3PVvdWHu5QJkwuX3n0fp+QG44oFsLZnKovzHMYY0eYw==
Date:   Mon, 30 May 2022 09:42:15 +0800
From:   Hilton Chain <hako@ultrarare.space>
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     bryancain3@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH] HID: apple: Properly handle function keys on misset
 non-apple keyboards
Message-ID: <20220530094215.646432cd@ultrarare.space>
In-Reply-To: <20220530083752.1973a905@ultrarare.space>
References: <20220529180230.17e9a0f9@ultrarare.space>
        <20220529182036.10226-1-jose.exposito89@gmail.com>
        <20220530083752.1973a905@ultrarare.space>
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
keys on Keychron keyboards") to support all misset non-apple keyboards.

Signed-off-by: Hilton Chain <hako@ultrarare.space>
---

 drivers/hid/hid-apple.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 42a568902f49..3b15753be467 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -36,7 +36,7 @@
 #define APPLE_NUMLOCK_EMULATION	BIT(8)
 #define APPLE_RDESC_BATTERY	BIT(9)
 #define APPLE_BACKLIGHT_CTL	BIT(10)
-#define APPLE_IS_KEYCHRON	BIT(11)
+#define APPLE_IS_BAD_APPLE	BIT(11)

 #define APPLE_FLAG_FKEY		0x01

@@ -363,7 +363,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}

 	if (fnmode == 3) {
-		real_fnmode = (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1;
+		real_fnmode = (asc->quirks & APPLE_IS_BAD_APPLE) ? 2 : 1;
 	} else {
 		real_fnmode = fnmode;
 	}
@@ -669,9 +669,9 @@ static int apple_input_configured(struct hid_device *hdev,
 		asc->quirks &= ~APPLE_HAS_FN;
 	}

-	if (strncmp(hdev->name, "Keychron", 8) == 0) {
-		hid_info(hdev, "Keychron keyboard detected; function keys will default to fnmode=2 behavior\n");
-		asc->quirks |= APPLE_IS_KEYCHRON;
+	if (strncmp(hdev->name, "Apple", 5)) {
+		hid_info(hdev, "Non-apple keyboard detected; function keys will default to fnmode=2 behavior\n");
+		asc->quirks |= APPLE_IS_BAD_APPLE;
 	}

 	return 0;

base-commit: b00ed48bb0a7c295facf9036135a573a5cdbe7de
--
2.36.1
