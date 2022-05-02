Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070C35172F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385920AbiEBPmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385910AbiEBPmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D930B1C1
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651505951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjxoxE0JKElHTb/WpKcB2BiZO2PHnuo9tVxz/TUikho=;
        b=OHAzUaShyqDqw/WmKCKrrPFv7fjin1UMiqeVAQCBiMiRFpEAYBwat9wrNmRileC9L1edLk
        me6EBgWvx2Bbhx2AUy1n8YWNXkL1hiiNvQvYCgF2qW4YLa1rUrXmJfycmqUmbykSg07fXX
        oirhFEyNjkG/xL3q2NGwoiBAcPZNutU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-2h71-vQwNyeJSFnqCklaNg-1; Mon, 02 May 2022 11:39:10 -0400
X-MC-Unique: 2h71-vQwNyeJSFnqCklaNg-1
Received: by mail-wr1-f70.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so5416241wrg.19
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 08:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjxoxE0JKElHTb/WpKcB2BiZO2PHnuo9tVxz/TUikho=;
        b=NPC4aqVDyLgpGgw3iGarGZylpHfiD2VSBmuAqUIWFGR96MaOYnHI8jaslCojdn7LBn
         EOlCmbsQkM3gvJ52AQ/2mck8cWJv0PVikOMvvX6qxzFaM9cNZ6K7N7fQFTXVsp0s4GCF
         +q+MQAr1fb1eWPgczuxuo/8zVD6+ZuMuyZBu+x53OgZmhe/Ck4DeMjMmTZ5MexQZkEJv
         P82tHoEIy+Btq9X9gpkZAcI1LeWKyKI8gIpoootSsEJ4nbckNuHZ0eaLU5+SqbQCt+l6
         mDDBYJB0vCpTW6OFIFynalWO5BxMlAwIMC6wgCiD9ttWbpafupeEWJmCPyJn1OugAuWX
         KqGw==
X-Gm-Message-State: AOAM5321cU8OFSwmMc5VWNyx1NgHmJT1H8W8ak1VQZLHnMEsx88QK/yX
        ezoaK/FupjI2eVPdDC58M10TLamNgdEVOZhqdZtsYEIgdDV5NY6FwQlJ1GQXDkFqW40zFocTByT
        gHeQnXgScZnDEcqFP/ALbgs68Q+CKoWJ1+RdvPEUY25vDokVyHTX4qd8A2qixLu/e2Sy5iW1Qyn
        k=
X-Received: by 2002:adf:f4c5:0:b0:20a:ece1:1e91 with SMTP id h5-20020adff4c5000000b0020aece11e91mr9894288wrp.172.1651505948866;
        Mon, 02 May 2022 08:39:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3Da6qZWFhP++jyhVMD/l4xJcEKuWzBbFQeF2rJfhQtQ7IqvFSHRl36OTYCsrPs3Om4eZVZw==
X-Received: by 2002:adf:f4c5:0:b0:20a:ece1:1e91 with SMTP id h5-20020adff4c5000000b0020aece11e91mr9894274wrp.172.1651505948606;
        Mon, 02 May 2022 08:39:08 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v28-20020adfa1dc000000b0020c5253d923sm7294489wrv.111.2022.05.02.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 08:39:06 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/3] drm: Allow simpledrm to setup its emulated FB as firmware provided
Date:   Mon,  2 May 2022 17:39:00 +0200
Message-Id: <20220502153900.408522-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502153900.408522-1-javierm@redhat.com>
References: <20220502153900.408522-1-javierm@redhat.com>
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
---

(no changes since v1)

 drivers/gpu/drm/drm_fb_helper.c  |  9 +++++++++
 drivers/gpu/drm/tiny/simpledrm.c |  2 +-
 include/drm/drm_fb_helper.h      | 10 ++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index fd0084ad77c3..775e47c5de1f 100644
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
@@ -2538,6 +2544,7 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
 {
 	struct drm_fb_helper *fb_helper;
 	unsigned int preferred_bpp = DRM_FB_GET_OPTION(DRM_FB_BPP, options);
+	bool firmware = DRM_FB_GET_OPTION(DRM_FB_FW, options);
 	int ret;
 
 	drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
@@ -2570,6 +2577,8 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
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
index 740f87560102..77a72d55308d 100644
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

