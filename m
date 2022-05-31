Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6D95394A5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbiEaQB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345974AbiEaQBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:01:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75E83813D5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:01:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D43E523A;
        Tue, 31 May 2022 09:01:52 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 313793F73D;
        Tue, 31 May 2022 09:01:51 -0700 (PDT)
Message-ID: <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
Date:   Tue, 31 May 2022 17:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
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
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531151332.GF1343366@nvidia.com>
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

On 2022-05-31 16:13, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 04:01:04PM +0100, Robin Murphy wrote:
>> On 2022-05-31 15:53, Jason Gunthorpe wrote:
>>> On Tue, May 31, 2022 at 10:11:18PM +0800, Baolu Lu wrote:
>>>> On 2022/5/31 21:10, Jason Gunthorpe wrote:
>>>>> On Tue, May 31, 2022 at 11:02:06AM +0800, Baolu Lu wrote:
>>>>>
>>>>>> For case 2, it is a bit weird. I tried to add a rwsem lock to make the
>>>>>> iommu_unmap() and dumping tables in debugfs exclusive. This does not
>>>>>> work because debugfs may depend on the DMA of the devices to work. It
>>>>>> seems that what we can do is to allow this race, but when we traverse
>>>>>> the page table in debugfs, we will check the validity of the physical
>>>>>> address retrieved from the page table entry. Then, the worst case is to
>>>>>> print some useless information.
>>>>>
>>>>> Sounds horrible, don't you have locking around the IOPTEs of some
>>>>> kind? How does updating them work reliably?
>>>>
>>>> There's no locking around updating the IOPTEs. The basic assumption is
>>>> that at any time, there's only a single thread manipulating the mappings
>>>> of the range specified in iommu_map/unmap() APIs. Therefore, the race
>>>> only exists when multiple ranges share some high-level IOPTEs. The IOMMU
>>>> driver updates those IOPTEs using the compare-and-exchange atomic
>>>> operation.
>>>
>>> Oh? Did I miss where that was documented as part of the iommu API?
>>>
>>> Daniel posted patches for VFIO to multi-thread iommu_domin mapping.
>>>
>>> iommufd goes out of its way to avoid this kind of serialization so
>>> that userspace can parallel map IOVA.
>>>
>>> I think if this is the requirement then the iommu API needs to
>>> provide a lock around the domain for the driver..
>>
>> Eww, no, we can't kill performance by forcing serialisation on the entire
>> API just for one silly driver-internal debugfs corner :(
> 
> I'm not worried about debugfs, I'm worried about these efforts to
> speed up VFIO VM booting by parallel domain loading:
> 
> https://lore.kernel.org/kvm/20220106004656.126790-1-daniel.m.jordan@oracle.com/
> 
> The DMA API should maintain its own external lock, but the general
> domain interface to the rest of the kernel should be safe, IMHO.

The DMA API doesn't need locking, partly since it can trust itself not 
to do stupid things, and mostly because it's DMA API performance that's 
fundamentally incompatible with serialisation anyway. Why do you think 
we have a complicated per-CPU IOVA caching mechanism, if not to support 
big multi-queue devices with multiple CPU threads mapping/unmapping in 
different parts of the same DMA domain concurrently?

> Or at least it should be documented..

As far as I'm aware there's never been any restriction at the IOMMU API 
level. It should be self-evident that racing concurrent 
iommu_{map,unmap} requests against iommu_domain_free(), or against each 
other for overlapping IOVAs, is a bad idea and don't do that if you want 
a well-defined outcome. The simpler drivers already serialise on a 
per-domain lock internally, while the more performance-focused ones 
implement lock-free atomic pagetable management in a similar style to 
CPU arch code; either way it should work fine as-is. The difference with 
debugfs is that it's a completely orthogonal side-channel - an 
iommu_domain user like VFIO or iommu-dma can make sure its *own* API 
usage is sane, but can't be aware of the user triggering some 
driver-internal introspection of that domain in a manner that could race 
more harmfully. It has to be down to individual drivers to make that 
safe if they choose to expose such an interface.

Robin.
