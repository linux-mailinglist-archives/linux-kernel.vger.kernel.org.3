Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245B6542BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiFHJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiFHJcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:32:39 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E01E5931B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:56:12 -0700 (PDT)
Received: from [10.20.42.13] (unknown [10.20.42.13])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx708eZKBiqoIsAA--.5557S3;
        Wed, 08 Jun 2022 16:55:58 +0800 (CST)
Subject: Re: [PATCH RFC V2 02/10] irqchip: Add LoongArch CPU interrupt
 controller support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1653649335-11998-1-git-send-email-lvjianmin@loongson.cn>
 <1653649335-11998-3-git-send-email-lvjianmin@loongson.cn>
 <87bkvf56wg.wl-maz@kernel.org>
 <64990891.8322.18119c6d212.Coremail.lvjianmin@loongson.cn>
 <87a6ax6c0n.wl-maz@kernel.org>
 <1c7b1ee5-3f1e-c090-fb2e-65741de76a9f@loongson.cn>
 <871qw25ctt.wl-maz@kernel.org>
 <0c6b88f8-c100-4068-5370-c30e95365b3c@loongson.cn>
 <87tu8xyn9n.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <271863fe-ffa0-af5e-22f6-d1e8e89d91ae@loongson.cn>
Date:   Wed, 8 Jun 2022 16:55:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87tu8xyn9n.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx708eZKBiqoIsAA--.5557S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KryrAry7GFWkAw4UZFWxXrb_yoW5Jr4rpa
        97Ja42krW8tr18uFWxKFWFqFyYyr1Sy348Xr1rGa47Wrn8u34agF12gr1j9Fy7urZ5KF4j
        vrWxZayxuF1DCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUq38nUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/7 下午2:56, Marc Zyngier wrote:
> On Tue, 07 Jun 2022 04:41:22 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>>
>> On 2022/6/6 下午6:02, Marc Zyngier wrote:
>>> + Lorenzo and Hanjun who maintain the ACPI irq code
>>>
>>> On Thu, 02 Jun 2022 04:16:30 +0100,
>>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
> 
> [...]
> 
>>>> I'm so sorry, I really don't find a way to reuse driver/acpi/irq.c
>>>> after my humble work.
>>> I don't think reimplementing ACPI is the solution. What could be a
>>> reasonable approach is a way to overload the retrieval of the
>>> acpi_gsi_domain_id fwnode with a GSI parameter.
>>>
>>> I hacked the following patch, which will give you an idea of what I
>>> have in mind (only compile-tested).
>>
>>
>> Hi, Marc, thanks so much for your patch. I have verified it on my
>> LoongArch machine and it works well.
>>
>>
>> BTW, in acpi_get_irq_source_fwhandle(), maybe
>> acpi_get_gsi_domain_id(ctx->index) is needed to changed to
>> acpi_get_gsi_domain_id(irq->interrupts[ctx->index])?
> 
> Yes, absolutely. Thanks for spotting it.
> 
>> I have another question, for LoongArch, acpi_isa_irq_to_gsi is
>> required to implemente, but no common version, do we need to
>> implemente an weak version in driver/acpi/irq.c as following?
>>
>>
>> int __weak acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
>> {
>>          if (gsi)
>>                  *gsi = isa_irq;
>>          return 0;
>> }
> 
> Do you actually have CONFIG_ISA? In 2022? For a brand new architecture?
> 
> If you really have to, then this needs to be a bit more involved:
> 
> #ifdef CONFIG_ISA
> int __weak acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
> {
> 	if (irq < nr_legacy_irqs()) {
> 		*gsi = isa_irq;
> 		return 0;
> 	}
> 
> 	return -1;
> }
> #endif
> 
> But I'd rather you get rid of any such legacy if this can be avoided.
> 

Thanks for your suggestion, I have confirmed that we don't need 
CONFIT_ISA for LoongArch, so acpi_isa_irq_to_gsi is not needed either.

>> I'll use the way you provided here to reuse driver/acpi/irq.c in next
>> version. How should I do next? Should I integrate your patch into my
>> next version or wait for you to merge it first?
> 
> Please pick up the patch (with the above fix), and use it as a prefix
> to your series. It needs to be reviewed by the relevant maintainers
> anyway.
> 

Ok, thanks, I'll add relevant maintainers to review for next version.

> Thanks,
> 
> 	M.
> 

