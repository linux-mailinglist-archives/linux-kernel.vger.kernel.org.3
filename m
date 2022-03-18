Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F4A4DD258
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiCRBSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiCRBSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:18:42 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7683A29EE3D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:17:23 -0700 (PDT)
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx38+b3TNiwz8LAA--.32732S3;
        Fri, 18 Mar 2022 09:17:16 +0800 (CST)
Subject: Re: [PATCH v2] mm: add access/dirty bit on numa page fault
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220317065033.2635123-1-maobibo@loongson.cn>
 <fbe8f659-44dd-dd10-a3c3-acaf387abd4d@redhat.com>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <1c54d958-9da2-97d0-e9a8-7629d4a3f7bd@loongson.cn>
Date:   Fri, 18 Mar 2022 09:17:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fbe8f659-44dd-dd10-a3c3-acaf387abd4d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx38+b3TNiwz8LAA--.32732S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZry3GFy5WF4ftryDAry8Grg_yoW5GryxpF
        Z5C3yjqF47Xr18Jw47Ww1q9r1rXa4kKa4fCr9xta4jqrs8Zrn7WrWUW3yF9aykCr1xtw4D
        JF4jgF48ua13ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5PpnJUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/17/2022 08:32 PM, David Hildenbrand wrote:
> On 17.03.22 07:50, Bibo Mao wrote:
>> On platforms like x86/arm which supports hw page walking, access
>> and dirty bit is set by hw, however on some platforms without
>> such hw functions, access and dirty bit is set by software in
>> next trap.
>>
>> During numa page fault, dirty bit can be added for old pte if
>> fail to migrate on write fault. And if it succeeds to migrate,
>> access bit can be added for migrated new pte, also dirty bit
>> can be added for write fault.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>  mm/memory.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c125c4969913..65813bec9c06 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4404,6 +4404,22 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>  	if (migrate_misplaced_page(page, vma, target_nid)) {
>>  		page_nid = target_nid;
>>  		flags |= TNF_MIGRATED;
>> +
>> +		/*
>> +		 * update pte entry with access bit, and dirty bit for
>> +		 * write fault
>> +		 */
>> +		spin_lock(vmf->ptl);
> 
> Ehm, are you sure? We did a pte_unmap_unlock(), so you most certainly need a
> 
> vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
yes, we need probe pte entry again after function pte_unmap_unlock().
> 
> 
> Also, don't we need pte_same() checks before we do anything after
> dropping the PT lock?
I do not think so. If page succeeds in migration, pte entry should be changed
also, it should be different.

regards
bibo,mao

> 
>> +		pte = *vmf->pte;
>> +		pte = pte_mkyoung(pte);
>> +		if (was_writable) {
>> +			pte = pte_mkwrite(pte);
>> +			if (vmf->flags & FAULT_FLAG_WRITE)
>> +				pte = pte_mkdirty(pte);
>> +		}
>> +		set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>> +		update_mmu_cache(vma, vmf->address, vmf->pte);
>> +		pte_unmap_unlock(vmf->pte, vmf->ptl);
>>  	} else {
>>  		flags |= TNF_MIGRATE_FAIL;
>>  		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
>> @@ -4427,8 +4443,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>  	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
>>  	pte = pte_modify(old_pte, vma->vm_page_prot);
>>  	pte = pte_mkyoung(pte);
>> -	if (was_writable)
>> +	if (was_writable) {
>>  		pte = pte_mkwrite(pte);
>> +		if (vmf->flags & FAULT_FLAG_WRITE)
>> +			pte = pte_mkdirty(pte);
>> +	}
>>  	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
>>  	update_mmu_cache(vma, vmf->address, vmf->pte);
>>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> 
> 

