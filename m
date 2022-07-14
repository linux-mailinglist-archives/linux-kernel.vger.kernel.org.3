Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB05749F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiGNKDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiGNKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:03:07 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F6F950066
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:03:05 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_9LO6c9iMN8dAA--.22168S3;
        Thu, 14 Jul 2022 18:02:55 +0800 (CST)
Subject: Re: [PATCH V14 14/15] irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC
 for LoongArch
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
 <1656837932-18257-15-git-send-email-lvjianmin@loongson.cn>
 <87y1x5krjd.wl-maz@kernel.org>
 <f76927be-8c8c-5bbe-ef5c-a63f4a09b29c@loongson.cn>
Message-ID: <bfbd08d6-6f09-3ddb-0fdf-8c459352cf0f@loongson.cn>
Date:   Thu, 14 Jul 2022 18:02:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f76927be-8c8c-5bbe-ef5c-a63f4a09b29c@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx_9LO6c9iMN8dAA--.22168S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWry5Zr1ktrWxWr4fKr1xKrg_yoW5Xw4kpF
        4vkFy5ArWUJw1xXry7Ww1Uury5Za4ftayjqF1fJ3ZrAr4DGrnFgFyUWryq9FWUCr48Gw1j
        vr15tF47uFn8AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svP
        MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/8 上午11:17, Jianmin Lv wrote:
> 
> 
> On 2022/7/7 下午8:59, Marc Zyngier wrote:
>> On Sun, 03 Jul 2022 09:45:31 +0100,
>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>>
>>> For LoongArch, ACPI_IRQ_MODEL_LPIC is introduced, and then the
>>> callback acpi_get_gsi_domain_id and acpi_gsi_to_irq_fallback are
>>> implemented.
>>>
>>> The acpi_get_gsi_domain_id callback returns related fwnode handle
>>> of irqdomain for different GSI range.
>>>
>>> The acpi_gsi_to_irq_fallback will create new mapping for gsi when
>>> the mapping of it is not found.
>>>
>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>> ---
>>>   drivers/acpi/bus.c                  |  3 +++
>>>   drivers/irqchip/irq-loongarch-cpu.c | 37 
>>> +++++++++++++++++++++++++++++++++++++
>>>   include/linux/acpi.h                |  1 +
>>>   3 files changed, 41 insertions(+)
>>>
>>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>>> index 86fa61a..63fbf00 100644
>>> --- a/drivers/acpi/bus.c
>>> +++ b/drivers/acpi/bus.c
>>> @@ -1145,6 +1145,9 @@ static int __init acpi_bus_init_irq(void)
>>>       case ACPI_IRQ_MODEL_PLATFORM:
>>>           message = "platform specific model";
>>>           break;
>>> +    case ACPI_IRQ_MODEL_LPIC:
>>> +        message = "LPIC";
>>> +        break;
>>>       default:
>>>           pr_info("Unknown interrupt routing model\n");
>>>           return -ENODEV;
>>> diff --git a/drivers/irqchip/irq-loongarch-cpu.c 
>>> b/drivers/irqchip/irq-loongarch-cpu.c
>>> index c2f7411..1b241d7 100644
>>> --- a/drivers/irqchip/irq-loongarch-cpu.c
>>> +++ b/drivers/irqchip/irq-loongarch-cpu.c
>>> @@ -15,6 +15,41 @@
>>>   static struct irq_domain *irq_domain;
>>> +static int lpic_gsi_to_irq(u32 gsi)
>>> +{
>>> +    /* Only pch irqdomain transferring is required for LoongArch. */
>>> +    if (gsi >= GSI_MIN_PCH_IRQ && gsi <= GSI_MAX_PCH_IRQ)
>>> +        return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, 
>>> ACPI_ACTIVE_HIGH);
>>> +    return -1;
>>
>> The expected return value on failure is 0 (which indicates that no
>> interrupt was mapped). Here, things will break as acpi_gsi_to_irq()
>> stores the result as unsigned, and compares the result to 0.
>>
> 
> Ok, thanks, I'll change the return value to 0 on failure and change 
> return type to unsigned int.
> 
> 

Hi, Marc, if the return type is changed to unsigned int, the return type 
of the fallback handler in the patch:
ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback

should be changed to unsigned int too, yes?

>>     M.
>>

