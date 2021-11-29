Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB77462676
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhK2Wwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbhK2Wue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:50:34 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D3C127111
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:06:09 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id d11so36084149ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tAEyj+P1GwPw8t/okpqzCX7GoYf79nGN9WlydqQpImA=;
        b=hpuo+Ib04BIuALv/T1Kc7Tkh0HujgdpvzwOKAy3j/p/Dle9ALLyDeYxz2I8t40D/cL
         Ozf2WysP180g3+ryqjRER41b8Q9Gh0HJKojGcjwdy27hmOswVoVSP5K4DS/9AfV5h8Ni
         HyNid4r3MAqeBPWaSNoPGk1hVzwT/rPAjmKzbPsZ8K37qRHbhBrwxviqUugokKHa0BnP
         uWAvGQz76sLa/8EOSR/vEP97gwa+T24KmUNyPB1FNLBozbbRMb98nSjrLC4hOCeSMx1y
         gQb2xHJcsHZEsBAaJG5SDMLkpq98Q86HpVxTbexI/kwKBOKLRuDH8nhqW9tzSUTZdCa/
         e/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tAEyj+P1GwPw8t/okpqzCX7GoYf79nGN9WlydqQpImA=;
        b=doRKeMJcv+IQ0XcUqpSlxkUhRnRH3j6Gr/7qiW+/6D+XwcaNxx8mHIrKf98aocAvuY
         zO14N9CTB8oQvBDBXGzWhmeNl2CwMset8IoZ84LhIVwXF/vt4gKxbev4BY8Tqij/dP+A
         vo4geUwOA67JQ11Y4hL8tb1zIJGVtxk33MZymdH08ZzcTUjQKqoZ6gbbKgq7DoA/E1Yv
         Op6wb/75KQpUN9YfYxEn0/uqkVVzQPUQQhmOW52j0lZobZdTKr8gvF+vZ4JyVsUibhEP
         z45nh3HtKrvm9YK9E4fKTfb6QPTKCA1BxrnHwERIPu9O7JbuMVw984iFEUSoNVDWDrTp
         Ubog==
X-Gm-Message-State: AOAM531v32CQWN2H/sw/FgLcf72oMgLZbZOlquRlm624fhNeyMeX5ymR
        0RUb77I6HakDGm8uarw7d63Fh3vaKbm+UFW5
X-Google-Smtp-Source: ABdhPJxuz/PYZhp3MA67amf0adstN770tPQR9dKihRo7Kp6xBNG5Vj82xhQdexSi9PtADeVw4NxgNg==
X-Received: by 2002:a2e:bba1:: with SMTP id y33mr50836072lje.263.1638209167535;
        Mon, 29 Nov 2021 10:06:07 -0800 (PST)
Received: from [172.16.0.150] ([31.148.138.103])
        by smtp.gmail.com with ESMTPSA id d39sm1422983lfv.78.2021.11.29.10.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 10:06:07 -0800 (PST)
Subject: Re: [PATCH] mtd: rawnand: arasan: Fix clock rate in NV-DDR
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, nagasure@xilinx.com, richard@nod.at,
        vigneshr@ti.com, linux-kernel@vger.kernel.org
References: <20211127180758.30884-1-okitain@gmail.com>
 <20211129095559.01aa63a6@xps13>
From:   Olga Kitaina <okitain@gmail.com>
Message-ID: <3da5dff5-53d4-15db-075d-9b195f2f75dd@gmail.com>
Date:   Mon, 29 Nov 2021 21:06:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129095559.01aa63a6@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 29.11.2021 11:55, Miquel Raynal wrote:
> Hi Olga,
> 
> Please add all the MTD maintainers in copy, as requested by
> get_maintainers.pl.
> 
> okitain@gmail.com wrote on Sat, 27 Nov 2021 21:07:58
> +0300:
> 
>> According to the Arasan NAND controller spec,
>> the flash clock rate for SDR must be <= 100 MHz,
>> while for NV-DDR it must be the same as the rate
>> of the CLK line for the mode.
> 
> I completely missed that, where did you get the information?

The "Data Interface Transitions" chapter of the spec contains timings for flash clock setup in NV-DDR
and NV-DDR2 modes. The "time period" of those clocks is equal to tCK in NV-DDR and tRC in NV-DDR2.

The same chapter should have information about necessary steps to switch from NV-DDR to SDR,
which includes setting the flash clock to 100 MHz.


Just to make sure i'm not shooting myself in the foot: am I changing the right clock?
The documentation points out that we have to change flash_clk, which i thought was
nfc->controller_clk and set up by anand->clk, but it seems like it might actually be nfc->bus_clk.

In that case, does setting nfc->controller_clk to 100 MHz by default make sense?
There isn't a hard limit on what the system clock might be (beyond a specific SoC),
but there are timing requirements for the flash clock, and so setting a specific 
system clock frequency seems unnecessary for most devices.



>> The driver previously always set 100 MHz for NV-DDR, which
>> would result in incorrect behavior for NV-DDR modes 0-4.
>>
>> The appropriate clock rate can be calculated
>> from the NV-DDR timing parameters as 1/tCK, or for rates
>> measured in picoseconds, 10^12 / nand_nvddr_timings->tCK_min.
>>
> 
> You need a couple of Fixes + Cc: stable tags here, otherwise the
> patch looks good to me.
> 

Will include in the next iteration of the patch, thank you.

>> Signed-off-by: Olga Kitaina <okitain@gmail.com>
>> ---
>>  drivers/mtd/nand/raw/arasan-nand-controller.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
>> index 53bd10738418..ed4ee9942441 100644
>> --- a/drivers/mtd/nand/raw/arasan-nand-controller.c
>> +++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/iopoll.h>
>> +#include <linux/math64.h>
>>  #include <linux/module.h>
>>  #include <linux/mtd/mtd.h>
>>  #include <linux/mtd/partitions.h>
>> @@ -1043,7 +1044,12 @@ static int anfc_setup_interface(struct nand_chip *chip, int target,
>>  				 DQS_BUFF_SEL_OUT(dqs_mode);
>>  	}
>>  
>> -	anand->clk = ANFC_XLNX_SDR_DFLT_CORE_CLK;
>> +	if (nand_interface_is_sdr)
>> +		anand->clk = ANFC_XLNX_SDR_DFLT_CORE_CLK;
>> +	else
>> +		/* ONFI timings are defined in picoseconds */
>> +		anand->clk = div_u64((u64)NSEC_PER_SEC * 1000,
>> +				     conf->timings.nvddr.tCK_min);
>>  
>>  	/*
>>  	 * Due to a hardware bug in the ZynqMP SoC, SDR timing modes 0-1 work
>>
>> base-commit: f53d4c109a666bf1a4883b45d546fba079258717
> 
> 
> Thanks,
> Miquèl
> 
