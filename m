Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40948478711
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhLQJan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:30:43 -0500
Received: from foss.arm.com ([217.140.110.172]:53814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhLQJal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:30:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61FCF1435;
        Fri, 17 Dec 2021 01:30:41 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E79DC3F774;
        Fri, 17 Dec 2021 01:30:38 -0800 (PST)
Date:   Fri, 17 Dec 2021 09:30:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        anshuman.khandual@arm.com, akpm@linux-foundation.org,
        david@redhat.com, quic_qiancai@quicinc.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gshan@redhat.com, justin.he@arm.com, nd@arm.com
Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Message-ID: <YbxYuETndF9LmJz4@FVFF77S0Q05N>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216082812.165387-1-jianyong.wu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 04:28:12PM +0800, Jianyong Wu wrote:
> The 'fixmap' is a global resource and is used recursively by
> create pud mapping(), leading to a potential race condition in the
> presence of a concurrent call to alloc_init_pud():
> 
> kernel_init thread                          virtio-mem workqueue thread
> ==================                          ===========================
> 
>   alloc_init_pud(...)                       alloc_init_pud(...)
>   pudp = pud_set_fixmap_offset(...)         pudp = pud_set_fixmap_offset(...)
>   READ_ONCE(*pudp)
>   pud_clear_fixmap(...)
>                                             READ_ONCE(*pudp) // CRASH!
> 
> As kernel may sleep during creating pud mapping, introduce a mutex lock to
> serialise use of the fixmap entries by alloc_init_pud().
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>

Since there were deadlock issues with the last version, it would be very nice
if we could check this with at least:

* CONFIG_DEBUG_ATOMIC_SLEEP
* CONFIG_PROVE_LOCKING

... so that we can be reasonably certain that we're not introducing some
livelock/deadlock scenario.

Are you able to reproduce the problem for testing, or was this found by
inspection? Do you have any instructions for reproducing the problem? e.g. can
this easily be tested with QEMU?

If you're able to reproduce the issue, it would be nice to have an example
backtrace of when this goes wrong.

Thanks,
Mark.

> ---
> 
> Change log:
> 
> from v2 to v3:
>      change spin lock to mutex lock as kernel may sleep when create pud
> map.
> 
>  arch/arm64/mm/mmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index acfae9b41cc8..e680a6a8ca40 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>  
>  static DEFINE_SPINLOCK(swapper_pgdir_lock);
> +static DEFINE_MUTEX(fixmap_lock);
>  
>  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  {
> @@ -329,6 +330,11 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  	}
>  	BUG_ON(p4d_bad(p4d));
>  
> +	/*
> +	 * We only have one fixmap entry per page-table level, so take
> +	 * the fixmap lock until we're done.
> +	 */
> +	mutex_lock(&fixmap_lock);
>  	pudp = pud_set_fixmap_offset(p4dp, addr);
>  	do {
>  		pud_t old_pud = READ_ONCE(*pudp);
> @@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  	} while (pudp++, addr = next, addr != end);
>  
>  	pud_clear_fixmap();
> +	mutex_unlock(&fixmap_lock);
>  }
>  
>  static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> -- 
> 2.17.1
> 
