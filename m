Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202C954D84F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344998AbiFPC1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFPC1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:27:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C04A4756F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655346427; x=1686882427;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+zsE1yD1mIDCXQBJJ5Ri010dHnoDRkJfwr7YyFuCg+U=;
  b=GnDcUIKxGtRBYNZ1Fw6ArHxMAwW18DR9uMZNucwQWL86JImWBK9QgtGt
   8F471P5aAQCgMX+gstT1dcFuMIWxGewyoPhdHG12Mhj4p3KIjMmjVtz5S
   jKU7KLUZmtmQ1tn2xtECW7a1aItDBVRFNaYP8AMoDjI/WtkUpqpdP4JEX
   uwy2ON2J51g5afVb1uM6qC6FKkqLlOMIzeNwKZg4axGs0TBvOAiVPuMo5
   MLblKMBGkfnPJ98+arJmhNFrqupnJBO4XxlDhZyS/QRLYPWw/GcwYXJFI
   8bG9ZLM26JnZihHRlW+z+TVfVYnbpvCYr0ltJkTROn1cw3hRER3JcLMTX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="340803427"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="340803427"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 19:27:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="831361599"
Received: from yuefengs-mobl.ccr.corp.intel.com (HELO [10.255.30.105]) ([10.255.30.105])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 19:27:04 -0700
Message-ID: <6b8a4728-62c0-edb2-7b13-c4f01f5dc41a@linux.intel.com>
Date:   Thu, 16 Jun 2022 10:27:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
 <20220609124934.GZ1343366@nvidia.com>
 <bbada5b7-737f-03dd-7d42-2ebad442a2bb@linux.intel.com>
 <20220615154040.GA4927@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220615154040.GA4927@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/15 23:40, Jason Gunthorpe wrote:
> On Fri, Jun 10, 2022 at 01:37:20PM +0800, Baolu Lu wrote:
>> On 2022/6/9 20:49, Jason Gunthorpe wrote:
>>>> +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
>>>> +			    struct list_head *pages)
>>>> +{
>>>> +	struct page *page, *next;
>>>> +
>>>> +	if (!domain->concurrent_traversal) {
>>>> +		put_pages_list(pages);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	list_for_each_entry_safe(page, next, pages, lru) {
>>>> +		list_del(&page->lru);
>>>> +		call_rcu(&page->rcu_head, pgtble_page_free_rcu);
>>>> +	}
>>> It seems OK, but I wonder if there is benifit to using
>>> put_pages_list() from the rcu callback
>>
>> The price is that we need to allocate a "struct list_head" and free it
>> in the rcu callback as well. Currently the list_head is sitting in the
>> stack.
> 
> You'd have to use a different struct page layout so that the list_head
> was in the struct page and didn't overlap with the rcu_head

Okay, let me head this direction in the next version.

Best regards,
baolu
