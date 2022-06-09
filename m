Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFFB544D58
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242295AbiFINTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiFINTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:19:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5AF5B85A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:19:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8928B12FC;
        Thu,  9 Jun 2022 06:19:14 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55F5D3F73B;
        Thu,  9 Jun 2022 06:19:12 -0700 (PDT)
Message-ID: <9a339b42-2993-f7e2-3122-764a486e796f@arm.com>
Date:   Thu, 9 Jun 2022 14:19:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
 <20220609124934.GZ1343366@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220609124934.GZ1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-09 13:49, Jason Gunthorpe wrote:
> On Thu, Jun 09, 2022 at 03:08:10PM +0800, Lu Baolu wrote:
>> The IOMMU page tables are updated using iommu_map/unmap() interfaces.
>> Currently, there is no mandatory requirement for drivers to use locks
>> to ensure concurrent updates to page tables, because it's assumed that
>> overlapping IOVA ranges do not have concurrent updates. Therefore the
>> IOMMU drivers only need to take care of concurrent updates to level
>> page table entries.
>>
>> But enabling new features challenges this assumption. For example, the
>> hardware assisted dirty page tracking feature requires scanning page
>> tables in interfaces other than mapping and unmapping. This might result
>> in a use-after-free scenario in which a level page table has been freed
>> by the unmap() interface, while another thread is scanning the next level
>> page table.
>>
>> This adds RCU-protected page free support so that the pages are really
>> freed and reused after a RCU grace period. Hence, the page tables are
>> safe for scanning within a rcu_read_lock critical region. Considering
>> that scanning the page table is a rare case, this also adds a domain
>> flag and the RCU-protected page free is only used when this flat is set.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h |  9 +++++++++
>>   drivers/iommu/iommu.c | 23 +++++++++++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 5e1afe169549..6f68eabb8567 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -95,6 +95,7 @@ struct iommu_domain {
>>   	void *handler_token;
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>> +	unsigned long concurrent_traversal:1;
>>   };
>>   
>>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>> @@ -657,6 +658,12 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
>>   	dev->iommu->priv = priv;
>>   }
>>   
>> +static inline void domain_set_concurrent_traversal(struct iommu_domain *domain,
>> +						   bool value)
>> +{
>> +	domain->concurrent_traversal = value;
>> +}
> 
> ?? If you want it to be a driver opt in I would just add a flags to
> the domain ops. "DOMAIN_FLAG_RCU_FREE_PAGES"

Is there a significant benefit to keeping both paths, or could we get 
away with just always using RCU? Realistically, pagetable pages aren't 
likely to be freed all that frequently, except perhaps at domain 
teardown, but that shouldn't really be performance-critical, and I guess 
we could stick an RCU sync point in iommu_domain_free() if we're really 
worried about releasing larger quantities of pages back to the allocator 
ASAP?

It's already a driver opt-in to use the iommu_iotlb_gather freelist in 
the first place, and right now the ones that do are also the ones that 
do lock-free table walks so will ultimately all want this as well.

Robin.

>> +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
>> +			    struct list_head *pages)
>> +{
>> +	struct page *page, *next;
>> +
>> +	if (!domain->concurrent_traversal) {
>> +		put_pages_list(pages);
>> +		return;
>> +	}
>> +
>> +	list_for_each_entry_safe(page, next, pages, lru) {
>> +		list_del(&page->lru);
>> +		call_rcu(&page->rcu_head, pgtble_page_free_rcu);
>> +	}
> 
> It seems OK, but I wonder if there is benifit to using
> put_pages_list() from the rcu callback
> 
> Jason
