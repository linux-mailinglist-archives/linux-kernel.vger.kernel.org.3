Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F564C6F97
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiB1Ofx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiB1Ofu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:35:50 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4235286D4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:35:10 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7F3B73FCAA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646058908;
        bh=cY+2Lb+cjTat47mxYF3hRVRAsG+Ud2T/F9b9vhwTP8I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=CRLWRQG2wUSOhIzOqopBQtdBkShhexYkXZeOYW8mdiGu3gY0AWcZfNQ1bbrCs6agD
         yqcW2yzfUHXeDz8aQ2MctUOKkTSqoXUZy58jvSn4LWFf9UwUN2xTaEFxGrjzTpLMsl
         IPJ7aEt3nJqMrFFkn/b9rCxECZmzS2DrVzNZDm8u3vWn14aV8HXj67BQBAA8r9L1v1
         2RjBabTc9uxubAJQ8hdSMgRGc7QoHh/glauuW2RqPt9i8Q6r2E+sqGfiH5M593uLDq
         Yaq8Uyi4JDn2bp7eTgASK2iK3eZanIBC552i87QscKj6eFExrI+B6jxXhx5tPpLlvD
         Fbcew4P5qGMbA==
Received: by mail-ed1-f71.google.com with SMTP id j9-20020a056402238900b004128085d906so5909023eda.19
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cY+2Lb+cjTat47mxYF3hRVRAsG+Ud2T/F9b9vhwTP8I=;
        b=cV+JagNKoDeUR2mlmUYU3x+gnM3PeirB0V4n1ClXVLUFiSxeQQWiIyeGfnhMx1HjmP
         GnYCKjzIjJ+0tVyt7DQUOwuI67zn1VNVf0tygX0AfBxe+GS6LKsoIHAstZ4MaV/YBdli
         wzl6Yt4W+gzCX8k5sJEwvl83NWgVxZFwTyyNNyC7lbrMf1w7c53PP0msMx8gXhU2/6F2
         A0cxkl0yzhcX8mFvXN8sjhtpG2Pvzm77PIPLRDtCBN1mVOPN8pv91x+ljMej+iNsaW3A
         zXbKWV5Z8PmJ0DuulgEfQCoAUXG8sjl+ywyEGJIkOpa/SjQBr4bhF6LoniQ1Q79ekFHy
         rz3g==
X-Gm-Message-State: AOAM532sltOQnDfR2Nd0c1bPriBmW/u4Wxo4oKm4E41vvxMNuu2J/1bL
        dxKYz4wPJW1zxEEniv0CULBMEIvBTf3O8KRPUuJNdn2hky9uMAYG4mYqqfsfqwkOwix6UUgtqEW
        6MNkx+d2wMIhuKVuUga2LzdyTXpg1/mW1yIOVqNu0FA==
X-Received: by 2002:a05:6402:50d4:b0:413:2a27:6b56 with SMTP id h20-20020a05640250d400b004132a276b56mr20130479edb.228.1646058905399;
        Mon, 28 Feb 2022 06:35:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDY8R2MrubTXi50w56pdwC6DtPAk6AD2Vm2bz+yDKpsTw4K5OhCQsji/CEA8QLue8RhCTBgw==
X-Received: by 2002:a05:6402:50d4:b0:413:2a27:6b56 with SMTP id h20-20020a05640250d400b004132a276b56mr20130333edb.228.1646058903378;
        Mon, 28 Feb 2022 06:35:03 -0800 (PST)
Received: from [192.168.0.135] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm4416053ejk.119.2022.02.28.06.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:35:02 -0800 (PST)
Message-ID: <ddd09f4f-782f-67e9-ec2f-dd5818ae26c5@canonical.com>
Date:   Mon, 28 Feb 2022 15:35:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: Re: [PATCH v3 1/3] dt-bindings: Convert ahci-platform DT
 bindings to yaml
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220227182800.275572-1-linux@fw-web.de>
 <20220227182800.275572-2-linux@fw-web.de>
 <4c3303f5-7af5-9974-7bea-b7f0d6c7ef53@canonical.com>
 <trinity-ac45bde6-392d-4810-8aad-9a06d2bcd85a-1646050780475@3c-app-gmx-bs53>
 <8fbbce9e-4fd9-d420-43ef-953e846d29f1@canonical.com>
 <trinity-f1b6ce3a-6f22-4cf8-bf51-a5e7f007dda7-1646057347735@3c-app-gmx-bs53>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-f1b6ce3a-6f22-4cf8-bf51-a5e7f007dda7-1646057347735@3c-app-gmx-bs53>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 15:09, Frank Wunderlich wrote:
> Hi,
> 
> looks like i'm not the right person to convert the binding. I have not enough knowledge about yaml, bindings, drivers, ...
> 
> i will try you suggestions for me as a lerning-by-doing approach, but will drop it from the series, same for part2 as it depends on first.
> 
> 
> 
>> Gesendet: Montag, 28. Februar 2022 um 13:38 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
> 
>> On 28/02/2022 13:19, Frank Wunderlich wrote:
> 
>>>> You converted the TXT bindings explicitly, but you missed the comment
>>>> just below the 'reg' about generic-ahci. The generic-ahci never comes alone.
>>>
>>> How should this comment be added? description above/below the compatible-property?
>>> Sorry for dumb questions...this is my first yaml ;)
>>
>> No, this has to be oneOf. See for example
>> Documentation/devicetree/bindings/gpio/gpio-vf610.yaml or many other files.
> 
> Afaik the generic-ahci should be defined optional with one of the others needed, but afaik this will duplicate the list i had.
> 
> so i end up in a struct like this
> 
> compatible:
>   oneOf:
>     - enum:
>       - brcm,iproc-ahci
>       - cavium,octeon-7130-ahci
>       - hisilicon,hisi-ahci
>       - ibm,476gtr-ahci
>       - marvell,armada-3700-ahci
>       - marvell,armada-380-ahci
>       - snps,dwc-ahci
>       - snps,spear-ahci
>     - items:
>       - const: generic-ahci
>       - enum:
>         - brcm,iproc-ahci
>         - cavium,octeon-7130-ahci
>         - hisilicon,hisi-ahci
>         - ibm,476gtr-ahci
>         - marvell,armada-3700-ahci
>         - marvell,armada-380-ahci
>         - snps,dwc-ahci
>         - snps,spear-ahci

That could be one way, but instead I propose to have only second part
(so enum + generic-ahci) for all compatibles mentioned in
ahci_platform.c, which do not customize the driver behavior for these
compatibles..


> 
> 
>>>>> + interrupts:
>>>>> + minItems: 1
>>>>
>>>> You mean maxItems?
>>>
>>> no, minItems, as interrupts suggests 1+ (same for phys)
>>
>> You cannot have infinite number of interrupts... What suggests "1+"?
>> What does it mean "as interrupts suggests"? Do these hardware blocks
>> really have many interrupt lines?
>>
>> The same for phys.
> 
> interrupts/phys is plural of interrupt/phy, so it suggests it can be more than 1.

There is no property named "interrupt" or "phy". There is only
"interrupts", "phys", "gpios", "clocks" etc. regardless whether there is
one or multiple items. This is not specific to bindings, but all DTS
have this.

> 
> as i said i do not know every driver with all possibilities, so i started with the min-items as we need at least 1 interrupt/phy, but yes if there are any limits then they should be added, but this needs extensive knowledge about the drivers/hardware, i don't have.

But the sources of the driver and DTS are available, why not using them?

> 
>>>>> + ports-implemented:
>>>>> + description:
>>>>> + Mask that indicates which ports that the HBA supports
>>>>> + are available for software to use. Useful if PORTS_IMPL
>>>>> + is not programmed by the BIOS, which is true with
>>>>> + some embedded SoCs.
>>>>> + minItems: 1
>>>>
>>>> You need a type and maxItems.
>>>
>>> what will be the type of a mask?
>>
>> `git grep ports-implemented` gives pretty straightfoward answer. All DTS
>> have u32 and driver also uses u32.
> 
> so type should be
> 
> $ref: '/schemas/types.yaml#/definitions/uint32'

Yes. See example schema.

> 
> ?
> 
> it's the only one i've found with u32 looking like a type
> 
> found in Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml

This part I do not understand.

> 
>>>
>>>>> +
>>>>> + resets:
>>>>> + minItems: 1
>>>>
>>>> maxItems?
>>>
>>> if there is a known maximum....
>>
>> Must be. You cannot have infinite number of reset lines... Please check
>> all DTS and drivers. If there is public documentation, it also might be
>> useful.
> 
> "Please check all DTS and drivers." this is impossible for me as doing this as hobby with still limited time ;(

I believe that information - how many resets - is in general findable
via driver sources. In all bindings conversions, if we do not have such
information, we need to try to look it up.

>>>
>>>>> +
>>>>> + target-supply:
>>>>> + description:
>>>>> + regulator for SATA target power
>>>>> +
>>>>> +required:
>>>>> + - compatible
>>>>> + - reg
>>>>> + - interrupts
>>>>> +
>>>>> +patternProperties:
>>>>> + "^sata-port@[0-9]+$":
>>>>
>>>> You limit number of ports to 10. On purpose? What about 0xa? 0xb?
>>>
>>> oh, right, there can be hexadecimal...
>>> thought this is only true for the main-node (address) and have only seen @0, @1 and @2
>>>
>>>>> + type: object
>>>>> + description:
>>>>> + Subnode with configuration of the Ports.
>>>>> +
>>>>> + properties:
>>>>> + reg:
>>>>> + maxItems: 1
>>>>> +
>>>>> + phys:
>>>>> + minItems: 1
>>>>
>>>> maxItems? Why do you put everywhere minItems? Are several phys really
>>>> expected?
>>>
>>> name suggests that it can be more than 1.
>>
>> What do you mean "name suggests"? Name of property? No, it does not
>> suggest that. Name is standard. Please check example schema and other
>> existing schema bindings to see how it is done. For example earlier
>> gpio-vf610.yaml is not bad.
> 
>>> i know from usb subsystem (dwc3 usb3) that a device can have more than one phy, and because in the txt there are no ranges i set everywhere MinItems to 1 with open end as i do not know all possibilities. Anything else will be trial and error...for all properties
>>
>> The bindings need to be specific, so only properties which really,
>> really can have many unknown elements we could keep here some high
>> maxItems limit. In 99% of cases maxItems are clearly defined.
> 
> so i need to do try-and-error, setting maxItems to 1, make checks, if failing look in driver, increase, ...

Why try-and-error? "git grep" works here...

> 
> but this is maybe not the right way to do as dts can contain errors which should not modify the binding.

True, but having stricter limit, even if not fully correct, is better
than having too loose limit. Stricter can be always loosened. Loose
requirement cannot be made stricter.

> 
>>> these are the commands i used:
>>>
>>> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>
>> Install dependencies (libyaml-dev) and you will see first error:
>> Documentation/devicetree/bindings/ata/ahci-platform.yaml:110:1:
>> [warning] wrong indentation: expected 2 but found 0 (indentation)
>>
>> But the one I am thinking is indeed not visible by default. You would
>> need to run it like Rob's boot is running, so add DT_CHECKER_FLAGS=-m.
>> Then you see:
>>
>> Documentation/devicetree/bindings/ata/ahci-platform.example.dt.yaml:0:0:
>> /example-1/sata@f7e90000: failed to match any schema with compatible:
>> ['marvell,berlin2q-achi', 'generic-ahci']
> 
> i try this, but imho it's better to drop the Patch as i'm no expert in this, don't know the HW/drivers enough and this will delay the dts patch too much.
> I thought i can help getting this (simple looking) txt converted to yaml.
> Seems the binding needs to be done by someone who knows the drivers more than me.
> 
> regards Frank


Best regards,
Krzysztof
