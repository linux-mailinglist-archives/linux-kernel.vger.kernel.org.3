Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13884DA56F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbiCOWeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiCOWeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:34:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5502DD58
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647383585; x=1678919585;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OwBLenYoHPXhCBJxzxgniCNW9JRsFisichsORrmXtio=;
  b=Qlg1fi18qLaFuUvh1BC5Tl/GGKl27LOVgdqrNS1bqW8Tx/lK4iHfImE7
   5oztyhT0oATsm1f5YbsxOghpcNaI0D8Vn4KS06nZw0GL4P/GLFuSREhos
   ULWmmH7wh5E+3+eSHHzOaEsN2ZCkqsRyPEPYHzRiIjwY5AvWpvrlwj6BN
   lTp9F1JdOIG7vpiPqJY5gc0dUC48aaHdb0tGOOgAdyPjGg/4Jf+GL4YW+
   IKxH3+M2v0aurAXHe51dbAR8NEHTcHoSMu7RtkIzMxHocoXqTXToFTHpB
   YAGuoA33e4UViwON/yCsjREEqEErluPTlp2Jg3lUFQCprNFJczOuCNjs+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256160339"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256160339"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 15:33:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="783241755"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 15:33:04 -0700
Date:   Tue, 15 Mar 2022 15:36:20 -0700
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
Message-ID: <20220315153620.710a30fa@jacob-builder>
In-Reply-To: <20220315143322.GW11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
        <20220315143322.GW11336@nvidia.com>
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

On Tue, 15 Mar 2022 11:33:22 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 14, 2022 at 10:07:07PM -0700, Jacob Pan wrote:
> > +	/*
> > +	 * Each domain could have multiple devices attached with
> > shared or per
> > +	 * device PASIDs. At the domain level, we keep track of unique
> > PASIDs and
> > +	 * device user count.
> > +	 * E.g. If a domain has two devices attached, device A has
> > PASID 0, 1;
> > +	 * device B has PASID 0, 2. Then the domain would have PASID
> > 0, 1, 2.
> > +	 */  
> 
> A 2d array of xarray's seems like a poor data structure for this task.
> 
> AFACIT this wants to store a list of (device, pasid) tuples, so a
> simple linked list, 1d xarray vector or a red black tree seems more
> appropriate..
> 
Agreed.
It might need some surgery for dmar_domain and device_domain_info, which
already has a simple device list. I am trying to leverage the existing data
struct, let me take a closer look.

> > +	if (entry) {
> > +		pinfo = entry;
> > +	} else {
> > +		pinfo = kzalloc(sizeof(*pinfo), GFP_ATOMIC);
> > +		if (!pinfo)
> > +			return -ENOMEM;
> > +		pinfo->pasid = pasid;
> > +		/* Store the new PASID info in the per domain array */
> > +		ret = xa_err(__xa_store(&dmar_domain->pasids, pasid,
> > pinfo,
> > +			     GFP_ATOMIC));
> > +		if (ret)
> > +			goto xa_store_err;
> > +	}
> > +	/* Store PASID in per device-domain array, this is for
> > tracking devTLB */
> > +	ret = xa_err(xa_store(&info->pasids, pasid, pinfo,
> > GFP_ATOMIC));
> > +	if (ret)
> > +		goto xa_store_err;
> > +
> > +	atomic_inc(&pinfo->users);
> > +	xa_unlock(&dmar_domain->pasids);
> > +
> > +	return 0;
> > +
> > +xa_store_err:
> > +	xa_unlock(&dmar_domain->pasids);
> > +	spin_lock_irqsave(&iommu->lock, flags);
> > +	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> > +	spin_unlock_irqrestore(&iommu->lock, flags);
> > +
> > +	if (!atomic_read(&pinfo->users)) {
> > +		__xa_erase(&dmar_domain->pasids, pasid);  
> 
> This isn't locked right
> 
good catch! need to move under xa_unlock.

Thanks,

Jacob
