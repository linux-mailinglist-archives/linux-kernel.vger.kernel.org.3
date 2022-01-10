Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A84895CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbiAJJ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243445AbiAJJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641808591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGDm1oaaWKUbsURSYDtt3eA6CLvZDH+FDjQaP+AuY/8=;
        b=C3zX4jOmqYap+53SM/TkVYqwkS8y67VK05zxkVEjyNL+H2O+Y2qMJYOJn5ufDNJH0CkU9J
        eDzX71xjvuE+3MNfc7LZQsocqC9YKNW+4rPxRfAU+p1HMDwIvSa/K/H/yjw3p1p51hhyL/
        zcDPQqSgNppra7varnquPFosqjatHGQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-DWh7alb7OuKcQwZXd5LP_g-1; Mon, 10 Jan 2022 04:56:30 -0500
X-MC-Unique: DWh7alb7OuKcQwZXd5LP_g-1
Received: by mail-wm1-f69.google.com with SMTP id m9-20020a05600c4f4900b0034644da3525so4697926wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGDm1oaaWKUbsURSYDtt3eA6CLvZDH+FDjQaP+AuY/8=;
        b=Ukzk6VuS3ocp3aX+hXeuONgJiHfYmYimFeY9JrTEfbhRjS1I90sl0DAoNhwAY58CUY
         Yk8BMm4/wKYfNWu6v5Jk8BlrK3nyYKVyetwi3/34LvucyGFkKSaNT98XW1cxMSrxxY/r
         q0tJRj4EtACveeG/T2vrG4BXph/St/4bANkOhntZu9iCyCj8+vp2zPlYK5DpnK+Czl2t
         O2Z75a5SZlJMzvVhwL/RUx5LQ8cndW0eD9ghjiYSdFkhrcLZbh3MEPyMj7IEVihXE/Jn
         H+Dj718cxvFOJ5a5mr4c8r0i6aIsiLK5wpRjT8BAH2JzYDvMowDwhCriphV7YreyIKmE
         v8/Q==
X-Gm-Message-State: AOAM531C2WhpfqcpNjE5MYeLG0yBHeXHFUXjNgOxAritMnlW+bshqM5b
        D58lEZ7M/WlBLlFz1eTuiNhpkIZI18LdUtl5877SoCAS0/dFnddiiwYDyiDl8Vpf6Qbt0HKw34a
        mRoJxtX7fgd3BZ8sgGpdFiFkYuZiWZUR0pM5kTRA7AVl4CVEcvj4CdG+o7m6pQMC6HLnD9z/cS7
        o=
X-Received: by 2002:a5d:6302:: with SMTP id i2mr5349410wru.25.1641808589103;
        Mon, 10 Jan 2022 01:56:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6ths/AcE+USA4b9jT9nuUL+2SfOzOGrd7hBLtsih5mHKb9hQ17/vSxnWdP1FKhpwI1kRuhA==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr5349395wru.25.1641808588900;
        Mon, 10 Jan 2022 01:56:28 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b13sm6315167wrf.64.2022.01.10.01.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:56:28 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kris Karas <bugs-a21@moonlit-rail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 1/2] video: vga16fb: Fix logic that checks for the display standard
Date:   Mon, 10 Jan 2022 10:56:24 +0100
Message-Id: <20220110095625.278836-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110095625.278836-1-javierm@redhat.com>
References: <20220110095625.278836-1-javierm@redhat.com>
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

All non-x86 architectures though treat orig_video_isVGA as a boolean so
only do the change for x86 and keep the old logic for the other arches.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Make the change only for x86 (Geert Uytterhoeven)

 drivers/video/fbdev/vga16fb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index e2757ff1c23d..8c464409eb99 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1332,7 +1332,12 @@ static int vga16fb_probe(struct platform_device *dev)
 	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
 	par = info->par;
 
+#if defined(CONFIG_X86)
+	par->isVGA = screen_info.orig_video_isVGA == VIDEO_TYPE_VGAC;
+#else
+	/* non-x86 architectures treat orig_video_isVGA as a boolean flag */
 	par->isVGA = screen_info.orig_video_isVGA;
+#endif
 	par->palette_blanked = 0;
 	par->vesa_blanked = 0;
 
-- 
2.33.1

