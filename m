Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C2C46E4BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhLIJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:02:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54190 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbhLIJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:02:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 82B97210FF;
        Thu,  9 Dec 2021 08:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639040344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YWsMjWejwfhqv/d2S29G1vAIT34xji/2SKWuQfXw5K8=;
        b=Oj5leA1irmEIVS38sLDs8L6lMXhTC3eucjbNFykrBPhzvl71r1t8FByE3XRHDoyxD71Q7o
        WLL39CJ8G/i0k8QO0golzFyLUs0DulUJjQeM7Uq3a+MI6QnNk5Ps3l190H212iz5RjnD/C
        czZEDHihlQLA2oN1MrJSv9gyDAJyKKU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1B254A3B95;
        Thu,  9 Dec 2021 08:59:04 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:59:03 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 3/3] mm/oom_kill: allow process_mrelease to run under
 mmap_lock protection
Message-ID: <YbHFVxd34P0CvfpG@dhcp22.suse.cz>
References: <20211208212211.2860249-1-surenb@google.com>
 <20211208212211.2860249-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208212211.2860249-3-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-12-21 13:22:11, Suren Baghdasaryan wrote:
> With exit_mmap holding mmap_write_lock during free_pgtables call,
> process_mrelease does not need to elevate mm->mm_users in order to
> prevent exit_mmap from destrying pagetables while __oom_reap_task_mm
> is walking the VMA tree. The change prevents process_mrelease from
> calling the last mmput, which can lead to waiting for IO completion
> in exit_aio.
> 
> Fixes: 337546e83fc7 ("mm/oom_kill.c: prevent a race between process_mrelease and exit_mmap")

I am not sure I have brought this up already but I do not think Fixes
tag is a good fit. 337546e83fc7 is a correct way to handle the race. It
is just slightly less optimal than this fix.

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/oom_kill.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1ddabefcfb5a..67780386f478 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1169,15 +1169,15 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  		goto put_task;
>  	}
>  
> -	if (mmget_not_zero(p->mm)) {
> -		mm = p->mm;
> -		if (task_will_free_mem(p))
> -			reap = true;
> -		else {
> -			/* Error only if the work has not been done already */
> -			if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> -				ret = -EINVAL;
> -		}
> +	mm = p->mm;
> +	mmgrab(mm);
> +
> +	if (task_will_free_mem(p))
> +		reap = true;
> +	else {
> +		/* Error only if the work has not been done already */
> +		if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> +			ret = -EINVAL;
>  	}
>  	task_unlock(p);
>  
> @@ -1188,13 +1188,16 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  		ret = -EINTR;
>  		goto drop_mm;
>  	}
> -	if (!__oom_reap_task_mm(mm))
> +	/*
> +	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
> +	 * possible change in exit_mmap is seen
> +	 */
> +	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
>  		ret = -EAGAIN;
>  	mmap_read_unlock(mm);
>  
>  drop_mm:
> -	if (mm)
> -		mmput(mm);
> +	mmdrop(mm);
>  put_task:
>  	put_task_struct(task);
>  	return ret;
> -- 
> 2.34.1.400.ga245620fadb-goog

-- 
Michal Hocko
SUSE Labs
