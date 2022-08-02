Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1075D5879A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiHBJJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiHBJJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:09:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119544B4A6;
        Tue,  2 Aug 2022 02:09:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B730920585;
        Tue,  2 Aug 2022 09:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659431373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UkyokZQiUGgS32T7RwX35cBkz6mpMRTZP71cJgaHl4k=;
        b=Bo7QfQt+FRw8GdAAowDqF5VitqqIwho89C+bfVzIEQpdEWQPxx5OvhU0d8iosWLLlXjQNt
        RN0v9VuCXrIG2/Aq3Kk24+Nqwly+MNLV3aWqAV4dlod5SwLgri5HraJyEmYM+/WvpJMFgP
        NRXcxqDlf3us08MYrOB/WwAIWdr98PY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AEF61345B;
        Tue,  2 Aug 2022 09:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X37/IM3p6GKdXwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 02 Aug 2022 09:09:33 +0000
Date:   Tue, 2 Aug 2022 11:09:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Kennelly <ckennelly@google.com>,
        Chris Zankel <chris@zankel.net>, Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH mm-unstable] mm/madvise: remove CAP_SYS_ADMIN requirement
 for process_madvise(MADV_COLLAPSE)
Message-ID: <YujpzGKImMQsn8SM@dhcp22.suse.cz>
References: <20220801210946.3069083-1-zokeefe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801210946.3069083-1-zokeefe@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hasn't this been discussed during the MADV_COLLAPSE submission? What has
changed? Does this need more time to settle with the consensus?

On Mon 01-08-22 14:09:46, Zach O'Keefe wrote:
> process_madvise(MADV_COLLAPSE) currently requires CAP_SYS_ADMIN when not
> acting on the caller's own mm.  This is maximally restrictive, and
> perpetuates existing issues with CAP_SYS_ADMIN.  Remove this requirement.
> 
> When acting on an external process' memory, the biggest concerns for
> process_madvise(MADV_COLLAPSE) are (1) being able to influence process
> performance by moving memory, possibly between nodes, that is mapped
> into the address space of external process(es), (2) defeat of
> address-space-layout randomization, and (3), being able to increase
> process RSS and memcg usage, possibly causing memcg OOM.
> 
> process_madvise(2) already enforces CAP_SYS_NICE and PTRACE_MODE_READ (in
> PTRACE_MODE_FSCREDS mode).  A process with these credentials can already
> accomplish (1) and (2) via move_pages(MPOL_MF_MOVE_ALL), and (3) via
> process_madvise(MADV_WILLNEED).
> 
> process_madvise(MADV_COLLAPSE) may also circumvent sysfs THP settings.
> When acting on one's own memory (which is equivalent to
> madvise(MADV_COLLAPSE)), this is deemed acceptable, since aside from the
> possibility of hoarding available hugepages (which is currently already
> possible) no harm to the system can be done.  When acting on an external
> process' memory, circumventing sysfs THP settings should provide no
> additional threat compared to the ones listed.  As such, imposing
> additional capabilities (such as CAP_SETUID, as a way to ensure the
> caller could have just altered the sysfs THP settings themselves)
> provides no extra protection.
> 
> Fixes: 7ec952341312 ("mm/madvise: add MADV_COLLAPSE to process_madvise()")
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> ---
>  mm/madvise.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f9e11b6c9916..af97100a0727 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1170,16 +1170,14 @@ madvise_behavior_valid(int behavior)
>  	}
>  }
>  
> -static bool
> -process_madvise_behavior_valid(int behavior, struct task_struct *task)
> +static bool process_madvise_behavior_valid(int behavior)
>  {
>  	switch (behavior) {
>  	case MADV_COLD:
>  	case MADV_PAGEOUT:
>  	case MADV_WILLNEED:
> -		return true;
>  	case MADV_COLLAPSE:
> -		return task == current || capable(CAP_SYS_ADMIN);
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -1457,7 +1455,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  		goto free_iov;
>  	}
>  
> -	if (!process_madvise_behavior_valid(behavior, task)) {
> +	if (!process_madvise_behavior_valid(behavior)) {
>  		ret = -EINVAL;
>  		goto release_task;
>  	}
> -- 
> 2.37.1.455.g008518b4e5-goog

-- 
Michal Hocko
SUSE Labs
