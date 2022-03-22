Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3A4E3897
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiCVFub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiCVFuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:50:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9B2DF4E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647928136; x=1679464136;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=1SnuodTzmo2WR9Zf0tKGMtHe4Kb2aNMr0wspGadKIwY=;
  b=bHa0TFWukQqYDq1rZl2yBHbBO8XOZ09CdZ3f8nAsoRUPGtkkrxMhqndX
   yuPp4oFVnoyng6UqdQ8RFhZ/7RKt99wAFB/387Nh30dglWn17MFzkpS/u
   oMqqQsgyCPi89RIvuBCoUIUZx5KT58QKCoZPG+McxiDf6rRZ2/EV7RLpj
   ptzba96yMsphDgCg/Fj5VuTWQyW5+rhpAMcLqUL36tQRebwOoewru5pXP
   Sb5SOcG/6aiYNjcxyd0Kt5TlBNtgmGmOMbw60wPIa+gvkIcGBFx91r97G
   056OBiDPmZ6ZCkCKZoslVf9QnuPWx/mMkvozQ2U/kukyXz6rwqdNHP/wA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="344159047"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="344159047"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 22:48:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="560217417"
Received: from ellenyin-mobl.ccr.corp.intel.com (HELO [10.254.213.205]) ([10.254.213.205])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 22:48:52 -0700
Message-ID: <45860360-4648-3f0b-6758-fe398aca4204@linux.intel.com>
Date:   Tue, 22 Mar 2022 13:48:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <20220321125021.GQ11336@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
In-Reply-To: <20220321125021.GQ11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 20:50, Jason Gunthorpe wrote:
> On Sun, Mar 20, 2022 at 02:40:29PM +0800, Lu Baolu wrote:
> 
>> +static enum iommu_page_response_code
>> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>> +{
>> +	vm_fault_t ret;
>> +	struct mm_struct *mm;
>> +	struct vm_area_struct *vma;
>> +	unsigned int access_flags = 0;
>> +	struct iommu_domain *domain = data;
> 
> Why is the iommu_domain not passed in as a fully typed object? I would
> think data should some opaque value used by non-sva cases.

The "data" is set together with the fault handler when the caller
installs a fault handler for an iommu domain. We will add a generic
interface to install fault handler for an iommu domain later when a real
non-sva case comes.

> 
> What is the lifetime model here anyhow?

I simply thought that the device driver should guarantee that there are
no pending faults after sva_unbind(). This is insufficient. I need to
rework this.

> 
>> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> +	struct iommu_fault_page_request *prm = &fault->prm;
>> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>> +
>> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> +		return status;
>> +
>> +	mm = domain->sva_cookie;
>> +	if (IS_ERR_OR_NULL(mm))
> 
> Do not use this function
> 
> Do not store err pointers in structs.

Sure.

> 
>> +out_put_mm:
>> +	mmap_read_unlock(mm);
>> +	mmput(mm);
> 
> mm structs are weird, they have two refcounts.
> 
> The 'sva_cookie' should hold a mmgrab/mmdrop() refcount to keep the
> pointer alive but to touch the mmap lock you have to upgrade it to a
> refcount that prevents destruction using mmget_not_zero() just for
> this short period.

Yes. Will look into it.

Best regards,
baolu
