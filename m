Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C344DD235
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiCRBDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiCRBC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:02:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 972B72571B9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:01:40 -0700 (PDT)
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxwM7t2TNiWz4LAA--.32529S3;
        Fri, 18 Mar 2022 09:01:33 +0800 (CST)
Subject: Re: [PATCH v2] mm: add access/dirty bit on numa page fault
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220317065033.2635123-1-maobibo@loongson.cn>
 <YjMoMVWXoJH9cmuf@casper.infradead.org>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <b373ce7e-d55a-03cf-abca-0863865cbd9c@loongson.cn>
Date:   Fri, 18 Mar 2022 09:01:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YjMoMVWXoJH9cmuf@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9BxwM7t2TNiWz4LAA--.32529S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr15uFyDZr13trWrZw4fXwb_yoW5JF47pF
        Z5CayYqFsrXr18AwsrGw1qyr1rXa48KFy3Cr9rta4Utws8urn7uryUW3yF9aykCry8tw4D
        Jr4UWFWUua90q3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x07bOoGdUUUUU=
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/17/2022 08:23 PM, Matthew Wilcox wrote:
> On Thu, Mar 17, 2022 at 02:50:33AM -0400, Bibo Mao wrote:
>> On platforms like x86/arm which supports hw page walking, access
>> and dirty bit is set by hw, however on some platforms without
>> such hw functions, access and dirty bit is set by software in
>> next trap.
>>
>> During numa page fault, dirty bit can be added for old pte if
>> fail to migrate on write fault. And if it succeeds to migrate,
>> access bit can be added for migrated new pte, also dirty bit
>> can be added for write fault.
> 
> Is this a correctness problem, in which case this will need to be
> backported, or is this a performance problem, in which case can you
> share some numbers?
It is only performance issue, and there is no obvious performance
improvement for general workloads on my hand, but I do not test
it on microbenchmark.

> 
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
>> -- 
>> 2.31.1
>>
>>

