Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C595401FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbiFGPBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343623AbiFGPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:01:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD03CF551A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:01:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m26so13138194wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9UpbUSyzB5BM/M+IOHSr/KOS4nqjlqBTVH6qCIsqDVs=;
        b=LpTu4x2GrXKwDxfcpNodQTe04DdpSLlrLOY3kKpS21O9BqbEBGczUAopJtSZWS+rJE
         w+aX/ZBiEcD1fIS3zZwbD20JydteRjTmVGPo3dNvlK5829FoEVE+Bmtl1o0DZY11IouJ
         feXlNEUw60xhhZducvrdszMY8YMdy3XVMXQKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9UpbUSyzB5BM/M+IOHSr/KOS4nqjlqBTVH6qCIsqDVs=;
        b=6P1UpCW/MgBj6+fLr9DNxNrzu4OgiwTPKxVnJhVAb1XXPO+5VuMEmLzMYlCqO4m9Vx
         CQ3z9s73kwhEr67+7gZaL1Nic1ZMs1IR4YTNlmY1py4m9e3DCYCNaXcMQobqN+ActKav
         w/0yzun4y8aPKhRz9wGtNgqt5o8lwLKPyaOuE0c8FtaJ0krISurLT0fSy8lXhgyWA/jI
         coM07txw1luTt3oUmZjF9i17SryySOgFOqa4KSJ+0RBddRkUCTvyPGM5H86YJN0Kg5i5
         gsQZFiMEYXq3erdB+kwPdcSkwcOjFOMQtZAM/VJLb6XwAVnm3RMhfBQ/5eDIrO3VfK+j
         0RkA==
X-Gm-Message-State: AOAM532luupq2s63s5o0EKRHDugrDCU0cUFAT36aw9Z+t+1XhARNeSng
        ULaz63pDKNLkCXFUECx8zf8NDg==
X-Google-Smtp-Source: ABdhPJzRSpk+t9rfEmAydcAN7JVl91M+kAWWTZJxeJuODBS8jkdv2bQOh5EfNSmoZ/h89TC2grRi3w==
X-Received: by 2002:a5d:67c9:0:b0:218:4a6a:298e with SMTP id n9-20020a5d67c9000000b002184a6a298emr6424341wrw.153.1654614085040;
        Tue, 07 Jun 2022 08:01:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4643000000b002103a7c5c91sm17684103wrs.43.2022.06.07.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:01:24 -0700 (PDT)
Date:   Tue, 7 Jun 2022 17:01:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 5/7] fbdev: Disable sysfb device registration when
 removing conflicting FBs
Message-ID: <Yp9oLJ/HD2rHxO3z@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511113144.1252729-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511113144.1252729-1-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:31:44PM +0200, Javier Martinez Canillas wrote:
> The platform devices registered by sysfb match with firmware-based DRM or
> fbdev drivers, that are used to have early graphics using a framebuffer
> provided by the system firmware.
> 
> DRM or fbdev drivers later are probed and remove all conflicting framebuffers,
> leading to these platform devices for generic drivers to be unregistered.
> 
> But the current solution has a race, since the sysfb_init() function could
> be called after a DRM or fbdev driver is probed and request to unregister
> the devices for drivers with conflicting framebuffes.
> 
> To prevent this, disable any future sysfb platform device registration by
> calling sysfb_disable(), if a driver requests to remove the conflicting
> framebuffers.
> 
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
> 
> Changes in v5:
> - Move the sysfb_disable() call at conflicting framebuffers again to
>   avoid the need of a DRIVER_FIRMWARE capability flag.
> - Add Daniel Vetter's Reviewed-by tag again since reverted to the old
>   patch that he already reviewed in v2.
> 
> Changes in v3:
> - Call sysfb_disable() when a DRM dev and a fbdev are registered rather
>   than when conflicting framebuffers are removed (Thomas Zimmermann).
> - Call sysfb_disable() when a fbdev framebuffer is registered rather
>   than when conflicting framebuffers are removed (Thomas Zimmermann).
> - Drop Daniel Vetter's Reviewed-by tag since patch changed a lot.
> 
> Changes in v2:
> - Explain in the commit message that fbmem has to unregister the device
>   as fallback if a driver registered the device itself (Daniel Vetter).
> - Also explain that fallback in a comment in the code (Daniel Vetter).
> - Don't encode in fbmem the assumption that sysfb will always register
>   platform devices (Daniel Vetter).
> - Add a FIXME comment about drivers registering devices (Daniel Vetter).
> 
>  drivers/video/fbdev/core/fbmem.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 9b035ef4d552..265efa189bcc 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1789,6 +1789,17 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
>  	if (do_free)
>  		kfree(a);
>  
> +	/*
> +	 * If a driver asked to unregister a platform device registered by
> +	 * sysfb, then can be assumed that this is a driver for a display
> +	 * that is set up by the system firmware and has a generic driver.
> +	 *
> +	 * Drivers for devices that don't have a generic driver will never
> +	 * ask for this, so let's assume that a real driver for the display
> +	 * was already probed and prevent sysfb to register devices later.
> +	 */
> +	sysfb_disable();

So the og version had (or should have had at least) the sysfb_disable()
call before we go through the loop and try to unregister stuff. I think
this needs to be done before we call do_remove_conflicting_framebuffer()
instead. With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(remove_conflicting_framebuffers);
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
