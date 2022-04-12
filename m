Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316034FDB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391387AbiDLJ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbiDLIkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A250EE2D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649750826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2VdMWR774a5F73y+bEiFyStJDpalZ9pO+6CFy328lrI=;
        b=eiSgE8WstwY3x+P5fMdOGPYi6X9x6VF/+nKfC5ppiM0UizmP2utEdNjfTSod/9BCWbLL83
        QHJCaSUzupGY+vPEUSz/rh1x8RBNcQpV+2IkQ9sOe2iVa57Bc200Y+lcIj2i3WbQ2H4no7
        D/XsaecOsQ7t/9gtLw1xb84KCzrxp7w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-LLJqer8VOsq2Zykw8ydDNA-1; Tue, 12 Apr 2022 04:07:05 -0400
X-MC-Unique: LLJqer8VOsq2Zykw8ydDNA-1
Received: by mail-wr1-f71.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so3790384wrg.20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2VdMWR774a5F73y+bEiFyStJDpalZ9pO+6CFy328lrI=;
        b=JaWtec2hNm8Oqdn7tkdJZuQjxVlLLM2rGnEQ4R8ZTmRb2WO7Rmtf/9G4gZzkT7uANh
         81ZP+NhLWVAuiKVL5KKfPfx8+LXn3IiOfr3SNT677TjiTSlqCr8m8Uyv3bF95TevUl7g
         tl+iEXIVAWrWojbzDf3+kALtdqEwaAUDVpQo/rb3Lbq8159Zc+eyUfyLTuJxsNpU2E+n
         bJI717Eofi0b+r0MB6sCNwjzXos6rQzbbiLez80Ub3P1Dt26iilPxkVcLb3fI80VSDxG
         CuP03/BMtqD800SSo8Rwo25UUQBTQQ2EhEJYCZXy8rMJOGEVSRGS9rFjFPvX7B9ZYULD
         AgjA==
X-Gm-Message-State: AOAM5301ITlC6KHai3Mc8j+HxXkyNIFXcyJXR7k2bk26Pf2ECwfDBYVs
        ifihbUCgd6gqcuoiXWtw2F6dh0wPEu41DQX7Aj+tUZCmMwz+pTgDQVGq8HCmeDradRLwo2o8zxn
        SBJmsQzdxnPF3jhET+rs0m3IW
X-Received: by 2002:adf:ff86:0:b0:207:a89b:f532 with SMTP id j6-20020adfff86000000b00207a89bf532mr5744866wrr.558.1649750823914;
        Tue, 12 Apr 2022 01:07:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpE+YrfgLKSaqQEucvAkzmjqLKY3AuURrxrIAYziIUmLTk+AXPmEsg4Tb3dLG4rGjFxW+4jA==
X-Received: by 2002:adf:ff86:0:b0:207:a89b:f532 with SMTP id j6-20020adfff86000000b00207a89bf532mr5744843wrr.558.1649750823604;
        Tue, 12 Apr 2022 01:07:03 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b00207aac5d595sm3027586wrx.38.2022.04.12.01.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:07:03 -0700 (PDT)
Message-ID: <4128b288-2b9a-f9cd-01f3-a1d50d3e10bb@redhat.com>
Date:   Tue, 12 Apr 2022 10:07:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/5] drm/solomon: Move device info from ssd130x-i2c to
 the core driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-5-javierm@redhat.com>
 <CAMuHMdVSsAtRLob5fLoBMNu-DRXJOaBrEHYEwG5iCA03XR5JSw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVSsAtRLob5fLoBMNu-DRXJOaBrEHYEwG5iCA03XR5JSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 09:23, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> Thanks for your patch!
> 
> On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> These are declared in the ssd130x-i2c transport driver but the information
>> is not I2C specific, and could be used by other SSD130x transport drivers.
>>
>> Move them to the ssd130x core driver and just set the OF device entries to
>> an ID that could be used to lookup the correct device info from an array.
>>
>> While being there, also move the SSD130X_DATA and SSD130X_COMMAND control
>> bytes. Since even though are used by the I2C interface, it could also be
> 
> though they are ... they could
>

Right, will fix it.
 
>> useful for other transport protocols such as SPI.
>>
>> Suggested-by: Chen-Yu Tsai <wens@kernel.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
>> --- a/drivers/gpu/drm/solomon/ssd130x.c
>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> 
>> @@ -860,7 +890,14 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
>>
>>         ssd130x->dev = dev;
>>         ssd130x->regmap = regmap;
>> -       ssd130x->device_info = device_get_match_data(dev);
>> +
>> +       variant = (enum ssd130x_variants)device_get_match_data(dev);
> 
> (uintptr_t), to avoid a cast from pointer to integer of different
> size warning.
>

Indeed. The kernel test robot reported the same.
 
>> +
> 
> Please drop the blank line.
>

Ok.
 
>> +       if (variant >= NR_SSD130X_VARIANTS)
>> +               return ERR_PTR(dev_err_probe(dev, -EINVAL,
>> +                                            "Invalid SSD130x variant\n"));
>> +
>> +       ssd130x->device_info = &ssd130x_variants[variant];
>>
>>         if (ssd130x->device_info->page_mode_only)
>>                 ssd130x->page_address_mode = 1;
> 
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

