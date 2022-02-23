Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999D04C1C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244452AbiBWTiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiBWTiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41F1B48E62
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645645069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N/l3oCj67GUwlDfyFRu9RXhbDrMuZBvOYEDah0hu0xk=;
        b=KbbsA2QgZ3qDgYCdd+1zy2HQJzyrAfQuGOieL8U6mtDwdvpvqg5oT4Un8WGPWNi1wq9jZi
        7gzgkjrFvMmY+9THMmRq9pGh/1wrAhTnrCERxdZQTeHAL20TFjxKPZcq7wO3y2C3+s9NSG
        uLopAH+lA4tCoo759d19979Fi1890IU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-QoJ-i34YO4OBuUzsg-8scQ-1; Wed, 23 Feb 2022 14:37:48 -0500
X-MC-Unique: QoJ-i34YO4OBuUzsg-8scQ-1
Received: by mail-wm1-f72.google.com with SMTP id v125-20020a1cac83000000b0037e3d70e7e1so1565603wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/l3oCj67GUwlDfyFRu9RXhbDrMuZBvOYEDah0hu0xk=;
        b=M16JETmtQ1m5R779HEHdVkWnKjbL8gQzpLpPqvB6o/VTHwrU+tFQ+ySwXo0Qj/I9so
         b9RIbH8IaFshU+4yzfpLnmohiFswpGZIjI1LSgwPXPePHvMsJWN+7SxWx60prAXfadhp
         lay+dqqnHI9YIEitExMFqon4ttHQ1TzseqGgm62YLk2G9BMeNu0q4LRDlOqe4nF5QILu
         sL26n2N59HwOWehl6Kxf7hchU6NNFIKDHzMOH0ft5X1E2Nn+cVEyo27RLrbNngFqIIgh
         kU03wxQ4dCQ9jagQIhSOWMfDK4H7LyX7tQ0CfaPlvlyLVEvtG/TWU4rccser+7xxBb7a
         jRpA==
X-Gm-Message-State: AOAM532EzGO2ZeOhZClQubuKTF0Sr13Avkfrmb5CMRInq5aNOARPT6C4
        OPwc9FhC60qgQGNRONzC/8TS2cWZSMVDvFvkl6JQOaylS5LZQ+qLefCcZAdMjqQKZNeEunGzycr
        +NNTQZKJfc9JpBH9VfWKWt0FncouakUawwxVAJQGxWmW9PpCMl3hZRExBFDF8jSMA29z1Akr3Nn
        8=
X-Received: by 2002:a5d:4450:0:b0:1e6:8d72:b88e with SMTP id x16-20020a5d4450000000b001e68d72b88emr865459wrr.632.1645645066695;
        Wed, 23 Feb 2022 11:37:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3dlcQ4rDmWCLTRjmi51tojX5NlBHrp66hbYXNYrBhpSKQ+FebzA6eKdmARYqeDYgmhj79ow==
X-Received: by 2002:a5d:4450:0:b0:1e6:8d72:b88e with SMTP id x16-20020a5d4450000000b001e68d72b88emr865433wrr.632.1645645066320;
        Wed, 23 Feb 2022 11:37:46 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v9sm511346wrx.27.2022.02.23.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:37:45 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/repaper: Use format helper for xrgb8888 to monochrome conversion
Date:   Wed, 23 Feb 2022 20:37:35 +0100
Message-Id: <20220223193735.213185-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now a drm_fb_xrgb8888_to_mono_reversed() helper function to do
format conversion from XRGB8888 to reversed monochrome.

Use that helper and remove the open coded version in the repaper driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

This was only built tested because I don't have access to the hardware.

 drivers/gpu/drm/tiny/repaper.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 97a775c48cea..5c74e236b16d 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -508,26 +508,6 @@ static void repaper_get_temperature(struct repaper_epd *epd)
 	epd->factored_stage_time = epd->stage_time * factor10x / 10;
 }
 
-static void repaper_gray8_to_mono_reversed(u8 *buf, u32 width, u32 height)
-{
-	u8 *gray8 = buf, *mono = buf;
-	int y, xb, i;
-
-	for (y = 0; y < height; y++)
-		for (xb = 0; xb < width / 8; xb++) {
-			u8 byte = 0x00;
-
-			for (i = 0; i < 8; i++) {
-				int x = xb * 8 + i;
-
-				byte >>= 1;
-				if (gray8[y * width + x] >> 7)
-					byte |= BIT(7);
-			}
-			*mono++ = byte;
-		}
-}
-
 static int repaper_fb_dirty(struct drm_framebuffer *fb)
 {
 	struct drm_gem_cma_object *cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
@@ -560,12 +540,10 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb)
 	if (ret)
 		goto out_free;
 
-	drm_fb_xrgb8888_to_gray8(buf, 0, cma_obj->vaddr, fb, &clip);
+	drm_fb_xrgb8888_to_mono_reversed(buf, 0, cma_obj->vaddr, fb, &clip);
 
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
 
-	repaper_gray8_to_mono_reversed(buf, fb->width, fb->height);
-
 	if (epd->partial) {
 		repaper_frame_data_repeat(epd, buf, epd->current_frame,
 					  REPAPER_NORMAL);
-- 
2.34.1

