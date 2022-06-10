Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664DA546116
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348493AbiFJJJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348414AbiFJJJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:09:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457F283E96
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654852036; x=1686388036;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KWBbBv0fNbkt9AOdrz/gHPWthaP0yG+qgfQ5rAjHmCE=;
  b=VaRRoc+cWdFVOvMRfY/Ozb7S/cKSOR0lM17qOKtjB1KtwatyOMAiWMTC
   iDMUb9FacXfrmYUp+7r9HZJQku5TXMu83TD5j5zLmLGEAnouDMFf6I0UF
   hQNEZD4a5yGOkGA1OHgTOUdzN4YCXqpW5mPknnPRzelMd1Dj+S2wdXGC3
   U5sMnSORy8CZkFlT7LtAmsURd6hrYVpEd71LaSQpSRsOlG9znJiqcHxZy
   Bg5Xq/i2MFwwsSSVvmXCJy8jXav9wfJfOsHG7W3mjWt+Y9hHU8Pp3zac7
   If1OiRko/38JEwmfqo5rxi/NoMWeocskV/wL4fR7GG7+cB1cu4bQkTlwH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276343866"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="276343866"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 02:07:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="638032467"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148]) ([10.249.169.148])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 02:07:12 -0700
Message-ID: <79c41aab-ec9c-3f5e-65d1-ff857f57816e@linux.intel.com>
Date:   Fri, 10 Jun 2022 17:07:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/11] iommu: Add max_pasids field in struct dev_iommu
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-3-baolu.lu@linux.intel.com>
 <20220609190102.GC33363@araj-dh-work>
 <f92629ef-8c9a-b89a-ef0b-32e71617bd51@linux.intel.com>
 <BN9PR11MB5276C7B4FAC55C58A5466EFC8CA69@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C7B4FAC55C58A5466EFC8CA69@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/6/10 17:01, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, June 10, 2022 2:47 PM
>>
>> On 2022/6/10 03:01, Raj, Ashok wrote:
>>> On Tue, Jun 07, 2022 at 09:49:33AM +0800, Lu Baolu wrote:
>>>> @@ -218,6 +219,30 @@ static void dev_iommu_free(struct device *dev)
>>>>    	kfree(param);
>>>>    }
>>>>
>>>> +static u32 dev_iommu_get_max_pasids(struct device *dev)
>>>> +{
>>>> +	u32 max_pasids = dev->iommu->iommu_dev->max_pasids;
>>>> +	u32 num_bits;
>>>> +	int ret;
>>>> +
>>>> +	if (!max_pasids)
>>>> +		return 0;
>>>> +
>>>> +	if (dev_is_pci(dev)) {
>>>> +		ret = pci_max_pasids(to_pci_dev(dev));
>>>> +		if (ret < 0)
>>>> +			return 0;
>>>> +
>>>> +		return min_t(u32, max_pasids, ret);
>>>
>>> Ah.. that answers my other question to consider device pasid-max. I guess
>>> if we need any enforcement of restricting devices that aren't supporting
>>> the full PASID, that will be done by some higher layer?
>>
>> The mm->pasid style of SVA is explicitly enabled through
>> iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA). The IOMMU driver
>> specific
>> restriction might be put there?
>>
>>>
>>> too many returns in this function, maybe setup all returns to the end of
>>> the function might be elegant?
>>
>> I didn't find cleanup room after a quick scan of the code. But sure, let
>> me go through code again offline.
>>
> 
> If we do care:
> 
> +static u32 dev_iommu_get_max_pasids(struct device *dev)
> +{
> +	u32 max_pasids = 0,
> +	u32 num_bits = 0;
> +	int ret;
> +
> +	if (dev_is_pci(dev)) {
> +		ret = pci_max_pasids(to_pci_dev(dev));
> +		if (ret > 0)
> +			max_pasids = ret;
> +	} else {
> +		ret = device_property_read_u32(dev, "pasid-num-bits", &num_bits);
> +		if (!ret)
> +			max_pasids = 1UL << num_bits;
> +	}
> +
> +	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
> +}

Great! Cleaner and more compact than mine. Thank you!

Best regards,
baolu
