Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB45392FA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbiEaOLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345209AbiEaOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:11:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5916CD1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654006302; x=1685542302;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jlWqAS9a8O9NkMkuZlVFXTKLAixuk0JanbpsgrmgyZM=;
  b=SHq8wRSVmQiQqdNNXacgTtPXWJny5B6BiBXaE+evBxo65PZqf5kJWfJM
   oE6Rzxa+0yg0ow01sWlJKwJA9nBKXebl7bZda1WwqLSRh4QZ1YgYNO99s
   OkAKzIwk6o00Q0XwPnSXZTbzaQRPe93OcNK09jK1v3tAonTi7x6t9f0mN
   3DK9jI8GrE0JQR74NLlYz7Xmzv0LS2PhA+/h0Ru5IpHiMlPfc/EanG9ya
   vxFwq+b+DtDN3LAijFIFo7LQmXmFz7+zNvcvpHiKMqaTlqaNo1/04NEjJ
   2tuOc2CE49EwuUg8VxmK2OPRt4JEyNc5v1XfLtTJ+ZmanEqTcBiF4+PAE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="262895347"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="262895347"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 07:11:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="605689795"
Received: from peakwan.ccr.corp.intel.com (HELO [10.249.168.229]) ([10.249.168.229])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 07:11:20 -0700
Message-ID: <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
Date:   Tue, 31 May 2022 22:11:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220531131052.GD1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/31 21:10, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 11:02:06AM +0800, Baolu Lu wrote:
> 
>> For case 2, it is a bit weird. I tried to add a rwsem lock to make the
>> iommu_unmap() and dumping tables in debugfs exclusive. This does not
>> work because debugfs may depend on the DMA of the devices to work. It
>> seems that what we can do is to allow this race, but when we traverse
>> the page table in debugfs, we will check the validity of the physical
>> address retrieved from the page table entry. Then, the worst case is to
>> print some useless information.
> 
> Sounds horrible, don't you have locking around the IOPTEs of some
> kind? How does updating them work reliably?

There's no locking around updating the IOPTEs. The basic assumption is
that at any time, there's only a single thread manipulating the mappings
of the range specified in iommu_map/unmap() APIs. Therefore, the race
only exists when multiple ranges share some high-level IOPTEs. The IOMMU
driver updates those IOPTEs using the compare-and-exchange atomic
operation.

> 
> It is just debugfs, so maybe it is not the end of the world, but
> still..

Fair enough. I think this is somewhat similar to that IOMMU hardware can
traverse the page table at any time without considering when the CPUs
update it. The IOMMU hardware will generate faults when it encounters
failure during the traverse of page table. Similarly, perhaps debugfs
could dump all-ones for an invalid IOPTE?

Best regards,
baolu
