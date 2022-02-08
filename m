Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503AE4ADFDF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383604AbiBHRsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiBHRsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:48:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9FC061576;
        Tue,  8 Feb 2022 09:48:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso1715191wme.5;
        Tue, 08 Feb 2022 09:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMfYT83zSUK7mpqLA4dZ2kmw3QdtLZi19QJaATNiud4=;
        b=b0UlYiJb+n9a3ESGEh2FQ41DHdlGNRN0IrEs1bZOqwA8HUraLDGQLQHM8Jow8C8gDT
         u8mgcDg7mmSy0EgofReFnROAT4HmWOjypA+0yG8tPoo5cZUe15Ue3hY+HylkzlIaFWRQ
         DM228zSOja0hyQ2P4tHRaiGJ+ZTjPOQnq4aON9Dv9XfurOgn2D4JMhMz+E7QqIvEqzPn
         Bae4EmBm2nWetNLmRuTxpf7L06luDOBVG2tcs+0e1YhbZi8WFIfGyItTLnAIoLTAN6jY
         7MtbuhdPRQ3/EHGeKHm0xCBvKKD1VnB8Laiv/YnDCxrSDcGAkjLExzy5xUHQW0jVhbHB
         DKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMfYT83zSUK7mpqLA4dZ2kmw3QdtLZi19QJaATNiud4=;
        b=1rjuK5oSfUrHC+CrY6j8yc+JIhNoXE66Jz74mPIG42vG3Xh49P4ZfDATmJBS38AGZj
         +rhVFPVAQofeAbMW0dSRW4Jv8ajfzjDLII7W5KZax9GFIH+yJeAnl3q1RxYzwn0MALdh
         TL+ddvmEjZBe9PSb9mWjOD91/gKNK1kg7ZFGcAsoDkp0BqJYi8kTcp4M7b4Xsi4kyj7r
         H0GOhJBr1hbVYlbsRr7KQwhyCzSDZA6NkX+BdU/Q6plcJFjtWu6bzP7qzD3rV5b6wR3H
         FrotBChb3iShG3OjkceBUsbIzk02jBeSAV7n9EgpsSd7BPpdiSYbDFHAMifyVkVElnBT
         yHYQ==
X-Gm-Message-State: AOAM5329+gr6L4FZTXc29hsVLG5N/g843T3M88VSiuVvYwB2xeZ1ipjQ
        LY92UUYiL2hMPaMuGMICfIg=
X-Google-Smtp-Source: ABdhPJyefCwGQxbs2MR2QmOb9dPMLVj8yskEcFolWeHZ/WLvicpIihMCF18HtuZnXCUuctgaV2o1Kw==
X-Received: by 2002:a05:600c:3ca5:: with SMTP id bg37mr1997746wmb.193.1644342500814;
        Tue, 08 Feb 2022 09:48:20 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id i2sm3467744wmq.23.2022.02.08.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:48:20 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH RESEND v3] Input: clear BTN_RIGHT/MIDDLE on buttonpads
Date:   Tue,  8 Feb 2022 18:48:06 +0100
Message-Id: <20220208174806.17183-1-jose.exposito89@gmail.com>
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

Buttonpads are expected to map the INPUT_PROP_BUTTONPAD property bit
and the BTN_LEFT key bit.

As explained in the specification, where a device has a button type
value of 0 (click-pad) or 1 (pressure-pad) there should not be
discrete buttons:
https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report

However, some drivers map the BTN_RIGHT and/or BTN_MIDDLE key bits even
though the device is a buttonpad and therefore does not have those
buttons.

This behavior has forced userspace applications like libinput to
implement different workarounds and quirks to detect buttonpads and
offer to the user the right set of features and configuration options.
For more information:
https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/726

In order to avoid this issue clear the BTN_RIGHT and BTN_MIDDLE key
bits when the input device is register if the INPUT_PROP_BUTTONPAD
property bit is set.

Notice that this change will not affect udev because it does not check
for buttons. See systemd/src/udev/udev-builtin-input_id.c.

List of known affected hardware:

 - Chuwi AeroBook Plus
 - Chuwi Gemibook
 - Framework Laptop
 - GPD Win Max
 - Huawei MateBook 2020
 - Prestigio Smartbook 141 C2
 - Purism Librem 14v1
 - StarLite Mk II   - AMI firmware
 - StarLite Mk II   - Coreboot firmware
 - StarLite Mk III  - AMI firmware
 - StarLite Mk III  - Coreboot firmware
 - StarLabTop Mk IV - AMI firmware
 - StarLabTop Mk IV - Coreboot firmware
 - StarBook Mk V

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v3:

 - Clear BTN_RIGHT/MIDDLE on input_register_device
   (Thanks to Dmitry Torokhov for pointing me in this direction)

 - Add acked-by tags (thanks to Peter, Benjamin and Jiří)
---
 drivers/input/input.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index ccaeb2426385..c3139bc2aa0d 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2285,6 +2285,12 @@ int input_register_device(struct input_dev *dev)
 	/* KEY_RESERVED is not supposed to be transmitted to userspace. */
 	__clear_bit(KEY_RESERVED, dev->keybit);
 
+	/* Buttonpads should not map BTN_RIGHT and/or BTN_MIDDLE. */
+	if (test_bit(INPUT_PROP_BUTTONPAD, dev->propbit)) {
+		__clear_bit(BTN_RIGHT, dev->keybit);
+		__clear_bit(BTN_MIDDLE, dev->keybit);
+	}
+
 	/* Make sure that bitmasks not mentioned in dev->evbit are clean. */
 	input_cleanse_bitmasks(dev);
 
-- 
2.25.1

