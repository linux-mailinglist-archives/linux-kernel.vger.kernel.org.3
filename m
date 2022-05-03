Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8BF517E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiECHUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiECHTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90A4B2D1D6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651562155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7Xo+XfuxpwgRvmh+x+4llEf06yjZT56T0kzU1GhsAM=;
        b=gGzpUKbEHv6eL/NhtrlFojh6SQwqzJd9sSNxI1qe027y2Yhzg/3oCNI7psBV31AyErzrCf
        rh/QZzF0zEJdwfyf0h9UdpMWroASfwLuZ6KEorFaNm0nmGqznJMvIJuvtM9VLtcCnAogAq
        Ho0ubciKo8DGf29nV0dYqOfbQdIwiXc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-g89Av_XDM76u8LCGAQDmxw-1; Tue, 03 May 2022 03:15:54 -0400
X-MC-Unique: g89Av_XDM76u8LCGAQDmxw-1
Received: by mail-wr1-f70.google.com with SMTP id g7-20020adfbc87000000b0020ac76d254bso6066057wrh.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7Xo+XfuxpwgRvmh+x+4llEf06yjZT56T0kzU1GhsAM=;
        b=sybjwLb5ofPSfJMUwVO2606MIA1fX3S3n527ascG7L9KuZDNU1UUgsXoc/OqowZZkI
         /gplsviFeqtCJAmZ/vZDNf8k7iPJnWfVsh/xq4rYDmZPBEWu+YOcbWumIMse7Jlw9UhG
         qG7Mu+vMcnX+tjxl/8W0wDpJBvHq9sJJlG8/kwjgFPUy0hZcLS/V+yDEsENohegs155M
         wpm5QTtYfrZC/Dw6uFWUJSm3a9CD9E8Sx+w2w0MG58QijQ2bHXJagPyrVZDccOGNy+UN
         mLRrBba4AdYDXq2AjlhDA8OlUG1CtTA8o9NqXZ7+GV5+WOlvDpZCvWqlsuOdb3hGteiU
         EeOg==
X-Gm-Message-State: AOAM532IP2XW2LvpwLSftnGOCBBhacuc5Zn7+3IGUHzUcM1ueOz2bffT
        L92PIo/S63ZJzObAH8jxzK2BA0W3KBYXGY8Azos0OcxCCgIqQFJCShaBmMTkrze5xuMz6D2Uhnk
        P4V6Yc4mF/g0PbGJWqZgZ3r+B1YSSjV0udjH+9tVCq7MMzAM8PZpFJPIxhR6yaCkSBeNY79woOQ
        w=
X-Received: by 2002:a05:6000:156a:b0:20c:64e3:948f with SMTP id 10-20020a056000156a00b0020c64e3948fmr5556154wrz.436.1651562153611;
        Tue, 03 May 2022 00:15:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynU4A8UAMBzp9HgBNoyG2MT4qKn8ajICWkatc7Q4nPkcU1AC0+1p+2JSCGZAIYuxarLlCg5w==
X-Received: by 2002:a05:6000:156a:b0:20c:64e3:948f with SMTP id 10-20020a056000156a00b0020c64e3948fmr5556139wrz.436.1651562153365;
        Tue, 03 May 2022 00:15:53 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c339400b003942a244f33sm1035387wmp.12.2022.05.03.00.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 00:15:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/3] drm: Allow simpledrm to setup its emulated FB as firmware provided
Date:   Tue,  3 May 2022 09:15:40 +0200
Message-Id: <20220503071540.471667-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503071540.471667-1-javierm@redhat.com>
References: <20220503071540.471667-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indicate to fbdev subsystem that the registered framebuffer is provided by
the system firmware, so that it can handle accordingly. For example, would
unregister the FB devices if asked to remove the conflicting framebuffers.

Add a new DRM_FB_FW field to drm_fbdev_generic_setup() options parameter.
Drivers can use this to indicate the FB helper initialization that the FB
registered is provided by the firmware, so it can be configured as such.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Changes in v3:
- Drop the firmware local variable (Laurent Pinchart).
- Use DRM_FB_OPTION() since DRM_FB_SET_OPTION() got renamed (kernel test robot).

 drivers/gpu/drm/drm_fb_helper.c  |  8 ++++++++
 drivers/gpu/drm/tiny/simpledrm.c |  2 +-
 include/drm/drm_fb_helper.h      | 10 ++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 52042ba1e4cf..28b21858b726 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1891,6 +1891,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
 		/* don't leak any physical addresses to userspace */
 		info->flags |= FBINFO_HIDE_SMEM_START;
 
+	/* Indicate that the framebuffer is provided by the firmware */
+	if (fb_helper->firmware)
+		info->flags |= FBINFO_MISC_FIRMWARE;
+
 	/* Need to drop locks to avoid recursive deadlock in
 	 * register_framebuffer. This is ok because the only thing left to do is
 	 * register the fbdev emulation instance in kernel_fb_helper_list. */
@@ -2512,6 +2516,8 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
  *
  * * DRM_FB_BPP: bits per pixel for the device. If the field is not set,
  *   @dev->mode_config.preferred_depth is used instead.
+ * * DRM_FB_FW: if the framebuffer for the device is provided by the
+ *   system firmware.
  *
  * This function sets up generic fbdev emulation for drivers that supports
  * dumb buffers with a virtual address and that can be mmap'ed.
@@ -2569,6 +2575,8 @@ void drm_fbdev_generic_setup(struct drm_device *dev, const unsigned int options)
 	if (!fb_helper->preferred_bpp)
 		fb_helper->preferred_bpp = 32;
 
+	fb_helper->firmware = DRM_FB_GET_OPTION(DRM_FB_FW, options);
+
 	ret = drm_fbdev_client_hotplug(&fb_helper->client);
 	if (ret)
 		drm_dbg_kms(dev, "client hotplug ret=%d\n", ret);
diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index f5b8e864a5cd..f6f1c5e108b2 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -901,7 +901,7 @@ static int simpledrm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	drm_fbdev_generic_setup(dev, 0);
+	drm_fbdev_generic_setup(dev, DRM_FB_OPTION(DRM_FB_FW, 1));
 
 	return 0;
 }
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 5fc41cf0c987..5a17af423944 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -44,6 +44,7 @@ enum mode_set_atomic {
 };
 
 #define DRM_FB_BPP_MASK GENMASK(7, 0)
+#define DRM_FB_FW_MASK GENMASK(8, 8)
 
 /* Using the GNU statement expression extension */
 #define DRM_FB_OPTION(option, value)				\
@@ -197,6 +198,15 @@ struct drm_fb_helper {
 	 * See also: @deferred_setup
 	 */
 	int preferred_bpp;
+
+	/**
+	 * @firmware:
+	 *
+	 * Set if the driver indicates to the FB helper initialization that the
+	 * framebuffer for the device being registered is provided by firmware,
+	 * so that it can pass this on when registering the framebuffer device.
+	 */
+	bool firmware;
 };
 
 static inline struct drm_fb_helper *
-- 
2.35.1

