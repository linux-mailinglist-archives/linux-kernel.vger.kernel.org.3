Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27D657FD30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiGYKLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiGYKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:11:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC92FD13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658743878; x=1690279878;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1kqxjz8pEwN4Kot1Jt27wFtLc1vilZcf22t+QeswRi8=;
  b=FdkodQZeh7U5pdupHIqVQe5t8N9ewFZaMYNst55Wu2RlsTIsW1DS7pfv
   FQhHrCqt6hqA6CgcSKRvWDuAAlBhiLKczxXhRvsc+Tq4FnaJ3KjLe1KRu
   BSHvkk2M0Pc3Y1FM6CvB8+aXrPcxVweNlm5gPMdOIpKoOPh2ODs+l2Mqs
   6v8ouN5tKy7e4moNMhb4zsOrUNvINtn5JE08hkMzVtinj70eet63soKRT
   VTio+GODf4f2rgvr+idl6HFf0JnFOSrHHHrAl0GDPDX38Ii/1eGcT+m1i
   jTavvA/mk892TsrsDBWF9Fb+rscLty0XsZyMkWqUJN0rP/6sVMmUJXkPr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="351656941"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="351656941"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 03:11:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="658125872"
Received: from liangk-mobl.ccr.corp.intel.com (HELO [10.255.30.67]) ([10.255.30.67])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 03:11:13 -0700
Message-ID: <441f6537-dde0-885a-3cc2-089b3ed4f4df@linux.intel.com>
Date:   Mon, 25 Jul 2022 18:11:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <5d353fe4-b642-992e-ef42-7d7f8b2edf7e@linux.intel.com>
 <BN9PR11MB527627410352E6DE921755898C959@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527627410352E6DE921755898C959@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/25 15:46, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Sunday, July 24, 2022 5:14 PM
>>
>> On 2022/7/23 22:11, Jason Gunthorpe wrote:
>>>> +void iommu_detach_device_pasid(struct iommu_domain *domain,
>> struct device *dev,
>>>> +			       ioasid_t pasid)
>>>> +{
>>>> +	struct iommu_group *group = iommu_group_get(dev);
>>>> +
>>>> +	mutex_lock(&group->mutex);
>>>> +	domain->ops->block_dev_pasid(domain, dev, pasid);
>>> I still really this OP, it is nonsense to invoke 'block_dev_pasid' on
>>> a domain, it should be on the iommu ops and it should not take in a
>>> domain parameter. This is why I prefer we write it as
>>>
>>> domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);
>>>
>>
>> I originally plan to refactor this after both Intel and ARM SMMUv3
>> drivers have real blocking domain supports. After revisiting this, it
>> seems that the only difficulty is how to check whether a domain is a
>> blocking domain. I am going to use below checking code:
>>
>> +	/*
>> +	 * Detach the domain if a blocking domain is set. Check the
>> +	 * right domain type once the IOMMU driver supports a real
>> +	 * blocking domain.
>> +	 */
>> +	if (!domain || domain->type == IOMMU_DOMAIN_UNMANAGED) {
>>
>> Does this work for you?
>>
> 
> Or you can call __iommu_group_alloc_blocking_domain() in the sva
> path and then just check whether the domain is equal to
> group->blocking_domain here.

Above check is in the IOMMU driver where group->blocking_domain is not
viable. I ever thought about have something like

struct iommu_domain *iommu_group_blocking_domain(struct iommu_group
*group)

to return group->blocking_domain. But it looks redundant.

Best regards,
baolu
