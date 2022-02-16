Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBB4B8268
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiBPHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:55:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBPHzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:55:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41412ABC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:54:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B9B01F383;
        Wed, 16 Feb 2022 07:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644998096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TxBgqjdksHPLJq8E0F3oYjbttSraGp3Hl6jxvEKvJhU=;
        b=YdvTOL8yRTcmAGpdAJUACb2vz0BxkDmsjyt+WDtgV7xclhve6QeIWyVuIaB1Fk7GiKIwx1
        T4lJ8A6eHnqkXPJm60Y9WRRTL8TbMWEl+YSsr5G6BhJ1tR2JglMUu6+5d9RfreM9kXzMRZ
        zYVhb9jWwAsuR9Z3jjtrAQ1OP5c/oeg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0B262A3B89;
        Wed, 16 Feb 2022 07:54:55 +0000 (UTC)
Date:   Wed, 16 Feb 2022 08:54:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        christian@brauner.io, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        luto@kernel.org, christian.brauner@ubuntu.com, fweimer@redhat.com,
        jengelh@inai.de, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Message-ID: <YgytzntIfx6Toom2@dhcp22.suse.cz>
References: <20220215201922.1908156-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215201922.1908156-1-surenb@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-02-22 12:19:22, Suren Baghdasaryan wrote:
> After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> otherwise it points to a vma that was freed and when reused leads to
> a use-after-free bug.

OK, so I have dived into this again. exit_mmap doesn't reset mmap
indeed.  That doesn't really matter for _oom victims_. Both the oom reaper and
mrelease do check for MMF_OOM_SKIP before calling __oom_reap_task_mm.
exit_mmap still sets MMF_OOM_SKIP before taking the mmap_lock for oom
victims so those paths should be still properly synchronized.  I have
proposed to get rid of this
http://lkml.kernel.org/r/YbHIaq9a0CtqRulE@dhcp22.suse.cz but we haven't
agreed on that.

mrelease path is broken because it doesn't mark the process oom_victim
and so the MMF_OOM_SKIP synchronization doesn't work. So we really need
this.
 
I would propose to rephrase the changelog to be more specific because I
do not want to remember all those details later on.
What about
"
oom reaping (__oom_reap_task_mm) relies on a 2 way synchronization with
exit_mmap. First it relies on the mmap_lock to exclude from unlock
path[1], page tables tear down (free_pgtables) and vma destruction.
This alone is not sufficient because mm->mmap is never reset. For
historical reasons[2] the lock is taken there is also MMF_OOM_SKIP set
for oom victims before.

The oom reaper only ever looks at oom victims so the whole scheme works
properly but process_mrelease can opearate on any task (with fatal
signals pending) which doesn't really imply oom victims. That means that
the MMF_OOM_SKIP part of the synchronization doesn't work and it can
see a task after the whole address space has been demolished and
traverse an already released mm->mmap list. This leads to use after free
as properly caught up by KASAN report.

Fix the issue by reseting mm->mmap so that MMF_OOM_SKIP synchronization
is not needed anymore. The MMF_OOM_SKIP is not removed from exit_mmap
yet but it acts mostly as an optimization now.

[1] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap,
v3")
[2] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run
concurrently")
"

I really have to say that I hate how complex this has grown in the name
of optimizations. This has backfired several times already resulting in
2 security issues. I really hope to get read any note of the oom reaper
from exit_mmap.

> Reported-by: syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/mmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1e8fdb0b51ed..d445c1b9d606 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
>  		vma = remove_vma(vma);
>  		cond_resched();
>  	}
> +	mm->mmap = NULL;
>  	mmap_write_unlock(mm);
>  	vm_unacct_memory(nr_accounted);
>  }
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 
Michal Hocko
SUSE Labs
