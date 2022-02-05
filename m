Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711CB4AA6B7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 06:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiBEFKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 00:10:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:48795 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbiBEFKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 00:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644037816; x=1675573816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JcX/1EZirCjM105wSMia+he9amGan4vf2Bw07F+RiJM=;
  b=Qxd9jDC6yQpwGIL5UPkzr/yRWQ6aFGRZ7Du/5msTHwNRyk8D+QCkn3X9
   CVLyxrkmf21B4zJrYUoZTgAHddNOXVMm3ucyAXZ9ccH463Hd5diw5QuE/
   LqohRIC/oR0cBlpEDNEcd7wra1i4AVABfTp7kgLpvwC93ktvd8S/eRFIy
   KLR2honnftt2z8pFqhYU2uiPuoSq4okBJQPSvsSpyZ2jSLRJ7N4csWkoe
   S6+Bp6aKg5XWXNbcV3jycT8AE5QT6q7dtXW+K480/DZyIpdX0Uinaato4
   Bo8vH9hA+B1UgMs9WlXaQKehcogmh9GDWzKtSIcQc+cLpFQvR9yyA+4ts
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248251597"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248251597"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 21:10:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="539426486"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 21:10:15 -0800
Date:   Fri, 4 Feb 2022 21:10:14 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Yf4Gtm5pu+e2whSE@otcwcpicx3.sc.intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-6-fenghua.yu@intel.com>
 <6ace7131-4671-6956-944f-df01e5d63470@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ace7131-4671-6956-944f-df01e5d63470@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Baolu,
On Sat, Feb 05, 2022 at 11:50:59AM +0800, Lu Baolu wrote:
> Hi Fenghua,
> 
> On 2022/1/29 4:28, Fenghua Yu wrote:
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 92fea3fbbb11..ef03b2176bbd 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -4781,7 +4781,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
> >   link_failed:
> >   	spin_unlock_irqrestore(&device_domain_lock, flags);
> >   	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> > -		ioasid_put(domain->default_pasid);
> > +		ioasid_free(domain->default_pasid);
> >   	return ret;
> >   }
> > @@ -4811,7 +4811,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
> >   	spin_unlock_irqrestore(&device_domain_lock, flags);
> >   	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> > -		ioasid_put(domain->default_pasid);
> > +		ioasid_free(domain->default_pasid);
> >   }
> >   static int prepare_domain_attach_device(struct iommu_domain *domain,
> 
> The domain->default_pasid is not relevant to SVA and it's being cleaned
> up by another series. No need to take care of it in this series.

Because ioasid_put() is renamed to ioasid_free() in this patch, without
above changes, this series cannot be compiled.

Thomas and I discussed how to handle aux_domain while you will remove
the entire aux_domain code (https://lore.kernel.org/lkml/87zgnf29op.ffs@tglx/).
The above changes are minimal and temporary changes to compile this series.
The changes will be removed along with the entire aux_domain by your
removing aux_domain series later in 5.18.

Thanks.

-Fenghua

