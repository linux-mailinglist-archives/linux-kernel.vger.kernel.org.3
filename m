Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E8B475A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbhLOONp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:13:45 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:20998 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhLOONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639577622; x=1671113622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IOEPlVejksN1DxCvbwyaNA34YV1REce2jmMX5fVsZOA=;
  b=vpDjst6Xy2Yorpf6VEZu8FCIXCbdXegrYTIpYLtQqsgqiNvIAyAaGAMI
   KQ5+Snio95osfqXGC60caA65F+0EqbcsY1wAWL7elPHfq5GL4AISoXeSU
   0c5GdSXGNJG1xNEudduFW4ubtar4RST2F9XkWC3cmAERRCHw98471pDdG
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Dec 2021 06:13:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 06:13:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 06:13:41 -0800
Received: from fixkernel.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 15 Dec
 2021 06:13:39 -0800
Date:   Wed, 15 Dec 2021 09:13:37 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Jianyong Wu <jianyong.wu@arm.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <anshuman.khandual@arm.com>, <akpm@linux-foundation.org>,
        <ardb@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <david@redhat.com>,
        <gshan@redhat.com>, <justin.he@arm.com>, <nd@arm.com>
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Message-ID: <Ybn4EfweLqKtyW0+@fixkernel.com>
References: <20211210095432.51798-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211210095432.51798-1-jianyong.wu@arm.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:54:32PM +0800, Jianyong Wu wrote:
> fixmap is a global resource and is used recursively in create pud mapping.
> It may lead to race condition when alloc_init_pud is called concurrently.
> 
> Fox example:
> alloc_init_pud is called when kernel_init. If memory hotplug
> thread, which will also call alloc_init_pud, happens during
> kernel_init, the race for fixmap occurs.
> 
> The race condition flow can be:
> 
> *************** begin **************
> 
> kerenl_init thread                          virtio-mem workqueue thread
> ==================                          ======== ==================
> alloc_init_pud(...)
>   pudp = pud_set_fixmap_offset(..)          alloc_init_pud(...)
> ...                                         ...
>     READ_ONCE(*pudp) //OK!                    pudp = pud_set_fixmap_offset(
> ...                                         ...
>   pud_clear_fixmap() //fixmap break
>                                               READ_ONCE(*pudp) //CRASH!
> 
> **************** end ***************
> 
> Hence, a spin lock is introduced to protect the fixmap during create pdg
> mapping.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>

I am afraid there is a problem to take a spinlock there.

node 0 deferred pages initialised in 2740ms
 pgdatinit0 (176) used greatest stack depth: 59184 bytes left
 devtmpfs: initialized
 KASLR disabled due to lack of seed
 BUG: sleeping function called from invalid context at mm/page_alloc.c:5151
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
 preempt_count: 1, expected: 0
 1 lock held by swapper/0/1:
  #0: ffff800009ea3278 (fixmap_lock){+.+.}-{2:2}, at: __create_pgd_mapping
  alloc_init_pud at /usr/src/linux-next/arch/arm64/mm/mmu.c:340 (discriminator 4)
  (inlined by) __create_pgd_mapping at /usr/src/linux-next/arch/arm64/mm/mmu.c:393 (discriminator 4)
 CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.16.0-rc5-next-20211214
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  dump_stack
  __might_resched
  __might_sleep
  __alloc_pages
  alloc_page_interleave
  alloc_pages
  __get_free_pages
  __pgd_pgtable_alloc
  __create_pgd_mapping
  __phys_to_pte_val at /usr/src/linux-next/./arch/arm64/include/asm/pgtable.h:77
  (inlined by) __pud_populate at /usr/src/linux-next/./arch/arm64/include/asm/pgalloc.h:25
  (inlined by) alloc_init_cont_pmd at /usr/src/linux-next/arch/arm64/mm/mmu.c:277
  (inlined by) alloc_init_pud at /usr/src/linux-next/arch/arm64/mm/mmu.c:358
  (inlined by) __create_pgd_mapping at /usr/src/linux-next/arch/arm64/mm/mmu.c:393
  map_entry_trampoline
  map_entry_trampoline at /usr/src/linux-next/arch/arm64/mm/mmu.c:639
  do_one_initcall
  kernel_init_freeable
  kernel_init
  ret_from_fork

> ---
>  arch/arm64/mm/mmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index acfae9b41cc8..98ac09ae9588 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>  
>  static DEFINE_SPINLOCK(swapper_pgdir_lock);
> +static DEFINE_SPINLOCK(fixmap_lock);
>  
>  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  {
> @@ -329,6 +330,11 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  	}
>  	BUG_ON(p4d_bad(p4d));
>  
> +	/*
> +	 * fixmap is global resource, thus it needs to be protected by a lock
> +	 * in case of race condition.
> +	 */
> +	spin_lock(&fixmap_lock);
>  	pudp = pud_set_fixmap_offset(p4dp, addr);
>  	do {
>  		pud_t old_pud = READ_ONCE(*pudp);
> @@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  	} while (pudp++, addr = next, addr != end);
>  
>  	pud_clear_fixmap();
> +	spin_unlock(&fixmap_lock);
>  }
>  
>  static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> -- 
> 2.17.1
> 
