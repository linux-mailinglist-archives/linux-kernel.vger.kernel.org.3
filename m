Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68284ADD13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381383AbiBHPk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381201AbiBHPkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:40:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A56FCC061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644334818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3+ygx7WT3LgjARaNLFe1zhALwKjcISILkzjd4t3g78=;
        b=PJPCIyjCr7oQuV7Ckv0+Lx4GaA+VdczlDgrrZqgo8B+BUyaPkE3F36t4evjS5zrYgDZyyL
        Om0EctAkiL/w/3k/S807Rdtnd57Q1ZAMrMalSGTCDfsZ8i8oeGsL/34a6lYAeODDcJxLTl
        4EuLDsmPAZAhBsIZ7+JMef/KUj8aE80=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-12iaTEKxNLGeErdsFaiqSw-1; Tue, 08 Feb 2022 10:40:15 -0500
X-MC-Unique: 12iaTEKxNLGeErdsFaiqSw-1
Received: by mail-wm1-f69.google.com with SMTP id a17-20020a05600c069100b0037bb7eb6944so554621wmn.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 07:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R3+ygx7WT3LgjARaNLFe1zhALwKjcISILkzjd4t3g78=;
        b=2x9qgLvTNrsvGIgOh+q89M2vd7ZnD39CcKhB3+Cq7mNCYk3sRrtxgUyJs4YH7H0NS9
         PoGRyMdBFll+nvRTrZXARGoZqI7su9cJX1dvJg2UqCghhG1SMk/ZAH6tZpZKNSMM8XDx
         LOGqWExs6IWsOeNumZ2xqunDsvc++BFE5r/uJZ8mPleUs4RDkVfCSTG8WK2l58/19qZ4
         zEyHr8iZ20CMgCpThLIP8qP2GcQrS1o4FJ5EMtvW6dF4ajI7EgtxT8Bfrp+HhOjxk5xM
         9g12ByNGHT+soZ1oVtx6I3tH4bdTBDeL9W8Yjdp5gLfFnk9xkW14jeV6tjIAau/svGuf
         LI4g==
X-Gm-Message-State: AOAM532nkVALsuo0ncZzJByn7QVMmM62MZuG/pvu77+svGRjvxBPRAVx
        PSmmxX0jnIcx7d2LW4A7GRm5fA0gI5K+zVcNdANSL4jJDdDBxHT/ayfmniVbTZBrcGl4i+AhknR
        ujfxdlJgCwPwqUtUH9G1oKin+
X-Received: by 2002:a5d:588e:: with SMTP id n14mr4244922wrf.45.1644334814512;
        Tue, 08 Feb 2022 07:40:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgsRW+lrC/D9yn6NeNRRQqunCaYEb9CMC26g+Mn3KPfiRrXRhLKFGC8C3j1dq2BkDZsEKSLg==
X-Received: by 2002:a5d:588e:: with SMTP id n14mr4244901wrf.45.1644334814281;
        Tue, 08 Feb 2022 07:40:14 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v18sm9972089wrm.105.2022.02.08.07.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 07:40:14 -0800 (PST)
Message-ID: <02d5b225-e1a8-77f6-7e4e-18d6a1df5e48@redhat.com>
Date:   Tue, 8 Feb 2022 16:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
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
References: <20220204134347.1187749-1-javierm@redhat.com>
 <CAMuHMdVTVX7LFay-rfv=oW96dMA24duMUVGRE62jQSNkrKtyMg@mail.gmail.com>
 <f178de92-7cb1-dcc5-1f60-9ccfc56bc0a4@redhat.com>
 <CAMuHMdWvrJip+W6ZZoO2ZURLc5CYmFno3=Sa2mL4xJE8gMzFqg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWvrJip+W6ZZoO2ZURLc5CYmFno3=Sa2mL4xJE8gMzFqg@mail.gmail.com>
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

On 2/8/22 16:23, Geert Uytterhoeven wrote:

[snip]

>>>   - The logo (I have a custom monochrome logo enabled) is no longer shown.
>>
>> I was able to display your tux monochrome with ./fbtest -f /dev/fb1 test004
> 
> I meant the kernel's logo (FB_LOGO_*),. Obviously you need to enable
> a smaller one, as the default 80x80 logo is too large, and thus can't
> be drawn on your 128x64 or my 128x32 display.
>

That makes sense.
 
>>>   - The screen is empty, with a (very very slow) flashing cursor in the
>>>     middle of the screen, with a bogus long line next to it, which I can
>>>     see being redrawn.
>>>   - Writing text (e.g. hello) to /dev/tty0, I first see the text,
>>>     followed by an enlargement of some of the characters.
>>
>> So far I was mostly testing using your fbtest repo tests and all of them
>> (modulo test009 that says "Screen size too small for this test").
>>
>> But I've tried now using as a VT and I see the same visual artifacts. I
>> wonder what's the difference between fbcon and the way your tests use
>> the fbdev API.
> 
> Fbcon does small writes to the shadow frame buffer, while fbtest
> writes to the mmap()ed /dev/fbX, causing a full page to be updated.
>

I see. Thanks for the information.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

