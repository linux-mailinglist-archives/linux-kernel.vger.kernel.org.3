Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83AA545BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346344AbiFJF7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiFJF7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:59:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668E012F0F7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 22:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654840775; x=1686376775;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bi5/vUaFBJ5/BUicsPXQdGCHavfxj1TbsC4ptkwormA=;
  b=S627IlGxk6ixXFyKFQ6n531Znf/MdOOAuZqLk4wb32LlOSXM/fbeC6Uy
   +63b4fSKjNin3KV5Jarff35k1M1tu8hn7k6mHfyvVzDiU8RAz0zm8dK4U
   kH7yHF7+4MzFSCPhx0uEUbxlMIqdAupgkhq5ukVMNdpAkenH3RBTM9wNo
   ax2h7bd4WEuUDpiQTS5gGw563jcd0SZMI/oR0mGA01fQIZNCxo6a56pBN
   fYa36oWpLiSjvcU1jMTZ4SvICK9DpmMWrJHMY0xhCTZ6ffFTY0pd9fpqY
   sij5MABMzfMxNKQec8HCfmFOJfo+Nyc9GRqMl5myoJ/E9OlLcdaL8vumn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="277557868"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="277557868"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 22:59:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="637952801"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148]) ([10.249.169.148])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 22:59:32 -0700
Message-ID: <df138613-c098-031f-e906-6599ed1076f9@linux.intel.com>
Date:   Fri, 10 Jun 2022 13:59:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
 <20220609124934.GZ1343366@nvidia.com>
 <9a339b42-2993-f7e2-3122-764a486e796f@arm.com>
 <20220609133234.GA1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220609133234.GA1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/9 21:32, Jason Gunthorpe wrote:
> On Thu, Jun 09, 2022 at 02:19:06PM +0100, Robin Murphy wrote:
> 
>> Is there a significant benefit to keeping both paths, or could we get away
>> with just always using RCU? Realistically, pagetable pages aren't likely to
>> be freed all that frequently, except perhaps at domain teardown, but that
>> shouldn't really be performance-critical, and I guess we could stick an RCU
>> sync point in iommu_domain_free() if we're really worried about releasing
>> larger quantities of pages back to the allocator ASAP?
> 
> I think you are right, anything that uses the iommu_iotlb_gather may
> as well use RCU too.
> 
> IIRC the allocators already know that RCU is often sitting on
> freed-memory and have some contigency to flush it out before OOMing,
> so nothing special should be needed.

Fair enough. How about below code?

static void pgtble_page_free_rcu(struct rcu_head *rcu)
{
         struct page *page = container_of(rcu, struct page, rcu_head);

         __free_pages(page, 0);
}

/*
  * Free pages gathered in the freelist of iommu_iotlb_gather. Use RCU free
  * way so that it's safe for lock-free page table walk.
  */
void iommu_free_iotlb_gather_pages(struct iommu_iotlb_gather *iotlb_gather)
{
         struct page *page, *next;

         list_for_each_entry_safe(page, next, &iotlb_gather->freelist, 
lru) {
                 list_del(&page->lru);
                 call_rcu(&page->rcu_head, pgtble_page_free_rcu);
         }
}

Best regards,
baolu
