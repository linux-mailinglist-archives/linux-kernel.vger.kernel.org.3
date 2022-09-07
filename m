Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324E65AFCB2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiIGGlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiIGGlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:41:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455689DF84
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:40:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t5so18172444edc.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 23:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=XaRjxOyW2MEx2tct3s/cWA1lvtbzxTStc/wVzUlH2uc=;
        b=eJz5MxKi7mTMm27o1zpVdo60zEiEVoggVNSQwDnTq4bJZ7gHO3YNiu08p+PQ2rcmSb
         3QSyS4dX+Q5bzpsYXbcOwTNfKOO11SM/M0ZEG8S6e1vMQdkzyubH7JDOuLegIbn+/PVw
         wAzNRlVnOnDnNxYNB5FtBmZ18lDBwqCdT89Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XaRjxOyW2MEx2tct3s/cWA1lvtbzxTStc/wVzUlH2uc=;
        b=pNiDYfwgcOxLwXvDap7oUKySo+9ZScrZaTVfKiLVxZ2lF65fqpWViVSrIwaacF/dwx
         Lmg5lA9FP7fN4IrHLwj1wEzbFflPJj7wem6nBqh1j/l7o2qIWu5MXYLTiYmxSgbtkrZz
         adEywRtHFmc0N3MpOkNvoFiqUrwuRsolqdsg4IhDWEYeAjWh5BnTkxajJFS3sv3pjaWt
         zms296iNqt3CdnREQtHqjNlUGbai0GIuHZKUp4kSNuGk8DjZYieCP04P80PEWaGNRKE6
         ue6V0nTACzUDBDI/U9FDnTloq9UeuIn2V8QSYbaKw2q0iOkd+XQ1RazNX4AGF1SzkAoQ
         08eA==
X-Gm-Message-State: ACgBeo0N9JcjxKoK9wEHutrBxjdC2W5TI9zGZPDdksr+ccY+w2YCH+/5
        mX9xyLGBq4ThbQtfMmLl2CzGWw==
X-Google-Smtp-Source: AA6agR7t8WtxiKGx/Qj9ZS3dD1CibtlbUMNB2bkccrOnKkFnoUMq4IeXkhEM/WViLTh7ZuX1kUdDvg==
X-Received: by 2002:a05:6402:33c5:b0:447:e4a3:c930 with SMTP id a5-20020a05640233c500b00447e4a3c930mr1825745edc.401.1662532845316;
        Tue, 06 Sep 2022 23:40:45 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id a26-20020aa7d91a000000b0044ee18e5f79sm2424487edr.28.2022.09.06.23.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:40:44 -0700 (PDT)
Date:   Wed, 7 Sep 2022 08:40:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
Subject: Re: [PATCH v6 28/57] drm_print: refine drm_debug_enabled for
 jump-label
Message-ID: <Yxg86v7UsB8jtyYi@phenom.ffwll.local>
Mail-Followup-To: Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
References: <20220904214134.408619-1-jim.cromie@gmail.com>
 <20220904214134.408619-29-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904214134.408619-29-jim.cromie@gmail.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 03:41:05PM -0600, Jim Cromie wrote:
> In order to use dynamic-debug's jump-label optimization in drm-debug,
> its clarifying to refine drm_debug_enabled into 3 uses:
> 
> 1.   drm_debug_enabled - legacy, public
> 2. __drm_debug_enabled - optimized for dyndbg jump-label enablement.
> 3.  _drm_debug_enabled - pr_debug instrumented, observable
> 
> 1. The legacy version always checks the bits.
> 
> 2. is privileged, for use by __drm_dbg(), __drm_dev_dbg(), which do an
> early return unless the category is enabled.  For dyndbg builds, debug
> callsites are selectively "pre-enabled", so __drm_debug_enabled()
> short-circuits to true there.  Remaining callers of 1 may be able to
> use 2, case by case.
> 
> 3. is 1st wrapped in a macro, with a pr_debug, which reports each
> usage in /proc/dynamic_debug/control, making it observable in the
> logs.  The macro lets the pr_debug see the real caller, not an inline
> function.
> 
> When plugged into 1, 3 identified ~10 remaining callers of the
> function, leading to the follow-on cleanup patch, and would allow
> activating the pr_debugs, estimating the callrate, and the potential
> savings by using the wrapper macro.  It is unused ATM, but it fills
> out the picture.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

So instead of having 3 here as a "you need to hack it in to see what
should be converted" I have a bit a different idea: Could we make the
public version also a dyndbg callsite (like the printing wrappers), but
instead of a dynamic call we'd have a dynamically fixed value we get out?
I think that would take care of everything you have here as an open.

Otherwise I'd just drop 3 for the series we're going to merge.
-Daniel

> ---
>  drivers/gpu/drm/drm_print.c |  4 ++--
>  include/drm/drm_print.h     | 28 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index 29a29949ad0b..cb203d63b286 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -285,7 +285,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
>  	struct va_format vaf;
>  	va_list args;
>  
> -	if (!drm_debug_enabled(category))
> +	if (!__drm_debug_enabled(category))
>  		return;
>  
>  	va_start(args, format);
> @@ -308,7 +308,7 @@ void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
>  	struct va_format vaf;
>  	va_list args;
>  
> -	if (!drm_debug_enabled(category))
> +	if (!__drm_debug_enabled(category))
>  		return;
>  
>  	va_start(args, format);
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index dfdd81c3287c..7631b5fb669e 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -321,11 +321,39 @@ enum drm_debug_category {
>  	DRM_UT_DRMRES
>  };
>  
> +/*
> + * 3 name flavors of drm_debug_enabled:
> + *   drm_debug_enabled - public/legacy, always checks bits
> + *  _drm_debug_enabled - instrumented to observe call-rates, est overheads.
> + * __drm_debug_enabled - privileged - knows jump-label state, can short-circuit
> + */
>  static inline bool drm_debug_enabled(enum drm_debug_category category)
>  {
>  	return unlikely(__drm_debug & BIT(category));
>  }
>  
> +/*
> + * Wrap fn in macro, so that the pr_debug sees the actual caller, not
> + * the inline fn.  Using this name creates a callsite entry / control
> + * point in /proc/dynamic_debug/control.
> + */
> +#define _drm_debug_enabled(category)				\
> +	({							\
> +		pr_debug("todo: maybe avoid via dyndbg\n");     \
> +		drm_debug_enabled(category);			\
> +	})
> +
> +#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
> +/*
> + * dyndbg is wrapping the drm.debug API, so as to avoid the runtime
> + * bit-test overheads of drm_debug_enabled() in those api calls.
> + * In this case, executed callsites are known enabled, so true.
> + */
> +#define __drm_debug_enabled(category)	true
> +#else
> +#define __drm_debug_enabled(category)	drm_debug_enabled(category)
> +#endif
> +
>  /*
>   * struct device based logging
>   *
> -- 
> 2.37.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
