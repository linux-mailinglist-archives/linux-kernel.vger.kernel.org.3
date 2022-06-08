Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334B7542C3C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiFHJ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiFHJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6493011B6BA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654680625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4mwQ2Ob5idWmk+vvtGsJutcDHuQ3WjU/+4QDpMeLxys=;
        b=fuT/VS1GcsrrnevBl4gTqWf+8iQJ1kLX8GlXePgtfvemoio5gO31P6Y94e8+xZbJs4krPR
        OSD0S2LbkFUb1aMKcUKaWh75Io1AY+6Tw0JkatR1Xj3jY2HyGVt6dhoUtpCDP04MPDW8UL
        YJdZqfbQbxaLzmKtScQZJPNaXxbB+x4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-exo_lZnSPde2MtNqjWohBg-1; Wed, 08 Jun 2022 05:30:21 -0400
X-MC-Unique: exo_lZnSPde2MtNqjWohBg-1
Received: by mail-wr1-f70.google.com with SMTP id h14-20020adfa4ce000000b00218518b622eso1301595wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4mwQ2Ob5idWmk+vvtGsJutcDHuQ3WjU/+4QDpMeLxys=;
        b=IDNiqUPQe1DEspNr9hImTVXhBvnkc19fuip9w8GcaluCjLho1RkInZ8Jo1WBqyzoNx
         8QVfB57U3V7KItwKcE22FZckbUPGnnxhBaZe6NCkYdsErLEXmqGD2GhufDjp4nrLA8mX
         uRBxlpDcPIrIqN0eqoYU5ZdbxcVo9cEB15iC7sTAK02T2VwOjqSbgwHyCMgheSxKxuDS
         r4DbaBzI2SGm+d/NrgINf/1U0lYRv4vaosOy+Cy4PLWsJadfjFB14LPWSLVnwjK5Q9Dk
         hlslxUjOQs7cTiA8S1+3KvArzFcdB5Hti0WwfnKADsuFby9Tvyo2k99nVh1Gqok8fs0n
         uwXw==
X-Gm-Message-State: AOAM530IARwVzNc8bnYMHO9tizZC+e7pxZq1JoxqMd5pJNp82h94bp/l
        YwXAl/gI+pyzER3thnZDCAnTdkRJT+U81U0r6k3uGEean5IgO0jYxqOoZ27qBp3/zS6cnQQNqHy
        akC05dLb7lKeskg1VhAa5AnyK
X-Received: by 2002:a5d:4fca:0:b0:210:34bd:be76 with SMTP id h10-20020a5d4fca000000b0021034bdbe76mr31877861wrw.93.1654680620542;
        Wed, 08 Jun 2022 02:30:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzh9pHQGJ+Q62PWsAXv9/CIDOGieywVAB5A+Z8Sy+C+P6dm624RlBQF5pJ6w++8hjiYKe6kg==
X-Received: by 2002:a5d:4fca:0:b0:210:34bd:be76 with SMTP id h10-20020a5d4fca000000b0021034bdbe76mr31877829wrw.93.1654680620215;
        Wed, 08 Jun 2022 02:30:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ad00:db2:4c6:8f3a:2ec4? (p200300cbc705ad000db204c68f3a2ec4.dip0.t-ipconnect.de. [2003:cb:c705:ad00:db2:4c6:8f3a:2ec4])
        by smtp.gmail.com with ESMTPSA id r8-20020adfdc88000000b0021576694d9dsm13885927wrj.97.2022.06.08.02.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:30:19 -0700 (PDT)
Message-ID: <260b719b-9138-9615-fae4-b5b4c86674a2@redhat.com>
Date:   Wed, 8 Jun 2022 11:30:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/1] mm/memory-failure: don't allow to unpoison hw
 corrupted page
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220608084356.40894-1-pizhenwei@bytedance.com>
 <20220608084356.40894-2-pizhenwei@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220608084356.40894-2-pizhenwei@bytedance.com>
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

On 08.06.22 10:43, zhenwei pi wrote:
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
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  mm/memory-failure.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b85661cbdc4a..da99a2b7ef35 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2090,6 +2090,7 @@ int unpoison_memory(unsigned long pfn)
>  {
>  	struct page *page;
>  	struct page *p;
> +	pte_t *kpte;
>  	int ret = -EBUSY;
>  	int freeit = 0;
>  	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
> @@ -2103,6 +2104,14 @@ int unpoison_memory(unsigned long pfn)
>  
>  	mutex_lock(&mf_mutex);
>  
> +	kpte = virt_to_kpte((unsigned long)page_to_virt(p));
> 
I'm curious whether virt_to_kpte is sane to use, especially, when having
the direct map map PMDs and not PTEs?

virt_to_kpte() only checks for pmd_none() -- but what if we have
pmd_large()?

Naive me would assume that calling virt_to_kpte() from generic code is
broken. Only mm/highmem.c uses it, however, 32bit most probably also
doesn't have large mappings in the page tables for the direct map.

-- 
Thanks,

David / dhildenb

