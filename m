Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9F545B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbiFJFLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243681AbiFJFLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:11:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071091A8E24
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 22:11:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso2949830pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 22:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gfr/1kB0hdJjKyLwAxEyqorGcwTLrSTUH/OalMcJ5Nk=;
        b=Eu3F124dxBPMBafNivYPu+51kqUxXADZrfA4Azv3kumBeKcO3YpTN9z0/hHXIQJwEO
         kfyDJ/8hCRFtD6/w6oa7ptxQI94anmPI3rDm22uWr6+qCSZj+66aXGnVDgLww2Fx1qmh
         F2vmTEYlmi5LIjuxkcC0NVJ38O0IUDd0Ye2pDL6/ntUCdq+rdATesO1qMlz/BuqXDkMO
         ieD8r6KmRP3uBCYPDWUZQl+rkHQBeMoOTCpXhZPddIng3C1ZOAfqkSPeNIldvZhJUemv
         gtKQLwYWwE0AOxshPVEEdFr1OZu11p8b76bLor/i6kTYVVNf4oEo0Y+yMLI0ucNFfDtX
         jE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gfr/1kB0hdJjKyLwAxEyqorGcwTLrSTUH/OalMcJ5Nk=;
        b=ieJdcal50twNSTf0BHgxzuegeo00LBdhJCebxlJ3tx0iGbJDt3km6qkVHKarqcBPnB
         7vWV3CyZ3OpbNJejc7t1ZhOHOZiOpTygI60v23QhrRh00JhzIaYnrNzAR1J4zs0ZE4za
         RMCw8waYT1kaca4EC+Ffa1EV/Qev0Qr7Y3CtROkDk1NHwnuk7Ei67bUIezEhNpY0pCFd
         q0osqS9UcYZd9XTLOxz5SZgUVLqPWdgKD0sc0PlF9P66jiTDAi+h3IBpu3hVEi4InzEF
         PgOndCGt+ySt0s8a5y7LgYAzNsvF47s35aF17ilZEiFM//UeWcAsst64qPZrwG6Spe0P
         STAw==
X-Gm-Message-State: AOAM531itorWsk23gdiHOlvrJ/I1vqRQUfwFRVN/qcgVUSVcbrYK+lwt
        dO5e81uLc7EnwgC8k+sUmpaT4w==
X-Google-Smtp-Source: ABdhPJzUrPlzUEP5qqpUR+IaLhP5px5eXoEW1R8Ms4hw6FMnga1ln1qj+QxVXYBv7fSn2RASmaIcTw==
X-Received: by 2002:a17:90b:3ec9:b0:1e8:6ab9:a47 with SMTP id rm9-20020a17090b3ec900b001e86ab90a47mr7049138pjb.60.1654837863362;
        Thu, 09 Jun 2022 22:11:03 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id e24-20020a62ee18000000b0051b9ac5a377sm18207404pfi.213.2022.06.09.22.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 22:11:02 -0700 (PDT)
Message-ID: <66cc45e6-0947-d991-af81-d56eb708f5b0@bytedance.com>
Date:   Fri, 10 Jun 2022 13:06:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Re: [PATCH v2 1/1] mm/memory-failure: don't allow to unpoison hw
 corrupted page
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220608084356.40894-1-pizhenwei@bytedance.com>
 <20220608084356.40894-2-pizhenwei@bytedance.com>
 <260b719b-9138-9615-fae4-b5b4c86674a2@redhat.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <260b719b-9138-9615-fae4-b5b4c86674a2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/22 17:30, David Hildenbrand wrote:
> On 08.06.22 10:43, zhenwei pi wrote:
>> Currently unpoison_memory(unsigned long pfn) is designed for soft
>> poison(hwpoison-inject) only. Since 17fae1294ad9d, the KPTE gets
>> cleared on a x86 platform once hardware memory corrupts.
>>
>> Unpoisoning a hardware corrupted page puts page back buddy only,
>> the kernel has a chance to access the page with *NOT PRESENT* KPTE.
>> This leads BUG during accessing on the corrupted KPTE.
>>
>> Do not allow to unpoison hardware corrupted page in unpoison_memory() to
>> avoid BUG like this:
>>
>>   Unpoison: Software-unpoisoned page 0x61234
>>   BUG: unable to handle page fault for address: ffff888061234000
>>   #PF: supervisor write access in kernel mode
>>   #PF: error_code(0x0002) - not-present page
>>   PGD 2c01067 P4D 2c01067 PUD 107267063 PMD 10382b063 PTE 800fffff9edcb062
>>   Oops: 0002 [#1] PREEMPT SMP NOPTI
>>   CPU: 4 PID: 26551 Comm: stress Kdump: loaded Tainted: G   M       OE     5.18.0.bm.1-amd64 #7
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ...
>>   RIP: 0010:clear_page_erms+0x7/0x10
>>   Code: ...
>>   RSP: 0000:ffffc90001107bc8 EFLAGS: 00010246
>>   RAX: 0000000000000000 RBX: 0000000000000901 RCX: 0000000000001000
>>   RDX: ffffea0001848d00 RSI: ffffea0001848d40 RDI: ffff888061234000
>>   RBP: ffffea0001848d00 R08: 0000000000000901 R09: 0000000000001276
>>   R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000001
>>   R13: 0000000000000000 R14: 0000000000140dca R15: 0000000000000001
>>   FS:  00007fd8b2333740(0000) GS:ffff88813fd00000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: ffff888061234000 CR3: 00000001023d2005 CR4: 0000000000770ee0
>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   PKRU: 55555554
>>   Call Trace:
>>    <TASK>
>>    prep_new_page+0x151/0x170
>>    get_page_from_freelist+0xca0/0xe20
>>    ? sysvec_apic_timer_interrupt+0xab/0xc0
>>    ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
>>    __alloc_pages+0x17e/0x340
>>    __folio_alloc+0x17/0x40
>>    vma_alloc_folio+0x84/0x280
>>    __handle_mm_fault+0x8d4/0xeb0
>>    handle_mm_fault+0xd5/0x2a0
>>    do_user_addr_fault+0x1d0/0x680
>>    ? kvm_read_and_reset_apf_flags+0x3b/0x50
>>    exc_page_fault+0x78/0x170
>>    asm_exc_page_fault+0x27/0x30
>>
>> Fixes: 847ce401df392 ("HWPOISON: Add unpoisoning support")
>> Fixes: 17fae1294ad9d ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")
>> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   mm/memory-failure.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index b85661cbdc4a..da99a2b7ef35 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2090,6 +2090,7 @@ int unpoison_memory(unsigned long pfn)
>>   {
>>   	struct page *page;
>>   	struct page *p;
>> +	pte_t *kpte;
>>   	int ret = -EBUSY;
>>   	int freeit = 0;
>>   	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
>> @@ -2103,6 +2104,14 @@ int unpoison_memory(unsigned long pfn)
>>   
>>   	mutex_lock(&mf_mutex);
>>   
>> +	kpte = virt_to_kpte((unsigned long)page_to_virt(p));
>>
> I'm curious whether virt_to_kpte is sane to use, especially, when having
> the direct map map PMDs and not PTEs?
> 
> virt_to_kpte() only checks for pmd_none() -- but what if we have
> pmd_large()?
> 
> Naive me would assume that calling virt_to_kpte() from generic code is
> broken. Only mm/highmem.c uses it, however, 32bit most probably also
> doesn't have large mappings in the page tables for the direct map.
> 

Hi,

I dived into this part and noticed that both pmd_off_k() and 
virt_to_kpte() are broken.

For example, on a x86 platform, if the CPU has feature 'pdpe1gb', the 
kernel prefers 1G map. (cat /proc/meminfo | grep DirectMap to show the 
current mapping)

static inline pmd_t *pmd_off_k(unsigned long va)
{
         return pmd_offset(pud_offset(p4d_offset(pgd_offset_k(va), va), 
va), va);
}

There is no pud_none() & pud_large()(of cause, we can't use pud_large() 
here) to test *PUD* valid or not.

So I'm going to do:
- in pmd_off_k(), use pud_none() and pud_bad() to test *PUD*, if failed, 
BUG().
- in virt_to_kpte(), use pmd_none() & pmd_bad() to test *PMD*, if 
failed, BUG().
- rework KPTE test in unpoison_memory(), walk page table instead of 
useing virt_to_kpte().

Do you have any suggestions?

-- 
zhenwei pi
