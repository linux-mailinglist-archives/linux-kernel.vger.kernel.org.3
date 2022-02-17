Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A664B977C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiBQEPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:15:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiBQEPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:15:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D21C23BF20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:15:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso8362579pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BRHU4NCvA1m6DIbfwfpUmCjUvEI/go7HDCOPtiKRhmc=;
        b=dTea0karGoH15VfGMhYIdEcGiwWUIWlc/eo1WR+H35bX7vY0rDVD3Lkx2V1qAtpdO1
         ja8r8JuR2RJ+M0TyvpfrFM9ZpSD3+vwVFfF5uFowGn2ZxILyznfNpk4SuxJHjQoNRrly
         OeDHjx0LG/G7Sr24OhNHu99llWvtlcFeJcSIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BRHU4NCvA1m6DIbfwfpUmCjUvEI/go7HDCOPtiKRhmc=;
        b=V7X9v2T2AIEGXlD+ldNkYJ52rHZPSIbTqfm8xmOLY5wUmGEwXavbKXuJmrtWOM6or6
         ylNHcAzy66LIJKGdGbSVaH6J9+jcOVATpwLbnlV4llzxuH2V/Se6EiuyHlvg2WHo5SE/
         rdyR8CHySZtQ6dzS/+fQU7VhDmXE+rtqdc+a5CCV5RZNovnOnDSl5vWtm0j9PJs1CJdj
         XaBW/3sbLZTXIhW4xm1M2bUmVtO74I92h5Kj1kqA1mvC1wseul+hoNO2ok2Xy8Pdt37e
         nUbewTCzu5uAH0Qrw+3f4fIgHwjhR7+1e69sA1F7/FZlA85wGuDMKHkPnleSpPEyU9eY
         psXw==
X-Gm-Message-State: AOAM533pcQQxM0n/b79GE6t9PNfJMaeduwQvA92awKRRjEGUEt86Wn4F
        UpvPIwRovD6dkBjwuKk0qX8hghDFXtimopFSgeY=
X-Google-Smtp-Source: ABdhPJwss8wPAzsmd4U3EfXcPIeBemJt2rbGFEBB1rkzGcoGin7giL9qpLJAP3moWmNPsZXKJzI1fg==
X-Received: by 2002:a17:90a:9408:b0:1b5:3908:d3d1 with SMTP id r8-20020a17090a940800b001b53908d3d1mr1179743pjo.188.1645071301635;
        Wed, 16 Feb 2022 20:15:01 -0800 (PST)
Received: from wmahon.c.googlers.com.com (218.180.124.34.bc.googleusercontent.com. [34.124.180.218])
        by smtp.gmail.com with ESMTPSA id p9sm5519360pfo.97.2022.02.16.20.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 20:15:01 -0800 (PST)
From:   William Mahon <wmahon@chromium.org>
X-Google-Original-From: William Mahon <wmahon@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH] HID: Add mapping for KEY_DICTATE
Date:   Thu, 17 Feb 2022 04:14:54 +0000
Message-Id: <20220217041427.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Numerous keyboards are adding dicate keys which allows for text
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
index 112901d2d8d2..0c6c6db942ca 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -992,6 +992,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
 		case 0x0cf: map_key_clear(KEY_VOICECOMMAND);	break;
 
+		case 0x0d8: map_key_clear(KEY_DICTATE);	break;
 		case 0x0d9: map_key_clear(KEY_EMOJI_PICKER);	break;
 
 		case 0x0e0: map_abs_clear(ABS_VOLUME);		break;
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 225ec87d4f22..12246594891c 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -735,6 +735,8 @@
 #define KEY_KBD_LCD_MENU4		0x2bb
 #define KEY_KBD_LCD_MENU5		0x2bc
 
+#define KEY_DICTATE 			0x27b
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
-- 
2.35.1.265.g69c8d7142f-goog

