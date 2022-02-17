Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71804BA409
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiBQPMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:12:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242337AbiBQPM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:12:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6BFFD13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:12:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CA4E60B23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 15:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E34C340E8;
        Thu, 17 Feb 2022 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645110730;
        bh=KDQe45qlzMBNPOl7GlXQkYPjXodxLAhGokag+dlZ2zo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Htsc0XFIK2HdOEgDOn9Ppq1O7VCXWF1mVm/DLnbg80UCH11tmBi3Qhgw/VlDoh9nJ
         /WxEhkdqOmCMDR5lLGMt9adBXTVTD4y+4cbC9SFRQocfSbvLpTIZs99vZ89ldtSTwX
         3+qG/yFdRzhcEbBtprGCHBieGeE/BjWzsMWZCgkFTm6BgCm/+sHpyssV68Z5VDuw37
         R0xN1GJku5w6CaImS+9wwuzgMMmV9/1SrdUfoQDiBClDh8/85s6bZFii08uu6plEKr
         VVqAt8Qw/QwMDFEaQ5WkS1PKqMup2XGJN+2rSnL+LUhbmok8ck9ROcK/tVc58QZmEL
         KXfwYS7ZZuelg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nKiS0-008bzU-J7; Thu, 17 Feb 2022 15:12:08 +0000
MIME-Version: 1.0
Date:   Thu, 17 Feb 2022 15:12:08 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] irqchip/riscv-intc: Create domain using named
 fwnode
In-Reply-To: <20220128052505.859518-3-apatel@ventanamicro.com>
References: <20220128052505.859518-1-apatel@ventanamicro.com>
 <20220128052505.859518-3-apatel@ventanamicro.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <063b8a5636d6372f37029946b2c3e0f4@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: apatel@ventanamicro.com, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de, daniel.lezcano@linaro.org, atishp@atishpatra.org, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-28 05:25, Anup Patel wrote:
> We should create INTC domain using a synthetic fwnode which will allow
> drivers (such as RISC-V SBI IPI driver, RISC-V timer driver, RISC-V
> PMU driver, etc) not having dedicated DT/ACPI node to directly create
> interrupt mapping for standard local interrupt numbers defined by the
> RISC-V privileged specification.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/irq.h      |  2 ++
>  arch/riscv/kernel/irq.c           | 13 +++++++++++++
>  drivers/clocksource/timer-clint.c | 13 +++++++------
>  drivers/clocksource/timer-riscv.c | 11 ++---------
>  drivers/irqchip/irq-riscv-intc.c  | 12 ++++++++++--
>  drivers/irqchip/irq-sifive-plic.c | 19 +++++++++++--------
>  6 files changed, 45 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/irq.h 
> b/arch/riscv/include/asm/irq.h
> index e4c435509983..f85ebaf07505 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -12,6 +12,8 @@
> 
>  #include <asm-generic/irq.h>
> 
> +extern struct fwnode_handle *riscv_intc_fwnode(void);
> +
>  extern void __init init_IRQ(void);
> 
>  #endif /* _ASM_RISCV_IRQ_H */
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 7207fa08d78f..f2fed78ab659 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -7,9 +7,22 @@
> 
>  #include <linux/interrupt.h>
>  #include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
>  #include <linux/seq_file.h>
>  #include <asm/smp.h>
> 
> +static struct fwnode_handle *intc_fwnode;
> +
> +struct fwnode_handle *riscv_intc_fwnode(void)
> +{
> +	if (!intc_fwnode)
> +		intc_fwnode = irq_domain_alloc_named_fwnode("RISCV-INTC");
> +
> +	return intc_fwnode;
> +}
> +EXPORT_SYMBOL_GPL(riscv_intc_fwnode);

Why is this created outside of the root interrupt controller driver?
Furthermore, why do you need to create a new fwnode the first place?
As far as I can tell, the INTC does have a node, and what you don't
have is the firmware linkage between PMU (an others) and the INTC.

what you should have instead is something like:

static struct fwnode_handle *(*__get_root_intc_node)(void);
struct fwnode_handle *riscv_get_root_intc_hwnode(void)
{
         if (__get_root_intc_node)
                 return __get_root_intc_node();

         return NULL;
}

and the corresponding registration interface.

But either way, something breaks: the INTC has one node per CPU, and
expect one irqdomain per CPU. Having a single fwnode completely breaks
the INTC driver (and probably the irqdomain list, as we don't check for
duplicate entries).

> diff --git a/drivers/irqchip/irq-riscv-intc.c 
> b/drivers/irqchip/irq-riscv-intc.c
> index b65bd8878d4f..26ed62c11768 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -112,8 +112,16 @@ static int __init riscv_intc_init(struct 
> device_node *node,
>  	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
>  		return 0;
> 
> -	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
> -					    &riscv_intc_domain_ops, NULL);
> +	/*
> +	 * Create INTC domain using a synthetic fwnode which will allow
> +	 * drivers (such as RISC-V SBI IPI driver, RISC-V timer driver,
> +	 * RISC-V PMU driver, etc) not having dedicated DT/ACPI node to
> +	 * directly create interrupt mapping for standard local interrupt
> +	 * numbers defined by the RISC-V privileged specification.
> +	 */
> +	intc_domain = irq_domain_create_linear(riscv_intc_fwnode(),
> +					       BITS_PER_LONG,
> +					       &riscv_intc_domain_ops, NULL);

This is what I'm talking about. It is simply broken. So either you don't
need a per-CPU node (and the DT was bad the first place), or you 
absolutely need
one (and the whole 'well-known/default domain' doesn't work at all).

Either way, this patch is plain wrong.


         M.
-- 
Jazz is not dead. It just smells funny...
