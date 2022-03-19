Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30F4DE542
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 03:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiCSC7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 22:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbiCSC7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 22:59:35 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 544E6DFD71
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 19:58:15 -0700 (PDT)
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxAM+9RjViz+8LAA--.33828S3;
        Sat, 19 Mar 2022 10:58:06 +0800 (CST)
Subject: Re: [PATCH v2] mm: add access/dirty bit on numa page fault
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220317065033.2635123-1-maobibo@loongson.cn>
 <fbe8f659-44dd-dd10-a3c3-acaf387abd4d@redhat.com>
 <1c54d958-9da2-97d0-e9a8-7629d4a3f7bd@loongson.cn>
 <8483f080-a23e-fe5d-88c2-4b32d8fda521@redhat.com>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <ff5391b2-be84-3192-407b-be5177612ce6@loongson.cn>
Date:   Sat, 19 Mar 2022 10:58:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8483f080-a23e-fe5d-88c2-4b32d8fda521@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9BxAM+9RjViz+8LAA--.33828S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw48ArW3ur1DGFy7GF1fXrb_yoW8Kw15pF
        Z5K3Z5KwsrXrnxtF1agw10kr1Sy3ykKFy5Wrn3ta4jy398Xrn7JrWY9FWru34Igr4ft3W5
        XF4jqa47uFsxZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
        bOoGdUUUUU=
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/18/2022 04:21 PM, David Hildenbrand wrote:
> On 18.03.22 02:17, maobibo wrote:
>>
>>
>> On 03/17/2022 08:32 PM, David Hildenbrand wrote:
>>> On 17.03.22 07:50, Bibo Mao wrote:
>>>> On platforms like x86/arm which supports hw page walking, access
>>>> and dirty bit is set by hw, however on some platforms without
>>>> such hw functions, access and dirty bit is set by software in
>>>> next trap.
>>>>
>>>> During numa page fault, dirty bit can be added for old pte if
>>>> fail to migrate on write fault. And if it succeeds to migrate,
>>>> access bit can be added for migrated new pte, also dirty bit
>>>> can be added for write fault.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>  mm/memory.c | 21 ++++++++++++++++++++-
>>>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index c125c4969913..65813bec9c06 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4404,6 +4404,22 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>>  	if (migrate_misplaced_page(page, vma, target_nid)) {
>>>>  		page_nid = target_nid;
>>>>  		flags |= TNF_MIGRATED;
>>>> +
>>>> +		/*
>>>> +		 * update pte entry with access bit, and dirty bit for
>>>> +		 * write fault
>>>> +		 */
>>>> +		spin_lock(vmf->ptl);
>>>
>>> Ehm, are you sure? We did a pte_unmap_unlock(), so you most certainly need a
>>>
>>> vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
>> yes, we need probe pte entry again after function pte_unmap_unlock().
>>>
>>>
>>> Also, don't we need pte_same() checks before we do anything after
>>> dropping the PT lock?
>> I do not think so. If page succeeds in migration, pte entry should be changed
>> also, it should be different.
>>
> 
> We have to be very careful here. Page migration succeeded, so I do
> wonder if you have to do anything on this branch *at all*. I'd assume
> that page migration too care of that already.
> 
> See, when only holding the mmap lock in read mode, there are absolutely
> no guarantees what will happen after dropping the PT lock. The page
> could get unmapped and another page could get mapped. The page could
> have been mapped R/O in the meantime.
> 
> So I'm pretty sure that unconditionally modifying the PTE here is wrong.
yes, there will be problem change pte directly, thanks for your guidance:)
it should be done on page migration flow, i will check code of page migration.

