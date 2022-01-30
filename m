Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD94A354E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 10:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354442AbiA3JNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 04:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354000AbiA3JNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 04:13:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300FEC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 01:13:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEDCAB8286B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 09:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADE5C340E4;
        Sun, 30 Jan 2022 09:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643534019;
        bh=cM8a1BT6LaZu1DHKkrAqCukI0JB0jBgJb3lYj9h6XPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+gXD0U3XoWUJpZx0ZUh1LuX+WqDimVnzKpgu+HDf0we7IkWiCUO6E/Rw574s6zGM
         n2m78pjt2B6yGu6BLWYm+5buzmGJrY0tWokjFw627i5JVNY6mxIfRON1qudqp6R1T6
         bzg+BEIAGwUKxFPwn8Wy91r7wkndzEn6fgKlmMBfQeMNTbUKyMb70aD8JwHaSRUBmY
         9ZLcRlIgwLHWnWdlVpRwSlZEMqt/l6Dlg/oYb0XpibcKnIe5aH4WMb5x6nKL8UXJKE
         S8jgdcRdn88DTjtOQzt+3mHvwGzulfZoFkdrsPr6XZ8IenHn+oivn4p3IArg7Hwkmj
         yEPgTiArK9pkw==
Date:   Sun, 30 Jan 2022 11:13:26 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 33/35] arm64/mm: attempt speculative mm faults first
Message-ID: <YfZWtsC3QIzXR0LI@kernel.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-34-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128131006.67712-34-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 05:10:04AM -0800, Michel Lespinasse wrote:
> Attempt speculative mm fault handling first, and fall back to the
> existing (non-speculative) code if that fails.
> 
> This follows the lines of the x86 speculative fault handling code,
> but with some minor arch differences such as the way that the
> VM_FAULT_BADACCESS case is handled.
> 
> Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
> ---
>  arch/arm64/mm/fault.c | 62 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 77341b160aca..2598795f4e70 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -25,6 +25,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/preempt.h>
>  #include <linux/hugetlb.h>
> +#include <linux/vm_event_item.h>
>  
>  #include <asm/acpi.h>
>  #include <asm/bug.h>
> @@ -524,6 +525,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
>  	unsigned long vm_flags;
>  	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>  	unsigned long addr = untagged_addr(far);
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	struct vm_area_struct *vma;
> +	struct vm_area_struct pvma;
> +	unsigned long seq;
> +#endif
>  
>  	if (kprobe_page_fault(regs, esr))
>  		return 0;
> @@ -574,6 +580,59 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
>  
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	/*
> +	 * No need to try speculative faults for kernel or
> +	 * single threaded user space.
> +	 */
> +	if (!(mm_flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
> +		goto no_spf;
> +
> +	count_vm_event(SPF_ATTEMPT);
> +	seq = mmap_seq_read_start(mm);
> +	if (seq & 1) {
> +		count_vm_spf_event(SPF_ABORT_ODD);
> +		goto spf_abort;
> +	}
> +	rcu_read_lock();
> +	vma = __find_vma(mm, addr);
> +	if (!vma || vma->vm_start > addr) {
> +		rcu_read_unlock();
> +		count_vm_spf_event(SPF_ABORT_UNMAPPED);
> +		goto spf_abort;
> +	}
> +	if (!vma_is_anonymous(vma)) {
> +		rcu_read_unlock();
> +		count_vm_spf_event(SPF_ABORT_NO_SPECULATE);
> +		goto spf_abort;
> +	}
> +	pvma = *vma;
> +	rcu_read_unlock();
> +	if (!mmap_seq_read_check(mm, seq, SPF_ABORT_VMA_COPY))
> +		goto spf_abort;
> +	vma = &pvma;
> +	if (!(vma->vm_flags & vm_flags)) {
> +		count_vm_spf_event(SPF_ABORT_ACCESS_ERROR);
> +		goto spf_abort;
> +	}
> +	fault = do_handle_mm_fault(vma, addr & PAGE_MASK,
> +			mm_flags | FAULT_FLAG_SPECULATIVE, seq, regs);
> +
> +	/* Quick path to respond to signals */
> +	if (fault_signal_pending(fault, regs)) {
> +		if (!user_mode(regs))
> +			goto no_context;
> +		return 0;
> +	}
> +	if (!(fault & VM_FAULT_RETRY))
> +		goto done;
> +
> +spf_abort:
> +	count_vm_event(SPF_ABORT);
> +no_spf:
> +
> +#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */

The speculative page fault implementation here (and for PowerPC as well)
looks very similar to x86. Can we factor it our rather than copy 3 (or
more) times?

> +
>  	/*
>  	 * As per x86, we may deadlock here. However, since the kernel only
>  	 * validly references user space from well defined areas of the code,
> @@ -612,6 +671,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
>  		goto retry;
>  	}
>  	mmap_read_unlock(mm);
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +done:
> +#endif
>  
>  	/*
>  	 * Handle the "normal" (no error) case first.
> -- 
> 2.20.1
> 
> 

-- 
Sincerely yours,
Mike.
