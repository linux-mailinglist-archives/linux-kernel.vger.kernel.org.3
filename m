Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46E58AD20
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbiHEPjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiHEPjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:39:13 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C826137
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:39:07 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m22so2093177qkm.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=XWdKJtSiozQ70DGJ4SJK+YBLTsE+4EZxsOCD/tHtlh4=;
        b=YCw1bWibZwOXQSuvoLpFd2Z+DE3sgK7sZam5PuffvnQnjLEC1p1qD74U4m3w4pDD48
         DP5aCA2hPGIOXbfURa88lZtX56fJ1h9jfZKVqNZO0mq3w3EhWk7pOgvqquvsuv0xa3Gm
         FH4Ddzl06ZKB/F9HUsDgjikWzkMioEnXOxAipXsW82j0xsqUYVVsQH/gTkFS87fwoPy2
         pwkbdENXHvG4i/Kyh9vzi+XjEVNxUh8iJYFG+u5/GsTrEOxQqAWgI0aF/DuWzfP252O0
         1LT6CeWmUop6NxesrCcNySFa4ubexV5XppbAylrO6OgZzbHZHxyFm7Wct5Mjay4Cidzu
         uzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XWdKJtSiozQ70DGJ4SJK+YBLTsE+4EZxsOCD/tHtlh4=;
        b=JMvyStHZ4QmmVzriEdRN0Cu4KzVMao2lQR1qnHlBn5ekbzZ5IvKGhl7LFYxsz/K/Ca
         YfhKkq7JgQKnK2w8uklikcMzHJz319PtR3Cirtj3HNH5t92pW1c9VI7SNbj8x8dWYi2i
         Dlp+EtS1SEEQK+4lmTeBsy6q3D8vou5cqfdOYwmPE9jHwEGnWtOMtwWwcE+peZ6N3rZG
         tDErDVWC6jM4961gEorGumCBp8M0A/moqD07Zbn9ML+6iCNiU9bbGgjlqU743t0VZZct
         eF+aD+Y5/O2n0n/1pdIC+0HRc2Ac+JORSvjF2Q9iO2/0IxpLU1tDDAgoGfMwBQODP7iH
         UvOA==
X-Gm-Message-State: ACgBeo1ivXC9xsPWkqdApgngLFzmEDgwAUSiTlVJtHeNgPBeh3UJu2GW
        ZEHstwxmjLxds1cZ2uAYi9UDGw==
X-Google-Smtp-Source: AA6agR51ei6GurEs0M9DhatE2fGKS708lYmr02CZNRVsHvRIoEDyFNJJzI1xU07ESj7aI0aSsyiguA==
X-Received: by 2002:a05:620a:1986:b0:6b8:6cef:6cc with SMTP id bm6-20020a05620a198600b006b86cef06ccmr5774035qkb.482.1659713946048;
        Fri, 05 Aug 2022 08:39:06 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id z7-20020ac87ca7000000b00304fc3d144esm2810269qtv.1.2022.08.05.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:39:05 -0700 (PDT)
Date:   Fri, 5 Aug 2022 15:39:05 +0000
From:   Sean Paul <sean@poorly.run>
To:     Jim Shargo <jshargo@chromium.org>
Cc:     jshargo@google.com,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/vkms: Merge default_config and device
Message-ID: <Yu05mVn6qyShEykr@art_vandelay>
References: <20220722213214.1377835-1-jshargo@chromium.org>
 <20220722213214.1377835-2-jshargo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722213214.1377835-2-jshargo@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 05:32:09PM -0400, Jim Shargo wrote:
> This is a small refactor to make ConfigFS support easier.
> 
> vkms_config is now a member of vkms_device and we now store a top-level
> reference to vkms_device.
> 
> This should be a no-op refactor.
> 
> Signed-off-by: Jim Shargo <jshargo@chromium.org>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c    | 58 +++++++++---------------------
>  drivers/gpu/drm/vkms/vkms_drv.h    |  5 ++-
>  drivers/gpu/drm/vkms/vkms_output.c |  6 ++--
>  3 files changed, 22 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 0ffe5f0e33f7..81ed9417e511 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -37,7 +37,7 @@
>  #define DRIVER_MAJOR	1
>  #define DRIVER_MINOR	0
>  
> -static struct vkms_config *default_config;
> +static struct vkms_device *vkms_device;

I think this should be stored in the platform device data on registration as
opposed to a global.

>  
>  static bool enable_cursor = true;
>  module_param_named(enable_cursor, enable_cursor, bool, 0444);
> @@ -91,13 +91,9 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
>  
>  static int vkms_config_show(struct seq_file *m, void *data)
>  {
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
> -
> -	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
> -	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
> -	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
> +	seq_printf(m, "writeback=%d\n", vkms_device->config.writeback);
> +	seq_printf(m, "cursor=%d\n", vkms_device->config.cursor);
> +	seq_printf(m, "overlay=%d\n", vkms_device->config.overlay);
>  
>  	return 0;
>  }
> @@ -158,11 +154,10 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
>  	return vkms_output_init(vkmsdev, 0);
>  }
>  
> -static int vkms_create(struct vkms_config *config)
> +static int vkms_create(void)
>  {
>  	int ret;
>  	struct platform_device *pdev;
> -	struct vkms_device *vkms_device;
>  
>  	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
>  	if (IS_ERR(pdev))
> @@ -179,9 +174,11 @@ static int vkms_create(struct vkms_config *config)
>  		ret = PTR_ERR(vkms_device);
>  		goto out_devres;
>  	}
> +	

In order to avoid the vkms_device global you would call platform_set_drvdata()
here and use platform_get_drvdata() to retrieve it elsewhere.

>  	vkms_device->platform = pdev;
> -	vkms_device->config = config;
> -	config->dev = vkms_device;
> +	vkms_device->config.cursor = enable_cursor;
> +	vkms_device->config.writeback = enable_writeback;
> +	vkms_device->config.overlay = enable_overlay;
>  
>  	ret = dma_coerce_mask_and_coherent(vkms_device->drm.dev,
>  					   DMA_BIT_MASK(64));
> @@ -207,6 +204,8 @@ static int vkms_create(struct vkms_config *config)
>  
>  	drm_fbdev_generic_setup(&vkms_device->drm, 0);
>  
> +	vkms_device->initialized = true;
> +

Do we really need this? If so, is there a race between this and the check in vkms_exit(), or do you get serialization for free from module init/exit?

>  	return 0;
>  
>  out_devres:
> @@ -218,46 +217,23 @@ static int vkms_create(struct vkms_config *config)
>  
>  static int __init vkms_init(void)
>  {
> -	struct vkms_config *config;
> -
> -	config = kmalloc(sizeof(*config), GFP_KERNEL);
> -	if (!config)
> -		return -ENOMEM;
> -
> -	default_config = config;
> -
> -	config->cursor = enable_cursor;
> -	config->writeback = enable_writeback;
> -	config->overlay = enable_overlay;
> -
> -	return vkms_create(config);
> +	return vkms_create();
>  }
>  
> -static void vkms_destroy(struct vkms_config *config)
> +static void __exit vkms_exit(void)
>  {
>  	struct platform_device *pdev;
>  
> -	if (!config->dev) {
> -		DRM_INFO("vkms_device is NULL.\n");
> +	if (!vkms_device || !vkms_device->initialized) {
>  		return;
>  	}
>  
> -	pdev = config->dev->platform;
> +	pdev = vkms_device->platform;
>  
> -	drm_dev_unregister(&config->dev->drm);
> -	drm_atomic_helper_shutdown(&config->dev->drm);
> +	drm_dev_unregister(&vkms_device->drm);
> +	drm_atomic_helper_shutdown(&vkms_device->drm);
>  	devres_release_group(&pdev->dev, NULL);
>  	platform_device_unregister(pdev);
> -
> -	config->dev = NULL;
> -}
> -
> -static void __exit vkms_exit(void)
> -{
> -	if (default_config->dev)
> -		vkms_destroy(default_config);
> -
> -	kfree(default_config);
>  }
>  
>  module_init(vkms_init);
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 91e63b12f60f..c7ebc4ee6b14 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -99,15 +99,14 @@ struct vkms_config {
>  	bool writeback;
>  	bool cursor;
>  	bool overlay;
> -	/* only set when instantiated */
> -	struct vkms_device *dev;
>  };
>  
>  struct vkms_device {
>  	struct drm_device drm;
>  	struct platform_device *platform;
>  	struct vkms_output output;
> -	const struct vkms_config *config;
> +	struct vkms_config config;
> +	bool initialized;
>  };
>  
>  #define drm_crtc_to_vkms_output(target) \
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index ba0e82ae549a..d0061c82003a 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -63,7 +63,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  	if (IS_ERR(primary))
>  		return PTR_ERR(primary);
>  
> -	if (vkmsdev->config->overlay) {
> +	if (vkmsdev->config.overlay) {
>  		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
>  			ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
>  			if (ret)
> @@ -71,7 +71,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  		}
>  	}
>  
> -	if (vkmsdev->config->cursor) {
> +	if (vkmsdev->config.cursor) {
>  		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
>  		if (IS_ERR(cursor))
>  			return PTR_ERR(cursor);
> @@ -103,7 +103,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  		goto err_attach;
>  	}
>  
> -	if (vkmsdev->config->writeback) {
> +	if (vkmsdev->config.writeback) {
>  		writeback = vkms_enable_writeback_connector(vkmsdev);
>  		if (writeback)
>  			DRM_ERROR("Failed to init writeback connector\n");
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
