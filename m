Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D54BAF4F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiBRBwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:52:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiBRBwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:52:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426333A186
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:51:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so11062971pjl.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X16XPp9/gYEXnP8aB8/5NjFWebpL9jucU/uxnbVHGDg=;
        b=To3yKrVDYmnsHF7QSf9+Js9ZmJsCfl25GO5Px9cfLDWxuHZ+nACzurfpxj9AftFu+t
         zxFKeXc4flLsacRHixoebzVwaYhuTK/19I28t+zNdjSsXTApi0CiCGNqSb9xOYY2KcXU
         f5iXeWEQJpgdqqwO08hI7Rt9ctjn90CCs1Czk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X16XPp9/gYEXnP8aB8/5NjFWebpL9jucU/uxnbVHGDg=;
        b=PthQDPSdVD5E8bXcknQRikuh2xBPfDJiSrHAJ6JRX6PPeiSpusNl4JCHFx0Ey8p4/h
         pJBPwqVKAnZ3INV4n4QIs9TQywh1pdyQa+vhbOat3xA/nX4+4w8u6ezqnUhiSI13FJlW
         K1qd4XZqwjc1ec5R7zoZRvQmeDp2wn/oe4/E/lpLQHm5PBuP4VPPMoQ1WOoPy0Te9QEa
         /+7ks31dIoHatgOzXkOgZy7TzcSFKuOIM2p3rC/TlYflHiZmvCjgwaQdWGsDel/k1BNc
         mghOmaOXZZrP6ile/O06QXvplmk++DIenj5GeqwwH/OBRvTD6r+ZsyPa+SOYLeWuJ2G6
         teDA==
X-Gm-Message-State: AOAM530E5GWSyD2ZJRSc4uWJ20SmQn2fdMSgyWPDobd/XJ6iK9DpIp50
        Yl4VlIPri/IEnLQ7wN7u3Br1IFORcf/eY933
X-Google-Smtp-Source: ABdhPJyKySdytsGZuvvOE5n50thjnrwuCkw5BLF0AFMznLsqjvp5c4Q1A8oW1XjilnQFWtwdh4IEiQ==
X-Received: by 2002:a17:90a:d3c1:b0:1b9:d7a7:f022 with SMTP id d1-20020a17090ad3c100b001b9d7a7f022mr10412375pjw.25.1645149112682;
        Thu, 17 Feb 2022 17:51:52 -0800 (PST)
Received: from wmahon.c.googlers.com.com (218.180.124.34.bc.googleusercontent.com. [34.124.180.218])
        by smtp.gmail.com with ESMTPSA id s11sm884072pfk.8.2022.02.17.17.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 17:51:52 -0800 (PST)
From:   William Mahon <wmahon@chromium.org>
X-Google-Original-From: William Mahon <wmahon@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH v2] HID: Add mapping for KEY_DICTATE
Date:   Fri, 18 Feb 2022 01:51:45 +0000
Message-Id: <20220218015136.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Numerous keyboards are adding dictate keys which allows for text
messages to be dicated by a microphone.

This patch adds a new key definition KEY_DICTATE and maps 0x0c/0x0d8
usage code to this new keycode. Additionally hid-debug is adjusted to
recognize this new usage code as well.

Signed-off-by: William Mahon <wmahon@google.com>
---

 drivers/hid/hid-debug.c                | 1 +
 drivers/hid/hid-input.c                | 1 +
 include/uapi/linux/input-event-codes.h | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 26c31d759914..8aa68416b1d7 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -969,6 +969,7 @@ static const char *keys[KEY_MAX + 1] = {
 	[KEY_ASSISTANT] = "Assistant",
 	[KEY_KBD_LAYOUT_NEXT] = "KbdLayoutNext",
 	[KEY_EMOJI_PICKER] = "EmojiPicker",
+	[KEY_DICTATE] = "Dictate",
 	[KEY_BRIGHTNESS_MIN] = "BrightnessMin",
 	[KEY_BRIGHTNESS_MAX] = "BrightnessMax",
 	[KEY_BRIGHTNESS_AUTO] = "BrightnessAuto",
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 112901d2d8d2..ce2b75a67cb8 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -992,6 +992,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
 		case 0x0cf: map_key_clear(KEY_VOICECOMMAND);	break;
 
+		case 0x0d8: map_key_clear(KEY_DICTATE);		break;
 		case 0x0d9: map_key_clear(KEY_EMOJI_PICKER);	break;
 
 		case 0x0e0: map_abs_clear(ABS_VOLUME);		break;
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 225ec87d4f22..9aa994cbcd60 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -660,6 +660,8 @@
 /* Select an area of screen to be copied */
 #define KEY_SELECTIVE_SCREENSHOT	0x27a
 
+#define KEY_DICTATE			0x27b
+
 /*
  * Some keyboards have keys which do not have a defined meaning, these keys
  * are intended to be programmed / bound to macros by the user. For most
-- 
2.35.1.473.g83b2b277ed-goog

