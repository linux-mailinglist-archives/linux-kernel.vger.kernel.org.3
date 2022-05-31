Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584305395E1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbiEaSHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiEaSHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:07:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FCCC33351
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:07:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77CB023A;
        Tue, 31 May 2022 11:07:40 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA0B3F766;
        Tue, 31 May 2022 11:07:38 -0700 (PDT)
Message-ID: <10f16c13-c50d-892c-a20d-979b2135c953@arm.com>
Date:   Tue, 31 May 2022 19:07:32 +0100
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
References: <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
 <20220531162152.GH1343366@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531162152.GH1343366@nvidia.com>
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

On 2022-05-31 17:21, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 05:01:46PM +0100, Robin Murphy wrote:
> 
>> The DMA API doesn't need locking, partly since it can trust itself not to do
>> stupid things, and mostly because it's DMA API performance that's
>> fundamentally incompatible with serialisation anyway. Why do you think we
>> have a complicated per-CPU IOVA caching mechanism, if not to support big
>> multi-queue devices with multiple CPU threads mapping/unmapping in different
>> parts of the same DMA domain concurrently?
> 
> Well, per-CPU is a form of locking.

Right, but that only applies for alloc_iova_fast() itself - once the 
CPUs have each got their distinct IOVA region, they can then pile into 
iommu_map() completely unhindered (and the inverse for the unmap path).

> So what are the actual locking rules here? We can call map/unmap
> concurrently but not if ... ?
> 
> IOVA overlaps?

Well, I think the de-facto rule is that you technically *can* make 
overlapping requests, but one or both may fail, and the final outcome in 
terms of what ends up mapped in the domain is undefined (especially if 
they both succeed). The only real benefit of enforcing serialisation 
would be better failure behaviour in such cases, but it remains 
fundamentally nonsensical for callers to make contradictory requests 
anyway, whether concurrently or sequentially, so there doesn't seem much 
point in spending effort on improving support for nonsense.

> And we expect the iommu driver to be unable to free page table levels
> that have IOVA boundaries in them?

I'm not entirely sure what you mean there, but in general an unmap 
request is expected to match some previous map request - there isn't a 
defined API-level behaviour for partial unmaps. They might either unmap 
the entire region originally mapped, or just the requested part, or 
might fail entirely (IIRC there was some nasty code in VFIO for 
detecting a particular behaviour). Similarly for unmapping anything 
that's already not mapped, some drivers treat that as a no-op, others as 
an error. But again, this is even further unrelated to concurrency.

>> The simpler drivers already serialise on a per-domain lock internally, while
>> the more performance-focused ones implement lock-free atomic pagetable
>> management in a similar style to CPU arch code; either way it should work
>> fine as-is.
> 
> The mm has page table locks at every level and generally expects them
> to be held for a lot of manipulations. There are some lockless cases,
> but it is not as aggressive as this sounds.

Oh, I've spent the last couple of weeks hacking up horrible things 
manipulating entries in init_mm, and never realised that that was 
actually the special case. Oh well, live and learn.

Robin.
