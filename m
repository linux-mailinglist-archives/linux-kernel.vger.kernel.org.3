Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E04B9855
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiBQFeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:34:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiBQFeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:34:17 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3701713701A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:34:04 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id om7so4527257pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8D3Z6SHi9rXAcsLdfMJxmtujjPxcEwgD3tdJ3a2pda0=;
        b=fUJFnw01k85b8Yf/4JGOZNVSLgr2asDoHVekpX9rqL5ssRwHVWW1msTEtV+tW1CTAq
         e3MlP9xIjspIlKi55yf0pijupjcXcs2KscrAqKRfoMfL3L5TuI+4CHXz2dQHsMWiPATe
         vWV5lC5uPbXLaHDWI3Li2csPabNBUew0oOkME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8D3Z6SHi9rXAcsLdfMJxmtujjPxcEwgD3tdJ3a2pda0=;
        b=UOZHSwK3Yv3tkWuq+x75Zlpa7ZS7ZsmBcQ/scWY7ZT4WlaNaX3wr3aXbcC2DqzZszy
         EQs46vCR4M8NzlyelLiDCAdk5Tb8//IZWbh0l1IGvftyVdI1R26zMYk8/kBBX2ulvQsP
         DuuZYpgvnD9HRfRfyMD1tcB29eMhUBJTo/QKUMdNFPj4QBgp0IgmPqIg7wLykBwiUTdF
         jmCaN+b1zSZT4ugYsyUrgiXlc5VHEcfXDpZgDuxN7hxI/QVrwZw6V726rvb47wWs2JPM
         4v8j7JppCKJWJIV4bez1gAH+qW4Ngbu31PdQafyb7x1hkKEWs50VGzsZT+Qi3Nhoq62d
         Zk1g==
X-Gm-Message-State: AOAM531gB35khjiTJi+Gmg8EX97RPOUWTq+oTgBrZkJ12+Miaz0ZoFpM
        xAlji0RSxig/tcKjXekPIFWF7bcoaSo7j/Za
X-Google-Smtp-Source: ABdhPJxNkq1zuGh2gcIzqnr1K1Pj6RLPmTp8xB4jXRH0uqFrHbtSGWvrSzUJJbmb7Wp16B2MKr1/vA==
X-Received: by 2002:a17:902:f70c:b0:14e:f1a4:d894 with SMTP id h12-20020a170902f70c00b0014ef1a4d894mr1296612plo.65.1645076043624;
        Wed, 16 Feb 2022 21:34:03 -0800 (PST)
Received: from wmahon.c.googlers.com.com (218.180.124.34.bc.googleusercontent.com. [34.124.180.218])
        by smtp.gmail.com with ESMTPSA id lk11sm68115pjb.31.2022.02.16.21.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 21:34:03 -0800 (PST)
From:   William Mahon <wmahon@chromium.org>
X-Google-Original-From: William Mahon <wmahon@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH] HID: Add mapping for KEY_APP_LAUNCHER
Date:   Thu, 17 Feb 2022 05:33:57 +0000
Message-Id: <20220217053354.1.I3a7746ad05d270161a18334ae06e3b6db1a1d339@changeid>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
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

The App Launcher key is used to bring up the Launcher menu.

This patch adds a new key definition KEY_APP_LAUNCHER and maps 0x0c02a28
usage code to this new keycode. Additionally hid-debug is adjusted to
recognize this new usage code as well.

Signed-off-by: William Mahon <wmahon@google.com>
---

 drivers/hid/hid-debug.c                | 1 +
 drivers/hid/hid-input.c                | 2 ++
 include/uapi/linux/input-event-codes.h | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 01135713e8f9..36a42ad3b7bc 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -930,6 +930,7 @@ static const char *keys[KEY_MAX + 1] = {
 	[KEY_SCREENSAVER] = "ScreenSaver",
 	[KEY_VOICECOMMAND] = "VoiceCommand",
 	[KEY_EMOJI_PICKER] = "EmojiPicker",
+	[KEY_APP_LAUNCHER] = "AppLauncher",
 	[KEY_BRIGHTNESS_MIN] = "BrightnessMin",
 	[KEY_BRIGHTNESS_MAX] = "BrightnessMax",
 	[KEY_BRIGHTNESS_AUTO] = "BrightnessAuto",
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index eccd89b5ea9f..7c89260826b2 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1162,6 +1162,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 		case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT);	break;
 
+		case 0x2a2: map_key_clear(KEY_APP_LAUNCHER);	break;
+
 		case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
 		case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
 		case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 311a57f3e01a..fdf43cf14125 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -651,6 +651,8 @@
 #define KEY_DATA			0x277
 #define KEY_ONSCREEN_KEYBOARD		0x278
 
+#define KEY_APP_LAUNCHER		0x27c
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
-- 
2.35.1.265.g69c8d7142f-goog

