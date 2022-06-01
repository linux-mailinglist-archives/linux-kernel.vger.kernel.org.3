Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96D4539CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349674AbiFAFrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiFAFri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:47:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03D723140
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654062456; x=1685598456;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pz8nnaQVnwSBHflv/+Mi+yb60f/0IVaCCTD8aF3LOog=;
  b=Hh5MuuRxoSFobsb0CqlrBut218ZaGY+5XGabZFSfmmd5/fVRAah2PEeC
   K3bURbVQjIFTKLEESwRNNQMa97LDZv+DlNZo3HPYFsQld9NQ94s3F6avW
   yeYhCfUr3zzu0bVw19Y7KKGKqPp3ulVa36kZ8//EG65eNiY/yxfKHNPBX
   4N+36unWGUivY6gpGD/RL77ddd1vQY0ibCV4zqmPXV8GJ2klaehuhoCzx
   y+TplZrNxU13gBKVjBICYfBgViyvEux0rPgTvIS/LZ1CHyhMnDO6cs1re
   7YpyKfTD+oPj2hSNYkCWuyCD44DQ8+e9jJDBJznJPriZn8/Usv8swdMeH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="300829816"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="300829816"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 22:47:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="706909235"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123]) ([10.255.28.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 22:47:33 -0700
Message-ID: <5da96e23-113d-c0e3-fb17-2ae52a66ec8e@linux.intel.com>
Date:   Wed, 1 Jun 2022 13:47:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
 <20220531155904.GA3726345@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220531155904.GA3726345@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/31 23:59, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 02:52:28PM +0100, Robin Murphy wrote:
> 
>>> +                break;
>>> +            pgtable_walk_level(m, phys_to_virt(phys_addr),
>>
>> Also, obligatory reminder that pfn_valid() only means that pfn_to_page()
>> gets you a valid struct page. Whether that page is direct-mapped kernel
>> memory or not is a different matter.
> 
> Even though this is debugfs, if the operation is sketchy like that and
> can theortically crash the kernel the driver should test capabilities,
> CAP_SYS_RAWIO or something may be appropriate. I don't think we have a
> better cap for 'userspace may crash the kernel'

Yes. We should test both CAP_SYS_ADMIN and CAP_SYS_RAWIO.

Best regards,
baolu

