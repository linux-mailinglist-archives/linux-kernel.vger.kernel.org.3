Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33609546654
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348119AbiFJMMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiFJMMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AC272BD3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654863124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWrigY09pHnr8+XLazEvyTbDnwfdwYvMh735UfA4r58=;
        b=dstePhWg/UmtWW7PDPtf8xgMoEA3+ZjY4qRZ9xKGjjNoGPrXbwUirM0ze5292Urzfx84j/
        3R0R7rBx7wHYNQwHPlQmUHf6BDLbbXM7EMcvblAzPalXBgzPoCQTcrROA3SqEV27DDCXUW
        1hLzgS7uIrp9psSsJTwWazviqazHpSE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-l6ygEzYYOuy1QsmXRBM9Ow-1; Fri, 10 Jun 2022 08:12:03 -0400
X-MC-Unique: l6ygEzYYOuy1QsmXRBM9Ow-1
Received: by mail-wr1-f69.google.com with SMTP id d9-20020adfe849000000b00213375a746aso5647176wrn.18
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=yWrigY09pHnr8+XLazEvyTbDnwfdwYvMh735UfA4r58=;
        b=54VPZZh4t/vgi49uUKO1gzvl11cIWDTk1iQjPYcX3bS1deqJHydgD7D76rH3V61GZC
         aF9dadZvLtxhdPScKC7cMbsQ478PcbHYG2JyuwApLLoRqONsD0xkXZAS+QUW1WA905PW
         8ZMN1yTH3B/G0ujElNfcijMYsFX1QHQoVdnSydaOJ9+FvpA0GsPkDi5tlpLTOwOuOJsl
         pqxwvtEV+ztXiZIl++gqJ3waN9l+wE4tcfkRWPscTiNyZgGU8xS3tiSGynaa6PJuh0ux
         U6Kl9h5o4k4m4mt8gUwboUmabnIATq+9l8ofO4y0nhMGjQZ+WMC31jrGsyrnGe3vuXRG
         FVYg==
X-Gm-Message-State: AOAM531XW7bcD2QjxmMqNoxWtDswG1oBDyT613bRxMaKb9JcfjuoYKY6
        ktveAl/1O5bvGhAbuFzaY99+ER2b7UoipdMUwBrzrlAL6DllgmAzTm2tQV3XCtw8iOTh4OIi82m
        Wx8rVThvI6j7fVzQs30AZeHzN
X-Received: by 2002:a7b:cd84:0:b0:39c:3620:301c with SMTP id y4-20020a7bcd84000000b0039c3620301cmr8405627wmj.19.1654863122006;
        Fri, 10 Jun 2022 05:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOr/86mQOSFaOz3pOKMn7+gQcZZ5ScjmAh7eAzs9lKMvSkvQJwRcXOUVw1VS9TbsQ6HrMjyA==
X-Received: by 2002:a7b:cd84:0:b0:39c:3620:301c with SMTP id y4-20020a7bcd84000000b0039c3620301cmr8405600wmj.19.1654863121687;
        Fri, 10 Jun 2022 05:12:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1f00:4727:6420:1d4d:ca23? (p200300cbc7051f00472764201d4dca23.dip0.t-ipconnect.de. [2003:cb:c705:1f00:4727:6420:1d4d:ca23])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4643000000b002103a7c5c91sm26337436wrs.43.2022.06.10.05.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 05:12:01 -0700 (PDT)
Message-ID: <0fedf6f3-3ab3-e1d2-fd6e-3dbe8e92f06d@redhat.com>
Date:   Fri, 10 Jun 2022 14:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/1] mm/memory-failure: don't allow to unpoison hw
 corrupted page
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220610114646.162764-1-pizhenwei@bytedance.com>
 <20220610114646.162764-2-pizhenwei@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220610114646.162764-2-pizhenwei@bytedance.com>
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

On 10.06.22 13:46, zhenwei pi wrote:
> Currently unpoison_memory(unsigned long pfn) is designed for soft
> poison(hwpoison-inject) only. Since 17fae1294ad9d, the KPTE gets
> cleared on a x86 platform once hardware memory corrupts.
> 
> Unpoisoning a hardware corrupted page puts page back buddy only,
> the kernel has a chance to access the page with *NOT PRESENT* KPTE.
> This leads BUG during accessing on the corrupted KPTE.
> 
> Do not allow to unpoison hardware corrupted page in unpoison_memory() to
> avoid BUG like this:
> 
>  Unpoison: Software-unpoisoned page 0x61234
>  BUG: unable to handle page fault for address: ffff888061234000
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 2c01067 P4D 2c01067 PUD 107267063 PMD 10382b063 PTE 800fffff9edcb062
>  Oops: 0002 [#1] PREEMPT SMP NOPTI
>  CPU: 4 PID: 26551 Comm: stress Kdump: loaded Tainted: G   M       OE     5.18.0.bm.1-amd64 #7
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ...
>  RIP: 0010:clear_page_erms+0x7/0x10
>  Code: ...
>  RSP: 0000:ffffc90001107bc8 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000000901 RCX: 0000000000001000
>  RDX: ffffea0001848d00 RSI: ffffea0001848d40 RDI: ffff888061234000
>  RBP: ffffea0001848d00 R08: 0000000000000901 R09: 0000000000001276
>  R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000001
>  R13: 0000000000000000 R14: 0000000000140dca R15: 0000000000000001
>  FS:  00007fd8b2333740(0000) GS:ffff88813fd00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffff888061234000 CR3: 00000001023d2005 CR4: 0000000000770ee0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   prep_new_page+0x151/0x170
>   get_page_from_freelist+0xca0/0xe20
>   ? sysvec_apic_timer_interrupt+0xab/0xc0
>   ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
>   __alloc_pages+0x17e/0x340
>   __folio_alloc+0x17/0x40
>   vma_alloc_folio+0x84/0x280
>   __handle_mm_fault+0x8d4/0xeb0
>   handle_mm_fault+0xd5/0x2a0
>   do_user_addr_fault+0x1d0/0x680
>   ? kvm_read_and_reset_apf_flags+0x3b/0x50
>   exc_page_fault+0x78/0x170
>   asm_exc_page_fault+0x27/0x30
> 
> Fixes: 847ce401df392 ("HWPOISON: Add unpoisoning support")
> Fixes: 17fae1294ad9d ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  mm/memory-failure.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b85661cbdc4a..3124f428302c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2068,6 +2068,58 @@ static int __init memory_failure_init(void)
>  }
>  core_initcall(memory_failure_init);
>  
> +/*
> + * Unpoisoning a hardware corrupted page with *NOT PRESENT* KPTE leads panic.
> + * Test a page is valid in the kernel mapping.
> + */
> +static bool kmap_valid(struct page *page)
> +{
> +	unsigned long addr = (unsigned long)page_to_virt(page);
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	pgd = pgd_offset_k(addr);
> +	if (pgd_none(*pgd))
> +		return false;
> +	if (pgd_leaf(*pgd))
> +		return true;
> +	if (pgd_bad(*pgd))
> +		return false;
> +
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d))
> +		return false;
> +	if (p4d_leaf(*p4d))
> +		return true;
> +	if (p4d_bad(*p4d))
> +		return false;
> +
> +	pud = pud_offset(p4d, addr);
> +	if (pud_none(*pud))
> +		return false;
> +	if (pud_leaf(*pud))
> +		return true;
> +	if (pud_bad(*pud))
> +		return false;
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (pmd_none(*pmd))
> +		return false;
> +	if (pmd_leaf(*pmd))
> +		return true;
> +	if (pmd_bad(*pmd))
> +		return false;
> +
> +	pte = pte_offset_map(pmd, addr);
> +	if (pte_none(*pte) || !pte_present(*pte))
> +		return false;
> +
> +	return true;
> +}
> +
>  #define unpoison_pr_info(fmt, pfn, rs)			\
>  ({							\
>  	if (__ratelimit(rs))				\
> @@ -2109,6 +2161,13 @@ int unpoison_memory(unsigned long pfn)
>  		goto unlock_mutex;
>  	}
>  
> +	if (!kmap_valid(page)) {
> +		unpoison_pr_info("Unpoison: Page was hardware poisoned %#lx\n",
> +				 pfn, &unpoison_rs);
> +		ret = -EOPNOTSUPP;
> +		goto unlock_mutex;
> +	}
> +
>  	if (page_count(page) > 1) {
>  		unpoison_pr_info("Unpoison: Someone grabs the hwpoison page %#lx\n",
>  				 pfn, &unpoison_rs);

I really prefer just disabling the unpoisioning mechanism in case there
is a real hw injected error.

-- 
Thanks,

David / dhildenb

