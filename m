Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45730516C90
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383927AbiEBI4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383910AbiEBI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46AC757B3B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651481587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RFdAbAFC6hVBQLu+NPQWCbO+3EFmV4d5chrstqJm+WU=;
        b=PekSMZ3zNgaAGaDR1kR8bSece3TILM9d+pnh1BCj6lHRl79GNCwjmueHClPAG3sed2+C+D
        x+bB4gOJXYH+QHUT9IBbMoCr8W7OMlcNokABEUxK3EtaKcLYt9LsLm2+NzQJ8Vhd7IvTJR
        hqQdntPUs+Qq6Nf/ybbhGvRyyJ8lgCc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-nLYshxRlM92lqkSiSh7T-g-1; Mon, 02 May 2022 04:53:06 -0400
X-MC-Unique: nLYshxRlM92lqkSiSh7T-g-1
Received: by mail-wm1-f70.google.com with SMTP id v191-20020a1cacc8000000b0038ce818d2efso4848014wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 01:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFdAbAFC6hVBQLu+NPQWCbO+3EFmV4d5chrstqJm+WU=;
        b=g5WOEn4PoLkvRphgx/qT1SRSpfmaPKUusymzR8X2ozMASKwQb3jAziD1DPRq66aV5s
         4n1glcN22QwszPMF4wUA0aBoqREg65ooQfU7L5qo8iw8szEXmGqqqCmZxYvnRCpQgJo/
         g4gTec6iaSnFagXs9rbD/2/vUq1Y5eT62WpWdyrdaLjI/hChTi2KaqrKAXAb706LurZL
         qswPhTKUKlz2QB3YAx6rnqqOIrBlBkvuv0Dfon6VHNImbyRB5bZN+8+7D9hxzMmuDXGQ
         foYElTowr9BxKctzLuBpBUx+cB4I5dMy3zlc1z0+/48gmh/SNog1EYx2Rt42ncEc7K+m
         4e1Q==
X-Gm-Message-State: AOAM531Y839k/5SR2uBE64ViKLw++JHYJJN+Pyi52M0hF62MkroA5J37
        7Hk9fuUX7AFIBviJn57Vy+i6KE1U6ZMHlwLIMbTRAk+Lze8o7KuU+D0gp/7wrj4gk5h2WvDs+MQ
        TyATfLaK92Dgb4Gm6lgxuZsoDxk9CZ65X/z44QIzie1ikZTs8pDGgyGkkkBPDU3vPI4ClirqA/+
        A=
X-Received: by 2002:a05:600c:6022:b0:394:3943:dd61 with SMTP id az34-20020a05600c602200b003943943dd61mr4082576wmb.196.1651481585184;
        Mon, 02 May 2022 01:53:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwAdCi1b+GagstF4L/akza3x40XLpRMN8KNh6WPEAQN0F84cne1/xuXbVNcY/l5tbIzjtp6A==
X-Received: by 2002:a05:600c:6022:b0:394:3943:dd61 with SMTP id az34-20020a05600c602200b003943943dd61mr4082552wmb.196.1651481584883;
        Mon, 02 May 2022 01:53:04 -0700 (PDT)
Received: from minerva.. ([90.167.94.74])
        by smtp.gmail.com with ESMTPSA id c1-20020adfc041000000b0020c5253d8desm6823400wrf.42.2022.05.02.01.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 01:53:04 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 3/3] drm: Allow simpledrm to setup its emulated FB as firmware provided
Date:   Mon,  2 May 2022 10:52:59 +0200
Message-Id: <20220502085259.286590-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502084830.285639-1-javierm@redhat.com>
References: <20220502084830.285639-1-javierm@redhat.com>
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

Indicate to fbdev subsystem that the registered framebuffer is provided by
the system firmware, so that it can handle accordingly. For example, would
unregister the FB devices if asked to remove the conflicting framebuffers.

Add a new DRM_FB_FW field to drm_fbdev_generic_setup() options parameter.
Drivers can use this to indicate the FB helper initialization that the FB
registered is provided by the firmware, so it can be configured as such.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_fb_helper.c  |  9 +++++++++
 drivers/gpu/drm/tiny/simpledrm.c |  2 +-
 include/drm/drm_fb_helper.h      | 10 ++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index f626947bb9b9..c2ff986f064d 100644
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
@@ -2511,6 +2515,8 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
  *
  * * DRM_FB_BPP: bits per pixel for the device. If the field is not set,
  *               @dev->mode_config.preferred_depth is used instead.
+ * * DRM_FB_FW:  if the framebuffer for the device is provided by the
+ *               system firmware.
  *
  * This function sets up generic fbdev emulation for drivers that supports
  * dumb buffers with a virtual address and that can be mmap'ed.
@@ -2537,6 +2543,7 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
 {
 	struct drm_fb_helper *fb_helper;
 	unsigned int preferred_bpp = DRM_FB_GET_OPTION(DRM_FB_BPP, options);
+	bool firmware = DRM_FB_GET_OPTION(DRM_FB_FW, options);
 	int ret;
 
 	drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
@@ -2569,6 +2576,8 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
 		preferred_bpp = 32;
 	fb_helper->preferred_bpp = preferred_bpp;
 
+	fb_helper->firmware = firmware;
+
 	ret = drm_fbdev_client_hotplug(&fb_helper->client);
 	if (ret)
 		drm_dbg_kms(dev, "client hotplug ret=%d\n", ret);
diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index f5b8e864a5cd..5dcc21ea6180 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -901,7 +901,7 @@ static int simpledrm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	drm_fbdev_generic_setup(dev, 0);
+	drm_fbdev_generic_setup(dev, DRM_FB_SET_OPTION(DRM_FB_FW, 1));
 
 	return 0;
 }
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 1da3ef76f499..0eec500e0784 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -44,6 +44,7 @@ enum mode_set_atomic {
 };
 
 #define DRM_FB_BPP_MASK GENMASK(7, 0)
+#define DRM_FB_FW_MASK GENMASK(8, 8)
 
 /* Using the GNU statement expression extension */
 #define DRM_FB_SET_OPTION(option, value)			\
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

