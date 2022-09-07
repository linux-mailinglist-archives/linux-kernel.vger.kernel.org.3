Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4E5B1048
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIGXVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIGXVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:21:05 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A909098A4A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:21:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id c4so12749454iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LTOeCjfJotr02jcfDPAY5LmPRWFwiUZOmDbbyJyKBEc=;
        b=nMgikIW25jVPRgTNTsPE+uV3ApiAjiwGNFkTu5WfstH3jXuUCVYuepPCclOtQUowmJ
         BOyF5Jk3IqveRLG322GQ2NcPPrnmutuRdgR/JJke2RXJ9gwmhn2TXdAM1uv0RNtAh6DG
         VQCL8mkLCcXfd+1NYUDPBV7UNxRQ2D58wfg/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LTOeCjfJotr02jcfDPAY5LmPRWFwiUZOmDbbyJyKBEc=;
        b=cg5EfT2uxvP/+1A90YuQ5AP/8sdCRdFkaFVQ3cSy8VF+rzJy5izAhLdQSjWJitW4ZX
         ZGp+8t0+OqjrmiBdBZUhnHEM462Q9uWVHb92r9jiCPObxs5VKA6C/dcS728xJHkDw3NO
         crVYvXouDuijFKqV+vVvGoaH/Ux5SPmHp934NQ+RvdaeVi4l9KKog7uf8UrbfTkpGD59
         B8wyBm+S3yk9J/YhTA81MJA4C1pNpO4fVQf9j8hu6cfVSFV97iikQZNYp43lAs3xBv9z
         mv6nxYHOMS81z6nZtRzYlDf089lY/cVCeSefDbSKv9AK64d96fbpFBLXNISB9wGv8nas
         +7+A==
X-Gm-Message-State: ACgBeo3ivgMt+EN1SSQZK1KH41p2rkPendtTZ4qaR08uDCzBqG2W7J0c
        +U6vUwGKZDtJvdJ4LLYijSjg584XLTmp9O5liFnn
X-Google-Smtp-Source: AA6agR64N1DTyVzrg7mBpqdIyR7XJWMH1r0rpCUWpuAEztHeFYzYR6CSGZcXYectjKAYRG4/ZpSLgmBMD0Dom4N1/90=
X-Received: by 2002:a6b:c504:0:b0:68b:6802:2bfe with SMTP id
 v4-20020a6bc504000000b0068b68022bfemr2928712iof.22.1662592863904; Wed, 07 Sep
 2022 16:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220903161309.32848-1-apatel@ventanamicro.com> <20220903161309.32848-3-apatel@ventanamicro.com>
In-Reply-To: <20220903161309.32848-3-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 7 Sep 2022 16:20:53 -0700
Message-ID: <CAOnJCUJU_2vfiWO7PXSpDmkBuQhw_R9iUURhSCwjU=3OW7c+eg@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] irqchip/riscv-intc: Allow drivers to directly
 discover INTC hwnode
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 3, 2022 at 9:13 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> Various RISC-V drivers (such as SBI IPI, SBI Timer, SBI PMU, and
> KVM RISC-V) don't have associated DT node but these drivers need
> standard per-CPU (local) interrupts defined by the RISC-V privileged
> specification.
>
> We add riscv_get_intc_hwnode() in arch/riscv which allows RISC-V
> drivers not having DT node to discover INTC hwnode which in-turn
> helps these drivers to map per-CPU (local) interrupts provided
> by the INTC driver.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/irq.h     |  4 ++++
>  arch/riscv/kernel/irq.c          | 18 ++++++++++++++++++
>  drivers/irqchip/irq-riscv-intc.c |  7 +++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index e4c435509983..43b9ebfbd943 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -12,6 +12,10 @@
>
>  #include <asm-generic/irq.h>
>
> +void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
> +
> +struct fwnode_handle *riscv_get_intc_hwnode(void);
> +
>  extern void __init init_IRQ(void);
>
>  #endif /* _ASM_RISCV_IRQ_H */
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 7207fa08d78f..96d3171f0ca1 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -7,9 +7,27 @@
>
>  #include <linux/interrupt.h>
>  #include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
>  #include <linux/seq_file.h>
>  #include <asm/smp.h>
>
> +static struct fwnode_handle *(*__get_intc_node)(void);
> +
> +void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void))
> +{
> +       __get_intc_node = fn;
> +}
> +
> +struct fwnode_handle *riscv_get_intc_hwnode(void)
> +{
> +       if (__get_intc_node)
> +               return __get_intc_node();
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(riscv_get_intc_hwnode);
> +
>  int arch_show_interrupts(struct seq_file *p, int prec)
>  {
>         show_ipi_stats(p, prec);
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index 499e5f81b3fe..9066467e99e4 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -92,6 +92,11 @@ static const struct irq_domain_ops riscv_intc_domain_ops = {
>         .xlate  = irq_domain_xlate_onecell,
>  };
>
> +static struct fwnode_handle *riscv_intc_hwnode(void)
> +{
> +       return intc_domain->fwnode;
> +}
> +
>  static int __init riscv_intc_init(struct device_node *node,
>                                   struct device_node *parent)
>  {
> @@ -126,6 +131,8 @@ static int __init riscv_intc_init(struct device_node *node,
>                 return rc;
>         }
>
> +       riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
> +
>         cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
>                           "irqchip/riscv/intc:starting",
>                           riscv_intc_cpu_starting,
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
-- 
Regards,
Atish
