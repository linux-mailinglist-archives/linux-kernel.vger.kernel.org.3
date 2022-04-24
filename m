Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7FE50D2C1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiDXPhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 11:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiDXPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:31:27 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98985171C04;
        Sun, 24 Apr 2022 08:28:25 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id e4so14578216oif.2;
        Sun, 24 Apr 2022 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=yr0/AkbMMu8pn1dkU35YlQmF7na7yjrNnK/horRQvq8=;
        b=YTsJBncPwlsdJoy0clMDPkRYsap010NbelrrDwP4gT2p8VkAeOwyCadOMVg4EkLC3g
         BU6v4rcHRP7TcChruJdux/6WqtJmUToOWUlOimc0ldD0p/STL+v6YSxQqTz/SiEj3JGk
         6SfYzDXOC60C+Zk6YtFsjMz2c7gYsvaefbEF/eKAM03STJHCFm25OuC/Z0YH/2cfNqkA
         U538FM4O480tv4oZ6rwPTTcYDvIV4RyyrEvA6n7gY5KKJPB4B+s22HrjImpN8j9osv2G
         SEdJ9k63zxNOgRDgM+KmfcxMquHhbq8CJJjUKerT4sEDujG7ogRPrwOnyNIjdLCE9lFh
         BU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=yr0/AkbMMu8pn1dkU35YlQmF7na7yjrNnK/horRQvq8=;
        b=6vnD+8dQFmxyCIkjIp2rzinoLopet/bOToKxMnl2YtHOByGo/3uzEEWghB5ivZYWCi
         +rlylgSvpddSCP7L/jowhR+EY8PKx8gmUpaAklTLvOnGzBu+KsO0K5sZma/VxYfD+8O7
         cY1obNpFAKSpXcqX/vynqo70JQqRpH2fX6OJ/az/sdloBzVT1Hlbsy0t+ISTk9eja4i2
         NPP0370RoYz/QRrb9fuISYcH3nGQX0swBEPrmTAqQY3CW47NEd9aiH8cBNciV3kMxAg/
         0HhL+B10ELgesmaEYtrPaSpDfQrPLH0USQ0+qkRh8SEWZ8FsnZoU4Bz5k5H7i2AYbXQ+
         GfoA==
X-Gm-Message-State: AOAM533aS0heWnGx1qtXYFFuC/rH9r8ilEPuKVhXK6t5ZIQox5cSnKAm
        JAmIERVQLb6nkLj0Rfc7TIQ=
X-Google-Smtp-Source: ABdhPJy+gDyQI+jYYZai2x5URiEV01l+fMZDWT8YjU8/GgIriEk0FB5ZVdkvpb6NfVQx+IMk0aUfQA==
X-Received: by 2002:aca:f286:0:b0:2da:58ba:c578 with SMTP id q128-20020acaf286000000b002da58bac578mr6576017oih.127.1650814104777;
        Sun, 24 Apr 2022 08:28:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w8-20020a056830410800b00605b48122eesm53063ott.14.2022.04.24.08.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 08:28:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net>
Date:   Sun, 24 Apr 2022 08:28:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
In-Reply-To: <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/22 01:52, Arnd Bergmann wrote:
> On Sun, Apr 24, 2022 at 4:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 4/23/22 12:55, Arnd Bergmann wrote:
>>> On Sat, Apr 23, 2022 at 1:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> On Sat, Apr 23, 2022 at 12:04:31AM +0200, Arnd Bergmann wrote:
>>>
>>> Odd, I can't reproduce this at all. Do you get any console output at
>>> all for this?
>>>
>>> Is this the plain omap1_defconfig, or something else?
>>>
>>
>> No, it is my own sx1 specific configuration.
>>
>> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/qemu_sx1_defconfig
>>
>> I don't recall where I got it from but ...
> 
> Ok, that explains it, thanks!
> 
> I fixed all the defconfig files that come with the kernel, but for your own
> ones you have to add
> 
> # CONFIG_ARCH_MULTI_V7 is not set
> 
> into the defconfig file, otherwise the multiplatform target defaults to
> an ARMv7 instead of ARMv5 build. For an OMAP15xx as in the SX1,
> you also need to enable CONFIG_ARCH_MULTI_V4T.
> 
> This is slightly unfortunate, but I don't see any way to avoid it, and the
> modified defconfig will still work fine with older kernel trees.
> 

Yes, that works. I changed it in my configuration.

>>> One thing I keep having to apply myself is this snippet:
>>>
>>> diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
>>> index 0bfad62ea858..87c695703580 100644
>>> --- a/arch/arm/mm/proc-arm925.S
>>> +++ b/arch/arm/mm/proc-arm925.S
>>> @@ -441,7 +441,6 @@ __arm925_setup:
>>>
>>>    #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
>>>           mov     r0, #4                          @ disable write-back
>>> on caches explicitly
>>> -       mcr     p15, 7, r0, c15, c0, 0
>>>    #endif
>>
>> it does not have CONFIG_CPU_DCACHE_WRITETHROUGH enabled.
> 
> Maybe it was disabled explicitly for the sx1_defconfig because of this
> bug. I would think that this is required for actual sx1 hardware because the
> option is default-enabled for ARM925T, and that CPU core is exclusively
> used in OMAP15xx.
> 

That looks like a bug in qemu. ARM925T instruction support is limited to V4T
instructions. qemu doesn't have explicit 5T support. It is either V4T
or V5.

Guenter
