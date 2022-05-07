Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A751E6FF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384881AbiEGMnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbiEGMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:43:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D46A4475C
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651927195; x=1683463195;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=YmK2sF5H1jxPtXJwdIL8ZX3BDZKl/eFl1duDkPG7Phk=;
  b=a2+cd/3hf6fYkmQ3yEhZszdmXHOljVOmTGj2gkF/xiXk+E2SZlt6ntla
   NFfGDbcLm1chFCeYmogaCJ//JnDRti4IGC60xRxlc23PA1+0YB18ESBsd
   TbVbKZEuMwPLTf/WLHvjLkulJuBo/TlcIYQYNsXQY9wyxnYAg/qCl2oIY
   P0MfqVs22BUNw0UnPZJ3+lcAL0R+8CK0l+MZVyiQ/w58jQwHjqquOTjIm
   KBSeMpopjwCRWCBl/V7DBmAm6D4TNX8KXrlzOSAflfS1gUv3eAlnnKkG5
   nt+Acihiq/bWKU1y0ge+Q/SDuF3yY0c3t9O4jsuejwHzO8wixnSPfkbAc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="249239598"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="249239598"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 05:39:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="586492100"
Received: from zhuangxi-mobl.ccr.corp.intel.com (HELO [10.255.30.94]) ([10.255.30.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 05:39:51 -0700
Message-ID: <86fd8977-1134-02d2-d9e3-19ce58cb9de4@linux.intel.com>
Date:   Sat, 7 May 2022 20:39:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 04/12] iommu/sva: Basic data structures for SVA
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-5-baolu.lu@linux.intel.com> <YnFv0ps0Ad8v+7uH@myrica>
 <d490e542-140c-58c3-bb11-9990795272b1@linux.intel.com>
 <669fb111-9821-aadc-acbf-de42bc551fc4@linux.intel.com>
In-Reply-To: <669fb111-9821-aadc-acbf-de42bc551fc4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/7 16:32, Baolu Lu wrote:
> Hi Jean,
> 
> On 2022/5/5 14:42, Baolu Lu wrote:
>> On 2022/5/4 02:09, Jean-Philippe Brucker wrote:
>>> On Mon, May 02, 2022 at 09:48:34AM +0800, Lu Baolu wrote:
>>>> Use below data structures for SVA implementation in the IOMMU core:
>>>>
>>>> - struct iommu_sva_ioas
>>>>    Represent the I/O address space shared with an application CPU 
>>>> address
>>>>    space. This structure has a 1:1 relationship with an mm_struct. It
>>>>    grabs a "mm->mm_count" refcount during creation and drop it on 
>>>> release.
>>>
>>> Do we actually need this structure?  At the moment it only keeps 
>>> track of
>>> bonds, which we can move to struct dev_iommu. Replacing it by a mm 
>>> pointer
>>> in struct iommu_domain simplifies the driver and seems to work
>>
>> Fair enough.
>>
>> +struct iommu_sva_ioas {
>> +    struct mm_struct *mm;
>> +    ioasid_t pasid;
>> +
>> +    /* Counter of domains attached to this ioas. */
>> +    refcount_t users;
>> +
>> +    /* All bindings are linked here. */
>> +    struct list_head bonds;
>> +};
>>
>> By moving @mm to struct iommu_domain and @bonds to struct dev_iommu, the
>> code looks simpler. The mm, sva domain and per-device dev_iommu are
>> guaranteed to be valid during bind() and unbind().
>>
>> Will head this direction in the next version.
> 
> I'm trying to implement this idea in real code. It seems that we need
> additional fields in struct iommu_domain to track which devices the mm
> was bound to. It doesn't simplify the code much. Any thoughts?

Sorry, Jean. This has been discussed. We don't need to share sva domain
among devices at this stage. It's not a big issue to sva domain as it's
a dumb domain which has no support for map()/unmap() and the cache
manipulation.

I will still head this direction. Sorry for the noise.

Best regards,
baolu

