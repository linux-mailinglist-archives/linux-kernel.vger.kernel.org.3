Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182694F7AFE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiDGJIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiDGJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:08:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CEEEA756
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:06:31 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ot30so9378775ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=qH1ao1Sv89tAmypsC25LX+raBksixuJK/BXtSJIZNVY=;
        b=fAbafEwVVzZIPTmi+s1aa1APtfjN/g7TFqYJJOZzKrvIEQeu6qOJhnNCJqurVwYJ06
         8EcvXB9YHcuxOvzk0cFHZ151BJTEG1CYB6t0HmQa/H+LavWbcpGkc76P2b4bYgUT0BPA
         daFv05Ohzp/OQ5GvBvBjz9mY3r7//Lt/9Bl6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=qH1ao1Sv89tAmypsC25LX+raBksixuJK/BXtSJIZNVY=;
        b=3UpwCISGMJ1hz4mkPdjR69D4KGh3jpYIL0PKypPLmlhV704WN5mgB0ExS9046JdQTC
         lT32ABx/LIu+mY4NUEyk5UMMKhHxf4kpb3l85Z+4uDqueffRtDYIZybZrWbzlKFI46w8
         5SEuKLmCKVY8OhMYEKvKVaylfFEJY9Vltl+wLCHqRrUCGls0TUpfsUyloKMjh2236dYN
         EWoY/Nm4X7RIGtkb/bQCTktK0jNXxoCkuNHSa0buvzi6OkAtWi7jmj7bi4BDpFos4LIs
         uGkIfGNgSpuywzxY1jKHUjAmBIT5tR5VfZNbODGZ2JXo0UoTdWOlOqCF0i4VsPWSMcOR
         6yjw==
X-Gm-Message-State: AOAM533za8JEYAvydw4uK6DbjdyRPPuf6S7mBnDxxZhLEwg/ASIyiA5j
        mFSBvncNi1zqrSBgXWN+4GbUYg==
X-Google-Smtp-Source: ABdhPJwrbTfjUAtCuRc4DBgoGgdXi1Z5uzcM1p+RofsjaThjZCGK7xpqEG5zTyD1TduyzO2Z+Butew==
X-Received: by 2002:a17:907:94c6:b0:6da:9561:ce0 with SMTP id dn6-20020a17090794c600b006da95610ce0mr12001579ejc.342.1649322390205;
        Thu, 07 Apr 2022 02:06:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm7415695ejy.165.2022.04.07.02.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:06:29 -0700 (PDT)
Date:   Thu, 7 Apr 2022 11:06:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RESEND RFC PATCH 2/5] firmware: sysfb: Add helpers to
 unregister a pdev and disable registration
Message-ID: <Yk6plGLa+uOb0ZyJ@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220406213919.600294-1-javierm@redhat.com>
 <20220406213919.600294-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406213919.600294-3-javierm@redhat.com>
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

On Wed, Apr 06, 2022 at 11:39:16PM +0200, Javier Martinez Canillas wrote:
> These can be used by subsystems to unregister a platform device registered
> by sysfb and also to disable future platform device registration in sysfb.
> 
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/firmware/sysfb.c | 47 +++++++++++++++++++++++++++++++++++-----
>  include/linux/sysfb.h    | 19 ++++++++++++++++
>  2 files changed, 60 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index b032f40a92de..08ae78c083f1 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -34,21 +34,52 @@
>  #include <linux/screen_info.h>
>  #include <linux/sysfb.h>
>  
> +static struct platform_device *pd;
> +static DEFINE_MUTEX(load_lock);
> +static bool disabled;
> +
> +void sysfb_disable(void)
> +{
> +	mutex_lock(&load_lock);
> +	disabled = true;
> +	mutex_unlock(&load_lock);
> +}
> +EXPORT_SYMBOL_GPL(sysfb_disable);
> +
> +bool sysfb_try_unregister(struct device *dev)
> +{
> +	bool ret = true;
> +
> +	mutex_lock(&load_lock);
> +	if (!pd || pd != to_platform_device(dev))
> +		return false;
> +
> +	platform_device_unregister(to_platform_device(dev));
> +	pd = NULL;
> +	mutex_unlock(&load_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sysfb_try_unregister);

Kerneldoc for these plus adding that to
Documentation/firmware/other_interfaces.rst would be really neat.

With that added Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> +
>  static __init int sysfb_init(void)
>  {
>  	struct screen_info *si = &screen_info;
>  	struct simplefb_platform_data mode;
> -	struct platform_device *pd;
>  	const char *name;
>  	bool compatible;
> -	int ret;
> +	int ret = 0;
> +
> +	mutex_lock(&load_lock);
> +	if (disabled)
> +		goto unlock_mutex;
>  
>  	/* try to create a simple-framebuffer device */
>  	compatible = sysfb_parse_mode(si, &mode);
>  	if (compatible) {
>  		pd = sysfb_create_simplefb(si, &mode);
>  		if (!IS_ERR(pd))
> -			return 0;
> +			goto unlock_mutex;
>  	}
>  
>  	/* if the FB is incompatible, create a legacy framebuffer device */
> @@ -60,8 +91,10 @@ static __init int sysfb_init(void)
>  		name = "platform-framebuffer";
>  
>  	pd = platform_device_alloc(name, 0);
> -	if (!pd)
> -		return -ENOMEM;
> +	if (!pd) {
> +		ret = -ENOMEM;
> +		goto unlock_mutex;
> +	}
>  
>  	sysfb_apply_efi_quirks(pd);
>  
> @@ -73,9 +106,11 @@ static __init int sysfb_init(void)
>  	if (ret)
>  		goto err;
>  
> -	return 0;
> +	goto unlock_mutex;
>  err:
>  	platform_device_put(pd);
> +unlock_mutex:
> +	mutex_unlock(&load_lock);
>  	return ret;
>  }
>  
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index 708152e9037b..e8c0313fac8f 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -55,6 +55,25 @@ struct efifb_dmi_info {
>  	int flags;
>  };
>  
> +#ifdef CONFIG_SYSFB
> +
> +void sysfb_disable(void);
> +bool sysfb_try_unregister(struct device *dev);
> +
> +#else /* CONFIG_SYSFB */
> +
> +static inline void sysfb_disable(void)
> +{
> +
> +}
> +
> +static inline bool sysfb_try_unregister(struct device *dev)
> +{
> +	return false;
> +}
> +
> +#endif /* CONFIG_SYSFB */
> +
>  #ifdef CONFIG_EFI
>  
>  extern struct efifb_dmi_info efifb_dmi_list[];
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
