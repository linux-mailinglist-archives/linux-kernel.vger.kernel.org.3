Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C1C4CE06C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 23:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiCDWvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 17:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCDWvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:51:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651831F6BD4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 14:50:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A00BB82A7B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 22:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1585FC340E9;
        Fri,  4 Mar 2022 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646434218;
        bh=f4c73Qb2h5VbumIRsVZDFSfPv+BHp7PeoO32syj+yas=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ihFYXDmH/fe7OCq5j3R0AHd2fnHrkL+SA7ygnr7lwfZlwKFKdrYgrR1dG+y8zZnUq
         k7h9hVLORJjw3XUWvdakviSZFEnl0Ejk/LlZ+QnjXXPL9WoxNBd2cGkWsN4WHmrImr
         bco3H6Z2kPUpYFPR+vR4XE7/gmZNg4WwQtDitR9wlScbuXHTi9YhPyY0MqAVvNgl32
         L0n/YDAdl1O3M5JBDCRbdTejzmO/hp+6d65Z+bXU0xMWka4mEAdv4imNOenA3JA0kc
         b82wt3/IsZwbOHb8tKxpje1IbPGzuU3KliJRU5rDiI4s3qUC/nTxbgntjvQZubHqrn
         z8Knvh6Lhjt3Q==
Message-ID: <6c09de15-1ab2-5ca8-7003-69ff3f7c4dc5@kernel.org>
Date:   Sat, 5 Mar 2022 00:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mtd: rawnand: omap2: Actually prevent invalid
 configuration and build error
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        krzysztof.kozlowski@canonical.com, vigneshr@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220220004415.GA1519274@roeck-us.net>
 <4bbe337e-8cd8-a4d6-303d-d5aa21bee2e0@infradead.org>
 <20220304165451.0129012e@xps13>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220304165451.0129012e@xps13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 04/03/2022 17:54, Miquel Raynal wrote:
> Hi Guenter, Roger,
> 
> rdunlap@infradead.org wrote on Sat, 26 Feb 2022 22:55:28 -0800:
> 
>> On 2/19/22 16:44, Guenter Roeck wrote:
>>> On Sat, Feb 19, 2022 at 09:36:00PM +0200, Roger Quadros wrote:  
>>>> The root of the problem is that we are selecting symbols that have
>>>> dependencies. This can cause random configurations that can fail.
>>>> The cleanest solution is to avoid using select.
>>>>
>>>> This driver uses interfaces from the OMAP_GPMC driver so we have to
>>>> depend on it instead.
>>>>
>>>> Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid configuration and build error")
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>  
>>>
>>> Tested-by: Guenter Roeck <linux@roeck-us.net>  
>>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Sorry for noticing that just now, but there is still a problem with
> this patch: we now always compile-in the OMAP_GPMC driver whenever we
> need the NAND controller, even though it is not needed. This grows the
> kernel for no reason.

Sorry, I did not understand what you meant.

We no longer explicitly enable OMAP_GPMC since we dropped the "select".
This fixes all build issues that were reported recently.

MTD_NAND_OMAP2 will not be enabled if OMAP_GPMC is not since we added
the "depends on". This fixes the original build issue that we started to
fix with select initially.

> 
> In fact, Roger once said:
> 
> 	"We will figure out how to enable OMAP_GPMC for K3 architecture
> 	some other way."
> 
> It turns out this is not what was finally proposed. Could we try yet
> another solution?

This issue is still present i.e. we cannot enable MTD_NAND_OMAP2 driver on
K3 platform since OMAP_GPMC config is hidden and not select-able
by user or defconfig file.

But it is not yet a deal breaker since NAND on K3 is not yet enabled upstream.

For this I think OMAP_GPMC has to be a visible config entry and select-able
from a defconfig file as I had done initially [1].

Now we have a lot of explanation to write as to why we need to do it ;)

[1] - https://lore.kernel.org/lkml/20211123102607.13002-3-rogerq@kernel.org/

> 
>>
>> Thanks.
>>
>>>   
>>>> ---
>>>>  drivers/mtd/nand/raw/Kconfig | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>>>> index 36e697456ec4..9b078e78f3fa 100644
>>>> --- a/drivers/mtd/nand/raw/Kconfig
>>>> +++ b/drivers/mtd/nand/raw/Kconfig
>>>> @@ -42,8 +42,7 @@ config MTD_NAND_OMAP2
>>>>  	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>>>>  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>>>>  	depends on HAS_IOMEM
>>>> -	select MEMORY
>>>> -	select OMAP_GPMC
>>>> +	depends on OMAP_GPMC
>>>>  	help
>>>>  	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
>>>>  	  and Keystone platforms.
>>>> -- 
>>>> 2.17.1
>>>>  
>>
> 
> Thanks,
> Miquèl


cheers,
-roger
