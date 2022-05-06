Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63BC51E022
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442751AbiEFUbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359144AbiEFUbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:31:46 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9006A069
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:28:02 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b20so6717489qkc.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gJRviFU9XNPBvSIC8osynd2EBbBBsM0NjUDjDjJmf6k=;
        b=l/qQW8JfOrw4KrFiJhRr4bCeOVcZPnBUWW2hdDR3RqRoe0c1Eb4Wv+9hR68y8Pu+WE
         ITfeV4SAWHOUVjopZBfrbDulPcoG1lIBkPgNzB1T82Nt62nb2GRhT4fTPzqPatofx2F4
         QQ8kyw2Tc1RGUBXCu17iz57vnBD2UJJRTOJaNJnG9hkJMiJavnFNCrF50vdlyBhp028B
         hlY5gZgGzUKv1GKa4HY+xrZC4PNO1/0D/i49Bda9+CXy2hysoD2ayM5Ntbz1zwoNCLUS
         TyiVCkVhW+k3VHmupL6QpiGcgDx9kmgOfo1f4DyRDgk27WU+nUtZPcwGpBtnkOnKFE3R
         qFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gJRviFU9XNPBvSIC8osynd2EBbBBsM0NjUDjDjJmf6k=;
        b=CT9yEX9ruQjR5zhjatGwuDMZttU+7JH5G9TEJ/Zvr69hncNWTGNPJMirpNlfFwO/H9
         bvFdqGjgY/DEJoSbOYeQMRLO81hWpitEEVnSFJpGfeocS088Vy0jtY+XC9Te475pWoIp
         cjnsft5wNJowZNlZAunRs+AgBSlTGuHVq/kXM7es+0qlrXtNOxUJhe+2moknai27BbO7
         WuHaFAxx5XCyDugn4T4rPfvuZnNQUDxx3uIwS7WMxbwhhudwUhmT7BfC/AibUKWCGwNj
         q/wxuAOPPjAnhyDDkNC1xHTEX9FMS6sXV9vjxydzyEDtlIR2XoSkLzNuTXJMdLRoyiMb
         U1og==
X-Gm-Message-State: AOAM530ng4z2LEV5iD/nFOolIxQhmJt8/oAFGl0bX3zS4inKxuXcDyDw
        7rGRuyBlR52sFZkdHRI8wEugdpOC/Dw8kQ==
X-Google-Smtp-Source: ABdhPJxJADx7Lnw1xbTgYnpRiF0dfcWdQucL7QaXHNOs1/+/tWJGzlZNm7XYpYGj0HJdHVSJgpJzrw==
X-Received: by 2002:a05:620a:e06:b0:69e:e402:477d with SMTP id y6-20020a05620a0e0600b0069ee402477dmr3719167qkm.716.1651868881482;
        Fri, 06 May 2022 13:28:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:538c])
        by smtp.gmail.com with ESMTPSA id z6-20020ac84546000000b002f39b99f6b4sm3069806qtn.78.2022.05.06.13.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:28:01 -0700 (PDT)
Date:   Fri, 6 May 2022 16:27:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YnWEmsUwJt9KOUN0@cmpxchg.org>
References: <20220505211748.41127-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505211748.41127-1-peterx@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 05:17:48PM -0400, Peter Xu wrote:
> I observed that for each of the shared file-backed page faults, we're very
> likely to retry one more time for the 1st write fault upon no page.  It's
> because we'll need to release the mmap lock for dirty rate limit purpose
> with balance_dirty_pages_ratelimited() (in fault_dirty_shared_page()).
> 
> Then after that throttling we return VM_FAULT_RETRY.
> 
> We did that probably because VM_FAULT_RETRY is the only way we can return
> to the fault handler at that time telling it we've released the mmap lock.
> 
> However that's not ideal because it's very likely the fault does not need
> to be retried at all since the pgtable was well installed before the
> throttling, so the next continuous fault (including taking mmap read lock,
> walk the pgtable, etc.) could be in most cases unnecessary.
> 
> It's not only slowing down page faults for shared file-backed, but also add
> more mmap lock contention which is in most cases not needed at all.
> 
> To observe this, one could try to write to some shmem page and look at
> "pgfault" value in /proc/vmstat, then we should expect 2 counts for each
> shmem write simply because we retried, and vm event "pgfault" will capture
> that.
> 
> To make it more efficient, add a new VM_FAULT_COMPLETED return code just to
> show that we've completed the whole fault and released the lock.  It's also
> a hint that we should very possibly not need another fault immediately on
> this page because we've just completed it.
> 
> This patch provides a ~12% perf boost on my aarch64 test VM with a simple
> program sequentially dirtying 400MB shmem file being mmap()ed:
> 
>   Before: 650980.20 (+-1.94%)
>   After:  569396.40 (+-1.38%)
> 
> I believe it could help more than that.
> 
> We need some special care on GUP and the s390 pgfault handler (for gmap
> code before returning from pgfault), the rest changes in the page fault
> handlers should be relatively straightforward.
> 
> Another thing to mention is that mm_account_fault() does take this new
> fault as a generic fault to be accounted, unlike VM_FAULT_RETRY.
> 
> I explicitly didn't touch hmm_vma_fault() and break_ksm() because they do
> not handle VM_FAULT_RETRY even with existing code, so I'm literally keeping
> them as-is.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

The change makes sense to me, but the unlock/retry signaling is
tricky...

> @@ -1227,6 +1247,18 @@ int fixup_user_fault(struct mm_struct *mm,
>  		return -EINTR;
>  
>  	ret = handle_mm_fault(vma, address, fault_flags, NULL);
> +
> +	if (ret & VM_FAULT_COMPLETED) {
> +		/*
> +		 * NOTE: it's a pity that we need to retake the lock here
> +		 * to pair with the unlock() in the callers. Ideally we
> +		 * could tell the callers so they do not need to unlock.
> +		 */
> +		mmap_read_lock(mm);
> +		*unlocked = true;
> +		return 0;
> +	}

unlocked can be NULL inside the function, yet you assume it's non-NULL
here. This is okay because COMPLETED can only be returned if RETRY is
set, and when RETRY is set unlocked must be non-NULL. It's correct but
not very obvious.

It might be cleaner to have separate flags for ALLOW_RETRY and
ALLOW_UNLOCK, with corresponding VM_FAULT_RETRY and VM_FAULT_UNLOCKED?
Even if not all combinations are used.

> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2942,7 +2942,7 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
>  		balance_dirty_pages_ratelimited(mapping);
>  		if (fpin) {
>  			fput(fpin);
> -			return VM_FAULT_RETRY;
> +			return VM_FAULT_COMPLETED;

There is one oddity in this now.

It completes the fault and no longer triggers a retry. Yet it's still
using maybe_unlock_mmap_for_io() and subject to retry limiting. This
means that if the fault already retried once, this code won't drop the
mmap_sem to call balance_dirty_pages() - even though it safely could
and should do so, without risking endless retries.

Here too IMO the distinction between ALLOW_RETRY|TRIED and
ALLOW_UNLOCK would make things cleaner and more obvious.
