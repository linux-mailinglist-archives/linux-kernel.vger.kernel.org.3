Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6340F49F12D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbiA1CmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:42:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:3811 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241696AbiA1CmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643337725; x=1674873725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qJGD54+z4s9uimUk4jVCMGmOmDNCKMZ5udJCxiNXpGY=;
  b=I5pvLefs1Y9bdUIq9J39wwpJlzzYFW2Xah+Q3xoE8/uWr4BlvEkWmJTE
   +y8j9N2WKuPECJna10wLtigUb/omA53NRXysmhYY+VYtsB1BlY3vmooDj
   6mLKXzP8r9zAQjRGw7pkbuGlypHj77KN27fsJkpAdBGyGhQCLqr+DVByz
   n65mtZE2hl2TJFzwYvrp+nt8zubVNT3WV6474291WmAXxZSyZzugK5dYO
   faCEPT9F3460bhTPlNWGe2t0CWq0aztcDp3XFw794nZ35IKO+gFE6TV5n
   CrDZh2W+gck//UJztqf++zM3RBNk9Q8gFCEHS8I/4ph6IBpbJT8YfLB4Z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="247247720"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="247247720"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:42:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="769962897"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:42:05 -0800
Date:   Thu, 27 Jan 2022 18:42:00 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YfNVBzN67rSu/QcE@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com>
 <87ee4w6g1n.ffs@tglx>
 <87bl006fdb.ffs@tglx>
 <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
 <878rv46eg3.ffs@tglx>
 <YfAUutQhqS6ejUFU@otcwcpicx3.sc.intel.com>
 <87k0em4lu9.ffs@tglx>
 <YfGGk7kWNc9q2YwV@otcwcpicx3.sc.intel.com>
 <8735la41qb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735la41qb.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Wed, Jan 26, 2022 at 10:38:04PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 26 2022 at 09:36, Fenghua Yu wrote:
> > On Wed, Jan 26, 2022 at 03:23:42PM +0100, Thomas Gleixner wrote:
> >> On Tue, Jan 25 2022 at 07:18, Fenghua Yu wrote:
> >> While looking at ioasid_put() usage I tripped over the following UAF
> >> issue:
> >> 
> >> --- a/drivers/iommu/intel/iommu.c
> >> +++ b/drivers/iommu/intel/iommu.c
> >> @@ -4817,8 +4817,10 @@ static int aux_domain_add_dev(struct dma
> >>  	auxiliary_unlink_device(domain, dev);
> >>  link_failed:
> >>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> >> -	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> >> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
> >>  		ioasid_put(domain->default_pasid);
> >> +		domain->default_pasid = INVALID_IOASID;
> >> +	}
> >>  
> >>  	return ret;
> >>  }
> >> @@ -4847,8 +4849,10 @@ static void aux_domain_remove_dev(struct
> >>  
> >>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> >>  
> >> -	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> >> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
> >>  		ioasid_put(domain->default_pasid);
> >> +		domain->default_pasid = INVALID_IOASID;
> >> +	}
> >>  }
> >>  
> >>  static int prepare_domain_attach_device(struct iommu_domain *domain,
> >
> > The above patch fixes an existing issue. I will put it in a separate patch,
> > right?
> 
> Correct.
> 
> > It cannot be applied cleanly to the upstream tree. Do you want me to base
> > the above patch (and the whole patch set) to the upstream tree or a specific
> > tip branch?
> 
> Against Linus tree please so that the bugfix applies.
> 
> > I will fold the following patch into patch #5. The patch #11 (the doc patch)
> > also needs to remove one paragraph talking about refcount.
> >
> > So I will send the whole patch set with the following changes:
> > 1. One new bug fix patch (the above patch)

When I study your above aux_domain bug fix path, I find more aux_domain bugs.
But then I find aux_domain will be completely removed because all aux_domain
related callbacks are not called and are dead code (no wonder there are
so many bugs in aux_domain). Please see this series: https://lore.kernel.org/linux-iommu/20220124071103.2097118-4-baolu.lu@linux.intel.com/
For the series, Baolu confirms that he is "pretty sure that should be part
of v5.18". And I don't find the series calls any IOASID function after
removing the aux_domain code.

So that means we don't need to fix those issues in the dead aux_domain
code any more because it will be completely removed in 5.18, right?

If you agree, I will not include the aux_domain fix patch or any other
aux_domain fix patches in the up-coming v3. Is that OK?

> > 2. Updated patch #5 (with the following patch folded)

I will still change ioasid_put() in the aux_domain callbacks to ioasid_free()
in patch #5. So compilation will pass. Baolu's series will remove
the entire aux_domain code in 5.18.

> > 3. Updated patch #11 (removing refcount description)
> 
> Looks good.
> 

Thanks.

-Fenghua
