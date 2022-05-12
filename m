Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F00B5244C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349515AbiELFRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345698AbiELFRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:17:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491CA62A0B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652332634; x=1683868634;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JZD9ZoRZafokL8iPENWer3ntJWFW7GvCYTn95IARhRg=;
  b=V8HR9PbwnClzeLU3EtR6ZAOIjkkRby6LftE4VWvH+h3tQLAeLgszN80s
   CNWHyMa9GAUzgEVywJjVP+YDg6QQWUOw4En1QZO0e29Ati0WA5MPyzoaG
   wwX8IfnEGtQBFv7auR/tsUGViyOER077eNNrOWBPzF8hlP4EkW40N9tDk
   j1Zn8MlLuxig6skGAabgH+Ot2EQnTdRL8xQNYokm28x2BEMe7hrPz/q4h
   9v4zsCACch0/+f7EEHyvI7LAQTKVI0KcL+RPp25cODgmaT3MytPkcT9PD
   E1yJgydzVgmyAMp9gCltELlZXL4OYDMiR7Q67BxlQr6zp0GwPr7wuFsWv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295139587"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="295139587"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 22:17:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="594492936"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168]) ([10.255.29.168])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 22:17:10 -0700
Message-ID: <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
Date:   Thu, 12 May 2022 13:17:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
 <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 13:01, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 12, 2022 11:03 AM
>>
>> On 2022/5/11 22:53, Jason Gunthorpe wrote:
>>>>> Also, given the current arrangement it might make sense to have a
>>>>> struct iommu_domain_sva given that no driver is wrappering this in
>>>>> something else.
>>>> Fair enough. How about below wrapper?
>>>>
>>>> +struct iommu_sva_domain {
>>>> +       /*
>>>> +        * Common iommu domain header,*must*  be put at the top
>>>> +        * of the structure.
>>>> +        */
>>>> +       struct iommu_domain domain;
>>>> +       struct mm_struct *mm;
>>>> +       struct iommu_sva bond;
>>>> +}
>>>>
>>>> The refcount is wrapped in bond.
>>> I'm still not sure that bond is necessary
>>
>> "bond" is the sva handle that the device drivers get through calling
>> iommu_sva_bind().
>>
> 
> 'bond' was required before because we didn't have a domain to wrap
> the page table at that time.
> 
> Now we have a domain and it is 1:1 associated to bond. Probably
> make sense now by just returning the domain as the sva handle
> instead?

It also includes the device information that the domain has been
attached. So the sva_unbind() looks like this:

/**
  * iommu_sva_unbind_device() - Remove a bond created with 
iommu_sva_bind_device
  * @handle: the handle returned by iommu_sva_bind_device()
  *
  * Put reference to a bond between device and address space. The device 
should
  * not be issuing any more transaction for this PASID. All outstanding page
  * requests for this PASID must have been flushed to the IOMMU.
  */
void iommu_sva_unbind_device(struct iommu_sva *handle)

It's fine to replace the iommu_sva with iommu_sva_domain for sva handle,
if we can include the device in the unbind() interface.

Anyway, I'd expect to achieve all these in two steps:

- sva and iopf refactoring, only iommu internal changes;
- sva interface refactoring, only interface changes.

Does above work?

Best regards,
baolu
