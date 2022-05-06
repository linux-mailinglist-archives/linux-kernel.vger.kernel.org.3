Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9EE51D8EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392450AbiEFN0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392424AbiEFN02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:26:28 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF94C69711
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651843364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ntfBkmjNjhrxvA8xhvwrtXUPZhy6WpJ5yDdT5A+/C00=;
        b=Wtk74G+V7aYi6mde13y1K7Fa8NuxGF0Hyf731kBLC7M2YKnml3AvC1mXkIUeofmlOzFPmE
        LfJo3q/yMVR8D2N6cZXjkfjbgMMnNYAClohUQp2YVR23vtAw8NYmeoyyssHLL6wZdrccQW
        qptb008pMC8Y+307xBhxDRoyT+tqnmM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-ypFVaWaVNYqy1yIqEEoILA-1; Fri, 06 May 2022 09:22:43 -0400
X-MC-Unique: ypFVaWaVNYqy1yIqEEoILA-1
Received: by mail-wr1-f70.google.com with SMTP id w11-20020adf8bcb000000b0020c550ba8d7so2582389wra.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 06:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntfBkmjNjhrxvA8xhvwrtXUPZhy6WpJ5yDdT5A+/C00=;
        b=wy4LGJ+M1ecrJUPUDus+xcBwP5L8UWWgtnMiz7zAyKAmHNqzSkZYA/+AZiV2/vQInQ
         M5VWj6szW8iyA8gfWqZ2eeiw8XCcaUPHKfSEIh24MeLUo67qIIQkjAihOzHMJtMeBTHQ
         jtBHy5kdz/PDCLGcVE0ptXX8T9uQjUk5zZWvvw3MMMRBAAAvBZrAwpHhVLbIjIl8jSwc
         qk5A+W5iCpq9FJOt5K5h6okusgcUihuwWCdb06J2xjYsg9+o6zYhQw9azOBtM/zniaMn
         bZMiIzdzMk8CD/8HoYkRTnEg0M+7mZMoOrnreWuy8doMtnjGjk1HJnQIdtWdxjerpcei
         WFHg==
X-Gm-Message-State: AOAM533v6cQLTBfET1tPW9mEfLofSCU9MQL/5xrJcn2c2CJZZr1w1AYG
        IhwvBE2H75COqN188fwxZBg4YWsCyq1aSwtMGebM+r0MVvse4sn3kcvzLBxWoJLglv9V9n2wNLn
        C95o5WWZq6KdxUBUpO97mpW3EXp/io/fzinYwvJ8ZXavBuWeT8OjCLC9TLLVM3wYkgmKmEdPgVE
        s=
X-Received: by 2002:a05:600c:20e:b0:394:2985:6d0c with SMTP id 14-20020a05600c020e00b0039429856d0cmr9784124wmi.106.1651843362262;
        Fri, 06 May 2022 06:22:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoBGIqiXlxsybVbyUOYtj+ac6M3xoMutesjNKS5Waxldl///9zmVAj4E/EHzyx2X+CmF9+Qw==
X-Received: by 2002:a05:600c:20e:b0:394:2985:6d0c with SMTP id 14-20020a05600c020e00b0039429856d0cmr9784085wmi.106.1651843361915;
        Fri, 06 May 2022 06:22:41 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bcf10000000b003942a244f54sm10378255wmg.45.2022.05.06.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:22:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, intel-gfx@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] fbdev: efifb: Fix a use-after-free due early fb_info cleanup
Date:   Fri,  6 May 2022 15:22:25 +0200
Message-Id: <20220506132225.588379-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Commit d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather
than .remove") attempted to fix a use-after-free error due driver freeing
the fb_info in the .remove handler instead of doing it in .fb_destroy.

But ironically that change introduced yet another use-after-free since the
fb_info was still used after the free.

This should fix for good by freeing the fb_info at the end of the handler.

Fixes: d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove")
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reported-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/efifb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index cfa3dc0b4eee..b3d5f884c544 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -259,12 +259,12 @@ static void efifb_destroy(struct fb_info *info)
 			memunmap(info->screen_base);
 	}
 
-	framebuffer_release(info);
-
 	if (request_mem_succeeded)
 		release_mem_region(info->apertures->ranges[0].base,
 				   info->apertures->ranges[0].size);
 	fb_dealloc_cmap(&info->cmap);
+
+	framebuffer_release(info);
 }
 
 static const struct fb_ops efifb_ops = {
-- 
2.35.1

