Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3951A54A31E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbiFNATv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 20:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiFNATt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:19:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7E62314D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:19:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z17so7160377pff.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LsULmdbxgYctRD3SwPgY92izi9f04navG3Xx9fUw034=;
        b=kTTqqpBuBC7A4pxbNnqiWEPSDl3f9kyDYa8GNMnEehZbDBO0bRmaKGaHufD8WZA9Zi
         g6EQhGBpsJZdnQ88WpHMnGMMlJe1nTEauX+NrgYjeR7fRbgN0ClxgQCc/wpbJ8VRjMqf
         97pXi2suDaJyD0I6k07j5eKUBVwGxKGVJ/kz6duG6q9IkWATc07iAVs82oq9GixuPDi8
         ouiSteIs9lfc1eWGv0cq/rizr7dE8/VJ9E59+U6EeRGFAk6cUf9cY/gWIChOuuJr7cYi
         eUNWKW0TryoLnTJJllzYLpOPk/1l1hHX4iMMp7F7mY0lvlpY8W4SX2jvUpQikVrT/8np
         cENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LsULmdbxgYctRD3SwPgY92izi9f04navG3Xx9fUw034=;
        b=qxxv4U8Wxa8Avt7PPXhM8v45lsEKD7EbQW6iNhXaDmOWmFJQVO2e7jV56REllIDTJS
         Eiw6Lq0tLjFXtxYx/ZDVX1zjJqjcIwpO4sA/P1FOE3gmzpMpC2NJaIVu9WUKpTMD0iWH
         MSIaL7YPUgzK8l7a9YTOMNMbpy4fYInTSg1PLy73hs08J5pWZnBs4pSMsRJeHUT9UM7J
         2wE4tQp5xfSYIvoYvcxswXDSO8hgjinoTuqcB4AdRZOmI3OrHF0AzeqjWiX89G3SGXTD
         4NSjNkFOYIvtfSiK3mle4SFkf9rD15xwHzBP/Nd2HDeR1kJJW2raJz5AH3d7ZXP7/nq+
         yvuQ==
X-Gm-Message-State: AOAM531/H4XfMt2skMrnae702kNd3O2nDmXhS7NTYiAQbSftDd0zWCu1
        4U2LFhLijQkkjGdFakOQWo+y3tbAWRO8Foo9
X-Google-Smtp-Source: ABdhPJzcQRRytmQM0a0XLSDllUPF5wHpwcQq9x65+ke/Q5OBnpWnZZ92XdsvbOeT6DJd+DEe6+q+mQ==
X-Received: by 2002:a63:b55:0:b0:3fd:a384:bd10 with SMTP id a21-20020a630b55000000b003fda384bd10mr1948575pgl.534.1655165987758;
        Mon, 13 Jun 2022 17:19:47 -0700 (PDT)
Received: from [10.4.36.16] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b00161478027f5sm5714627pla.150.2022.06.13.17.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 17:19:47 -0700 (PDT)
Message-ID: <d9bd9d4d-ec4e-1528-4348-800a8c6dc1b6@bytedance.com>
Date:   Tue, 14 Jun 2022 08:22:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Re: [PATCH v3 1/1] mm/memory-failure: don't allow to unpoison hw
 corrupted page
Content-Language: en-US
To:     naoya.horiguchi@nec.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
References: <20220610114646.162764-1-pizhenwei@bytedance.com>
 <20220610114646.162764-2-pizhenwei@bytedance.com>
 <0fedf6f3-3ab3-e1d2-fd6e-3dbe8e92f06d@redhat.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <0fedf6f3-3ab3-e1d2-fd6e-3dbe8e92f06d@redhat.com>
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



On 6/10/22 20:12, David Hildenbrand wrote:
> On 10.06.22 13:46, zhenwei pi wrote:
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
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   mm/memory-failure.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index b85661cbdc4a..3124f428302c 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2068,6 +2068,58 @@ static int __init memory_failure_init(void)
>>   }
>>   core_initcall(memory_failure_init);
>>   
>> +/*
>> + * Unpoisoning a hardware corrupted page with *NOT PRESENT* KPTE leads panic.
>> + * Test a page is valid in the kernel mapping.
>> + */
>> +static bool kmap_valid(struct page *page)
>> +{
>> +	unsigned long addr = (unsigned long)page_to_virt(page);
>> +	pgd_t *pgd;
>> +	p4d_t *p4d;
>> +	pud_t *pud;
>> +	pmd_t *pmd;
>> +	pte_t *pte;
>> +
>> +	pgd = pgd_offset_k(addr);
>> +	if (pgd_none(*pgd))
>> +		return false;
>> +	if (pgd_leaf(*pgd))
>> +		return true;
>> +	if (pgd_bad(*pgd))
>> +		return false;
>> +
>> +	p4d = p4d_offset(pgd, addr);
>> +	if (p4d_none(*p4d))
>> +		return false;
>> +	if (p4d_leaf(*p4d))
>> +		return true;
>> +	if (p4d_bad(*p4d))
>> +		return false;
>> +
>> +	pud = pud_offset(p4d, addr);
>> +	if (pud_none(*pud))
>> +		return false;
>> +	if (pud_leaf(*pud))
>> +		return true;
>> +	if (pud_bad(*pud))
>> +		return false;
>> +
>> +	pmd = pmd_offset(pud, addr);
>> +	if (pmd_none(*pmd))
>> +		return false;
>> +	if (pmd_leaf(*pmd))
>> +		return true;
>> +	if (pmd_bad(*pmd))
>> +		return false;
>> +
>> +	pte = pte_offset_map(pmd, addr);
>> +	if (pte_none(*pte) || !pte_present(*pte))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   #define unpoison_pr_info(fmt, pfn, rs)			\
>>   ({							\
>>   	if (__ratelimit(rs))				\
>> @@ -2109,6 +2161,13 @@ int unpoison_memory(unsigned long pfn)
>>   		goto unlock_mutex;
>>   	}
>>   
>> +	if (!kmap_valid(page)) {
>> +		unpoison_pr_info("Unpoison: Page was hardware poisoned %#lx\n",
>> +				 pfn, &unpoison_rs);
>> +		ret = -EOPNOTSUPP;
>> +		goto unlock_mutex;
>> +	}
>> +
>>   	if (page_count(page) > 1) {
>>   		unpoison_pr_info("Unpoison: Someone grabs the hwpoison page %#lx\n",
>>   				 pfn, &unpoison_rs);
> 
> I really prefer just disabling the unpoisioning mechanism in case there
> is a real hw injected error.
> 

Hi, Naoya & Andrew

What is your opinion?

-- 
zhenwei pi
