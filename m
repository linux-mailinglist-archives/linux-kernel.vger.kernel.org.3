Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE304B1F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347778AbiBKHnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:43:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347777AbiBKHnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74A892E9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644565393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+JoBX4dv2Ujy4kHFl4q2D9yIGmIdd5volu8AUosqWE=;
        b=RdUhG+Hyq2LpweCA5pPN7RiZhctVT43Bxc9M2053mC39yhfl2J1kE3oZc7IPhh9VJJzpvV
        FzbkkfLl8F+xuoxf3QX3BnU8RtY+zZBT5fDGfoim533yFV6SSX0+JyOeUWwt19CFA4myT/
        ujPhZ3S8qumHSO+oOJMovj0E8yPh/VU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-S-OgPcbMPEyu1Si4IEHX9A-1; Fri, 11 Feb 2022 02:43:12 -0500
X-MC-Unique: S-OgPcbMPEyu1Si4IEHX9A-1
Received: by mail-ej1-f71.google.com with SMTP id ky6-20020a170907778600b0068e4bd99fd1so3725789ejc.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q+JoBX4dv2Ujy4kHFl4q2D9yIGmIdd5volu8AUosqWE=;
        b=5MXtkSWHEs7XPgENYcgEmFPmnoi+Dv3QDTE9K3ib7RsjXdzzCS3+CwcMl2LHNiNNuB
         tWlq6CNoeiJMORsTASWyk+/WYpJE8KB7uFLVOlShOHz5oiLV91hc7nNTmjtwDkLUJoTo
         vN4FfESb9GJlnnBF0QE5ctJicw+uhaQf02+2wtHcAxIqk1ByOkaUgKYrKGP1Z0ic82ou
         g2huh2KTiTGDTV8oooO5rqL8RI4fomZ3GzNptevxi9SWqbIsJKDWE/5suSotiiVwrpGx
         YH8fmCekqLrl6WW1Cx7abnw5qfd0MsK4k/INbZ7RjXe5MJ1XRy6wYBvkIZRSEyekkIpW
         zNFw==
X-Gm-Message-State: AOAM531d3/HXvwTIdcGDmtWDsr8fJ3HtyCQ7wXZJPGgOlBTLeRXkqTwE
        NXpq9hCpIk22GYF5zrnqHTEqD2CB+nphIi/sC+LQb+FLhHTTIBcXfOCjca8l9HPrFQa6GfsoKhm
        pEsHXzDvNrs2J3Efy2NYPXTI/
X-Received: by 2002:a17:906:5d14:: with SMTP id g20mr322475ejt.37.1644565391013;
        Thu, 10 Feb 2022 23:43:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEfQpRtLobU4UAs4SWOVNcJDhEjOkbQmmbly0Xr2tW7hupHSA1QdZZhCzrr2fKvmPOHvfu0w==
X-Received: by 2002:a17:906:5d14:: with SMTP id g20mr322469ejt.37.1644565390811;
        Thu, 10 Feb 2022 23:43:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id g15sm4632241edz.100.2022.02.10.23.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 23:43:10 -0800 (PST)
Message-ID: <d4425819-78c0-ad53-841d-fd59a59c2736@redhat.com>
Date:   Fri, 11 Feb 2022 08:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 3/9] ASoC: Intel: bytcr_wm5102: use GFP_KERNEL
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
 <20220210204223.104181-4-Julia.Lawall@inria.fr>
 <d26561a1-ddd4-aea0-792d-efce104ad44f@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d26561a1-ddd4-aea0-792d-efce104ad44f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/11/22 01:20, Pierre-Louis Bossart wrote:
> 
> 
> On 2/10/22 14:42, Julia Lawall wrote:
>> Platform_driver probe functions aren't called with locks held
>> and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.
>>
>> Problem found with Coccinelle.
> 
> Thanks Julia, indeed it's the only case where GFP_ATOMIC is used for
> machine drivers.
> 
> This was already present in the initial Android driver from Intel (2013)
> [1] and missed in the multiple passes to get this upstream.
> 
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Yeah I should have caught this when I upstreamed the machine driver:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> [1]
> https://github.com/lenovo-yt2-dev/android_kernel_lenovo_baytrail/blob/cm-12.1/sound/soc/intel/board/byt_bl_wm5102.c
> 
>>
>> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>>
>> ---
>>  sound/soc/intel/boards/bytcr_wm5102.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
>> index 504ef4cab111..8d8e96e3cd2d 100644
>> --- a/sound/soc/intel/boards/bytcr_wm5102.c
>> +++ b/sound/soc/intel/boards/bytcr_wm5102.c
>> @@ -389,7 +389,7 @@ static int snd_byt_wm5102_mc_probe(struct platform_device *pdev)
>>  	bool sof_parent;
>>  	int ret;
>>  
>> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_ATOMIC);
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>  	if (!priv)
>>  		return -ENOMEM;
>>  
>>
> 

