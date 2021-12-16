Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38AF477C27
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbhLPTDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:03:23 -0500
Received: from foss.arm.com ([217.140.110.172]:47534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233828AbhLPTDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:03:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 504E112FC;
        Thu, 16 Dec 2021 11:03:22 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8375D3F774;
        Thu, 16 Dec 2021 11:03:21 -0800 (PST)
Date:   Thu, 16 Dec 2021 19:03:15 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        kernel-team@android.com, Jay Chen <jkchen@linux.alibaba.com>
Subject: Re: [PATCH] irqchip/gic-v4: Disable redistributors' view of the VPE
 table at boot time
Message-ID: <20211216190315.GA14220@lpieralisi>
References: <20211216144804.1578566-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216144804.1578566-1-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 02:48:04PM +0000, Marc Zyngier wrote:
> Jay Chen reported that using a kdump kernel on a GICv4.1 system
> results in a RAS error being delivered when the secondary kernel
> configures the ITS's view of the new VPE table.
> 
> As it turns out, that's because each RD still has a pointer to
> the previous instance of the VPE table, and that particular
> implementation is very upset by seeing two bits of the HW that
> should point to the same table with different values.
> 
> To solve this, let's invalidate any reference that any RD has to
> the VPE table when discovering the RDs. The ITS can then be
> programmed as expected.

It makes sense. I believe there is an additional question though,
related to ITSes sharing the VPE table (SVPET) with RDs.

IIUC, all ITSes within a given affinity (that therefore are sharing the
VPE table) need to be quiesced before allocating a new VPE table.

Again, I am off the radar for a while and this patch makes sense on its
own, just raising the question since I was trying to understand whether
that can be an additional issue to solve on kexec; I will follow up
on this query.

It would be nice to know Alibaba's GIC HW topology if possible.

Thanks for putting together the fix and merging it.

Lorenzo

> Reported-by: Jay Chen <jkchen@linux.alibaba.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Link: https://lore.kernel.org/r/20211214064716.21407-1-jkchen@linux.alibaba.com
> ---
>  drivers/irqchip/irq-gic-v3.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index daec3309b014..86397522e786 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -920,6 +920,22 @@ static int __gic_update_rdist_properties(struct redist_region *region,
>  {
>  	u64 typer = gic_read_typer(ptr + GICR_TYPER);
>  
> +	/* Boot-time cleanip */
> +	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
> +		u64 val;
> +
> +		/* Deactivate any present vPE */
> +		val = gicr_read_vpendbaser(ptr + SZ_128K + GICR_VPENDBASER);
> +		if (val & GICR_VPENDBASER_Valid)
> +			gicr_write_vpendbaser(GICR_VPENDBASER_PendingLast,
> +					      ptr + SZ_128K + GICR_VPENDBASER);
> +
> +		/* Mark the VPE table as invalid */
> +		val = gicr_read_vpropbaser(ptr + SZ_128K + GICR_VPROPBASER);
> +		val &= ~GICR_VPROPBASER_4_1_VALID;
> +		gicr_write_vpropbaser(val, ptr + SZ_128K + GICR_VPROPBASER);
> +	}
> +
>  	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
>  
>  	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
> -- 
> 2.30.2
> 
