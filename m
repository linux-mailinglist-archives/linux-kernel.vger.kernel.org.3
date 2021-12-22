Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6816447CA22
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhLVANs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:13:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235204AbhLVANs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640132027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0Qq4bqfzfE3trvRIEDVDXat+HDTqmCMW/URnd0so/Y=;
        b=TJvm7S9XBd4zmN4ENfOCVxuP/Wv5wFIh4s8+YSusFjHZq4POKmGDoH6TbbDJ7Z3Zzeq5iA
        Y+faehRCqlNsPidVZFSzXte1u0JPgTELKoZjH91968Sz+RLtpOGSoR+qd7+arhroDwtwrp
        lv40A/5k0l5V8fP3d9vpXNJ+hikNGBA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-58B3z8TSP3evCd018Ze-dg-1; Tue, 21 Dec 2021 19:13:46 -0500
X-MC-Unique: 58B3z8TSP3evCd018Ze-dg-1
Received: by mail-ed1-f71.google.com with SMTP id d7-20020aa7ce07000000b003f84e9b9c2fso357937edv.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l0Qq4bqfzfE3trvRIEDVDXat+HDTqmCMW/URnd0so/Y=;
        b=ItVcQOi4UO4fdGjJzwi5N2ThPzNpLIYYBTSty3oZaOIyGmuQbUlozOt9VYuf245ciB
         9NFp5vjHCFMwMMQMQkTrI4tw+dyaHFyX/7xMvNbTSSArTMuiVw3qCITY1PN14InnxRWe
         HzdlZlV+Egq8Av81cq8tnRFLVRNS3jMrOT7f1KwmQry+zG3nU2KAWtiFzfZ2LI1FRS5N
         28Wi54LDVrBrESDLY5yxqe25rHdmhnkKgTxZyaxLavnGqhLyk4081KDr1FEC2d13smog
         mYoaJE9/kQovRf8oGehVNGI7yPDdq0nIl3kig0/oFwzNp+X0hKmy62f5Vs4NOu+aHeg5
         okdw==
X-Gm-Message-State: AOAM531arYgzEA9zJBbs0AXfH3xF3HmI6kMRAivq5KeOaPF4ywpOqvJX
        7ppcVNFhzZrB6140DYUnQNZI/wMg78bOJzmFAmYK15z2gjGhazANWasinqPF8K3JbhymOuddwgz
        X0MbrBPCREfHl76fkr6WpAOv1
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr503044ejc.551.1640132024361;
        Tue, 21 Dec 2021 16:13:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWIsX82dWa3sKDnmIan+Qjx5tWjk2AfiuQebVmEZ3//spVNOkyiANcePpTAxbV0EdzLofNog==
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr503023ejc.551.1640132024176;
        Tue, 21 Dec 2021 16:13:44 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id r24sm97529edv.18.2021.12.21.16.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 16:13:43 -0800 (PST)
Message-ID: <4611aa52-d0ff-9de6-3fa8-d997175533f6@redhat.com>
Date:   Wed, 22 Dec 2021 01:13:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 3/3] drm/privacy_screen_x86: Add entry for ChromeOS
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
References: <20211222001127.3337471-1-rajatja@google.com>
 <20211222001127.3337471-3-rajatja@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211222001127.3337471-3-rajatja@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/22/21 01:11, Rajat Jain wrote:
> Add a static entry in the x86 table, to detect and wait for
> privacy-screen on some ChromeOS platforms.
> 
> Please note that this means that if CONFIG_CHROMEOS_PRIVACY_SCREEN is
> enabled, and if "GOOG0010" device is found in ACPI, then the i915 probe
> shall return EPROBE_DEFER until a platform driver actually registers the
> privacy-screen: https://hansdegoede.livejournal.com/25948.html
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> v4: * Simplify the detect_chromeos_privacy_screen() function
>     * Don't change the existing print statement
> v3: * Remove the pr_info() from detect_chromeos_privacy_screen(), instead
>       enhance the one already present in drm_privacy_screen_lookup_init()
> v2: * Use #if instead of #elif
>     * Reorder the patches in the series.
>     * Rebased on drm-tip
> 
>  drivers/gpu/drm/drm_privacy_screen_x86.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
> index a2cafb294ca6..88802cd7a1ee 100644
> --- a/drivers/gpu/drm/drm_privacy_screen_x86.c
> +++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
> @@ -47,6 +47,13 @@ static bool __init detect_thinkpad_privacy_screen(void)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
> +static bool __init detect_chromeos_privacy_screen(void)
> +{
> +	return acpi_dev_present("GOOG0010", NULL, -1);
> +}
> +#endif
> +
>  static const struct arch_init_data arch_init_data[] __initconst = {
>  #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
>  	{
> @@ -58,6 +65,16 @@ static const struct arch_init_data arch_init_data[] __initconst = {
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
> 

