Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD24AAAAC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380777AbiBERkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:40:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380769AbiBERkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644082812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+XMIPONIeda9RhSsJc9ELak7yslDV8zLw8dyCY9WO4=;
        b=fG5PTKOJ/arSXnaYo++JCScHX9yaLlmWtUtOjmf0dhGQPz+sm03tn4ib/mRfDc/PUQn5q/
        /sRwWWnsn24V599rbe1MFDa3acsFS9pxoE1xewQuYq2sWG972RWDe0+kk8fuxvrWDEpitr
        NKW77KO6xHQhtYoHOPyTK6iW0Xkt6Co=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-HuQEbUE4OCyZsJH-x5F1PQ-1; Sat, 05 Feb 2022 12:40:11 -0500
X-MC-Unique: HuQEbUE4OCyZsJH-x5F1PQ-1
Received: by mail-wr1-f71.google.com with SMTP id i2-20020adfa502000000b001e30c5ae60fso491889wrb.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 09:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s+XMIPONIeda9RhSsJc9ELak7yslDV8zLw8dyCY9WO4=;
        b=w8cXXjE+TIPwMOAepyZtC3cbhYSFTBaM6NdgKNC8RWgZJk+/nlPHhO7Mv+0eHi+COK
         S0eS2eI5ob0qKGRijjSaamVjiyVd696kelPVpl2GH0L97Xad63rllHEu1uep2UGZSp3C
         1PuFyMl7qLKkSsczOOFdf5Py9cxRi64vT8bf+cRcAcYOgrz9EMkEh30xlxZD17zv+c+T
         oRgL6tL+0G5nwEvreh/dshZs9MMJUYeGHfY+VXnfb59ifzwECP8a74ZdYxzivqCwoU+h
         NjUsfeekBB8lXqpYopZHgpjUX+OXR1o6u8pKey+Ytna5XE8/1iztwy3fW/ig27vO0p7P
         LXBQ==
X-Gm-Message-State: AOAM533ZEsgBaI1IslLyGfrpC9aRdiPI1MbVSBW9UgSy4CxjfToQSJF/
        jvybRHZy0as5DvvyIZ1YGKVK42LaYxtou/YTRb9uCknwYfYjHk5ZCwFAMph2uuVFXovWKFFfT5w
        vweGLVOcC7PGFtYmvt9yPOIgv
X-Received: by 2002:adf:eacc:: with SMTP id o12mr3614255wrn.576.1644082809878;
        Sat, 05 Feb 2022 09:40:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwOCtnvSr9+0ruFVwU6XWZ8NVfXJZicBayON9c+Gj34T6iN20u+eYDTxD526vsLX81bmpGlg==
X-Received: by 2002:adf:eacc:: with SMTP id o12mr3614243wrn.576.1644082809582;
        Sat, 05 Feb 2022 09:40:09 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ay29sm4452119wmb.38.2022.02.05.09.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 09:40:09 -0800 (PST)
Message-ID: <8b87cbc8-4878-b320-9460-dac751f6f0d6@redhat.com>
Date:   Sat, 5 Feb 2022 18:40:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/4] drm/tiny: Add driver for Solomon SSD130X OLED
 displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20220204134347.1187749-1-javierm@redhat.com>
 <20220204134347.1187749-3-javierm@redhat.com>
 <Yf03sCSuQwHKvgA9@smile.fi.intel.com>
 <d4e8c16c-5586-3233-0b99-be15a4c0f7aa@redhat.com>
 <Yf511hhojzIXcNXp@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yf511hhojzIXcNXp@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/22 14:04, Andy Shevchenko wrote:
> On Fri, Feb 04, 2022 at 08:19:12PM +0100, Javier Martinez Canillas wrote:
>> On 2/4/22 15:26, Andy Shevchenko wrote:
>>> On Fri, Feb 04, 2022 at 02:43:45PM +0100, Javier Martinez Canillas wrote:
> 
> ...
> 
>>>> +struct ssd130x_device {
>>>> +	struct drm_device drm;
>>>> +	struct drm_simple_display_pipe pipe;
>>>> +	struct drm_display_mode mode;
>>>> +	struct drm_connector connector;
>>>
>>>
>>>> +	struct i2c_client *client;
>>>
>>> Can we logically separate hw protocol vs hw interface from day 1, please?
>>> This will allow to add SPI support for this panel much easier.
>>>
>>> Technically I would like to see here
>>>
>>> 	struct device *dev;
>>>
>>> and probably (I haven't looked into design)
>>>
>>> 	struct ssd130x_ops *ops;
>>>
>>> or something alike.
>>
>> Sure. I wanted to keep the driver simple, making the writes bus agnostic and
>> adding a level of indirection would make it more complex. But I agree that
>> it will also make easier to add more buses later. I will do that for v3.
> 
> I have SSD1306 display with SPI interface and I'm not able to test your series.
> With the above it at least gives me a point to consider helping (coding and
> testing)  with SPI one.
>

Yes, I understand that. On the other hand, I only have a SSD1306 with an I2C
interface so I'm interested in supporting that. Then someone could extend to
support other buses :)

But I agree with you that making the driver easier to extend and using regmap
would be desirable. In fact, since I will add the level of indirection I can
got ahead and attempt to add the SPI support as well.

I won't be able to test but I can use drivers/staging/fbtft/fb_ssd1306.c as a
reference for this.

> ...
> 
>>>> +	if (!fb)
>>>> +		return;
>>>
>>> Can it happen?
>>
>> I don't know, but saw that the handler of other drivers checked for this so
>> preferred to play safe and do the same.
> 
> So, either cargo-cult or indeed it may happen. Somebody may conduct a research
> on this...
>

Someone familiar with the simple display pipe helpers should chime in, I tried
to grep around but couldn't figure out whether it was safe or not to assume the
struct drm_framebuffer won't ever be NULL in a struct drm_shadow_plane_state.

As mentioned other drivers were doing and I preferred to be defensive rather
than leading to a possible NULL pointer dereference.
 
> ...
> 
>>>> +	drm_mode_probed_add(connector, mode);
>>>> +	drm_set_preferred_mode(connector, mode->hdisplay, mode->vdisplay);
>>>> +
>>>> +	return 1;
>>>
>>> Positive code, what is the meaning of it?
>>
>> It's the number of connector modes. The driver only supports 1.
> 
> A comment then?
> 

Yes, that makes sense.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

