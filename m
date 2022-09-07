Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC595B0089
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiIGJdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGJdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:33:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB99874BBF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662543190; x=1694079190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k5YPzoTF8zWkG4kDDBbQlRFazp3TFOTCHVAL/rlhWIw=;
  b=e07Wg1l1wDfF/wbc+TkuLUy7cFa6fJJhElsB6kbaQ+xNH2EdavHnaDUx
   +NH2DA1pdmLW2aeiKzAukkx4U5hFYoXUVKI5M0aT/X2tWFY5xu/HaEWfL
   WEtNhAyCKy1K5Ot390vpmQTWkhBMu4j/IIqQG77bA5pL7HzJ0jfzeYu7R
   eyQ/nxfDsEusqB52GlQZBbWpjfLLfVea6wDB07LgnS9dEv4eFIMc+8UwO
   XEDeO7nqxkmzTwdau8pWszj1Vr54ty/Pltt8ruypaKGef/DUy+Lv/LbKA
   HKDUZQuSZoOGAmYJBKlTMBteAeWkMx6JJROj+H04d2WiRc/Gfuvfy5Xpj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="383122122"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="383122122"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:33:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="644545512"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.212.12]) ([10.254.212.12])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:33:05 -0700
Message-ID: <7c4383ac-0b0b-dd43-9958-dbd4abeea63f@linux.intel.com>
Date:   Wed, 7 Sep 2022 17:33:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To:     John Garry <john.garry@huawei.com>, robin.murphy@arm.com,
        joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

在 2022/9/6 18:50, John Garry 写道:
> On 06/09/2022 10:28, Ethan Zhao wrote:
>
> Hi Ethan,
>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/iommu/iova.c | 7 ++-----
>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index 47d1983dfa2a..580fdf669922 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine 
>>> *mag, struct iova_domain *iovad)
>>>       unsigned long flags;
>>>       int i;
>>> -    if (!mag)
>>> -        return;
>>> -
>>
>> iommu_probe_device
>>    ops->probe_finalize(dev);
>>      intel_iommu_probe_finalize
>>         iommu_setup_dma_ops
>>           iommu_dma_init_domain(domain, dma_base, dma_limit, dev)
>>             iova_domain_init_rcaches
>>               {
>>               ...
>>               cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
>>               cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
>>             if (!cpu_rcache->loaded || !cpu_rcache->prev) {
>>                  ret = -ENOMEM;
>>                        goto out_err;
>>
>> Do you mean iova_magazine_alloc() is impossible to fail ?
>
> No, iova_magazine_alloc() may fail and return NULL. But if it does 
> then we set iovad rcache pointer = NULL in the error path and don't 
> use the rcache.

Yup,  if iova_magazine_alloc() failed ,

iovad->rcaches = NULL;

was set by free_iova_rcaches()

in error path of iova_domain_init_rcache().

and checked in

alloc_iova_fast()->iova_rcache_get().

More comment in code would wipe off my curiosity.


Thanks,

Ethan

>
> However we have a !iovad->rcache check on the "fast" alloc but not 
> "insert". I need to check why that is again.
>
> Thanks,
> john

-- 
"firm, enduring, strong, and long-lived"

