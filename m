Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AEB4F7B06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiDGJKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbiDGJKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:10:06 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EAD12C9C1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:08:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w18so5576441edi.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=tii6bmJW9q55jraQmqHw5/idP+ltcE2ABPemNM804dw=;
        b=d8NY3NEzkBkOOnx/540Vv7+vhzPjQIzJR7MP2cGJi36CjQNjQxQZe9D0NcJm3aLrUU
         7wHgNikyxzQlxUvrhu/bEjik7VXhE7Dod+c64jjBDTCbwdHcxgmEXtdXh07U3cEZ/1V7
         SmGZfZQBtkjZSr1TrudQYHmWhY7b5sJUOH4GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=tii6bmJW9q55jraQmqHw5/idP+ltcE2ABPemNM804dw=;
        b=qpeRgXf5lEu+3/wlSM9QFDGwK7kgCUQs2SpSjhGdxMpkzNS3OOPMBtOps4xd4h3gy1
         LBvThndT5FDZH3qOAQB28oHL771hskVcw9SeeQ3CWBuBVSczN4s4GA8ocqhwX9ufZj5Z
         W9lDnIWNZHD9ibHMGQbxsCQFAqzIFqswzxobuLB1aI6GkkAhOGtY0lphJaChWDoB2brS
         /w1Ol2cT5464NJeW8Msf6YNQSA8Ci+eV2djUVcaGpWZXb+LK8E3gbSiJdNdYeJUjp146
         JAvC1AARJvO9+FEEpwEIpkmyDys7ZQjm4hDdJt04aK6lEqk5lGHivd5bzViEn44a4btb
         19bQ==
X-Gm-Message-State: AOAM530oIQrDos1vDiWU2LVCpk46Hu+fw1LdZ17KKGZpnjAaOfzwuJCo
        R9yuDz4dSdtf6IUlyRmZlPLsnQ==
X-Google-Smtp-Source: ABdhPJyQFKkA+eaM9rwNPX5uaaYGzenW769xIFP9frPL0MM1TluJEXSe1dbq2fqxT6/3oclOghqisw==
X-Received: by 2002:a05:6402:34cf:b0:419:75b1:99ad with SMTP id w15-20020a05640234cf00b0041975b199admr13137536edc.228.1649322485763;
        Thu, 07 Apr 2022 02:08:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7470308ejc.218.2022.04.07.02.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:08:05 -0700 (PDT)
Date:   Thu, 7 Apr 2022 11:08:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-fbdev@vger.kernel.org
Subject: Re: [RESEND RFC PATCH 3/5] fbdev: Restart conflicting fb removal
 loop when unregistering devices
Message-ID: <Yk6p86OohLC9wJpj@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-fbdev@vger.kernel.org
References: <20220406213919.600294-1-javierm@redhat.com>
 <20220406213919.600294-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406213919.600294-4-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 11:39:17PM +0200, Javier Martinez Canillas wrote:
> Drivers that want to remove registered conflicting framebuffers prior to
> register their own framebuffer, calls remove_conflicting_framebuffers().
> 
> This function takes the registration_lock mutex, to prevent a races when
> drivers register framebuffer devices. But if a conflicting framebuffer
> device is found, the underlaying platform device is unregistered and this
> will lead to the platform driver .remove callback to be called, which in
> turn will call to the unregister_framebuffer() that takes the same lock.
> 
> To prevent this, a struct fb_info.forced_out field was used as indication
> to unregister_framebuffer() whether the mutex has to be grabbed or not.
> 
> A cleaner solution is to drop the lock before platform_device_unregister()
> so unregister_framebuffer() can take it when called from the fbdev driver,
> and just grab the lock again after the device has been registered and do
> a removal loop restart.
> 
> Since the framebuffer devices will already be removed, the loop would just
> finish when no more conflicting framebuffers are found.
> 
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

It's always entertaining with these things since they can go boom in funny
ways, but need to a least try :-) Recursive locks are just a bit too evil.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
> 
>  drivers/video/fbdev/core/fbmem.c | 21 ++++++++++++++-------
>  include/linux/fb.h               |  1 -
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index b585339509b0..c1bfb8df9cba 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1555,6 +1555,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
>  {
>  	int i;
>  
> +restart_removal:
>  	/* check all firmware fbs and kick off if the base addr overlaps */
>  	for_each_registered_fb(i) {
>  		struct apertures_struct *gen_aper;
> @@ -1582,8 +1583,18 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
>  			 * fix would add code to remove the device from the system.
>  			 */
>  			if (dev_is_platform(device)) {
> -				registered_fb[i]->forced_out = true;
> +				/*
> +				 * Drop the lock since the driver will call to the
> +				 * unregister_framebuffer() function that takes it.
> +				 */
> +				mutex_unlock(&registration_lock);
>  				platform_device_unregister(to_platform_device(device));
> +				mutex_lock(&registration_lock);
> +				/*
> +				 * Restart the removal now that the platform device
> +				 * has been unregistered and its associated fb gone.
> +				 */
> +				goto restart_removal;
>  			} else {
>  				pr_warn("fb%d: cannot remove device\n", i);
>  				do_unregister_framebuffer(registered_fb[i]);
> @@ -1917,13 +1928,9 @@ EXPORT_SYMBOL(register_framebuffer);
>  void
>  unregister_framebuffer(struct fb_info *fb_info)
>  {
> -	bool forced_out = fb_info->forced_out;
> -
> -	if (!forced_out)
> -		mutex_lock(&registration_lock);
> +	mutex_lock(&registration_lock);
>  	do_unregister_framebuffer(fb_info);
> -	if (!forced_out)
> -		mutex_unlock(&registration_lock);
> +	mutex_unlock(&registration_lock);
>  }
>  EXPORT_SYMBOL(unregister_framebuffer);
>  
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 39baa9a70779..f1e0cd751b06 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -503,7 +503,6 @@ struct fb_info {
>  	} *apertures;
>  
>  	bool skip_vt_switch; /* no VT switch on suspend/resume required */
> -	bool forced_out; /* set when being removed by another driver */
>  };
>  
>  static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
