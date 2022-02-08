Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EABB4AE192
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385578AbiBHSzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385551AbiBHSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:55:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5A9C0612C0;
        Tue,  8 Feb 2022 10:55:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r7so12891811wmq.5;
        Tue, 08 Feb 2022 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2rLFrwGSf/fjUuAvUVyqkzahpLoS6qof5NPWyop7JA=;
        b=EK3T3ZR1A7H31bUygylx4Ud9sCiarT3y28W/L+LJ7Q2Z8G3xmKezXiw/q9adC1ar4i
         PRnlYBsJrSSwSAExNZkYsQ+1TYLC+vWf9wo2aLAc+OSbtN3+z8znofX7nmWwdiUlEA1c
         p3VnU7ENuGTTwEQ25sQZ5R3LlIAf9udJr4YAoTSffFGUWGwG8MDav4aqv9csrZ38uRLZ
         oCchCrOEqf+jb50ezwbdxdTmlobOkW9rsy5+RHORovdwzpocRiFmqc/ki44CU8cHjJ40
         jbpwMGzt9GHw8Q/yGzPoSuDIHZeLhEOU4thfyaoEL1aPaY+6U92nL1mCLCGdJVBeOxg1
         lVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2rLFrwGSf/fjUuAvUVyqkzahpLoS6qof5NPWyop7JA=;
        b=iq8G4XIwNifhsbeZOV8DTgb1QAAreyCiNWPHXb8lqsgFWURp9+WrB1JVemvMO/zYDt
         m5S70cYmt5Gw8Aa/7e/Qfim66IWVVu8JknW2NuVF+U5TNoN8d5mUY7OejTR6uIuAUPov
         B39VhPwDsN3+7WHZkCo/crQCoQl4Eh05NCYl5k55V81JZZIz0ljk/d2z6BcNl3Zsq/CX
         PqMdBw4qrOAge1/Z0/I5Oly+SiDQjjxNOc2n3b3TKQY/yV8+tcUL5/DirmIX3b4lXGCX
         35EacApmTTxnzLOcLKcYnqVOeh9HiA5SOUUYhwyPl2DBHDfJu0Rcsl9ZIdJBa3D95O8s
         5pcw==
X-Gm-Message-State: AOAM530BdrOXyS6bwHB8xT2gLQQVXs5D9UZTgHF4G+J9aZe3he+e5H6H
        tvFUnpneVtyxmhghQjweYLI=
X-Google-Smtp-Source: ABdhPJy+NGsLX5KnwKNlbDgAb6Z0yHzKcjQnt/ojyVP35AQc8/ANOmzJAIjSf9RSIaEAtI8uEhhBiA==
X-Received: by 2002:a05:600c:3552:: with SMTP id i18mr2256601wmq.21.1644346535282;
        Tue, 08 Feb 2022 10:55:35 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id w6sm11897613wrp.51.2022.02.08.10.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:55:35 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2] HID: apple: Report Magic Keyboard 2021 with fingerprint reader battery over USB
Date:   Tue,  8 Feb 2022 19:55:30 +0100
Message-Id: <20220208185530.51690-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Like the Apple Magic Keyboard 2015, when connected over USB, the 2021
version with fingerprint reader registers 2 different interfaces. One of
them is used to report the battery level.

However, unlike when connected over Bluetooth, the battery level is not
reported automatically and it is required to fetch it manually.

Add the APPLE_RDESC_BATTERY quirk to fix the battery report descriptor
and manually fetch the battery level.

Tested with the ANSI variant of the keyboard with and without numpad.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Rebased on master, it was for-next
---
 drivers/hid/hid-apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 24802a4a636e..5117d354af18 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -752,11 +752,11 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
-		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021),
-		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 
-- 
2.25.1

