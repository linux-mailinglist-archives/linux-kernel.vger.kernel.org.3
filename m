Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA0A52415B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349560AbiELAGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349552AbiELAFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:05:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CEC13F1F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652313954; x=1683849954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iEGg3ZUCdx9uygbP/iQOaVPDEP0BAuMfZKqEQ1Cahnc=;
  b=dnMGvaTXHWuuTExgra1KNQ/YaJWLXwDZY3IY2u2jTWDTSwzW0QOt+n9X
   BuEEi3WZFEjOC/IyS9LoxDKm7dXgawfOGoW/q3SpaJpppFIk7aElieQQK
   bAOOJgYlNPju5LEYICGrGMSHkYW411W0r5YR0lRIihzSKoSBTAr2/Eqij
   76UIGnXl6+ousI702WdCErVxQPHfcncu6etVxZW+E1CtKSWA0EiU3AC2p
   3a7EwE0C4bHrX5yXaP/B1KLHobxDi82IlpEhQ+7udj1rLpI/O2BLfCLd5
   VEj6O8yRAswmaWI8WFVlYLVi4M57ugSw3PVPxsqZwAWTmrsGdFRPNMmOt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="330448449"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="330448449"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="658374063"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 11 May 2022 17:05:53 -0700
Date:   Wed, 11 May 2022 17:09:24 -0700
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
Subject: Re: [PATCH v6 01/29] irq/matrix: Expose functions to allocate the
 best CPU for new vectors
Message-ID: <20220512000924.GA16273@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-2-ricardo.neri-calderon@linux.intel.com>
 <878rreh27n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rreh27n.ffs@tglx>
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

On Fri, May 06, 2022 at 09:48:28PM +0200, Thomas Gleixner wrote:
> Ricardo,

Thank you very much for your feedback Thomas! I am sorry for my late reply, I
had been out of office.

> 
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > Certain types of interrupts, such as NMI, do not have an associated vector.
> > They, however, target specific CPUs. Thus, when assigning the destination
> > CPU, it is beneficial to select the one with the lowest number of
> > vectors.
> 
> Why is that beneficial especially in the context of a NMI watchdog which
> then broadcasts the NMI to all other CPUs?

My intent was not the NMI watchdog specifically but potential use cases that do
not involve NMI broadcasts. If the NMI targets a single CPU, it is best to
select the CPU with the lowest vector allocation count.

> 
> That's wishful thinking perhaps, but I don't see any benefit at all.
> 
> > Prepend the functions matrix_find_best_cpu_managed() and
> > matrix_find_best_cpu_managed()
> 
> The same function prepended twice becomes two functions :)
> 

Sorry, I missed this.

> > with the irq_ prefix and expose them for
> > IRQ controllers to use when allocating and activating vector-less IRQs.
> 
> There is no such thing like a vectorless IRQ. NMIs have a vector. Can we
> please describe facts and not pulled out of thin air concepts which do
> not exist?

Thank you for the clarification. I see your point. I wrote this patch because
maskable interrupts and NMIs have different entry points. As you state,
however, the also have a vector.

I can drop this patch.

BR,
Ricardo

> 
> Thanks,
> 
>         tglx
