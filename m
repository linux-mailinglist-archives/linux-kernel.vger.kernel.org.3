Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C72750678B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348043AbiDSJUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiDSJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:20:32 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CDC26AC9;
        Tue, 19 Apr 2022 02:17:50 -0700 (PDT)
Received: from [10.28.39.106] (10.28.39.106) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 19 Apr
 2022 17:17:48 +0800
Message-ID: <2e382e3e-c231-c9e4-73a1-0637288fcd4f@amlogic.com>
Date:   Tue, 19 Apr 2022 17:17:48 +0800
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
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20220419102629.1c77aa2a@xps13>
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

Hello Miquel,

On 2022/4/19 16:26, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello,
> 
> liang.yang@amlogic.com wrote on Mon, 18 Apr 2022 11:40:10 +0800:
> 
>> Hi Miquel,
>>
>> i have some confusion when i prepare the patches. for DT compatibility, it falls back to the old DT when failed to get resource by the new DT, but there is some points:
>> a. old DT depends on MMC sub clock driver, but it never be merged, so it can't work.
> 
> I don't get what you mean here, sorry. I believe there is a new way to
> describe this clock but grabbing the one from the MMC still works, does
> not it?
> 

No, it doesn't. after the NFC driver using the MMC sub clock framework 
was merged into the mainline of kernel, we didn't continue to submit the 
series of patches about MMC sub clock after v9. when i found that, we 
made a discussion to decide whether to recover the series of patches 
about MMC sub clock framework, finally, see the description from cover 
letter, we plan to abandon it and adopt the new clock scheme in this 
series of patches.

Thanks.

>> b. if it falls back to the old DT, beside the regmap lookup below, it seems that we have to preserve the code of the old clock setting in nfc_clk_init().
> 
> Yes, probably.
> 
>> do we still need to avoid break DT compatibility?
> 
> We should try our best to avoid breaking the DT, yes.
> 
>>
>> Thanks.
>>
>> On 2022/4/11 10:40, Liang Yang wrote:
>>>>>        nfc->dev = dev;
>>>>> -    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>> -    nfc->reg_base = devm_ioremap_resource(dev, res);
>>>>> +    nfc->reg_base = devm_platform_ioremap_resource_byname(pdev, "nfc");
>>>>
>>>> This change seems unrelated.
>>>
>>> To be consistent with the following > devm_platform_ioremap_resource_byname(pdev, "emmc"). do you mean that we > don't need it?>
>>>>>        if (IS_ERR(nfc->reg_base))
>>>>>            return PTR_ERR(nfc->reg_base);
>>>>> -    nfc->reg_clk =
>>>>> -        syscon_regmap_lookup_by_phandle(dev->of_node,
>>>>> -                        "amlogic,mmc-syscon");
>>>>> -    if (IS_ERR(nfc->reg_clk)) {
>>>>> -        dev_err(dev, "Failed to lookup clock base\n");
>>>>> -        return PTR_ERR(nfc->reg_clk);
>>>>> -    }
>>>>> +    nfc->sd_emmc_clock = devm_platform_ioremap_resource_byname(pdev, >>> "emmc");
>>>>> +    if (IS_ERR(nfc->sd_emmc_clock))
>>>>> +        return PTR_ERR(nfc->sd_emmc_clock);
>>>>
>>>> While I agree this is much better than the previous solution, we cannot
>>>> break DT compatibility, so you need to try getting the emmc clock, but
>>>> if it fails you should fallback to the regmap lookup.
>>>
>>> ok, i will fix it next version. thanks.
>>>    
>>>>   
>>>>>        irq = platform_get_irq(pdev, 0);
> 
> 
> Thanks,
> Miquèl
> 
> .
