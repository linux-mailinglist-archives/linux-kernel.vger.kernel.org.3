Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC37545BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346133AbiFJFhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbiFJFh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:37:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FB6387188
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654839445; x=1686375445;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6a8QudFS6MG+aPxhpladdSOsdGbNDj5qg8atPxMfEDg=;
  b=KTQEOsFnQWBCrlt0hn38ofXps6N2upeidNgywiOqeha2eBhFEy945t+6
   Tp6xdtYKIA9plbkGmKV3DkOzQqm4zP1oDpZEikRFeZctLyD68yZZ8yImp
   IotSlCv0CkPBnqACC7WAnO/wJDYBT9vpJmvR2vrJmHaevRDSFfaUuXK2u
   5qMkq8L+8yXqmvO8gU7qBUTi3PbPCpnqzKxUgamAez098yaV3LTvl4Kra
   Kf95SAvBdmZ1JZvq6qk0dP7GW23DyJsZ9atkl0jcLjPEj6BgHo97JqtGN
   xlxcTCp4Z431POU/tMcRPJmDEkbF2SJIQ1LuhcvbABD3TFtcF7WAIj79I
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276296029"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="276296029"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 22:37:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="637944554"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148]) ([10.249.169.148])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 22:37:22 -0700
Message-ID: <bbada5b7-737f-03dd-7d42-2ebad442a2bb@linux.intel.com>
Date:   Fri, 10 Jun 2022 13:37:20 +0800
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
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220609124934.GZ1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/9 20:49, Jason Gunthorpe wrote:
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
> It seems OK, but I wonder if there is benifit to using
> put_pages_list() from the rcu callback

The price is that we need to allocate a "struct list_head" and free it
in the rcu callback as well. Currently the list_head is sitting in the
stack.

Best regards,
baolu
