Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED653989F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347986AbiEaVWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347972AbiEaVWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:22:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45025590B3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:22:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A35023A;
        Tue, 31 May 2022 14:22:39 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9ECA3F66F;
        Tue, 31 May 2022 14:22:37 -0700 (PDT)
Message-ID: <56bbbad7-bcba-a440-692b-64e50b4eddf8@arm.com>
Date:   Tue, 31 May 2022 22:22:32 +0100
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
References: <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
 <20220531162152.GH1343366@nvidia.com>
 <10f16c13-c50d-892c-a20d-979b2135c953@arm.com>
 <20220531185110.GJ1343366@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531185110.GJ1343366@nvidia.com>
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

On 2022-05-31 19:51, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 07:07:32PM +0100, Robin Murphy wrote:
> 
>>> And we expect the iommu driver to be unable to free page table levels
>>> that have IOVA boundaries in them?
>>
>> I'm not entirely sure what you mean there, but in general an unmap request
>> is expected to match some previous map request
> 
> atomic cmpxchg is OK for inserting new page table levels but it can't
> protect you against concurrent freeing of page table levels. So
> without locks it means that page tables can't usually be freed. Which
> seems to match what the Intel driver does - at least from a cursory
> look.
> 
> This is one of the reasons the mm has the mmap/etc lock and spinlocks
> because we do expect page table levels to get wiped out when VMA's are
> zap'd - all the different locks provide the protection against page
> tables disappearing under from something manipulating them.
> 
> Basically every "lockless" walk in (process) MM land is actually
> protected by some kind of lock that blocks zap_page_range() from
> removing the page table levels themselves.

I'm not an expert in the Intel or AMD code, so I can only speak with 
confidence about what we do in io-pgtable-arm, but the main reason for 
not freeing pagetables is that it's simply not worth the bother of 
trying to work out whether a whole sub-tree is empty. Not to mention 
whether it's *still* empty by the time that we may have figured out that 
it was.

There are only 3 instances where we'll free a table while the domain is 
live. The first is the one legitimate race condition, where two map 
requests targeting relatively nearby PTEs both go to fill in an 
intermediate level of table; whoever loses that race frees the table 
they allocated, but it was never visible to anyone else so that's 
definitely fine. The second is if we're mapping a block entry, and find 
that there's already a table entry there, wherein we assume the table 
must be empty, clear the entry, invalidate any walk caches, install the 
block entry, then free the orphaned table; since we're mapping the 
entire IOVA range covered by that table, there should be no other 
operations on that IOVA range attempting to walk the table at the same 
time, so it's fine. The third is effectively the inverse, if we get a 
block-sized unmap but find a table entry rather than a block at that 
point (on the assumption that it's de-facto allowed for a single unmap 
to cover multiple adjacent mappings as long as it does so exactly); 
similarly we assume that the table must be full, and no other operations 
should be racing because we're unmapping its whole IOVA range, so we 
remove the table entry, invalidate, and free as before.

Again for efficiency reasons we don't attempt to validate those 
assumptions by inspecting the freed tables, so odd behaviour can fall 
out if the caller *does* do something bogus. For example if two calls 
race to map a block and a page in the same (unmapped) region, the block 
mapping will always succeed (and be what ends up in the final pagetable 
state), but the page mapping may or may not report failure depending on 
the exact timing.

Although we don't have debug dumping for io-pgtable-arm, it's good to be 
thinking about this, since it's made me realise that dirty-tracking 
sweeps per that proposal might pose a similar kind of concern, so we 
might still need to harden these corners for the sake of that. Which 
also reminds me that somewhere I have some half-finished patches making 
io-pgtable-arm use the iommu_iotlb_gather freelist, so maybe I'll tackle 
both concerns at once (perhaps we might even be able to RCU-ify the 
freelist generically? I'll see how it goes when I get there).

Cheers,
Robin.
