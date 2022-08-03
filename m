Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572BC588BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiHCL7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiHCL7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:59:10 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D4DE52FFE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:59:08 -0700 (PDT)
Received: from [10.20.42.22] (unknown [10.20.42.22])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxCs3+YupiflwDAA--.1278S3;
        Wed, 03 Aug 2022 19:58:54 +0800 (CST)
Subject: Re: [PATCH 1/2] irqchip/loongson-eiointc: Check hwirq overflow
To:     Huacai Chen <chenhuacai@gmail.com>, Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220803042728.3230346-1-chenhuacai@loongson.cn>
 <87r11xbxox.wl-maz@kernel.org>
 <CAAhV-H5d20zj+vnrEYRYW1h7FwRJpGYtJDc1q4hRdPh3KbXruw@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <97d33f58-6a15-3a94-f9c0-42ebd48cf562@loongson.cn>
Date:   Wed, 3 Aug 2022 19:58:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5d20zj+vnrEYRYW1h7FwRJpGYtJDc1q4hRdPh3KbXruw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxCs3+YupiflwDAA--.1278S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr17CFWkWr18JFWfJF1UZFb_yoW5JFW8pF
        WUGayjvF48J34UAr9Fgr1DXFyYy3y3tFyxKay3K3srZr98Ar1DKF1kZFn8uF1kCrWxGFnF
        vF4jgFs7uF1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU901xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/3 下午3:33, Huacai Chen wrote:
> Hi, Jianmin,
> 
> On Wed, Aug 3, 2022 at 3:20 PM Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Wed, 03 Aug 2022 05:27:27 +0100,
>> Huacai Chen <chenhuacai@loongson.cn> wrote:
>>>
>>> Check hwirq overflow when allocate irq in eiointc domain.
>>>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>>   drivers/irqchip/irq-loongson-eiointc.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
>>> index 80d8ca6f2d46..f8060e58ee06 100644
>>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>>> @@ -241,8 +241,11 @@ static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>>        struct eiointc *priv = domain->host_data;
>>>
>>>        ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
>>> -     if (ret)
>>> -             return ret;
>>> +     if (ret < 0)
>>> +             return -EINVAL;
>>> +
>>> +     if (hwirq >= IOCSR_EXTIOI_VECTOR_NUM)
>>> +             return -EINVAL;
>>
>> How can this happen? Also, you're allocating a *range*. Surely the
>> upper boundary should matter too?
> Do you know the exact reason? Please give some information, thanks.
> 

In our internal repo, we don't have middle domain in pch-msi driver, so 
no check for hwirq as in alloc of middle domain. When hwirq is assigned 
failed(negtive value), the wrong hwirq will be passed to parent 
domain(eio domain)'s alloc, so we add check in eio domain's alloc there.


But here, it seems that the check is unnecessary, because in pch-msi driver:

static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
                                            unsigned int virq,
                                            unsigned int nr_irqs, void 
*args)
{
         struct pch_msi_data *priv = domain->host_data;
         int hwirq, err, i;


         hwirq = pch_msi_allocate_hwirq(priv, nr_irqs);
         if (hwirq < 0)
                 return hwirq;


         for (i = 0; i < nr_irqs; i++) {
                 err = pch_msi_parent_domain_alloc(domain, virq + i, 
hwirq + i);
                 [...]


If pch_msi_allocate_hwirq failed, pch_msi_middle_domain_alloc will 
return, and pch_msi_parent_domain_alloc(will call eio domain's alloc) 
will not be called.


>>
>> And for the umpteenth time, please add a cover letter when sending
>> multiple patches. This is a hard requirement for me.
> OK, I will add a cover letter, even for simple fix patches. Sorry.
> 
> Huacai
>>
>> Thanks,
>>
>>          M.
>>
>> --
>> Without deviation from the norm, progress is not possible.

