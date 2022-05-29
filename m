Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB88537084
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 12:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiE2KMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 06:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE2KMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 06:12:06 -0400
X-Greylist: delayed 533 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 May 2022 03:12:02 PDT
Received: from mail.boiledscript.com (unknown [192.151.158.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0938425C47;
        Sun, 29 May 2022 03:12:02 -0700 (PDT)
Date:   Sun, 29 May 2022 18:02:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultrarare.space;
        s=dkim; t=1653818579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jjq1DAlPmCj+12oFmUYPRHLaYrupTtjphtRxoBdBCnw=;
        b=sKl9nspg5/4kfLQj7l2aFAAkdPdc7wlvjLRpsOr0mfO1F5G0hSdMUvZdpz0uxYNR7dYRcO
        /Sb0OldzsAHdEwZLD8amFjSjEph4L6PPE5E1lz7rU6bnN/Ywv1zwyOIqBC2Lu7Qq9reeEv
        54M/bSEqRngT4A7MtoUDehlPY5vgEFckWSJ9VTckmOp539a4mVtVCc7J9U9PEC+eFUy5m4
        fAwYLY5Gbn4ib2epSWk3CC7EUpDs6uJ+vnxdNLyEP9mpNU+FTxF0Bm2aWFdGIBjGLEcNG8
        CTmBbuEG57CjsSBVP+XXP15vKNlbSl95xygJ7R2fZdipA8jZBotbQ2T7H4J5hQ==
From:   Hilton Chain <hako@ultrarare.space>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: apple: Reset quirks when Fn key is not found
Message-ID: <20220529180230.17e9a0f9@ultrarare.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Authentication-Results: mail.boiledscript.com;
        auth=pass smtp.mailfrom=hako@ultrarare.space
X-Spamd-Bar: /
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=46rom 6813a0a2c0f1a965f650abba3e1e4a8e79b40c26 Mon Sep 17 00:00:00 2001
From: Hilton Chain <hako@ultrarare.space>
Date: Sun, 29 May 2022 16:25:57 +0800
Subject: [PATCH] HID: apple: Reset quirks when Fn key is not found

Commit a5fe7864d8ad ("HID: apple: Do not reset quirks when the Fn key is
not found") re-involves the fnmode issue fixed in commit a5d81646fa29
("HID: apple: Disable Fn-key key-re-mapping on clone keyboards"), as linked
below.

To make things work again, this commit reverts a5fe7864d8ad ("HID: apple:
Do not reset quirks when the Fn key is not found")  and the recent
workaround fa33382c7f74 ("HID: apple: Properly handle function keys on
Keychron keyboards")

Link: https://lore.kernel.org/linux-input/f82dd7a1-a5c6-b651-846c-29f6df943=
6af@redhat.com/
Fixes: a5fe7864d8ad ("HID: apple: Do not reset quirks when the Fn key is no=
t found")
Signed-off-by: Hilton Chain <hako@ultrarare.space>
---
 drivers/hid/hid-apple.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 42a568902f49..3b666dcb63f0 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -21,7 +21,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
-#include <linux/string.h>
=20
 #include "hid-ids.h"
=20
@@ -36,17 +35,16 @@
 #define APPLE_NUMLOCK_EMULATION	BIT(8)
 #define APPLE_RDESC_BATTERY	BIT(9)
 #define APPLE_BACKLIGHT_CTL	BIT(10)
-#define APPLE_IS_KEYCHRON	BIT(11)
=20
 #define APPLE_FLAG_FKEY		0x01
=20
 #define HID_COUNTRY_INTERNATIONAL_ISO	13
 #define APPLE_BATTERY_TIMEOUT_MS	60000
=20
-static unsigned int fnmode =3D 3;
+static unsigned int fnmode =3D 1;
 module_param(fnmode, uint, 0644);
 MODULE_PARM_DESC(fnmode, "Mode of fn key on Apple keyboards (0 =3D disable=
d, "
-		"1 =3D fkeyslast, 2 =3D fkeysfirst, [3] =3D auto)");
+		"[1] =3D fkeyslast, 2 =3D fkeysfirst)");
=20
 static int iso_layout =3D -1;
 module_param(iso_layout, int, 0644);
@@ -351,7 +349,6 @@ static int hidinput_apple_event(struct hid_device *hid,=
 struct input_dev *input,
 	const struct apple_key_translation *trans, *table;
 	bool do_translate;
 	u16 code =3D 0;
-	unsigned int real_fnmode;
=20
 	u16 fn_keycode =3D (swap_fn_leftctrl) ? (KEY_LEFTCTRL) : (KEY_FN);
=20
@@ -362,13 +359,7 @@ static int hidinput_apple_event(struct hid_device *hid=
, struct input_dev *input,
 		return 1;
 	}
=20
-	if (fnmode =3D=3D 3) {
-		real_fnmode =3D (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1;
-	} else {
-		real_fnmode =3D fnmode;
-	}
-
-	if (real_fnmode) {
+	if (fnmode) {
 		if (hid->product =3D=3D USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI ||
 		    hid->product =3D=3D USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO ||
 		    hid->product =3D=3D USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS ||
@@ -415,7 +406,7 @@ static int hidinput_apple_event(struct hid_device *hid,=
 struct input_dev *input,
=20
 			if (!code) {
 				if (trans->flags & APPLE_FLAG_FKEY) {
-					switch (real_fnmode) {
+					switch (fnmode) {
 					case 1:
 						do_translate =3D !asc->fn_on;
 						break;
@@ -664,14 +655,10 @@ static int apple_input_configured(struct hid_device *=
hdev,
 {
 	struct apple_sc *asc =3D hid_get_drvdata(hdev);
=20
+	/* Handling some non-Apple keyboards which use Apple's vendor ID */
 	if ((asc->quirks & APPLE_HAS_FN) && !asc->fn_found) {
 		hid_info(hdev, "Fn key not found (Apple Wireless Keyboard clone?), disab=
ling Fn key handling\n");
-		asc->quirks &=3D ~APPLE_HAS_FN;
-	}
-
-	if (strncmp(hdev->name, "Keychron", 8) =3D=3D 0) {
-		hid_info(hdev, "Keychron keyboard detected; function keys will default t=
o fnmode=3D2 behavior\n");
-		asc->quirks |=3D APPLE_IS_KEYCHRON;
+		asc->quirks =3D 0;
 	}
=20
 	return 0;

base-commit: fdaf9a5840acaab18694a19e0eb0aa51162eeeed
--=20
2.36.1

