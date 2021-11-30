Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC8463F05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbhK3ULz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbhK3ULo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:11:44 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D4DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:08:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id r26so56727725lfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7JdcQD2gHw8mJRZkpMLuKPrRtMfe79QTxAa5BKkqe1c=;
        b=fjzIGck3py3iiHKaVF+NvBwVw2PYlI1/8kpJBfpq9aVM7PL9dLMO8n46AjAoOJLmsv
         Ul1ly0XiAkZ2dYBJxAJ3FGGpwsgPCoBhhUtA+MyxgDrcvSU75dMQDhywARODnmvpJ9f6
         K2mnoppoZo3CBObWoEDemDz8SbK7uokesXybGyy2Iyrmh+ErUBzv5p7ofY/SnDxzPgJ7
         JS87Q2cKmc15KwMZNPYlIXvyFiRjuI0FACeOT5S+fap5i7+UgUt6N+sYz381DnTD17Rb
         pEOQZxoDbDYM1bakqBcMnfIJJZkoVGG5jgSqZzj5yOPAocxdbioUsZhKAqYNKrA8wdtQ
         piIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7JdcQD2gHw8mJRZkpMLuKPrRtMfe79QTxAa5BKkqe1c=;
        b=xLJfCMQC8fFD5nHH1815YHRtA4RMNwhuE6csZtwRju5NKY4w+J1OVANrL+EFcQQKRO
         ClQedgYreD4jipZCwMCQG0KDgI6YNOz0gtEpc9V+yKQAmJEi5N7IcSRnaWzH3uN1CcTz
         edkaHagnAQGInY0ol4OnfKm/LOJ8lHCasfExqnogv2pvXo5UIAMaxJ9SLVpNpDSU74ib
         hEbST85yZz4Xd6cgf/0SFJZL068p2GMTwvS+FVFTdyMln7XoD1rIqXIPc1pLPz8COISI
         SxiYF51I6dttvlgAm5f0obzAehEap9sflhNrNk6eG+ryQU1wK9yUHqsu/uxP05m2Ryxf
         SNPw==
X-Gm-Message-State: AOAM533RoUj+ndmOClThwPMNmKFIiMZmcgCDdEmINssJ+XlunFJCmpRf
        rmhCV21EuREbqLuJ9JFc32kYI59HZBWUeAKZ
X-Google-Smtp-Source: ABdhPJyoZOJhv+FDusWXLIfIYnl/DUwY50qJw+eFkwVhVscVOcf6ZxCNVEjK4qCdctHINQCnLqZfpw==
X-Received: by 2002:a05:6512:1082:: with SMTP id j2mr1289087lfg.557.1638302902537;
        Tue, 30 Nov 2021 12:08:22 -0800 (PST)
Received: from [172.16.0.150] ([31.148.138.103])
        by smtp.gmail.com with ESMTPSA id a1sm1818910lfc.92.2021.11.30.12.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 12:08:22 -0800 (PST)
Subject: Re: [PATCH] mtd: rawnand: arasan: Fix clock rate in NV-DDR
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, nagasure@xilinx.com, richard@nod.at,
        vigneshr@ti.com, linux-kernel@vger.kernel.org
References: <20211127180758.30884-1-okitain@gmail.com>
 <20211129095559.01aa63a6@xps13>
 <3da5dff5-53d4-15db-075d-9b195f2f75dd@gmail.com>
 <20211130082017.1400f24b@xps13>
From:   Olga Kitaina <okitain@gmail.com>
Message-ID: <fb6a4b49-7c10-4ed1-7054-5dd8ce2d8073@gmail.com>
Date:   Tue, 30 Nov 2021 23:08:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130082017.1400f24b@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 30.11.2021 10:20, Miquel Raynal wrote:
> Hi Olga,
> 
> okitain@gmail.com wrote on Mon, 29 Nov 2021 21:06:05 +0300:
> 
>> Hi Miquel,
>>
>> On 29.11.2021 11:55, Miquel Raynal wrote:
>>> Hi Olga,
>>>
>>> Please add all the MTD maintainers in copy, as requested by
>>> get_maintainers.pl.
>>>
>>> okitain@gmail.com wrote on Sat, 27 Nov 2021 21:07:58
>>> +0300:
>>>   
>>>> According to the Arasan NAND controller spec,
>>>> the flash clock rate for SDR must be <= 100 MHz,
>>>> while for NV-DDR it must be the same as the rate
>>>> of the CLK line for the mode.  
>>>
>>> I completely missed that, where did you get the information?  
>>
>> The "Data Interface Transitions" chapter of the spec contains timings for flash clock setup in NV-DDR
>> and NV-DDR2 modes. The "time period" of those clocks is equal to tCK in NV-DDR and tRC in NV-DDR2.
>>
>> The same chapter should have information about necessary steps to switch from NV-DDR to SDR,
>> which includes setting the flash clock to 100 MHz.
>>
>>
>> Just to make sure i'm not shooting myself in the foot: am I changing the right clock?
>> The documentation points out that we have to change flash_clk, which i thought was
>> nfc->controller_clk and set up by anand->clk, but it seems like it might actually be nfc->bus_clk.
> 
> I believe I made a serious mistake, re-reading the code it feels like
> I'm changing the system's clock (which basically changes nothing in our
> case) instead of changing the NAND bus clock.
> 
>> In that case, does setting nfc->controller_clk to 100 MHz by default make sense?
>> There isn't a hard limit on what the system clock might be (beyond a specific SoC),
>> but there are timing requirements for the flash clock, and so setting a specific 
>> system clock frequency seems unnecessary for most devices.
>>
> 
> Please create a two-patch series:
> 1- Setting the right clock in the current code base (inverting bus_clk
> and controller_clk where relevant, setting one to 100MHz and letting
> the other as it is)
> 2- Changing the default NV-DDR rate based on tCK (below patch).
> 
> Do you have the necessary hardware for testing?

I'm sorry to say - I do not. The SoC this problem was initially noticed on can't run latest Linux,
and even if it did I have no way of acquiring an NV-DDR-capable flash.

Since Bootlin merged in NV-DDR support into the kernel, is it possible for you to test 
the next iteration of this patch series on NV-DDR hardware as well?
Say, by purposefully preventing NV-DDR mode 5 from being chosen in anfc_setup_interface()?

>>>> The driver previously always set 100 MHz for NV-DDR, which
>>>> would result in incorrect behavior for NV-DDR modes 0-4.
>>>>
>>>> The appropriate clock rate can be calculated
>>>> from the NV-DDR timing parameters as 1/tCK, or for rates
>>>> measured in picoseconds, 10^12 / nand_nvddr_timings->tCK_min.
>>>>  
>>>
>>> You need a couple of Fixes + Cc: stable tags here, otherwise the
>>> patch looks good to me.
>>>   
>>
>> Will include in the next iteration of the patch, thank you.
>>
>>>> Signed-off-by: Olga Kitaina <okitain@gmail.com>
>>>> ---
>>>>  drivers/mtd/nand/raw/arasan-nand-controller.c | 8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
>>>> index 53bd10738418..ed4ee9942441 100644
>>>> --- a/drivers/mtd/nand/raw/arasan-nand-controller.c
>>>> +++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
>>>> @@ -18,6 +18,7 @@
>>>>  #include <linux/gpio/consumer.h>
>>>>  #include <linux/interrupt.h>
>>>>  #include <linux/iopoll.h>
>>>> +#include <linux/math64.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/mtd/mtd.h>
>>>>  #include <linux/mtd/partitions.h>
>>>> @@ -1043,7 +1044,12 @@ static int anfc_setup_interface(struct nand_chip *chip, int target,
>>>>  				 DQS_BUFF_SEL_OUT(dqs_mode);
>>>>  	}
>>>>  
>>>> -	anand->clk = ANFC_XLNX_SDR_DFLT_CORE_CLK;
>>>> +	if (nand_interface_is_sdr)
>>>> +		anand->clk = ANFC_XLNX_SDR_DFLT_CORE_CLK;
>>>> +	else
>>>> +		/* ONFI timings are defined in picoseconds */
>>>> +		anand->clk = div_u64((u64)NSEC_PER_SEC * 1000,
>>>> +				     conf->timings.nvddr.tCK_min);
>>>>  
>>>>  	/*
>>>>  	 * Due to a hardware bug in the ZynqMP SoC, SDR timing modes 0-1 work
>>>>
>>>> base-commit: f53d4c109a666bf1a4883b45d546fba079258717  
>>>
>>>
>>> Thanks,
>>> Miquèl
>>>   
> 
> 
> Thanks,
> Miquèl
> 

Thanks,
Olga.
