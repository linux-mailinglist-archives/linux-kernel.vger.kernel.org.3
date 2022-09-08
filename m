Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF45B1479
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIHGN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHGNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:13:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E0A1A6C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662617603; x=1694153603;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=2IW4wWfVNHmVo/NiHYBGC//rjJKYPihI5USP8eEFU40=;
  b=DITkfaPBeGqMDdiWajOtKxACAyw7PciopFvlL2HNHGJYGqiGxBwbxdkt
   IYe1Hn/YQLofO09R5OlKIb+WFN3Z6S8GL0DuSEwKI1tHDabenon/14nZy
   h2frb7EbXjssH5Z/fHe4jN7dBklekFd1iFAJCwH8krNdbLdlOoR7OFW5k
   0a6Vu3e1A8Xhk1oEKlQIpA35vse6vcanNERTc04nhCoUSJMrKfkYeMp2O
   Tnn/IRzIC/9H+nf1OnbYDNuU1gdJoPOlFuRI588NsZ9lwSFx0zVJYBhIe
   l/owmIHiSv8kBCaW3UUOURBFz4MDEX4VCru8+1Cxbg+gVXRNB3Mcl5rrD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="284098218"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="284098218"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:13:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="943205673"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.62]) ([10.254.209.62])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:13:20 -0700
Message-ID: <7f105bae-5def-e125-9391-c774d82ff455@linux.intel.com>
Date:   Thu, 8 Sep 2022 14:13:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220718235325.3952426-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276287E75395A59865812978C919@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8e970367-746e-0e74-ba39-e941fdbfdab7@linux.intel.com>
 <BN9PR11MB52765FEEC0ED0EAB5D691FA38C959@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c24bd222-9356-0564-414d-d54ca1e2b79b@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()
In-Reply-To: <c24bd222-9356-0564-414d-d54ca1e2b79b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2022/7/25 17:39, Baolu Lu wrote:
> On 2022/7/25 15:40, Tian, Kevin wrote:
>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>> Sent: Sunday, July 24, 2022 11:00 AM
>>>
>>> Hi Kevin,
>>>
>>> On 2022/7/21 15:39, Tian, Kevin wrote:
>>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>>> Sent: Tuesday, July 19, 2022 7:53 AM
>>>>>
>>>>> @@ -88,7 +89,8 @@ extern struct list_head dmar_drhd_units;
>>>>>    static inline bool dmar_rcu_check(void)
>>>>>    {
>>>>>        return rwsem_is_locked(&dmar_global_lock) ||
>>>>> -           system_state == SYSTEM_BOOTING;
>>>>> +           system_state == SYSTEM_BOOTING ||
>>>>> +           (IS_ENABLED(CONFIG_INTEL_IOMMU)
>>>>> && !intel_iommu_enabled);
>>>>>    }
>>>>
>>>> intel_iommu_enabled is 0 if CONFIG_INTEL_IOMMU is not set.
>>>>
>>>> same for other similar checks.
>>>
>>> Sorry that I didn't get your point. If CONFIG_INTEL_IOMMU is not set,
>>> IS_ENABLED(CONFIG_INTEL_IOMMU) is 0. The adding check has no effect.
>>> Did
>>> I miss anything?
>>>
>>
>> My point was that the check on CONFIG_INTEL_IOMMU is unnecessary.
> 
> Oh, if INTEL_IOMMU is not configured, the interrupt remapping could also
> be supported, so we still need the rcu protection. We only relax the rcu
> check when INTEL_IOMMU is configured, but not enabled yet.

The next stepping, we will tie INTEL_IOMMU and VT-d IRQ_REMAPPING
together, that will make the VT-d software simpler.

Joerg also proposed this in another discussion thread:

https://lore.kernel.org/all/YrVPelnOi9nql%2F8C@8bytes.org/

After that, we have no need to add above check anymore. As this is a
quick fix for lockdep splat, we don't need to wait until that done.

Does this work for you?

Best regards,
baolu
