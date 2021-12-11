Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4781471222
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 07:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhLKG2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 01:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhLKG2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 01:28:36 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D86C061714;
        Fri, 10 Dec 2021 22:28:35 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g18so10333867pfk.5;
        Fri, 10 Dec 2021 22:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=1BAfnfwabtd9IekqdpYeuqD6/EPGp86ulLTWgAwxEX8=;
        b=ON92GQqHmawNhOyRcpFj5YzdQw8Uy4jtLgFLlxkjuqsocwlTB80/SBaTKA0AR7+fJq
         l+ygePdi7JpskgSe2p1bYmBpdvWbwIuoZvLCaO3eE6ebShdOmjzsFEpd8Ee2ho1so4Va
         2v6NkwiKcA8YBFVHsyZqjIiqqraR/AdgE7sagznZq/2/GQ3y3LrI0NY1fbWR6o6kpESo
         WNHzA1Oe/2hCsq0yGVb1w/dFO/2PA1fovRqqWucqQYwF+gdISt9orKfKUIkYS/FMA2bY
         UXU5zGYzXuDK+PGjGcCTtgYtqqXYgRu4VZM7/bwdm8mNAmKCigEXXVJKbM8Q8xpWNena
         +xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=1BAfnfwabtd9IekqdpYeuqD6/EPGp86ulLTWgAwxEX8=;
        b=DqXsZaUrh7/IqDniB7gnNuFl8rPPFhG0LcJWTzNoBUVeTs0Lhxffv451t1k7Cdx5Cw
         79BAVAk+xgOMzJyIsrQbVcEdXREsbHnzqWWs287kh2ja1FyRkmieeBuSqio17kkDJO+y
         1AcXL3iH2cMb1bbWT23bcDK+8h9qCHrfjw4cqfOfyFfj+Gg4DHHJmkdIjeb3YZbj75XT
         Y4/5Vfv/Tp8IkrqCcJaypkULFbloLr934BPs68RpRajRbXxL5eRBWV7nMZ6PBK/+z1hc
         lI34XieZW6oX/X2Q0y/GQ9UEZ5lpE0Oj/BHH7YFkflicfXXPCS3FPEvU5E4FL/XbE34o
         n2QQ==
X-Gm-Message-State: AOAM531NWJ8nJ92lAxUL9n/99YrtgBR0yuCk6uxR52aIBUhB1k8zQZDe
        uz6/mxvBiKIzeEwlXv+SDv4=
X-Google-Smtp-Source: ABdhPJwlJR+4g5dhX8nNL40lNfMtBMpFTCbMHPvCjrvItMJlTek2WYqiqzk4mC0MjOsc3cFufpGA7A==
X-Received: by 2002:a63:8b4c:: with SMTP id j73mr9479826pge.525.1639204115164;
        Fri, 10 Dec 2021 22:28:35 -0800 (PST)
Received: from localhost.localdomain ([119.8.24.36])
        by smtp.gmail.com with ESMTPSA id k19sm4920463pff.20.2021.12.10.22.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 22:28:34 -0800 (PST)
Message-ID: <61b44512.1c69fb81.a2de3.f58a@mx.google.com>
X-Google-Original-Message-ID: <20211211062644.14033-1-Kortan>
From:   kortanzh@gmail.com
X-Google-Original-From: Kortan
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        s.parschauer@gmx.de
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kortan <kortanzh@gmail.com>
Subject: [PATCH v2] HID: quirks: Always poll Anne Pro 2(C15) Keyboard
Date:   Sat, 11 Dec 2021 14:26:45 +0800
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kortan <kortanzh@gmail.com>

According to https://openannepro.github.io/ap2_revisions, Anne Pro 2
keyboard has two hardware revisions, C15(04d9:a292) and C18(04d9:a293).

Previous patch submitted by Sebastian only fix the C18 revision. This
patch add missing C15 revision support.

Fixes: ca28aff0e1dc ("HID: quirks: Always poll Obins Anne Pro 2 keyboard")
Signed-off-by: Kortan <kortanzh@gmail.com>
---
Changes v1 -> v2:
* Fix link typo in commit message

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

