Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A1B546098
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbiFJI5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbiFJI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF5E6712C9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654851453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTWibueTmngdj/xrifw+G1kLc6wzYjVJd13reaabSIc=;
        b=c0nsF2m6gmHxFRcY614V9AJaFWykyp/kjXKYHNGl4AySlIsWUVsHasCrm/gMoe2PWlAoM8
        5NOMbJDLpKzl8nbZz820HHS0qHTFR/IMIWon1X7JcHq8MR2J+Ho7ad60Qn24szNHBNc5/e
        qH4iqjry/FPzeiVzfyZIvAKv67F5hrM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-FXKqg3aBOV6_qZaXGpUXpg-1; Fri, 10 Jun 2022 04:57:32 -0400
X-MC-Unique: FXKqg3aBOV6_qZaXGpUXpg-1
Received: by mail-wm1-f72.google.com with SMTP id u12-20020a05600c19cc00b0038ec265155fso1008647wmq.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=xTWibueTmngdj/xrifw+G1kLc6wzYjVJd13reaabSIc=;
        b=lv3ra4T5dNmycXBvNylBWnR17gc5jYYwGQHMZ7v5yuc37IcOzrfmd7ybZFpXCnpVw4
         rmD/O9EsgDW1jU3NwN/t/Q4319Qk5W9vAQr7T3LOXgBAc7j9FNLvvJf8u8NbDOS6ct02
         DapyfmB2fWK75jMDuWNdx6hPzcgIbK4yte5ptb9scPeb2xEE1CxSkWzr7ebAWgzO0lOT
         lC5IG2umHOrz25uQfssFbRAuqILdkM0LBkf4uoTncWxqDpOXkyQoEPTZ1lVsD6ieDgtc
         GGD4/VwceTgmduGd+IrFX/LZnVvsut4cQe9lPvKgutnkTMaOnlWIFxBhjX/1JJjmtu9P
         9QwQ==
X-Gm-Message-State: AOAM533+wjP7eYns7Y4hL5iXqA5/wGrAqxJdDrixHG/rn8LFLOW0VOjN
        4Lmcqx/bDEOzHvf1l7w/8ZE1LAI9MJ+eF9V3Au3Ip7a5j53g7P/eGIeNWXt9xN3nUvZuy+GivnO
        qJ28TspVV/JuDYXYbzqWrHvGH
X-Received: by 2002:a05:600c:1ca0:b0:39c:4dbd:e9ed with SMTP id k32-20020a05600c1ca000b0039c4dbde9edmr7659430wms.40.1654851451381;
        Fri, 10 Jun 2022 01:57:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9gPwJbMWqqdj9HjxvxEPPxNvmExqSzJ0nBlmICif9ZArE+TzhG8FV2J0O8kN951M8VxsgLA==
X-Received: by 2002:a05:600c:1ca0:b0:39c:4dbd:e9ed with SMTP id k32-20020a05600c1ca000b0039c4dbde9edmr7659416wms.40.1654851451049;
        Fri, 10 Jun 2022 01:57:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1f00:4727:6420:1d4d:ca23? (p200300cbc7051f00472764201d4dca23.dip0.t-ipconnect.de. [2003:cb:c705:1f00:4727:6420:1d4d:ca23])
        by smtp.gmail.com with ESMTPSA id z5-20020a7bc145000000b0039763d41a48sm2153407wmi.25.2022.06.10.01.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 01:57:30 -0700 (PDT)
Message-ID: <d7927214-e433-c26d-7a9c-a291ced81887@redhat.com>
Date:   Fri, 10 Jun 2022 10:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220608084356.40894-1-pizhenwei@bytedance.com>
 <20220608084356.40894-2-pizhenwei@bytedance.com>
 <260b719b-9138-9615-fae4-b5b4c86674a2@redhat.com>
 <66cc45e6-0947-d991-af81-d56eb708f5b0@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/1] mm/memory-failure: don't allow to unpoison hw
 corrupted page
In-Reply-To: <66cc45e6-0947-d991-af81-d56eb708f5b0@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.06.22 07:06, zhenwei pi wrote:
> 
> 
> On 6/8/22 17:30, David Hildenbrand wrote:
>> On 08.06.22 10:43, zhenwei pi wrote:
>>> Currently unpoison_memory(unsigned long pfn) is designed for soft
>>> poison(hwpoison-inject) only. Since 17fae1294ad9d, the KPTE gets
>>> cleared on a x86 platform once hardware memory corrupts.
>>>
>>> Unpoisoning a hardware corrupted page puts page back buddy only,
>>> the kernel has a chance to access the page with *NOT PRESENT* KPTE.
>>> This leads BUG during accessing on the corrupted KPTE.
>>>
>>> Do not allow to unpoison hardware corrupted page in unpoison_memory() to
>>> avoid BUG like this:
>>>
>>>   Unpoison: Software-unpoisoned page 0x61234
>>>   BUG: unable to handle page fault for address: ffff888061234000
>>>   #PF: supervisor write access in kernel mode
>>>   #PF: error_code(0x0002) - not-present page
>>>   PGD 2c01067 P4D 2c01067 PUD 107267063 PMD 10382b063 PTE 800fffff9edcb062
>>>   Oops: 0002 [#1] PREEMPT SMP NOPTI
>>>   CPU: 4 PID: 26551 Comm: stress Kdump: loaded Tainted: G   M       OE     5.18.0.bm.1-amd64 #7
>>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ...
>>>   RIP: 0010:clear_page_erms+0x7/0x10
>>>   Code: ...
>>>   RSP: 0000:ffffc90001107bc8 EFLAGS: 00010246
>>>   RAX: 0000000000000000 RBX: 0000000000000901 RCX: 0000000000001000
>>>   RDX: ffffea0001848d00 RSI: ffffea0001848d40 RDI: ffff888061234000
>>>   RBP: ffffea0001848d00 R08: 0000000000000901 R09: 0000000000001276
>>>   R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000001
>>>   R13: 0000000000000000 R14: 0000000000140dca R15: 0000000000000001
>>>   FS:  00007fd8b2333740(0000) GS:ffff88813fd00000(0000) knlGS:0000000000000000
>>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>   CR2: ffff888061234000 CR3: 00000001023d2005 CR4: 0000000000770ee0
>>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>   PKRU: 55555554
>>>   Call Trace:
>>>    <TASK>
>>>    prep_new_page+0x151/0x170
>>>    get_page_from_freelist+0xca0/0xe20
>>>    ? sysvec_apic_timer_interrupt+0xab/0xc0
>>>    ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
>>>    __alloc_pages+0x17e/0x340
>>>    __folio_alloc+0x17/0x40
>>>    vma_alloc_folio+0x84/0x280
>>>    __handle_mm_fault+0x8d4/0xeb0
>>>    handle_mm_fault+0xd5/0x2a0
>>>    do_user_addr_fault+0x1d0/0x680
>>>    ? kvm_read_and_reset_apf_flags+0x3b/0x50
>>>    exc_page_fault+0x78/0x170
>>>    asm_exc_page_fault+0x27/0x30
>>>
>>> Fixes: 847ce401df392 ("HWPOISON: Add unpoisoning support")
>>> Fixes: 17fae1294ad9d ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")
>>> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>> ---
>>>   mm/memory-failure.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index b85661cbdc4a..da99a2b7ef35 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -2090,6 +2090,7 @@ int unpoison_memory(unsigned long pfn)
>>>   {
>>>   	struct page *page;
>>>   	struct page *p;
>>> +	pte_t *kpte;
>>>   	int ret = -EBUSY;
>>>   	int freeit = 0;
>>>   	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
>>> @@ -2103,6 +2104,14 @@ int unpoison_memory(unsigned long pfn)
>>>   
>>>   	mutex_lock(&mf_mutex);
>>>   
>>> +	kpte = virt_to_kpte((unsigned long)page_to_virt(p));
>>>
>> I'm curious whether virt_to_kpte is sane to use, especially, when having
>> the direct map map PMDs and not PTEs?
>>
>> virt_to_kpte() only checks for pmd_none() -- but what if we have
>> pmd_large()?
>>
>> Naive me would assume that calling virt_to_kpte() from generic code is
>> broken. Only mm/highmem.c uses it, however, 32bit most probably also
>> doesn't have large mappings in the page tables for the direct map.
>>
> 
> Hi,
> 
> I dived into this part and noticed that both pmd_off_k() and 
> virt_to_kpte() are broken.
> 
> For example, on a x86 platform, if the CPU has feature 'pdpe1gb', the 
> kernel prefers 1G map. (cat /proc/meminfo | grep DirectMap to show the 
> current mapping)
> 
> static inline pmd_t *pmd_off_k(unsigned long va)
> {
>          return pmd_offset(pud_offset(p4d_offset(pgd_offset_k(va), va), 
> va), va);
> }
> 
> There is no pud_none() & pud_large()(of cause, we can't use pud_large() 
> here) to test *PUD* valid or not.
> 
> So I'm going to do:
> - in pmd_off_k(), use pud_none() and pud_bad() to test *PUD*, if failed, 
> BUG().
> - in virt_to_kpte(), use pmd_none() & pmd_bad() to test *PMD*, if 
> failed, BUG().
> - rework KPTE test in unpoison_memory(), walk page table instead of 
> useing virt_to_kpte().
> 
> Do you have any suggestions?
> 

TBH, I am not convinced that this is worth the trouble.


You have to win the lottery and get a MCE use a pure debugging interface
to clear a hwpoisoned page that was not previously poisoned via that
debugging interface. There are easier ways to crash the kernel if one is
explicitly looking for trouble on a debug kernel.


Further, this looks very x86 specific to me. The whole detection is
unreliable if the arch doesn't do this unmapping, and neither your patch
subject nor the new error message holds reliably.

Even further, what if the hw error triggered memory_failure() which set
SetPageHWPoison(), but that failed? We won't be unmapping anything,
still, you'd be able to clear that because it could look like a software
poisoned page, no?

Last but not least: what if some other arch requires yet some other
handling for hw poisoned pages that we are not covering here?


Instead of seeing more widespread use of virt_to_kpte() and friends I'd
much rather see all of that "generic" only-works-on-random-32bit-arch
stuff removed.


I am not even sure if we even *need* that unpoisoning complexity just
for some debugging/testing activity.

847ce401df39 ("HWPOISON: Add unpoisoning support") mentions: "The
unpoisoning interface is useful for stress testing tools to reclaim
poisoned pages (to prevent OOM)". Why can't these tools simply reboot
once we reach a certain #hwpoisoned pages? It's certainly a lot easier
then having kernel support for something that cannot happen in "real"
environments.


So if anything, I'd vote for removing that interface+complexity, or
alternatively *disabling* it once we have a hw triggered poisoning.

-- 
Thanks,

David / dhildenb

