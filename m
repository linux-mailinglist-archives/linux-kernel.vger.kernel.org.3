Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B121482BD1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiABQOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiABQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:14:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F52C061761;
        Sun,  2 Jan 2022 08:14:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so17187912wmd.5;
        Sun, 02 Jan 2022 08:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8d4jk47oCuccILhlRc/9yaOfbV2sOOCkqDrRw8XhIk=;
        b=fwow5QyMuhID/lPGRQqs/X4A8XyFnDJhWUs9kfO6eSrft7sGpzNo8E1SDUMn7yg3D1
         hnIQaBBrrVzOsZu3xY3p35jWxCVLu1zUEhwBwerr5yZuVJ/PaHVdltnK/XAy1RKnxaaD
         Fbc3SsnXwsh5G+fwnCAGkJ02UQ8C72kYGJEkH8FB/50rwzggLslLpjMeAFr2efxlOBo6
         14QADD4KjcJ3SJWfGBRxIQEfvSjGxpoFTeng7TWuyLr/HR56n3w82iwSAtWuiqcaSDHu
         a5Csp5swUOqRjRY7N9VYl0r6vlZ+nWxe2+sWsCva3uRI6DjbVs5y/sY4J21eRtJn1FeM
         izmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8d4jk47oCuccILhlRc/9yaOfbV2sOOCkqDrRw8XhIk=;
        b=uUM/yh0U91KzqeObPP7FX2+k9gQZswR4GPVJmB+qkkKBiY0qiZJfVI7LklXSlqejgk
         P0txWzHIFEjlzewbso4BFPbHVGOx+yNT9vDqRBY8SHJXlGeI3JnREpJ4bPRvpbWzXuY7
         ewB1YBYlA5P8rMhWFc4x3INKaGrP55MZCgVVAYPIJC5ThoKmYQHz13f0HO4Ftcv006dQ
         9AMFzbTJSC5zwfh07CiVF7n+Oh4RztQ+7ZqN6GuttnUSf/wWvF5o1Dn2NDzZy7nVl8/5
         /CRiV2u7NY6XtJJ8BQGGFHhjNr0wgsnRdTeJfkDA4+aFN5uSYqoTk5Pnp9a8WF5oHzYn
         /EUw==
X-Gm-Message-State: AOAM531rDdaWr4LI71XpKGB5zVWPWdMa6cIBTjn2r8IuiMTBbJRX2juU
        y/RrcOS5/LjnQr9GLxZVSXo=
X-Google-Smtp-Source: ABdhPJynM/Adj+3dUtjrT/79VAazSgKmC2z7Z5fnrviUdYA9at5SIvwI50uwB3fa0+KgkixRyu9LkA==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr5485253wmj.162.1641140068370;
        Sun, 02 Jan 2022 08:14:28 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id f8sm34155715wry.16.2022.01.02.08.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:14:27 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexhenrie24@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH -next] HID: apple: Report Magic Keyboard 2021 battery over USB
Date:   Sun,  2 Jan 2022 17:14:18 +0100
Message-Id: <20220102161418.143775-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 drivers/hid/hid-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 2bd8276411e0..afbee7c3b2e1 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -719,7 +719,7 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
-		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 
-- 
2.25.1

