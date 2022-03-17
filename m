Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD7A4DCD77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiCQSVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiCQSVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:21:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62764221BB5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647541188; x=1679077188;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dd1Fx2C8nau5BfZpLzjrRCCTIM9HuEvH9Zm4mhUpWsM=;
  b=LIc+jVo0SmaRGzSH6+Vu5yIr5m55ioNVxBc2uol5EyQ1emSldV8R3SLm
   myQZ0edkpceApskdU2g+MWeMbPCI7GIX2JFk++/UF8Uw6dpDNhcCjyomf
   UKlaLXIINd2kJIpHcGbrtZv7gW6Tsg+6CxQy91jnFXYHWRFFbU9wLXh56
   tUlGHxBgd+VYGazz5MuUlE0JGZNO0uMHLSiTajhYhvRs+2yRpqAqtdYhH
   07S8qNH6r5CDpw22bioPVwS84hQa1DTIaYlsIUI12FMPjatrwl//jt/to
   xbVNB54aDxMuX9/sp2Q4uMtAx96wrjm+rEtRpq4jU6O8zlHdPNnKVSQla
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="343382207"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="343382207"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 11:19:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="715144088"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 11:19:47 -0700
Date:   Thu, 17 Mar 2022 11:23:04 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220317112304.61cf8953@jacob-builder>
In-Reply-To: <20220317132308.GV11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
        <20220315143322.GW11336@nvidia.com>
        <20220315153620.710a30fa@jacob-builder>
        <20220315230457.GO11336@nvidia.com>
        <20220316135004.61ae1611@jacob-builder>
        <20220316221550.GS11336@nvidia.com>
        <20220316174959.08040193@jacob-builder>
        <20220317132308.GV11336@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, 17 Mar 2022 10:23:08 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 16, 2022 at 05:49:59PM -0700, Jacob Pan wrote:
> 
> > > I would expect real applications will try to use the same PASID for
> > > the same IOVA map to optimize IOTLB caching.
> > > 
> > > Is there a use case for that I'm missing?
> > >   
> > Yes. it would be more efficient for PASID selective domain TLB flush.
> > But on VT-d IOTLB is also tagged by domain ID, domain flush can use DID
> > if there are many PASIDs. Not sure about other archs. Agree that
> > optimizing PASIDs for TLB flush should be a common goal.  
> 
> If you sort the list of (device, pasid) tuples can something like VT-d
> collapse all the same devices and just issue one DID invalidation:
> 
>  list_for_each()
>     if (itm->device == last_invalidated_device)
>           continue;
>     invalidate(itm->device);
>     last_invalidated_device = itm->device;
> 
I assume this is for devTLB since IOMMU's IOTLB flush doesn't care about
device. I think it works for device-wide invalidation.

> While something that was per-pasid could issue per-pasid invalidations
> from the same data structure?
> 
yes. we can use the same data structure for PASID selective devTLB but 
 list_for_each()
     if (itm->pasid == pasid_to_be_invalidated;
	     invalidate(itm->device, pasid);

For IOMMU's IOTLB, we also have two granularities
1. domain-wide
2. pasid-wide
For #1, we just use DID to invalidate w/o traverse the list.
For #2, we just need to sanity check the pasid is indeed attached by going
through the list.

Seems to work!

> > > Otherwise your explanation is what I was imagining as well.
> > > 
> > > I would also think about expanding your struct so that the device
> > > driver can track per-device per-domain data as well, that seems
> > > useful IIRC?
> > >   
> > yes, at least both VT-d and FSL drivers have struct device_domain_info.
> >   
> > > ie put a 'sizeof_iommu_dev_pasid_data' in the domain->ops and
> > > allocate that much memory so the driver can use the trailer space for
> > > its own purpose.
> > >   
> > That sounds great to have but not sure i understood correctly how to do
> > it.
> > 
> > Do you mean for each vendor driver's struct device_domain_info (or
> > equivalent), we carve out sizeof_iommu_dev_pasid_data as common data,
> > then the rest of the space is vendor specific? I don't feel I get your
> > point, could you elaborate?  
> 
> I've seen it done two ways..
> 
> With a flex array:
> 
>  struct iommu_device_data {
>      struct list_head list
>      ioasid_t pasid;
>      struct device *dev;
>      [..]
>      u64 device_data[];
>  }
> 
>  struct intel_device_data {
>       [..]
>  }
>  struct iommu_device_data *dev_data;
>  struct intel_device_data *intel_data = (void *)&dev_data->device_data;
> 
> Or with container of:
> 
>  struct iommu_device_data {
>      struct list_head list
>      ioasid_t pasid;
>      struct device *dev;
>      [..]
>  }
> 
>  struct intel_device_data {
>      struct iommu_device_data iommu; // must be first
>      [...]
>  }
>  struct iommu_device_data *dev_data;
>  struct intel_device_data *intel_data = container_of(dev_data, struct
> intel_device_data, iommu);
> 
> In either case you'd add a size_t to the domain->ops specifying how
> much extra memory for the core code to allocate when it manages the
> datastructure. The first case allocates based on struct_size, the
> second case allocates what is specified.
> 
> Look at INIT_RDMA_OBJ_SIZE() for some more complicated example how the
> latter can work. I like it because it has the nice container_of
> pattern in drivers, the downside is it requires a BUILD_BUG_ON to
> check that the driver ordered its struct properly.
> 
> The point is to consolidate all the code for allocating and walking
> the data structure without having to force two allocations and extra
> pointer indirections on performance paths.
Make sense, very neat. Vendor driver would not need to do allocations. Let
me give that a try. Seems #2 has better type safety.

Thank you so much for the thorough explanation!

Jacob
