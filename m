Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7319D53950C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbiEaQmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiEaQmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:42:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AFE45A5B3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:42:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E38523A;
        Tue, 31 May 2022 09:42:44 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DE733F66F;
        Tue, 31 May 2022 09:42:42 -0700 (PDT)
Message-ID: <80f362fd-8e69-1dcd-ba7a-abfc55894d61@arm.com>
Date:   Tue, 31 May 2022 17:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Will Deacon <will@kernel.org>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
 <20220531155904.GA3726345@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531155904.GA3726345@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 16:59, Jason Gunthorpe wrote:
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

It shouldn't be insurmountable to make this safe, it just needs a bit 
more than pfn_valid(), which can still return true off the ends of the 
memory map if they're not perfectly section-aligned, and for random 
reserved holes in the middle.

Robin.
