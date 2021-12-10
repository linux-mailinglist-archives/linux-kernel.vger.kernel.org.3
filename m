Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E698470836
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245200AbhLJSRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:17:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:23625 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245226AbhLJSRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:17:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="301793916"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="301793916"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 10:14:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="659713475"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 10:14:01 -0800
Date:   Fri, 10 Dec 2021 10:18:20 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/4] iommu/vt-d: Support PASID DMA for in-kernel usage
Message-ID: <20211210101820.58b24b77@jacob-builder>
In-Reply-To: <20211210174848.GH6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1638884834-83028-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20211208132255.GS6385@nvidia.com>
        <20211208111659.6de22e52@jacob-builder>
        <9f724b3a-6028-43d7-b4fc-d8a939e7b2cf@linux.intel.com>
        <20211209152113.64b817b9@jacob-builder>
        <921a766f-d826-2ca4-f739-4d196b32a681@linux.intel.com>
        <20211210095025.38af67ce@jacob-builder>
        <20211210174848.GH6385@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, 10 Dec 2021 13:48:48 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Dec 10, 2021 at 09:50:25AM -0800, Jacob Pan wrote:
> 
> > > Tying pasid to an iommu_domain is not a good idea. An iommu_domain
> > > represents an I/O address translation table. It could be attached to a
> > > device or a PASID on the device.  
> > 
> > I don;t think we can avoid storing PASID at domain level or the group's
> > default domain. IOTLB flush is per domain. Default domain of DMA type
> > is already tying to PASID0, right?  
> 
> No, it is just wrong.
> 
> If the HW requires a list of everything that is connected to the
> iommu_domain then it's private iommu_domain should have that list.
> 
What I have in this patchset is in the private dmar_domain
struct dmar_domain {
	...
	u32		kernel_pasid;	/* for in-kernel DMA w/
PASID */ atomic_t	kernel_pasid_user; /* count of kernel_pasid users
*/ struct iommu_domain domain;	/* generic domain data structure for
					   iommu core */
};

Perhaps I am missing the point. "private domain" is still "domain level" as
what I stated. Confused :(

> But it is a *list* not a single PASID.
> 
We could have a list when real use case comes.

> If one device has 10 PASID's pointing to this domain you must flush
> them all if that is what the HW requires.
> 
Yes. My point is that other than PASID 0 is a given, we must track the 10
PASIDs to avoid wasted flush. It also depend on how TLBs are tagged and
flush granularity available. But at the API level, should we support all the
cases?

> Jason


Thanks,

Jacob
