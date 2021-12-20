Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A93D47B3EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhLTTub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhLTTua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:50:30 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF349C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:50:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso174991pjc.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=omKEumi0/sMUkgfeE+wVUPVvzgif1Rbc6lYFVM9Ereo=;
        b=WFEPFl7giFl5WW+J8eGbuaecw13OosUZpEnVjwmAIv0f0GrUmpe2I4cMqiNhCX2y+M
         fnLJSYSVI/MpVdRy0OJ4ii5qC6GfsHDdH/9AM6HYK5INFmMOyN95FVzobzntgaYmPuf9
         Fvxavs+g7o+dGGUB4hea2bSr4T/CkFJK4PcUBouh9OgEIeUO7KkqoWOIHuB3WJiXxh3A
         S3+s3qZR7Q8DMwcKgxOXsEky6EmOFulwtljyHxt2r1Sy0cnI4/+Mpk2UPhb7onqN6C6L
         xpj+WeSEQihVEJBHsOjO4+EgyaGKrbh848bupGwUyyQi7g9fmVLkXjjWNLG6Ll/KhKkY
         8nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omKEumi0/sMUkgfeE+wVUPVvzgif1Rbc6lYFVM9Ereo=;
        b=hSGJIGcDC1H42Tsw+9SoSAqIy1gQG6AdbLCD8QZSZ1SuVA+cABLg0fvV3FQC3ac7wS
         86pVkKibO0XVFH6QQ0Te+PQJ2Co5CbDlF8b+ddUO/Xy+z/0SLuqG1/xXRebdUtMon1Ei
         fQsDi/ZJPurlxA8FU+Pka31euEOU5lbLRhHfedHP7J2MidEWlC0kgXgx0CXqNU5B4EAq
         1Y9bY58iYYths58UEBySaBHvnTA4WF91f5qGpja4rmazIlB1wWn/HlZhrpZlLtDfzJ5d
         QkhkcPrqWQnU7i/3DyugIargLWI6RmQ76Yrva8lKVCodi1YMrPv0xJkIeoiUH7njfhRA
         5MwQ==
X-Gm-Message-State: AOAM530a19YFcJ2UbPlkcQf6f+Ou9ed/n4JYE1A/ij2WvjaPbVpeB2ep
        SZrkHfXIxWO8+3JwoRapc3E=
X-Google-Smtp-Source: ABdhPJy/mPgkfT3mRFUEuhymyrtCUZdWxuGjUuiyRrndhASUC0JLvGsa4Xa69qvSHb0zGdkwMZABsw==
X-Received: by 2002:a17:90a:e7c6:: with SMTP id kb6mr626149pjb.61.1640029829357;
        Mon, 20 Dec 2021 11:50:29 -0800 (PST)
Received: from google.com ([2620:15c:202:201:9632:a1c4:968a:6f66])
        by smtp.gmail.com with ESMTPSA id kb1sm185294pjb.56.2021.12.20.11.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 11:50:28 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Google-Original-From: Dmitry Torokhov <dtor@google.com>
Date:   Mon, 20 Dec 2021 11:50:25 -0800
To:     Rajat Jain <rajatja@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        gwendal@google.com, seanpaul@google.com, marcheau@google.com,
        rajatxjain@gmail.com
Subject: Re: [PATCH v2 2/2] drm/privacy_screen_x86: Add entry for ChromeOS
 privacy-screen
Message-ID: <YcDegV8wqljpU3J0@google.com>
References: <20211217202850.1967594-1-rajatja@google.com>
 <20211217202850.1967594-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217202850.1967594-2-rajatja@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:28:50PM -0800, Rajat Jain wrote:
> Add a static entry in the x86 table, to detect and wait for
> privacy-screen on some ChromeOS platforms.
> 
> Please note that this means that if CONFIG_CHROMEOS_PRIVACY_SCREEN is
> enabled, and if "GOOG0010" device is found in ACPI, then the i915 probe
> shall return EPROBE_DEFER until a platform driver actually registers the
> privacy-screen: https://hansdegoede.livejournal.com/25948.html
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: * Use #if instead of #elif
>     * Reorder the patches in the series.
>     * Rebased on drm-tip
> 
>  drivers/gpu/drm/drm_privacy_screen_x86.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
> index a2cafb294ca6..0c5699ad70a3 100644
> --- a/drivers/gpu/drm/drm_privacy_screen_x86.c
> +++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
> @@ -47,6 +47,18 @@ static bool __init detect_thinkpad_privacy_screen(void)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
> +static bool __init detect_chromeos_privacy_screen(void)

Does marking this __init work in case there is a deferral? Can it happen
that privacy screen is a module and so will get loaded only after we
discarded __init sections.

> +{
> +	if (!acpi_dev_present("GOOG0010", NULL, -1))
> +		return false;
> +
> +	pr_info("%s: Need to wait for ChromeOS privacy-screen drvr", __func__);

I still do not see how this message is helpful. If it is really desired,
I'd put something into the code that calls into lookups.

> +	return true;
> +
> +}
> +#endif
> +
>  static const struct arch_init_data arch_init_data[] __initconst = {
>  #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
>  	{
> @@ -58,6 +70,16 @@ static const struct arch_init_data arch_init_data[] __initconst = {
>  		.detect = detect_thinkpad_privacy_screen,
>  	},
>  #endif
> +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
> +	{
> +		.lookup = {
> +			.dev_id = NULL,
> +			.con_id = NULL,
> +			.provider = "privacy_screen-GOOG0010:00",
> +		},
> +		.detect = detect_chromeos_privacy_screen,
> +	},
> +#endif
>  };
>  
>  void __init drm_privacy_screen_lookup_init(void)
> -- 
> 2.34.1.307.g9b7440fafd-goog
> 

Thanks.

-- 
Dmitry
