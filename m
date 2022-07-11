Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15655E1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiF0IAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiF0IAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:00:39 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB478DB1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:00:37 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb02bY7liSsRfAA--.44295S3;
        Mon, 27 Jun 2022 16:00:27 +0800 (CST)
Subject: Re: [PATCH V12 01/10] APCI: irq: Add support for multiple GSI domains
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1655273250-23495-1-git-send-email-lvjianmin@loongson.cn>
 <1655273250-23495-2-git-send-email-lvjianmin@loongson.cn>
 <87k09ipfe2.wl-maz@kernel.org>
 <0247b7d5-aca9-5db1-e712-4783ee672110@loongson.cn>
 <87fsk2p8b5.wl-maz@kernel.org>
 <d7bc898d-187c-7cb5-73c5-ab28602548ca@loongson.cn>
 <87czeu36jw.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <b5089477-11a3-a013-79cf-0826809d778a@loongson.cn>
Date:   Mon, 27 Jun 2022 16:00:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87czeu36jw.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxb02bY7liSsRfAA--.44295S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4xXrW7AFyrtry5Gr4DArb_yoWfGr18pF
        WxK3W3CF40qr17Zry2g3WYgFyak34rtrW8XF4UJ347Ar1qkF1fKrnrWryj9FyDZr45Cr4j
        vr1UKFWxWF1DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU901xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svP
        MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/27 下午3:32, Marc Zyngier wrote:
> On Sat, 25 Jun 2022 10:34:34 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>>
>>
>> On 2022/6/18 下午6:36, Marc Zyngier wrote:
>>> On Wed, 15 Jun 2022 10:28:47 +0100,
>>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2022/6/15 下午3:14, Marc Zyngier wrote:
>>>>> On Wed, 15 Jun 2022 07:07:21 +0100,
>>>>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>>>>>
>>>>>> From: Marc Zyngier <maz@kernel.org>
>>>>>>
>>>>>> In an unfortunate departure from the ACPI spec, the LoongArch
>>>>>> architecture split its GSI space across multiple interrupt
>>>>>> controllers.
>>>>>>
>>>>>> In order to be able to reuse sthe core code and prevent
>>>>>> architectures from reinventing an already square wheel, offer
>>>>>> the arch code the ability to register a dispatcher function
>>>>>> that will return the domain fwnode for a given GSI.
>>>>>>
>>>>>> The ARM GIC drivers are updated to support this (with a single
>>>>>> domain, as intended).
>>>>>>
>>>>>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>>>
>>>>> I don't think this tag is appropriate here.
>>>>>
>>>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>>>> Cc: Hanjun Guo <guohanjun@huawei.com>
>>>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>>>> ---
>>>>>>     drivers/acpi/irq.c           | 40 +++++++++++++++++++++++-----------------
>>>>>>     drivers/irqchip/irq-gic-v3.c | 18 ++++++++++++------
>>>>>>     drivers/irqchip/irq-gic.c    | 18 ++++++++++++------
>>>>>>     include/linux/acpi.h         |  2 +-
>>>>>>     4 files changed, 48 insertions(+), 30 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
>>>>>> index c68e694..b7460ab 100644
>>>>>> --- a/drivers/acpi/irq.c
>>>>>> +++ b/drivers/acpi/irq.c
>>>>>> @@ -12,7 +12,7 @@
>>>>>>       enum acpi_irq_model_id acpi_irq_model;
>>>>>>     -static struct fwnode_handle *acpi_gsi_domain_id;
>>>>>> +static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
>>>>>>       /**
>>>>>>      * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
>>>>>> @@ -26,10 +26,7 @@
>>>>>>      */
>>>>>>     int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>>>>>     {
>>>>>> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
>>>>>> -							DOMAIN_BUS_ANY);
>>>>>> -
>>>>>> -	*irq = irq_find_mapping(d, gsi);
>>>>>> +	*irq = acpi_register_gsi(NULL, gsi, -1, -1);
>>>>>
>>>>> What is this?
>>>>>
>>>>> - This wasn't part of my initial patch, and randomly changing patches
>>>>>      without mentioning it isn't acceptable
>>>>>
>>>>> - you *cannot* trigger a registration here, as this isn't what the API
>>>>>      advertises
>>>>>
>>>>> - what makes you think that passing random values (NULL, -1... )to
>>>>>      acpi_register_gsi() is an acceptable thing to do?
>>>>>
>>>>> The original patch had:
>>>>>
>>>>> @@ -26,8 +26,10 @@ static struct fwnode_handle *acpi_gsi_domain_id;
>>>>>       */
>>>>>      int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>>>>      {
>>>>> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
>>>>> -							DOMAIN_BUS_ANY);
>>>>> +	struct irq_domain *d;
>>>>> +
>>>>> +	d = irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
>>>>> +				     DOMAIN_BUS_ANY);
>>>>>        	*irq = irq_find_mapping(d, gsi);
>>>>>      	/*
>>>>>
>>>>> and I don't think it needs anything else. If something breaks, let's
>>>>> discuss it, but don't abuse the API nor the fact that I usually don't
>>>>> review my own patches to sneak things in...
>>>>>
>>>>
>>>> Sorry, Marc, I don't know how to communicate with you for my change
>>>> here before submitting the patch, maybe I should mention it in the
>>>> patch commit or code.
>>>
>>> It should at least be discussed first, like you are doing it here.
>>>
>>>> When I use the patch, I found that acpi_gsi_to_irq in driver/acpi/irq.c
>>>> only handle existed mapping and will return -EINVAL if mapping not
>>>> found. When I test on my machine, a calling stack is as following:
>>>>
>>>>
>>>> acpi_bus_init
>>>> ->acpi_enable_subsystem
>>>>     ->acpi_ev_install_xrupt_handlers
>>>>       ->acpi_ev_install_sci_handler
>>>>         ->acpi_os_install_interrupt_handler
>>>>           ->acpi_gsi_to_irq
>>>>
>>>>
>>>> the acpi_gsi_to_irq returned -EINVAL because of no mapping found. I
>>>> looked into acpi_gsi_to_irq of x86, acpi_register_gsi is called in it
>>>> so that new mapping for gsi is created if no mapping is found.
>>>
>>> So it looks like we have a discrepancy between the x86 and ARM on that
>>> front.
>>>
>>> Lorenzo, Hanjun, can you please have a look at this and shed some
>>> light on what the expected behaviour is? It looks like we never
>>> encountered an issue with this on arm64, which tends to indicate that
>>> we don't usually use the above path.
>>>
>>>> I looked into generic acpi_register_gsi, the existed mapping will be
>>>> checked first by calling irq_find_mapping, so I think calling
>>>> acpi_register_gsi in acpi_gsi_to_irq can address the problem.
>>>>
>>>> But you're right, I'm wrong that I passed random value of -1 to
>>>> acpi_register_gsi. I don't find a right way to address the problem
>>>> without changing acpi_gsi_to_irq. I'll continue to work for the
>>>> problem.
>>>
>>> At the very least, this should be indirected so that the existing
>>> behaviour isn't affected, no matter how badly broken arm64 may or may
>>> not be here. Please have a look at the patch below that should help
>>> you with this.
>>>
>>> Thanks,
>>>
>>> 	M.
>>>
>>>   From 3e6b87ea49473d0eb384f42e76d584a1495a538c Mon Sep 17 00:00:00 2001
>>> From: Marc Zyngier <maz@kernel.org>
>>> Date: Sat, 18 Jun 2022 11:29:33 +0100
>>> Subject: [PATCH] ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific
>>>    fallback
>>>
>>> It appears that the generic version of acpi_gsi_to_irq() doesn't
>>> fallback to establishing a mapping if there is no pre-existing
>>> one while the x86 version does.
>>>
>>> While arm64 seems unaffected by it, LoongArch is relying on the x86
>>> behaviour. In an effort to prevent new architectures from reinventing
>>> the proverbial wheel, provide an optional callback that the arch code
>>> can set to restore the x86 behaviour.
>>>
>>> Hopefully we can eventually get rid of this in the future once
>>> the expected behaviour has been clarified.
>>>
>>> Reported-by: Jianmin Lv <lvjianmin@loongson.cn>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>    drivers/acpi/irq.c   | 8 ++++++--
>>>    include/linux/acpi.h | 1 +
>>>    2 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
>>> index 6e1633ac1756..66c5f01995d0 100644
>>> --- a/drivers/acpi/irq.c
>>> +++ b/drivers/acpi/irq.c
>>> @@ -13,6 +13,7 @@
>>>    enum acpi_irq_model_id acpi_irq_model;
>>>      static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
>>> +static int (*acpi_gsi_to_irq_fallback)(u32 gsi);
>>>      /**
>>>     * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
>>> @@ -33,9 +34,12 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>>      	*irq = irq_find_mapping(d, gsi);
>>>    	/*
>>> -	 * *irq == 0 means no mapping, that should
>>> -	 * be reported as a failure
>>> +	 * *irq == 0 means no mapping, that should be reported as a
>>> +	 * failure, unless there is an arch-specific fallback handler.
>>>    	 */
>>> +	if (!*irq && acpi_gsi_to_irq_fallback)
>>> +		*irq = acpi_gsi_to_irq_fallback(gsi);
>>> +
>>>    	return (*irq > 0) ? 0 : -EINVAL;
>>>    }
>>>    EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>> index 957e23f727ea..71d3719e3ec4 100644
>>> --- a/include/linux/acpi.h
>>> +++ b/include/linux/acpi.h
>>> @@ -357,6 +357,7 @@ int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
>>>      void acpi_set_irq_model(enum acpi_irq_model_id model,
>>>    			struct fwnode_handle *(*)(u32));
>>> +void acpi_set_gsi_to_irq_fallback(int (*)(u32));
>>>    
>>
>> Hi, Marc
>>
>> I want to make sure that if acpi_set_gsi_to_irq_fallback should be
>> implemented in driver/acpi/irq.c as acpi_set_irq_model, e.g.:
>>
>> void __init acpi_set_gsi_to_irq_fallback(int (*fn)(u32))
>> {
>> 	acpi_gsi_to_irq_fallback = fn;
>> }
>>
>> And then, arch related code can call acpi_set_gsi_to_irq_fallback
>> to register a callback.
> 
> Yes. I had something like that, but forgot to add it to the patch,
> apparently.
> 

Ok, I'll add that to the patch, please check the change in next version.

> 	M.
> 

