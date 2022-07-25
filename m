Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A25657FD55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiGYKWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiGYKWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:22:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F7CB84C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658744530; x=1690280530;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wAXUudd2bYpf3nYYKav//ZqBy0T3UuLekipqsksLhYI=;
  b=C1BomNv+A8WJyUXri5zr5E7MpLWib0orDjp+PFkq63wcjeQB3TyC9q8j
   QWKlww5+iC1r0v02jTqk3Y/0TRIh/lKOjcv6mophdpH+cqVhDwGRTV9v9
   eTRapJHZOhQlTA6/6o70r3a2gHl15GsvIyVU83pulURzPrdCEwb81nQK/
   rY/0CM5gHsJ3/u2NZ5o3GQM7hYcTJx260Pof+Bh25vJ6pxJVl03zNnylJ
   /GVm4LXKcpyQDGT2Q+BVvYvy0NU4Mu40E+eWh/GOW01BZOs2zWqreYeua
   Ciwkf9njScFy1xGoimYqbRDtjPW/sllvldryKBTXxHSdSeZswYA/LTOap
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="349362690"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="349362690"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 03:22:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="658130002"
Received: from liangk-mobl.ccr.corp.intel.com (HELO [10.255.30.67]) ([10.255.30.67])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 03:22:06 -0700
Message-ID: <b868cd13-4902-7d60-048a-31bb92b94cda@linux.intel.com>
Date:   Mon, 25 Jul 2022 18:22:06 +0800
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
 <BN9PR11MB52764D3E07E6755EF52DDC138C959@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D3E07E6755EF52DDC138C959@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/7/25 15:50, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Sunday, July 24, 2022 9:48 PM
>>>
>>> The API is really refcounting the PASID:
>>>
>>>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>>>> +					struct mm_struct *mm);
>>>> +void iommu_sva_unbind_device(struct iommu_sva *handle);
>>>
>>> So what you need to do is store that 'iommu_sva' in the group's PASID
>>> xarray.
>>>
>>> The bind logic would be
>>>
>>>     sva = xa_load(group->pasid, mm->pasid)
>>>     if (sva)
>>>        refcount_inc(sva->users)
>>>        return sva
>>>     sva = kalloc
>>>     sva->domain = domain
>>>     xa_store(group->pasid, sva);
>>
>> Thanks for the suggestion. It makes a lot of sense to me.
>>
>> Furthermore, I'd like to separate the generic data from the caller-
>> specific things because the group->pasid_array should also be able to
>> serve other usages. Hence, the attach/detach_device_pasid interfaces
>> might be changed like below:
>>
>> /* Collection of per-pasid IOMMU data */
>> struct group_pasid {
>> 	struct iommu_domain *domain;
>> 	void *priv;
>> };
>>
> 
> Is there any reason why pasid refcnt is sva specific and needs to be
> in a priv field?

I am going to store the iommu_sva data which represents the bind
relationship between device and domain.

Best regards,
baolu
