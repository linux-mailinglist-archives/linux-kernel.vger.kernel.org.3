Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577CF56B287
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiGHGIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbiGHGIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:08:22 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81CC82CC89
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:08:21 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxaeDLycdiTL8QAA--.39984S3;
        Fri, 08 Jul 2022 14:08:11 +0800 (CST)
Subject: Re: [PATCH V14 13/15] irqchip: Add LoongArch CPU interrupt controller
 support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
 <1656837932-18257-14-git-send-email-lvjianmin@loongson.cn>
 <871quxm6rp.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <1a993c4e-ecb6-9b75-4620-a868f8ffe7a2@loongson.cn>
Date:   Fri, 8 Jul 2022 14:08:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <871quxm6rp.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxaeDLycdiTL8QAA--.39984S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4kJr1xZw1kKrWxGFyDJrb_yoW8Jw45pF
        WUG3W2gr4DAr17X3Wvga1FkFnayrn3JrWUCanak3y7J3s8Gwn0gryakFW5G3yDCF1I9r1j
        vF40va4xWF4DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU901xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
        6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svP
        MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/7 下午8:44, Marc Zyngier wrote:
> On Sun, 03 Jul 2022 09:45:30 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> LoongArch CPUINTC stands for CSR.ECFG/CSR.ESTAT and related interrupt
>> controller that described in Section 7.4 of "LoongArch Reference Manual,
>> Vol 1". For more information please refer Documentation/loongarch/irq-
>> chip-model.rst.
>>
>> LoongArch CPUINTC has 13 interrupt sources: SWI0~1, HWI0~7, IPI, TI
>> (Timer) and PCOV (PMC). IRQ mappings of HWI0~7 are configurable (can be
>> created from DT/ACPI), but IPI, TI (Timer) and PCOV (PMC) are hardcoded
>> bits, so we define get_xxx_irq() for them.
> 
> I really dislike this practice. Even if these 3 interrupts are well
> known (their hwirqs are set in stone), you should be able to directly
> create the interrupt from the rest of the kernel code.
> 
> All you have to do is to expose the fwnode_handle in the arch code
> (just like you do for other interrupt controllers), retrieve the
> domain and perform the mapping. No need for any extra arch-specific
> API in the irqchip controller.
> 
> It would also be good to mention that this irqchip driver also probes
> the all the rest of the interrupt hierarchy.
> 

Ok, thanks, I'll change it in next version.


> Thanks,
> 
> 	M.
> 

