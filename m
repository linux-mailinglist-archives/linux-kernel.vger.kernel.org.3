Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE86452976C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiEQCiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiEQCiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:38:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAC245503
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652755089; x=1684291089;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TvoRtaY2Mjgh/1gRlxU2MnLeVhFHFwlZKH+8DjiQySo=;
  b=cx4wGNXg+EhSBADYG4OJgV351xlP1fOfLWVrDbDHGXn7u0wt/B6h+W3V
   VCqSp4lc1XMWtNnh9vYLR3WQCURsNiPQXfGENeodZCgbrVYv2NdDpzCTy
   IKOwbQhbZYU3WDhFeXZQ/1DfAi+OcvOlqVby6MgGy3LkLe0CZ5LH9QYnp
   p34SjkcrEL5MIy2lzkquxrsdq8X1GmFg4Q3OI7DnJ3Sx/CvZhnqgSUvdw
   rMlcolN0q0PUAxCVaTJCrPo8cz0OjJi5z9p1FTAU3xnOsSYWKvrrhnzZT
   5TznEmCt1pov2SCXIICsxAE7nvrH7sqXY8BOpPDjy+/mwcTVo6yB8zjnS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270975951"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="270975951"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 19:38:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="596859162"
Received: from ctang1-mobl.ccr.corp.intel.com (HELO [10.249.192.251]) ([10.249.192.251])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 19:37:57 -0700
Message-ID: <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
Date:   Tue, 17 May 2022 10:37:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
 <20220516135741.GV1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220516135741.GV1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 2022/5/16 21:57, Jason Gunthorpe wrote:
> On Mon, May 16, 2022 at 12:22:08PM +0100, Robin Murphy wrote:
>> On 2022-05-16 02:57, Lu Baolu wrote:
>>> Each IOMMU driver must provide a blocking domain ops. If the hardware
>>> supports detaching domain from device, setting blocking domain equals
>>> detaching the existing domain from the deivce. Otherwise, an UNMANAGED
>>> domain without any mapping will be used instead.
>> Unfortunately that's backwards - most of the implementations of .detach_dev
>> are disabling translation entirely, meaning the device ends up effectively
>> in passthrough rather than blocked.
> Ideally we'd convert the detach_dev of every driver into either
> a blocking or identity domain. The trick is knowing which is which..

I am still a bit puzzled about how the blocking_domain should be used 
when it is extended to support ->set_dev_pasid.

If it's a blocking domain, the IOMMU driver knows that setting the
blocking domain to device pasid means detaching the existing one.

But if it's an identity domain, how could the IOMMU driver choose
between:

  - setting the input domain to the pasid on device; or,
  - detaching the existing domain.

I've ever thought about below solutions:

- Checking the domain types and dispatching them to different
   operations.
- Using different blocking domains for different types of domains.

But both look rough.

> 
> Guessing going down the list:
>   apple dart - blocking, detach_dev calls apple_dart_hw_disable_dma() same as
>                IOMMU_DOMAIN_BLOCKED
> 	      [I wonder if this drive ris wrong in other ways though because
>                 I dont see a remove_streams in attach_dev]
>   exynos - this seems to disable the 'sysmmu' so I'm guessing this is
>            identity
>   iommu-vmsa - Comment says 'disable mmu translaction' so I'm guessing
>                this is idenity
>   mkt_v1 - Code looks similar to mkt, which is probably identity.
>   rkt - No idea
>   sprd - No idea
>   sun50i - This driver confusingly treats identity the same as
>            unmanaged, seems wrong, no idea.
>   amd - Not sure, clear_dte_entry() seems to set translation on but points
>         the PTE to 0 ? Based on the spec table 8 I would have expected
>         TV to be clear which would be blocking. Maybe a bug??
>   arm smmu qcomm - not sure
>   intel - blocking
> 
> These doesn't support default domains, so detach_dev should return
> back to DMA API ownership, which is either identity or something weird:
>   fsl_pamu - identity due to the PPC use of dma direct
>   msm
>   mkt
>   omap
>   s390 - platform DMA ops
>   terga-gart - Usually something called a GART would be 0 length once
>                disabled, guessing blocking?
>   tegra-smmu
> 
> So, the approach here should be to go driver by driver and convert
> detach_dev to either identity, blocking or just delete it entirely,
> excluding the above 7 that don't support default domains. And get acks
> from the driver owners.
> 

Agreed. There seems to be a long way to go. I am wondering if we could
decouple this refactoring from my new SVA API work? We can easily switch
.detach_dev_pasid to using blocking domain later.

Best regards,
baolu
