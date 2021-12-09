Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8776846F3B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhLITRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:17:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:55659 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhLITRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:17:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225055274"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="225055274"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:14:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="564935042"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:13:59 -0800
Date:   Thu, 9 Dec 2021 11:18:17 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <20211209111817.6a84a55c@jacob-builder>
In-Reply-To: <BN9PR11MB527617F8CC015E4F15EDCC9F8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <20211208131358.GR6385@nvidia.com>
        <1ffc1366-2711-3026-fb09-8f60a260f618@intel.com>
        <20211208175116.GC6385@nvidia.com>
        <BN9PR11MB527617F8CC015E4F15EDCC9F8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Thu, 9 Dec 2021 01:48:09 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, December 9, 2021 1:51 AM
> >   
> > > > > +	/*
> > > > > +	 * Try to enable both in-kernel and user DMA request
> > > > > with PASID.
> > > > > +	 * PASID is supported unless both user and kernel PASID
> > > > > are
> > > > > +	 * supported. Do not fail probe here in that idxd can
> > > > > still be
> > > > > +	 * used w/o PASID or IOMMU.
> > > > > +	 */
> > > > > +	if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) ||
> > > > > +		idxd_enable_system_pasid(idxd)) {
> > > > > +		dev_warn(dev, "Failed to enable PASID\n");
> > > > > +	} else {
> > > > > +		set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > > > >   	}  
> > > > Huh? How can the driver keep going if PASID isn't supported? I
> > > > thought the whole point of this was because the device cannot do
> > > > DMA without PASID at all?  
> > >
> > > There are 2 types of WQ supported with the DSA devices. A dedicated
> > > WQ  
> > type  
> > > and a shared WQ type. The dedicated WQ type can support DMA with and  
> > without  
> > > PASID. The shared wq type must have a PASID to operate. The driver can
> > > support dedicated WQ only without PASID usage when there is no PASID
> > > support.  
> > 
> > Can you add to the cover letter why does the kernel require to use the
> > shared WQ?
> > 
> > Jason  
> 
> Two reasons:
> 
> On native the shared WQ is useful when the kernel wants to offload
> some memory operations (e.g. page-zeroing) to DSA. When #CPUs are
> more than #WQs, this allows per-cpu lock-less submissions using
> ENQCMD(PASID, payload) instruction.
> 
> In guest the virtual DSA HW may only contain a WQ in shared mode
> (unchangeable by the guest) when the host admin wants to share
> the limited WQ resource among many VMs. Then there is no choice
> in guest regardless whether it's for user or kernel controlled DMA.
I will add these to the next cover letter.


Thanks,

Jacob
