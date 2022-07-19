Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF97957A136
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiGSOPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbiGSOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:14:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C1D85A441
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:40:57 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv+NgtNZiUpMoAA--.13064S3;
        Tue, 19 Jul 2022 21:40:48 +0800 (CST)
Subject: Re: [PATCH V16 09/14] irqchip/loongson-pch-msi: Add ACPI init support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
 <1658153621-40445-10-git-send-email-lvjianmin@loongson.cn>
 <CAAhV-H5SVZV5RKhegWNOovSQN9ez_qZKuPUD8NkXwy-xd2MWRQ@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <88a83517-cb6a-b833-8282-051bacfcb110@loongson.cn>
Date:   Tue, 19 Jul 2022 21:40:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5SVZV5RKhegWNOovSQN9ez_qZKuPUD8NkXwy-xd2MWRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxv+NgtNZiUpMoAA--.13064S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4kCF1Dtr13tw43tw4rAFb_yoWfWF1rpF
        WUAanrXr48J34UWrWvgF4DZryaya4a9F4Iva15G3Wftw1qyr95KF18JF17uF1rAr4UGF1I
        vr18tw4DuF1DJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
        XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
        x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/19 上午10:40, Huacai Chen wrote:
> Hi, Jianmin,
> 
> On Mon, Jul 18, 2022 at 10:21 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
>> Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
>> please refer Documentation/loongarch/irq-chip-model.rst.
>>
>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/irq.h       |  12 ++-
>>   arch/loongarch/kernel/irq.c            |   1 -
>>   drivers/irqchip/irq-loongson-pch-msi.c | 131 ++++++++++++++++++++++-----------
>>   3 files changed, 99 insertions(+), 45 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
>> index 74fef60..3e61824 100644
>> --- a/arch/loongarch/include/asm/irq.h
>> +++ b/arch/loongarch/include/asm/irq.h
>> @@ -106,11 +106,20 @@ struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
>>                                          struct acpi_madt_ht_pic *acpi_htvec);
>>   int pch_lpc_acpi_init(struct irq_domain *parent,
>>                                          struct acpi_madt_lpc_pic *acpi_pchlpc);
>> -struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
>> +#if IS_ENABLED(CONFIG_LOONGSON_PCH_MSI)
>> +int pch_msi_acpi_init(struct irq_domain *parent,
>>                                          struct acpi_madt_msi_pic *acpi_pchmsi);
>> +#else
>> +static inline int pch_msi_acpi_init(struct irq_domain *parent,
>> +                                       struct acpi_madt_msi_pic *acpi_pchmsi)
>> +{
>> +       return 0;
>> +}
>> +#endif
>>   int pch_pic_acpi_init(struct irq_domain *parent,
>>                                          struct acpi_madt_bio_pic *acpi_pchpic);
>>   int find_pch_pic(u32 gsi);
>> +struct fwnode_handle *get_pch_msi_handle(int pci_segment);
>>
>>   extern struct acpi_madt_lio_pic *acpi_liointc;
>>   extern struct acpi_madt_eio_pic *acpi_eiointc[MAX_IO_PICS];
>> @@ -123,7 +132,6 @@ int pch_pic_acpi_init(struct irq_domain *parent,
>>   extern struct irq_domain *cpu_domain;
>>   extern struct irq_domain *liointc_domain;
>>   extern struct fwnode_handle *pch_lpc_handle;
>> -extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>>   extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
>>
>>   extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
>> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
>> index 866b2ee..ce21281 100644
>> --- a/arch/loongarch/kernel/irq.c
>> +++ b/arch/loongarch/kernel/irq.c
>> @@ -27,7 +27,6 @@
>>
>>   struct irq_domain *cpu_domain;
>>   struct irq_domain *liointc_domain;
>> -struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>>
>>   /*
>>    * 'what should we do if we get a hw irq event on an illegal vector'.
>> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
>> index e3801c4..b3f1f8e 100644
>> --- a/drivers/irqchip/irq-loongson-pch-msi.c
>> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
>> @@ -15,6 +15,8 @@
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>>
>> +static int nr_pics;
>> +
>>   struct pch_msi_data {
>>          struct mutex    msi_map_lock;
>>          phys_addr_t     doorbell;
>> @@ -23,6 +25,8 @@ struct pch_msi_data {
>>          unsigned long   *msi_map;
>>   };
>>
>> +static struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
>> +
>>   static void pch_msi_mask_msi_irq(struct irq_data *d)
>>   {
>>          pci_msi_mask_irq(d);
>> @@ -154,12 +158,12 @@ static void pch_msi_middle_domain_free(struct irq_domain *domain,
>>   };
>>
>>   static int pch_msi_init_domains(struct pch_msi_data *priv,
>> -                               struct device_node *node,
>> -                               struct irq_domain *parent)
>> +                               struct irq_domain *parent,
>> +                               struct fwnode_handle *domain_handle)
>>   {
>>          struct irq_domain *middle_domain, *msi_domain;
>>
>> -       middle_domain = irq_domain_create_linear(of_node_to_fwnode(node),
>> +       middle_domain = irq_domain_create_linear(domain_handle,
>>                                                  priv->num_irqs,
>>                                                  &pch_msi_middle_domain_ops,
>>                                                  priv);
>> @@ -171,7 +175,7 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
>>          middle_domain->parent = parent;
>>          irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
>>
>> -       msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
>> +       msi_domain = pci_msi_create_irq_domain(domain_handle,
>>                                                 &pch_msi_domain_info,
>>                                                 middle_domain);
>>          if (!msi_domain) {
>> @@ -183,19 +187,11 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
>>          return 0;
>>   }
>>
>> -static int pch_msi_init(struct device_node *node,
>> -                           struct device_node *parent)
>> +static int pch_msi_init(phys_addr_t msg_address, int irq_base, int irq_count,
>> +                       struct irq_domain *parent_domain, struct fwnode_handle *domain_handle)
>>   {
>> -       struct pch_msi_data *priv;
>> -       struct irq_domain *parent_domain;
>> -       struct resource res;
>>          int ret;
>> -
>> -       parent_domain = irq_find_host(parent);
>> -       if (!parent_domain) {
>> -               pr_err("Failed to find the parent domain\n");
>> -               return -ENXIO;
>> -       }
>> +       struct pch_msi_data *priv;
>>
>>          priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>          if (!priv)
>> @@ -203,48 +199,99 @@ static int pch_msi_init(struct device_node *node,
>>
>>          mutex_init(&priv->msi_map_lock);
>>
>> -       ret = of_address_to_resource(node, 0, &res);
>> -       if (ret) {
>> -               pr_err("Failed to allocate resource\n");
>> -               goto err_priv;
>> -       }
>> -
>> -       priv->doorbell = res.start;
>> -
>> -       if (of_property_read_u32(node, "loongson,msi-base-vec",
>> -                               &priv->irq_first)) {
>> -               pr_err("Unable to parse MSI vec base\n");
>> -               ret = -EINVAL;
>> -               goto err_priv;
>> -       }
>> -
>> -       if (of_property_read_u32(node, "loongson,msi-num-vecs",
>> -                               &priv->num_irqs)) {
>> -               pr_err("Unable to parse MSI vec number\n");
>> -               ret = -EINVAL;
>> -               goto err_priv;
>> -       }
>> +       priv->doorbell = msg_address;
>> +       priv->irq_first = irq_base;
>> +       priv->num_irqs = irq_count;
>>
>>          priv->msi_map = bitmap_zalloc(priv->num_irqs, GFP_KERNEL);
>> -       if (!priv->msi_map) {
>> -               ret = -ENOMEM;
>> +       if (!priv->msi_map)
>>                  goto err_priv;
>> -       }
>>
>>          pr_debug("Registering %d MSIs, starting at %d\n",
>>                   priv->num_irqs, priv->irq_first);
>>
>> -       ret = pch_msi_init_domains(priv, node, parent_domain);
>> +       ret = pch_msi_init_domains(priv, parent_domain, domain_handle);
>>          if (ret)
>>                  goto err_map;
>>
>> +       pch_msi_handle[nr_pics++] = domain_handle;
>>          return 0;
>>
>>   err_map:
>>          bitmap_free(priv->msi_map);
>>   err_priv:
>>          kfree(priv);
>> -       return ret;
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static int pch_msi_of_init(struct device_node *node, struct device_node *parent)
>> +{
>> +       int err;
>> +       int irq_base, irq_count;
>> +       struct resource res;
>> +       struct irq_domain *parent_domain;
>> +
>> +       parent_domain = irq_find_host(parent);
>> +       if (!parent_domain) {
>> +               pr_err("Failed to find the parent domain\n");
>> +               return -ENXIO;
>> +       }
>> +
>> +       if (of_address_to_resource(node, 0, &res)) {
>> +               pr_err("Failed to allocate resource\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (of_property_read_u32(node, "loongson,msi-base-vec", &irq_base)) {
>> +               pr_err("Unable to parse MSI vec base\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (of_property_read_u32(node, "loongson,msi-num-vecs", &irq_count)) {
>> +               pr_err("Unable to parse MSI vec number\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       err = pch_msi_init(res.start, irq_base, irq_count, parent_domain, of_node_to_fwnode(node));
>> +       if (err < 0)
>> +               return err;
>> +
>> +       return 0;
>> +}
>> +
>> +IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI
>> +struct fwnode_handle *get_pch_msi_handle(int pci_segment)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < MAX_IO_PICS; i++) {
>> +               if (msi_group[i].pci_segment == pci_segment)
>> +                       return pch_msi_handle[i];
>> +       }
>> +       return NULL;
>>   }
> Not sure, but it seems this function should not be ACPI-specific.
> 

We only support multiple bridges for ACPI on LoongArch machine, so
it's ACPI-specific.

> Huacai
>>

>> -IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
>> +int __init pch_msi_acpi_init(struct irq_domain *parent,
>> +                                       struct acpi_madt_msi_pic *acpi_pchmsi)
>> +{
>> +       int ret;
>> +       struct fwnode_handle *domain_handle;
>> +
>> +       if (!acpi_pchmsi)
>> +               return -EINVAL;
>> +
>> +       domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchmsi);
>> +
>> +       ret = pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
>> +                               acpi_pchmsi->count, parent, domain_handle);
>> +       if (ret < 0)
>> +               irq_domain_free_fwnode(domain_handle);
>> +
>> +       return ret;
>> +}
>> +#endif
>> --
>> 1.8.3.1
>>
>>

