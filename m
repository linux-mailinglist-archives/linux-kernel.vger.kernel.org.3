Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF464885A3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 20:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiAHTmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 14:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiAHTmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 14:42:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB5C06173F;
        Sat,  8 Jan 2022 11:42:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f189-20020a1c1fc6000000b00347ac5ccf6cso2817237wmf.3;
        Sat, 08 Jan 2022 11:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMfYT83zSUK7mpqLA4dZ2kmw3QdtLZi19QJaATNiud4=;
        b=ULSi6jw91Njz1zP2daocgobmsvnd4Lm5tC6ZTRb02LlNq2fvJR3E8RqhnR0nfnyUiV
         ZnyM+ZPFyZFLI4Yn4lM4SdgtM4oP8QW65LsJz+EqJrNpAUfSm1pvyB+oYUWQjmu6mavg
         K4TwHHrrYSyENINNhZSb0dS8wYc0XbHP/Dh83UBHt8CFXMGRf8f9zaTGesOsg7x6JM3t
         AR0yF+uCgqOYAw2cafrGAEblAvgKWu11O1bnIZrZxZvoML242Q/5Z6Ye3GPmOthtX6v+
         /CQr5tH0Y98ofNoDi5Q4KQ+iliXuduWwuRMCPIo9++V6IFwojQHDJpu5HRIWKFLykFgS
         K9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMfYT83zSUK7mpqLA4dZ2kmw3QdtLZi19QJaATNiud4=;
        b=h2jvnU5quVNnMgH/GaotAFoksbQCEFwWcMVUi5oz5dRG72gUMCyzU4zuvps0/1m3QN
         w6UpS6ZLIgIlAs/AptRDU10BQPl06Rp4uk+yibGqIb17RL2/7WQuFO8l+YRdRDQCUqXa
         SrHeaoDpUhqk/urFtQM3tqbGlCyDZDfYKNXvp6RHcZYQ6hFjHljvynJWlORuNiE3Kdg3
         igrEZVACuN5IA7h7atXgMsRW5qON5Na7hvqyZh65F1nyLOcJC1O0Peb3rGPPXYGzGeXN
         /J3dVznDcsRCXLCP2K02UfgCjFhynToWuHoDz9QeULY/U8M1HEnEjwCkYWJ9xmnNT8CB
         crLQ==
X-Gm-Message-State: AOAM531jLVHSh7NGWAOV9o0iLgjw5XUhF/x6zL7dd5OJk7NKqW7KZJg1
        8hfHHp2vX0C+W5QYYt4vZ+4=
X-Google-Smtp-Source: ABdhPJx6dYepHWnL90X0cTjzi5JB7xbgJ/4XkiKWpp3TTdZeKBMW3Mk6K/kDVA91p5f0QpTRS1iNeA==
X-Received: by 2002:a05:600c:214:: with SMTP id 20mr15615793wmi.84.1641670972270;
        Sat, 08 Jan 2022 11:42:52 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id s1sm1058815wrv.38.2022.01.08.11.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 11:42:51 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        peter.hutterer@who-t.net, roderick.colenbrander@sony.com,
        pali@kernel.org, rydberg@bitmath.org, nick@shmanahar.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH v3] Input: clear BTN_RIGHT/MIDDLE on buttonpads
Date:   Sat,  8 Jan 2022 20:42:35 +0100
Message-Id: <20220108194235.14401-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

