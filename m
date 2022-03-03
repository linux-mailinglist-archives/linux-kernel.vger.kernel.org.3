Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFB14CB4C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiCCCSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiCCCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:18:06 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309762724
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:17:22 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t5so3558411pfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 18:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Y6AdbsQCsGIi4ikNR94oE8HmTOxGuNWSzajQTJThGg=;
        b=PdRn3/yKD29Qe8LZeVNjT5+PdDCP+0c7XZkCPuw1+wR8e37bjMVmX3/BpWoDuk9VgU
         JIa2eVSfWiEs04eXZ6Sgr1RLSoLGz9+gc95OVv3TtcY0WsIqksxCcuFeo+x1+Z+08YTZ
         6D3v65DRj63kaQx0QvCQ6A8JP0aSUO27+kWA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Y6AdbsQCsGIi4ikNR94oE8HmTOxGuNWSzajQTJThGg=;
        b=wITIwlOOU/YEunjI2qf5b8V3eg77q/Q5jaDYPEUypgXytEc5nRnGOG3PCGk+W4ay1Y
         VtroapjKZGkWFWl3ktSXzGDzO4bOKkompYGWZzKU5ieUmIu+PpJVcNU39qZM9j57qAmW
         rowCaUtd8HQCM5O0YbIztZ7oIiG1QbW2xis1aoZ5tnf1oXj+FFshlHP1+odmqKZPD8z/
         9BUB5D0LcpW5+EHmw64uPdUVnnekV68gZHc07Yu9zapaAt7WYwDMsnxgoCpDiJ7pMvwy
         bn3ijkprSVvnvuxPGn2kgekYlDEXD/xradtEMenJEbxkUuYpOsWuQHT8Di3HPaSXJBT3
         d8Fg==
X-Gm-Message-State: AOAM5307HYn0sejcz3x2Vgk1gfFJtLzTTkdEtZAiA00QfX5AWpYU7rQl
        JYLedUyb8NHpZsCSf6U5UweRoNTBAWx2Mw==
X-Google-Smtp-Source: ABdhPJzvicLVEzzO3ISHIRjrq5m6i1lfWUvVT8PGJHNsNPYXmSJNdvK9sI8/7Xbgzr7Rq1GjjzyOaw==
X-Received: by 2002:a63:f241:0:b0:365:948d:19bb with SMTP id d1-20020a63f241000000b00365948d19bbmr28485780pgk.253.1646273841586;
        Wed, 02 Mar 2022 18:17:21 -0800 (PST)
Received: from wmahon.c.googlers.com.com (218.180.124.34.bc.googleusercontent.com. [34.124.180.218])
        by smtp.gmail.com with ESMTPSA id q91-20020a17090a1b6400b001bc8d59a02fsm357750pjq.35.2022.03.02.18.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 18:17:21 -0800 (PST)
From:   William Mahon <wmahon@chromium.org>
X-Google-Original-From: William Mahon <wmahon@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     William Mahon <wmahon@google.com>,
        William Mahon <wmahon@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH v4] HID: Add mapping for KEY_DICTATE
Date:   Thu,  3 Mar 2022 02:17:13 +0000
Message-Id: <20220303021501.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Numerous keyboards are adding dictate keys which allows for text
messages to be dictated by a microphone.

This patch adds a new key definition KEY_DICTATE and maps 0x0c/0x0d8
usage code to this new keycode. Additionally hid-debug is adjusted to
recognize this new usage code as well.

Signed-off-by: William Mahon <wmahon@chromium.org>
---

 drivers/hid/hid-debug.c                | 1 +
 drivers/hid/hid-input.c                | 1 +
 include/uapi/linux/input-event-codes.h | 1 +
 3 files changed, 3 insertions(+)

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
index 225ec87d4f22..4db5d41848e4 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -612,6 +612,7 @@
 #define KEY_ASSISTANT		0x247	/* AL Context-aware desktop assistant */
 #define KEY_KBD_LAYOUT_NEXT	0x248	/* AC Next Keyboard Layout Select */
 #define KEY_EMOJI_PICKER	0x249	/* Show/hide emoji picker (HUTRR101) */
+#define KEY_DICTATE		0x24a	/* Start or Stop Voice Dictation Session (HUTRR99) */
 
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
-- 
2.35.1.616.g0bdcbb4464-goog

