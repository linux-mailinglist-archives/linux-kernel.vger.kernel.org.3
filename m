Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99D55820B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiG0HI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiG0HI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:08:26 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DC53135D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:08:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x11so12028979qts.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pyyO3i1v16awzlQfFzZWgMicARjUE5W8d3bIsv/OgNE=;
        b=mJFiwyzHl75IMZ8ucjWQXx6hvsV4XWr5nHjqYFHrjRKyhGKgh948OvOKF9+y/ZtevT
         YbF6R8O855DD/LtEHZ0KY8BQp4g1HgHeCgi7TTPXNf06zAOr+EoSi5Q5o2EIBggI78H+
         JLRduYEAy2fDKRwMjhOkzuziXSGvbHXLj2+uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyyO3i1v16awzlQfFzZWgMicARjUE5W8d3bIsv/OgNE=;
        b=rTGy5dcr2gmYwVh8kXwx2oICkf+hZjjT0gTo3WqWIkIEG9YTifM7fUgX+rtx1CGNJ6
         tNzf0zxXHsFTENtEFjf6T7FWzKHjyRw5XpqoWLYx7obwQ0bcKGB2K3t2zLSVgLEbr9JI
         U5vSuL/ZIC6fOBruADEJU56f6eMFP4BCzi1+Qnrr+Q5PNtmgvRODS5KEpH1CLuW57SDw
         290oL3SbBi1MqkvSrOWusOtl1C+b5w0hufkReHWysWAKxJwAeu5xAKfDiKhtpZnB8Vtj
         lZFmTX8VldFtiNxgbzmKr2MCU23yapyIDrGYn2hNztvzPSdSdjs3n0LatRk1MU2kb2yk
         h7rg==
X-Gm-Message-State: AJIora/OpqlLjxT95UG0XqPoMeJlm+ZdPiGcWVHuwQMXWmkq8Z96rouc
        xgKdPGrKciqYNegnVsANUsQOQQ==
X-Google-Smtp-Source: AGRyM1sKKtleTGian1VChNl553V9Yw0pvi8UIZxWLqXfq44/w+W/AU43ZicsJpg0Tc6g6tlY2AolQw==
X-Received: by 2002:a05:622a:44e:b0:31f:4cf7:3abc with SMTP id o14-20020a05622a044e00b0031f4cf73abcmr31806qtx.124.1658905703974;
        Wed, 27 Jul 2022 00:08:23 -0700 (PDT)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id f14-20020a05620a280e00b006b5bf5d45casm12585198qkp.27.2022.07.27.00.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 00:08:23 -0700 (PDT)
From:   Peter Suti <peter.suti@streamunlimited.com>
To:     chuansheng.liu@intel.com, dan.carpenter@oracle.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Peter Suti <peter.suti@streamunlimited.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: fbtft: core: set smem_len before fb_deferred_io_init call
Date:   Wed, 27 Jul 2022 09:07:23 +0200
Message-Id: <20220727070723.1489599-1-peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726161347.GR2338@kadam>
References: <20220726161347.GR2338@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fbtft_framebuffer_alloc() calls fb_deferred_io_init() before
initializing info->fix.smem_len.  It is set to zero by the
framebuffer_alloc() function.  It will trigger a WARN_ON() at the
start of fb_deferred_io_init() and the function will not do anything.

Fixes: 856082f021a2 ("fbdev: defio: fix the pagelist corruption")

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
---
 drivers/staging/fbtft/fbtft-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 9b3eaed80cdd..afaba94d1d1c 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -654,7 +654,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	fbdefio->delay =            HZ / fps;
 	fbdefio->sort_pagereflist = true;
 	fbdefio->deferred_io =      fbtft_deferred_io;
-	fb_deferred_io_init(info);
 
 	snprintf(info->fix.id, sizeof(info->fix.id), "%s", dev->driver->name);
 	info->fix.type =           FB_TYPE_PACKED_PIXELS;
@@ -665,6 +664,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	info->fix.line_length =    width * bpp / 8;
 	info->fix.accel =          FB_ACCEL_NONE;
 	info->fix.smem_len =       vmem_size;
+	fb_deferred_io_init(info);
 
 	info->var.rotate =         pdata->rotate;
 	info->var.xres =           width;
-- 
2.25.1

