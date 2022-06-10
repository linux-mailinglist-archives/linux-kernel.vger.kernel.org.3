Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE85462BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbiFJJr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347152AbiFJJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:47:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068565C662
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:47:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p10so35762949wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=OPbvFpgsCXrc/RPsUnJXvMubbP17Qr2YxU9/bS1wZjk=;
        b=Sx9VSFOKuSIF/SG/wZmN6t3GEVIdE7lEIrbl9Mm6OhO6ibXPIulugZeY3eOarE4gWg
         Xmxf7UQrHvFKBv/T01+affQqxcOeCFb1i3fIGXdkw5hb2dEDXYgTkvw4vOo6uE4njvOA
         Cr+H0XBeSDbYhAPd/i/bPJeriwwqBIj+qQ0CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=OPbvFpgsCXrc/RPsUnJXvMubbP17Qr2YxU9/bS1wZjk=;
        b=hET86rxO1LDA5XHiyw3ds61htKZ/kesgr2LV0zXsTepe4B4BtY/gubuh5Fo4rtBi7A
         RGorS0E+hZlrmX/RUHBgG7MD6JPyg2ySm7YmyRcPzXNeslWiO4zz/glw5bRi2r5DhhjY
         KcY0eUQ3BK9CIKEr8Rddj/Ss3ykK+w0h+RuTgH3zTkfAIPDdGgHLC4wDZsK12PuIS7zX
         XdrPvPJJZpP+PC7KuGfge1t3jcPxyG0VJ4sn8udOBuEQZHs4Zlp7dEPsZvPLtqwWU/80
         znWi5zJxosq5gL9TfbFCCryqs4OGtli4zZPyV6FcWQhanIpoY2OKwL5kEMf+ugk/cnYj
         /HnQ==
X-Gm-Message-State: AOAM533wOMjcTuzrjdSln0FbM2JE6UkcTxH8jFlikJmzYQ4vWY5vOKIQ
        p95VAtSedrGkYctfl7yxj6Qmuw==
X-Google-Smtp-Source: ABdhPJw/3X2seKC/9g3emEoshWFl3NznfblFRQrKNLuh5mPnwP52ajg48RkiCudO7VotgG18/i6y3Q==
X-Received: by 2002:adf:e4cb:0:b0:219:b63c:d238 with SMTP id v11-20020adfe4cb000000b00219b63cd238mr7519156wrm.705.1654854438519;
        Fri, 10 Jun 2022 02:47:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b0039c50d2d28csm2364864wmq.44.2022.06.10.02.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 02:47:17 -0700 (PDT)
Date:   Fri, 10 Jun 2022 11:47:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fbdev@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] Revert "fbdev: vesafb: Allow to be built if COMPILE_TEST
 is enabled"
Message-ID: <YqMTI3yxmWq/f+Gp@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fbdev@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220610085450.1341880-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085450.1341880-1-javierm@redhat.com>
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

On Fri, Jun 10, 2022 at 10:54:50AM +0200, Javier Martinez Canillas wrote:
> This reverts commit fa0e256450f27a7d85f65c63f05e6897954a1d53. The kernel
> test robot reported that attempting to build the vesafb driver fails on
> some architectures, because these don't define a `struct screen_info`.
> 
> This leads to linking errors, for example on parisc with allyesconfig:
> 
>   hppa-linux-ld: drivers/video/fbdev/vesafb.o: in function `vesafb_probe':
> >> (.text+0x738): undefined reference to `screen_info'
> >> hppa-linux-ld: (.text+0x73c): undefined reference to `screen_info'
>    hppa-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
> >> (.init.text+0x28): undefined reference to `screen_info'
> >> hppa-linux-ld: (.init.text+0x30): undefined reference to `screen_info'
>    hppa-linux-ld: (.init.text+0x78): undefined reference to `screen_info'
> 
> The goal of commit fa0e256450f2 ("fbdev: vesafb: Allow to be built if
> COMPILE_TEST is enabled") was to have more build coverage for the driver
> but it wrongly assumed that all architectures would define a screen_info.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
> 
>  drivers/video/fbdev/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index bd849013f16f..f2a6b81e45c4 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -616,7 +616,7 @@ config FB_UVESA
>  
>  config FB_VESA
>  	bool "VESA VGA graphics support"
> -	depends on (FB = y) && (X86 || COMPILE_TEST)
> +	depends on (FB = y) && X86
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -- 
> 2.36.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
