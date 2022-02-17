Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5404BAB4A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbiBQUvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:51:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiBQUvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:51:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A083163D75
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:51:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 076BDB81B0E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19DFC340E8;
        Thu, 17 Feb 2022 20:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645131057;
        bh=M3DCGGewZr70eOjOG2Q+HAYxvOudSciSqV1kblBNK10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CGhuRuGZUgReF4FrJXds7xwuu7lZPVgEWg6FkVnzGeppquRnxl8H1BlU/gNxN5YhW
         0R/EB451JzKtQlDEOcOa1lQyMr2VqCnuo8J+uq64RhvnpYkTxur4uAanC15/ruRL+G
         PLoADDOvAC4+tSBvui4R4PEP+ncpLCTe41J82m1I=
Date:   Thu, 17 Feb 2022 12:50:56 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, shy828301@gmail.com,
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
Message-Id: <20220217125056.df4073b42f2d911c99939e93@linux-foundation.org>
In-Reply-To: <CAJuCfpFL9AQxNsjKxDHhu7UgMGETs+h9Avi6o1mQkvZ4N7CTRw@mail.gmail.com>
References: <20220215201922.1908156-1-surenb@google.com>
        <YgytzntIfx6Toom2@dhcp22.suse.cz>
        <CAJuCfpFL9AQxNsjKxDHhu7UgMGETs+h9Avi6o1mQkvZ4N7CTRw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 11:51:13 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> This changelog is very detailed and I support switching to it. Andrew,
> please let me know if I should re-post the patch with this description
> or you will just amend the one in your tree.

I have made that change.


From: Suren Baghdasaryan <surenb@google.com>
Subject: mm: fix use-after-free bug when mm->mmap is reused after being freed

oom reaping (__oom_reap_task_mm) relies on a 2 way synchronization with
exit_mmap.  First it relies on the mmap_lock to exclude from unlock
path[1], page tables tear down (free_pgtables) and vma destruction. 
This alone is not sufficient because mm->mmap is never reset.  For
historical reasons[2] the lock is taken there is also MMF_OOM_SKIP set
for oom victims before.

The oom reaper only ever looks at oom victims so the whole scheme works
properly but process_mrelease can opearate on any task (with fatal
signals pending) which doesn't really imply oom victims.  That means
that the MMF_OOM_SKIP part of the synchronization doesn't work and it
can see a task after the whole address space has been demolished and
traverse an already released mm->mmap list.  This leads to use after
free as properly caught up by KASAN report.

Fix the issue by reseting mm->mmap so that MMF_OOM_SKIP synchronization
is not needed anymore.  The MMF_OOM_SKIP is not removed from exit_mmap
yet but it acts mostly as an optimization now.

[1] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
[2] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")

[mhocko@suse.com: changelog rewrite]
Link: https://lore.kernel.org/all/00000000000072ef2c05d7f81950@google.com/
Link: https://lkml.kernel.org/r/20220215201922.1908156-1-surenb@google.com
Fixes: 64591e8605d6 ("mm: protect free_pgtables with mmap_lock write lock in exit_mmap")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reported-by: syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
Suggested-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jan Engelhardt <jengelh@inai.de>
Cc: Tim Murray <timmurray@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mmap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/mmap.c~mm-fix-use-after-free-bug-when-mm-mmap-is-reused-after-being-freed
+++ a/mm/mmap.c
@@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
 		vma = remove_vma(vma);
 		cond_resched();
 	}
+	mm->mmap = NULL;
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
 }
_

