Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50443470802
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245052AbhLJSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:05:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:2453 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235392AbhLJSFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:05:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="262516504"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="262516504"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 10:01:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="463753687"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 10:01:27 -0800
Date:   Fri, 10 Dec 2021 10:05:45 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <20211210100545.373c30d1@jacob-builder>
In-Reply-To: <20211210123109.GE6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <YbHie/Z4bIXwTInx@myrica>
        <20211209101404.6aefbe1c@jacob-builder>
        <YbMYkKZBktlrB2CR@myrica>
        <20211210123109.GE6385@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, 10 Dec 2021 08:31:09 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Dec 10, 2021 at 09:06:24AM +0000, Jean-Philippe Brucker wrote:
> > On Thu, Dec 09, 2021 at 10:14:04AM -0800, Jacob Pan wrote:  
> > > > This looks like we're just one step away from device drivers needing
> > > > multiple PASIDs for kernel DMA so I'm trying to figure out how to
> > > > evolve the API towards that. It's probably as simple as keeping a
> > > > kernel IOASID set at first, but then we'll probably want to
> > > > optimize by having multiple overlapping sets for each device driver
> > > > (all separate from the SVA set).  
> > > Sounds reasonable to start with a kernel set for in-kernel DMA once
> > > we need multiple ones. But I am not sure what *overlapping* sets mean
> > > here, could you explain?  
> > 
> > Given that each device uses a separate PASID table, we could allocate
> > the same set of PASID values for different device drivers. We just need
> > to make sure that those values are different from PASIDs allocated for
> > user SVA.  
> 
> Why does user SVA need global values anyhow?
> 
Currently, we have mm.pasid for user SVA. mm is global. We could have per
device PASID for dedicated devices (not shared across mm's), but that would
make things a lot more complex. I am thinking multiple PASIDs per mm is
needed, right?

For VT-d, the shared workqueue (SWQ) requires global PASIDs in that we
cannot have two processes use the same PASID to submit work on a workqueue
shared by the two processes. Each process's PASID must be unique to the
SWQ's PASID table.

> Jason


Thanks,

Jacob
