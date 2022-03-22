Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795BA4E3AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiCVIoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiCVIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:44:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E919413CF6;
        Tue, 22 Mar 2022 01:42:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 648181F43DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647938552;
        bh=ZNH440yknkDh/m/M5zf1aXWnLlpXC6fg0XWbHBtoN7M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EeM1uYKCpBYjXvUDyOx6y+vxbXAaJzLk3Ge26/1Xy2eJCOadADsvRuo+jPUVoEE5v
         igb7eq2Oduhale4IAuQUCnGb+Ejf4u1MJviwCMkjuKHu9VEfMMaHni45sLbQ3xTM7O
         Duw29OL3LMKr/mdC6t6yjGGaJbaiACBaGwBpOiTKGQ3kM7AKWw/7Z46wtrkRxMa9ld
         uQgJKW3XvSVzB5FznnLyn3mQFzltxOyymH3s8st6eR6W+G9mWxunJcKO/GTfBFI8hV
         LEuMbAXpELgraVmQxSK/he0kT6rFfKF/OIyGjQZOULwwAF8t+OAvCCjeB+hBR2CsvQ
         vcKOEppgZpCjA==
Message-ID: <5d9c7655-b05e-aa77-d405-c1ec971daa77@collabora.com>
Date:   Tue, 22 Mar 2022 09:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v8 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Content-Language: en-US
To:     Axe Yang <axe.yang@mediatek.com>, Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220321115133.32121-1-axe.yang@mediatek.com>
 <20220321115133.32121-2-axe.yang@mediatek.com>
 <YjkKURNzg8JPbXcg@robh.at.kernel.org>
 <b03df175f871ee9a6561862f5bd7bceb9cafbde1.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b03df175f871ee9a6561862f5bd7bceb9cafbde1.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/03/22 02:35, Axe Yang ha scritto:
> On Mon, 2022-03-21 at 18:29 -0500, Rob Herring wrote:
>> On Mon, Mar 21, 2022 at 07:51:32PM +0800, Axe Yang wrote:
>>> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
>>> This feature allow SDIO devices alarm asynchronous interrupt to
>>> host
>>> even when host stop providing clock to SDIO card. An extra wakeup
>>> interrupt and pinctrl states for SDIO DAT1 pin state switching are
>>> required in this scenario.
>>>
>>> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
>>> ---
>>>   .../devicetree/bindings/mmc/mtk-sd.yaml       | 23
>>> ++++++++++++++++++-
>>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> index 297ada03e3de..f57774535a1d 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> @@ -69,12 +69,23 @@ properties:
>>>         - const: ahb_cg
>>>   
>>>     interrupts:
>>> -    maxItems: 1
>>> +    description:
>>> +      Should at least contain MSDC GIC interrupt. To support SDIO
>>> in-band wakeup, an extended
>>> +      interrupt is required and be configured as wakeup source
>>> irq.
>>> +    minItems: 1
>>> +    maxItems: 2
>>>   
>>>     pinctrl-names:
>>> +    description:
>>> +      Should at least contain default and state_uhs. To support
>>> SDIO in-band wakeup, dat1 pin
>>> +      will be switched between GPIO mode and SDIO DAT1 mode,
>>> state_eint and state_dat1 are
>>> +      mandatory in this scenarios.
>>> +    minItems: 2
>>>       items:
>>>         - const: default
>>>         - const: state_uhs
>>> +      - const: state_eint
>>> +      - const: state_dat1
>>>   
>>>     pinctrl-0:
>>>       description:
>>> @@ -86,6 +97,16 @@ properties:
>>>         should contain uhs mode pin ctrl.
>>>       maxItems: 1
>>>   
>>> +  pinctrl-2:
>>> +    description:
>>> +      should switch dat1 pin to GPIO mode.
>>> +    maxItems: 1
>>> +
>>> +  pinctrl-3:
>>> +    description:
>>> +      should switch SDIO dat1 pin from GPIO mode back to SDIO
>>> mode.
>>
>> How is this different than pinctrl-0?
> 
> pinctrl-0 contains default settings for all IO pins(CLK/CMD/DAT).
> pinctrl-1 contains settings for all IO pins(CLK/CMD/DAT) in UHS mode.
> pinctrl-3 is lightweight pinctrl-1, only keep SDIO DAT1 pin function
> switch part.
> 

Is there any particular reason why we cannot simply select pinctrl-1 again
instead of pinctrl-3, apart from the virtually not existent overhead of
one more mmio write?

> ...
> 
> Regards,
> Axe
> 

