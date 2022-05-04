Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2289519C44
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347762AbiEDJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347567AbiEDJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:51:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6B426565
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:48:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g6so1847550ejw.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YZq9atGlvwHL4dEwvj0CopnhgDQAd2ZXRzQtho9D+5A=;
        b=WFGXkkMXffbA0qaSs2B1o7KhHe69J7OK8AO7HEqxqma2bxjtuy7uFumM7kW0j8qb6f
         YCqSmuDHJ3DBZ/x1l5suMvMcBLzdFlDMru7ZL4S85Pftc04ka3blyXccxtWM/P4MaanM
         5W3KFYRc/7w5EsXKQiEz49k7ou2n3UlIBD61A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YZq9atGlvwHL4dEwvj0CopnhgDQAd2ZXRzQtho9D+5A=;
        b=ZldxvOthKSTvGsretsFIHvhBMayAp9YXYL9Udv9dPML9iL8dzMPw/anGnSAksZ/woh
         HgaEMGw8gavVeRaVD1YOzWjN6EuETg4rC0Z+56ICns3z3kXQ9cKMtKyxRnCz5ehAVRoG
         3+UKCqLAMTmn+mIKEQ9emhoiDni5ZitmtqDqA/tmAvByFmVl71OY+JdHoSuozxvXiAmQ
         vWD361ux839EEqjnmRWHdSV5IVdVMR9R7NTIc0hlZYhndJuemNe5HAzKx3aXPdt2nhv5
         p2u7uIb329GoqLgD+4heT9Bt0g1TYXbPDAxOygQUbADqyMArI9H5qFdHPlB5fKTsWhiD
         PbBA==
X-Gm-Message-State: AOAM53217UUKKfuNli9HVolTx8jFz/3X6t6QQld5B2JEC4Vtr3Lzp66O
        nBYHI005REJh/QFns0IerzHk5Q==
X-Google-Smtp-Source: ABdhPJzqAWkhy8NRWylyo9UZc1cM9O+xCPSTXudw+0/AIIaP29QmmUWuYV9rEXWaQnyQMurfR+nxZA==
X-Received: by 2002:a17:907:97c9:b0:6db:ab53:1fdf with SMTP id js9-20020a17090797c900b006dbab531fdfmr20024148ejc.406.1651657680230;
        Wed, 04 May 2022 02:48:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l24-20020a056402029800b0042617ba63a7sm9006631edv.49.2022.05.04.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 02:47:59 -0700 (PDT)
Date:   Wed, 4 May 2022 11:47:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] fbdev: Make fb_release() return -ENODEV if fbdev was
 unregistered
Message-ID: <YnJLzY7Yiax/AwMx@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220502130944.363776-1-javierm@redhat.com>
 <20220502130944.363776-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502130944.363776-3-javierm@redhat.com>
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

On Mon, May 02, 2022 at 03:09:44PM +0200, Javier Martinez Canillas wrote:
> A reference to the framebuffer device struct fb_info is stored in the file
> private data, but this reference could no longer be valid and must not be
> accessed directly. Instead, the file_fb_info() accessor function must be
> used since it does sanity checking to make sure that the fb_info is valid.
> 
> This can happen for example if the fbdev driver was one that is using a
> framebuffer provided by the system firmware. In that case, the fbdev core
> could unregister the framebuffer device if a real video driver is probed.
> 
> Reported-by: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Doesn't this mean we just leak the references? Also anything the driver
might refcount in fb_open would be leaked too.

I'm not sure what exactly you're trying to fix here, but this looks a bit
wrong.

Maybe stepping back what fbdev would need, but doesn't have (see the
commit reference I dropped on the previous version) is drm_dev_enter/exit
around hw access. the file_fb_info check essentially provides that, but
with races and everything.

But drm_dev_enter/exit should not disable sw side code, especially not
refcount cleanup like fb_release does here.
-Daniel

> ---
> 
>  drivers/video/fbdev/core/fbmem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 20d8929df79f..d68097105f93 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1439,7 +1439,10 @@ fb_release(struct inode *inode, struct file *file)
>  __acquires(&info->lock)
>  __releases(&info->lock)
>  {
> -	struct fb_info * const info = file->private_data;
> +	struct fb_info * const info = file_fb_info(file);
> +
> +	if (!info)
> +		return -ENODEV;
>  
>  	lock_fb_info(info);
>  	if (info->fbops->fb_release)
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
