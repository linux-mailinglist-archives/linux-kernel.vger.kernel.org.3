Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD12954DCEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiFPIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiFPIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:30:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532075DA3A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:30:46 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LNwN82MwNzDqqF;
        Thu, 16 Jun 2022 16:30:16 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 16:30:42 +0800
Subject: Re: [PATCH v6 1/1] mm/memory-failure: disable unpoison once hw error
 happens
To:     zhenwei pi <pizhenwei@bytedance.com>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220615093209.259374-1-pizhenwei@bytedance.com>
 <20220615093209.259374-2-pizhenwei@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <61092273-ea3f-449a-8993-a917837e1cf0@huawei.com>
Date:   Thu, 16 Jun 2022 16:30:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220615093209.259374-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/15 17:32, zhenwei pi wrote:
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
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  Documentation/vm/hwpoison.rst |  3 ++-
>  drivers/base/memory.c         |  2 +-
>  include/linux/mm.h            |  1 +
>  mm/hwpoison-inject.c          |  2 +-
>  mm/madvise.c                  |  2 +-
>  mm/memory-failure.c           | 12 ++++++++++++
>  6 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
> index c742de1769d1..b9d5253c1305 100644
> --- a/Documentation/vm/hwpoison.rst
> +++ b/Documentation/vm/hwpoison.rst
> @@ -120,7 +120,8 @@ Testing
>    unpoison-pfn
>  	Software-unpoison page at PFN echoed into this file. This way
>  	a page can be reused again.  This only works for Linux
> -	injected failures, not for real memory failures.
> +	injected failures, not for real memory failures. Once any hardware
> +	memory failure happens, this feature is disabled.
>  
>    Note these injection interfaces are not stable and might change between
>    kernel versions
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 084d67fd55cc..bc60c9cd3230 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -558,7 +558,7 @@ static ssize_t hard_offline_page_store(struct device *dev,
>  	if (kstrtoull(buf, 0, &pfn) < 0)
>  		return -EINVAL;
>  	pfn >>= PAGE_SHIFT;
> -	ret = memory_failure(pfn, 0);
> +	ret = memory_failure(pfn, MF_SW_SIMULATED);
>  	if (ret == -EOPNOTSUPP)
>  		ret = 0;
>  	return ret ? ret : count;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bc8f326be0ce..4346e51484ba 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3232,6 +3232,7 @@ enum mf_flags {
>  	MF_MUST_KILL = 1 << 2,
>  	MF_SOFT_OFFLINE = 1 << 3,
>  	MF_UNPOISON = 1 << 4,
> +	MF_SW_SIMULATED = 1 << 5,
>  };
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index 5c0cddd81505..65e242b5a432 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -48,7 +48,7 @@ static int hwpoison_inject(void *data, u64 val)
>  
>  inject:
>  	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
> -	err = memory_failure(pfn, 0);
> +	err = memory_failure(pfn, MF_SW_SIMULATED);
>  	return (err == -EOPNOTSUPP) ? 0 : err;
>  }
>  
> diff --git a/mm/madvise.c b/mm/madvise.c
> index d7b4f2602949..0316bbc6441b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1112,7 +1112,7 @@ static int madvise_inject_error(int behavior,
>  		} else {
>  			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
>  				 pfn, start);
> -			ret = memory_failure(pfn, MF_COUNT_INCREASED);
> +			ret = memory_failure(pfn, MF_COUNT_INCREASED | MF_SW_SIMULATED);
>  			if (ret == -EOPNOTSUPP)
>  				ret = 0;
>  		}
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b85661cbdc4a..da39ec8afca8 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -69,6 +69,8 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
>  
>  atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>  
> +static bool hw_memory_failure __read_mostly = false;

IIUC, this variable is updated every time when hardware memory corrupt happens. So
adding __read_mostly macro here doesn't look very appropriate. But when compared to
soft unpoison, this should be much rare. So __read_mostly should make sense from this
point of view. No strong opinion.

Anyway, the patch looks good to me. Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

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
> +
>  	if (!PageHWPoison(p)) {
>  		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
>  				 pfn, &unpoison_rs);
> 

