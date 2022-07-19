Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8038D5790EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiGSCii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiGSCid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:38:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44332715C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98110B817CA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480D2C341CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658198310;
        bh=eo8dR8UxBG4GcoyxQWNmWqivK6NI2ddRfXnjJa6OZHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GxpXOovoD/dcd9csiboqWSW8yDJRQzsloauHWZnad+X5gl6UjgP1ff3zgsDg9WTef
         o5nksAMD2/NHSqVCXzBZiw0YbBZIJkcnAiITUnLa2EULypVLyXJp81IlFXYXD1EkSC
         J21UVXMh5fdXRDfKbj3NBIzz6n7xRwFwsz2yfJ9R/+k5mWcrV7Q9xpOKcpn/NG0aRh
         61SajwaQ4OCULxUDMAbsoxgmEep+lZI5nWkwMFYdQLvehcmXfgE3r7CN1YTsDMOoKk
         vMUeLVW92YVSq7J4PGPYlSoXXB5Cq8fdPAaMGKpY+aoR7/voiuCTRY89EpSyYAKHLN
         4+nD9KcoboiOA==
Received: by mail-ua1-f44.google.com with SMTP id s7so6267531uao.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:38:30 -0700 (PDT)
X-Gm-Message-State: AJIora+IwwaG1cnN45AG0Wmgixjr2j5cJ2M9otiZL0eWV4WmanS+nqDK
        Y9uSPTS231RnpDovoqZTxmQxPxy4blVxQpOr33E=
X-Google-Smtp-Source: AGRyM1uq0+oApbWu0nRO+BDAaKnNcccyMDrhQZqa10uOBalRUFcDUxKy26H7RRIC+XTrmPzZxpXtryxpeqA8S0yWfHk=
X-Received: by 2002:a9f:3253:0:b0:383:c330:68 with SMTP id y19-20020a9f3253000000b00383c3300068mr7232632uad.104.1658198309199;
 Mon, 18 Jul 2022 19:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn> <1658153621-40445-12-git-send-email-lvjianmin@loongson.cn>
In-Reply-To: <1658153621-40445-12-git-send-email-lvjianmin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 19 Jul 2022 10:38:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ap2pMR44JC7PEBB4RPKcUdJotXS-AHuCCfR7mXrnH0Q@mail.gmail.com>
Message-ID: <CAAhV-H6ap2pMR44JC7PEBB4RPKcUdJotXS-AHuCCfR7mXrnH0Q@mail.gmail.com>
Subject: Re: [PATCH V16 11/14] LoongArch: prepare to support multiple pch-pic
 and pch-msi irqdomain
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

Please change "prepare" to "Prepare" in the title, and move this patch
just after "LoongArch: Use ACPI_GENERIC_GSI for gsi handling", since
the former patches are all "preparation".

Huacai

On Mon, Jul 18, 2022 at 10:21 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
> For systems with two chipsets, there are two related pch-pic and
> pch-msi irqdomains, each of which has the same node id as its
> parent irqdomain. So we use a structure to mantain the relation
> of node and it's parent irqdomain as pch irqdomin, the 'pci_segment'
> field is only used to match the pci segment of a pci device when
> setting msi irqdomain for the device.
>
> struct acpi_vector_group {
>         int node;
>         int pci_segment;
>         struct irq_domain *parent;
> };
>
> The field 'pci_segment' and 'node' are initialized from MCFG, and
> the parent irqdomain driver will set field 'parent' by matching same
> 'node'.
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>  arch/loongarch/include/asm/irq.h |  8 ++++++++
>  arch/loongarch/kernel/irq.c      | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
> index de8af43..c847300 100644
> --- a/arch/loongarch/include/asm/irq.h
> +++ b/arch/loongarch/include/asm/irq.h
> @@ -48,6 +48,14 @@ static inline bool on_irq_stack(int cpu, unsigned long sp)
>  #define MAX_IO_PICS 2
>  #define NR_IRQS        (64 + (256 * MAX_IO_PICS))
>
> +struct acpi_vector_group {
> +       int node;
> +       int pci_segment;
> +       struct irq_domain *parent;
> +};
> +extern struct acpi_vector_group pch_group[MAX_IO_PICS];
> +extern struct acpi_vector_group msi_group[MAX_IO_PICS];
> +
>  #define CORES_PER_EIO_NODE     4
>
>  #define LOONGSON_CPU_UART0_VEC         10 /* CPU UART0 */
> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
> index b04201c..06f2a15 100644
> --- a/arch/loongarch/kernel/irq.c
> +++ b/arch/loongarch/kernel/irq.c
> @@ -26,6 +26,8 @@
>  EXPORT_PER_CPU_SYMBOL(irq_stat);
>
>  struct irq_domain *cpu_domain;
> +struct acpi_vector_group pch_group[MAX_IO_PICS];
> +struct acpi_vector_group msi_group[MAX_IO_PICS];
>
>  /*
>   * 'what should we do if we get a hw irq event on an illegal vector'.
> @@ -52,6 +54,41 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>         return 0;
>  }
>
> +static int __init early_pci_mcfg_parse(struct acpi_table_header *header)
> +{
> +       struct acpi_table_mcfg *mcfg;
> +       struct acpi_mcfg_allocation *mptr;
> +       int i, n;
> +
> +       if (header->length < sizeof(struct acpi_table_mcfg))
> +               return -EINVAL;
> +
> +       n = (header->length - sizeof(struct acpi_table_mcfg)) /
> +                                       sizeof(struct acpi_mcfg_allocation);
> +       mcfg = (struct acpi_table_mcfg *)header;
> +       mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
> +
> +       for (i = 0; i < n; i++, mptr++) {
> +               msi_group[i].pci_segment = mptr->pci_segment;
> +               pch_group[i].node = msi_group[i].node = (mptr->address >> 44) & 0xf;
> +       }
> +
> +       return 0;
> +}
> +
> +static void __init init_vec_parent_group(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < MAX_IO_PICS; i++) {
> +               msi_group[i].pci_segment = -1;
> +               msi_group[i].node = -1;
> +               pch_group[i].node = -1;
> +       }
> +
> +       acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
> +}
> +
>  void __init init_IRQ(void)
>  {
>         int i;
> @@ -65,6 +102,7 @@ void __init init_IRQ(void)
>         clear_csr_ecfg(ECFG0_IM);
>         clear_csr_estat(ESTATF_IP);
>
> +       init_vec_parent_group();
>         irqchip_init();
>  #ifdef CONFIG_SMP
>         ipi_irq = EXCCODE_IPI - EXCCODE_INT_START;
> --
> 1.8.3.1
>
>
