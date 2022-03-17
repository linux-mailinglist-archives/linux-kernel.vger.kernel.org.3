Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893D74DBBE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347539AbiCQAsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355235AbiCQAr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:47:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FFC1CFDE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647478004; x=1679014004;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NnAPp6oZd6VCwzUOq2GdDfZv4iSoBJAkNLTJDUkH7T0=;
  b=k4ALTn/w9L8jZ+v93cajV9EOtfG1SFaWuedIrCYgSNlja5yLyra4h1U/
   dVKUHdRhtYL3ZVdWIPODYAp5FIgyUVmU4CxE20bshYjnZwMdSUatH5kVq
   5gyWt0zZfSPfqqWwWupDpxOTCUuWJVJv1gLRQC4k3vk8SAzOzXakjpcfP
   9/sap4CKkxs2KQSVsGCxrqyrLJzKc3DtCtO5/rzW7kwjdkKruX66YgCaJ
   aj2JBvD/WAy1iKKVeFlv4n66YDeqKfxy5YdkipMbG7qvTw7JIUyysP/3f
   qjl0KlheQx/WImlSELlCrlj5ct2zoBCh7M7Vs9mmoGa+jHYVeQKP32xM1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244202013"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="244202013"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:46:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="513240440"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:46:43 -0700
Date:   Wed, 16 Mar 2022 17:49:59 -0700
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
Message-ID: <20220316174959.08040193@jacob-builder>
In-Reply-To: <20220316221550.GS11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
        <20220315143322.GW11336@nvidia.com>
        <20220315153620.710a30fa@jacob-builder>
        <20220315230457.GO11336@nvidia.com>
        <20220316135004.61ae1611@jacob-builder>
        <20220316221550.GS11336@nvidia.com>
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

Hi Jason,

On Wed, 16 Mar 2022 19:15:50 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 16, 2022 at 01:50:04PM -0700, Jacob Pan wrote:
> 
> > I guess a list of (device, pasid) tuples as you suggested could work
> > but it will have duplicated device entries since each device could have
> > multiple PASIDs. right?  
> 
> Is assigning the same iommu_domain to multiple PASIDs of the same
> device something worth optimizing for?
Probably not, the current usage case has only two PASIDs at most (RID2PASID
+ a kernel PASID).

I was just thinking for the generalized case, device TLB flush would be
more efficient if we don't go through the domain list. Use a per-domain-dev
list instead. But it doesn't matter much for DMA domain which has one
device mostly.

> I would expect real applications will try to use the same PASID for
> the same IOVA map to optimize IOTLB caching.
> 
> Is there a use case for that I'm missing?
> 
Yes. it would be more efficient for PASID selective domain TLB flush. But
on VT-d IOTLB is also tagged by domain ID, domain flush can use DID if
there are many PASIDs. Not sure about other archs. Agree that optimizing
PASIDs for TLB flush should be a common goal.

> Otherwise your explanation is what I was imagining as well.
> 
> I would also think about expanding your struct so that the device
> driver can track per-device per-domain data as well, that seems
> useful IIRC?
> 
yes, at least both VT-d and FSL drivers have struct device_domain_info.

> ie put a 'sizeof_iommu_dev_pasid_data' in the domain->ops and
> allocate that much memory so the driver can use the trailer space for
> its own purpose.
> 
That sounds great to have but not sure i understood correctly how to do it.

Do you mean for each vendor driver's struct device_domain_info (or
equivalent), we carve out sizeof_iommu_dev_pasid_data as common data, then
the rest of the space is vendor specific? I don't feel I get your point,
could you elaborate?


Thanks,

Jacob
