Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31F5520EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiEJHrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbiEJHqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:46:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DA81F62B;
        Tue, 10 May 2022 00:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFDD2B81B40;
        Tue, 10 May 2022 07:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7328EC385A6;
        Tue, 10 May 2022 07:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652168415;
        bh=4pa8xtxIYdPOOPiZ/Rc8/Ec0VVkaJkPcp/T1DfEb3Fo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nd3IK2VDBTzrTD1nGJpkHFs76uFlJwD6+CDVNDGKMgKf59LN+DoIVdgzPExTDtzt1
         QeDJD+zMWlTvAoEHMMZbxvxinwvO74OeemTdi7wPuK4wp+O3s7oPr76aVw3N8cku78
         RSknBkEUCSxXv6WYKRyB1Q3d5NBpCxP2w8uac4WvwlcNqwl776Gthmmv2KyZLoqbU9
         TDtiibgPUULduFui1TTMjqkVHS9h3z4q0HaM9WXWU5841nL5TbOeHomWDy6ARPqA0L
         a1+kTBgIPxvjUEYs8cXC/ftAEUOfrCihFPO4LucHASPPsiCL8DeacxlhI+m3KfzYSo
         Ba1wS2q51YI7w==
Message-ID: <22ed864d-8d71-7042-4d55-2b0b65d4d281@kernel.org>
Date:   Tue, 10 May 2022 10:40:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] memory: OMAP_GPMC should depend on ARCH_OMAP2PLUS ||
 ARCH_K3
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <2b7d411b4a7913335082c858cb0d63b9e4bf7c5b.1652103920.git.geert+renesas@glider.be>
 <20fd1a74-c0f5-d8e9-4903-b74c185d5aa3@kernel.org>
 <CAMuHMdVXHSnOOnn3jchezQc+bsPYTnSPuw_rOe+pyskAVaQGnQ@mail.gmail.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CAMuHMdVXHSnOOnn3jchezQc+bsPYTnSPuw_rOe+pyskAVaQGnQ@mail.gmail.com>
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

Geert,

On 10/05/2022 10:30, Geert Uytterhoeven wrote:
> Hi Roger,
> 
> On Tue, May 10, 2022 at 9:22 AM Roger Quadros <rogerq@kernel.org> wrote:
>> On 09/05/2022 16:48, Geert Uytterhoeven wrote:
>>> The Texas Instruments OMAP General Purpose Memory Controller (GPMC) is
>>> only present on TI OMAP2/3/4/5, AM33xx, AM43x, DRA7xx, TI81xx, and K3
>>> SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_K3, to prevent
>>> asking the user about this driver when configuring a kernel without
>>> OMAP2+ or K3 SoC family support.
>>>
>>> Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>>> --- a/drivers/memory/Kconfig
>>> +++ b/drivers/memory/Kconfig
>>> @@ -105,6 +105,7 @@ config TI_EMIF
>>>  config OMAP_GPMC
>>>       tristate "Texas Instruments OMAP SoC GPMC driver"
>>>       depends on OF_ADDRESS
>>> +     depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
>>>       select GPIOLIB
>>>       help
>>>         This driver is for the General Purpose Memory Controller (GPMC)
>>
>> Is there any possibility that CONFIG_IRQ_DOMAIN is not set while both
>> OF_ADDRESS and COMPILE_TEST are set?
>>
>> That particular case will lead to build failures.
>>
>> e.g.
>> https://krzk.eu/#/builders/63/builds/162
> 
> So it needs an additional dependency on IRQ_DOMAIN.
> That is a pre-existing problem, not caused by my patch (which adds
> more dependencies, and doesn't remove any).

Fair enough.

Could you please also add ARCH_KEYSTONE in the 'depends on' list
as some SoCs in that architecture do have the GPMC block.

cheers,
-roger
