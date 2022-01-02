Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D426482C4F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiABRFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiABRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:04:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17814C061761;
        Sun,  2 Jan 2022 09:04:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l4so20220070wmq.3;
        Sun, 02 Jan 2022 09:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3boBvFJeKQxpTMzKTlBE3Vnj/eOP88tQipRCfi3Teg=;
        b=d0iokJiEd40r0UmcUsVrnhkvwIa0OfS7C/AzULxKac7BTk///7pEJvxXoMcDSSVNQM
         eJOq0ad7oRzeQLkZzZFMjw/y5dnJizyJThsdjSuWUQIO5Cb4sMYjFCRpAd9aMvCakhoW
         ntN2nbiDizuNgwJy3FMdVYoMgIjy06+AqyWRFu0GgyETzhR56xVF78Xt4TxXXDLK1aOj
         QD+IG91UJwLNpwH9EQWj86wR8lWzzvyIHEFh/s/4WwwF027GW8sLEeXNGvGBS9cHAHcm
         cXL6VVE/CdJM+vouA/OpdbSeML0mOmnaWNDkAkK8pRWVE5I0cRprS50rHaDMHFbsCqAW
         gpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3boBvFJeKQxpTMzKTlBE3Vnj/eOP88tQipRCfi3Teg=;
        b=NFYWoe6AhKRw1GBxvyJ0w8diPjMiR2l/qYtM6UWR6oKXfMEBXzyeEU56H66ulzEdpZ
         +vnBhHLKXKXXjy4oeLO2n/SJ8I+psL1zm+aZUUjKfKviqkHq8tRq59ZUvKyP08Bx64rc
         /50Gt2OpWaJV/tCvbWM2k5xEL57Gv57CwaLoHE061E6FzjmroBu+SAdniHLUrUuqS3o1
         8lhYP1vFmdff0M/ErPmtxBsW3Fu9VN+BxuNESr+w0IZZ5J0zmRHn8vwMQN/8QF4zNEpL
         /rxRXfgbyVTbKeWqLLDrGmdkPHIcvkquMeBfqJq7wE3LGpwWhZGUYoP1PieaJjuGeIdY
         6L1g==
X-Gm-Message-State: AOAM532TJeGh+AwVlq/g2OmqwN0Q7V0r+ZoH8aoIl8XYRRmWdst1XayF
        vQ/JBM9K5kc9CW8DZoKTPQo=
X-Google-Smtp-Source: ABdhPJwe83dtZDpqhiUjphmosusV20Q9sphZnCUgQZkrgjYoPzxYNyJHYEUsSv+8IbGLEdYj3LidXQ==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr35880616wmc.92.1641143096585;
        Sun, 02 Jan 2022 09:04:56 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id a204sm34869172wmd.39.2022.01.02.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:04:56 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexhenrie24@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/1] HID: apple: Report Magic Keyboard 2021 with fingerprint reader battery over USB
Date:   Sun,  2 Jan 2022 18:04:47 +0100
Message-Id: <20220102170447.159959-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220102170447.159959-1-jose.exposito89@gmail.com>
References: <20220102170447.159959-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 drivers/hid/hid-apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index e40cd17c7f40..8054a130fc91 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -723,11 +723,11 @@ static const struct hid_device_id apple_devices[] = {
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

