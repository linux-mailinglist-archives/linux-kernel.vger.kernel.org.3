Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293F757A0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiGSOPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiGSOOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:14:49 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2247F823B5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:41:15 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axf+J1tNZihpMoAA--.11021S3;
        Tue, 19 Jul 2022 21:41:09 +0800 (CST)
Subject: Re: [PATCH V16 11/14] LoongArch: prepare to support multiple pch-pic
 and pch-msi irqdomain
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
 <1658153621-40445-12-git-send-email-lvjianmin@loongson.cn>
 <CAAhV-H6ap2pMR44JC7PEBB4RPKcUdJotXS-AHuCCfR7mXrnH0Q@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <a07df42e-2cf9-2931-f707-332bc870fbbd@loongson.cn>
Date:   Tue, 19 Jul 2022 21:41:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6ap2pMR44JC7PEBB4RPKcUdJotXS-AHuCCfR7mXrnH0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Axf+J1tNZihpMoAA--.11021S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur4UKFykurWfKrW8Ar1kKrg_yoWrGF43pF
        WDCFs8Kr45JryxWr1aqay5Wr4Sq34SkFsFqw4fKa4ftrn29rykKF48tr1DuFyFka18CF1I
        va4avFy3uw4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
        AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
        x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/19 上午10:38, Huacai Chen wrote:
> Hi, Jianmin,
> 
> Please change "prepare" to "Prepare" in the title, and move this patch
> just after "LoongArch: Use ACPI_GENERIC_GSI for gsi handling", since
> the former patches are all "preparation".
> 

Ok, thanks.


> Huacai
> 
> On Mon, Jul 18, 2022 at 10:21 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> For systems with two chipsets, there are two related pch-pic and
>> pch-msi irqdomains, each of which has the same node id as its
>> parent irqdomain. So we use a structure to mantain the relation
>> of node and it's parent irqdomain as pch irqdomin, the 'pci_segment'
>> field is only used to match the pci segment of a pci device when
>> setting msi irqdomain for the device.
>>
>> struct acpi_vector_group {
>>          int node;
>>          int pci_segment;
>>          struct irq_domain *parent;
>> };
>>
>> The field 'pci_segment' and 'node' are initialized from MCFG, and
>> the parent irqdomain driver will set field 'parent' by matching same
>> 'node'.
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/irq.h |  8 ++++++++
>>   arch/loongarch/kernel/irq.c      | 38 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
>> index de8af43..c847300 100644
>> --- a/arch/loongarch/include/asm/irq.h
>> +++ b/arch/loongarch/include/asm/irq.h
>> @@ -48,6 +48,14 @@ static inline bool on_irq_stack(int cpu, unsigned long sp)
>>   #define MAX_IO_PICS 2
>>   #define NR_IRQS        (64 + (256 * MAX_IO_PICS))
>>
>> +struct acpi_vector_group {
>> +       int node;
>> +       int pci_segment;
>> +       struct irq_domain *parent;
>> +};
>> +extern struct acpi_vector_group pch_group[MAX_IO_PICS];
>> +extern struct acpi_vector_group msi_group[MAX_IO_PICS];
>> +
>>   #define CORES_PER_EIO_NODE     4
>>
>>   #define LOONGSON_CPU_UART0_VEC         10 /* CPU UART0 */
>> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
>> index b04201c..06f2a15 100644
>> --- a/arch/loongarch/kernel/irq.c
>> +++ b/arch/loongarch/kernel/irq.c
>> @@ -26,6 +26,8 @@
>>   EXPORT_PER_CPU_SYMBOL(irq_stat);
>>
>>   struct irq_domain *cpu_domain;
>> +struct acpi_vector_group pch_group[MAX_IO_PICS];
>> +struct acpi_vector_group msi_group[MAX_IO_PICS];
>>
>>   /*
>>    * 'what should we do if we get a hw irq event on an illegal vector'.
>> @@ -52,6 +54,41 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>>          return 0;
>>   }
>>
>> +static int __init early_pci_mcfg_parse(struct acpi_table_header *header)
>> +{
>> +       struct acpi_table_mcfg *mcfg;
>> +       struct acpi_mcfg_allocation *mptr;
>> +       int i, n;
>> +
>> +       if (header->length < sizeof(struct acpi_table_mcfg))
>> +               return -EINVAL;
>> +
>> +       n = (header->length - sizeof(struct acpi_table_mcfg)) /
>> +                                       sizeof(struct acpi_mcfg_allocation);
>> +       mcfg = (struct acpi_table_mcfg *)header;
>> +       mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
>> +
>> +       for (i = 0; i < n; i++, mptr++) {
>> +               msi_group[i].pci_segment = mptr->pci_segment;
>> +               pch_group[i].node = msi_group[i].node = (mptr->address >> 44) & 0xf;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void __init init_vec_parent_group(void)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < MAX_IO_PICS; i++) {
>> +               msi_group[i].pci_segment = -1;
>> +               msi_group[i].node = -1;
>> +               pch_group[i].node = -1;
>> +       }
>> +
>> +       acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
>> +}
>> +
>>   void __init init_IRQ(void)
>>   {
>>          int i;
>> @@ -65,6 +102,7 @@ void __init init_IRQ(void)
>>          clear_csr_ecfg(ECFG0_IM);
>>          clear_csr_estat(ESTATF_IP);
>>
>> +       init_vec_parent_group();
>>          irqchip_init();
>>   #ifdef CONFIG_SMP
>>          ipi_irq = EXCCODE_IPI - EXCCODE_INT_START;
>> --
>> 1.8.3.1
>>
>>

