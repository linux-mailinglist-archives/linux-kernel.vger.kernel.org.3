Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7498047D86C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 21:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhLVU4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 15:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbhLVU4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 15:56:10 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF40C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 12:56:10 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f5so13324243edq.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 12:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZGfnM0NbF6Lnwn+/4v0lYf4UoXf1XyHSPDhBU5PYm+w=;
        b=ODBWafjTuhxpOyZRsUMimelFOUAdAR18tX5lXt2fWab4ErAM/IpEp08Mt7WuFaiK35
         V7a7D94j9J8dMmqZWDj+SZwsm8zsI9PAoXvWsXsVx3e9plHG2W9jR5xjWLXTFphrwjHD
         NKPWM+jGTCd+Ti49LpH0kflkPiyASTBwqfvE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ZGfnM0NbF6Lnwn+/4v0lYf4UoXf1XyHSPDhBU5PYm+w=;
        b=rcFpH2zthkFfelpWN+q08Y2O/1TRpJ55QlVNhnBj5KTQaXwkpqYo7lQU7IFYTW5X51
         iO6Ye2pwKqPuv0pjmGg62Tg42dpvfJgzF+XxjjYK4ak83MBcOBqysx9XLqTSgTBRPlmP
         XDAYuHa1rKF1uoWpMEzgYTmkUPE4LGTSEvWZdlTpoG+Yc6ouFIkdqVD/enGNl/arwuN5
         rL49YqVCLTt6B+exozuM7/L5PB7LbZpq9XfpXnYz4hgpC4f433W4dcRYRbZMqZbx2bB6
         8oIgTLJiW7a8Y9GAqHkv7zn1JP5cJOPEnwmwodwf62xf852yryb33YFIcfZ85gVCURaq
         MxOA==
X-Gm-Message-State: AOAM532cEqBv0UaR6mynQg2h+clo+s4iIWKyAagp290s+HWGJmfRO60E
        X5BM/HMjVrD/LlqfSkiCdEE8wQ==
X-Google-Smtp-Source: ABdhPJznl20tGyyVj8H8hiyWICpl1Z3hcWY9+UYEKVr+on/kEg8QKEuVlN3dcT7fJ/ABi0QaMKzDSw==
X-Received: by 2002:a17:906:b785:: with SMTP id dt5mr3710609ejb.515.1640206568603;
        Wed, 22 Dec 2021 12:56:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id dp6sm1094151ejc.140.2021.12.22.12.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 12:56:08 -0800 (PST)
Date:   Wed, 22 Dec 2021 21:56:06 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] drm/ttm: fix compilation on ARCH=um
Message-ID: <YcOQ5uMYLuI0/y5v@phenom.ffwll.local>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
References: <CAMuHMdXTRYjtfyWTVN86pn4STO2EPR1B5+KHj=wAqguXt=hpHg@mail.gmail.com>
 <20211220111519.a4c8c6eff702.Ie4cf4e68698f6a9f546b83379bc52c266504424f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220111519.a4c8c6eff702.Ie4cf4e68698f6a9f546b83379bc52c266504424f@changeid>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:15:22AM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Even if it's probably not really useful, it can get selected
> by e.g. randconfig builds, and then failing to compile is an
> annoyance. Unfortunately, it's hard to fix in Kconfig, since
> DRM_TTM is selected by many things that don't really depend
> on any specific architecture, and just depend on PCI (which
> is indeed now available in ARCH=um via simulation/emulation).
> 
> Fix this in the code instead by just ifdef'ing the relevant
> two lines that depend on "real X86".
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Probably the last thing before I disappear until 2022 :-)

Merged into drm-misc-fixes, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/ttm/ttm_module.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
> index 0037eefe3239..a3ad7c9736ec 100644
> --- a/drivers/gpu/drm/ttm/ttm_module.c
> +++ b/drivers/gpu/drm/ttm/ttm_module.c
> @@ -68,9 +68,11 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
>  #if defined(__i386__) || defined(__x86_64__)
>  	if (caching == ttm_write_combined)
>  		tmp = pgprot_writecombine(tmp);
> +#ifndef CONFIG_UML
>  	else if (boot_cpu_data.x86 > 3)
>  		tmp = pgprot_noncached(tmp);
> -#endif
> +#endif /* CONFIG_UML */
> +#endif /* __i386__ || __x86_64__ */
>  #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
>  	defined(__powerpc__) || defined(__mips__)
>  	if (caching == ttm_write_combined)
> -- 
> 2.33.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
