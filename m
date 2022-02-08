Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1295F4AE179
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385515AbiBHSuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbiBHSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:50:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB769C0613CB;
        Tue,  8 Feb 2022 10:50:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i15so50563wrb.3;
        Tue, 08 Feb 2022 10:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bW4/d1RmPrcFkBPFnS9TEkSFkwgeh0dGJKR1Tr/Tag=;
        b=gA8E/iaX8ZYazGtleR4LppT76qqFGqWeQMVCvagIzF9Bs1x2SnfR/OcI2cxB8uDGzx
         HbCcOPQNhAzMFwXdZDFbqpEZAbOTLVJc0JijlqBZwI5qVpeaAm2H5UOXRoO33KAQQ9xm
         STfhTCz7XcrevNkV1JNxkS6Foi1W1K42hNSVx0wE/xpE35t1IdJ9lO8Qt2eAEajeOAoX
         6TaGuUk+WlqVj7EoeflwW+easwYPITv3+L6pml7OFYFP8pM+8EpG5ER02wgz1/HhAefL
         l4EqLBZ/7BBlqWVWshV7ozHfwxHbuetCsVFAW4mytjGHctJLV0KZmxD+FRXGMC4WCxRH
         hmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bW4/d1RmPrcFkBPFnS9TEkSFkwgeh0dGJKR1Tr/Tag=;
        b=MRB8mwTGvuStsTPDDfftGVupLtFMqeM2t5qX9hxQ1D2CXy7aO7xp9v2hscGIikPS6g
         GoxQBZNtKBdLzRUFBLi4UKmoplMq66muzGXHkQgSgThtQOlpR1PJIA0usb2kE9CLERvy
         N7cBraxvzZ/vrB6vWi1ae6tpGBdS/atJ/fZyfiJXCMQPnfe6aOV7CxCDS/dkVNRTSC/M
         2Ye+2j3TCgGLlU+UAI+YrsYbxprXZSmAUkqB0cKZeiFsklIJeMrKYz+5chvzdY2rnd2L
         kdfVjBoUStm+HtnPFzIm3uukSoQPuuQ31KFfbVxH80BfoaOOtBmQ+zAdQNXHIWExrVR6
         7Ouw==
X-Gm-Message-State: AOAM533HaloaiYxYwMSSEOruUAjujSydUR33ESy8mfuvul20fSHdWOPL
        FObDXRBqCMsct5zaCaSOLu8=
X-Google-Smtp-Source: ABdhPJz45ZFJM/Fwd9aGG9iOwkXkrrtyioQdxXvuQ1/MTPwTjXGfU2eF5zizwbWX6o+YR4FVI+kUMg==
X-Received: by 2002:a5d:64ad:: with SMTP id m13mr4635534wrp.671.1644346214253;
        Tue, 08 Feb 2022 10:50:14 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id g20sm4242982wmq.9.2022.02.08.10.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:50:13 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2] HID: apple: Report Magic Keyboard 2021 battery over USB
Date:   Tue,  8 Feb 2022 19:50:09 +0100
Message-Id: <20220208185009.49100-1-jose.exposito89@gmail.com>
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
version registers 2 different interfaces. One of them is used to report
the battery level.

However, unlike when connected over Bluetooth, the battery level is not
reported automatically and it is required to fetch it manually.

Add the APPLE_RDESC_BATTERY quirk to fix the battery report descriptor
and manually fetch the battery level.

Tested with the ANSI, ISO and JIS variants of the keyboard.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Rebased on master, it was for-next
---
 drivers/hid/hid-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 24802a4a636e..ce88f8645155 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -748,7 +748,7 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
-		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
-- 
2.25.1

