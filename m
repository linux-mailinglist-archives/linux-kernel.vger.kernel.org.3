Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1976581795
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiGZQjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiGZQji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:39:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BF21E3FB;
        Tue, 26 Jul 2022 09:39:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g2so12883295wru.3;
        Tue, 26 Jul 2022 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqtpgNQcwaCsv1mwTgrIhbhApopwMTvPV7ss+M+u/o8=;
        b=gqfCzSRumTU5hd/8wloopALuGRlO+ohrPc5LK7Mlw34AOq0OV14XK4LpyN4rdMTsNd
         F8/9dm4rPUEQMweKUOZpoD2hdSgn+vHFlyYoJMzNyz9iedi+ltCeD742W0v2zvkOXExo
         okNB/A2NdWlUp2jmdRi0gR0zGAgzxUR7WwYZmG+WzxV1aPQrVYmttf/QXaU3H65fDoEW
         BaLe7UYGIA2rK8oIxR5v92/xYSO0cEPAlZgnk6n52eK/dtaC+FvXnfDJpRW0vYTIvDx+
         zrPR3n3w/zS/bZaTFb7VXZgbeiNQT/WpWY8y63Xr3TgVZiv97IWmP1bB5+fvEHoG/rZo
         BlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqtpgNQcwaCsv1mwTgrIhbhApopwMTvPV7ss+M+u/o8=;
        b=EgcmSzbUffLXGxcq7KpTNPiKcRRK9UUUrQAw6W/zbALPzZv6yHqk0tlTek84sw/Z4n
         C9EpiDkmv+FnJUN7Y7UcjZSpjVM1jvMmAQnN6JdQqGjZLhxeBoSTs0So/BL8xt9QZxuX
         eQgBYQxeyuJuBDZMph7frX+moio8tXfTFq3KtIGJ/fzHF8lfwyCK99ZALlfPapBIm4ke
         gsj4eheVCzPFwt9KvgNVPCUfRzaLzPCrRunzXPvNN9keFGzFUsr6lvtTSZbr08puBSwf
         Wpc9jlUJZoIj168EQ2xjupVsFu41qBN1J9+cYA86bHJXcT694ks2cgqWsMBITY8Yenej
         ZQRg==
X-Gm-Message-State: AJIora+D83K1LvXmjLVmPjkxbF2F51MP+dilqcFGHK7rPJlcz/1UUYL+
        xOM7UkWERHyk6oQYuVKv+dw=
X-Google-Smtp-Source: AGRyM1v0Q8klGCqgyFszBS1ethiWTBLZjMoRkrRSHbnBYEYbOkKJF+HJfgWU3/kZr5XYBzdDn6hIUw==
X-Received: by 2002:adf:ec11:0:b0:21e:5ec4:6ce0 with SMTP id x17-20020adfec11000000b0021e5ec46ce0mr11727432wrn.113.1658853577078;
        Tue, 26 Jul 2022 09:39:37 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c058900b0039c54bb28f2sm19514710wmd.36.2022.07.26.09.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:39:36 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 7/7] HID: uclogic: Add support for XP-PEN Deco Pro S
Date:   Tue, 26 Jul 2022 18:39:26 +0200
Message-Id: <20220726163926.10549-8-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726163926.10549-1-jose.exposito89@gmail.com>
References: <20220726163926.10549-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XP-PEN Deco Pro S is a UGEE v2 device with a frame with 8 buttons,
a bitmap dial and a mouse. Its pen has 2 buttons, supports tilt and
pressure.

All the pieces to support it are already in place. Add its ID in order
to support the device.

The required Wireshark traces were captured by Jouke Witteveen.
For more information check [1].

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/738  [1]
Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 139910034c17..ee6d27a5dd1c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1279,6 +1279,7 @@
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640	0x0094
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01	0x0042
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L	0x0935
+#define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S	0x0909
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06	0x0078
 #define USB_DEVICE_ID_UGEE_TABLET_G5		0x0074
 #define USB_DEVICE_ID_UGEE_TABLET_EX07S		0x0071
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 47a17375c7fc..6fcdb141acec 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -523,6 +523,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06) },
 	{ }
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 797eeb443c18..dd4b1ed6fd1e 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1583,6 +1583,8 @@ int uclogic_params_init(struct uclogic_params *params,
 		break;
 	case VID_PID(USB_VENDOR_ID_UGEE,
 		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L):
+	case VID_PID(USB_VENDOR_ID_UGEE,
+		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S):
 		rc = uclogic_params_ugee_v2_init(&p, hdev);
 		if (rc != 0)
 			goto cleanup;
-- 
2.25.1

