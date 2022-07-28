Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FCA583F55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiG1M4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiG1M4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:56:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A452F46DAC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42671B82445
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1151C433D6;
        Thu, 28 Jul 2022 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659012988;
        bh=VrARDON6MbbsGtnH+7r+BZjRFSap/yVpLEOwumEtuAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S59vQ7Z9gA8wdVLPDSCycoXdtrLb9uTdzJ0uF35hf5YoD/AVjT3eLxX7F9hc4isVK
         Z8h23/W0nPWIWXzOSS7uFHMKruxJGUgMrKPCeNhX2ph0B2rDlQc1b7MqBDVhMPKG0y
         WTlCqRKJkU2+74A3l200mVLrzBAcUr2X8KcAKIO0rQAUSoEdEWlfqPZhIE6xSLpeEW
         FtTBJNrRHXdtlqPTlTTM3clgYNVd2S2IR7h1Xae9mzGcPy4KASpnF4Jld95DKcURSk
         QECj85NpuHcLj0rDCWp/jFdAtNaDX35hQpnEXBz+ZPaiNhmI1s1AGgo/LDuU0t8u1s
         Qmzto7H8wH1zw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oH34D-0000Bz-Pr; Thu, 28 Jul 2022 14:56:42 +0200
Date:   Thu, 28 Jul 2022 14:56:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] irqdomain: Fix mapping-creation race
Message-ID: <YuKHiZuNvN+K9NCc@hovoldconsulting.com>
References: <20220728092710.21190-1-johan+linaro@kernel.org>
 <87wnbxwj94.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnbxwj94.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 12:48:23PM +0100, Marc Zyngier wrote:
> On Thu, 28 Jul 2022 10:27:10 +0100,
> Johan Hovold <johan+linaro@kernel.org> wrote:
> > 
> > Parallel probing (e.g. due to asynchronous probing) of devices that share
> > interrupts can currently result in two mappings for the same hardware
> > interrupt to be created.
> 
> And I thought nobody would be using shared interrupts anymore. Turns
> out people are still building braindead HW... :-/
> 
> > 
> > Add a serialising mapping mutex so that looking for an existing mapping
> > before creating a new one is done atomically.
> > 
> > Note that serialising the lookup and creation in
> > irq_create_mapping_affinity() would have been enough to prevent the
> > duplicate mapping, but that could instead cause
> > irq_create_fwspec_mapping() to fail when there is a race.
> > 
> > Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
> > Fixes: b62b2cf5759b ("irqdomain: Fix handling of type settings for existing mappings")
> > Cc: Dmitry Torokhov <dtor@chromium.org>
> > Cc: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  kernel/irq/irqdomain.c | 46 +++++++++++++++++++++++++++++++-----------
> >  1 file changed, 34 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> > index 8fe1da9614ee..d263a7dd4170 100644
> > --- a/kernel/irq/irqdomain.c
> > +++ b/kernel/irq/irqdomain.c
> > @@ -22,6 +22,7 @@
> >  
> >  static LIST_HEAD(irq_domain_list);
> >  static DEFINE_MUTEX(irq_domain_mutex);
> > +static DEFINE_MUTEX(irq_mapping_mutex);
> 
> I'd really like to avoid a global mutex. At the very least this should
> be a per-domain mutex, otherwise this will serialise a lot more than
> what is needed.

Yeah, I considered that too, but wanted to get your comments on this
first.

Also note that the likewise global irq_domain_mutex (and
sparse_irq_lock) are taken in some of these paths so perhaps using finer
locking won't actually matter that much as this is mostly for parallel
probing.

> >  
> >  static struct irq_domain *irq_default_domain;
> >  
> > @@ -669,7 +670,7 @@ EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
> >  #endif
> >  
> >  /**
> > - * irq_create_mapping_affinity() - Map a hardware interrupt into linux irq space
> > + * __irq_create_mapping_affinity() - Map a hardware interrupt into linux irq space
> >   * @domain: domain owning this hardware interrupt or NULL for default domain
> >   * @hwirq: hardware irq number in that domain space
> >   * @affinity: irq affinity
> > @@ -679,9 +680,9 @@ EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
> >   * If the sense/trigger is to be specified, set_irq_type() should be called
> >   * on the number returned from that call.
> >   */
> 
> This comment should be moved to the exported function, instead of
> documenting something that nobody can call...

Yes, of course. I looked at the kernel doc for another
double-underscore-prefixed function, but those are all exported.
 
> > -unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
> > -				       irq_hw_number_t hwirq,
> > -				       const struct irq_affinity_desc *affinity)
> > +static unsigned int __irq_create_mapping_affinity(struct irq_domain *domain,
> > +						  irq_hw_number_t hwirq,
> > +						  const struct irq_affinity_desc *affinity)
> >  {
> >  	struct device_node *of_node;
> >  	int virq;
> > @@ -724,6 +725,19 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
> >  
> >  	return virq;
> >  }
> > +
> > +unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
> > +					 irq_hw_number_t hwirq,
> > +					 const struct irq_affinity_desc *affinity)
> > +{
> > +	unsigned int virq;
> > +
> > +	mutex_lock(&irq_mapping_mutex);
> > +	virq = __irq_create_mapping_affinity(domain, hwirq, affinity);
> > +	mutex_unlock(&irq_mapping_mutex);
> > +
> > +	return virq;
> > +}
> >  EXPORT_SYMBOL_GPL(irq_create_mapping_affinity);
> >  
> >  static int irq_domain_translate(struct irq_domain *d,
> > @@ -789,6 +803,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> >  	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
> >  		type &= IRQ_TYPE_SENSE_MASK;
> >  
> > +	mutex_lock(&irq_mapping_mutex);
> > +
> >  	/*
> >  	 * If we've already configured this interrupt,
> >  	 * don't do it again, or hell will break loose.
> > @@ -801,7 +817,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> >  		 * interrupt number.
> >  		 */
> >  		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
> > -			return virq;
> > +			goto out;
> >  
> >  		/*
> >  		 * If the trigger type has not been set yet, then set
> > @@ -810,26 +826,26 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> >  		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
> >  			irq_data = irq_get_irq_data(virq);
> >  			if (!irq_data)
> > -				return 0;
> > +				goto err;
> >  
> >  			irqd_set_trigger_type(irq_data, type);
> > -			return virq;
> > +			goto out;
> >  		}
> >  
> >  		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
> >  			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
> > -		return 0;
> > +		goto err;
> >  	}
> >  
> >  	if (irq_domain_is_hierarchy(domain)) {
> >  		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
> >  		if (virq <= 0)
> > -			return 0;
> > +			goto err;
> >  	} else {
> >  		/* Create mapping */
> > -		virq = irq_create_mapping(domain, hwirq);
> > +		virq = __irq_create_mapping_affinity(domain, hwirq, NULL);
> 
> This rechecks for the existence of the mapping. Surely we can do a bit
> better by rejigging this (admittedly bitrotting) code.

I'm sure we can. Should I try to fix the race first with a patch like
this one that can potentially be backported, and then see what I can do
about cleaning this up?

After all it has looked like this for the past eight years since when
this code was first merged.

Johan
