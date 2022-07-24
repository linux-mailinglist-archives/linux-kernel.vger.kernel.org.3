Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762E957F567
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiGXOE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 10:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGXOE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 10:04:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E372112621
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658671496; x=1690207496;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4SB7MknA24m1jUG2lvk0lBvwcZyqcGj7Lokl0Nv3fhk=;
  b=CxlLKRZl99+3Tk8lXzRN8gTj9VR0K4IV5HGgc2MH4tUHuB6JVWYTb+iO
   pApM9ph5uDQYs4/gTw9+B0V0aVjbcRDc/arlmAGHYR7SYOSZE3FRb9FVL
   G6pH/h9Pb70oef5rtJZGJN/+DXGBLHvtR4CpIjSRBCGfW+JwuQ/INiZxf
   2yqcuhxPETTIyiOHYdvEjtlx57GUwFXMfzr3wxpj6Jcp9mAVhELUVTi3r
   j7qL15YlfjuHs5zyVSInps/yHFDsCyxXJmiU6gEu3OQpik1lgko8H4PVM
   gCKPebPN+sEZnfxTdAPlDHMu3tiJViZnn+EmDVhvuHREc8vSesy5iGIAs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="267320782"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="267320782"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 07:04:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657820532"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 07:04:52 -0700
Message-ID: <487b533a-b289-eee7-0bd8-3be36c6e00e3@linux.intel.com>
Date:   Sun, 24 Jul 2022 22:04:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 10/12] iommu: Prepare IOMMU domain for IOPF
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-11-baolu.lu@linux.intel.com>
 <20220723143334.GJ79279@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220723143334.GJ79279@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/23 22:33, Jason Gunthorpe wrote:
> On Tue, Jul 05, 2022 at 01:07:08PM +0800, Lu Baolu wrote:
>> This adds some mechanisms around the iommu_domain so that the I/O page
>> fault handling framework could route a page fault to the domain and
>> call the fault handler from it.
>>
>> Add pointers to the page fault handler and its private data in struct
>> iommu_domain. The fault handler will be called with the private data
>> as a parameter once a page fault is routed to the domain. Any kernel
>> component which owns an iommu domain could install handler and its
>> private parameter so that the page fault could be further routed and
>> handled.
>>
>> This also prepares the SVA implementation to be the first consumer of
>> the per-domain page fault handling model. The I/O page fault handler
>> for SVA is copied to the SVA file with mmget_not_zero() added before
>> mmap_read_lock().
>>
>> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Tested-by: Tony Zhu <tony.zhu@intel.com>
>> ---
>>   include/linux/iommu.h         |  3 ++
>>   drivers/iommu/iommu-sva-lib.h |  8 +++++
>>   drivers/iommu/io-pgfault.c    |  7 +++++
>>   drivers/iommu/iommu-sva-lib.c | 58 +++++++++++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c         |  4 +++
>>   5 files changed, 80 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index ae0cfca064e6..47610f21d451 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -105,6 +105,9 @@ struct iommu_domain {
>>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>> +	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
>> +						      void *data);
>> +	void *fault_data;
>>   	union {
>>   		struct {
>>   			iommu_fault_handler_t handler;
> 
> Why do we need two falut callbacks? The only difference is that one is
> recoverable and the other is not, right?
> 
> Can we run both down the same op?

The iommu_fault_handler_t is for report_iommu_fault() which could be
replaced with the newer iommu_report_device_fault().

https://lore.kernel.org/linux-iommu/Yo4Nw9QyllT1RZbd@myrica/

> 
>> +/*
>> + * I/O page fault handler for SVA
>> + */
>> +enum iommu_page_response_code
>> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>> +{
>> +	vm_fault_t ret;
>> +	struct vm_area_struct *vma;
>> +	struct mm_struct *mm = data;
>> +	unsigned int access_flags = 0;
>> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> +	struct iommu_fault_page_request *prm = &fault->prm;
>> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>> +
>> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> +		return status;
>> +
>> +	if (IS_ERR_OR_NULL(mm) || !mmget_not_zero(mm))
> 
> Do not use IS_ERR_ON_NULL. mm should never be null here since the
> fault handler should have been removed from the domain before the
> fault_data is changed.

Yes. Updated.

Best regards,
baolu

