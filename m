Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D6147993D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 07:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhLRGzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 01:55:32 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:57519 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhLRGzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 01:55:31 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id yTctmAwLisoWhyTctm8zt5; Sat, 18 Dec 2021 07:55:29 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 18 Dec 2021 07:55:29 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] iommu/vt-d: Use bitmap_zalloc() when applicable
To:     Lu Baolu <baolu.lu@linux.intel.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <367914663187b8fe043e31b352cd6ad836088f0a.1639778255.git.christophe.jaillet@wanadoo.fr>
 <73bdc4a3-6028-2ab5-f9a6-dbad15effad4@linux.intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <935af038-1b75-2717-40fa-e2e7858ed09e@wanadoo.fr>
Date:   Sat, 18 Dec 2021 07:55:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <73bdc4a3-6028-2ab5-f9a6-dbad15effad4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/12/2021 à 06:56, Lu Baolu a écrit :
> On 2021/12/18 5:58, Christophe JAILLET wrote:
>> 'ommu->domain_ids' is a bitmap. So use 'bitmap_zalloc()' to simplify
>> code and improve the semantic, instead of hand writing it.
>>
>> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
>> consistency.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/iommu/intel/iommu.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index b6a8f3282411..4acc97765209 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1878,17 +1878,16 @@ static void iommu_disable_translation(struct 
>> intel_iommu *iommu)
>>   static int iommu_init_domains(struct intel_iommu *iommu)
>>   {
>> -    u32 ndomains, nlongs;
>> +    u32 ndomains;
>>       size_t size;
>>       ndomains = cap_ndoms(iommu->cap);
>>       pr_debug("%s: Number of Domains supported <%d>\n",
>>            iommu->name, ndomains);
>> -    nlongs = BITS_TO_LONGS(ndomains);
>>       spin_lock_init(&iommu->lock);
>> -    iommu->domain_ids = kcalloc(nlongs, sizeof(unsigned long), 
>> GFP_KERNEL);
>> +    iommu->domain_ids = bitmap_zalloc(ndomains, GFP_KERNEL);
>>       if (!iommu->domain_ids)
>>           return -ENOMEM;
>> @@ -1903,7 +1902,7 @@ static int iommu_init_domains(struct intel_iommu 
>> *iommu)
>>       if (!iommu->domains || !iommu->domains[0]) {
>>           pr_err("%s: Allocating domain array failed\n",
>>                  iommu->name);
>> -        kfree(iommu->domain_ids);
>> +        bitmap_free(iommu->domain_ids);
>>           kfree(iommu->domains);
>>           iommu->domain_ids = NULL;
>>           iommu->domains    = NULL;
>> @@ -1964,7 +1963,7 @@ static void free_dmar_iommu(struct intel_iommu 
>> *iommu)
>>           for (i = 0; i < elems; i++)
>>               kfree(iommu->domains[i]);
>>           kfree(iommu->domains);
>> -        kfree(iommu->domain_ids);
>> +        bitmap_free(iommu->domain_ids);
>>           iommu->domains = NULL;
>>           iommu->domain_ids = NULL;
>>       }
> 
> This patch has been merged to Joerg's tree through
> 
> https://lore.kernel.org/linux-iommu/20211217083817.1745419-2-baolu.lu@linux.intel.com/ 
> 
> 
> Are there any extra changes in this one?

No, this is the same. Sorry for the duplicate.

CJ

> 
> Best regards,
> baolu
> 

