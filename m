Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACF449259D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbiARMVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:21:22 -0500
Received: from foss.arm.com ([217.140.110.172]:55324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239364AbiARMVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:21:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82CEDD6E;
        Tue, 18 Jan 2022 04:21:20 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B84253F73D;
        Tue, 18 Jan 2022 04:21:19 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:21:13 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        kernel-team@android.com, Jay Chen <jkchen@linux.alibaba.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Reset each ITS's BASERn register
 before probe
Message-ID: <20220118122113.GA18876@lpieralisi>
References: <20220117161910.2041761-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117161910.2041761-1-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 04:19:10PM +0000, Marc Zyngier wrote:
> A recent bug report outlined that the way GICv4.1 is handled across
> kexec is pretty bad. We can end-up in a situation where ITSs share
> memory (this is the case when SVPEPT==1) and reprogram the base

SVPET

> registers, creating a situation where ITSs that are part of a given
> affinity group see different pointers. Which is illegal. Boo.
> 
> In order to restore some sanity, reset the BASERn registers to 0
> *before* probing any ITS. Although this isn't optimised at all,
> this is only a once-per-boot cost, which shouldn't show up on
> anyone's radar.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Jay Chen <jkchen@linux.alibaba.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20211216190315.GA14220@lpieralisi
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 106 +++++++++++++++++++++++++------
>  1 file changed, 87 insertions(+), 19 deletions(-)

Thank you for the patch Marc.

> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index ee83eb377d7e..9d68afe9fa86 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4856,6 +4856,38 @@ static struct syscore_ops its_syscore_ops = {
>  	.resume = its_restore_enable,
>  };
>  
> +static void __init __iomem *its_map_one(struct resource *res, int *err)
> +{
> +	void __iomem *its_base;
> +	u32 val;
> +
> +	its_base = ioremap(res->start, SZ_64K);
> +	if (!its_base) {
> +		pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
> +		*err = -ENOMEM;
> +		return NULL;
> +	}
> +
> +	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
> +	if (val != 0x30 && val != 0x40) {
> +		pr_warn("ITS@%pa: No ITS detected, giving up\n", &res->start);
> +		*err = -ENODEV;
> +		goto out_unmap;
> +	}
> +
> +	*err = its_force_quiescent(its_base);
> +	if (*err) {
> +		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &res->start);
> +		goto out_unmap;
> +	}
> +
> +	return its_base;
> +
> +out_unmap:
> +	iounmap(its_base);
> +	return NULL;
> +}
> +
>  static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
>  {
>  	struct irq_domain *inner_domain;
> @@ -4963,29 +4995,14 @@ static int __init its_probe_one(struct resource *res,
>  {
>  	struct its_node *its;
>  	void __iomem *its_base;
> -	u32 val, ctlr;
>  	u64 baser, tmp, typer;
>  	struct page *page;
> +	u32 ctlr;
>  	int err;
>  
> -	its_base = ioremap(res->start, SZ_64K);
> -	if (!its_base) {
> -		pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
> -		return -ENOMEM;
> -	}
> -
> -	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
> -	if (val != 0x30 && val != 0x40) {
> -		pr_warn("ITS@%pa: No ITS detected, giving up\n", &res->start);
> -		err = -ENODEV;
> -		goto out_unmap;
> -	}
> -
> -	err = its_force_quiescent(its_base);
> -	if (err) {
> -		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &res->start);
> -		goto out_unmap;
> -	}
> +	its_base = its_map_one(res, &err);
> +	if (!its_base)
> +		return err;
>  
>  	pr_info("ITS %pR\n", res);
>  
> @@ -5248,6 +5265,22 @@ static int its_cpu_memreserve_lpi(unsigned int cpu)
>  	return ret;
>  }
>  
> +/* Mark all the BASER registers as invalid before they get reprogrammed */
> +static void __init its_reset_one(struct resource *res)
> +{
> +	void __iomem *its_base;
> +	int err, i;
> +
> +	its_base = its_map_one(res, &err);
> +	if (!its_base)
> +		return;
> +
> +	for (i = 0; i < GITS_BASER_NR_REGS; i++)
> +		gits_write_baser(0, its_base + GITS_BASER + (i << 3));
> +
> +	iounmap(its_base);
> +}
> +
>  static const struct of_device_id its_device_id[] = {
>  	{	.compatible	= "arm,gic-v3-its",	},
>  	{},
> @@ -5258,6 +5291,22 @@ static int __init its_of_probe(struct device_node *node)
>  	struct device_node *np;
>  	struct resource res;
>  
> +	/*
> +	 * Make sure *all* the ITS are reset before we probe any, as
> +	 * they may be sharing memory. Don't bother warning on the
> +	 * first iteration, as any error will be caught on the second
> +	 * one.
> +	 */
> +	for (np = of_find_matching_node(node, its_device_id); np;
> +	     np = of_find_matching_node(np, its_device_id)) {
> +		if (!of_device_is_available(np) ||
> +		    !of_property_read_bool(np, "msi-controller") ||
> +		    of_address_to_resource(np, 0, &res))
> +			continue;
> +
> +		its_reset_one(&res);

This all makes sense to me, only one question (commenting on the DT
path but that's obviously valid for ACPI below as well).

We are not checking whether the reset was successful. Is it remotely
possible that we fail to quiesce an ITS (and reset its GITS_BASER)
while being able to probe other ITSes within the same affinity ?

Overthinking, agreed, just asking if we should not just bail
out whenever *any* ITS reset fails (though that looks a tad harsh,
we don't know at this stage whether some ITSes are siblings).

Don't know, only open question I have, otherwise the patch looks good
to me.

Thanks,
Lorenzo

> +	}
> +
>  	for (np = of_find_matching_node(node, its_device_id); np;
>  	     np = of_find_matching_node(np, its_device_id)) {
>  		if (!of_device_is_available(np))
> @@ -5420,9 +5469,28 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
>  	return err;
>  }
>  
> +static int __init its_acpi_reset(union acpi_subtable_headers *header,
> +				 const unsigned long end)
> +{
> +	struct acpi_madt_generic_translator *its_entry;
> +	struct resource res;
> +
> +	its_entry = (struct acpi_madt_generic_translator *)header;
> +	res = (struct resource) {
> +		.start	= its_entry->base_address,
> +		.end	= its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1,
> +		.flags	= IORESOURCE_MEM,
> +	};
> +
> +	its_reset_one(&res);
> +	return 0;
> +}
> +
>  static void __init its_acpi_probe(void)
>  {
>  	acpi_table_parse_srat_its();
> +	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
> +			      its_acpi_reset, 0);
>  	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
>  			      gic_acpi_parse_madt_its, 0);
>  	acpi_its_srat_maps_free();
> -- 
> 2.30.2
> 
