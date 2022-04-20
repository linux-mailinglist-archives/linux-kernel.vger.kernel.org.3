Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24187508344
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376669AbiDTIWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376653AbiDTIWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:22:04 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A995F2494A;
        Wed, 20 Apr 2022 01:19:18 -0700 (PDT)
Received: from [10.28.39.106] (10.28.39.106) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 20 Apr
 2022 16:19:17 +0800
Message-ID: <fb76d82d-d4df-9b0a-506c-83771f000b97@amlogic.com>
Date:   Wed, 20 Apr 2022 16:19:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/2] mtd: rawnand: meson: discard the common MMC sub
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
References: <20220402074921.13316-1-liang.yang@amlogic.com>
 <20220402074921.13316-2-liang.yang@amlogic.com>
 <20220404103034.48ec16b1@xps13>
 <50105d6b-8ced-1b72-30cb-a709c4a4dd26@amlogic.com>
 <d5a33645-fac1-9c69-afe6-654bfe93ca48@amlogic.com>
 <20220419102629.1c77aa2a@xps13>
 <2e382e3e-c231-c9e4-73a1-0637288fcd4f@amlogic.com>
 <20220419172528.2dd75e7b@xps13>
 <126691f4-bc6b-10cd-ee2c-ff4006bc6518@amlogic.com>
 <20220420092912.10ce66ec@xps13>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20220420092912.10ce66ec@xps13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.106]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 2022/4/20 15:29, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Liang,
> 
> liang.yang@amlogic.com wrote on Wed, 20 Apr 2022 13:44:32 +0800:
> 
>> Hi Miquel,
>>
>> On 2022/4/19 23:25, Miquel Raynal wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hello,
>>>
>>> liang.yang@amlogic.com wrote on Tue, 19 Apr 2022 17:17:48 +0800:
>>>    
>>>> Hello Miquel,
>>>>
>>>> On 2022/4/19 16:26, Miquel Raynal wrote:
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> Hello,
>>>>>
>>>>> liang.yang@amlogic.com wrote on Mon, 18 Apr 2022 11:40:10 +0800:
>>>>>     >>>> Hi Miquel,
>>>>>>
>>>>>> i have some confusion when i prepare the patches. for DT compatibility, it falls back to the old DT when failed to get resource by the new DT, but there is some points:
>>>>>> a. old DT depends on MMC sub clock driver, but it never be merged, so it can't work.
>>>>>
>>>>> I don't get what you mean here, sorry. I believe there is a new way to
>>>>> describe this clock but grabbing the one from the MMC still works, does
>>>>> not it?
>>>>>     >>
>>>> No, it doesn't. after the NFC driver using the MMC sub clock framework was merged into the mainline of kernel, we didn't continue to submit the series of patches about MMC sub clock after v9. when i found that, we made a discussion to decide whether to recover the series of patches about MMC sub clock framework, finally, see the description from cover letter, we plan to abandon it and adopt the new clock scheme in this series of patches.
>>>
>>> I am not sure to follow. Is the current code completely broken? I
>>> believe it is not, so I don't understand your issue.
>>
>> i think only the code about the clock is completely broken.
>>
>>>
>>> Can you please summarize the situation?
>>
>> Yes. the current NFC clock implementation depends on the following series of patches [https://lore.kernel.org/all/20220121074508.42168-5-liang.yang@amlogic.com], which we call "Meson MMC Sub Clock Controller Driver".
>> when i was preparing the NFC patchset at that time, we discussed how the clock should be implemented base on the special clock framework for NFC and EMMC port. then we decided to implement a driver "Meson MMC Sub Clock Controller Driver". so another people begin to prepare "Meson MMC Sub Clock Controller Driver", but submitted it by different patchset.
>> finally, now the meson NFC patchset is accepted and merged, but "Meson MMC Sub Clock Controller Driver" patchset is not. also we decide to abandon the patset "Meson MMC Sub Clock Controller Driver" and implement the new clock design in this series.
> 
> Ok thanks for the summary and the link with the discussion with Jerome
> and Neil, it's informative.
> 
> So in the end, we are not really breaking anything here as this NAND
> controller driver never worked in the first place? Or is it only one of
> the two compatibles which is not working?

i think no one can work now. i am preparing the newer clock framework in 
this series.

> 
> If this never worked then please do the binding changes (in the first
> patch of your series) and then do the necessary changes in the code. If
> this worked with at least one of the two compatibles, then you have to
> create dedicated helpers, one for each, in order to grab the clocks
> differently and not break anybody.

ok, i am changing the bindings and code in this series. thanks for your 
explanation.

> 
>>
>>>    
>>>>
>>>> Thanks.
>>>>   
>>>>>> b. if it falls back to the old DT, beside the regmap lookup below, it seems that we have to preserve the code of the old clock setting in nfc_clk_init().
>>>>>
>>>>> Yes, probably.
>>>>>     >>>> do we still need to avoid break DT compatibility?
>>>>>
>>>>> We should try our best to avoid breaking the DT, yes.
>>>>>     >>>>
>>>>>> Thanks.
>>>>>>
>>>>>> On 2022/4/11 10:40, Liang Yang wrote:
>>>>>>>>>          nfc->dev = dev;
>>>>>>>>> -    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>>>>> -    nfc->reg_base = devm_ioremap_resource(dev, res);
>>>>>>>>> +    nfc->reg_base = devm_platform_ioremap_resource_byname(pdev, "nfc");
>>>>>>>>
>>>>>>>> This change seems unrelated.
>>>>>>>
>>>>>>> To be consistent with the following > devm_platform_ioremap_resource_byname(pdev, "emmc"). do you mean that we > don't need it?>
>>>>>>>>>          if (IS_ERR(nfc->reg_base))
>>>>>>>>>              return PTR_ERR(nfc->reg_base);
>>>>>>>>> -    nfc->reg_clk =
>>>>>>>>> -        syscon_regmap_lookup_by_phandle(dev->of_node,
>>>>>>>>> -                        "amlogic,mmc-syscon");
>>>>>>>>> -    if (IS_ERR(nfc->reg_clk)) {
>>>>>>>>> -        dev_err(dev, "Failed to lookup clock base\n");
>>>>>>>>> -        return PTR_ERR(nfc->reg_clk);
>>>>>>>>> -    }
>>>>>>>>> +    nfc->sd_emmc_clock = devm_platform_ioremap_resource_byname(pdev, >>> "emmc");
>>>>>>>>> +    if (IS_ERR(nfc->sd_emmc_clock))
>>>>>>>>> +        return PTR_ERR(nfc->sd_emmc_clock);
>>>>>>>>
>>>>>>>> While I agree this is much better than the previous solution, we cannot
>>>>>>>> break DT compatibility, so you need to try getting the emmc clock, but
>>>>>>>> if it fails you should fallback to the regmap lookup.
>>>>>>>
>>>>>>> ok, i will fix it next version. thanks.
>>>>>>>      >>>>   >>>>>        irq = platform_get_irq(pdev, 0);
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Miquèl
>>>>>
>>>>> .
>>>
>>>
>>> Thanks,
>>> Miquèl
>>>
>>> .
> 
> 
> Thanks,
> Miquèl
> 
> .
