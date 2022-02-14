Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38074B42FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbiBNHih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:38:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiBNHib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:38:31 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A274F9C3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:38:24 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7900468AFE; Mon, 14 Feb 2022 08:38:20 +0100 (CET)
Date:   Mon, 14 Feb 2022 08:38:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] iommu/vt-d: Use xarray for global
 device_domain_info
Message-ID: <20220214073820.GF17411@lst.de>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com> <20220214025704.3184654-11-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-11-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  
>  const struct iommu_ops intel_iommu_ops;
> @@ -903,7 +905,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
>  	struct dmar_domain *domain;
>  	int offset, level;
>  
> -	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
> +	info = xa_load(&device_domain_array,
> +		       devi_idx(iommu->segment, bus, devfn));
>  	if (!info || !info->domain) {
>  		pr_info("device [%02x:%02x.%d] not probed\n",
>  			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> @@ -1742,14 +1745,14 @@ static int iommu_init_domains(struct intel_iommu *iommu)

Don't we need a rcu critical section here?

> -	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
> +	rcu_read_lock();
> +	xa_for_each(&device_domain_array, index, info) {
>  		if (info->iommu != iommu)
>  			continue;
>  
> @@ -1758,7 +1761,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>  
>  		__dmar_remove_one_dev_info(info);
>  	}
> -	spin_unlock_irqrestore(&device_domain_lock, flags);
> +	rcu_read_unlock();

__dmar_remove_one_dev_info asserts that device_domain_lock is held,
which these two hunks remove.

>  	spin_lock_irqsave(&device_domain_lock, flags);
>  	dev_iommu_priv_set(dev, NULL);
> -	list_del(&info->global);
> +	xa_erase(&device_domain_array,
> +		 devi_idx(info->segment, info->bus, info->devfn));
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  
>  	kfree(info);

Do we need a kfree_rcu here to allow rcu based access?
