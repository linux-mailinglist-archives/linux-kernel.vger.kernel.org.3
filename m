Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664E44DAAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353991AbiCPHEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiCPHEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:04:49 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC3241037
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:03:34 -0700 (PDT)
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxvxPAizFiBhcKAA--.7401S3;
        Wed, 16 Mar 2022 15:03:29 +0800 (CST)
Subject: Re: [PATCH] mm: add access/dirty bit on numa page fault
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220316010836.1137084-1-maobibo@loongson.cn>
 <93302a47-9fda-25c7-4212-41b8dd027696@arm.com>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <3756661c-d710-7bf6-76ab-39ac44f8e8b3@loongson.cn>
Date:   Wed, 16 Mar 2022 15:03:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <93302a47-9fda-25c7-4212-41b8dd027696@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxvxPAizFiBhcKAA--.7401S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4rWw48Ww18JF47tr47urg_yoW8Kw43pF
        Z3Cayjqa12qr1IyanrG3Wqvr1rXa48KFy7Cr9rt3Wjkws8Zrn7Cry8u3yruaykAry8tws8
        Jr4jgFWUuan8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
        PpnJUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/16/2022 02:43 PM, Anshuman Khandual wrote:
> 
> 
> On 3/16/22 06:38, Bibo Mao wrote:
>> During numa page fault, dirty bit can be added for old pte if
>> fail to migrate on write fault. And if it succeeds to migrate,
>> access bit can be added for migrated new pte, also dirty bit
>> can be added for write fault.
> 
> The current code does not set the access and dirty bits when ever
> applicable i.e on FAULT_FLAG_WRITE, on the pte (old if migration
> fails, new if migration succeeds) ? Did not this cause any problem
> earlier ? I am wondering how this might have gone unnoticed.

On arm/x86 platform hw will set access/dirty bits automatically,
however on MIPS platform access/dirty bits are set by software in next
page fault, it is relatively easier to watch on MIPS platform.

regards
bibo,mao

> 
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

