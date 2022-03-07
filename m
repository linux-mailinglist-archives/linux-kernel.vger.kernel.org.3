Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB74D092E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiCGVGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiCGVGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:06:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4FB7EA3D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 13:05:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04AACB816F8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 21:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA64C340FD;
        Mon,  7 Mar 2022 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646687152;
        bh=NY/LXiBfva6sib1pzjqDb5fkBqhAkuW9f39ryTvq1cc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=raHaa2HxqeRZEC1I4Bd9hL9I1bROc7qqiUnxGzBRTGIr+JiO1C/qm6rnMaNtD0QkF
         etqbmRBq7XG5sHb90ag1osCD8dXx6c+ZVIT/EuHba8HYFnhLEtDSCiRMwHl84sTfyp
         Kq7F2U1/YMLzPDh/MlcuhCfuBivVe6ExvvIfACxoWk3RtiT8lYF/jOFk1K1+H+t4un
         0roJdvY3j6+xRo/3LdTFgEjsj1Xt7+0iPK++h8r/2OrBaeQJpGmibeOE2ETk7mFyop
         ZjKsRO2wt+2lx7puqECQcVPIm3SdieW4lZxVInrNa7HmcV+hkGcU4EpIjbF8U2EKFL
         dxfXio8Dwj1xg==
Message-ID: <c91edeac-817c-d30d-ae45-f216670b9e69@kernel.org>
Date:   Mon, 7 Mar 2022 23:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mtd: rawnand: omap2: Actually prevent invalid
 configuration and build error
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        krzysztof.kozlowski@canonical.com, vigneshr@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220220004415.GA1519274@roeck-us.net>
 <4bbe337e-8cd8-a4d6-303d-d5aa21bee2e0@infradead.org>
 <20220304165451.0129012e@xps13>
 <6c09de15-1ab2-5ca8-7003-69ff3f7c4dc5@kernel.org>
 <20220307110357.20d50176@xps13>
 <c39d64f0-deef-4cae-fab7-555a48e31811@kernel.org>
 <20220307151249.7e5b7210@xps13>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220307151249.7e5b7210@xps13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 07/03/2022 16:12, Miquel Raynal wrote:
> Hi Roger,
> 
> rogerq@kernel.org wrote on Mon, 7 Mar 2022 14:25:48 +0200:
> 
>> Hi Miquel,
>>
>> On 07/03/2022 12:03, Miquel Raynal wrote:
>>> Hi Roger,
>>>
>>> rogerq@kernel.org wrote on Sat, 5 Mar 2022 00:50:14 +0200:
>>>   
>>>> Hi Miquel,
>>>>
>>>> On 04/03/2022 17:54, Miquel Raynal wrote:  
>>>>> Hi Guenter, Roger,
>>>>>
>>>>> rdunlap@infradead.org wrote on Sat, 26 Feb 2022 22:55:28 -0800:
>>>>>     
>>>>>> On 2/19/22 16:44, Guenter Roeck wrote:    
>>>>>>> On Sat, Feb 19, 2022 at 09:36:00PM +0200, Roger Quadros wrote:      
>>>>>>>> The root of the problem is that we are selecting symbols that have
>>>>>>>> dependencies. This can cause random configurations that can fail.
>>>>>>>> The cleanest solution is to avoid using select.
>>>>>>>>
>>>>>>>> This driver uses interfaces from the OMAP_GPMC driver so we have to
>>>>>>>> depend on it instead.
>>>>>>>>
>>>>>>>> Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid configuration and build error")
>>>>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>      
>>>>>>>
>>>>>>> Tested-by: Guenter Roeck <linux@roeck-us.net>      
>>>>>>
>>>>>> Tested-by: Randy Dunlap <rdunlap@infradead.org>    
>>>>>
>>>>> Sorry for noticing that just now, but there is still a problem with
>>>>> this patch: we now always compile-in the OMAP_GPMC driver whenever we
>>>>> need the NAND controller, even though it is not needed. This grows the
>>>>> kernel for no reason.    
>>>>
>>>> Sorry, I did not understand what you meant.
>>>>
>>>> We no longer explicitly enable OMAP_GPMC since we dropped the "select".
>>>> This fixes all build issues that were reported recently.
>>>>
>>>> MTD_NAND_OMAP2 will not be enabled if OMAP_GPMC is not since we added
>>>> the "depends on". This fixes the original build issue that we started to
>>>> fix with select initially.  
>>>
>>> Yes, this side is fine.
>>>
>>> In the initial commit, you proposed:
>>>
>>> --- a/drivers/mtd/nand/raw/Kconfig
>>> +++ b/drivers/mtd/nand/raw/Kconfig
>>> @@ -42,7 +42,8 @@ config MTD_NAND_OMAP2
>>>         tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>>>         depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>>>         depends on HAS_IOMEM
>>> +       select OMAP_GPMC if ARCH_K3
>>>
>>> Which creates a dependency over OMAP_GPMC only for a single
>>> architecture. Which means that other OMAP platforms do not necessarily
>>> need OMAP_GPMC for the NAND controller to work. Now, you propose:  
>>
>> No that is not true. Other platforms that need MTD_NAND_OMAP2 are
>> explicitly selecting OMAP_GPMC
>> i.e. in arch/arm/mach-omap2/Kconfig
> 
> Okay, in this case the fix is fine but we will need to clean this up in
> a second time.

What clean up are you implying here? Those legacy platform might need
OMAP_GPMC for booting so they select it. There is nothing much we can do there.

What is left to do now is make user/defconfig files to enable OMAP_GPMC driver
so other platforms that don't need OMAP_GPMC for basic operation can still
enable them later via defconfig or manually by user.

> 
>>> --- a/drivers/mtd/nand/raw/Kconfig
>>> +++ b/drivers/mtd/nand/raw/Kconfig
>>> @@ -42,8 +42,7 @@ config MTD_NAND_OMAP2
>>>  	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>>>  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>>>  	depends on HAS_IOMEM
>>> 	depends on OMAP_GPMC
>>>
>>> This means any of the other OMAP architectures will compile the GPMC
>>> driver even though they might not need it, which would unnecessarily
>>> increase the kernel size.
>>>
>>> Am I missing something?  
>>
>> MTD_NAND_OMAP2 NAND controller is a submodule of the OMAP GPMC IP. So it
>> cannot work without OMAP_GPMC driver.
> 
> I didn't remember exactly but in that case it's okay, I was just
> surprised by the "select GPMC if ARCH_K3" but indeed with this
> explanation it makes more sense.
> 
>> Hope this clarifies the doubts.
> 
> Yes, thanks. I will send the fix to Linus then.
> 
> Cheers,
> Miquèl

cheers,
-roger
