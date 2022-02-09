Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BEF4AF249
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiBINEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiBINET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:04:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30578C05CB97
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644411862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUzAJD5kbTchlL+gjCOgw4eKuUNlJh2PUtfBXKNWAAo=;
        b=LSf+gKgA7gtQ1lgEhEeSvAq2yZFo2vgTmCw6pMn1MaSO7YsUu2+AFK+82Pdz1Xqwm5w2F0
        NwpzaQEYZIJ7QJXQImAsyA+OcMLCu8Eug+dWWPbRhyyyBQyi7Y79uus+t6R+pgN0ae6Bnv
        FEOb2SrEnUZb7dXU2DCMm8SJEmz979o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-XuHeTHBRMTm6kEH1goyQtg-1; Wed, 09 Feb 2022 08:04:21 -0500
X-MC-Unique: XuHeTHBRMTm6kEH1goyQtg-1
Received: by mail-wm1-f72.google.com with SMTP id u14-20020a05600c210e00b0037bddd0562eso480594wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 05:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aUzAJD5kbTchlL+gjCOgw4eKuUNlJh2PUtfBXKNWAAo=;
        b=RmUsXQmWFf6BOZrzwWnGhG/baUfjVH3K3ODb9Sw0rOZEok8DrklpbBfUQVeua92R0p
         DCWFIkHaU6vMPpaYSDCqZy97SD+gO9vJmK06vgbP9mXblgnMBOfV3snVT01ktcng/3T4
         rvPg97J5sw+5KFFNOjFyNzGclRFPyOK+8XwXGiGo+a4jfUqWDYvf9f6y6gNPhNMRNr7n
         BMJegv/ZQLYo9oOMXVXcOD+1qyh/y7o4krGMqXvbcCsTU5WIMzHWecbWemSvVmvUDkai
         yHAKAOf4IHTzYS2q91M2zFWu9a8E5tFdUvtBd2XyafvZIVd7pIQeLPYCptHd81PZ/hVn
         E1mQ==
X-Gm-Message-State: AOAM533dZWixy+hHupO99DaxjXjo8sSIeoAbceK2HNR+AH09imy9vAxp
        9Xu8Z9/7CaAVzS5dt9U6PMjyzd3oZpPCm9mTjZUtIthFpV7O+bCmAhaj8PPrOtsdscRR3yev00u
        krz0N7jJNlpfRCGofqhqycubR
X-Received: by 2002:adf:f384:: with SMTP id m4mr2089450wro.619.1644411859839;
        Wed, 09 Feb 2022 05:04:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiO4EFMylBV1d9vxTXEoIqL6kXbZmHBfOW0Qxtx/E3aYbo8p+lRqr/HlGnFxDb8si5vo3ofg==
X-Received: by 2002:adf:f384:: with SMTP id m4mr2089432wro.619.1644411859577;
        Wed, 09 Feb 2022 05:04:19 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s26sm1994270wmh.47.2022.02.09.05.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 05:04:19 -0800 (PST)
Message-ID: <e6efb2fd-300e-5282-1f2e-a68130d0b45a@redhat.com>
Date:   Wed, 9 Feb 2022 14:04:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
 <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 13:25, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Wed, Feb 9, 2022 at 10:12 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The ssd130x driver only provides the core support for these devices but it
>> does not have any bus transport logic. Add a driver to interface over SPI.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
> 
>> +static const struct of_device_id ssd130x_of_match[] = {
>> +       {
>> +               .compatible = "solomon,ssd1305fb-spi",
> 
> This needs an update to the DT bindings.

Yes, I know. Didn't feel like it, because the patch is a WIP anyways
(I haven't tested it but was included just for illustration purposes).

If someone confirms that works then I will include a proper DT binding
in the next revision.

> Hence this may be a good time to deprecate the existing
> "solomon,ssd130*fb-i2c" compatible values, and switch to
> "solomon,ssd130*fb" instead, for both I2C and SPI.

Is this the preferred approach ? Asking because most of the drivers I
know use this -$bus suffix. From a device <--> driver matching point
of view, shouldn't be an issue to have two different drivers to use
the same compatible strings, as long as these are for different buses.

Since AFAIK the match only happens within the same struct bus_type. But
I wonder if this could cause issues in other places, for example the
module loading. IIRC the OF modaliases don't include the device type.

If instead the drivers were old platform drivers and have an i2c_device_id
and spi_device_id tables, then using the same device name would not be an
issue due the modalias having a i2c: and spi: prefix to make a distinction.

What I think we should do is drop the "fb" part, since that seemed to me
that was included because it was an fbdev driver. And not really hardware
description.

> Of course the I2C subdriver still has to bind against the old values,
> too, for backwards compatibility.
>

Yes, agreed.
 
>> +               .data = (void *)&ssd130x_ssd1305_deviceinfo,
> 
> The casts are not needed.
>

Ok.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

