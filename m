Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4794AF1DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiBIMh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiBIMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:37:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4F7EC05CB9E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644410275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yv06k0qcIVzfebmQao0F8lU/DvXpAPuqfxT+fivD3r4=;
        b=ZZlWb2bWOJA/YRe6waWsCNKNEeE0XUgDMxeO6QzMqjDa/E9IseV8snOkWI8cR7uGQZFcvP
        MnZAyS9LzOW7JOsDGS71a+zKanbTRmokx4BvGHpdPjX6d937Z8EKeTCN71tZBCOLyxpPBx
        GSvlmkaEAaFWc2B0HD2RaO0I333MbKs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-Khykqd2QNQi1QQbROsKu-A-1; Wed, 09 Feb 2022 07:37:54 -0500
X-MC-Unique: Khykqd2QNQi1QQbROsKu-A-1
Received: by mail-wm1-f71.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so2604629wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 04:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yv06k0qcIVzfebmQao0F8lU/DvXpAPuqfxT+fivD3r4=;
        b=GGWr+t6e+C2GsnfQOyRf5lTC2/cO3cPCZgdYlHTj9Mt8ar6ThMT9rjeFBjms+OVouk
         eBSvhye9jI6Zc+2ZvfBZodaDw/z76wT+JuUFgFzZdztXvpOfWOlO8BRfGdN77Zc9zKNh
         EQZdUtqj6neE/5PWHfnPb5uQ53SMPauBXyqCrsFkvPa9whh6d89pGzUXZGGwgeApE/ib
         DS9BkgpylV1rmLUSPZBTtRY3Cjt3KNSCZ+pHaYHfzV1b+eV2XthmrJt9E5PtyF38TNjd
         Km3hJaF4okaxmF2u7zdzbv8TxWaYnedLYjR/I31l0a3wsFINE5WLbV5fZm8LO2mATsMn
         1vBw==
X-Gm-Message-State: AOAM531kTBsWIChfnpcQ6MZFqFguOnsO9ATeqV+4SXBLlV6v7VH0PKL8
        Mi3FK40cIzTGam+uOEaSKvzgIQQD5uB5c/IkAmgbZB06gfMpLn7JwxR+ULpcBr8/7mW2Bj1mMy1
        UyfnHpGZcQwLJZaF1r6l4sXV+
X-Received: by 2002:a05:600c:4fc2:: with SMTP id o2mr1884059wmq.145.1644410273539;
        Wed, 09 Feb 2022 04:37:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmjpeXcKAGK2lwWC20JlgA2fV6RbEkugJVOCgWV8vBNqH8VPABqTYOsxX7qWXxzkqn+qGm5A==
X-Received: by 2002:a05:600c:4fc2:: with SMTP id o2mr1884035wmq.145.1644410273273;
        Wed, 09 Feb 2022 04:37:53 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l28sm14096444wrz.90.2022.02.09.04.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:37:52 -0800 (PST)
Message-ID: <58ebacd2-d44d-c7e9-e752-de7815dd4cc1@redhat.com>
Date:   Wed, 9 Feb 2022 13:37:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <CAMuHMdVs750iE=kP1vabwgsGOb8sHc8aC5k=HwCU32CURnYktw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVs750iE=kP1vabwgsGOb8sHc8aC5k=HwCU32CURnYktw@mail.gmail.com>
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

Hello Geert,

On 2/9/22 13:19, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Wed, Feb 9, 2022 at 10:03 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
>> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
> 
> [...]
> 
>> - Fix a bug when doing partial updates (Geert Uytterhoeven)
> 
> Thanks, the text console is now more or less working as expected.

Thanks for giving it a try to this version too! Glad to know that
is working better now.

> There is still an issue with the cursor, though.
> After doing "echo hello > /dev/tty0", the text appears, but the cursor
> is gone. "clear > /dev/tty0" brings it back.
>

Hmm, I was able to reproduce this too. Thanks for pointing it out,
I'll investigate what the problem is.
 
> The execution time of "time ls" has improved. It now takes 1.21s
> (0.86s with ssd1306fb).
>

Yes, I believe that was due the bug I mentioned that partial updates
weren't done but a full screen update instead.
 
> The logo is not shown, even when I create a 16-color or 224-color
> version of the small monochrome logo I'm using.
>

I'll also dig into this.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

