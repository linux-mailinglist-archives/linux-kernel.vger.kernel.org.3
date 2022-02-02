Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0AF4A6D0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245026AbiBBIjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:39:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245039AbiBBIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ96plJnExVz4IofZgZgy11FIOo1veP7nuoBU4KJMcA=;
        b=BQmHESqj7So+lESTgNlrXx12KcqJ3SGlSnqbUdeIlnOt3tKjzBvXxDV41RnR54R0yfUfJu
        06JSlQkc7butqaeEC/TdQ5eYG6XMhfZ5Ywga6YikkPbmvlchYrs9qMwMh2bDRLSn21JkoT
        /d9U9GsE9K1hS1tBz4jgxYb70LQz5Vc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-V1TOX9n-N9uDNGP3YlDnUQ-1; Wed, 02 Feb 2022 03:38:54 -0500
X-MC-Unique: V1TOX9n-N9uDNGP3YlDnUQ-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso3423009wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 00:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IQ96plJnExVz4IofZgZgy11FIOo1veP7nuoBU4KJMcA=;
        b=t3BixA1nyhgnonhwfnUWptmnyxqfflihVO5U7kPKe5RY4dqQhxYR/sPVwQewTJpjD6
         7Dg+G761gg9AZRsE8YUTtsZP6mhaE5PXqBzB+Q9QIXdTZrguq2rnUqW9y1A+tWKCsZZm
         HaXPOqXSetGRoQoqW2iWNrPp6yZshO8LDfxk71Ms+bqiHLaWPZkfePFtMPHWh7/v8D9Z
         CZsNpYT7KxOSnJZxVCDrqIHQ/XtOKlIR8WdAytS5G1rgH8A2SmxIC+I3hoODr9v4++oi
         TFB1N2iYW23m8uyv+l09zLcggVDcwlVyKK/YOTmotnzrEMCgwndXi+k1LutncXjZNZ5F
         0wQA==
X-Gm-Message-State: AOAM532xqCnlVQ26eQLqUPsEjJHomjY8lA4hUgqYvaxw51aGFopgOSum
        0vegZoKfu9LRqpFtsuZjlsUjZWPAGRsF5MH1FP4TLhQQlZo31gVx9xzWu6bi7TJT6z1OIhKccxu
        IB8Wn5F+Tg4L8CC9JwZMmeXOh
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr5150573wmj.59.1643791133573;
        Wed, 02 Feb 2022 00:38:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxC9orog6Z8LfxDGH06ODz7grjUoMzfg+w2FlDgm3DeIkMP38HoKyw95IAqRi1WUhNTRJi28Q==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr5150546wmj.59.1643791133371;
        Wed, 02 Feb 2022 00:38:53 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z17sm3963598wmf.47.2022.02.02.00.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 00:38:52 -0800 (PST)
Message-ID: <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
Date:   Wed, 2 Feb 2022 09:38:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org> <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
 <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
 <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
 <YfmaqUBqCrgp0QdO@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfmaqUBqCrgp0QdO@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

On 2/1/22 21:40, Sam Ravnborg wrote:

[snip]

> 
> I took a look at the datasheets - and all ssd1305, ssd1306 and ssd1307
> are the same. They have timing constrains on the Vcc.
> The random schematic I found on the net showed me that a PWM was used to
> control the Vcc voltage - which again is used to control the brightness.
> 
> All the above has nothing to do with backlight - I had this mixed up in
> my head.
>

Yes, same here. I was leaning towards fixing the DT binding but then due
Geert comment and after reading the datasheets for ssd130{5,6,7} like you
I had the same understanding.

Glad that you agree.

[snip] 

> 
> Last I recommend to drop the fbdev variant - if the drm driver has any
> regressions we can fix them. And I do not see any other way to move
> users over. Unless their setup breaks then they do not change.
>

As I mentioned in this thread I wouldn't propose to drop the fbdev variant.
I prefer to use the carrot and not the stick. Peter Robinson suggested to
make the driver mutually exclusive and add !FB_SSD1307 in the config symbol.

I think that makes sense and will do it in v2.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

