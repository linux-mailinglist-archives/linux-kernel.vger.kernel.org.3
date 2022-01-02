Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FD3482C79
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiABRv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiABRvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:51:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2426DC061761;
        Sun,  2 Jan 2022 09:51:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso17269023wme.1;
        Sun, 02 Jan 2022 09:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zzy9y85HyG7JaH8HDrxcZsH9CJ6yKFB5eKEzJ6d5Urk=;
        b=RwmO2g5qI1hxzJD0dUCg150QhbTav3oOkUAFSCOAxpaCYZE1uqBaUFUZ99NHpD/6Vq
         A1nwMnntMr58WYhLKJVBqK1YqwNjukbDcyeF1zzH4USkk6hlLef/njvTsiypFqO1BaK9
         xcX3WevoLQFZG6mAqxplsFdAjP8FKlk8XqaNxg2ZVr+cpm/sige0MFpc2kY9/V0iZg3G
         QhjUgNkW1725+nsgdF95G2o9PeFnqQ3wCU5yWVJOcSfs3WGW/0sxt+Kpj94lZgXQyGnu
         VatCJ3FtvreH+2v9xCNIlG9nZZ8Fli1jw+zZimx/3kvXcpzBqHy1yzdQVIfS8EsK6/U8
         nytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zzy9y85HyG7JaH8HDrxcZsH9CJ6yKFB5eKEzJ6d5Urk=;
        b=OPP34x2nBNdwJ+i4XouLaGFkN2iGpKyv99ayf7JC921h3rRYLaRHmVW90WztafYHVu
         20sLiPoqBxNSBQLIJ1ZkoHbFLnJlOy4fjzg4wYvqhiEoVI5kbEQQMRLYVbvKafpWZjkF
         XE0NxIKXjGvDM+yc34UmgicZV6kVu1cflXQZd0UKuNGI4Vq/5+BvtaErQroQj00Zs6H7
         NQBr04wx4u9aWUCKoHC64iCmALdB8zknrqyqo/IGafJs1oc8l3tSK6zd7I3XzO5uDw2k
         rxx8NtjJVeWPreUYMITxZ8eyXDC2fMp+UYX+kThfz7Qh+4LdyaiupVBtZyg4A5D9kXTl
         gDfw==
X-Gm-Message-State: AOAM533dfZtsmqwUpmpcDhvxWT3zF/jXJxRrwE50hkxG4sjj3JzCICZF
        NDZ9nqM9UQRvfECbHcXXzV8=
X-Google-Smtp-Source: ABdhPJz5bquYoy/p0MGCGTUdpd6ZPxDa4lKs08QG4eu6JprXq3z28OywElLNxUahvG4TF2aGWSyuRQ==
X-Received: by 2002:a05:600c:4fcd:: with SMTP id o13mr33109520wmq.142.1641145881779;
        Sun, 02 Jan 2022 09:51:21 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id l17sm22564593wms.24.2022.01.02.09.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:51:21 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexhenrie24@gmail.com,
        bberg@redhat.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/1] HID: apple: Add Magic Keyboard 2021 with fingerprint reader FN key mapping
Date:   Sun,  2 Jan 2022 18:51:13 +0100
Message-Id: <20220102175113.174642-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220102175113.174642-1-jose.exposito89@gmail.com>
References: <20220102175113.174642-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the function key table introduced for the Magic Keyboard 2021
without fingerprint reader in the models with fingerprint reader and/or
numpad.

Tested with the ANSI variant of the keyboard with and without numpad.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-apple.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 8fcbac7f50ce..24802a4a636e 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -242,7 +242,9 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}
 
 	if (fnmode) {
-		if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021)
+		if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021 ||
+		    hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021 ||
+		    hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021)
 			table = apple2021_fn_keys;
 		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
-- 
2.25.1

