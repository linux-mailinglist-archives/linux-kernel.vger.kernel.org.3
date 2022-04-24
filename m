Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C479350CE63
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiDXCMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbiDXCMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:12:07 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA041AAB73;
        Sat, 23 Apr 2022 19:09:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso8331781otf.12;
        Sat, 23 Apr 2022 19:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/4WY8lQ2r9E3jRayXo+cM/u5KEpSVq7T3K2hgqZLRN8=;
        b=iMm7j9be64nnY2we3kMeOQC5Pj129NrX5ABYhzCFQgIRJ+Ik/psrhjF5r/pmbNZvJy
         nA3uaouN4tuYuhiNIaHKYw+YwzjV+kJKW5pZWtDU0GTKWu//N59zGG1fdbP9tNgWJRjg
         AqNszvtPvjJNt2cEMqoWc2MQsq1/aQ70s6DAcNDBOaPYwZvIWFR4+Zb0ls+3EVu9eOAb
         KTSMm2n+k9g4CyFP8heqe4gzTDNSh2sRc5XtpvQCIpTgIm/O2folezzCln192gATJAVk
         i8DvmOlTzlnLi/wkKkSV70TYGsg4chRlc2jxJB+NXokPS/xNBOb/lAVbFPkYyy464S89
         OnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/4WY8lQ2r9E3jRayXo+cM/u5KEpSVq7T3K2hgqZLRN8=;
        b=qu/m1of248VHBxuc1OFIXpHOjbJQnrlCxWrc+gEO3APAnSUVmUd4lzJhlOcHXUO+o3
         b7aV5T4ckScAIXLH1iq2bVMViS/SsBIESMLOhiDa6XoFoXMvkOEsUDIdG/XZfPQGis03
         Uuvr8WRpjUCaIm6n+YFAU/7TLOWek9BRpQ3YrRgVw8pykVjnxCY8awZajB5Z0X2JphpF
         2gqgTM1FdG9Z2s/QJKGaWbYQLYs4EIUdORK7CBzU8DLRkYzEJlzbsHUSGwAzuC4MW18I
         JWVKqIIXOE2KwT6feO4mb8uMm+vIuLmHQOHM9HhIsV/hAneM3QOGMvOpsNvXaX72EFMR
         AuvQ==
X-Gm-Message-State: AOAM533Za/vln0QN96sAzdcfq/ZLx8o2e9zmD7/9NKnHIHpm0WJH+7Ox
        sHOGrwM2WOT/0j54pKqPUls=
X-Google-Smtp-Source: ABdhPJw1Nv7YurwGcrk889YKSXtPCE0PE6W5Bg0YNZLXIur1o0RT75r4zuYxuJBEQLPxL9fB1XCPwg==
X-Received: by 2002:a05:6830:2b29:b0:605:7cdb:f10b with SMTP id l41-20020a0568302b2900b006057cdbf10bmr4208370otv.157.1650766147578;
        Sat, 23 Apr 2022 19:09:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j126-20020acab984000000b002da77222b7dsm2325070oif.22.2022.04.23.19.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 19:09:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net>
Date:   Sat, 23 Apr 2022 19:09:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
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
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/22 12:55, Arnd Bergmann wrote:
> On Sat, Apr 23, 2022 at 1:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Sat, Apr 23, 2022 at 12:04:31AM +0200, Arnd Bergmann wrote:
>>> On Fri, Apr 22, 2022 at 10:55 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> On 4/22/22 12:16, Arnd Bergmann wrote:
>>>>> On Fri, Apr 22, 2022 at 7:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>> Which machine did you hit this on? Is this on hardware or in qemu?
>>>>>
>>>> qemu, as always. borzoi, spitz, terrier, tosa, z2, and sx1 fail.
>>>> Also, I just noticed that the failure is not always the same.
>>>> z2 fails to boot from initrd, and sx1 fails to boot completely.
>>>
>>> That's a lot of machines failing, I hope at least we got the same bugs more
>>> than once here.
>>>
>>> For the I/O space, I found now that PXA was not using the standard
>>> virtual I/O address yet, but instead used a NULL-based offset.
>>>
>>> I'm not entirely happy with this patch, but this is an outline of what
>>> I think we need to fix that: https://pastebin.com/3nVgQsEw
>>> This one is probably incomplete, at least it breaks sa1100 for now,
>>> and it adds a bogus CONFIG_PCI dependency. I'm also not sure
>>> in what way the last patch in the series triggers it, rather than the
>>> one that removed mach/io.h.
>>>
>>> I had sx1 booting in qemu at least, with the omap1 multiplatform series only.
>>> If you have a custom config for this one, make sure you get the right
>>> DEBUG_LL address.
>>>
>>>> I'll do another round of bisects.
>>>
>>
>> Here is the bisect for the sx1 boot failure.
> 
> Odd, I can't reproduce this at all. Do you get any console output at
> all for this?
> 
> Is this the plain omap1_defconfig, or something else?
> 

No, it is my own sx1 specific configuration.

https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/qemu_sx1_defconfig

I don't recall where I got it from but ...

> One thing I keep having to apply myself is this snippet:
> 
> diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
> index 0bfad62ea858..87c695703580 100644
> --- a/arch/arm/mm/proc-arm925.S
> +++ b/arch/arm/mm/proc-arm925.S
> @@ -441,7 +441,6 @@ __arm925_setup:
> 
>   #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
>          mov     r0, #4                          @ disable write-back
> on caches explicitly
> -       mcr     p15, 7, r0, c15, c0, 0
>   #endif

it does not have CONFIG_CPU_DCACHE_WRITETHROUGH enabled.

Guenter

> 
>          adr     r5, arm925_crval
> 
> I don't remember what the story is behind this, but I can't actually manage
> to boot omap1_defconfig on qemu with the instruction intact.
> 
>         Arnd

