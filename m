Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD67B4CB5A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiCCD6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCCD6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:58:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E6615041C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:57:16 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m22so3627894pja.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sN56U/MxzcAq7Ji7ujqvCiSFXq3Px2uncy+XviL6Elo=;
        b=UzQ9ZzQuF00lfXHKdO8TTfq27JObbQGJkGO7h1nBMLLCb6WKsmcoWsWxBSKHeMcPJr
         bqIONY1/aUpiDtuKJkzTcvmDgo+MYYpWoPG0MHc6dDCkk8+CZ+a4VpeXH0E2zlbMqwQj
         xiWw8fjxPVyLy0CcQ4/l5LZrc26kU4GS/iyC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sN56U/MxzcAq7Ji7ujqvCiSFXq3Px2uncy+XviL6Elo=;
        b=nGcCWRQuyKuklRs7Btzna9KKZ+KSi0OGpLcWTwm5uHOmcXVXNe9XW2Xl0Fbqs17BFF
         QgHSJRsMD+BZnnW793lo841/bFP/bbOWHgjMCUg7vUdUjmGlPHAWhk/W79Ufoy0bQDjL
         QCeaJMwHjKekl1HrsYQjpKg4eC+66IAqBgJEkKNhP6xtkfN4ZLgUBvGSqaLe1kGZZTLd
         zfqCWDsU6i1WzX7jIYH6vIAsvYlEuS3/k2zRKevEkvPDamwcwiKAASlT4WlhNSwjUWa4
         MRzsW2YDCRW/0kd5bYivFUMq215lSheDb3Hi6ezF9QWzl/ZOeqARwFBWD11C0wH/WrLR
         5Hsw==
X-Gm-Message-State: AOAM531XhGEV88ROcIe4iQNw+Q04dj6FXY76dbF1t0MMyLnn71fLKk0e
        tigjByO74uUbmPBjPouPUEg4frauOFpVnA==
X-Google-Smtp-Source: ABdhPJwcrMOZlFSBfbq4cahkRSQNhcw0qyaNIzWMyJ8sa0tB1anPQEUPy1RXTpva9PR4JSO7Ear/xA==
X-Received: by 2002:a17:902:e5c3:b0:151:96df:e06a with SMTP id u3-20020a170902e5c300b0015196dfe06amr6430506plf.41.1646279835479;
        Wed, 02 Mar 2022 19:57:15 -0800 (PST)
Received: from wmahon.c.googlers.com.com (218.180.124.34.bc.googleusercontent.com. [34.124.180.218])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm6526366pjc.56.2022.03.02.19.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 19:57:15 -0800 (PST)
From:   William Mahon <wmahon@chromium.org>
X-Google-Original-From: William Mahon <wmahon@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     William Mahon <wmahon@google.com>,
        William Mahon <wmahon@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH v3] HID: Add mapping for KEY_ALL_APPLICATIONS
Date:   Thu,  3 Mar 2022 03:57:03 +0000
Message-Id: <20220303035618.1.I3a7746ad05d270161a18334ae06e3b6db1a1d339@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new key definition for KEY_ALL_APPLICATIONS
and aliases KEY_DASHBOARD to it.

It also maps the 0x0c/0x2a2 usage code to KEY_ALL_APPLICATIONS.

Signed-off-by: William Mahon <wmahon@chromium.org>
---

 drivers/hid/hid-debug.c                | 1 +
 drivers/hid/hid-input.c                | 2 ++
 include/uapi/linux/input-event-codes.h | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 01135713e8f9..dbde52bd6585 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -939,6 +939,7 @@ static const char *keys[KEY_MAX + 1] = {
 	[KEY_KBDINPUTASSIST_NEXTGROUP] = "KbdInputAssistNextGroup",
 	[KEY_KBDINPUTASSIST_ACCEPT] = "KbdInputAssistAccept",
 	[KEY_KBDINPUTASSIST_CANCEL] = "KbdInputAssistCancel",
+	[KEY_ALL_APPLICATIONS] = "AllApplications",
 };
 
 static const char *relatives[REL_MAX + 1] = {
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index eccd89b5ea9f..c3e303c1d8d1 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1162,6 +1162,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 		case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT);	break;
 
+		case 0x2a2: map_key_clear(KEY_ALL_APPLICATIONS);	break;
+
 		case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
 		case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
 		case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 311a57f3e01a..556aa8f88201 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -278,7 +278,8 @@
 #define KEY_PAUSECD		201
 #define KEY_PROG3		202
 #define KEY_PROG4		203
-#define KEY_DASHBOARD		204	/* AL Dashboard */
+#define KEY_ALL_APPLICATIONS	204
+#define KEY_DASHBOARD	KEY_ALL_APPLICATIONS /* AL Dashboard */
 #define KEY_SUSPEND		205
 #define KEY_CLOSE		206	/* AC Close */
 #define KEY_PLAY		207
-- 
2.35.1.616.g0bdcbb4464-goog

