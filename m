Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094844AD426
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352414AbiBHI4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiBHI4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:56:50 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D985C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:56:49 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EBFF83F4B6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644310607;
        bh=jrCjP6cigoq2hUV57n4k5BTndMW5LQallJ585bA4v4U=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=b/sAkhKFjLJazsU5AjfDQ0dfetpumh0ZCRtRzNLaG9HlL/l9B5qlX02p1J15ENeM7
         B7ipymFrHwOWbahXFByDwJZMcj3z9HLaslUyaTQ043b+m451WEl5KALWk+xcjeaA/B
         YF1kdQ/HGnxlKK88xq+hl3iXYXGUscqo77EQgusRNYpMihufgzIkI1tuPNGe+wClDI
         pfaw9d+73hWYXQ9Royk4TJlNA4Q9oCfU30nW9IIgNE+4VE6/HHNX7+rdbbiyO1JGA+
         QWzqOk1nOtfHAQWefqSOBFH9fK5z7olpawtzbYTXCHAymP7wcV3/LHmwb/GvPZwsTS
         Pesz19Yy/gN+w==
Received: by mail-ej1-f72.google.com with SMTP id la22-20020a170907781600b006a7884de505so5431113ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jrCjP6cigoq2hUV57n4k5BTndMW5LQallJ585bA4v4U=;
        b=j7eab2RE9XXTifRHqBZMMfcvz83cBIBlGUzdmHDGSDb+8Su/5eh4f5V4mehOtAga+0
         9YqRou+Ou8BfxcxvjGH0h2SKcOwZcTPgFNBWI3CFk+2DyDD8mjMhO3G8Hk+DfuvQY0Mx
         AlXei/sg0L7QB3NVdymDXI7es5ixPe7rRJraI6sFlEcaC+Q33vvT88NmjJyoSKsFwlZo
         4fVZmjaGHioHa+DbBPHpc/DQqS1qzc9jeWTyA+puUl0I+1SPrAU6evcxRBmafhgxaeBP
         LlFb80dDkzaxoL57NLhKxCM9zN6+gK7eXW6sTQbTGkV1whmRbkdRji1twaXckUW6dwPq
         deuw==
X-Gm-Message-State: AOAM5323AtcrtU45gugPefvBRqgC/7YFqbNqcaWftE61Lsy8qI1Oan1L
        g0kllIckO0Ah1Vk9WCiwvgS25QOgwWOHC31IzeuGuYMVgMC2hhJX4SbQyM9OGifLhTtg6XzLY2j
        1oiG+fQJ7Jy4O6N+HN0uZw6GUDJD2XRhzKuhdZUe4mg==
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr2940481ejc.770.1644310607492;
        Tue, 08 Feb 2022 00:56:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWL7auPyMvH/eI9rxLnQiNw2PVY1Wgkiymv6mfS8QZo6OPnHvXX90ldKMwT7Z004YsVjstlQ==
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr2940447ejc.770.1644310607251;
        Tue, 08 Feb 2022 00:56:47 -0800 (PST)
Received: from [192.168.0.92] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a21sm4220537eds.5.2022.02.08.00.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 00:56:46 -0800 (PST)
Message-ID: <1a172e64-f662-2a36-71ef-4214cfe5bffc@canonical.com>
Date:   Tue, 8 Feb 2022 09:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 6/6] i2c: npcm: Support NPCM845
Content-Language: en-US
To:     Tali Perry <tali.perry1@gmail.com>
Cc:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Tyrone Ting <warp5tw@gmail.com>, avifishman70@gmail.com,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>, semen.protsenko@linaro.org,
        yangyicong@hisilicon.com, Wolfram Sang <wsa@kernel.org>,
        jie.deng@intel.com, sven@svenpeter.dev, bence98@sch.bme.hu,
        lukas.bulwahn@gmail.com, arnd@arndb.de, olof@lixom.net,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tali Perry <tali.perry@nuvoton.com>,
        Avi Fishman <Avi.Fishman@nuvoton.com>,
        tomer.maimon@nuvoton.com, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        kfting@nuvoton.com, devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220207063338.6570-1-warp5tw@gmail.com>
 <20220207063338.6570-7-warp5tw@gmail.com> <YgEJ1M40AG9EuRPI@latitude>
 <086655b0-b9d2-30ed-1496-47cdc6346003@canonical.com>
 <CAHb3i=vpFwez+ZzDhHkSxjkios3tyoM2urRpCxOn3vfwzvewog@mail.gmail.com>
 <30ac5fe7-9d96-a756-24b0-384361b48a2d@canonical.com>
 <CAHb3i=ukzVr4DDgcPQ2+DO+LXWWtgjCe03WbG-CqvsOP_qqvUw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAHb3i=ukzVr4DDgcPQ2+DO+LXWWtgjCe03WbG-CqvsOP_qqvUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 09:51, Tali Perry wrote:
>> On 08/02/2022 08:14, Tali Perry wrote:
>>>> Subject: Re: [PATCH v1 6/6] i2c: npcm: Support NPCM845
>>>>
>>>> On 07/02/2022 13:00, Jonathan Neuschäfer wrote:
>>>>> Hello,
>>>>>
>>>>> On Mon, Feb 07, 2022 at 02:33:38PM +0800, Tyrone Ting wrote:
>>>>>> From: Tyrone Ting <kfting@nuvoton.com>
>>>>>>
>>>>>> NPCM8XX uses a similar i2c module as NPCM7XX.
>>>>>> The only difference is that the internal HW FIFO is larger.
>>>>>>
>>>>>> Related Makefile and Kconfig files are modified to support as well.
>>>>>>
>>>>>> Fixes: 56a1485b102e ("i2c: npcm7xx: Add Nuvoton NPCM I2C controller
>>>>>> driver")
>>>>>
>>>>> It's not really a bug fix, but rather an additional feature.
>>>>> Therefore, I suggest removing the Fixes tag from this patch.
>>>>>
>>>>>> Signed-off-by: Tyrone Ting <kfting@nuvoton.com>
>>>>>> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
>>>>>> ---
>>>>> [...]
>>>>>>  /* init register and default value required to enable module */
>>>>>>  #define NPCM_I2CSEGCTL 0xE4
>>>>>> +#ifdef CONFIG_ARCH_NPCM7XX
>>>>>>  #define NPCM_I2CSEGCTL_INIT_VAL 0x0333F000
>>>>>> +#else
>>>>>> +#define NPCM_I2CSEGCTL_INIT_VAL 0x9333F000
>>>>>> +#endif
>>>>>
>>>>> This is going to cause problems when someone tries to compile a kernel
>>>>> that runs on both NPCM7xx and NPCM8xx (because the driver will then
>>>>> only work on NPCM7xx).
>>>>
>>>> Yes, good catch.
>>>>
>>>> The NPCM7XX is multiplatform, I guess NPCM8xx will be as well, so this looks like an invalid code. How such code is supposed to work on multiplatform kernel?
>>>>
>>>
>>> NPCM7xx and NPCM8xx are very different devices.
>>> They share same driver sources for some of the modules but it's not ABI.
>>> Users cannot compile a single kernel with two separate DTS.
>>> In case of the i2c controller, the npcm7xx has a 16 byte HW FIFO,
>>> and the NPCM8xx has 32 bytes HW FIFO.
>>> This also means that registers fields are slightly different.
>>> For init data we can move it to the DTS, but register field sizes
>>> can't be handled with this approach.
>>>
>>
>> What do you mean they cannot compile a kernel with different DTS? Of
>> course they can - when we talk about multiplatform sub-architectures!
>> Maybe there is something specific in NPCMxxx which stops it but then it
>> should not be marked multiplatform.
>>
> 
> 
> NCPM7xx is ARM32 bit (dual core Cortex A9)
> NPCM8xx is ARM64 bit (quad core Cortex A35)
> 
> They have completely different architecture so not ABI compliant.
> I2C module is similar, but the devices are quite different and have
> separate architectures.

OK, in such case usually you indeed can't have both. :)

> Sorry for the confusion.
> This is the first patch we try to upstream for NPCM8xx.
> In the coming weeks we will upstream the architecture of NPCM8xx as well.

Still, ARCH_XXX should not be hard-coded in the drivers to change the
driver's behavior, even if driver won't be used simultaneously. It
breaks all design principles and prevents any further re-use if a new
use case appears.

You can use "ifdef ARCH_XXX" to skip building of some parts of the
driver, but it's not the case here.


Best regards,
Krzysztof
