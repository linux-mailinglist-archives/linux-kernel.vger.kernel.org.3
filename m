Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5822595A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiHPLly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiHPLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:41:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB88BCC3B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:11:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z6so14434281lfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0cuU1bG6KFLMr6an740FWMa8MPaqg8PFLx685pJUkOY=;
        b=GYEkY3kBMOdN21wTqQAEDOg88pgX6jp9BtCRiEAUPFEC6zLl70PjISb/WBZMzz3c/E
         azAJ/UWONLB1jmDNlv9VZH2FA77IyeUK8jMU51+I/lXnmBeUB6KNCTR94t1sG0NrS9vt
         UnWaYBYdbffWDhISjUJXAUDWBwzwYGfsDdS/xntKp6At257goXRAUH5oiRfXMgJg5aFQ
         6tS7afCAa6zoTnvIK4rB3RePeJNCayOSIY6uaJ0DqtXTt5vVGG0GC7gO5ngutEGaZMca
         6W5ZMF8oiVXgcqcq9d4QDxrta+c6D//Ffad0mHN5wG4u8vy2kG54TuUk19KN2RewMM6+
         CzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0cuU1bG6KFLMr6an740FWMa8MPaqg8PFLx685pJUkOY=;
        b=jIRirJAlryZjHc+quK8EtJniTGjN/GqWGJ0rDQyY/hZg+8Jf5iyQy5+TwEYcViqvTw
         n0LxLzebyBCIIdcalKw6/JmaNRsgiFEMLks5e0gNYzGFxoHbuPlaQS1+VOk9z0Cb9HO+
         fBEmF0iBi7d0sGIvZeQJ6VPw027ArrSaTVCVxdC1yO8KWgKVB/sT98NLe9ME906KEqSS
         rtOsYSl3yfUYBqaje66+qUDuuxP1pvJZOAB1HOxXOQRizeElaf33NTiHyZ5MIIdHWH1z
         /vlV9np6w6t7aUoBjxpocn8aDH2xp+TwVM1CRuYqUFQdsqMSOdlGgxBmNXnRioO2lyId
         Alkg==
X-Gm-Message-State: ACgBeo0FFWYGYR4MAraBbScxlVerLmzPVwkOJnY721vGJ3NDgfwdFEBq
        fK9iWmZn9vvC8njtnHg4J4xXaA==
X-Google-Smtp-Source: AA6agR4jvAh3L22ickhZa14uDRFbhGMs9hDFABhJBvwWXmWM/n4NtsL5IflGqzOc8MYp3IFiSXYs5A==
X-Received: by 2002:ac2:47f1:0:b0:48a:ea6e:b8fd with SMTP id b17-20020ac247f1000000b0048aea6eb8fdmr6589451lfp.26.1660648282335;
        Tue, 16 Aug 2022 04:11:22 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id u17-20020a056512041100b0047f7419de4asm1354065lfk.180.2022.08.16.04.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 04:11:21 -0700 (PDT)
Message-ID: <29072f12-b9a3-9815-ad52-5c4f6b1634b3@linaro.org>
Date:   Tue, 16 Aug 2022 14:11:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220815050815.22340-1-samuel@sholland.org>
 <5593349.DvuYhMxLoT@jernej-laptop> <3881930.ZaRXLXkqSa@diego>
 <2249129.ElGaqSPkdT@jernej-laptop>
 <b5401052-e803-9788-64d6-82b2737533ce@linaro.org>
 <20220816120050.07dc2416@donnerap.cambridge.arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816120050.07dc2416@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 14:00, Andre Przywara wrote:
> On Tue, 16 Aug 2022 12:42:39 +0300
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> Hi,
> 
>> On 16/08/2022 12:25, Jernej Škrabec wrote:
>>> Dne torek, 16. avgust 2022 ob 11:12:05 CEST je Heiko Stübner napisal(a):  
>>>> Am Dienstag, 16. August 2022, 09:49:58 CEST schrieb Jernej Škrabec:  
>>>>> Dne torek, 16. avgust 2022 ob 09:41:45 CEST je Krzysztof Kozlowski   
>>> napisal(a):  
>>>>>> On 15/08/2022 08:08, Samuel Holland wrote:  
>>>>>>> +
>>>>>>> +	de: display-engine {
>>>>>>> +		compatible = "allwinner,sun20i-d1-display-engine";
>>>>>>> +		allwinner,pipelines = <&mixer0>, <&mixer1>;
>>>>>>> +		status = "disabled";
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	osc24M: osc24M-clk {  
>>>>>>
>>>>>> lowercase
>>>>>>  
>>>>>>> +		compatible = "fixed-clock";
>>>>>>> +		clock-frequency = <24000000>;  
>>>>>>
>>>>>> This is a property of the board, not SoC.  
>>>>>
>>>>> SoC needs 24 MHz oscillator for correct operation, so each and every board
>>>>> has it. Having it here simplifies board DT files.  
>>>>
>>>> I guess the oscillator is a separate component on each board, right?  
>>>
>>> Correct.
>>>   
>>>> And DT obvious is meant to describe the hardware - independently from
>>>> implementation-specific choices.  
>>>
>>> There is no choice in this case. 24 MHz crystal has to be present.
>>>
>>> FWIW, including crystal node in SoC specific DTSI is already common pattern in 
>>> Allwinner ARM SoC DTSI files.
>>>   
>>>>
>>>> Starting to discuss which exceptions to allow then might lead to even more
>>>> exceptions.
>>>>
>>>> Also having to look for a board-component in the soc dtsi also is surprising
>>>> if one gets to the party later on :-) .  
>>>
>>> As I said, if one is accustomed to Allwinner ARM DT development, it would be 
>>> more surprising to include 24 MHz crystal node in each and every board DT.  
>>
>> It's same everywhere. Allwinner, Exynos, iMX, Qualcomm. Everywhere this
>> is a part of the board, so even if oscillator frequency is fixed (as in
>> 99% of cases although some SoCs I think might just allow to implement
>> one of few), still this is a property of the board. Because:
>> 1. DTSI describes the SoC part, not board.
>> 2. So the DTS developer is a bit more conscious about his design.
> 
> 1) is certainly true, but indeed most platforms put the base
> crystal oscillator in the SoC .dtsi:

Yes. And once per week when I look at new DTS I need to repeat the same
arguments. :)

> I just sampled Rockchip (rk3399.dtsi,
> rk356x.dtsi, rk3328.dtsi), Amlogic (meson-g12-common.dtsi), ActionSemi (s[79]00.dtsi),
> Qualcomm (msm8916.dtsi, sm8450.dtsi, sc7180.dtsi), Freescale (imx8mm.dtsi,
> imx8qxp.dtsi), Realtek (rtd129x.dtsi), Broadcom (bcm283x.dtsi), Mediatek
> (mt8183.dtsi, mt8516.dtsi). The list probably goes on (I just stopped
> here).
> 
> I think one reason might be that this is so central to the whole SoC
> operation, that it's already referenced multiple times in the base .dtsi.
> And having a yet unresolved reference in the .dtsi looks dodgy.
> 
> NVidia seems to omit a base oscillator (maybe it's implicit in their
> binding design), Marvell doesn't use a fixed-clock (but still puts their
> base clock in armada-37xx.dtsi).
> 
> Exynos and Renesas put a *stub* fixed-clock in the .dtsi, and set the
> frequency in the board .dts files. Would this be a compromise?

This is exactly what I said before. The clock frequency is a property of
the board. Feel free to keep the rest of the clock in the SoC DTSI to
reduce duplication, but at minimum the clock should go to the board.

Best regards,
Krzysztof
