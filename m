Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954185268F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383226AbiEMSEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244159AbiEMSEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:04:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D62CE3C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652465049; x=1684001049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mmVeSLOWGrrJNNPaH5sVqOAPJshfUhndaLU/q/Ct39k=;
  b=kzxU0mtXugMta8L+yVKIbg3yCQHXcn+0eSnjE5ghEPwncSPMrBR6VBZa
   TOmwzMcYQef5L5a+cGRpEV/RJc/hUKkYLmXBhHNbnukqrRJ9suWIRT8Xm
   OCK/9XmVhB+HhmcsHHGwzzjPpVpipVBxPZ0V/dxqsp0wtNq7ovh6uoy3+
   X+dnTe4UUSJQ0Zbl8mhVtwdrDCGUrzX50rX94uhQPfM0JNlcv3y2wvzux
   UXQbZlpMts2+JdTXuNCuK0MFnzi4LDNVJ7169QKWVLGlVZ7aYSzkPVpTR
   a+yKQqbNPzcWR1YoSpPaI8gbEovfUV6Voht0Gxeh0d876DAb3KWc1uUrY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="269214206"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="269214206"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 11:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="624962791"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 13 May 2022 11:04:09 -0700
Date:   Fri, 13 May 2022 11:07:44 -0700
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
Subject: Re: [PATCH v6 10/29] iommu/vt-d: Implement minor tweaks for NMI irqs
Message-ID: <20220513180744.GB22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-11-ricardo.neri-calderon@linux.intel.com>
 <87wneyfj90.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wneyfj90.ffs@tglx>
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

On Fri, May 06, 2022 at 11:23:23PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > The Intel IOMMU interrupt remapping driver already programs correctly the
> > delivery mode of individual irqs as per their irq_data. Improve handling
> > of NMIs. Allow only one irq per NMI. Also, it is not necessary to cleanup
> > irq vectors after updating affinity.
> 
> Structuring a changelog in paragraphs might make it readable. New lines
> exist for a reason.

Sure, I can structure this in paragraphps.
> 
> > NMIs do not have associated vectors.
> 
> Again. NMI has an vector associated, but it is not subject to dynamic
> vector management.

Indeed, it is clear to me now.

> 
> > diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> > index fb2d71bea98d..791a9331e257 100644
> > --- a/drivers/iommu/intel/irq_remapping.c
> > +++ b/drivers/iommu/intel/irq_remapping.c
> > @@ -1198,8 +1198,12 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
> >  	 * After this point, all the interrupts will start arriving
> >  	 * at the new destination. So, time to cleanup the previous
> >  	 * vector allocation.
> > +	 *
> > +	 * Do it only for non-NMI irqs. NMIs don't have associated
> > +	 * vectors.
> 
> See above.

Sure.

> 
> >  	 */
> > -	send_cleanup_vector(cfg);
> > +	if (cfg->delivery_mode != APIC_DELIVERY_MODE_NMI)
> > +		send_cleanup_vector(cfg);
> 
> So this needs to be replicated for all invocations of
> send_cleanup_vector(), right? Why can't you put it into that function?

Certainly, it can be done inside the function.

>   
> >  	return IRQ_SET_MASK_OK_DONE;
> >  }
> > @@ -1352,6 +1356,9 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
> >  	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
> >  		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
> >  
> > +	if ((info->flags & X86_IRQ_ALLOC_AS_NMI) && nr_irqs != 1)
> > +		return -EINVAL;
> 
> This cannot be reached when the vector allocation domain already
> rejected it, but copy & pasta is wonderful and increases the line count.

Yes, this is not needed.

Thanks and BR,
Ricardo
> 
> Thanks,
> 
>         tglx
> 
> 
