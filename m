Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70F6577D85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiGRI37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiGRI3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:29:49 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50837DF97
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:29:48 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz9PqGdVipG8mAA--.33224S3;
        Mon, 18 Jul 2022 16:29:30 +0800 (CST)
Subject: Re: [PATCH V15 00/15] irqchip: Add LoongArch-related irqchip drivers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
 <87less52bx.wl-maz@kernel.org>
 <6e9def1e-31fe-787d-1b2b-a328424352f0@loongson.cn>
 <87ilnw3vlg.wl-maz@kernel.org>
 <20994a99-b5b1-442d-d23d-2a11ecef24a0@loongson.cn>
 <87wncbzteg.wl-maz@kernel.org>
 <058aed14-3644-5fc4-8eda-ec645df91836@loongson.cn>
 <87fsiy53h3.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <6d534d7d-766c-d5d1-59ed-1ecdd96837be@loongson.cn>
Date:   Mon, 18 Jul 2022 16:29:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87fsiy53h3.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxz9PqGdVipG8mAA--.33224S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr13trW3GrykGrykGry8Xwb_yoW8tr45pF
        WagFyYyF4qyFyrAwnrtan0qa1FyrWfJ3ykXrnI93y8Aas8twnrXr1aya1j9Fy7uF1Ikw4j
        vrWIg34fuF1DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svP
        MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/18 下午2:39, Marc Zyngier wrote:
> On Mon, 18 Jul 2022 02:07:21 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>>
>>
>> On 2022/7/17 下午10:49, Marc Zyngier wrote:
>>> On Sun, 17 Jul 2022 12:29:05 +0100,
>>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2022/7/17 下午6:02, Marc Zyngier wrote:
>>>>> But the other issue is that you seem to call this function from two
>>>>> different locations. This cannot be right, as there should be only one
>>>>> probe order, and not multiple.
>>>>>
>>>>
>>>> As we described two IRQ models(Legacy and Extended) in this cover
>>>> letter, the parent domain of MSI domain can be htvec domain(Legacy) or
>>>> eiointc domain(Extended). In MADT, only one APIC(HTPIC for htvec or
>>>> EIOPIC for eiointc) is allowed to pass into kernel, and then in the
>>>> irqchip driver, only one kind APIC of them can be parsed from MADT, so
>>>> we have to support two probe order for them.
>>>
>>> Do you really have the two variants in the wild? Or is this just
>>> because this is a possibility?
>>>
>>
>> Currently, there are not CPUs(used for PC and server) based on
>> LoongArch shipped with only HTPIC, but with both HTPIC and EIOPIC, we
>> just want to provide two choices for designers(but obviously, EIOPIC
>> may be enough currently). Do you think we don't have to do like this,
>> yes? If so, maybe we don't have to support ACPI-way entry for htvec
>> currently, and do the work in future if required.
> 
> If the existing HW is only following the 'Extended' model, then I'd
> suggest you only support this for now. It has two effects:
> 
> - it simplifies the current code, making it more maintainable and
>    easier to reason about
> 
> - it sends the message to integrators that 'Extended' is the correct
>    model, and that it is what they should support
> 
> Now, we don't have much time left to get this series into -next (I
> will be closing the tree to new features this week, and only queue
> fixes).
> 
> So whatever you need to do, please do it quickly so that we can have
> at least some of this in 5.20.
> 
> Thanks,
> 
> 	M.
> 

Ok, Marc, thanks for your suggestion, got it, I'll remove 'Legacy' mode 
support and send next version as soon as possible.

