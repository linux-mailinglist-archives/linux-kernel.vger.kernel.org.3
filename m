Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF751423B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354473AbiD2GUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiD2GUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:20:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1E82180A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651213048; x=1682749048;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ti68k/z1JomTVPNNM6IUrCDfU5XGG1j6rnK5v6KWG4c=;
  b=XDY6thVHodQGRImHhaWEKKwTJBSKmQpsFxKIQhEySnW7WbuUONNZQ2D/
   /Uw0JaMn6noB4HJNaLzziWaIa+hyshudpxemtDdx0vLbo6UXI2BmtK3VO
   NaHBErH/r6xWn7qTViOVtQ0tMDDTptXBeNWFRUwpJbT4B7yA0u5l5B/VJ
   E0KEy/qONEYTPfKQEQ0xg2EnmYoZaul1wT+ZM6LvA7TyeIeQkgmeYAL9n
   S+st6mGHaVeXlfFOE3ZTtyiFQeUAGsWiEKU9G0YFGRWFPFugCm+UEOoxI
   KehViIHsWlMT7K1OkIa52nn0hLToowvEhJwMG+SIzhKNZRhRO/9nfmiuL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="253929554"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="253929554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 23:17:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="581917186"
Received: from lye4-mobl.ccr.corp.intel.com (HELO [10.249.170.95]) ([10.249.170.95])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 23:17:25 -0700
Message-ID: <dfe247b5-10d9-75d7-b742-28be910b5fb2@linux.intel.com>
Date:   Fri, 29 Apr 2022 14:17:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 10/12] iommu: Prepare IOMMU domain for IOPF
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-11-baolu.lu@linux.intel.com>
 <YmqpGFzMZn7ZMzsQ@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YmqpGFzMZn7ZMzsQ@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 2022/4/28 22:47, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> On Thu, Apr 21, 2022 at 01:21:19PM +0800, Lu Baolu wrote:
>> +/*
>> + * Get the attached domain for asynchronous usage, for example the I/O
>> + * page fault handling framework. The caller get a reference counter
>> + * of the domain automatically on a successful return and should put
>> + * it with iommu_domain_put() after usage.
>> + */
>> +struct iommu_domain *
>> +iommu_get_domain_for_dev_pasid_async(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +
>> +	if (!pasid_valid(pasid))
>> +		return NULL;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return NULL;
>> +
>> +	mutex_lock(&group->mutex);
> 
> There is a possible deadlock between unbind() and the fault handler:
> 
>   unbind()                            iopf_handle_group()
>    mutex_lock(&group->mutex)
>    iommu_detach_device_pasid()
>     iopf_queue_flush_dev()             iommu_get_domain_for_dev_pasid_async()
>      ... waits for IOPF work            mutex_lock(&group->mutex)
> 

Yes, really.

> I was wrong in my previous review: we do have a guarantee that the SVA
> domain does not go away during IOPF handling, because unbind() waits for
> pending faults with iopf_queue_flush_dev() before freeing the domain (or
> for Arm stall, knows that there are no pending faults). So we can just get
> rid of domain->async_users and the group->mutex in IOPF, I think?

Agreed with you. The Intel code does the same thing in its unbind().

Thus, the sva domain's life cycle has already synchronized with IOPF
handling, there's no need for domain->async.

I will drop it in the next version. Thanks you!

Best regards,
baolu
