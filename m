Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74B94DB3BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356901AbiCPOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiCPOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:53:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1FB565804
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:52:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 755931515;
        Wed, 16 Mar 2022 07:52:40 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BD143F7D7;
        Wed, 16 Mar 2022 07:52:39 -0700 (PDT)
Date:   Wed, 16 Mar 2022 14:51:58 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 2/3] irqchip/gic-v3: Detect LPI invalidation MMIO
 registers
Message-ID: <20220316145141.44d20486@slackpad.lan>
In-Reply-To: <20220315165034.794482-3-maz@kernel.org>
References: <20220315165034.794482-1-maz@kernel.org>
        <20220315165034.794482-3-maz@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 16:50:33 +0000
Marc Zyngier <maz@kernel.org> wrote:

Hi,

> Since GICv4.1, an implementation can offer the same MMIO-based
> implementation as DirectLPI, only with an ITS. Given that this
> can be hugely beneficial for workloads that are very LPI masking
> heavy (although these workloads are admitedly a bit odd).
> 
> Interestingly, this is independent of RVPEI, which only *implies*
> the functionnality.
> 
> So let's detect whether the implementation has GICR_CTLR.IR set,
> and propagate this as DirectLPI to the ITS driver.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3.c       | 15 +++++++++++----
>  include/linux/irqchip/arm-gic-v3.h |  2 ++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 736163d36b13..363bfe172033 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -918,7 +918,11 @@ static int gic_populate_rdist(void)
>  static int __gic_update_rdist_properties(struct redist_region *region,
>  					 void __iomem *ptr)
>  {
> -	u64 typer = gic_read_typer(ptr + GICR_TYPER);
> +	u64 typer;
> +	u32 ctlr;
> +
> +	typer = gic_read_typer(ptr + GICR_TYPER);
> +	ctlr = readl_relaxed(ptr + GICR_CTLR);

Is there any reason you didn't keep this together? I thought this was
recommended, in general?

>  
>  	/* Boot-time cleanip */
>  	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
> @@ -941,6 +945,7 @@ static int __gic_update_rdist_properties(struct redist_region *region,
>  	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
>  	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
>  	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
> +					   !!(ctlr & GICR_CTLR_IR) |

So this means that has_direct_lpi is not really correct anymore, as the
IR bit only covers the INVL and SYNCR registers, not the GICR_SETLPIR
and GICR_CLRLPIR registers, if I understand the spec correctly?

But I guess this is nitpicking, as we don't use direct LPIs at all in
Linux? And I guess the target is lpi_update_config(), which now doesn't
need the command queue anymore?

Maybe this could be clarified in the commit message?

>  					   gic_data.rdists.has_rvpeid);
>  	gic_data.rdists.has_vpend_valid_dirty &= !!(typer & GICR_TYPER_DIRTY);
>  
> @@ -962,7 +967,11 @@ static void gic_update_rdist_properties(void)
>  	gic_iterate_rdists(__gic_update_rdist_properties);
>  	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
>  		gic_data.ppi_nr = 0;
> -	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
> +	pr_info("GICv3 features: %d PPIs, %s%s\n",

I like having that on one line, but it looks a bit odd with the
trailing comma when we have neither RSS nor DirectLPI.
What about:
	pr_info("GICv3 features: %d PPIs%s%s\n",
	gic_data.ppi_nr,
	gic_data.has_rss ? ", RSS" : "",
	gic_data.rdists.has_direct_lpi ? ", DirectLPI" : "");

> +		gic_data.ppi_nr,
> +		gic_data.has_rss ? "RSS " : "",
> +		gic_data.rdists.has_direct_lpi ? "DirectLPI " : "");
> +	
>  	if (gic_data.rdists.has_vlpis)
>  		pr_info("GICv4 features: %s%s%s\n",
>  			gic_data.rdists.has_direct_lpi ? "DirectLPI " : "",
> @@ -1797,8 +1806,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
>  
>  	gic_data.has_rss = !!(typer & GICD_TYPER_RSS);
> -	pr_info("Distributor has %sRange Selector support\n",
> -		gic_data.has_rss ? "" : "no ");
>  
>  	if (typer & GICD_TYPER_MBIS) {
>  		err = mbi_init(handle, gic_data.domain);
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 12d91f0dedf9..aeb8ced53880 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -127,6 +127,8 @@
>  #define GICR_PIDR2			GICD_PIDR2
>  
>  #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
> +#define GICR_CTLR_IR			(1UL << 1)
> +#define GICR_CTLR_CES			(1UL << 2)

As Oliver (and you) already pointed out, this is swapped.

Cheers,
Andre

>  #define GICR_CTLR_RWP			(1UL << 3)
>  
>  #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)

