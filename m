Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A25F5790F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiGSCkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiGSCkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A344330547
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:40:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36D1B60C4D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD7CC341C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658198440;
        bh=eE5Dei1/N1LTDNoxwvMQkRVexHfWNyj5HyT/ORd6wuM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yvaz83Cta8bqYqsz+VjR26B1Aa/7OMLU9DnpoKWo/D7yit5pf/rQumXTcTeuJwy+F
         /SwSBDLA1CVPRfqD3toGBKVONX60ePDTOhyVp6cEN60zBwjnI4n/WGDRW39Iv3/B7w
         eL0n7mfIsaksr1HXY5oVIl78udjiPq+7smDQvPnTcifcIR3O5M5Eh3Rl207pcDlziu
         Z5eZ1tFGIX8JUzX3cfRg+R4sovEgV0GcmGHz1djuahV+n779jug97EvGPTlj7KjVyB
         2LjrXyPmFq5ZTfKAlOsGXSeGlrehAw01vt3ACE3zr0XKdn67VW7ICa9IYe6Oxf4fKh
         9Qr4PygnVGJBA==
Received: by mail-ua1-f51.google.com with SMTP id g12so2376921uan.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:40:40 -0700 (PDT)
X-Gm-Message-State: AJIora+w1eC9Y6qNVHKA3sK+eCXRiro1Mn+RY8vxuDVRaXJzGbnX/E+F
        ElOESxRjGbwQwDmVhF2kfXRs7oFX7YdCQ2bi7m4=
X-Google-Smtp-Source: AGRyM1tRmQFEYKJKD5z9Q5eJMm/RulrtRC2g8gppsjLNfIxXdO6JfLDUpQLfcwc0V0yvUT4clrCJvnTT2UV/oi7rFus=
X-Received: by 2002:ab0:7001:0:b0:382:c47c:2825 with SMTP id
 k1-20020ab07001000000b00382c47c2825mr11117008ual.23.1658198439243; Mon, 18
 Jul 2022 19:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn> <1658153621-40445-10-git-send-email-lvjianmin@loongson.cn>
In-Reply-To: <1658153621-40445-10-git-send-email-lvjianmin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 19 Jul 2022 10:40:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5SVZV5RKhegWNOovSQN9ez_qZKuPUD8NkXwy-xd2MWRQ@mail.gmail.com>
Message-ID: <CAAhV-H5SVZV5RKhegWNOovSQN9ez_qZKuPUD8NkXwy-xd2MWRQ@mail.gmail.com>
Subject: Re: [PATCH V16 09/14] irqchip/loongson-pch-msi: Add ACPI init support
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jianmin,

On Mon, Jul 18, 2022 at 10:21 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
> From: Huacai Chen <chenhuacai@loongson.cn>
>
> PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
> Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
> please refer Documentation/loongarch/irq-chip-model.rst.
>
> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/irq.h       |  12 ++-
>  arch/loongarch/kernel/irq.c            |   1 -
>  drivers/irqchip/irq-loongson-pch-msi.c | 131 ++++++++++++++++++++++-----------
>  3 files changed, 99 insertions(+), 45 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
> index 74fef60..3e61824 100644
> --- a/arch/loongarch/include/asm/irq.h
> +++ b/arch/loongarch/include/asm/irq.h
> @@ -106,11 +106,20 @@ struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
>                                         struct acpi_madt_ht_pic *acpi_htvec);
>  int pch_lpc_acpi_init(struct irq_domain *parent,
>                                         struct acpi_madt_lpc_pic *acpi_pchlpc);
> -struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
> +#if IS_ENABLED(CONFIG_LOONGSON_PCH_MSI)
> +int pch_msi_acpi_init(struct irq_domain *parent,
>                                         struct acpi_madt_msi_pic *acpi_pchmsi);
> +#else
> +static inline int pch_msi_acpi_init(struct irq_domain *parent,
> +                                       struct acpi_madt_msi_pic *acpi_pchmsi)
> +{
> +       return 0;
> +}
> +#endif
>  int pch_pic_acpi_init(struct irq_domain *parent,
>                                         struct acpi_madt_bio_pic *acpi_pchpic);
>  int find_pch_pic(u32 gsi);
> +struct fwnode_handle *get_pch_msi_handle(int pci_segment);
>
>  extern struct acpi_madt_lio_pic *acpi_liointc;
>  extern struct acpi_madt_eio_pic *acpi_eiointc[MAX_IO_PICS];
> @@ -123,7 +132,6 @@ int pch_pic_acpi_init(struct irq_domain *parent,
>  extern struct irq_domain *cpu_domain;
>  extern struct irq_domain *liointc_domain;
>  extern struct fwnode_handle *pch_lpc_handle;
> -extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>  extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
>
>  extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
> index 866b2ee..ce21281 100644
> --- a/arch/loongarch/kernel/irq.c
> +++ b/arch/loongarch/kernel/irq.c
> @@ -27,7 +27,6 @@
>
>  struct irq_domain *cpu_domain;
>  struct irq_domain *liointc_domain;
> -struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>
>  /*
>   * 'what should we do if we get a hw irq event on an illegal vector'.
> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
> index e3801c4..b3f1f8e 100644
> --- a/drivers/irqchip/irq-loongson-pch-msi.c
> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
> @@ -15,6 +15,8 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>
> +static int nr_pics;
> +
>  struct pch_msi_data {
>         struct mutex    msi_map_lock;
>         phys_addr_t     doorbell;
> @@ -23,6 +25,8 @@ struct pch_msi_data {
>         unsigned long   *msi_map;
>  };
>
> +static struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
> +
>  static void pch_msi_mask_msi_irq(struct irq_data *d)
>  {
>         pci_msi_mask_irq(d);
> @@ -154,12 +158,12 @@ static void pch_msi_middle_domain_free(struct irq_domain *domain,
>  };
>
>  static int pch_msi_init_domains(struct pch_msi_data *priv,
> -                               struct device_node *node,
> -                               struct irq_domain *parent)
> +                               struct irq_domain *parent,
> +                               struct fwnode_handle *domain_handle)
>  {
>         struct irq_domain *middle_domain, *msi_domain;
>
> -       middle_domain = irq_domain_create_linear(of_node_to_fwnode(node),
> +       middle_domain = irq_domain_create_linear(domain_handle,
>                                                 priv->num_irqs,
>                                                 &pch_msi_middle_domain_ops,
>                                                 priv);
> @@ -171,7 +175,7 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
>         middle_domain->parent = parent;
>         irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
>
> -       msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
> +       msi_domain = pci_msi_create_irq_domain(domain_handle,
>                                                &pch_msi_domain_info,
>                                                middle_domain);
>         if (!msi_domain) {
> @@ -183,19 +187,11 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
>         return 0;
>  }
>
> -static int pch_msi_init(struct device_node *node,
> -                           struct device_node *parent)
> +static int pch_msi_init(phys_addr_t msg_address, int irq_base, int irq_count,
> +                       struct irq_domain *parent_domain, struct fwnode_handle *domain_handle)
>  {
> -       struct pch_msi_data *priv;
> -       struct irq_domain *parent_domain;
> -       struct resource res;
>         int ret;
> -
> -       parent_domain = irq_find_host(parent);
> -       if (!parent_domain) {
> -               pr_err("Failed to find the parent domain\n");
> -               return -ENXIO;
> -       }
> +       struct pch_msi_data *priv;
>
>         priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -203,48 +199,99 @@ static int pch_msi_init(struct device_node *node,
>
>         mutex_init(&priv->msi_map_lock);
>
> -       ret = of_address_to_resource(node, 0, &res);
> -       if (ret) {
> -               pr_err("Failed to allocate resource\n");
> -               goto err_priv;
> -       }
> -
> -       priv->doorbell = res.start;
> -
> -       if (of_property_read_u32(node, "loongson,msi-base-vec",
> -                               &priv->irq_first)) {
> -               pr_err("Unable to parse MSI vec base\n");
> -               ret = -EINVAL;
> -               goto err_priv;
> -       }
> -
> -       if (of_property_read_u32(node, "loongson,msi-num-vecs",
> -                               &priv->num_irqs)) {
> -               pr_err("Unable to parse MSI vec number\n");
> -               ret = -EINVAL;
> -               goto err_priv;
> -       }
> +       priv->doorbell = msg_address;
> +       priv->irq_first = irq_base;
> +       priv->num_irqs = irq_count;
>
>         priv->msi_map = bitmap_zalloc(priv->num_irqs, GFP_KERNEL);
> -       if (!priv->msi_map) {
> -               ret = -ENOMEM;
> +       if (!priv->msi_map)
>                 goto err_priv;
> -       }
>
>         pr_debug("Registering %d MSIs, starting at %d\n",
>                  priv->num_irqs, priv->irq_first);
>
> -       ret = pch_msi_init_domains(priv, node, parent_domain);
> +       ret = pch_msi_init_domains(priv, parent_domain, domain_handle);
>         if (ret)
>                 goto err_map;
>
> +       pch_msi_handle[nr_pics++] = domain_handle;
>         return 0;
>
>  err_map:
>         bitmap_free(priv->msi_map);
>  err_priv:
>         kfree(priv);
> -       return ret;
> +
> +       return -EINVAL;
> +}
> +
> +#ifdef CONFIG_OF
> +static int pch_msi_of_init(struct device_node *node, struct device_node *parent)
> +{
> +       int err;
> +       int irq_base, irq_count;
> +       struct resource res;
> +       struct irq_domain *parent_domain;
> +
> +       parent_domain = irq_find_host(parent);
> +       if (!parent_domain) {
> +               pr_err("Failed to find the parent domain\n");
> +               return -ENXIO;
> +       }
> +
> +       if (of_address_to_resource(node, 0, &res)) {
> +               pr_err("Failed to allocate resource\n");
> +               return -EINVAL;
> +       }
> +
> +       if (of_property_read_u32(node, "loongson,msi-base-vec", &irq_base)) {
> +               pr_err("Unable to parse MSI vec base\n");
> +               return -EINVAL;
> +       }
> +
> +       if (of_property_read_u32(node, "loongson,msi-num-vecs", &irq_count)) {
> +               pr_err("Unable to parse MSI vec number\n");
> +               return -EINVAL;
> +       }
> +
> +       err = pch_msi_init(res.start, irq_base, irq_count, parent_domain, of_node_to_fwnode(node));
> +       if (err < 0)
> +               return err;
> +
> +       return 0;
> +}
> +
> +IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +struct fwnode_handle *get_pch_msi_handle(int pci_segment)
> +{
> +       int i;
> +
> +       for (i = 0; i < MAX_IO_PICS; i++) {
> +               if (msi_group[i].pci_segment == pci_segment)
> +                       return pch_msi_handle[i];
> +       }
> +       return NULL;
>  }
Not sure, but it seems this function should not be ACPI-specific.

Huacai
>
> -IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
> +int __init pch_msi_acpi_init(struct irq_domain *parent,
> +                                       struct acpi_madt_msi_pic *acpi_pchmsi)
> +{
> +       int ret;
> +       struct fwnode_handle *domain_handle;
> +
> +       if (!acpi_pchmsi)
> +               return -EINVAL;
> +
> +       domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchmsi);
> +
> +       ret = pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
> +                               acpi_pchmsi->count, parent, domain_handle);
> +       if (ret < 0)
> +               irq_domain_free_fwnode(domain_handle);
> +
> +       return ret;
> +}
> +#endif
> --
> 1.8.3.1
>
>
