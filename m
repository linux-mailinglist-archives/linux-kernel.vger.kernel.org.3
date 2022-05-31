Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC453937E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345426AbiEaPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345438AbiEaPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:01:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE09E5C746
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:01:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1597B23A;
        Tue, 31 May 2022 08:01:14 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F8D43F73D;
        Tue, 31 May 2022 08:01:11 -0700 (PDT)
Message-ID: <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
Date:   Tue, 31 May 2022 16:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531145301.GE1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 15:53, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 10:11:18PM +0800, Baolu Lu wrote:
>> On 2022/5/31 21:10, Jason Gunthorpe wrote:
>>> On Tue, May 31, 2022 at 11:02:06AM +0800, Baolu Lu wrote:
>>>
>>>> For case 2, it is a bit weird. I tried to add a rwsem lock to make the
>>>> iommu_unmap() and dumping tables in debugfs exclusive. This does not
>>>> work because debugfs may depend on the DMA of the devices to work. It
>>>> seems that what we can do is to allow this race, but when we traverse
>>>> the page table in debugfs, we will check the validity of the physical
>>>> address retrieved from the page table entry. Then, the worst case is to
>>>> print some useless information.
>>>
>>> Sounds horrible, don't you have locking around the IOPTEs of some
>>> kind? How does updating them work reliably?
>>
>> There's no locking around updating the IOPTEs. The basic assumption is
>> that at any time, there's only a single thread manipulating the mappings
>> of the range specified in iommu_map/unmap() APIs. Therefore, the race
>> only exists when multiple ranges share some high-level IOPTEs. The IOMMU
>> driver updates those IOPTEs using the compare-and-exchange atomic
>> operation.
> 
> Oh? Did I miss where that was documented as part of the iommu API?
> 
> Daniel posted patches for VFIO to multi-thread iommu_domin mapping.
> 
> iommufd goes out of its way to avoid this kind of serialization so
> that userspace can parallel map IOVA.
> 
> I think if this is the requirement then the iommu API needs to
> provide a lock around the domain for the driver..

Eww, no, we can't kill performance by forcing serialisation on the 
entire API just for one silly driver-internal debugfs corner :(

Robin.
