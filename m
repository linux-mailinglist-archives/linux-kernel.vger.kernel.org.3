Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F46B4DD958
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiCRMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiCRMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:02:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A982D4D4F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647604871; x=1679140871;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=pBffoB48lXGmhcQ4bn5CKS0U9vBbO6aigybptR2nzow=;
  b=TuRdTD+9U1TK32wJgGzkaqBHciLNBmxpEOq7JzqOasM+TZ3VnkCytSvw
   t/KPKX9SQZhh7IshhzsQiVpOBP0eEqfDav5EoFIokxRtaLE9CoastDzNb
   QtprtiNprGT3K8d0DC/228kQN9PPCBkZOej37siBbdd2GZKoBx35U3gZ7
   JzazhzCiD+ZRuBuMKT3rr8bEq85fdnI/SEvAGBpy68J21rNVmTEgv0i3r
   OdRCuEvK/Iz0ODYSfzbhMjfRiy3d8nUyQ4jfaMnzCI7Rbj0ARXvb8bXzm
   DnCy0R6fvuniq4jUjSmeNGHwSKn6BSxunpvw+CmwDOejUaQDkmE64L/tT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="255948136"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="255948136"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 05:01:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558405336"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.248]) ([10.254.215.248])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 05:01:06 -0700
Message-ID: <a10f3fcc-9e31-913d-853e-b6da5fcb36a0@linux.intel.com>
Date:   Fri, 18 Mar 2022 20:01:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
 <YjB4AyrgsnbUrlLe@myrica>
 <BN9PR11MB5276D5B88C05B509C2C790A98C109@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
In-Reply-To: <BN9PR11MB5276D5B88C05B509C2C790A98C109@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/15 19:49, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker<jean-philippe@linaro.org>
>> Sent: Tuesday, March 15, 2022 7:27 PM
>>
>> On Mon, Mar 14, 2022 at 10:07:06PM -0700, Jacob Pan wrote:
>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>
>>> An IOMMU domain represents an address space which can be attached by
>>> devices that perform DMA within a domain. However, for platforms with
>>> PASID capability the domain attachment needs be handled at device+PASID
>>> level. There can be multiple PASIDs within a device and multiple devices
>>> attached to a given domain.
>>> This patch introduces a new IOMMU op which support device, PASID, and
>>> IOMMU domain attachment. The immediate use case is for PASID capable
>>> devices to perform DMA under DMA APIs.
>>>
>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>   include/linux/iommu.h | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>> index 369f05c2a4e2..fde5b933dbe3 100644
>>> --- a/include/linux/iommu.h
>>> +++ b/include/linux/iommu.h
>>> @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
>>>    * @aux_get_pasid: get the pasid given an aux-domain
>>>    * @sva_bind: Bind process address space to device
>>>    * @sva_unbind: Unbind process address space from device
>>> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
>>> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>> Isn't that operation "assign a PASID to a domain" instead?  In patch 5,
>> the domain is already attached to the device, so set_domain_pasid() might
>> be clearer and to the point. If the IOMMU driver did the allocation we
>> could also avoid patch 1.
> iiuc this API can also work for future SIOV usage where each mdev attached
> to the domain has its own pasid. "assigning a PASID to a domain" sounds
> like going back to the previous aux domain approach which has one PASID
> per domain and that PASID is used on all devices attached to the aux domain...
> 

This also works for SVA as far as I can see. The sva_bind essentially is
to  attach an SVA domain to the PASID of a device. The sva_bind/unbind
ops could be removed with these two new callbacks.

Best regards,
baolu
