Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BAD4DA533
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352181AbiCOWVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbiCOWVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:21:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA55C649
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647382803; x=1678918803;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ftAV5fWCIIwIFJtTVZEpph+lygZNASFk6VFTJssfJdE=;
  b=WVh98egR+O3cGUfe68zUSR1OsAOspJvmuNTIs7hQ6yRl4YENnuFAwlPj
   ImlF2KPDxoDmmGx34WhIw1JTVXrsgpClMjO0D/0qSSWddY3btZFleIm+A
   yq0Bn3U9akAKW91gK/VgUQefQ/KqCI/BxnVZP+VpyiqIv2XKeX71seiQ9
   DzM55VjFt36YYYroWc5LvU4bOFkjfCK9Ht5V28BaKXNwzQPzOylypNiUA
   cLM4WJqYZDuQZPOf3/YFvl9+XhH+jePeg2hhIXUluMCQ+HVWgWB4nqsE5
   4xbp5qmMa53+FoVdofrrM5lhgw7WGkEXthX/85tGisWwu2O+Zg1L3GJ5w
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256158402"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256158402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 15:20:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="557137205"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 15:20:02 -0700
Date:   Tue, 15 Mar 2022 15:23:18 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220315152318.262dd0bf@jacob-builder>
In-Reply-To: <BN9PR11MB52768A46ED515D2E02FFEF5D8C109@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB52768A46ED515D2E02FFEF5D8C109@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Tue, 15 Mar 2022 10:33:08 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > 
> > On VT-d platforms with scalable mode enabled, devices issue DMA requests
> > with PASID need to attach to the correct IOMMU domains.
> > The attach operation involves the following:
> > - programming the PASID into device's PASID table
> > - tracking device domain and the PASID relationship
> > - managing IOTLB and device TLB invalidations
> > 
> > This patch extends DMAR domain and device domain info with xarrays to
> > track per domain and per device PASIDs.  It provides the flexibility to
> > be used beyond DMA API PASID support.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 194
> > +++++++++++++++++++++++++++++++++++-
> >  include/linux/intel-iommu.h |  12 ++-
> >  2 files changed, 202 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 881f8361eca2..9267194eaed3 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1622,20 +1622,48 @@ static void __iommu_flush_dev_iotlb(struct
> > device_domain_info *info,
> >  			   qdep, addr, mask);
> >  }
> > 
> > +static void __iommu_flush_dev_piotlb(struct device_domain_info *info,  
> 
> piotlb is confusing, better be:
> 
> 	__iommu_flush_dev_iotlb_pasid()
> 
yeah, that is more clear.

> > +					u64 address,
> > +				     ioasid_t pasid, unsigned int mask)
> > +{
> > +	u16 sid, qdep;
> > +
> > +	if (!info || !info->ats_enabled)
> > +		return;
> > +
> > +	sid = info->bus << 8 | info->devfn;
> > +	qdep = info->ats_qdep;
> > +	qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
> > +				 pasid, qdep, address, mask);
> > +}
> > +
> >  static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
> >  				  u64 addr, unsigned mask)
> >  {
> >  	unsigned long flags;
> >  	struct device_domain_info *info;
> >  	struct subdev_domain_info *sinfo;
> > +	unsigned long pasid;
> > +	struct pasid_info *pinfo;
> > 
> >  	if (!domain->has_iotlb_device)
> >  		return;
> > 
> >  	spin_lock_irqsave(&device_domain_lock, flags);
> > -	list_for_each_entry(info, &domain->devices, link)
> > -		__iommu_flush_dev_iotlb(info, addr, mask);
> > -
> > +	list_for_each_entry(info, &domain->devices, link) {
> > +		/*
> > +		 * We cannot use PASID based devTLB invalidation on
> > RID2PASID
> > +		 * Device does not understand RID2PASID/0. This is
> > different  
> 
> Lack of a conjunction word between 'RID2PASID' and 'Device'.
> 
> and what is RID2PASID/0? It would be clearer to point out that RID2PASID
> is visible only within the iommu to mark out requests without PASID, 
> thus this PASID value should never be sent to the device side.
> 
Good point, will do.

> > +		 * than IOTLB invalidation where RID2PASID is also
> > used for
> > +		 * tagging.  
> 
> Then it would be obvious because IOTLB is iommu internal agent thus takes 
> use of RID2PASID for tagging.
> 
ditto

> > +		 */
> > +		xa_for_each(&info->pasids, pasid, pinfo) {
> > +			if (!pasid)  
> 
> this should be compared to PASID_RID2PASID (though it's zero today).
> 
ditto

> > +				__iommu_flush_dev_iotlb(info, addr,
> > mask);
> > +			else
> > +				__iommu_flush_dev_piotlb(info, addr,
> > pasid, mask);
> > +		}
> > +	}
> >  	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> >  		info = get_domain_info(sinfo->pdev);
> >  		__iommu_flush_dev_iotlb(info, addr, mask);  
> 
> Thanks
> Kevin


Thanks,

Jacob
