Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B98471219
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 07:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhLKGQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 01:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhLKGQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 01:16:53 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB32C061714;
        Fri, 10 Dec 2021 22:16:52 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z6so7673495plk.6;
        Fri, 10 Dec 2021 22:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=uFeYg6S/Je1PYJSAjW1hb1D6KhJjdhXKfHaKvZlFy7o=;
        b=fcWYEa1ryBUECRr/yJiGnewxbKr3cbmMHa/gChptvXxz9GZg2fxV5BZfYniHdR4nzo
         wgmlcUIL7RT2z/9hkTYLEqB96MvhlqI3DnsGpH1a1eaOuZkyWPNzMGjgKtZ4xIdRGcvU
         OnLiFOQsGbRE4+TJNeAEoGzbxDBEGY+6R7C+wSRS0u0SqiyLr2JGWTAMQ9vezfAuQ1pm
         n2ojJs2ENbYhT2oC3uojKfgnQJ+SJ1Hp7guVSPT2pet9CZtO32AIZu/RzexwFw09o5D3
         wGfOlLUJffQF7AXGpShZLU7jIf02O+TmNaCZvUTwouEGI1744P4EEWg4KDV2dfK1YFn1
         rAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=uFeYg6S/Je1PYJSAjW1hb1D6KhJjdhXKfHaKvZlFy7o=;
        b=4DeZwUB+2DtOFtCQ17kAlvlJIURrOwo7leuSz5xWWxWU5MYj7IxbNfnuCWWbfw3MkE
         ava/lUIB6tLs3RgJ5qpwz/UMVWy7kpEzdafVa/3mfI9r/ca08GYiymALhF+xSLW2pDG8
         caHexK0KtcoOzjWOXYcacfsTueC2ro76cu2MM6F2+wfKoYUSdjIPnwQ4JrpQ2UbSGpgS
         IDxJ8kwrEE48ZymFZEc0C8qsJcAEVtG58Mbq/clwkmXjkmXxhjYEMsTU8U00V19DcV4m
         Dmhzxe9VohX5+4F1vo1F4COZ1k5NbVZi7umhVr6Fp7+KYwvJeyJLon3zUS+44uOjWau0
         LQFA==
X-Gm-Message-State: AOAM533zfwtSWjGp2HjZUr0shP7uQjCGCeVqFZUxn+zCoj09QZ6nu57o
        z5Z595W2UQHpDrwECUkz+oPORdGVT6oN/gWQ6nmZ1g==
X-Google-Smtp-Source: ABdhPJyclyMiq8tgI01YZl/16gVu8aZNCwLroVTNpT0Yf1fMA6r9U3sI59lAnuCXzV4oZFrOCeL7Dw==
X-Received: by 2002:a17:903:11c4:b0:141:da55:6158 with SMTP id q4-20020a17090311c400b00141da556158mr81415862plh.7.1639203412437;
        Fri, 10 Dec 2021 22:16:52 -0800 (PST)
Received: from localhost.localdomain ([119.8.24.36])
        by smtp.gmail.com with ESMTPSA id y70sm1845336pgd.21.2021.12.10.22.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 22:16:52 -0800 (PST)
Message-ID: <61b44254.1c69fb81.ca496.5d65@mx.google.com>
X-Google-Original-Message-ID: <20211211061606.13936-1-Kortan>
From:   kortanzh@gmail.com
X-Google-Original-From: Kortan
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        s.parschauer@gmx.de
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kortan <kortanzh@gmail.com>
Subject: [PATCH] HID: quirks: Always poll Anne Pro 2(C15) Keyboard
Date:   Sat, 11 Dec 2021 14:16:07 +0800
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kortan <kortanzh@gmail.com>

According to https://openannepro.github.io/ap2_revisionas, Anne Pro 2
keyboard has two hardware revisions, C15(04d9:a292) and C18(04d9:a293).

Previous patch submitted by Sebastian only fix the C18 revision. This
patch add missing C15 revision support.

Fixes: ca28aff0e1dc ("HID: quirks: Always poll Obins Anne Pro 2 keyboard")
Signed-off-by: Kortan <kortanzh@gmail.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 19da07777d62..3b1335cd19ba 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -644,6 +644,7 @@
 #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081	0xa081
 #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2	0xa0c2
 #define USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096	0xa096
+#define USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A292	0xa292
 #define USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A293	0xa293
 
 #define USB_VENDOR_ID_IMATION		0x0718
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index ee7e504e7279..2952ce3aa560 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -94,6 +94,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A292), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A293), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A), HID_QUIRK_ALWAYS_POLL },
-- 
2.34.1

