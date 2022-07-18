Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224E0578659
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiGRP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiGRP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BB928E2F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1163961315
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A70C341D1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658158075;
        bh=f6aow2kzzAFSqfxYnbvxTpSUyhhJbIhqINsOZ2Zi7OE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ubi9tXLMN+BPZltFMlZ/qblsglLuBb0X7srXOzdx1nIdRM9iJ4ubA65qwQGtkHcX7
         iQz7Vdc3ptzuiHABTdL9ZiNjrGQ0BM4aJ2PkmT38CO21YpbnxcEB2w5+SQsuYw965l
         nomoF1SLpqdTfz6FA8GJS+3KLx1WM7HAZZ/4VJEKkAIUa+XCHrmAOJxGMdgqqhFQOH
         w010yvL34g1JBrnuZF8HONfebrKyzRpFqPv8u11+D+INt2uNOlT9QHQe/d6n7R4kZq
         PisqwlQEoJR9c2ZjZJgl6WLjXC9BZBlJ5I664F72cTLYm4XL+tdPMddvLduMdknH0U
         2XIZ9L1a5ruEw==
Received: by mail-vs1-f41.google.com with SMTP id 125so319326vsd.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:27:55 -0700 (PDT)
X-Gm-Message-State: AJIora9W+pUOiLRJypxyag9/bO0LTzjqZtB17Y8uLnMLR8ffrfq4T1iO
        y1QT6InNVzvgcte/PPNJ7nawV2j+PXVGOZGx9SU=
X-Google-Smtp-Source: AGRyM1sHfqJGafT5khvtKQm23L+QOj2Xe2+1hxQzetjlDIuNZBNanw5NbZa1jNnSpHvxNMZASk+rPfLSgJ7HrK5twUI=
X-Received: by 2002:a05:6102:3543:b0:357:3ae7:bbd0 with SMTP id
 e3-20020a056102354300b003573ae7bbd0mr10065788vss.84.1658158074018; Mon, 18
 Jul 2022 08:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn> <1658153621-40445-9-git-send-email-lvjianmin@loongson.cn>
In-Reply-To: <1658153621-40445-9-git-send-email-lvjianmin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 18 Jul 2022 23:27:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4WQMjk+eU0C=j_XabDNJm5U+a_KGD4y1izgjk4qc-kCg@mail.gmail.com>
Message-ID: <CAAhV-H4WQMjk+eU0C=j_XabDNJm5U+a_KGD4y1izgjk4qc-kCg@mail.gmail.com>
Subject: Re: [PATCH V16 08/14] irqchip/loongson-pch-pic: Add ACPI init support
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

On Mon, Jul 18, 2022 at 10:14 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
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
>  arch/loongarch/include/asm/irq.h            |   5 +-
>  arch/loongarch/kernel/irq.c                 |   1 -
>  arch/mips/include/asm/mach-loongson64/irq.h |   2 +-
>  drivers/irqchip/irq-loongson-pch-pic.c      | 178 +++++++++++++++++++++++-----
>  4 files changed, 151 insertions(+), 35 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
> index 48c0ce4..74fef60 100644
> --- a/arch/loongarch/include/asm/irq.h
> +++ b/arch/loongarch/include/asm/irq.h
> @@ -108,8 +108,9 @@ int pch_lpc_acpi_init(struct irq_domain *parent,
>                                         struct acpi_madt_lpc_pic *acpi_pchlpc);
>  struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
>                                         struct acpi_madt_msi_pic *acpi_pchmsi);
> -struct irq_domain *pch_pic_acpi_init(struct irq_domain *parent,
> +int pch_pic_acpi_init(struct irq_domain *parent,
>                                         struct acpi_madt_bio_pic *acpi_pchpic);
> +int find_pch_pic(u32 gsi);
>
>  extern struct acpi_madt_lio_pic *acpi_liointc;
>  extern struct acpi_madt_eio_pic *acpi_eiointc[MAX_IO_PICS];
> @@ -123,7 +124,7 @@ struct irq_domain *pch_pic_acpi_init(struct irq_domain *parent,
>  extern struct irq_domain *liointc_domain;
>  extern struct fwnode_handle *pch_lpc_handle;
>  extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
> -extern struct irq_domain *pch_pic_domain[MAX_IO_PICS];
> +extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
>
>  extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
>
> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
> index 07d6059..866b2ee 100644
> --- a/arch/loongarch/kernel/irq.c
> +++ b/arch/loongarch/kernel/irq.c
> @@ -28,7 +28,6 @@
>  struct irq_domain *cpu_domain;
>  struct irq_domain *liointc_domain;
>  struct irq_domain *pch_msi_domain[MAX_IO_PICS];
> -struct irq_domain *pch_pic_domain[MAX_IO_PICS];
>
>  /*
>   * 'what should we do if we get a hw irq event on an illegal vector'.
> diff --git a/arch/mips/include/asm/mach-loongson64/irq.h b/arch/mips/include/asm/mach-loongson64/irq.h
> index 98ea977..55e0dee 100644
> --- a/arch/mips/include/asm/mach-loongson64/irq.h
> +++ b/arch/mips/include/asm/mach-loongson64/irq.h
> @@ -7,7 +7,7 @@
>  #define NR_MIPS_CPU_IRQS       8
>  #define NR_MAX_CHAINED_IRQS    40 /* Chained IRQs means those not directly used by devices */
>  #define NR_IRQS                        (NR_IRQS_LEGACY + NR_MIPS_CPU_IRQS + NR_MAX_CHAINED_IRQS + 256)
> -
> +#define MAX_IO_PICS            1
>  #define MIPS_CPU_IRQ_BASE      NR_IRQS_LEGACY
>
>  #include <asm/mach-generic/irq.h>
> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
> index a4eb8a2..b6a73c8 100644
> --- a/drivers/irqchip/irq-loongson-pch-pic.c
> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> @@ -33,13 +33,40 @@
>  #define PIC_REG_IDX(irq_id)    ((irq_id) / PIC_COUNT_PER_REG)
>  #define PIC_REG_BIT(irq_id)    ((irq_id) % PIC_COUNT_PER_REG)
>
> +static int nr_pics;
> +
>  struct pch_pic {
>         void __iomem            *base;
>         struct irq_domain       *pic_domain;
>         u32                     ht_vec_base;
>         raw_spinlock_t          pic_lock;
> +       u32                     vec_count;
> +       u32                     gsi_base;
>  };
>
> +static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
> +
> +struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
> +
> +int find_pch_pic(u32 gsi)
> +{
> +       int i;
> +
> +       /* Find the PCH_PIC that manages this GSI. */
> +       for (i = 0; i < MAX_IO_PICS; i++) {
> +               struct pch_pic *priv = pch_pic_priv[i];
> +
> +               if (!priv)
> +                       return -1;
> +
> +               if (gsi >= priv->gsi_base && gsi < (priv->gsi_base + priv->vec_count))
> +                       return i;
> +       }
> +
> +       pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
> +       return -1;
> +}
> +
>  static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
>  {
>         u32 reg;
> @@ -139,6 +166,28 @@ static void pch_pic_ack_irq(struct irq_data *d)
>         .irq_set_type           = pch_pic_set_type,
>  };
>
> +static int pch_pic_domain_translate(struct irq_domain *d,
> +                                       struct irq_fwspec *fwspec,
> +                                       unsigned long *hwirq,
> +                                       unsigned int *type)
> +{
> +       struct pch_pic *priv = d->host_data;
> +       struct device_node *of_node = to_of_node(fwspec->fwnode);
> +
> +       if (fwspec->param_count < 1)
> +               return -EINVAL;
> +
> +       if (of_node) {
> +               *hwirq = fwspec->param[0] + priv->ht_vec_base;
> +               *type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> +       } else {
> +               *hwirq = fwspec->param[0] - priv->gsi_base;
> +               *type = IRQ_TYPE_NONE;
> +       }
> +
> +       return 0;
> +}
> +
>  static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
>                               unsigned int nr_irqs, void *arg)
>  {
> @@ -149,13 +198,13 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
>         struct irq_fwspec parent_fwspec;
>         struct pch_pic *priv = domain->host_data;
>
> -       err = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
> +       err = pch_pic_domain_translate(domain, fwspec, &hwirq, &type);
>         if (err)
>                 return err;
>
>         parent_fwspec.fwnode = domain->parent->fwnode;
>         parent_fwspec.param_count = 1;
> -       parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
> +       parent_fwspec.param[0] = hwirq;
>
>         err = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
>         if (err)
> @@ -170,7 +219,7 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
>  }
>
>  static const struct irq_domain_ops pch_pic_domain_ops = {
> -       .translate      = irq_domain_translate_twocell,
> +       .translate      = pch_pic_domain_translate,
>         .alloc          = pch_pic_alloc,
>         .free           = irq_domain_free_irqs_parent,
>  };
> @@ -180,7 +229,7 @@ static void pch_pic_reset(struct pch_pic *priv)
>         int i;
>
>         for (i = 0; i < PIC_COUNT; i++) {
> -               /* Write vectored ID */
> +               /* Write vector ID */
>                 writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
>                 /* Hardcode route to HT0 Lo */
>                 writeb(1, priv->base + PCH_INT_ROUTE(i));
> @@ -198,50 +247,37 @@ static void pch_pic_reset(struct pch_pic *priv)
>         }
>  }
>
> -static int pch_pic_of_init(struct device_node *node,
> -                               struct device_node *parent)
> +static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
> +                       struct irq_domain *parent_domain, struct fwnode_handle *domain_handle,
> +                       u32 gsi_base)
>  {
>         struct pch_pic *priv;
> -       struct irq_domain *parent_domain;
> -       int err;
>
>         priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
>
>         raw_spin_lock_init(&priv->pic_lock);
> -       priv->base = of_iomap(node, 0);
> -       if (!priv->base) {
> -               err = -ENOMEM;
> +       priv->base = ioremap(addr, size);
> +       if (!priv->base)
>                 goto free_priv;
> -       }
> -
> -       parent_domain = irq_find_host(parent);
> -       if (!parent_domain) {
> -               pr_err("Failed to find the parent domain\n");
> -               err = -ENXIO;
> -               goto iounmap_base;
> -       }
>
> -       if (of_property_read_u32(node, "loongson,pic-base-vec",
> -                               &priv->ht_vec_base)) {
> -               pr_err("Failed to determine pic-base-vec\n");
> -               err = -EINVAL;
> -               goto iounmap_base;
> -       }
> +       priv->ht_vec_base = vec_base;
> +       priv->vec_count = ((readq(priv->base) >> 48) & 0xff) + 1;
> +       priv->gsi_base = gsi_base;
>
>         priv->pic_domain = irq_domain_create_hierarchy(parent_domain, 0,
> -                                                      PIC_COUNT,
> -                                                      of_node_to_fwnode(node),
> -                                                      &pch_pic_domain_ops,
> -                                                      priv);
> +                                               priv->vec_count, domain_handle,
> +                                               &pch_pic_domain_ops, priv);
> +
>         if (!priv->pic_domain) {
>                 pr_err("Failed to create IRQ domain\n");
> -               err = -ENOMEM;
>                 goto iounmap_base;
>         }
>
>         pch_pic_reset(priv);
> +       pch_pic_handle[nr_pics] = domain_handle;
> +       pch_pic_priv[nr_pics++] = priv;
>
>         return 0;
>
> @@ -250,7 +286,87 @@ static int pch_pic_of_init(struct device_node *node,
>  free_priv:
>         kfree(priv);
>
> -       return err;
> +       return -EINVAL;
> +}
> +
> +#ifdef CONFIG_OF
> +
> +static int pch_pic_of_init(struct device_node *node,
> +                               struct device_node *parent)
> +{
> +       int err, vec_base;
> +       struct resource res;
> +       struct irq_domain *parent_domain;
> +
> +       if (of_address_to_resource(node, 0, &res))
> +               return -EINVAL;
> +
> +       parent_domain = irq_find_host(parent);
> +       if (!parent_domain) {
> +               pr_err("Failed to find the parent domain\n");
> +               return -ENXIO;
> +       }
> +
> +       if (of_property_read_u32(node, "loongson,pic-base-vec", &vec_base)) {
> +               pr_err("Failed to determine pic-base-vec\n");
> +               return -EINVAL;
> +       }
> +
> +       err = pch_pic_init(res.start, resource_size(&res), vec_base,
> +                               parent_domain, of_node_to_fwnode(node), 0);
> +       if (err < 0)
> +               return err;
> +
> +       return 0;
>  }
>
>  IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
> +
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +static int __init
> +lpcintc_parse_madt(union acpi_subtable_headers *header,
> +                      const unsigned long end)
> +{
> +       struct acpi_madt_lpc_pic *lpcintc_entry = (struct acpi_madt_lpc_pic *)header;
For consistency, please use pch_lpc_parse_madt() and pchlpc_entry here, thanks.

Huacai
> +
> +       return pch_lpc_acpi_init(pch_pic_priv[0]->pic_domain, lpcintc_entry);
> +}
> +
> +static int __init acpi_cascade_irqdomain_init(void)
> +{
> +       acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC,
> +                             lpcintc_parse_madt, 0);
> +       return 0;
> +}
> +
> +int __init pch_pic_acpi_init(struct irq_domain *parent,
> +                                       struct acpi_madt_bio_pic *acpi_pchpic)
> +{
> +       int ret, vec_base;
> +       struct fwnode_handle *domain_handle;
> +
> +       if (!acpi_pchpic)
> +               return -EINVAL;
> +
> +       vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
> +
> +       domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchpic);
> +       if (!domain_handle) {
> +               pr_err("Unable to allocate domain handle\n");
> +               return -ENOMEM;
> +       }
> +
> +       ret = pch_pic_init(acpi_pchpic->address, acpi_pchpic->size,
> +                               vec_base, parent, domain_handle, acpi_pchpic->gsi_base);
> +
> +       if (!ret) {
> +               if (acpi_pchpic->id == 0)
> +                       acpi_cascade_irqdomain_init();
> +       } else
> +               irq_domain_free_fwnode(domain_handle);
> +
> +       return ret;
> +}
> +#endif
> --
> 1.8.3.1
>
>
