Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DC058207B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiG0GwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiG0Gvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:51:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20347F5E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:51:15 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m9so18731717ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aJUcWFFmWH0ACuT+DEaxkfE7LttZ2cDcW0MPuo+aX+s=;
        b=vtx7QZ7D3Fz/UFYvObJYc0p4k7igsEZqawJNaTCN9XLR0p2eXTc+WIMlOoklwoTvVg
         +QLAzNztvGzIkJqCovfYla9H+MiEhwjj9TDqG0s6Qqd0aXmLCTUdzoviFSPZPS9rq3R5
         uUcqItXA0SmeaFAn1fWctXsDsM1nEVL1UdJuHBRUrFcZnrJ6gHOilwMN6guglZL5610v
         /vX6PUe/gnAMkcr6aZ6Hf4t2/JYgoUvY3hL240dIqbwhPvDo+M8/IyVsFJ6L3oZGzTfB
         dgqF8MvxA7kwGoiHvO6l4MUBuaevuECVhPUkEGtzp3iXH1d8BsdLYv3R5DRnTz8DTQYw
         lubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aJUcWFFmWH0ACuT+DEaxkfE7LttZ2cDcW0MPuo+aX+s=;
        b=RqfczIQNahruTPl5UOGj/OCM7aqPIQEHOdVQdjqxvOyHuCiowx4PdybMQIf2YMF8TJ
         /RdCOHurY1a/B/RJuiBs4HwgyudXRIBUTOqQVP8r22iNROkJcgCK0bYlUqCPMl9orQFM
         RCG1Cic6O2JdENDLDoJWji/Srq69JZT7qp3ynFqRbbhb6EpKJmV1SgkkR44GQvnWIqR/
         EEvkY5RkdEo8G8JeGNESadkXf+VvdeQ9rfm22UMD/iY4QZ1lmYPYlwCk0LkDMSN2yI3n
         HbxU+1xPAnH2g+fE6N+0OEeJwhACpbUcgNVE3/6goLdOVikZzxVgPAF6kKMh+AcJrPKk
         7uHg==
X-Gm-Message-State: AJIora8iXZ3aRZTyV1SsQfp2QDIiRmkAEO8B7nQENKaLtmuQtfvveBpW
        BMsJhwBmnwVQMEv7estZW/6kJw==
X-Google-Smtp-Source: AGRyM1ueak/90bYUNOSpELSH8le2EAc2zF3399bwDPGwAEYllYwk9el8QSzhFMo2e77a56LQfDbCAw==
X-Received: by 2002:a2e:98d5:0:b0:25e:c1b:f262 with SMTP id s21-20020a2e98d5000000b0025e0c1bf262mr3590812ljj.343.1658904673405;
        Tue, 26 Jul 2022 23:51:13 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id h7-20020a19ca47000000b0048aa00a03fesm808662lfj.215.2022.07.26.23.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 23:51:12 -0700 (PDT)
Message-ID: <8463a831-f263-31b2-6cd7-482ae9594bc1@linaro.org>
Date:   Wed, 27 Jul 2022 08:51:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] spi: npcm-pspi: Add NPCM845 peripheral SPI support
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220722114136.251415-1-tmaimon77@gmail.com>
 <20220722114136.251415-3-tmaimon77@gmail.com>
 <afae04e0-76a3-1bcb-5b47-9944fa9ab2c0@linaro.org>
 <YtrvyyMGm64hFG5j@sirena.org.uk>
 <0c8688d5-b0c1-8cc1-ec27-292acbb38dfc@linaro.org>
 <YtrzF9BFJrXfxiz0@sirena.org.uk>
 <CAP6Zq1iRowFv4qg=AqdVmBRRx5p4-5AaC1G-aZs=2LnOAOELXA@mail.gmail.com>
 <20869b88-41f3-9e9c-347e-17c3d01baa5d@linaro.org>
 <CAP6Zq1iHCL9Krjw-wYKrG1K_yzwj-_qNROYxhogvkDjk+gCL-g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1iHCL9Krjw-wYKrG1K_yzwj-_qNROYxhogvkDjk+gCL-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 21:32, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Thanks for your explanation.
> 
> On Tue, 26 Jul 2022 at 12:47, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 24/07/2022 10:44, Tomer Maimon wrote:
>>> Hi Mark and Krzysztof,
>>>
>>> Thanks for your reply,
>>>
>>> On Fri, 22 Jul 2022 at 21:57, Mark Brown <broonie@kernel.org> wrote:
>>>>
>>>> On Fri, Jul 22, 2022 at 08:47:24PM +0200, Krzysztof Kozlowski wrote:
>>>>> On 22/07/2022 20:43, Mark Brown wrote:
>>>>
>>>>>> ...with a fallback list required by the bindings so the driver actually
>>>>>> binds.  Note that bindings are currently not in YAML format so there'd
>>>>>> be even less enforcement of that than normal, and as they're currently
>>>>>> written the bindings don't require fallback.
>>>>
>>>>> Yes, the bindings document should be rephrased but we were living like
>>>>> that for few years. :)
>>>>
>>>> The binding document as it stands only has one compatible, there's no
>>>> existing problem with it other than the YAML conversion.  If we're
>>>> adding something new that requires a fallback we should be explicit
>>>> about that rather than have something that's actively misleading where
>>>> previously things were clear.  I don't mind if we add the compatible to
>>>> the driver or document the requirement for the fallback but we should do
>>>> one of the two.
>>>
>>> is V2 good enough? adding the compatible to the driver and the document?
>>> Or should we use fallback?
>>> If fallback is choosen, can you explain how I should do it?
>>
>> I propose to use fallback. The preferred way is to convert it to DT
>> schema and then add new device support (so two commits). Other
>> acceptable way is to rephrase the TXT so it clearly states desired
>> compatibles - one for old device, two for new devices. There are plenty
>> of examples in current sources.
> Appreciate if you could clarify.
> in case we use DT-schema, we dont describe the fallback like we doing
> in txt document?
> I mean that in the yaml file we should describe the NPCM PSPI
> compatible property as follow:
>   compatible:
>     enum:
>       - nuvoton,npcm750-pspi
>       - nuvoton,npcm845-pspi
> 
> If yes, how should the user know that he needs to use fallback incase
> is using nuvoton,npcm845-pspi? only from the device tree?
>

If you use DT schema format, you must code it as with fallback (so
items). This is the most popular setup for SoC components so you will
easily find such examples.


Best regards,
Krzysztof
