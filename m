Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7C4AF687
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiBIQ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiBIQ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 227A1C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644423967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9tzfRXX9aIJ3ddS/ncBHLRQCL4mho0HZX6VdWoJ+48=;
        b=GNnxncPrtewnvqLHH/PbSOGrwX7X2CZU5xoxbnbRUZd3nj4a0lvpR1KGw8cJZTquWSfx7A
        zvQkfxF6OQVraHGj6GRXrUOLRqB4bw8BQQTjXl3Gbv7K/WSXddqzPbu1+exjh3haEWHVfu
        OOnnGQ1f7f5N5RAf7gG8ktNqcPyDZOA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-qUmzi6XTOlO5qdTvDrJk7w-1; Wed, 09 Feb 2022 11:26:04 -0500
X-MC-Unique: qUmzi6XTOlO5qdTvDrJk7w-1
Received: by mail-wr1-f71.google.com with SMTP id j8-20020adfc688000000b001e3322ced69so1296613wrg.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T9tzfRXX9aIJ3ddS/ncBHLRQCL4mho0HZX6VdWoJ+48=;
        b=a6WZN+qDne2K1hji1diTst5236qO3fog7tsoWVPCQiNHkYrGXiJOcRwT3yTg8IIzQX
         CSmHofGKioS4mnU2CXdO6Y7O26GuYkH/ZxjmsTYTtuXYGfnon+JfsWx8LccIMQYAu1TD
         7QUdvsGZBx3XCjN5bMFAxeoTVqUkWeyy0XT03dpSBCrvGryCfEW4hmDOza5Oj5T5gjoQ
         mHQ+8djl5H5Im9mc2L0cEfLpi4929g/mWrdvoJDHHJbMYlyn1OiqBvJ0fjr6IiK1PIX+
         31KwOGR+sHe5M2j8QVkGkGEgUjhK01A+eUSE1l6YrGKAIlU4f0Za9hg3q6xDVuSWOQAG
         j4IA==
X-Gm-Message-State: AOAM5325C3gi2B/A8ElzV2jOaXrslFhPNLn82GNIH9s18YD6GYldSf+T
        Fa1k+rgwmlQxFSns0zWnXdMlZYuhM4C4SmE0/nlZDLYll9PENnh4okM1iB7alvX8744ji223Trp
        iro3LP6mHVmJjXLRe6BuYqSy5
X-Received: by 2002:a05:600c:3549:: with SMTP id i9mr2759711wmq.23.1644423962957;
        Wed, 09 Feb 2022 08:26:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKaf2S5vQEeUlpONN8Lw24iZWfuG6UcC4phWOJMjQWloR3GX0YNxop48TsjVq5kgNCNsqZBA==
X-Received: by 2002:a05:600c:3549:: with SMTP id i9mr2759672wmq.23.1644423962457;
        Wed, 09 Feb 2022 08:26:02 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p14sm17885082wrr.7.2022.02.09.08.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:26:02 -0800 (PST)
Message-ID: <406152d8-13e4-de8a-9542-bf1d96dbab0a@redhat.com>
Date:   Wed, 9 Feb 2022 17:26:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
 <YgPZ3W0e7N7JQ1dT@smile.fi.intel.com>
 <e29eaccc-863a-21d4-e669-0b708604d723@redhat.com>
 <YgPnE0yj0Y0OJxq6@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPnE0yj0Y0OJxq6@smile.fi.intel.com>
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

On 2/9/22 17:08, Andy Shevchenko wrote:

[snip]

>> Agreed, as mentioned I'll give it a try to sending all the data as a
>> bulk write with regmap.
> 
> Ah, it might be that it should be noinc bulk op. Need to be checked anyway.
>

Yeah, I'll give it a try for v4. Let's see how it goes.

[snip]

>>>
>>> A-ha, why not in the callee?
>>>
>>
>> I think is easier to read when doing it in the caller, specially since there
>> is only a single call. Than calling it unconditionally and making it a no-op
>> if there isn't a reset GPIO.
> 
> It doesn't matter where the check is and checking that in the callee seems
> better as it relies on the reset functionality. Caller in such case shouldn't
> even think if it's supported or not, not their business.
>

Ok, no strong opinions really so I will change it.
 
> Last, but not least, if you think of power management, you probably want to
> assert reset there as well, means additional checks?
> 
>>>> +		ssd130x_reset(ssd130x);
> 
> ...
> 
>>>> +	if (IS_ERR(ssd130x)) {
>>>
>>>> +		dev_err(dev, "Failed to allocate DRM device: %d\n", ret);
>>>> +		return ssd130x;
>>>
>>> return dev_err_probe() ?
>>>
>>
>> No, because this isn't a resource provided by other driver. If this
>> failed is mostly due a memory allocation error.
> 
> Is it a problem? dev_err_probe() got update in the documentation explaining
> that's fine to call even in such cases. The outcome is less amount of LOCs.
>

Thanks for pointing out. In my mind that was a way to denote in the code that
a probe deferral was possible and that the message should be debug but now I
went and read the comment as you suggested:

 * Note that it is deemed acceptable to use this function for error
 * prints during probe even if the @err is known to never be -EPROBE_DEFER.
 * The benefit compared to a normal dev_err() is the standardized format
 * of the error code and the fact that the error code is returned

So you are correct and using it is preferred even when no probe defer error
will be returned. I'll do that here and in the other places you mentioned.

[snip] 

>>> I have feelings that half of my comments were ignored...
>>> Maybe I missed the discussion(s).
>>
>> I assure you that no comments from you or anyone were ignored.
>>
>> I may had missed something but if if I did was a mistake and
>> not intentionally. I keep a changelog for each revision in
>> the patches with the name of the reviewer so people can check
>> and compare.
>>
>> If something that you mentioned is not there, I apologize and
>> please point me out so I can address it in v4.
> 
> It's just a feeling, because I repeating that dev_err_probe() a lot :-)
> Nevertheless, now I see at least your point why you went that way.
> But see my comments on it.

And I did use dev_err_probe() in the places that could cause a probe
deferral so it wasn't (completely) ignored.

On that topic, I even typed a SPI driver because of your feedback :)

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

