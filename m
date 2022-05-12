Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BD152417B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349634AbiELAXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242707AbiELAXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:23:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B62016609F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652315009; x=1683851009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FXGLp4kn6zowFU/uMojpzoAT+8Tt5jfdv5yfT9ck7Mg=;
  b=K1EBet4/u5n6/ELIzR6ilyWceXrk06LR2c8MAlLk4wVj3zK7ZljQMBKL
   +Iq4x3IAtjE8IvGGp8ubcoG27z3v0FXt/ZPHZ2A0+ArOJgTNpy7VC3luK
   a9kwwpFJ8Bu3g7Gz9W5wZ6N42SssN1d6ykS8fE38uyDQgGsDINqXdLSfT
   3eXXrBB2Ai5fRKIui+1Mh4IAVAHdvV2OmV/17w1RT3WKZMXrvX7AYm0Tt
   c7jp1gzr9kVwtmrAEGY2LjrKS4sS+w3YRmVJl39+q9a1hMUgXWUx51GMW
   ntRHcL2+b2OmkN7l77BKUzu7sEi3SuN4VxincxW71qD8o4UjxXR/EqRuR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="332886070"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="332886070"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="594395631"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2022 17:23:27 -0700
Date:   Wed, 11 May 2022 17:26:58 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/29] x86/apic: Add irq_cfg::delivery_mode
Message-ID: <20220512002658.GB16273@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-3-ricardo.neri-calderon@linux.intel.com>
 <875ymih1yl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ymih1yl.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 09:53:54PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > Currently, the delivery mode of all interrupts is set to the mode of the
> > APIC driver in use. There are no restrictions in hardware to configure the
> > delivery mode of each interrupt individually. Also, certain IRQs need
> > to be
> 
> s/IRQ/interrupt/ Changelogs can do without acronyms.

Sure. I will sanitize all the changelogs to remove acronyms.

> 
> > configured with a specific delivery mode (e.g., NMI).
> >
> > Add a new member, delivery_mode, to struct irq_cfg. Subsequent changesets
> > will update every irq_domain to set the delivery mode of each IRQ to that
> > specified in its irq_cfg data.
> >
> > To keep the current behavior, when allocating an IRQ in the root
> > domain
> 
> The root domain does not allocate an interrupt. The root domain
> allocates a vector for an interrupt. There is a very clear and technical
> destinction. Can you please be more careful about the wording?

I will review the wording in the changelogs.

> 
> > --- a/arch/x86/kernel/apic/vector.c
> > +++ b/arch/x86/kernel/apic/vector.c
> > @@ -567,6 +567,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
> >  		irqd->chip_data = apicd;
> >  		irqd->hwirq = virq + i;
> >  		irqd_set_single_target(irqd);
> > +
> 
> Stray newline.

Sorry! I will remove it.
> 
> >  		/*
> >  		 * Prevent that any of these interrupts is invoked in
> >  		 * non interrupt context via e.g. generic_handle_irq()
> > @@ -577,6 +578,14 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
> >  		/* Don't invoke affinity setter on deactivated interrupts */
> >  		irqd_set_affinity_on_activate(irqd);
> >  
> > +		/*
> > +		 * Initialize the delivery mode of this irq to match the
> 
> s/irq/interrupt/

I will make this change.

Thanks and BR,
Ricardo

> 
> > +		 * default delivery mode of the APIC. Children irq domains
> > +		 * may take the delivery mode from the individual irq
> > +		 * configuration rather than from the APIC driver.
> > +		 */
> > +		apicd->hw_irq_cfg.delivery_mode = apic->delivery_mode;
> > +
> >  		/*
> >  		 * Legacy vectors are already assigned when the IOAPIC
> >  		 * takes them over. They stay on the same vector. This is
