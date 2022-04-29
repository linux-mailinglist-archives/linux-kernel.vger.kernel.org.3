Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1845515586
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380699AbiD2U1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiD2U1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:27:16 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66D2D5EB7;
        Fri, 29 Apr 2022 13:23:57 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e93bbb54f9so9203734fac.12;
        Fri, 29 Apr 2022 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=SFIOKWJe2JhWRyQ+23tvbYEj6baZGKnP/u3z5kRMOi8=;
        b=BahK7/YeJ4+uX3TzsNp83MyBHnpLrE/qMu4xIBQ+ZS6zy01DaiHuUoeMxTPloX76K5
         Ubgax4WkYffJVNJHfHbej2xMadXBqbARWF06vNjo4iI2fpzfmtqnvbFUit+eVhoT1JhV
         L/oOL5XftssttI+3dl8EE8ip+1SLDGWPYT/KGiBuWq9m2dSZpPqkNlOUQZQhXWucL9yn
         1fTqb9x/Wr6wFFu0woyAx4hT7nL1jqWbVXQZqXhqHEX6+b6K6K/EYkfUjIg0dufd9cmz
         QpF+Wag/CjwN6tGuBEbwsUj/v1JxGTP/6FWWqjwteWqgFXZ5FfZeR3y6GbuGNkqHg17F
         kvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=SFIOKWJe2JhWRyQ+23tvbYEj6baZGKnP/u3z5kRMOi8=;
        b=oWbh7m9c6V8g7I4YB1HilOg1/++FP/pUOkyeJ/l++6yFg/muX5DNgxTb+ug/L0rrKX
         F/ruUuwScjxTV/uxGs2TERHmO2cXd8NUd0BsBccsOxBGLy7LsazOcHQ3wBJhT1gfG5zz
         ix0t6vLV8gzq7LnL2TtGEK/m7MU8yUNwAAH4dzOigu6Cc28f+9C45h4Um/dYcuHxZ1hU
         qHtN7iAA7nfcfSq9WHnR6D5fxAKcR4aiuZK0R9KPxzeVrvNrta8Z6etjirwjYlsgk/4o
         h5FKC/IhGu3Jdowt8u8TqSD7KjCT0OM75rvP1FMlIGyCxv1d1+KeCz0FCw0mjqby5Eeu
         FzKA==
X-Gm-Message-State: AOAM533uM/sgk2gvbldMRwRzhDQL7HpBo9IFH7e50VnWMJqNgpdeGgzh
        D/rkVGn871qH91EZ0RnaJkf9DNHePIm7fw==
X-Google-Smtp-Source: ABdhPJzws2nk+8IQUdLMQ/UW+L134oqTe0mAkrmJ+izKxrmouBw2DYvgJERUyyz49n7YZEOnnZehOg==
X-Received: by 2002:a05:6870:60a1:b0:e2:b6b8:3e67 with SMTP id t33-20020a05687060a100b000e2b6b83e67mr2057906oae.137.1651263837158;
        Fri, 29 Apr 2022 13:23:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k14-20020a4ae28e000000b0035eb4e5a6cfsm1153965oot.37.2022.04.29.13.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:23:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
Date:   Fri, 29 Apr 2022 13:23:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
 <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net>
 <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
 <20220422234150.GA3442771@roeck-us.net>
 <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net>
 <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net>
 <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net>
In-Reply-To: <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 10:48, Guenter Roeck wrote:
> On 4/28/22 06:44, Arnd Bergmann wrote:
>> On Sun, Apr 24, 2022 at 8:48 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>> On Sun, Apr 24, 2022 at 5:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> On 4/24/22 01:52, Arnd Bergmann wrote:
>>>>> On Sun, Apr 24, 2022 at 4:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>> into the defconfig file, otherwise the multiplatform target defaults to
>>>>> an ARMv7 instead of ARMv5 build. For an OMAP15xx as in the SX1,
>>>>> you also need to enable CONFIG_ARCH_MULTI_V4T.
>>>>>
>>>>> This is slightly unfortunate, but I don't see any way to avoid it, and the
>>>>> modified defconfig will still work fine with older kernel trees.
>>>>>
>>>>
>>>> Yes, that works. I changed it in my configuration.
>>>
>>> Ok, great!. I managed to boot the z2 machine with PCMCIA support
>>> and it gets around the issue with my patch, correctly detecting the
>>> CF card.
>>
>> Hi Guenter,
>>
>> I have now sent out a fix that I'm happy with, and applied it to the
>> pxa-multiplatform-5.18 branch of the soc tree as well as the
>> combined arm/multiplatform tree.
>>
>> I have not merged this new version into the for-next branch
>> since I would like to see if there are any other regressions first.
>>
>> Can you run your boot tests on the arm/multiplatform branch
>> and let me know if that fixes everything you found? If that
>> takes a lot of manual steps on your side, I'd just wait for the
>> build bots and merge it after all there are no new compile-time
>> issues.
>>
> 
> I tried the pxa-multiplatform-5.18 branch. Its failures match
> those in v5.18-rc1.
> 

Uuh, wait, the build wasn't complete. There are still some
failures. I'll report later.

Guenter
