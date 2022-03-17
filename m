Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E964DCC92
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiCQRgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiCQRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:36:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 924C2C74BA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:35:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52EE71682;
        Thu, 17 Mar 2022 10:35:26 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.7.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00A9B3F7B4;
        Thu, 17 Mar 2022 10:35:24 -0700 (PDT)
Date:   Thu, 17 Mar 2022 17:35:23 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 2/3] irqchip/gic-v3: Detect LPI invalidation MMIO
 registers
Message-ID: <YjNxW5iFIYFApshg@lpieralisi>
References: <20220315165034.794482-1-maz@kernel.org>
 <20220315165034.794482-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315165034.794482-3-maz@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:50:33PM +0000, Marc Zyngier wrote:
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
>  
>  	/* Boot-time cleanip */
>  	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
> @@ -941,6 +945,7 @@ static int __gic_update_rdist_properties(struct redist_region *region,
>  	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
>  	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
>  	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
> +					   !!(ctlr & GICR_CTLR_IR) |
>  					   gic_data.rdists.has_rvpeid);
>  	gic_data.rdists.has_vpend_valid_dirty &= !!(typer & GICR_TYPER_DIRTY);
>  
> @@ -962,7 +967,11 @@ static void gic_update_rdist_properties(void)
>  	gic_iterate_rdists(__gic_update_rdist_properties);
>  	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
>  		gic_data.ppi_nr = 0;
> -	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
> +	pr_info("GICv3 features: %d PPIs, %s%s\n",
> +		gic_data.ppi_nr,
> +		gic_data.has_rss ? "RSS " : "",
> +		gic_data.rdists.has_direct_lpi ? "DirectLPI " : "");

I understand GICR_CTLR.IR detection (which is v4.1 feature) - I don't
get why in this patch we are adding a GICv3 DirectLPI info dump (hunk
above), it is probably nitpicking but the hunk above does not seem to
belong in this patch - it is a separate print info refactoring or I am
reading it wrongly.

Lorenzo

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
>  #define GICR_CTLR_RWP			(1UL << 3)
>  
>  #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
> -- 
> 2.34.1
> 
