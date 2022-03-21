Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F13D4E24EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346612AbiCULD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346620AbiCULDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:03:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE3A14B84C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647860511; x=1679396511;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=STU6cY35f0Ar5xQ71SnPMC7cF7hVD3maLrZFmxx4A+8=;
  b=jrnOz7aHPQ2ZslXg1e4FeCNXO7vfvyIjzEILP5BJLqak4EN/gyVeLdVD
   PuzkRiW1l8KFlA8gkaJ50grYnC7AfPRmkOlHwqQNZmcJ61NmmDCuHmZQo
   uxWLncD4oQeOn2eKTu8a0tF5KEnj9swWjz4BIRn4UreaIyyJsrxOBmaSg
   nqbbjF2vQbSX9BtU+pXeqmae2hDt/XdFU9XsyQ2SWT6PfEAmG2m169x1n
   6ixKZf7xtaqBWET14A61V/PosEfFXqD6u+NRUkM7AqkriBd2ItmnH0SWo
   sGuHJZpUoUpvN2wv8Nxnr6Akr9dzTbw4qRiwW98ocemMJO5rlyJwDucA5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="239681187"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="239681187"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 04:01:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="559819619"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.169]) ([10.254.213.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 04:01:47 -0700
Message-ID: <ec863d22-b79c-2e50-5897-7f1ab5381e44@linux.intel.com>
Date:   Mon, 21 Mar 2022 19:01:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com>
 <BL1PR11MB52714F57E430FCBE97DDAB478C169@BL1PR11MB5271.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB52714F57E430FCBE97DDAB478C169@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 16:04, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, March 20, 2022 2:40 PM
>> +struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void
>> *drvdata)
>> +{
>> +	int ret = -EINVAL;
>> +	struct iommu_sva *handle;
>> +	struct iommu_domain *domain;
>> +
>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +	if (!handle)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits)
>> - 1);
>> +	if (ret)
>> +		goto out;
>> +
>> +	domain = iommu_sva_domain_alloc(dev);
>> +	if (!domain) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +	domain->sva_cookie = mm;
> 
> one domain can be attached by multiple devices, so this should not be
> a blind alloc.

Indeed. Perhaps we could associate the SVA domain with the mm->pasid and
add a user counter inside the domain.

Best regards,
baolu
