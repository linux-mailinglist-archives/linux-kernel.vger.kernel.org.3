Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0006149C571
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiAZIl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:41:26 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46368
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230519AbiAZIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:41:25 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 77EAA3F197
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643186484;
        bh=MvhbiN5MMNYU7hqMrRzTsXC+uHqIqDEC2OOeXTzdnqc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=W6vjqZyM1SbNOF95DszPyLhvIzTyB9nn2r1dlowaBMkEIV9C1nwFksVChoJ1V/Rqt
         5TjKj+Zg7Y2sRejchOnirGL9vuCO57/2mOYxnV2wKndwsNdmV+etfPyEuVo7aL74w0
         pBJwjJaqf+o2vHP1f8tO8hiK5gBOt1+7O+TzKRGvbnQYbt6DRItGxqjcc7hP9pWfbT
         HJ3mJ3adtPaDSPiOCWP5JGQAXRuN4NTnu/kHD/LOocNOAm8t6lDKcglZeMCbI8XRVh
         kW8oNZiu1x+qCJs3Qow4hEg9j0DWbtl67Luk+SzWWQxDCxje01tv2Xgpsf4onno2X+
         IwV2T5ZA3ismg==
Received: by mail-wr1-f70.google.com with SMTP id r26-20020adfab5a000000b001d67d50a45cso3968782wrc.18
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MvhbiN5MMNYU7hqMrRzTsXC+uHqIqDEC2OOeXTzdnqc=;
        b=QFduxCSd3EutAn+U5oqhDwfByNMEqvttMIJ6o2yRaPRwA/4S5yVEgi3OF00wb7jjzk
         kkQIeqJMQpfavPpPK3XRjmin4qJvEkjbzRnOOzTXU0DOR/pFnSDil1FdLX2NAJRsvDN8
         5KfNPTCVY3XOcR2+TwQHk+9DVLQdFoQd+Tnm3U2h9cToHVsUWhWLMnlY2erPgxDozHGt
         yHmsBBwVkCyVMU4vatIy7/7ZiscLYmPd1lERJVJDffJztAatbEd9tf4CHTXorXgVAdsN
         SQLdS0udCIVZ80bkIV1vjwK8ioxLDvYqFCEgWmPLUeOZfYHUHhEEgvzhYGlvxq3E9bKg
         Qryg==
X-Gm-Message-State: AOAM533wdm263OWJFM0dGXei+nZf4gn9Sg2uVSgoKTMX61gnvtcutRac
        zN0p7CNtgRqUr/dRhI6eybL9UTtj3wiyEEVxV1isl/SrwoOMNFX272ry+J25GmAXkcI5RBiSXMw
        MkFiCf58tQOcZqCH3eEE0/jwAkZvo2pYFmNtL19urdA==
X-Received: by 2002:adf:e806:: with SMTP id o6mr22473395wrm.331.1643186480502;
        Wed, 26 Jan 2022 00:41:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXoHj/4QvKRm5T7/Y0OI0y/w1oCu75F3OpZukCWWW0CNuv4ZALkAKZdf7YGevstvuatonoDA==
X-Received: by 2002:adf:e806:: with SMTP id o6mr22473374wrm.331.1643186480309;
        Wed, 26 Jan 2022 00:41:20 -0800 (PST)
Received: from [192.168.0.60] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v124sm2588509wme.30.2022.01.26.00.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 00:41:19 -0800 (PST)
Message-ID: <2f4dd91a-e4ad-2559-f65e-914561de4047@canonical.com>
Date:   Wed, 26 Jan 2022 09:41:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Adding architectural support for HPE's GXP BMC. This is
 the first of a series of patches to support HPE's BMC with Linux Kernel.
Content-Language: en-US
To:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <nick.hawkins@hpe.com>
 <20220125194609.32314-1-nick.hawkins@hpe.com>
 <CAK8P3a0ccoH_sNE9eWxQnWHEWNBPFL6k4k6mku=cHs_fRfnL-w@mail.gmail.com>
 <CA8148A1-578E-4621-9714-45AB391C353A@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CA8148A1-578E-4621-9714-45AB391C353A@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 02:49, Verdun, Jean-Marie wrote:
> Hello Arnd,
> 
> I work with Nick on upstreaming the initial code for our GXP asic. Many thanks for your feedbacks.
> 
> We will update accordingly. I must admit that I am a little bit lost regarding the process we shall follow to introduce a new SoC. We took the path to send first the DT side and then the drivers through a set of patch per driver. Andrew, seems to guide us into a direction where we shall have a very small DT initially and we will expand it in a step by step manner when we will get drivers approved, this might lead us into a process which might be very sequential. What is the best recommendation to follow ? Either way is ok on our side, I am just looking at the easiest solution for the code Maintainers.

The current DTS patch won't pass checkpatch because you have around 30
undocumented compatibles. The process does not have to be sequential -
quite contrary - rather parallel with several submission happening the
same time. The point is that we need to see the bindings and check
whether your DTS complies with them. Actually the check should be done
by you with dtbs_check, but let's say we also look at it.

Your patch with full-blown DTS and drivers is also good approach, except
there are no drivers sent. For example:
https://lore.kernel.org/?q=hpe%2Cgxp-i2c
https://lore.kernel.org/?q=hpe%2Cgxp-wdt
If you want to avoid building DTS sequentially, no problem, just send
the bindings and DTS.

Andrew's approach is much more flexible because it allows you to discuss
the bindings while not postponing the core part of DTS.


> 
> Most of this code is intended to be used with OpenBMC and u-boot. We didn't have yet upstream anything into the bootloader, and wanted to follow a step by step approach by initially publishing into the kernel (that explain why some init also are still hardcoded in the case the bootloader doesn't provide the data, that is still work in progress, but we can have end user testing the infrastructure). We have a very small user space environment to validate that the kernel boot properly by using u-root, before getting OpenBMC fully loaded. Last but not least, as this is a BMC code, which is new to our end users, it would be just great to have default fall back if the u-boot environment is not properly setup (roughly we could code the MAC address into the umac driver, or the DT to address such cases). We plan to update uboot in the next couple of days by the way. 
> 
> We do not use dtsi at all for the moment, as we are generating a dtb out of the dts file and load it into our SPI image. Probably not the best approach, but this is the way it is implemented currently. The dtb is compiled outside the kernel tree for the moment using dtc compiler. We will add that step into the dts boot Makefile, it make sense. Does the dtsi is mandatory for every SoC ? I can build one if needed. But as this SoC is a BMC, the current dts is an example of what shall be configured. Many other datas related to the hardware target platform are defined into OpenBMC layers while we build for various ProLiant servers. We wanted our kernel code being readily testable that is why we have that generic dts. (GPIOS mapping is machine dependent)

The commit misses description, so I actually don't know how the
architecture looks like. For most of SoC, there is a DTSI because the
SoC is being put on different boards/products. It allows clear
separation between SoC (which could be reused) and board. If you have
only a DTS, then:
1. Where is the SoC here? How it can be re-used by different board?
2. Is it only one DTS per entire sub-architecture? No more boards? Only
one product? No even revisions or improved versions?

Best regards,
Krzysztof
