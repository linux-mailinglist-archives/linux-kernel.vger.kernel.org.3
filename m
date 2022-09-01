Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748AF5A9A58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiIAOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiIAOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:30:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74CF427DDA;
        Thu,  1 Sep 2022 07:30:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D47DBD6E;
        Thu,  1 Sep 2022 07:30:35 -0700 (PDT)
Received: from [10.57.18.92] (unknown [10.57.18.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2C763F7B4;
        Thu,  1 Sep 2022 07:29:51 -0700 (PDT)
Message-ID: <3e402947-61f9-b7e8-1414-fde006257b6f@arm.com>
Date:   Thu, 1 Sep 2022 15:29:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
 <52d3fe0b86bdc04fdbf3aae095b2f71f4ea12d44.camel@linux.ibm.com>
 <e01e6ef2-ba45-7433-5fe4-a6806dac3af9@arm.com>
 <8b561ad3023fc146ba0779cbd8fff14d6409c6aa.camel@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <8b561ad3023fc146ba0779cbd8fff14d6409c6aa.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-01 14:42, Niklas Schnelle wrote:
> On Thu, 2022-09-01 at 12:01 +0100, Robin Murphy wrote:
>> On 2022-09-01 10:37, Niklas Schnelle wrote:
>>> On Thu, 2022-09-01 at 09:56 +0200, Pierre Morel wrote:
>>>> On 8/31/22 22:12, Matthew Rosato wrote:
>>>>> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
>>>>> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
>>>>> domains and the DMA API handling.  However, this commit does not
>>>>> sufficiently handle the case where the device is released via a call
>>>>> to the release_device op as it may occur at the same time as an opposing
>>>>> attach_dev or detach_dev since the group mutex is not held over
>>>>> release_device.  This was observed if the device is deconfigured during a
>>>>> small window during vfio-pci initialization and can result in WARNs and
>>>>> potential kernel panics.
>>>>>
>>>>> Handle this by tracking when the device is probed/released via
>>>>> dev_iommu_priv_set/get().  Ensure that once the device is released only
>>>>> release_device handles the re-init of the device DMA.
>>>>>
>>>>> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
>>>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>>> ---
>>>>>     arch/s390/include/asm/pci.h |  1 +
>>>>>     arch/s390/pci/pci.c         |  1 +
>>>>>     drivers/iommu/s390-iommu.c  | 39 ++++++++++++++++++++++++++++++++++---
>>>>>     3 files changed, 38 insertions(+), 3 deletions(-)
>>>>>
>>>>>
>>> ---8<---
>>>>>     
>>>>> @@ -206,10 +221,28 @@ static void s390_iommu_release_device(struct device *dev)
>>>>>
>>> ---8<---
>>>>> +		/* Make sure this device is removed from the domain list */
>>>>>     		domain = iommu_get_domain_for_dev(dev);
>>>>>     		if (domain)
>>>>>     			s390_iommu_detach_device(domain, dev);
>>>>> +		/* Now ensure DMA is initialized from here */
>>>>> +		mutex_lock(&zdev->dma_domain_lock);
>>>>> +		if (zdev->s390_domain) {
>>>>> +			zdev->s390_domain = NULL;
>>>>> +			zpci_unregister_ioat(zdev, 0);
>>>>> +			zpci_dma_init_device(zdev);
>>>>
>>>> Sorry if it is a stupid question, but two things looks strange to me:
>>>>
>>>> - having DMA initialized just after having unregistered the IOAT
>>>> Is that really all we need to unregister before calling dma_init_device?
>>>>
>>>> - having DMA initialized inside the release_device callback:
>>>> Why isn't it done in the device_probe ?
>>>
>>> As I understand it iommu_release_device() which calls this code is only
>>> used when a device goes away. So, I think you're right in that it makes
>>> little sense to re-initialize DMA at this point, it's going to be torn
>>> down immediately after anyway. I do wonder if it would be an acceptably
>>> small change to just set zdev->s390_domain = NULL here and leave DMA
>>> uninitialized while making zpci_dma_exit_device() deal with that e.g.
>>> by doing nothing if zdev->dma_table is NULL but I'm not sure.
>>>
>>> Either way I fear this mess really is just a symptom of our current
>>> design oddity of driving the same IOMMU hardware through both our DMA
>>> API implementation (arch/s390/pci_dma.c) and the IOMMU driver
>>> (driver/iommu/s390-iommu.c) and trying to hand off between them
>>> smoothly where common code instead just layers one atop the other when
>>> using an IOMMU at all.
>>>
>>> I think the correct medium term solution is to use the common DMA API
>>> implementation (drivers/iommu/dma-iommu.c) like everyone else. But that
>>> isn't the minimal fix we need now.
>>>
>>> I do have a working prototype of using the common implementation but
>>> the big problem that I'm still searching a solution for is its
>>> performance with a virtualized IOMMU where IOTLB flushes (RPCIT on
>>> s390) are used for shadowing and are expensive and serialized. The
>>> optimization we used so far for unmap, only doing one global IOTLB
>>> flush once we run out of IOVA space, is just too much better in that
>>> scenario to just ignore. As one data point, on an NVMe I get about
>>> _twice_ the IOPS when using our existing scheme compared to strict
>>> mode. Which makes sense as IOTLB flushes are known as the bottleneck
>>> and optimizing unmap like that reduces them by almost half. Queued
>>> flushing is still much worse likely due to serialization of the
>>> shadowing, though again it works great on LPAR. To make sure it's not
>>> due to some bug in the IOMMU driver I even tried converting our
>>> existing DMA driver to layer on top of the IOMMU driver with the same
>>> result.
>>
>> FWIW, can you approximate the same behaviour by just making IOVA_FQ_SIZE
>> and IOVA_FQ_TIMEOUT really big, and deferring your zpci_refresh_trans()
>> hook from .unmap to .flush_iotlb_all when in non-strict mode?
>>
>> I'm not against the idea of trying to support this mode of operation
>> better in the common code, since it seems like it could potentially be
>> useful for *any* virtualised scenario where trapping to invalidate is
>> expensive and the user is happy to trade off the additional address
>> space/memory overhead (and even greater loss of memory protection)
>> against that.
>>
>> Robin.
> 
> 
> Ah thanks for reminding me. I had tried that earlier but quickly ran
> into the size limit of per-CPU allocations. This time I turned the
> "struct iova_fq_entry entries" member into a pointer and allocted that
> with vmalloc(). Also thankfully the ops->flush_iotlb_all(), iommu_iotlb_sync(), and iommu_iotlb_sync_map() already perfectly match
> our needs.
> 
> Okay, this is _very_ interesting. With the above cranking IOVA_FQ_SIZE
> all the way to 32768 and IOVA_FQ_TIMEOUT to 4000 ms, I can get to about
> 91% of the performance of our scheme (layered on the IOMMU API). That
> also seems to be the limit. I guess there is also more overhead than
> with our bitset IOVA allocation that doesn't need any bookkeeping
> besides a "lazily unmapped" bit per page. With a more sane IOVA_FQ_SIZE
> of 8192 and 100 ms timeout I still get about 76% of the performance.

Promising indeed... come to think of it, if you weren't already using it 
then "iommu.forcedac=1" should save a bit more time in the IOVA 
allocator especially if we're deliberately letting the address space 
fill up. Clearly your current allocator doesn't have to work around 
broken x86 PCs, so you're at liberty to convince the common one not to 
either.

> Interestingly with the above changes but default values for
> IOVA_FQ_SIZE/IOVA_FQ_TIMEOUT things are much worse than even strict
> mode (~50%) and I get less than 8% the IOPS with this NVMe.
> 
> So yeah it seems you're right and one can largely emulate our scheme
> with this. I do wonder if we could go further and do a "flush on
> running out of IOVAs" domain type with acceptable changes. My rough
> idea would be to collect lazily freed IOVAs in the same data structure
> as the free IOVAs, then on running out of those one can simply do a
> global IOTLB flush and the lazily freed IOVAs become the new free
> IOVAs. With that the global reset would be even cheaper than with our
> bitmaps. For a generic case one would of course also need to track the
> gather->freelist that we don't use in s390 but e.g. virtio-iommu
> doesn't seem to use that either. What do you think?

Right, the next step would be to bridge that gap to iommu-dma to dump 
the flush queue when IOVA allocation failure implies we've reached the 
"rollover" point, and perhaps not use the timer at all. By that point a 
dedicated domain type, or at least some definite internal flag, for this 
alternate behaviour seems like the logical way to go.

Cheers,
Robin.
