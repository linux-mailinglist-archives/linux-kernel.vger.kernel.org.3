Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B059153FDE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243169AbiFGLuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243139AbiFGLur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:50:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2BB1C04
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:50:45 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LHTD51PDBzjXQ1;
        Tue,  7 Jun 2022 19:49:25 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 19:50:43 +0800
Subject: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw corrupted
 page
To:     zhenwei pi <pizhenwei@bytedance.com>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220604103229.3378591-1-pizhenwei@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b7b64c37-5326-de61-8c8e-efba38f9b207@huawei.com>
Date:   Tue, 7 Jun 2022 19:50:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220604103229.3378591-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/4 18:32, zhenwei pi wrote:
> Currently unpoison_memory(unsigned long pfn) is designed for soft
> poison(hwpoison-inject) only. Unpoisoning a hardware corrupted page
> puts page back buddy only, this leads BUG during accessing on the
> corrupted KPTE.
> 
> Do not allow to unpoison hardware corrupted page in unpoison_memory()
> to avoid BUG like this:
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

Thanks for fixing this issue.

> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  mm/memory-failure.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b85661cbdc4a..ec49571924f4 100644
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
> @@ -2101,6 +2102,13 @@ int unpoison_memory(unsigned long pfn)
>  	p = pfn_to_page(pfn);
>  	page = compound_head(p);
>  
> +	kpte = virt_to_kpte((unsigned long)page_to_virt(p));
> +	if (kpte && !pte_present(*kpte)) {

It seems this bug is specified to x86? IIUC, not all arch will unmap the entire page if the
whole page is affected and poisoned. So the above virt_to_kpte + !pte_present check could not
detect the hardware corrupted page reliably, i.e. if page is not *whole* unmapped, e.g. *possible*
hugetlb page, we will still unpoison a hardware corrupted page. Or am I miss something?

> +		unpoison_pr_info("Unpoison: Page was hardware poisoned %#lx\n",
> +				 pfn, &unpoison_rs);
> +		return -EPERM;
> +	}
> +

I think -EOPNOTSUPP might be a better error code too as Naoya pointed out.

>  	mutex_lock(&mf_mutex);
>  
>  	if (!PageHWPoison(p)) {
> 

Thanks!
