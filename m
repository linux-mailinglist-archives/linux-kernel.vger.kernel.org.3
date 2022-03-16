Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23C54DB9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358040AbiCPUsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358107AbiCPUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:48:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE7F5A598
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647463609; x=1678999609;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=amVRG1zmPs9HJDAJXGSv/XhAzDgNn5MXqtThTcMFz2o=;
  b=Yfce87SXPIuEZQ570NZmQ9G6yN7D9rXMKjjo/MVuaBvQkV1QiV0N9Sm8
   qZojUtiAf4FLqlnG98JSH2cYxyhzQyaxtCZi95O3AnPJ43jf01fbL6oQj
   apgeoXpFlNvUOrAeIJYcq/9OpuKqLWcbybbOhbHBKG3cW/vSZV2KdLI4W
   y9dxxOqV1t0RIYRIDdQTVKQLZ0Vb9woS/JQykYzFvUxIPqwH1RqpUoiWY
   4Wn2mBfifwSrt2wjeaXYcKL74wrpyUbIhdNBYvnWcMsVPh6IllTsqBBsW
   uT0nn8NtWQ7xA2fvcJD6UL31JjXpNXQPgRNXwo/08tYaiL65hO9vXzjMr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="237315565"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="237315565"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 13:46:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="513175592"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 13:46:48 -0700
Date:   Wed, 16 Mar 2022 13:50:04 -0700
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
Message-ID: <20220316135004.61ae1611@jacob-builder>
In-Reply-To: <20220315230457.GO11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
        <20220315143322.GW11336@nvidia.com>
        <20220315153620.710a30fa@jacob-builder>
        <20220315230457.GO11336@nvidia.com>
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

On Tue, 15 Mar 2022 20:04:57 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 15, 2022 at 03:36:20PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Tue, 15 Mar 2022 11:33:22 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Mon, Mar 14, 2022 at 10:07:07PM -0700, Jacob Pan wrote:  
> > > > +	/*
> > > > +	 * Each domain could have multiple devices attached with
> > > > shared or per
> > > > +	 * device PASIDs. At the domain level, we keep track of
> > > > unique PASIDs and
> > > > +	 * device user count.
> > > > +	 * E.g. If a domain has two devices attached, device A has
> > > > PASID 0, 1;
> > > > +	 * device B has PASID 0, 2. Then the domain would have
> > > > PASID 0, 1, 2.
> > > > +	 */    
> > > 
> > > A 2d array of xarray's seems like a poor data structure for this task.
> > > 
> > > AFACIT this wants to store a list of (device, pasid) tuples, so a
> > > simple linked list, 1d xarray vector or a red black tree seems more
> > > appropriate..
> > >   
> > Agreed.
> > It might need some surgery for dmar_domain and device_domain_info, which
> > already has a simple device list. I am trying to leverage the existing
> > data struct, let me take a closer look.  
> 
> Maybe the core code should provide this data structure in the
> iommu_domain.
> 
> Figuring out what stuff is attached is something every driver has to
> do right?
yeah, seems we already have some duplicated device list in vendor domain
struct, e.g. VT-d's dmar_domain, AMD's protection_domain. Similarly for 
device_domain_info equivalent.

If core code provides domain-device-pasid tracking, we could do device-pasid
tracking in ioasid.c, when we support per device PASID allocation, each
phy device could be an IOASID set, thus its own namespace.

Perhaps, we could do the following: add a device list to struct
iommu_domain, this will replace vender's domain lists. The data would be
something like:
struct iommu_dev_pasid_data {
	struct list_head list;	  /* For iommu_domain->dev_list */
	struct ioasid_set *pasids;  /* For the PASIDs used by the device */
	struct device *dev;
};

I guess a list of (device, pasid) tuples as you suggested could work but it
will have duplicated device entries since each device could have multiple
PASIDs. right?

Have to code this up to see.

Thanks for the pointers,

Jacob
