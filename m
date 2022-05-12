Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A74D524C44
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353476AbiELL7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbiELL7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:59:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF41217FCA
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652356787; x=1683892787;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2xpqBipggE9efSrMnAk1RxaKgm4Z25yOtIHM0l1ipSE=;
  b=D0H5/tLr9KKVS0ruxCZKIYIMnIrKdAaeVJfuzVl9AbIlc1Hx0jbd0k87
   3PJE3rNATfgzLWvHq/2BGFgRTccKz71gXhCnMC43Av5j4Pflwvo4nQ2Fl
   ZJ8Ns4CklSy48Qw9KSDXLGgX+yS6/SdCHWByL7nxmQZt5VgghI4n2MIgt
   5SNziVIlVl1N/XFamqwiOrJNwpOD/ffU2Hy8WECx5GSMcIxhIeGd7ZM9W
   So9D+TgWQcbyrfhbJeQidpEjyvpZhOel6cpctEjeUx54Ti6wwTMSzK2wE
   LoboHGZm4EnN28s23D/04e7RtsL+4MANGmac9VPtSoE5wfS5qXve2jLQC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="356404381"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="356404381"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 04:59:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="594633931"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168]) ([10.255.29.168])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 04:59:43 -0700
Message-ID: <1a78418a-8637-e8dd-d1de-5529f20058fd@linux.intel.com>
Date:   Thu, 12 May 2022 19:59:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
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
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
 <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
 <20220512114844.GT49344@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220512114844.GT49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 19:48, Jason Gunthorpe wrote:
> On Thu, May 12, 2022 at 01:17:08PM +0800, Baolu Lu wrote:
>> On 2022/5/12 13:01, Tian, Kevin wrote:
>>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, May 12, 2022 11:03 AM
>>>>
>>>> On 2022/5/11 22:53, Jason Gunthorpe wrote:
>>>>>>> Also, given the current arrangement it might make sense to have a
>>>>>>> struct iommu_domain_sva given that no driver is wrappering this in
>>>>>>> something else.
>>>>>> Fair enough. How about below wrapper?
>>>>>>
>>>>>> +struct iommu_sva_domain {
>>>>>> +       /*
>>>>>> +        * Common iommu domain header,*must*  be put at the top
>>>>>> +        * of the structure.
>>>>>> +        */
>>>>>> +       struct iommu_domain domain;
>>>>>> +       struct mm_struct *mm;
>>>>>> +       struct iommu_sva bond;
>>>>>> +}
>>>>>>
>>>>>> The refcount is wrapped in bond.
>>>>> I'm still not sure that bond is necessary
>>>>
>>>> "bond" is the sva handle that the device drivers get through calling
>>>> iommu_sva_bind().
>>>>
>>>
>>> 'bond' was required before because we didn't have a domain to wrap
>>> the page table at that time.
>>>
>>> Now we have a domain and it is 1:1 associated to bond. Probably
>>> make sense now by just returning the domain as the sva handle
>>> instead?
>>
>> It also includes the device information that the domain has been
>> attached. So the sva_unbind() looks like this:
>>
>> /**
>>   * iommu_sva_unbind_device() - Remove a bond created with
>> iommu_sva_bind_device
>>   * @handle: the handle returned by iommu_sva_bind_device()
>>   *
>>   * Put reference to a bond between device and address space. The device
>> should
>>   * not be issuing any more transaction for this PASID. All outstanding page
>>   * requests for this PASID must have been flushed to the IOMMU.
>>   */
>> void iommu_sva_unbind_device(struct iommu_sva *handle)
>>
>> It's fine to replace the iommu_sva with iommu_sva_domain for sva handle,
>> if we can include the device in the unbind() interface.
> 
> Why would we have a special unbind for SVA?

It's about SVA kAPI for device drivers. The existing kAPIs include:

struct iommu_sva *iommu_sva_bind_device(struct device *dev,
                                         struct mm_struct *mm,
                                         void *drvdata);
void iommu_sva_unbind_device(struct iommu_sva *handle);
u32 iommu_sva_get_pasid(struct iommu_sva *handle);

> SVA should not different from normal domains it should use the normal
> detach flow too.

Best regards,
baolu
