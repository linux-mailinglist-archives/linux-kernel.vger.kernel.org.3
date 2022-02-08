Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA294ADCB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380483AbiBHPcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380449AbiBHPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57415C061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644334335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnfSnxFE1VYyOfFPEeAqSReRud2yqkNu5yv4OL4UGFM=;
        b=UZasacGUzfKcR9GO7vKmB1t9I65RTH9UzymhHDSqpi/okSsOfUMBhgyvMjK92eZP4/D4Rq
        a9gNh6cN0kkKjFst69S9aU2Hp1/plIqCrpJ2JNV8CXTafj8491UVGDfBiyIChFnNw4+W+C
        QQ2Q0ZI0e9wmjcc/YyhR1+ayvx4YYHw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-i0BI_YH_NVuF_Oo9m20FpQ-1; Tue, 08 Feb 2022 10:32:14 -0500
X-MC-Unique: i0BI_YH_NVuF_Oo9m20FpQ-1
Received: by mail-wr1-f71.google.com with SMTP id q8-20020adfb188000000b001e33a8cdbf4so901243wra.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 07:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QnfSnxFE1VYyOfFPEeAqSReRud2yqkNu5yv4OL4UGFM=;
        b=FhI0K3BgcpQFMf8nRc3giDImZdDUoU34ezhKLtFahyvdsCwlspCP2Hh0lkeGVbdfxE
         JRne56RnhXFwkzriU4wobx2dy7Um61qCtga/YUfaHqcUp5I6WSKBNyVYlAbItXgc3wMY
         ancBOzSaOY7ygbZXtn/SAxVKwB9Stb7ev7yMpB81TfpTpKK4bl3ItGfI4RUo8XGJ+9IX
         pOIMKuHxZ+XJNaVasO0ZPDqnQYltFTJZl7dNL2ONTwA/QzA3pRJMl450l4/U+pbXRTcA
         vMSsftU3s4hwIk4lCucvx6PbTUKaxC1b8nvHDTM4cHqcbnuqU0QmGgYNibURS2DmIO0W
         bdDw==
X-Gm-Message-State: AOAM531JbiT2fwJhmKoyUaybXcyOdpS0/XR6Eir5qYvXUy0VRodb9A2L
        S//zFZQoReSjjvvzxvweK8Qmq/0TvU5cGROjx6I5V4pKBA3oIsbxJtMl1NJy4wJPYve6zjo190j
        zSn3ryVyljmecKoX3WKf0QXGn
X-Received: by 2002:a05:6000:178d:: with SMTP id e13mr4078660wrg.199.1644334333064;
        Tue, 08 Feb 2022 07:32:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0uZ5F9GLuLEaXgNHD2jfvev/PazPYbXR3QUr3Uxy791l+CRAyYCO27d+KNpiT1o2GaLqxrQ==
X-Received: by 2002:a05:6000:178d:: with SMTP id e13mr4078640wrg.199.1644334332831;
        Tue, 08 Feb 2022 07:32:12 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z17sm2451298wml.38.2022.02.08.07.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 07:32:12 -0800 (PST)
Message-ID: <10e06ad6-e8bd-a6de-3334-c682125e7753@redhat.com>
Date:   Tue, 8 Feb 2022 16:32:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <CAMuHMdVTVX7LFay-rfv=oW96dMA24duMUVGRE62jQSNkrKtyMg@mail.gmail.com>
 <f178de92-7cb1-dcc5-1f60-9ccfc56bc0a4@redhat.com>
 <YgKJtjoFMSzxNiiI@sirena.org.uk>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgKJtjoFMSzxNiiI@sirena.org.uk>
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

Hello Mark,

On 2/8/22 16:18, Mark Brown wrote:
> On Tue, Feb 08, 2022 at 04:10:49PM +0100, Javier Martinez Canillas wrote:
>> On 2/8/22 15:19, Geert Uytterhoeven wrote:
> 
>>>   - "time ls" on the serial console (no files in the current directory,
>>>     so nothing to print) increases from 0.86s to 1.92s, so the system is
>>>     more loaded.  As ssd1307fb relied on deferred I/O too, the slowdown
>>>     might be (partly) due to redrawing of the visual artefacts
>>>     mentioned above.
> 
>> I was trying to first have the driver and then figure out how to optimize
>> it. For v3 I'm using regmap to access instead of the I2C layer directly.
> 
>> I noticed that this is even slower but it makes the driver more clean and
>> allows to support both I2C and SPI (untested but will include it as a WIP).
> 
> I wouldn't have expected regmap to add huge overhead relative to I2C,
> partly predicated on I2C being rather slow itself.  There will be some
> overhead for concurrency protection and data marshalling but for I2C
> clocked at normal speeds it's surprising.

Thanks for chiming in. That's good to know, I'll investigate more then.

Probably I was wrongly blaming regmap while it was another change that
is causing the display to be refreshed at a slower rate than before.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

