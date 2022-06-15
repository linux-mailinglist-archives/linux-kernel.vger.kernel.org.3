Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1DE54C4ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbiFOJn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346900AbiFOJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:43:27 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3113A4348C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:43:25 -0700 (PDT)
Received: from [10.20.42.13] (unknown [10.20.42.13])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj96zqaliPYFDAA--.6230S3;
        Wed, 15 Jun 2022 17:43:16 +0800 (CST)
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
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <5ca8542e-060e-bdd5-ee5b-f5a9ca6bbb3a@loongson.cn>
Date:   Wed, 15 Jun 2022 17:43:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87k09ipfe2.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxj96zqaliPYFDAA--.6230S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZry8XFyDJF1kCw1xWF47XFb_yoW5AF15pF
        WfG3Wa9r4jqr1xWa13K34Y9Fyakas5t3y8Xr4fJ3srAr1DuF9akF10gFyFkFyDZFy3Gr42
        vF1UtF4kuF1qyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
        W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svPMxAIw28I
        cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/15 下午3:14, Marc Zyngier wrote:
> On Wed, 15 Jun 2022 07:07:21 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Marc Zyngier <maz@kernel.org>
>>
>> In an unfortunate departure from the ACPI spec, the LoongArch
>> architecture split its GSI space across multiple interrupt
>> controllers.
>>
>> In order to be able to reuse sthe core code and prevent
>> architectures from reinventing an already square wheel, offer
>> the arch code the ability to register a dispatcher function
>> that will return the domain fwnode for a given GSI.
>>
>> The ARM GIC drivers are updated to support this (with a single
>> domain, as intended).
>>
>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
> 
> I don't think this tag is appropriate here.
> 

Ok, I'll drop it.

>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Cc: Hanjun Guo <guohanjun@huawei.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   drivers/acpi/irq.c           | 40 +++++++++++++++++++++++-----------------
>>   drivers/irqchip/irq-gic-v3.c | 18 ++++++++++++------
>>   drivers/irqchip/irq-gic.c    | 18 ++++++++++++------
>>   include/linux/acpi.h         |  2 +-
>>   4 files changed, 48 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
>> index c68e694..b7460ab 100644
>> --- a/drivers/acpi/irq.c
>> +++ b/drivers/acpi/irq.c
>> @@ -12,7 +12,7 @@
>>   
>>   enum acpi_irq_model_id acpi_irq_model;
>>   
>> -static struct fwnode_handle *acpi_gsi_domain_id;
>> +static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
>>   
>>   /**
>>    * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
>> @@ -26,10 +26,7 @@
>>    */
>>   int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>   {
>> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
>> -							DOMAIN_BUS_ANY);
>> -
>> -	*irq = irq_find_mapping(d, gsi);
>> +	*irq = acpi_register_gsi(NULL, gsi, -1, -1);
> 
> What is this?
> 
> - This wasn't part of my initial patch, and randomly changing patches
>    without mentioning it isn't acceptable
> 
> - you *cannot* trigger a registration here, as this isn't what the API
>    advertises
> 
> - what makes you think that passing random values (NULL, -1... )to
>    acpi_register_gsi() is an acceptable thing to do?
> 
> The original patch had:
> 
> @@ -26,8 +26,10 @@ static struct fwnode_handle *acpi_gsi_domain_id;
>     */
>    int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>    {
> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> -							DOMAIN_BUS_ANY);
> +	struct irq_domain *d;
> +
> +	d = irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
> +				     DOMAIN_BUS_ANY);
>      	*irq = irq_find_mapping(d, gsi);
>    	/*
> 
> and I don't think it needs anything else. If something breaks, let's
> discuss it, but don't abuse the API nor the fact that I usually don't
> review my own patches to sneak things in...
> 
> 	M.
> 

