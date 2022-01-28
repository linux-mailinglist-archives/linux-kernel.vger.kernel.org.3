Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D8C49F905
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348339AbiA1MQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:16:28 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:35996 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiA1MQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:16:27 -0500
Received: from [10.28.39.106] (10.28.39.106) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 28 Jan
 2022 20:16:26 +0800
Message-ID: <e87b40f0-140e-0521-b861-7481cfc1507d@amlogic.com>
Date:   Fri, 28 Jan 2022 20:16:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/2] mtd: rawnand: meson: discard the common MMC sub
 clock framework
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220128113237.39996-1-liang.yang@amlogic.com>
 <20220128113237.39996-2-liang.yang@amlogic.com>
 <20220128124036.25fe0539@xps13>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20220128124036.25fe0539@xps13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.106]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Thanks for the review and quick response.

On 2022/1/28 19:40, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Liang,
> 
> liang.yang@amlogic.com wrote on Fri, 28 Jan 2022 19:32:36 +0800:
> 
>> EMMC and NAND has the same clock control register named 'SD_EMMC_CLOCK' which is
> 
> have
ok
> 
>> defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is the divider and
>> bit6~7 is the mux for fix pll and xtal.
> 
>> Previously a common MMC sub clock framework is implemented and shared by EMMC and
> 
> I believe you meant that this hasa already been contributed? I would
> then rephrase with:
> 
> A common MMC and NAND sub-clock has been implemented and can be used by
> the eMMC and NAND controller (which are mutually exclusive anyway).
> 
> Let's use this new clock.
ok. thanks
> 
>> NAND, but that is coupling the EMMC and NAND, although EMMC and NAND is mutually
>> exclusive.
>>
>> Change-Id: Ibeb4c7ff886f5886aac4d6c664d7bbd1b1bcb997
> 
> No change Ids.
ok. i will delete next version.
> 
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> ---
>>   drivers/mtd/nand/raw/meson_nand.c | 161 +++++++++++++++++-------------
>>   1 file changed, 89 insertions(+), 72 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index ac3be92872d0..f6a3d5c2ea1c 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -2,7 +2,7 @@
>>   /*
>>    * Amlogic Meson Nand Flash Controller Driver
>>    *
>> - * Copyright (c) 2018 Amlogic, inc.
>> + * Copyright (c) 2018-2021 Amlogic, inc.
> 
> Please don't.
> 
>>    * Author: Liang Yang <liang.yang@amlogic.com>
>>    */
>>   
>> @@ -10,6 +10,7 @@
>>   #include <linux/dma-mapping.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>>   #include <linux/mtd/rawnand.h>
>>   #include <linux/mtd/mtd.h>
>>   #include <linux/mfd/syscon.h>
>> @@ -19,6 +20,7 @@
>>   #include <linux/iopoll.h>
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>> +#include <linux/of_address.h>
>>   #include <linux/sched/task_stack.h>
>>   
>>   #define NFC_REG_CMD		0x00
>> @@ -104,6 +106,9 @@
>>   
>>   #define PER_INFO_BYTE		8
>>   
>> +#define CLK_DIV_SHIFT		0
>> +#define CLK_DIV_WIDTH		6
>> +
>>   struct meson_nfc_nand_chip {
>>   	struct list_head node;
>>   	struct nand_chip nand;
>> @@ -151,15 +156,17 @@ struct meson_nfc {
>>   	struct nand_controller controller;
>>   	struct clk *core_clk;
>>   	struct clk *device_clk;
>> -	struct clk *phase_tx;
>> -	struct clk *phase_rx;
>> +	struct clk *nand_clk;
>> +	struct clk_divider nand_divider;
>>   
>>   	unsigned long clk_rate;
>>   	u32 bus_timing;
>>   
>>   	struct device *dev;
>> -	void __iomem *reg_base;
>> -	struct regmap *reg_clk;
>> +	struct {
>> +		void __iomem *reg_base;
>> +		void __iomem *sd_emmc_clock;
>> +	} res;
> 
> Please split your commit: first the mechanical changes, then the use of
> the new area or something like that.
> 
> Otherwise there are too many lines changed, I can't spot where it is
> interesting.

ok. i will split it next version. thanks.

> 
> Thanks,
> Miquèl
> 
> .
