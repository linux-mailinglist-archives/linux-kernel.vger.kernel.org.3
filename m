Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B88E473FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhLNJwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:52:16 -0500
Received: from foss.arm.com ([217.140.110.172]:50532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232688AbhLNJwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:52:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2677D6E;
        Tue, 14 Dec 2021 01:52:13 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E75D23F5A1;
        Tue, 14 Dec 2021 01:52:12 -0800 (PST)
Date:   Tue, 14 Dec 2021 09:52:07 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jay Chen <jkchen@linux.alibaba.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, zhangliguang@linux.alibaba.com
Subject: Re: [RFC PATCH] irqchip/gic-v4.1:fix the kdump GIC ITS RAS error for
 ITS BASER2
Message-ID: <20211214095207.GA26339@lpieralisi>
References: <20211214064716.21407-1-jkchen@linux.alibaba.com>
 <87h7bbk05r.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7bbk05r.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 09:26:08AM +0000, Marc Zyngier wrote:
> [+ Lorenzo, just in case...]

Thanks. I am away at the moment but definitely on this case. I believe
this is also an issue with a kexec'ed kernel (where we expect v4.1
functionality to be up and running in the kexec'ed kernel compared to a
kdump usecase), need to put something together and test it if someone
does not beat me to it.

Lorenzo

> Hi Jay,
> 
> Thanks for this.
> 
> On Tue, 14 Dec 2021 06:47:16 +0000,
> Jay Chen <jkchen@linux.alibaba.com> wrote:
> > 
> > We encounter a GIC RAS Error in below flow:
> > (1) Configure ITS related register (including
> > 	GITS_BASER2, GITS_BASER2.valid = 1'b1)
> > (2) Configure GICR related register (including
> > 	GICR_VPROPBASER, GICR_VPROPBASER.valid = 1'b1)
> > The common settings in above 2 register are the same
> > and currently everything is OK
> > (3) Kernel panic and os start the kdump flow.And then os
> > reconfigure ITS related register (including GITS_BASER2,
> > GITS_BASER2.valid = 1'b1). But at this time, gicr_vpropbaser
> > is not initialized, so it is still an old value. At this point,
> > the new value of its_baser2 and the old value of gicr_vpropbaser is
> > different, resulting in its RAS error.
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=215327
> 
> I'm sorry, but I don't have any access to this. Please add all the
> relevant details to the commit message and drop the link.
> 
> Could you please detail what HW this is on? The architecture
> specification for GICv4.1 doesn't make any mention of RAS error
> conditions, so this must be implementation specific. A reference to
> the TRM of the IP would certainly help.
> 
> Now, I think you have identified something interesting, but I'm not
> convinced by the implementation, see below.
> 
> > 
> > Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index eb0882d15366..c340bbf4427b 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -2623,6 +2623,12 @@ static int its_alloc_tables(struct its_node *its)
> >  			return err;
> >  		}
> >  
> > +		if ((i == 2) && is_kdump_kernel() && is_v4_1(its)) {
> > +			val = its_read_baser(its, baser);
> > +			val &= ~GITS_BASER_VALID;
> > +			its_write_baser(its, baser, val);
> > +		}
> 
> This looks like a very odd way to address the issue. You are silently
> disabling the Base Register containing the VPE table, and carry on as
> if nothing happened. What happen if someone starts a guest using
> direct injection at this point? A kdump kernel still is a full fledged
> kernel, and I don't expect it to behave differently.
> 
> If we are to make this work, we need to either disable the v4.1
> extension altogether or sanitise the offending registers so that we
> don't leave things in a bad state. My preference is of course the
> latter.
> 
> Could you please give this patch a go and let me know if it helps?
> 
> Thanks,
> 
> 	M.
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index daec3309b014..cb339ace5046 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -920,6 +920,15 @@ static int __gic_update_rdist_properties(struct redist_region *region,
>  {
>  	u64 typer = gic_read_typer(ptr + GICR_TYPER);
>  
> +	/* Boot-time cleanup */
> +	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
> +		u64 val;
> +
> +		val = gicr_read_vpropbaser(ptr + SZ_128K + GICR_VPROPBASER);
> +		val &= ~GICR_VPROPBASER_4_1_VALID;
> +		gicr_write_vpropbaser(val, ptr + SZ_128K + GICR_VPROPBASER);
> +	}
> +
>  	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
>  
>  	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
> 
> -- 
> Without deviation from the norm, progress is not possible.
