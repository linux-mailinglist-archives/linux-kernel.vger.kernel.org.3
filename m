Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834085170F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbiEBNzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385456AbiEBNyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1E4A13D34
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651499443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BQpSyCSvSxwXSRLg4x96E4uuSIM8J4F+LPJOv0S8u+E=;
        b=B2jeY0OGiOeMFgO8xSDWDD9sJCG5BW9sz6lMsl6l4fPx3Q0RTF9ttsMcAH6VK/fUNwc+NN
        Qpiynf4owwkQU+eDLnuIYQUi46P+teQp5rBI/BhYnKgTytRKyrwhXfL/5seWhafbYcAEpF
        IR/fxzpxGhwDHa3eS7cxlq1xxNAbQ40=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-oJygabKOOme5umDuqfBGWQ-1; Mon, 02 May 2022 09:50:42 -0400
X-MC-Unique: oJygabKOOme5umDuqfBGWQ-1
Received: by mail-wr1-f69.google.com with SMTP id o13-20020adfa10d000000b0020c6fa5a77cso305361wro.23
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQpSyCSvSxwXSRLg4x96E4uuSIM8J4F+LPJOv0S8u+E=;
        b=PxB9qMFu0lp0IdkvJYD6jB2dpSZEANGUV4DYnsa3A5JlhqgUpZO2fCvrUU14KZf7wX
         s7Z0wY+PJmWwt0caRk+BUU1uLYMug8hLgjC8rhBUhvQ46lU73gBrX4+Iu2EiwnbJ+E/T
         YcwFqUi6kfa6HeHzuBz4Yyx3RC8C3DaFZj7b20tI4bazpJT0IiWuzSVYBzu5Bio0K6Z3
         +SvEP/X5zNSipfoHBQmTOA7pmya070vxcmKPBY1eyijqFNeqeDMG3Aav9PHwEYrwyYuG
         KKBmsGQ5S36GVr+3aXhQcGm7zmgoMkUKAC+oif1qgekw+e+jDshvddUWtpXoQLXKOjcv
         8YXw==
X-Gm-Message-State: AOAM531vSzTCfTUk7dUSk3OpcwF6uM+8wsoBMtHI4ybA/ccO3fPLgS0h
        qEzzP96za19o9GLZtA8+uBfoSRwa6hI7gJnBPx3hEvtqXmTvsWSMcZb/jUh8Up004Kbd198v0mP
        kVm6ONzFxDbPOMt+L3DtHan8GVZ4y/zj9doczDWWKRGprR8Vz8Q93kfbwaSARzx/k+9RF8qsXHd
        4=
X-Received: by 2002:a1c:f315:0:b0:381:1f6d:6ca6 with SMTP id q21-20020a1cf315000000b003811f6d6ca6mr15371035wmq.25.1651499441067;
        Mon, 02 May 2022 06:50:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGqfnkXq/QNQtkvE0piB9l7XKahLmkaXX4erAteBBJGEmr2zey65L6iPEnmq/SupQnMxgPQg==
X-Received: by 2002:a1c:f315:0:b0:381:1f6d:6ca6 with SMTP id q21-20020a1cf315000000b003811f6d6ca6mr15371002wmq.25.1651499440753;
        Mon, 02 May 2022 06:50:40 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w6-20020adf8bc6000000b0020c5253d8bdsm8725957wra.9.2022.05.02.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:50:40 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zack Rusin <zackr@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2] fbdev: Make fb_release() return -ENODEV if fbdev was unregistered
Date:   Mon,  2 May 2022 15:50:14 +0200
Message-Id: <20220502135014.377945-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A reference to the framebuffer device struct fb_info is stored in the file
private data, but this reference could no longer be valid and must not be
accessed directly. Instead, the file_fb_info() accessor function must be
used since it does sanity checking to make sure that the fb_info is valid.

This can happen for example if the registered framebuffer device is for a
driver that just uses a framebuffer provided by the system firmware. In
that case, the fbdev core would unregister the framebuffer device when a
real video driver is probed and ask to remove conflicting framebuffers.

The bug has been present for a long time but commit 27599aacbaef ("fbdev:
Hot-unplug firmware fb devices on forced removal") unmasked it since the
fbdev core started unregistering the framebuffers' devices associated.

Fixes: 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced removal")
Reported-by: Maxime Ripard <maxime@cerno.tech>
Reported-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

Changes in v2:
- Drop patch 1/2 since patch 2/2 should be enough to fix the issue.
- Add missing Fixes and Reported-by tags (Thomas Zimmermann).
- Add Thomas Zimmermann's Reviewed-by tag.

 drivers/video/fbdev/core/fbmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 84427470367b..82d4318ba8f7 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1434,7 +1434,10 @@ fb_release(struct inode *inode, struct file *file)
 __acquires(&info->lock)
 __releases(&info->lock)
 {
-	struct fb_info * const info = file->private_data;
+	struct fb_info * const info = file_fb_info(file);
+
+	if (!info)
+		return -ENODEV;
 
 	lock_fb_info(info);
 	if (info->fbops->fb_release)
-- 
2.35.1

