Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC38B55D023
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbiF1Ipz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbiF1Ipp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:45:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DE492D1FA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:45:17 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf9iRv7piQUJhAA--.10467S3;
        Tue, 28 Jun 2022 16:45:06 +0800 (CST)
Subject: Re: [PATCH V12 01/10] APCI: irq: Add support for multiple GSI domains
To:     Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1655273250-23495-1-git-send-email-lvjianmin@loongson.cn>
 <1655273250-23495-2-git-send-email-lvjianmin@loongson.cn>
 <87k09ipfe2.wl-maz@kernel.org>
 <0247b7d5-aca9-5db1-e712-4783ee672110@loongson.cn>
 <87fsk2p8b5.wl-maz@kernel.org>
 <ae3e0bc7-67c3-8f05-d3ba-98cab9b75117@huawei.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <80e06104-718f-01b5-91ce-a51c7151dde8@loongson.cn>
Date:   Tue, 28 Jun 2022 16:45:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ae3e0bc7-67c3-8f05-d3ba-98cab9b75117@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxf9iRv7piQUJhAA--.10467S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGryfAF1DGrW5Xr43uF17KFg_yoW7JF15pF
        WktF15ArWUJr10qr10ga1YgFyakr1Uta48Xr1rJa47Aw4qgF1SgF47Xryj9FyDJr4rCr4j
        qr15tFZ7uFnrArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/28 下午3:42, Hanjun Guo wrote:
> On 2022/6/18 18:36, Marc Zyngier wrote:
> [...]
>>>>> --- a/drivers/acpi/irq.c
>>>>> +++ b/drivers/acpi/irq.c
>>>>> @@ -12,7 +12,7 @@
>>>>>      enum acpi_irq_model_id acpi_irq_model;
>>>>>    -static struct fwnode_handle *acpi_gsi_domain_id;
>>>>> +static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
>>>>>      /**
>>>>>     * acpi_gsi_to_irq() - Retrieve the linux irq number for a given 
>>>>> GSI
>>>>> @@ -26,10 +26,7 @@
>>>>>     */
>>>>>    int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>>>>    {
>>>>> -    struct irq_domain *d = 
>>>>> irq_find_matching_fwnode(acpi_gsi_domain_id,
>>>>> -                            DOMAIN_BUS_ANY);
>>>>> -
>>>>> -    *irq = irq_find_mapping(d, gsi);
>>>>> +    *irq = acpi_register_gsi(NULL, gsi, -1, -1);
>>>>
>>>> What is this?
>>>>
>>>> - This wasn't part of my initial patch, and randomly changing patches
>>>>     without mentioning it isn't acceptable
>>>>
>>>> - you *cannot* trigger a registration here, as this isn't what the API
>>>>     advertises
>>>>
>>>> - what makes you think that passing random values (NULL, -1... )to
>>>>     acpi_register_gsi() is an acceptable thing to do?
>>>>
>>>> The original patch had:
>>>>
>>>> @@ -26,8 +26,10 @@ static struct fwnode_handle *acpi_gsi_domain_id;
>>>>      */
>>>>     int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>>>     {
>>>> -    struct irq_domain *d = 
>>>> irq_find_matching_fwnode(acpi_gsi_domain_id,
>>>> -                            DOMAIN_BUS_ANY);
>>>> +    struct irq_domain *d;
>>>> +
>>>> +    d = irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
>>>> +                     DOMAIN_BUS_ANY);
>>>>           *irq = irq_find_mapping(d, gsi);
>>>>         /*
>>>>
>>>> and I don't think it needs anything else. If something breaks, let's
>>>> discuss it, but don't abuse the API nor the fact that I usually don't
>>>> review my own patches to sneak things in...
>>>>
>>>
>>> Sorry, Marc, I don't know how to communicate with you for my change
>>> here before submitting the patch, maybe I should mention it in the
>>> patch commit or code.
>>
>> It should at least be discussed first, like you are doing it here.
>>
>>> When I use the patch, I found that acpi_gsi_to_irq in driver/acpi/irq.c
>>> only handle existed mapping and will return -EINVAL if mapping not
>>> found. When I test on my machine, a calling stack is as following:
>>>
>>>
>>> acpi_bus_init
>>> ->acpi_enable_subsystem
>>>    ->acpi_ev_install_xrupt_handlers
>>>      ->acpi_ev_install_sci_handler
>>>        ->acpi_os_install_interrupt_handler
>>>          ->acpi_gsi_to_irq
>>>
>>>
>>> the acpi_gsi_to_irq returned -EINVAL because of no mapping found. I
>>> looked into acpi_gsi_to_irq of x86, acpi_register_gsi is called in it
>>> so that new mapping for gsi is created if no mapping is found.
>>
>> So it looks like we have a discrepancy between the x86 and ARM on that
>> front.
>>
>> Lorenzo, Hanjun, can you please have a look at this and shed some
>> light on what the expected behaviour is? It looks like we never
>> encountered an issue with this on arm64, which tends to indicate that
>> we don't usually use the above path.
> 
> Sorry for the late reply, I just noticed this tomorrow.
> 
> As you said, we never encountered Jianmin's issue on ARM64 hardware,
> for the call stack which Jianmin shows, acpi_ev_install_xrupt_handlers()
> is only called for non-reduced ACPI hardware, but ARM64 is always
> defined as reduced ACPI hardware in the ACPI spec, from the first
> supported version of ACPI spec for ARM.
> 
> Jianmin, is the LoongArch using the redunced hardware mode in ACPI?
> if it's using SCI interrupt, I think not, correct me if I'm wrong.
> 

Thanks for your reply, Hanjun, LoongArch uses non-reduced ACPI hardware,
so SCI interrupt is used, which is different from ARM using reduced 
hardware.

>>
>>> I looked into generic acpi_register_gsi, the existed mapping will be
>>> checked first by calling irq_find_mapping, so I think calling
>>> acpi_register_gsi in acpi_gsi_to_irq can address the problem.
>>>
>>> But you're right, I'm wrong that I passed random value of -1 to
>>> acpi_register_gsi. I don't find a right way to address the problem
>>> without changing acpi_gsi_to_irq. I'll continue to work for the
>>> problem.
>>
>> At the very least, this should be indirected so that the existing
>> behaviour isn't affected, no matter how badly broken arm64 may or may
>> not be here. Please have a look at the patch below that should help
>> you with this.
> 
> Looks good to me, I will review and test the v13 patch set.
> 
> Thanks
> Hanjun

