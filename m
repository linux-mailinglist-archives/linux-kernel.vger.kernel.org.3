Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655CF4B2D71
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbiBKTTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:19:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348143AbiBKTTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:19:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B1B7CEC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644607153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyCtcy17QHLTtv1k1HmEtsqRuXGxf8tgP4TsQBAS3bU=;
        b=QorM1DuuJk5EkTfMML5FBAMmrbZ3lxBMuWs+dZF5+w6PJ00gajNX6cSM34egxJyEfoZSTH
        zW3hp3oq7FbipjHAzHm5+uw5oOCKJCbKKMpQAd56HVMEQfqVFXSv4qBoT7UIRwQHDG3Hjk
        UZgVa3pUMyFVkh0Z7cRaCdMBTbM9MI0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-jbPUF1bHP2Ce-z50aH2wog-1; Fri, 11 Feb 2022 14:19:11 -0500
X-MC-Unique: jbPUF1bHP2Ce-z50aH2wog-1
Received: by mail-wr1-f71.google.com with SMTP id v9-20020adfa1c9000000b001e33e5dbd5fso4202065wrv.17
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LyCtcy17QHLTtv1k1HmEtsqRuXGxf8tgP4TsQBAS3bU=;
        b=a9UVbwntS93JDLrhQ0tbZy9S1IUAX6y5nToSFuD/0nbP+MNu0ahBNs/onye7Yy3GbE
         /K6TlNJ+SaMW5P3OlQwpaDrtWnZEoRTakaLNvRxk7F6ZRdEZ67J1vsQsU3XGsFYycuaW
         li0tg9bBPyiDdnlWNVYdo8dfLMjeaGfEowka8aR+VNU0hjAtEHu3apW9iKcPgmT7Cv4h
         1qGmhXN8jiYNcNxq5LZVO18lYCH4xvgoCz/TykopzdvL0UrPYh7g+4M8QgFmDi6pv00Q
         Xw7/8kb2SbpgycHhPoHk1+O/wYKB/NBgCURADp/hksK4e+CPOUifKXssCHWpmRBSfAis
         0fYw==
X-Gm-Message-State: AOAM533qhgXVRpXF+nvHg80J9se+ZMOCs4vbA7JrwkODAEQlyXCXAkjo
        1Z2rkxHfVP+4x9zg6XrHcCEQxeSEvjiYat9AkMmuLKUpHQMdwIlg2zw2J6MKLZ4JtUYImMCs73e
        u7AoLj7KZK6YpSWdNm2LntoJS
X-Received: by 2002:a05:6000:8:: with SMTP id h8mr2474761wrx.332.1644607150707;
        Fri, 11 Feb 2022 11:19:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiqXfjbhptD1x8APLYHH3orD+YxL3kzwWSg/16agCVLRuxyjHANNX5i/1FKkT7EkMLscBwrQ==
X-Received: by 2002:a05:6000:8:: with SMTP id h8mr2474732wrx.332.1644607150371;
        Fri, 11 Feb 2022 11:19:10 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l12sm17301844wrs.11.2022.02.11.11.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 11:19:10 -0800 (PST)
Message-ID: <001ee392-d457-31e5-0087-272ef82afd12@redhat.com>
Date:   Fri, 11 Feb 2022 20:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 3/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20220211143358.3112958-1-javierm@redhat.com>
 <20220211143358.3112958-4-javierm@redhat.com>
 <YgaLGDVscXlANxcZ@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgaLGDVscXlANxcZ@smile.fi.intel.com>
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

Hello Andy,

On 2/11/22 17:13, Andy Shevchenko wrote:

[snip]

> 
>> +#define SSD130X_SET_COM_PINS_CONFIG1_MASK	GENMASK(4, 4)
> 
> BIT(4)
> 
>> +#define SSD130X_SET_COM_PINS_CONFIG1_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG1_MASK, (!val))
>> +#define SSD130X_SET_COM_PINS_CONFIG2_MASK	GENMASK(5, 5)
> 
> BIT(5)
>

I actually thought about that when using these macros and considered
just using BIT(N) instead but at the end decided to do GENMASK(n, n)
for two reasons:

1) It better documents what this is about, that's bitmask of 1 -bit.
   One of the main advantages of using these macros for me is to better
   express what these are, otherwise could just use 1 << n or whatever.

2) It's consistent with the other definitions for bitmasks that have
   more than one bit.
   
Looked at other drivers using these macros and noticed that is not
uncommon to have GENMASK(n, n), so I went for that.
 
>> +#define SSD130X_SET_COM_PINS_CONFIG2_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG2_MASK, (val))
> 
> I would put GENMASK() directly into FIELD(), but it's up to you
> (and I haven't checked the use of *_MASK anyway).
>

Same. I also considered just using GENMASK() directly, but since I was
already reworking these, I thought that having the _MASK constant macros
would make the code more explicit about these being masks and what for.

> 
> ...
> 
>> +static int ssd130x_write_data(struct ssd130x_device *ssd130x, u8 *values, int count)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_bulk_write(ssd130x->regmap, SSD130X_DATA, values, count);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
> 
> return regmap_bulk_write(...);
>

Sure.

>> +}
> 
> ...
> 
>> +/*
>> + * Helper to write command (SSD130X_COMMAND). The fist variadic argument
>> + * is the command to write and the following are the command options.
>> + *
>> + * Note that the ssd130x protocol requires each command and option to be
>> + * written as a SSD130X_COMMAND device register value. That is why a call
>> + * to regmap_write(..., SSD130X_COMMAND, ...) is done for each argument.
>> + */
> 
> Thanks!
>

You are welcome.
 
>> +static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
>> +				    /* u8 cmd, u8 option, ... */...)
>> +{
>> +	va_list ap;
>> +	u8 value;
>> +	int ret;
>> +
>> +	va_start(ap, count);
>> +
>> +	do {
>> +		value = va_arg(ap, int);
>> +		ret = regmap_write(ssd130x->regmap, SSD130X_COMMAND, (u8)value);
> 
> Wondering if you really need this casting. value is u8 by definition.
>

Yeah, I'll drop it too.

[snip]

>> +	ssd130x = devm_drm_dev_alloc(dev, &ssd130x_drm_driver,
>> +				     struct ssd130x_device, drm);
>> +	if (IS_ERR(ssd130x)) {
> 
>> +		dev_err_probe(dev, PTR_ERR(ssd130x),
>> +			      "Failed to allocate DRM device\n");
>> +		return ssd130x;
> 
> This...
> 
>> +	}
> 
> ...
> 
>> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
>> +					    &ssd130xfb_bl_ops, NULL);
>> +	if (IS_ERR(bl))
>> +		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
>> +					     "Unable to register backlight device\n"));
> 
> Can be consistent with this then.
> 

Yes. I meant to change it everywhere but seems that one slipped it through.

It's not worth to send a v6 just for the changes you mentioned but I can do
them before pushing the patches to drm-misc (once I get ack for this patch).

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

