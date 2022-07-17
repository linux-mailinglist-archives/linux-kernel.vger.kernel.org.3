Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F98C5775EE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 13:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiGQL3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 07:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 07:29:19 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6D4113E8E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:29:17 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxCeGB8tNisuAkAA--.6360S3;
        Sun, 17 Jul 2022 19:29:05 +0800 (CST)
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
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <20994a99-b5b1-442d-d23d-2a11ecef24a0@loongson.cn>
Date:   Sun, 17 Jul 2022 19:29:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ilnw3vlg.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxCeGB8tNisuAkAA--.6360S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW8Cr17GrW3XF1kuw45Jrb_yoWrur17pF
        WUXa9Fya1UArW5Ars7t3yFqrySv34fKrykWws5C34DArnI9w1DGr1xtF1UuFy7Cr48K3yj
        vr4Fg3Z7uF4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2
        jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm
        -wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/17 下午6:02, Marc Zyngier wrote:
> On Sun, 17 Jul 2022 02:06:12 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>>
>>
>> On 2022/7/17 上午2:39, Marc Zyngier wrote:
>>> On Fri, 15 Jul 2022 08:05:36 +0100,
>>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>>>
>>>> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
>>>> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
>>>> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
>>>> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
>>>> are already added in the ACPI Specification 6.5(which may be published in
>>>> early June this year and the board is reviewing the draft).
>>>>
>>>> Currently, LoongArch based processors (e.g. Loongson-3A5000) can only
>>>> work together with LS7A chipsets. The irq chips in LoongArch computers
>>>> include CPUINTC (CPU Core Interrupt Controller), LIOINTC (Legacy I/O
>>>> Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller),
>>>> HTVECINTC (Hyper-Transport Vector Interrupt Controller), PCH-PIC (Main
>>>> Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
>>>> in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
>>>
>>> [...]
>>>
>>> Compiling this series for loongarch with loongson3_defconfig on top of
>>> 5.19-rc3 results in the following:
>>>
>>> loongarch64-linux-ld: drivers/irqchip/irq-loongson-eiointc.o: in function `.L60':
>>> irq-loongson-eiointc.c:(.init.text+0x4c): undefined reference to `pch_msi_acpi_init'
>>> loongarch64-linux-ld: drivers/irqchip/irq-loongson-htvec.o: in function `pch_msi_parse_madt':
>>> irq-loongson-htvec.c:(.init.text+0x14): undefined reference to `pch_msi_acpi_init'
>>> make: *** [Makefile:1164: vmlinux] Error 1
>>>
>>> I *really* would have expected this series to be in a better shape
>>> after over 15 rounds, but it looks like I'm expecting too much. I
>>> haven't investigated the breakage, but this should (at the very least)
>>> pass the defconfig test and optional drivers not being selected.
>>>
>>> The corresponding MIPS configuration seems to build fine.
>>>
>>> 	M.
>>>
>>
>> Hi, Marc
>>
>> Sorry for that first, pch_msi_acpi_init is defined in pch_msi driver
>> which is compiled depend on CONFIG_PCI, and I test the patches each
>> time with PCI patches and other(or else, kernel can not be boot), so
>> I'm ok for testing the patches. The PCI patches has been accepted by
>> PCI maintainers and will be merged in this merge window.
> 
> But each series *must* at the very least compile in isolation.
> 
>>
>> I don't know how to deal with this situation. Should I add *#ifdef
>> CONFIG_PCI* at position of calling pch_msi_acpi_init or some other
>> way?
> 
> You could try something like this, which results in a kernel that
> fully links with defconfig and no additional patch:
> 
> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
> index ca468564fc85..4479d95867ec 100644
> --- a/arch/loongarch/include/asm/irq.h
> +++ b/arch/loongarch/include/asm/irq.h
> @@ -99,8 +99,17 @@ int htvec_acpi_init(struct irq_domain *parent,
>   					struct acpi_madt_ht_pic *acpi_htvec);
>   int pch_lpc_acpi_init(struct irq_domain *parent,
>   					struct acpi_madt_lpc_pic *acpi_pchlpc);
> +#if IS_ENABLED(CONFIG_LOONGSON_PCH_MSI)
>   int pch_msi_acpi_init(struct irq_domain *parent,
> -					struct acpi_madt_msi_pic *acpi_pchmsi);
> +		      struct acpi_madt_msi_pic *acpi_pchmsi);
> +#else
> +static inline int pch_msi_acpi_init(struct irq_domain *parent,
> +				    struct acpi_madt_msi_pic *acpi_pchmsi)
> +{
> +	return 0;
> +
> +}
> +#endif
>   int pch_pic_acpi_init(struct irq_domain *parent,
>   					struct acpi_madt_bio_pic *acpi_pchpic);
>   int find_pch_pic(u32 gsi);
> 

Ok, thanks, I'll add this into that patch.


> But the other issue is that you seem to call this function from two
> different locations. This cannot be right, as there should be only one
> probe order, and not multiple.
> 

As we described two IRQ models(Legacy and Extended) in this cover 
letter, the parent domain of MSI domain can be htvec domain(Legacy) or 
eiointc domain(Extended). In MADT, only one APIC(HTPIC for htvec or 
EIOPIC for eiointc) is allowed to pass into kernel, and then in the 
irqchip driver, only one kind APIC of them can be parsed from MADT, so 
we have to support two probe order for them.

> 	M.
> 

