Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D9854C09D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 06:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiFOEYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 00:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbiFOEYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:24:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C189B4B1E2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:24:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E948C1F92C;
        Wed, 15 Jun 2022 04:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655267038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcB9+iBc/9gnTVKwe/6+WsWBKGgd7gdnEFJEFa/K7B4=;
        b=Z1eAGmC+oG58yDlgF6S8/Co1OhhtLM392BErpIWFO0ofOcAEs0jp/dJJov3BXqu60gEBda
        HEbZsXvCARYBjWFdWX7iVFPIC/1y35mrWnVUdwAiCGzumKJTZdoi1U0Tk91PZfMCiZ2zea
        kcLO/oZTsFpI/gptwwqxvW1bFAcGJU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655267038;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcB9+iBc/9gnTVKwe/6+WsWBKGgd7gdnEFJEFa/K7B4=;
        b=Gl9O8q96OQwW1YOXAfi2uZrVUC+JCC4s48Ltihq5EoYQFB9ouKs7wZ3/C9msMFyjt9fthr
        bcfRY1r1lcrw9ICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FCF8139F3;
        Wed, 15 Jun 2022 04:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3K6TFN5eqWK7SgAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 15 Jun 2022 04:23:58 +0000
Date:   Wed, 15 Jun 2022 06:23:56 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw error
 happens
Message-ID: <Yqle3M18fuEJE0qn@localhost.localdomain>
References: <20220615020005.246295-1-pizhenwei@bytedance.com>
 <20220615020005.246295-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615020005.246295-2-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:00:05AM +0800, zhenwei pi wrote:
> Currently unpoison_memory(unsigned long pfn) is designed for soft
> poison(hwpoison-inject) only. Since 17fae1294ad9d, the KPTE gets
> cleared on a x86 platform once hardware memory corrupts.
> 
> Unpoisoning a hardware corrupted page puts page back buddy only,
> the kernel has a chance to access the page with *NOT PRESENT* KPTE.
> This leads BUG during accessing on the corrupted KPTE.
> 
> Suggested by David&Naoya, disable unpoison mechanism when a real HW error
> happens to avoid BUG like this:
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
...
...
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b85661cbdc4a..385b5e99bfc1 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -69,6 +69,8 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
>  
>  atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>  
> +static bool hw_memory_failure;
> +
>  static bool __page_handle_poison(struct page *page)
>  {
>  	int ret;
> @@ -1768,6 +1770,9 @@ int memory_failure(unsigned long pfn, int flags)
>  
>  	mutex_lock(&mf_mutex);
>  
> +	if (!(flags & MF_SW_SIMULATED))
> +		hw_memory_failure = true;
> +
>  	p = pfn_to_online_page(pfn);
>  	if (!p) {
>  		res = arch_memory_failure(pfn, flags);
> @@ -2103,6 +2108,13 @@ int unpoison_memory(unsigned long pfn)
>  
>  	mutex_lock(&mf_mutex);
>  
> +	if (hw_memory_failure) {
> +		unpoison_pr_info("Unpoison: Disabled after HW memory failure %#lx\n",
> +				 pfn, &unpoison_rs);
> +		ret = -EOPNOTSUPP;
> +		goto unlock_mutex;
> +	}

If we disable this, I would move this at the beginning of the function.
We do not really care whether the pfn is valid or getting the head of
the page, etc.
So, unless I'm missing something, this should be enough?

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 385b5e99bfc1..ece15f07dee7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2100,6 +2100,12 @@ int unpoison_memory(unsigned long pfn)
        static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
                                        DEFAULT_RATELIMIT_BURST);
 
+       if (hw_memory_failure) {
+                unpoison_pr_info("Unpoison: Disabled after HW memory failure\n",
+                                 &unpoison_rs);
+               ret -EOPNOTSUPP;
+        }
+
        if (!pfn_valid(pfn))
                return -ENXIO;
 

-- 
Oscar Salvador
SUSE Labs
