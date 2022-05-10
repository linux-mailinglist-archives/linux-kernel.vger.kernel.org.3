Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3EC520EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiEJHr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbiEJHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:46:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13328AAE01;
        Tue, 10 May 2022 00:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F2CDB80A05;
        Tue, 10 May 2022 07:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995FEC385C9;
        Tue, 10 May 2022 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652168479;
        bh=hcJ/0scfAlen/Lzqbi68DI9xyiOaM670xSaP++6Hm9M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QIhApCdmXcD3OYldzlmFltueG21PlDuu4WSfn+JqN8hgTnzg8nC8G89L5BR2e52tX
         WgpiHm/Cm3X8tybiQTeAjXWUJb71ttlb3OmxhJX8EqQcc4P8XFfHCz8wy7tBgI8FLS
         P6BQIgbeMnvhNyKlo7Xn4mvQnKinE/kNQykqtcHGFowM83M6DiaBSZ2wzuH6bWkqLE
         kSp6/b50yMHIdD1hk67+l1EhZksWTikLqckMnj+QYWXItOSbCLbqXqStHIbBz4hwTJ
         r7LGmBvlV6E/2dw4w2urvENxaxucBaSdeRReFeo5p6O9Jnawnzj34yEG5sLYbfhDtW
         ylJSd5AxBusBQ==
Message-ID: <edee6a1e-ad72-d51d-2bda-d6f59b7d91e5@kernel.org>
Date:   Tue, 10 May 2022 10:41:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] memory: OMAP_GPMC should depend on ARCH_OMAP2PLUS ||
 ARCH_K3
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <2b7d411b4a7913335082c858cb0d63b9e4bf7c5b.1652103920.git.geert+renesas@glider.be>
 <20fd1a74-c0f5-d8e9-4903-b74c185d5aa3@kernel.org>
 <CAMuHMdVXHSnOOnn3jchezQc+bsPYTnSPuw_rOe+pyskAVaQGnQ@mail.gmail.com>
 <b8983ff3-7dca-0556-1bcc-05897aef212c@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <b8983ff3-7dca-0556-1bcc-05897aef212c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2022 10:36, Krzysztof Kozlowski wrote:
> On 10/05/2022 09:30, Geert Uytterhoeven wrote:
>> Hi Roger,
>>
>> On Tue, May 10, 2022 at 9:22 AM Roger Quadros <rogerq@kernel.org> wrote:
>>> On 09/05/2022 16:48, Geert Uytterhoeven wrote:
>>>> The Texas Instruments OMAP General Purpose Memory Controller (GPMC) is
>>>> only present on TI OMAP2/3/4/5, AM33xx, AM43x, DRA7xx, TI81xx, and K3
>>>> SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_K3, to prevent
>>>> asking the user about this driver when configuring a kernel without
>>>> OMAP2+ or K3 SoC family support.
>>>>
>>>> Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>>>> --- a/drivers/memory/Kconfig
>>>> +++ b/drivers/memory/Kconfig
>>>> @@ -105,6 +105,7 @@ config TI_EMIF
>>>>  config OMAP_GPMC
>>>>       tristate "Texas Instruments OMAP SoC GPMC driver"
>>>>       depends on OF_ADDRESS
>>>> +     depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
>>>>       select GPIOLIB
>>>>       help
>>>>         This driver is for the General Purpose Memory Controller (GPMC)
>>>
>>> Is there any possibility that CONFIG_IRQ_DOMAIN is not set while both
>>> OF_ADDRESS and COMPILE_TEST are set?
>>>
>>> That particular case will lead to build failures.
>>>
>>> e.g.
>>> https://krzk.eu/#/builders/63/builds/162
>>
>> So it needs an additional dependency on IRQ_DOMAIN.
>> That is a pre-existing problem, not caused by my patch (which adds
>> more dependencies, and doesn't remove any).
> 
> Is this really a case here? The failure reported above was for earlier
> version of Roger's patch which was changing to:
> 	depends on OF_ADDRESS || COMPILE_TEST
> 
> Here, OF_ADDRESS will be always a dependency. If it builds in current
> configuration (having only OF_ADDRESS), then adding dependencies should
> not cause more issues.... It only restricts the config, not widens it.
> 
> Therefore the patch looks actually correct, but some testing would be
> nice that we don't hit the same issues as before.
> 

I'll take care of the tests using lkp of course ;)

cheers,
-roger
