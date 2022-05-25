Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17E533673
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbiEYFd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243999AbiEYFd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:33:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F1D5E74D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653456835; x=1684992835;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tC5kXzJ2AZTXt2qxLz/QlNtc9RLvHWTtlK4ZRvR3278=;
  b=P+9eIJ0iqKBOt5fl8p6Khy5jOuGihRyGHIvIdVx2ejCb2/qJYTwf2qUC
   T1ueCF66F9iZ8BVGLaWhfkntKaDQvpAr+qAWGQufchHjBdTIcY0qu4LtH
   rzNvYPACceB/tLyND3XWLE+VdIItMabADHQMlAkBA4OnWl+WFWcPNYo47
   9yK9p9D0cCXpleBkCStIiT3HkeSEkTStgOX+IF5cA9GmWJgvB/TQyRQ4B
   /c10JKQPadBJYbJnxJRX1Jb/P8KZ1H3G/1N4BGSOiFcy+vgjS/w9NGdty
   p3pa5jUCpKCEA6norC8BHZiqoWRodq1+jPF/MfD5orO1cs1qT48WUNd71
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="336775076"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="336775076"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 22:33:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601666278"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139]) ([10.255.29.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 22:33:50 -0700
Message-ID: <11743cbe-c354-8442-d758-764cc59ce01a@linux.intel.com>
Date:   Wed, 25 May 2022 13:33:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <20220524134440.GT1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220524134440.GT1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/24 21:44, Jason Gunthorpe wrote:
>> +{
>> +	struct iommu_sva_domain *sva_domain;
>> +	struct iommu_domain *domain;
>> +
>> +	if (!bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
>> +	if (!sva_domain)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mmgrab(mm);
>> +	sva_domain->mm = mm;
>> +
>> +	domain = &sva_domain->domain;
>> +	domain->type = IOMMU_DOMAIN_SVA;
>> +	domain->ops = bus->iommu_ops->sva_domain_ops;
>> +
>> +	return domain;
>> +}
>> +
>> +void iommu_sva_free_domain(struct iommu_domain *domain)
>> +{
>> +	struct iommu_sva_domain *sva_domain = to_sva_domain(domain);
>> +
>> +	mmdrop(sva_domain->mm);
>> +	kfree(sva_domain);
>> +}
> No callback to the driver?

Should do this in the next version. This version added an sva-specific
iommu_domain_ops pointer in iommu_ops. This is not the right way to go.

> 
>> +int iommu_sva_set_domain(struct iommu_domain *domain, struct device *dev,
>> +			 ioasid_t pasid)
>> +{
> Why does this function exist? Just call iommu_set_device_pasid()

Yes, agreed.

> 
>> +int iommu_set_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			   ioasid_t pasid)
>> +{
> Here you can continue to use attach/detach language as at this API
> level we expect strict pairing..

Sure.

> 
> 
>> +void iommu_block_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			      ioasid_t pasid)
>> +{
>> +	struct iommu_group *group = iommu_group_get(dev);
>> +
>> +	mutex_lock(&group->mutex);
>> +	domain->ops->block_dev_pasid(domain, dev, pasid);
>> +	xa_erase(&group->pasid_array, pasid);
>> +	mutex_unlock(&group->mutex);
> Should be the blocking domain.

As we discussed, we should change above to blocking domain when the
blocking domain is supported on at least Intel and arm-smmu-v3 drivers.
I have started the work for Intel driver support.

Best regards,
baolu

