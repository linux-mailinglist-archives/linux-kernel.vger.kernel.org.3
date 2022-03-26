Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51124E816F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiCZOie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiCZOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:38:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9986B5574B;
        Sat, 26 Mar 2022 07:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24E8AB800A0;
        Sat, 26 Mar 2022 14:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8874AC2BBE4;
        Sat, 26 Mar 2022 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648305413;
        bh=igDtAuPL6icAEvvm8ro1ZcNAYdsaI4UpfWZQyWSpzZY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=umn7cW7hHrYSqvT6wIkAD4FnPQqWnanVEj5betr3KnFkm0ZWl8LrHJ767/4crzSxt
         3Jh8lgzJhHWW/jzrJhyoCU2w00cIN+qtx89ZGkE5OR49BPI+BP+Sa8nCOjr+oqrqTk
         DKP7JXT3/ex1/wHFayq25cu6Dw/9UP7g5EfLLfy2T8O+xA7C2kQyKpdGq6frUTV1aV
         PMHWu4hl+eOwbJvDhdwQwXzvrcS7WrjenZhn0AalgM+8A+7BA77T2x9M6XFviiw8gh
         xKJsZAP1nFdQKb3HbaZp6Vs7B3+ySLcKl1atNyvlUOacRY3xIH9RD56dVrxf/elY6u
         DOz4RiP9CAsDg==
Message-ID: <f76c1b41-a671-fe47-1f7c-3b34027b9479@kernel.org>
Date:   Sat, 26 Mar 2022 16:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] memory: omap-gpmc: Make OMAP_GPMC config visible and
 selectable
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, kishon@ti.com,
        nm@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220326084331.28310-1-rogerq@kernel.org>
 <e28524f0-7251-afc3-4237-58994659f0d3@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <e28524f0-7251-afc3-4237-58994659f0d3@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 26/03/2022 16:09, Vignesh Raghavendra wrote:
> Hi Roger,
> 
> On 26/03/22 2:13 pm, Roger Quadros wrote:
>> So far for armv7 TI platforms, GPMC was being selected by
>> arch/arm/mach-* architecture Kconfig files.
>>
>> For K3 platforms, GPMC is no longer required for basic boot
>> and cannot be always enabled by default by mach- Kconfig.
>>
>> We need a way for user (or board defconfig) to enable
>> it if required so ake OMAP_GPMC Kconfig option always visible.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/memory/Kconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
>> index 30bff6cb1b8d..da2af9c38fe3 100644
>> --- a/drivers/memory/Kconfig
>> +++ b/drivers/memory/Kconfig
>> @@ -103,8 +103,8 @@ config TI_EMIF
>>  	  temperature changes
>>  
>>  config OMAP_GPMC
>> -	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
>> -	depends on OF_ADDRESS
>> +	bool "Texas Instruments OMAP SoC GPMC driver"
>> +	depends on OF_ADDRESS || COMPILE_TEST
> 
> Can we make this tristate now, so that driver can be built as module?

Sure, I'll give it a try.

> 
>>  	select GPIOLIB
>>  	help
>>  	  This driver is for the General Purpose Memory Controller (GPMC)

--
cheers,
-roger
