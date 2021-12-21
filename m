Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E32847C705
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbhLUSxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241559AbhLUSxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640112812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RaxEfKPsvW2G/7TOdhBfY5WrgkaW6Nyc3UL395DMCcQ=;
        b=IYQVz7v/zid4wRERult49/YbYH9wSgVf6peVDZ/e2kwlTXSQujsfIJ8PxnWYH2xfClRWQq
        eaZ3gZp3s2xGrqts8KvF3TeBcqhjVpGucd7GR0ndReFsM0q9ss+8dah5fXprDyGwLtqwmc
        KOoddTvvHEbYmd1XZ9k0Vq9SYSaBqAk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-HS-j5457MMGLlPHIdEWsBw-1; Tue, 21 Dec 2021 13:53:31 -0500
X-MC-Unique: HS-j5457MMGLlPHIdEWsBw-1
Received: by mail-ed1-f72.google.com with SMTP id q15-20020a056402518f00b003f87abf9c37so3504001edd.15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RaxEfKPsvW2G/7TOdhBfY5WrgkaW6Nyc3UL395DMCcQ=;
        b=XGvqLmDg2gfYT7YTmo5j/U1cVSe/7rum1Ehgjm7DKePpfTPsSjiJqPnKGivV0b1uqs
         YntXekKVepuf1eGvMXTWH0GtYNGZWmhrDb9EN4QEdS91TvbiCkvR/P9o2+je7FXABNTy
         blFmVqARPd/pAQL8zZNDzELnj1VTx/CXh0YoXOOGLI4uu4WTzta/3D3ukUzYwFwM2q1h
         IBrS9K56g36GsZEzx/CJ+bLiN4/PdY42dlyf6pI9aP67ovKVXQdI7Tl8q9wJZFX2qhhC
         ykYJA8Qup9UweNoCJBQkCf/pZ1ymtNfBx4dkgTeuc7zvo6kKBLl4I4vHyTJrXZUhdRcU
         qVSg==
X-Gm-Message-State: AOAM530n9OKRMyhkeWi6NlbvAl1/NmRup0wwnb5QsRYrnVuaJ8c6p10Q
        ftc19vPzpTCkO3XaLD18Spd9xwxtoZunRb8qo5zJccb144zImqPJDuPWosO1GDY3j9TdFWepaev
        W//29YL9ZRTTLS8lOTk4yrTxE
X-Received: by 2002:a17:906:2802:: with SMTP id r2mr3940487ejc.172.1640112810372;
        Tue, 21 Dec 2021 10:53:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRqLy4pcUlbMjBepIrlRH0zBM2jdr2lBOYDmUXU8Typ0GYIlXRJZrjUnh4K1UqEUq6499rUA==
X-Received: by 2002:a17:906:2802:: with SMTP id r2mr3940454ejc.172.1640112810048;
        Tue, 21 Dec 2021 10:53:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id i6sm5695402edx.46.2021.12.21.10.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:53:29 -0800 (PST)
Message-ID: <c6abc6df-6e66-38e3-d934-e71467d71f88@redhat.com>
Date:   Tue, 21 Dec 2021 19:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 3/3] drm/privacy_screen_x86: Add entry for ChromeOS
 privacy-screen
Content-Language: en-US
To:     Rajat Jain <rajatja@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, gwendal@google.com,
        seanpaul@google.com, marcheu@google.com, dtor@google.com
Cc:     rajatxjain@gmail.com
References: <20211220222828.2625444-1-rajatja@google.com>
 <20211220222828.2625444-3-rajatja@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211220222828.2625444-3-rajatja@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/20/21 23:28, Rajat Jain wrote:
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
> v3: * Remove the pr_info() from detect_chromeos_privacy_screen(), instead
>       enhance the one already present in drm_privacy_screen_lookup_init()
> v2: * Use #if instead of #elif
>     * Reorder the patches in the series.
>     * Rebased on drm-tip
> 
>  drivers/gpu/drm/drm_privacy_screen_x86.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
> index a2cafb294ca6..0fdd2b500e6d 100644
> --- a/drivers/gpu/drm/drm_privacy_screen_x86.c
> +++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
> @@ -47,6 +47,16 @@ static bool __init detect_thinkpad_privacy_screen(void)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
> +static bool __init detect_chromeos_privacy_screen(void)
> +{
> +	if (!acpi_dev_present("GOOG0010", NULL, -1))
> +		return false;
> +
> +	return true;

This can be simplified to just:

	return acpi_dev_present("GOOG0010", NULL, -1);

> +}
> +#endif
> +
>  static const struct arch_init_data arch_init_data[] __initconst = {
>  #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
>  	{
> @@ -58,6 +68,16 @@ static const struct arch_init_data arch_init_data[] __initconst = {
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
> @@ -68,7 +88,8 @@ void __init drm_privacy_screen_lookup_init(void)
>  		if (!arch_init_data[i].detect())
>  			continue;
>  
> -		pr_info("Found '%s' privacy-screen provider\n",
> +		pr_info("Found '%s' privacy-screen provider."
> +			"Might have to defer probe for it...\n",
>  			arch_init_data[i].lookup.provider);

I'm afraid this change in the log message will only confuse users,
and for your goal of checking if a privacy-screen provider has
been detected, the original message is good enough.

Please drop this part of the patch.

Regards,

Hans



>  
>  		/* Make a copy because arch_init_data is __initconst */
> 

