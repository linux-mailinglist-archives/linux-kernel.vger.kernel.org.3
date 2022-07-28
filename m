Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F8D583991
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiG1Hf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiG1Hf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:35:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA584BD31;
        Thu, 28 Jul 2022 00:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6875361B4B;
        Thu, 28 Jul 2022 07:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85905C433C1;
        Thu, 28 Jul 2022 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658993754;
        bh=wQZZqAL+kFVdUJWp5ooVgLp9Rrxami8eilCXEiS5KqM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r1w1vzS2BhHizZTBRkOlJ+pRrEiu5vFFIrU6oLsUx4k+uqmdAcJ1vMmV/ReSPVpG0
         8UOLUKnZuu1dTbOKOGDVA6hKhDVSp6+cXPO7TwbmC4nDUECQh+hBrPKS46P8YRgnsu
         /1LBKXagj6gZLWGk8Tw8ujcfoeQj2NxXCLVnRrs3BeIlIHDNgwJgLmEGhXod6PDGv3
         TcUEJs6ZAQMhg44c9Em2MU0Lw7rDllyvM2syS1IYq7KujnJJY6+fbkWVi2uHGniKcA
         +tynTk0mC880vFhIkQ7MbnyHbrmxnIJf+As+DrxtdZPGnl2P1HA25p2pEFe1OmyoMq
         uxqKvhZeDPa3w==
Message-ID: <8aa6228e-e6a2-b1f7-688e-8b4aa614c882@kernel.org>
Date:   Thu, 28 Jul 2022 09:35:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
 <3bb0ffa0-8091-0848-66af-180a41a68bf7@linaro.org>
 <CAODwPW89xZQZiZdQNt6+CcRjz=nbEAAFH0h_dBFSE5v3aFU4rQ@mail.gmail.com>
 <8f51aed8-956b-ac09-3baf-2b4572db1352@linaro.org>
 <CAODwPW9MvYJo8QbKOoVcUAKJ8Hxon2MCv_H5qpv=yaSTLLc+ug@mail.gmail.com>
 <628a7302-1409-81f7-f72b-6b1645df9225@linaro.org>
 <CAODwPW-4i+idH8Nz6=EmNUXYWgWkoOHs3wOZ7BbrH5GwGDZ1Ww@mail.gmail.com>
 <1f3189ef-7d3f-27b3-a691-b9649090b650@linaro.org>
 <CAODwPW-GDkfyFaNSnEngpSfz8LSXRetu+xwp3QrFHP1rH1O06w@mail.gmail.com>
 <86b9c6d6-e8e5-7f6d-0970-460baf9b6fcc@linaro.org>
 <CAD=FV=U8rgxuymX6hurS96rg1fjDUfh60b0X4UbpPp+TA+ck5g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAD=FV=U8rgxuymX6hurS96rg1fjDUfh60b0X4UbpPp+TA+ck5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2022 16:07, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jul 27, 2022 at 1:47 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 21/07/2022 01:42, Julius Werner wrote:
>>> Sorry, got distracted from this for a bit. Sounds like we were pretty
>>> much on the same page about how the updated binding should look like
>>> here, the remaining question was just about the compatible string.
>>>
>>>>>> Yes, we can. You still would need to generate the compatible according
>>>>>> to the current bindings. Whether we can change it I am not sure. I think
>>>>>> it depends how much customization is possible per vendor, according to
>>>>>> JEDEC spec. If we never ever have to identify specific part, because
>>>>>> JEDEC spec and registers tell us everything, then we could skip it,
>>>>>> similarly to lpddr2 and jedec,spi-nor.
>>>>>
>>>>> Shouldn't that be decided per use case? In general LPDDR is a pretty
>>>>> rigid set of standards and memory controllers are generally compatible
>>>>> with any vendor without hardcoding vendor-specific behavior, so I
>>>>> don't anticipate that this would be likely (particularly since there
>>>>> is no "real" kernel device driver that needs to initialize the full
>>>>> memory controller, after all, these bindings are mostly
>>>>> informational).
>>>>
>>>> If decided per use case understood as "decided depending how to use the
>>>> bindings" then answer is rather not. For example Linux implementation is
>>>> usually not the best argument to shape the bindings and usually to such
>>>> arguments answer is: "implementation does not matter".
>>>>
>>>> If by "use case" you mean actual hardware or specification
>>>> characteristics, then yes, of course. This is why I wrote "it depends".
>>>
>>> By "use case" I mean our particular platform and firmware requirements
>>> -- or rather, the realities of building devices with widely
>>> multi-sourced LPDDR parts. One cannot efficiently build firmware that
>>> can pass an exact vendor-and-part-specific compatible string to Linux
>>> for this binding for every single LPDDR part used on such a platform.
>>
>> Why cannot? You want to pass them as numerical values which directly map
>> to vendor ID and some part, don't they?
> 
> If you really want this to be in the "compatible" string, maybe the
> right answer is to follow the lead of USB which encodes the VID/PID in
> the compatible string
> (Documentation/devicetree/bindings/usb/usb-device.yaml). It's solving
> this exact same problem of avoiding needing a table translating from
> an ID provided by a probable device to an human-readable string.

This makes sense. I would still argue that number of vendors is small
thus strings could be translated (there is like 20 of them in JEP166D -
JC-42.6), but for device ID this would work.

> 
> 
>>> And I don't see why that should be needed, either... that's kinda the
>>> point of having an interoperability standard, after all, that you can
>>> just assume the devices all work according to the same spec and don't
>>> need to hardcode details about each specific instance.
>>
>> If we talk about standard, then DT purpose is not for autodetectable
>> pieces. These values are autodetectable, so such properties should not
>> be encoded in DT.
> 
> In the case of DDR, I think that the firmware can auto-detect them but
> not the kernel. So from the kernel's point of view the DDR info should
> be in DT, right?

True, I thought memory controllers could provide such information, but
now I checked Exynos5422 DMC and it does not expose such register.


Best regards,
Krzysztof
