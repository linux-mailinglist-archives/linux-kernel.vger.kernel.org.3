Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9534D9F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbiCOQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiCOQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:10:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF14C25EAB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647360546; x=1678896546;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYoawQt8/mjlKy6DboqveGnemw0SfDUDHd8XG2dieWM=;
  b=U/yckrpt22PL+Scw6Ddqw7opklMIoXvQRu0h5NbVKI5NuxlUXLAlATK3
   HbRmeYGZD7CjRIrbRwTp0axhNsTdYXyODKfkcqK8OacGvpdV3RtEVVSI8
   XU/UFME3guWNVtRRXJhhw59aQqIYkDh+DdhY0qf6itvMlmFxr+nKu+EmK
   MtdyY88KPh5RV4mN+J+usd9aURptxb6G1MFKcgGJis2vzBI6Q62y5gAJz
   BObQboddztEEZwGAstZ2obmcYZbBnMc9p6k7TiScNVIGpDcWMsAvzyovl
   3oP/CZ/DFWgjB1K5ypwe35CoK16d8TEC1TjcvMS0mhf+K/izmZt/aOuwW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281119503"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="281119503"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:08:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="540497258"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:08:00 -0700
Date:   Tue, 15 Mar 2022 09:11:16 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <20220315091116.26e10b1b@jacob-builder>
In-Reply-To: <BN9PR11MB5276D5B88C05B509C2C790A98C109@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
        <YjB4AyrgsnbUrlLe@myrica>
        <BN9PR11MB5276D5B88C05B509C2C790A98C109@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Tue, 15 Mar 2022 11:49:57 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Tuesday, March 15, 2022 7:27 PM
> > 
> > On Mon, Mar 14, 2022 at 10:07:06PM -0700, Jacob Pan wrote:  
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > >
> > > An IOMMU domain represents an address space which can be attached by
> > > devices that perform DMA within a domain. However, for platforms with
> > > PASID capability the domain attachment needs be handled at
> > > device+PASID level. There can be multiple PASIDs within a device and
> > > multiple devices attached to a given domain.
> > > This patch introduces a new IOMMU op which support device, PASID, and
> > > IOMMU domain attachment. The immediate use case is for PASID capable
> > > devices to perform DMA under DMA APIs.
> > >
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  include/linux/iommu.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index 369f05c2a4e2..fde5b933dbe3 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
> > >   * @aux_get_pasid: get the pasid given an aux-domain
> > >   * @sva_bind: Bind process address space to device
> > >   * @sva_unbind: Unbind process address space from device
> > > + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> > > + * @detach_dev_pasid: detach an iommu domain from a pasid of device  
> > 
> > Isn't that operation "assign a PASID to a domain" instead?  In patch 5,
> > the domain is already attached to the device, so set_domain_pasid()
> > might be clearer and to the point. If the IOMMU driver did the
> > allocation we could also avoid patch 1.
I agree, we could let vendor driver do the allocation inside this op. On
the other side, we could also keep the flexibility such that this op can be
used for guest PASID bind, with a SVA domain.
> 
> iiuc this API can also work for future SIOV usage where each mdev attached
> to the domain has its own pasid. "assigning a PASID to a domain" sounds
> like going back to the previous aux domain approach which has one PASID
> per domain and that PASID is used on all devices attached to the aux
> domain...
> 
yes, that is the intention. I plan to lift the requirement in patch 5 such
that device attachment will not be a prerequisite. That would be after mdev
adoption.

> > 
> > If I understand correctly this series is not about a generic PASID API
> > that allows drivers to manage multiple DMA address spaces, because there
> > still doesn't seem to be any interest in that. It's about the specific
> > IDXD use-case, so let's focus on that. We can introduce a specialized
> > call such as (iommu|dma)_set_device_pasid(), which will be easy to
> > consolidate later into a more generic "dma_enable_pasid()" API if that
> > ever seems useful.
> > 
Right, at the moment it is still a single address space. i.e. the current
domain of the device/group.

But this limitation is at the driver facing API layer not limited in the
IOMMU ops.

> > Thanks,
> > Jean
> >   
> > >   * @sva_get_pasid: Get PASID associated to a SVA handle
> > >   * @page_response: handle page request response
> > >   * @cache_invalidate: invalidate translation caches
> > > @@ -296,6 +298,10 @@ struct iommu_ops {
> > >  	struct iommu_sva *(*sva_bind)(struct device *dev, struct
> > > mm_struct  
> > *mm,  
> > >  				      void *drvdata);
> > >  	void (*sva_unbind)(struct iommu_sva *handle);
> > > +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> > > +				struct device *dev, ioasid_t id);
> > > +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> > > +				 struct device *dev, ioasid_t id);
> > >  	u32 (*sva_get_pasid)(struct iommu_sva *handle);
> > >
> > >  	int (*page_response)(struct device *dev,
> > > --
> > > 2.25.1
> > >  


Thanks,

Jacob
