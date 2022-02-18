Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA24BC268
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 23:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbiBRWAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 17:00:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiBRWAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 17:00:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B0E60DAB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:00:34 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso9795017pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZLwKSjEy/ME5rayoc52rgW3ddgP7xtdGaSWqAl+rBU=;
        b=mif1AVloBIpbkRLpATD7fmfQIw6RGGHSm7NgqeRuknULpZUC8cnrbwYy80zOJwmo8D
         A+Gql6BmpZzXBwmpltHVxG5cOtfx/wmteLNVBIn7kqgICH3Jgtdb6/t1LVSTlFdxGpdj
         BfbBxn4t20fhQFB62mmb5dtVE4uhVW2HqGhMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZLwKSjEy/ME5rayoc52rgW3ddgP7xtdGaSWqAl+rBU=;
        b=3JJWLzdNjUjS30sLrQ0xSTprbhxXUAGif+832Z3uqZdAK9bwyxmjeFU5nOeLzlVHl7
         eeqh3b8tF/beSh9ISz+eZm6G46C0CO1KYbGLlfHoEJs90dU4/GhJ+RGcP5+o4XIvEMkr
         5//HxoKMFnaXFFaH9WkpzWvDDEaRw9Np2HdJxOaK7IQHKR6pHzqVYKVxfM6UZBb3XcEg
         iO2HhG/kl6VFKDuwU4gOpKCbl5AVThpSO1Gxn13DpOIdjjsP/cF/XemESp2K4rJD+VCs
         MQiOcBNwm8oSz+XJKJwkMHdkNO+RrV31sUsaocFh975yqYHL1MXItnlYipnxoXZtwaiC
         R/zQ==
X-Gm-Message-State: AOAM530DAcPv9OzQWrZj0gny1QtGn6JK/35EF1y41cI+7WYykaPXg2j8
        W9v6MzcXvhKvYRnQ/YPGVLP8nNiSU+xJJhdz
X-Google-Smtp-Source: ABdhPJz1rF5Jz09SD9USfmfteVEXQVcNRBPn0FNJ2bLonG7qFKB1MtE8MuXRu36OM46fMNwoTr1rIA==
X-Received: by 2002:a17:902:dacd:b0:14f:4e5d:fe0d with SMTP id q13-20020a170902dacd00b0014f4e5dfe0dmr9162472plx.128.1645221633881;
        Fri, 18 Feb 2022 14:00:33 -0800 (PST)
Received: from wmahon.c.googlers.com.com (218.180.124.34.bc.googleusercontent.com. [34.124.180.218])
        by smtp.gmail.com with ESMTPSA id 13sm306494pje.50.2022.02.18.14.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 14:00:33 -0800 (PST)
From:   William Mahon <wmahon@chromium.org>
X-Google-Original-From: William Mahon <wmahon@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH v3] HID: Add mapping for KEY_DICTATE
Date:   Fri, 18 Feb 2022 21:59:08 +0000
Message-Id: <20220218215531.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
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
messages to be dictated by a microphone.

This patch adds a new key definition KEY_DICTATE and maps 0x0c/0x0d8
usage code to this new keycode. Additionally hid-debug is adjusted to
recognize this new usage code as well.

Signed-off-by: William Mahon <wmahon@google.com>
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
2.35.1.473.g83b2b277ed-goog

