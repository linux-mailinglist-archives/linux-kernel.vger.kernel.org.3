Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6721D487639
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347015AbiAGLHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:07:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346998AbiAGLHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641553655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58zbRN1g/CU6F0V6Z7/ygK3GmWeTFgdq63VOW5AeL6U=;
        b=VNpYDy8ZFcOe2bOKxaFR8Tq3ifDvbCCdn9Gv8OuuLUufJr9RZ3YBO8klNilfXD9z3RZZje
        3D1tbbQOjxGM4+dvZscGnxi15S/Na3qfQmI/1ciU3lYAX+LDQCMHEYkw4uYZHaHjjY0/bL
        Ml/kXp8aNVct57NbJ3tKIuFCzA4sR4k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-l8t1e2DKMUeccoBLdStHUA-1; Fri, 07 Jan 2022 06:07:34 -0500
X-MC-Unique: l8t1e2DKMUeccoBLdStHUA-1
Received: by mail-wm1-f72.google.com with SMTP id d4-20020a05600c34c400b00345d5d47d54so1353143wmq.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 03:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58zbRN1g/CU6F0V6Z7/ygK3GmWeTFgdq63VOW5AeL6U=;
        b=bhR5pffWIO0/sOE6gok/CtfzmlFVSP1K6zA0DpVdksBI4afiq/2elYw8rppvBy3nhN
         z++EJZQSrauBVQIKICvLxD2P0aQdyMB+5qfUvYYcBOyuOszYhxkATpAENUJGlrGtJckR
         uv1A4jYEcP9yo3ZBw6CbT9elg8ct1XWUigSOY+yFHpEnVHQ8N9zBLsDCnKM+9QT1UeKE
         xYDCfXx7HGL5e0R3oVuwPvlpZ0bvoY7ycI6AUFmAgvclldXGj3YOeWn8c5gv58G/aUhx
         omTIEPqBDhtstNCtI7tuh1NvTvKOUFWPZFy3/gbaAOkcAJGJFxeOvwduGsiOAq9CapaQ
         7bsA==
X-Gm-Message-State: AOAM533gJQvG5Y96hpo/zc9YSSg6bv0lnhCTieinFbXVCYZ+wU3Cc9Qz
        8vrAKXozPYFmRaFcL47JhoOT8sAk+5X2fg7y1mJ4aY9KwKLLyYBL9UlA5RfQo9gMQKQ9+HAeVWg
        e726BxoQVJhawyLsjgyPTLq5v91q+bqdq/g7qSj3OaMB/gcsNXJsubZXuwAuDbVcGlra3mHJ2vI
        g=
X-Received: by 2002:a05:6000:184f:: with SMTP id c15mr55611171wri.632.1641553653106;
        Fri, 07 Jan 2022 03:07:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8FiBkwupY26l2VOQFCBjlQX2PiwGOdMzcc0tazi6OhYPBwayO3s/sLvIG8bnzF/tTNPF5NQ==
X-Received: by 2002:a05:6000:184f:: with SMTP id c15mr55611147wri.632.1641553652846;
        Fri, 07 Jan 2022 03:07:32 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r9sm9337273wmq.18.2022.01.07.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 03:07:32 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kris Karas <bugs-a21@moonlit-rail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/2] video: vga16fb: Fix logic that checks for the display standard
Date:   Fri,  7 Jan 2022 12:07:22 +0100
Message-Id: <20220107110723.323276-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107110723.323276-1-javierm@redhat.com>
References: <20220107110723.323276-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vga16fb framebuffer driver supports both Enhanced Graphics Adapter
(EGA) and Video Graphics Array (VGA) 16 color graphic cards.

But the logic to check whether the EGA or VGA standard are used is not
correct. It just checks if screen_info.orig_video_isVGA is set, but it
should check if is set to VIDEO_TYPE_VGAC instead.

This means that it assumes to be VGA even if is set to VIDEO_TYPE_EGAC.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/vga16fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index e2757ff1c23d..3347c9b6a332 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1332,7 +1332,7 @@ static int vga16fb_probe(struct platform_device *dev)
 	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
 	par = info->par;
 
-	par->isVGA = screen_info.orig_video_isVGA;
+	par->isVGA = screen_info.orig_video_isVGA == VIDEO_TYPE_VGAC;
 	par->palette_blanked = 0;
 	par->vesa_blanked = 0;
 
-- 
2.33.1

