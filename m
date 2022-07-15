Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B36B5758FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbiGOBFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiGOBF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:05:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639663ED4D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:05:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so10150118pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMOaZjPOn7LiquFMJQ2CXw2tm+jQRrs558CGBk7ulfo=;
        b=bLRYriYf5s7UQ/7X05zIPibEf2AowOD7S1AeGIFEUYUiontcazQytHEDFm5AMwD7Jd
         VtCJdkBFLj+RTUVp7AqOSB0b0QRlkGLXysDfwIxtNa4cwB7U/hm4G0FmLnXCTRfoa1H3
         5gj6tuT3/ndw0w0YmLzxWkHImdMAct6eqdJvvfU59ObMTJk1vitayP1ItkBy/LvLJDqu
         p5AlTMyKgRVRyqNpIfOMb/fEFhmDLtTTVcKH/9geUYOGgVtpe914ygD0UTdqEsiSoSxT
         qr4aHnwd2R36jao2d0xJgODe1MqDVmtlWV39NwR6A+K8PsZjeDIOSVY2Yy8uaVgnJWtp
         yV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMOaZjPOn7LiquFMJQ2CXw2tm+jQRrs558CGBk7ulfo=;
        b=Uaip60CJ7Vvse3YNiaATm15a39kha1fy7JOzxmhU+AXc/K5mL4WE5ybzPtVYCX2b3s
         EZu3eJbCuMctYvOo7ozIg9VCOHwr1z9KfiYUhLcFvSSU6EsYPskGqaS5Ef4g4bymf8hz
         fQ4hqYbxroMzy7VbBG7t8m3h1HXOY716KB9DlKn/pU8P+b0eUPFxRJ4rEd3vipDO2kaB
         B26GnbaWG0a2hXhCWLwEYsjUJiUTWiagEyypifTh/QQt/uTz6Z4QH4Hu85qpsMbkUf7D
         w6k5J6DDPfyCowzuyWklkfL6yWn7hpZaf6758qvMNnzNyOnhFbId8I+mka+WZpuhmYC5
         LGyg==
X-Gm-Message-State: AJIora8f6lqrlfXjzP5fjv/wqXXQiypKjxHgEFtOhsVx8uHzCtOOVedJ
        zykiG1PQOFIjybfGKnbrlPZY3SW7dEF04gE=
X-Google-Smtp-Source: AGRyM1twV7U8txW9uqIswjHAUWHS1tkOsGchB7TYe8k6E3/W/dwm7czkvcZjMOj1Yu40M1A57av/HQ==
X-Received: by 2002:a17:90b:4a83:b0:1ef:de4c:660f with SMTP id lp3-20020a17090b4a8300b001efde4c660fmr12412585pjb.213.1657847127947;
        Thu, 14 Jul 2022 18:05:27 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b0016c27561454sm2163541plh.283.2022.07.14.18.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 18:05:27 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] ALSA: bcd2000: Fix a UAF bug on the error path of probing
Date:   Fri, 15 Jul 2022 09:05:15 +0800
Message-Id: <20220715010515.2087925-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver fails in snd_card_register() at probe time, it will free
the 'bcd2k->midi_out_urb' before killing it, which may cause a UAF bug.

The following log can reveal it:

[   50.727020] BUG: KASAN: use-after-free in bcd2000_input_complete+0x1f1/0x2e0 [snd_bcd2000]
[   50.727623] Read of size 8 at addr ffff88810fab0e88 by task swapper/4/0
[   50.729530] Call Trace:
[   50.732899]  bcd2000_input_complete+0x1f1/0x2e0 [snd_bcd2000]

Fix this by adding usb_kill_urb() before usb_free_urb().

Fixes: b47a22290d58 ("ALSA: MIDI driver for Behringer BCD2000 USB device")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 sound/usb/bcd2000/bcd2000.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index cd4a0bc6d278..7aec0a95c609 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -348,7 +348,8 @@ static int bcd2000_init_midi(struct bcd2000 *bcd2k)
 static void bcd2000_free_usb_related_resources(struct bcd2000 *bcd2k,
 						struct usb_interface *interface)
 {
-	/* usb_kill_urb not necessary, urb is aborted automatically */
+	usb_kill_urb(bcd2k->midi_out_urb);
+	usb_kill_urb(bcd2k->midi_in_urb);
 
 	usb_free_urb(bcd2k->midi_out_urb);
 	usb_free_urb(bcd2k->midi_in_urb);
-- 
2.25.1

