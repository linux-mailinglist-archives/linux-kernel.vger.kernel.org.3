Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8558225D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiG0IrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG0IrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:47:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C521E32
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:47:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d17so24048478lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fyGOJcha6A03fDOSCS5Vm0hs+e/084WU5S+ZEPMoTD8=;
        b=IRLK9Gd62p9a4QhD9fY7mPV7KWVyxmh6O1i3LYD8FjRj9hmd96kjJwe67bxn0LDMye
         S4c7pn4OU6Pjc2oSDLBppujq1NMK9in2FhfTOIJmf+zJfPr7HmF7+AUppbFcY6uMpvIP
         sZixf3NEmMZ6Txt2Wv3l3+v6kGKIxWo1BoNtePi/fuQdvsE0q4Xv1xJZ+ADIepPWv543
         Z1eSd5JE03rob8WvqtkzKqpIo5q1DJvKENvMDswzuFXziGMOfjrgbL/me1M0+68IL6x1
         VehDMwdEVq1UKVdPfYY1oQho/ZrNGwHVUrxXK9CzPj8lfZzCMpQEdFavOyztNWBTQBpQ
         6X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fyGOJcha6A03fDOSCS5Vm0hs+e/084WU5S+ZEPMoTD8=;
        b=6ifokiEpvFKlACNbaSOjxz0rqGqiYnQE9HrHgK47+0voP9K3mzZJGJi7z9R3NzUtVz
         01Ub5L1irapQNYc6V0/hxosgWjTKc6TssMKnqnQgGbQipnVbNp5HmF4vnLoUoZNNxxGf
         v5ebPvjIHtOz3Dki0CvO2c57McHaSvZ1A3Wf4UngK8ipCxq8Ogn8ZvKH9GVkY30+C93w
         dJI9YeTO4r9NfKldQ2c5GEbVc0xhq2OKbnmtVfRjYkf1EyBeOmfos28MjZ8Jug/f71nA
         2hdfnQLa1aEQjF/6M46RcJOC2waTGuOe/K+BIo5/hcqF2xm+1KctOr8vsBm8ifbYW1u4
         Pfvg==
X-Gm-Message-State: AJIora9HC+ZMeobPOiMON7l1WfkBXCZeceTsZ57TIm3FnE3AYwTJBFem
        R4Iyqvu1kWvmF0V0Z5xIqDbRjg==
X-Google-Smtp-Source: AGRyM1tyCDT4MpDc7m56vBI2mON64hEj1M5dlPsDL7ffpOzQeOBHpEGgLBQi3qbvbSPkWSYt+PFqSg==
X-Received: by 2002:a05:6512:3f0a:b0:480:2556:b7a3 with SMTP id y10-20020a0565123f0a00b004802556b7a3mr7492456lfa.306.1658911632616;
        Wed, 27 Jul 2022 01:47:12 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id t28-20020a2e8e7c000000b0025d4d9be72csm3758297ljk.3.2022.07.27.01.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 01:47:12 -0700 (PDT)
Message-ID: <86b9c6d6-e8e5-7f6d-0970-460baf9b6fcc@linaro.org>
Date:   Wed, 27 Jul 2022 10:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW-GDkfyFaNSnEngpSfz8LSXRetu+xwp3QrFHP1rH1O06w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 01:42, Julius Werner wrote:
> Sorry, got distracted from this for a bit. Sounds like we were pretty
> much on the same page about how the updated binding should look like
> here, the remaining question was just about the compatible string.
> 
>>>> Yes, we can. You still would need to generate the compatible according
>>>> to the current bindings. Whether we can change it I am not sure. I think
>>>> it depends how much customization is possible per vendor, according to
>>>> JEDEC spec. If we never ever have to identify specific part, because
>>>> JEDEC spec and registers tell us everything, then we could skip it,
>>>> similarly to lpddr2 and jedec,spi-nor.
>>>
>>> Shouldn't that be decided per use case? In general LPDDR is a pretty
>>> rigid set of standards and memory controllers are generally compatible
>>> with any vendor without hardcoding vendor-specific behavior, so I
>>> don't anticipate that this would be likely (particularly since there
>>> is no "real" kernel device driver that needs to initialize the full
>>> memory controller, after all, these bindings are mostly
>>> informational).
>>
>> If decided per use case understood as "decided depending how to use the
>> bindings" then answer is rather not. For example Linux implementation is
>> usually not the best argument to shape the bindings and usually to such
>> arguments answer is: "implementation does not matter".
>>
>> If by "use case" you mean actual hardware or specification
>> characteristics, then yes, of course. This is why I wrote "it depends".
> 
> By "use case" I mean our particular platform and firmware requirements
> -- or rather, the realities of building devices with widely
> multi-sourced LPDDR parts. One cannot efficiently build firmware that
> can pass an exact vendor-and-part-specific compatible string to Linux
> for this binding for every single LPDDR part used on such a platform.

Why cannot? You want to pass them as numerical values which directly map
to vendor ID and some part, don't they?

> And I don't see why that should be needed, either... that's kinda the
> point of having an interoperability standard, after all, that you can
> just assume the devices all work according to the same spec and don't
> need to hardcode details about each specific instance.

If we talk about standard, then DT purpose is not for autodetectable
pieces. These values are autodetectable, so such properties should not
be encoded in DT.

> 
> The existing bindings seem to have clearly been designed for platforms
> that only ever use a single specific LPDDR part, and in those cases
> these issues don't come up, so I assume this choice had just been made
> without much thought. 

True.

> But now I would like to reuse them on platforms
> where this is a problem, and that's why I would like to either expand
> or change the binding to (also) allow a generic compatible string to
> solve it. (Whether that means moving all platforms to only use this
> generic compatible string, or allowing it side-by-side with the
> existing part-specific compatible strings is up to you -- I don't want
> to preclude other platforms from doing what they prefer, I just want
> to make sure there's some form of workable solution for my platform.
> But if you would prefer this to be an all-or-nothing thing, we could
> change everything over to a generic compatible string too if you
> want.)
> 
>>> Of course there may always be mistakes and broken
>>> devices that need custom handling, and if someone has a platform with
>>> such a case I of course don't want to preclude them from tying special
>>> behavior to a custom compatible string. But why would that mean we
>>> need to make this mandatory for all platforms even if it's not
>>> relevant (and not practically feasible) for them? Why not allow both?
>>
>> Depends. If generic compatible is not enough (works only for your case)
>> then it should have never been added alone.
> 
> No, I don't think it would work only for my case -- in fact I think
> it's pretty unlikely that we'll ever find a case where this doesn't
> work. LPDDR is a very rigid standard that generally needs to be able
> to interoperate (at the memory controller and firmware training code
> level) without any vendor-specific software quirks. I was just trying
> to say that I wouldn't want to stop anybody from adding
> vendor-specific quirks for a platform if they really needed to -- but
> I don't know of any such case in practice and I doubt it actually
> exists. The few existing uses of this binding don't use the compatible
> string for anything more than to parse out the manufacturer ID, which
> I think would make much more sense to model as a property.


Best regards,
Krzysztof
