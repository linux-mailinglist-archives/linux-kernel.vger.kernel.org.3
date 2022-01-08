Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9F488464
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiAHQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234629AbiAHQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641658212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfgabDSS/gH6CDQ8l3rvCMIxMgihojIJUexXgrRTlE0=;
        b=N/+AlIDzKro2i40JRlfz0Cso6lYzMF0CopSByJ0vChCtnJ65fRGh0EW+1reEeHfnGLrMWQ
        hSct3F7Jk/Rg3eqpoLLthkQsEr+m8U+9k76GXkk8wX7/JvMdEznj8PcAGAsndaoV6nzBfi
        frCLvl4uFpyTSTTYFPIfHHDouyp6HrI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-VmESeps0P0SYLJSq5Iv1rg-1; Sat, 08 Jan 2022 11:10:11 -0500
X-MC-Unique: VmESeps0P0SYLJSq5Iv1rg-1
Received: by mail-ed1-f69.google.com with SMTP id dz8-20020a0564021d4800b003f897935eb3so6991077edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 08:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZfgabDSS/gH6CDQ8l3rvCMIxMgihojIJUexXgrRTlE0=;
        b=SdoWJCLyJjaadUBFGv+cPi8VPWa37s+yTUydWuucheBBS3l+l0Qn/RXGNwX+MOSZZZ
         uZtfSEO6E1qOsPLy5A+29xgD0iLiDGWt0aRH8BFCqyOkgEGKbDm9Yk7f9zcP5hjWstd7
         7cqKU5WvzTvmzgsQGA2nQQU+r4UwxjNf3Pnr56p76B3hd7QIketlgPNzg3QeNM0KsOz7
         uA3P0OKCOmIu9TeYMaDyZPd4U4aSA4S6ZbKkAQv7RDCi68zj+dqydR/hyJObcIdHJCAN
         ZTOO5qKxZQMNq31dOGZfnCX77PLooCUP0A8xsmRLIH6//bUUzzAnfvVcL1xnnEe5M5HL
         KIVQ==
X-Gm-Message-State: AOAM53321FoTCAJGp4Y11PvedKov4nCNFcsHHsWC5VEG9HMMR6KGdvnu
        69HyK8CIqmuJmVllveY0MU9oXb+LOLjY0z2PrZSIGicZl8Pxlz9SjFv8cpqh54KrbE+Xd5ARO/q
        d9aHTolcDi1Ec2yO6DvZ3qLz5
X-Received: by 2002:a17:906:86cb:: with SMTP id j11mr10313290ejy.40.1641658209790;
        Sat, 08 Jan 2022 08:10:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzafHPA1hS1YxU4MAlmNDyZjL5mOgs//ZNBjd0fJXg2UApooAeaTTngtJ64hglQALtpKMzMrA==
X-Received: by 2002:a17:906:86cb:: with SMTP id j11mr10313276ejy.40.1641658209573;
        Sat, 08 Jan 2022 08:10:09 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id r3sm619371ejr.79.2022.01.08.08.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 08:10:09 -0800 (PST)
Message-ID: <d38ec2f9-a21f-d431-235a-9edb59fc40e9@redhat.com>
Date:   Sat, 8 Jan 2022 17:10:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v5 3/3] drm/privacy_screen_x86: Add entry for ChromeOS
 privacy-screen
Content-Language: en-US
To:     Benson Leung <bleung@google.com>, Rajat Jain <rajatja@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        seanpaul@google.com, marcheu@google.com, dtor@google.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        rajatxjain@gmail.com
References: <20220107190208.95479-1-rajatja@google.com>
 <20220107190208.95479-3-rajatja@google.com> <YdiPOoU1JrqR7N6S@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YdiPOoU1JrqR7N6S@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 1/7/22 20:06, Benson Leung wrote:
> Hi Rajat, 
> 
> Thanks for your changes here.
> 
> On Fri, Jan 07, 2022 at 11:02:08AM -0800, Rajat Jain wrote:
>> Add a static entry in the x86 table, to detect and wait for
>> privacy-screen on some ChromeOS platforms.
>>
>> Please note that this means that if CONFIG_CHROMEOS_PRIVACY_SCREEN is
>> enabled, and if "GOOG0010" device is found in ACPI, then the i915 probe
>> shall return EPROBE_DEFER until a platform driver actually registers the
>> privacy-screen: https://hansdegoede.livejournal.com/25948.html
>>
>> Signed-off-by: Rajat Jain <rajatja@google.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Hi Hans,
> 
> Since this change depends on the privacy screen changes staged for v5.17,
> I'm OK as platform/chrome maintainer to have this go through the drm tree.
> 
> Acked-By: Benson Leung <bleung@chromium.org>

Ok, I will merge this into drm-misc-next coming Monday.

Note I'm afraid that it is too late for 5.17, the drm-misc maintainers
have already created the final drm-misc tag for the 5.17 pull-req.

Regards,

Hans


> 
> 
>> ---
>> v5: * Add Hans' "Reviewed by"
>> v4: * Simplify the detect_chromeos_privacy_screen() function
>>     * Don't change the existing print statement
>> v3: * Remove the pr_info() from detect_chromeos_privacy_screen(), instead
>>       enhance the one already present in drm_privacy_screen_lookup_init()
>> v2: * Use #if instead of #elif
>>     * Reorder the patches in the series.
>>     * Rebased on drm-tip
>>
>>  drivers/gpu/drm/drm_privacy_screen_x86.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
>> index a2cafb294ca6..88802cd7a1ee 100644
>> --- a/drivers/gpu/drm/drm_privacy_screen_x86.c
>> +++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
>> @@ -47,6 +47,13 @@ static bool __init detect_thinkpad_privacy_screen(void)
>>  }
>>  #endif
>>  
>> +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
>> +static bool __init detect_chromeos_privacy_screen(void)
>> +{
>> +	return acpi_dev_present("GOOG0010", NULL, -1);
>> +}
>> +#endif
>> +
>>  static const struct arch_init_data arch_init_data[] __initconst = {
>>  #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
>>  	{
>> @@ -58,6 +65,16 @@ static const struct arch_init_data arch_init_data[] __initconst = {
>>  		.detect = detect_thinkpad_privacy_screen,
>>  	},
>>  #endif
>> +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
>> +	{
>> +		.lookup = {
>> +			.dev_id = NULL,
>> +			.con_id = NULL,
>> +			.provider = "privacy_screen-GOOG0010:00",
>> +		},
>> +		.detect = detect_chromeos_privacy_screen,
>> +	},
>> +#endif
>>  };
>>  
>>  void __init drm_privacy_screen_lookup_init(void)
>> -- 
>> 2.34.1.575.g55b058a8bb-goog
>>
> 

