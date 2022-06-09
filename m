Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E522554548D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbiFITBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiFITBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:01:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3020E11A03
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654801264; x=1686337264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EmjwxxcIPjSKbVJyKUdZT+cLlENxHUYXqwB3T5Diz90=;
  b=PMHz+O6stWoWPFAEm/sd8Lry7OHV/HwPT8oA+NtP8bOu84rjpnw8QafY
   msQeXTm+t+znWITSCDYyzhoWEVDivQT/NkGovNvTCP39uWhSzkeRWx2lJ
   ALhVoG+XdE1/7f230Z3p/dAFyEVLarQgshHh3qUylJhtiAyV8/tVYMkND
   ouGROuLp24rKDUTlTUylOwrnNrbhguu3YBRFNwR9fo4MINl8wxyocmJQT
   DB5HUyAmcPAWSMZRABUWdIZQYNXWFkIdV2/2T3yC9rgYumJsZjVGKu0nm
   wntIhlpw6KjEYi+0WpQJ15GFLE1KYI6nVO0ukxfPnFcwt0UGsN67LOvta
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="266161270"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="266161270"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 12:01:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="908473498"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 12:01:03 -0700
Date:   Thu, 9 Jun 2022 19:01:02 +0000
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v8 02/11] iommu: Add max_pasids field in struct dev_iommu
Message-ID: <20220609190102.GC33363@araj-dh-work>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607014942.3954894-3-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:49:33AM +0800, Lu Baolu wrote:
> Use this field to save the number of PASIDs that a device is able to
> consume. It is a generic attribute of a device and lifting it into the
> per-device dev_iommu struct could help to avoid the boilerplate code
> in various IOMMU drivers.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  2 ++
>  drivers/iommu/iommu.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 03fbb1b71536..d50afb2c9a09 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -364,6 +364,7 @@ struct iommu_fault_param {
>   * @fwspec:	 IOMMU fwspec data
>   * @iommu_dev:	 IOMMU device this device is linked to
>   * @priv:	 IOMMU Driver private data
> + * @max_pasids:  number of PASIDs device can consume
>   *
>   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>   *	struct iommu_group	*iommu_group;
> @@ -375,6 +376,7 @@ struct dev_iommu {
>  	struct iommu_fwspec		*fwspec;
>  	struct iommu_device		*iommu_dev;
>  	void				*priv;
> +	u32				max_pasids;
>  };
>  
>  int iommu_device_register(struct iommu_device *iommu,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 847ad47a2dfd..adac85ccde73 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -20,6 +20,7 @@
>  #include <linux/idr.h>
>  #include <linux/err.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ats.h>

Is this needed for this patch?

>  #include <linux/bitops.h>
>  #include <linux/property.h>
>  #include <linux/fsl/mc.h>
> @@ -218,6 +219,30 @@ static void dev_iommu_free(struct device *dev)
>  	kfree(param);
>  }
>  
> +static u32 dev_iommu_get_max_pasids(struct device *dev)
> +{
> +	u32 max_pasids = dev->iommu->iommu_dev->max_pasids;
> +	u32 num_bits;
> +	int ret;
> +
> +	if (!max_pasids)
> +		return 0;
> +
> +	if (dev_is_pci(dev)) {
> +		ret = pci_max_pasids(to_pci_dev(dev));
> +		if (ret < 0)
> +			return 0;
> +
> +		return min_t(u32, max_pasids, ret);

Ah.. that answers my other question to consider device pasid-max. I guess
if we need any enforcement of restricting devices that aren't supporting
the full PASID, that will be done by some higher layer?

too many returns in this function, maybe setup all returns to the end of
the function might be elegant?

> +	}
> +
> +	ret = device_property_read_u32(dev, "pasid-num-bits", &num_bits);
> +	if (ret)
> +		return 0;
> +
> +	return min_t(u32, max_pasids, 1UL << num_bits);
> +}
> +
>  static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>  {
>  	const struct iommu_ops *ops = dev->bus->iommu_ops;
> @@ -243,6 +268,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  	}
>  
>  	dev->iommu->iommu_dev = iommu_dev;
> +	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
>  
>  	group = iommu_group_get_for_dev(dev);
>  	if (IS_ERR(group)) {
> -- 
> 2.25.1
> 
