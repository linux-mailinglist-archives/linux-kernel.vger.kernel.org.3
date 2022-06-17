Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BC54F5B7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381948AbiFQKnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382017AbiFQKni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:43:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF406B098;
        Fri, 17 Jun 2022 03:43:36 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E95E7660179A;
        Fri, 17 Jun 2022 11:43:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655462615;
        bh=pFTBW1Zh7xOWnfG5j0ce7qDXmci6BaoqwUQ7UixScpM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MONmR2Bg8gdLljZi9brFqmUNwblg2wc5HVnMI03qwBR7GWqnaQafxjrcvyDPwe7ks
         cqXbi/klmn+yRGLSUjt1LAQkVJi/w/E7OiqULn3uBXq/9GCA7FsAF3KDs6FVZJ21g7
         z0pw8DbAFnLwzn6u/uX/GiHooNDY1GfqvbjDWcSiqJSHNxJfesoeVUMj28YYLnr6iQ
         21to0rqNYEhI+MhoqzJnYaTiI+ZTb0UMED4ZXjwl5s5dbFBK8tZWPK267wzfamCGDl
         kthMhrjHEy/1LFEvKCObCQ+Z5HIrcVBa2OXmaGPPRtISntL6uMP/ISPcBBJPqxDz9X
         H3I5JBoXikNdg==
Message-ID: <c5573088-4bf6-e665-4921-05f57f1f4580@collabora.com>
Date:   Fri, 17 Jun 2022 12:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] mfd: mt6397: Add basic support for MT6331+MT6332
 PMIC
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>, lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, hsin-hsiung.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616091531.12646-1-angelogioacchino.delregno@collabora.com>
 <20220616091531.12646-3-angelogioacchino.delregno@collabora.com>
 <870ec36b-bc3c-377b-114a-4a9417942be2@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <870ec36b-bc3c-377b-114a-4a9417942be2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/06/22 12:12, Matthias Brugger ha scritto:
> 
> 
> On 16/06/2022 11:15, AngeloGioacchino Del Regno wrote:
>> Add support for the MT6331 PMIC with MT6332 Companion PMIC, found
>> in MT6795 Helio X10 smartphone platforms.
>>
>> This combo has support for multiple devices but, for a start,
>> only the following have been implemented:
>> - Regulators (two instances, one in MT6331, one in MT6332)
>> - RTC (MT6331)
>> - Keys (MT6331)
>> - Interrupts (MT6331 also dispatches MT6332's interrupts)
>>
>> There's more to be implemented, especially for MT6332, which
>> will come at a later stage.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/mfd/mt6397-core.c            |  47 ++
>>   drivers/mfd/mt6397-irq.c             |   9 +-
>>   include/linux/mfd/mt6331/core.h      |  53 +++
>>   include/linux/mfd/mt6331/registers.h | 584 ++++++++++++++++++++++++
>>   include/linux/mfd/mt6332/core.h      |  53 +++
>>   include/linux/mfd/mt6332/registers.h | 642 +++++++++++++++++++++++++++
>>   include/linux/mfd/mt6397/core.h      |   2 +
>>   7 files changed, 1389 insertions(+), 1 deletion(-)
>>   create mode 100644 include/linux/mfd/mt6331/core.h
>>   create mode 100644 include/linux/mfd/mt6331/registers.h
>>   create mode 100644 include/linux/mfd/mt6332/core.h
>>   create mode 100644 include/linux/mfd/mt6332/registers.h
>>
>> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
>> index 1a368ad08f58..1c974132dc0b 100644
>> --- a/drivers/mfd/mt6397-core.c
>> +++ b/drivers/mfd/mt6397-core.c
>> @@ -12,10 +12,12 @@
>>   #include <linux/regmap.h>
>>   #include <linux/mfd/core.h>
>>   #include <linux/mfd/mt6323/core.h>
>> +#include <linux/mfd/mt6331/core.h>
>>   #include <linux/mfd/mt6358/core.h>
>>   #include <linux/mfd/mt6359/core.h>
>>   #include <linux/mfd/mt6397/core.h>
>>   #include <linux/mfd/mt6323/registers.h>
>> +#include <linux/mfd/mt6331/registers.h>
>>   #include <linux/mfd/mt6358/registers.h>
>>   #include <linux/mfd/mt6359/registers.h>
>>   #include <linux/mfd/mt6397/registers.h>
>> @@ -23,6 +25,9 @@
>>   #define MT6323_RTC_BASE        0x8000
>>   #define MT6323_RTC_SIZE        0x40
>> +#define MT6331_RTC_BASE        0x4000
>> +#define MT6331_RTC_SIZE        0x40
>> +
>>   #define MT6358_RTC_BASE        0x0588
>>   #define MT6358_RTC_SIZE        0x3c
>> @@ -37,6 +42,11 @@ static const struct resource mt6323_rtc_resources[] = {
>>       DEFINE_RES_IRQ(MT6323_IRQ_STATUS_RTC),
>>   };
>> +static const struct resource mt6331_rtc_resources[] = {
>> +    DEFINE_RES_MEM(MT6331_RTC_BASE, MT6331_RTC_SIZE),
>> +    DEFINE_RES_IRQ(MT6331_IRQ_STATUS_RTC),
>> +};
>> +
>>   static const struct resource mt6358_rtc_resources[] = {
>>       DEFINE_RES_MEM(MT6358_RTC_BASE, MT6358_RTC_SIZE),
>>       DEFINE_RES_IRQ(MT6358_IRQ_RTC),
>> @@ -66,6 +76,11 @@ static const struct resource mt6323_keys_resources[] = {
>>       DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_FCHRKEY, "homekey"),
>>   };
>> +static const struct resource mt6331_keys_resources[] = {
>> +    DEFINE_RES_IRQ_NAMED(MT6331_IRQ_STATUS_PWRKEY, "powerkey"),
>> +    DEFINE_RES_IRQ_NAMED(MT6331_IRQ_STATUS_HOMEKEY, "homekey"),
>> +};
>> +
>>   static const struct resource mt6397_keys_resources[] = {
>>       DEFINE_RES_IRQ_NAMED(MT6397_IRQ_PWRKEY, "powerkey"),
>>       DEFINE_RES_IRQ_NAMED(MT6397_IRQ_HOMEKEY, "homekey"),
>> @@ -100,6 +115,27 @@ static const struct mfd_cell mt6323_devs[] = {
>>       },
>>   };
>> +/* MT6331 is always used in combination with MT6332 */
>> +static const struct mfd_cell mt6331_mt6332_devs[] = {
>> +    {
>> +        .name = "mt6331-rtc",
>> +        .num_resources = ARRAY_SIZE(mt6331_rtc_resources),
>> +        .resources = mt6331_rtc_resources,
>> +        .of_compatible = "mediatek,mt6331-rtc",
>> +    }, {
>> +        .name = "mt6331-regulator",
>> +        .of_compatible = "mediatek,mt6331-regulator"
>> +    }, {
>> +        .name = "mt6332-regulator",
>> +        .of_compatible = "mediatek,mt6332-regulator"
>> +    }, {
>> +        .name = "mtk-pmic-keys",
>> +        .num_resources = ARRAY_SIZE(mt6331_keys_resources),
>> +        .resources = mt6331_keys_resources,
>> +        .of_compatible = "mediatek,mt6331-keys"
>> +    },
>> +};
>> +
>>   static const struct mfd_cell mt6358_devs[] = {
>>       {
>>           .name = "mt6358-regulator",
>> @@ -179,6 +215,14 @@ static const struct chip_data mt6323_core = {
>>       .irq_init = mt6397_irq_init,
>>   };
>> +static const struct chip_data mt6331_mt6332_core = {
>> +    .cid_addr = MT6331_HWCID,
>> +    .cid_shift = 0,
>> +    .cells = mt6331_mt6332_devs,
>> +    .cell_size = ARRAY_SIZE(mt6331_mt6332_devs),
>> +    .irq_init = mt6397_irq_init,
>> +};
>> +
>>   static const struct chip_data mt6358_core = {
>>       .cid_addr = MT6358_SWCID,
>>       .cid_shift = 8,
>> @@ -261,6 +305,9 @@ static const struct of_device_id mt6397_of_match[] = {
>>       {
>>           .compatible = "mediatek,mt6323",
>>           .data = &mt6323_core,
>> +    }, {
>> +        .compatible = "mediatek,mt6331",
>> +        .data = &mt6331_mt6332_core,
>>       }, {
>>           .compatible = "mediatek,mt6358",
>>           .data = &mt6358_core,
>> diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
>> index 2924919da991..eff53fed8fe7 100644
>> --- a/drivers/mfd/mt6397-irq.c
>> +++ b/drivers/mfd/mt6397-irq.c
>> @@ -12,6 +12,8 @@
>>   #include <linux/suspend.h>
>>   #include <linux/mfd/mt6323/core.h>
>>   #include <linux/mfd/mt6323/registers.h>
>> +#include <linux/mfd/mt6331/core.h>
>> +#include <linux/mfd/mt6331/registers.h>
>>   #include <linux/mfd/mt6397/core.h>
>>   #include <linux/mfd/mt6397/registers.h>
>> @@ -172,7 +174,12 @@ int mt6397_irq_init(struct mt6397_chip *chip)
>>           chip->int_status[0] = MT6323_INT_STATUS0;
>>           chip->int_status[1] = MT6323_INT_STATUS1;
>>           break;
>> -
>> +    case MT6331_CHIP_ID:
> 
> I'm a bit puzzeld about the IDs of both are the same, should we at least add "case 
> MT6332_CHIP_ID:" here to make clear this holds for bot chips?
> 

There's a catch here: the MT6332 int_con/int_status registers are different and
this one does actually needs to be registered accordingly... the logic in here is
that we currently register only MT6331's interrupt controller - we will be unable
(temporarily, of course) to *manage* (mask/unmask) MT6332's interrupts (but if the
registers are configured to unmask interrupts before booting linux, these will
fire through MT6331's external interrupt line).

I didn't want to implement this for the companion because of three reasons:
   1. I need to think about a good and clean strategy for that;
   2. I don't want to push untested code upstream;
   3. I currently have *no way* to test the interrupts that the companion
      will be firing, as they're about the battery charger... and there's no
      driver for that, and implementing it is a bit complicated, I am indeed
      planning to implement that later, but for a first push of the actual
      PMIC basics, it's not really a good idea (because again, requires more
      time).

There's another interesting interrupt in MT6332, which is for the flash LED
and should be easier to implement... but still, please, not right now, as I
really don't materially have the time that's required to do that.

So that's about it - we're registering with one compatible (the one for the
"main pmic"), then whatever concerns the companion PMIC is done with some
sort companion specific flow variation (check how I've modeled this in the
mtk-pmic-wrap.c driver [1]):


[1]: 
https://lore.kernel.org/lkml/20220520124039.228314-1-angelogioacchino.delregno@collabora.com/T/#t



>> +        chip->int_con[0] = MT6331_INT_CON0;
>> +        chip->int_con[1] = MT6331_INT_CON1;
>> +        chip->int_status[0] = MT6331_INT_STATUS_CON0;
>> +        chip->int_status[1] = MT6331_INT_STATUS_CON1;
>> +        break;
>>       case MT6391_CHIP_ID:
>>       case MT6397_CHIP_ID:
>>           chip->int_con[0] = MT6397_INT_CON0;
>> diff --git a/include/linux/mfd/mt6331/core.h b/include/linux/mfd/mt6331/core.h
>> new file mode 100644
>> index 000000000000..d0fabcd53eb4
>> --- /dev/null
>> +++ b/include/linux/mfd/mt6331/core.h
>> @@ -0,0 +1,53 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2021 AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
>> + */
>> +
>> +#ifndef __MFD_MT6331_CORE_H__
>> +#define __MFD_MT6331_CORE_H__
>> +
>> +enum mt6331_irq_status_numbers {
>> +    MT6331_IRQ_STATUS_PWRKEY = 0,
>> +    MT6331_IRQ_STATUS_HOMEKEY,
>> +    MT6331_IRQ_STATUS_CHRDET,
>> +    MT6331_IRQ_STATUS_THR_H,
>> +    MT6331_IRQ_STATUS_THR_L,
>> +    MT6331_IRQ_STATUS_BAT_H,
>> +    MT6331_IRQ_STATUS_BAT_L,
>> +    MT6331_IRQ_STATUS_RTC,
>> +    MT6331_IRQ_STATUS_AUDIO,
>> +    MT6331_IRQ_STATUS_MAD,
>> +    MT6331_IRQ_STATUS_ACCDET,
>> +    MT6331_IRQ_STATUS_ACCDET_EINT,
>> +    MT6331_IRQ_STATUS_ACCDET_NEGV = 12,
>> +    MT6331_IRQ_STATUS_VDVFS11_OC = 16,
>> +    MT6331_IRQ_STATUS_VDVFS12_OC,
>> +    MT6331_IRQ_STATUS_VDVFS13_OC,
>> +    MT6331_IRQ_STATUS_VDVFS14_OC,
>> +    MT6331_IRQ_STATUS_GPU_OC,
>> +    MT6331_IRQ_STATUS_VCORE1_OC,
>> +    MT6331_IRQ_STATUS_VCORE2_OC,
>> +    MT6331_IRQ_STATUS_VIO18_OC,
>> +    MT6331_IRQ_STATUS_LDO_OC,
>> +    MT6331_IRQ_STATUS_NR,
>> +};
>> +
>> +#define MT6331_IRQ_CON0_BASE    MT6331_IRQ_STATUS_PWRKEY
>> +#define MT6331_IRQ_CON0_BITS    (MT6331_IRQ_STATUS_ACCDET_NEGV + 1)
>> +#define MT6331_IRQ_CON1_BASE    MT6331_IRQ_STATUS_VDVFS11_OC
>> +#define MT6331_IRQ_CON1_BITS    (MT6331_IRQ_STATUS_LDO_OC - 
>> MT6331_IRQ_STATUS_VDFS11_OC + 1)
>> +
>> +#define MT6331_INT_GEN(sp)                \
>> +{                            \
>> +    .hwirq_base = MT6331_IRQ_##sp##_BASE,        \
>> +    .num_int_regs =                    \
>> +        ((MT6331_IRQ_##sp##_BITS - 1) /        \
>> +        MTK_PMIC_REG_WIDTH) + 1,        \
>> +    .en_reg = MT6331_INT_##sp##,            \
>> +    .en_reg_shift = 0x6,                \
>> +    .sta_reg = MT6331_INT_STATUS0_##sp##,        \
>> +    .sta_reg_shift = 0x2,                \
>> +    .top_offset = MT6331_##sp##_TOP,        \
>> +}
> 
> What will we need this macro for? It's not used here.
> 

Thanks for catching that!!!!

This is a leftover, we don't need it at all and we will probably never need
it, and it's the same for the 6332 one.

Will send a new one that removes these useless macros asap.

Cheers,
Angelo
