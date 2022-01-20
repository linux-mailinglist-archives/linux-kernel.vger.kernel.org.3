Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4034945FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358273AbiATDOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:14:06 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34345 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358266AbiATDOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:14:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=zelin.deng@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V2JWwbh_1642648442;
Received: from 30.21.166.20(mailfrom:zelin.deng@linux.alibaba.com fp:SMTPD_---0V2JWwbh_1642648442)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Jan 2022 11:14:03 +0800
Message-ID: <2ad9b10f-b7b7-afec-38ed-16176a6c55c9@linux.alibaba.com>
Date:   Thu, 20 Jan 2022 11:13:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu/vt-d: Do not dump pasid table entries in kdump
 kernel
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1642583260-21095-1-git-send-email-zelin.deng@linux.alibaba.com>
 <846c0ff6-32b1-73a4-0510-f1e809684991@linux.intel.com>
From:   zelin deng <zelin.deng@linux.alibaba.com>
In-Reply-To: <846c0ff6-32b1-73a4-0510-f1e809684991@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/1/20 上午10:58, Lu Baolu 写道:
> On 1/19/22 5:07 PM, Zelin Deng wrote:
>> In kdump kernel PASID translations won't be copied from previous kernel
>> even if scalable-mode is enabled, so pages of PASID translations are
>
> Yes. The copy table support for scalable mode is still in my task list.
>
>> non-present in kdump kernel. Attempt to access those address will cause
>> PF fault:
>>
>> [   13.396476] DMAR: DRHD: handling fault status reg 3
>> [   13.396478] DMAR: [DMA Read NO_PASID] Request device [81:00.0] 
>> fault addr 0xffffd000 [fault reason 0x59] SM: Present bit in PA$
>> [   13.396480] DMAR: Dump dmar5 table entries for IOVA 0xffffd000
>> [   13.396481] DMAR: scalable mode root entry: hi 0x0000000000000000, 
>> low 0x00000000460d1001
>> [   13.396482] DMAR: context entry: hi 0x0000000000000008, low 
>> 0x00000010c4237401
>> [   13.396485] BUG: unable to handle page fault for address: 
>> ff110010c4237000
>> [   13.396486] #PF: supervisor read access in kernel mode
>> [   13.396487] #PF: error_code(0x0000) - not-present page
>> [   13.396488] PGD 5d201067 P4D 5d202067 PUD 0
>> [   13.396490] Oops: 0000 [#1] PREEMPT SMP NOPTI
>> [   13.396491] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
>> 5.16.0-rc6-next-20211224+ #6
>> [   13.396493] Hardware name: Intel Corporation 
>> EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.86B.0067.D12.2110190950 
>> 10/19/2021
>> [   13.396494] RIP: 0010:dmar_fault_dump_ptes+0x13b/0x295
>>
>> Hence skip dumping pasid table entries if in kdump kernel.
>
> This just asks dmar_fault_dump_ptes() to keep silent. The problem is
> that the context entry is mis-configured. Perhaps we should disable
> copy table for scalable mode for now. How about below change?

Yep.  The change looks good to me.

Actually I had encountered another issue which had blocked virtio-net 
device when scalable mode is enabled in kdump kernel so that I had made 
the same change as yours -- 'to disable translation if sm_on in kdump 
kernel' in our internal tree.

I only observe this issue on our dragonfly baremetal server with 
virtio-net device inside, I did't send the fix to upstream as I am not 
sure if it is reasonable to disable translation in kdump kernel.


>
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3337,10 +3337,11 @@ static int __init init_dmars(void)
>
>                 init_translation_status(iommu);
>
> -               if (translation_pre_enabled(iommu) && 
> !is_kdump_kernel()) {
> +               if (translation_pre_enabled(iommu) &&
> +                   (!is_kdump_kernel() || sm_supported(iommu))) {
>                         iommu_disable_translation(iommu);
>                         clear_translation_pre_enabled(iommu);
> -                       pr_warn("Translation was enabled for %s but we 
> are not in kdump mode\n",
> +                       pr_warn("Translation was enabled for %s but we 
> are not in kdump mode or copy table not supported\n",
>                                 iommu->name);
>                 }
>
>>
>> Fixes: 914ff7719e8a (“iommu/vt-d: Dump DMAR translation structure 
>> when DMA fault occurs”)
>> Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 92fea3fb..f0134cf 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1074,6 +1074,12 @@ void dmar_fault_dump_ptes(struct intel_iommu 
>> *iommu, u16 source_id,
>>       if (!sm_supported(iommu))
>>           goto pgtable_walk;
>>   +    /* PASID translations is not copied, skip dumping pasid table 
>> entries
>> +     * otherwise non-present page will be accessed.
>> +     */
>> +    if (is_kdump_kernel())
>> +        goto pgtable_walk;
>> +
>>       /* get the pointer to pasid directory entry */
>>       dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
>>       if (!dir) {
>>
>
> Best regards,
> baolu
