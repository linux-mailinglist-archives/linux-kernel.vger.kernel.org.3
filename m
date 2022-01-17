Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D6C4903E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiAQIdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbiAQIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:32:58 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14A3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:32:58 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so18864698otc.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nVT8uDAlRL3Rmmm8MhN7jbH+dX4OmgglPO5LqqiGAE=;
        b=AuRUmj9xA5HENmcIlN/9Rn9vzA+9z3Pfac3UWeMtFHWZXnoqTbe5r4y27TAHXI8iql
         tcRZhA0P9z8eDNyCTxvgPbNmvo87LQcjdLCmIDp/CD6rghjB7iPRerseTYwmLYuI9ioD
         kcVGDf00+2RzRJk07n7tmIQ7WAg1uYJ7+p0NpGosT5ulDHbLD9cZgx9CVLks0B3/HGOy
         8YuFdsVbsW/7zV7p0fj7JbdRCU1LWEzViLpLIxMcSCCBLEaZUMIBeygzYUfNJ4GvaG9M
         O4PVowpvw8bQCt02+VcQbEhmJtOB/HrwP7Vl/CKe2iw04wg35XXRTFeSkNK5QP9+RiQg
         qVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nVT8uDAlRL3Rmmm8MhN7jbH+dX4OmgglPO5LqqiGAE=;
        b=eu5iQSuBoCOYO5zouGQBj544Vj75ASyruZeKlpI73GE2Mrp+THXAC+js0m8+UJHxBh
         qXC5+/y/FDHHL3jY46RhHaVEI4Jc47SzhM70bEnqUAQyfUfgKbONpcAuuAgMz6ucAsD+
         kYthdp6t7PhAsX/mRqOFhFO+eqQOgiM3Z5OEJlMBJgbnHrfOF8Jclj38f/2L3BwC8q71
         K7g71fThXQ66j1k+nbi1/mPTldOAoORftE9RMssiOdOR1yOSIbv24FdXvvM9aBbi0o6J
         VXn4xBMKpziTopHIKMsrEk9dtU7Q3yVjgzCS8ks5xskk6z3oWsdpI4zd3t6zWEoddCpy
         Fr7g==
X-Gm-Message-State: AOAM533xi1dwO7+PKN8SPEEdLCvffylrEjAhVG2PstDAs4LzmFRe/Q/M
        CzukBb9f3ZoN/jvUzqWw1ts8RPC7dDqFYu3GYfbE7+EgH88=
X-Google-Smtp-Source: ABdhPJzTvfxW7uuMUP3uIE/Fzrwgy6KEBncQaVEVTdPP3Pl/1bhkfcmnWvt4qfcx8vzDGseQeJEoAo0pGtE5c7YoOpA=
X-Received: by 2002:a05:6830:802:: with SMTP id r2mr9177385ots.298.1642408377877;
 Mon, 17 Jan 2022 00:32:57 -0800 (PST)
MIME-Version: 1.0
References: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
 <YeO8pcs866Iu2iJX@ip-172-31-30-232.ap-northeast-1.compute.internal>
In-Reply-To: <YeO8pcs866Iu2iJX@ip-172-31-30-232.ap-northeast-1.compute.internal>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 17 Jan 2022 16:32:46 +0800
Message-ID: <CADvbK_eY=3Gf79MkvK72Nh86ysN4eoFei0k1jg0frg22GgToGA@mail.gmail.com>
Subject: Re: [PATCH] mm: slub: fix a deadlock warning in kmem_cache_destroy
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 2:35 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Fri, Jan 14, 2022 at 09:23:16AM -0500, Xin Long wrote:
> > cpus_read_lock() is introduced into kmem_cache_destroy() by
> > commit 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations
> > __free_slab() invocations out of IRQ context"), and it could cause
> > a deadlock.
> >
> > As Antoine pointed out, when one thread calls kmem_cache_destroy(), it is
> > blocking until kn->active becomes 0 in kernfs_drain() after holding
> > cpu_hotplug_lock. While in another thread, when calling kernfs_fop_write(),
> > it may try to hold cpu_hotplug_lock after incrementing kn->active by
> > calling kernfs_get_active():
> >
>
> Hello. can you give me a link of related the thread?
Sorry, I don't have a thread on the internet, but I think the changelog
has provided all the information we have.

Just note that It was reproduced in the RHEL-8 RT Kernel after we fixed
another issue. From the code analysis, this issue does exist on the
upstream kernel, though I couldn't build an upstream RT kernel for the
testing.

>
> >         CPU0                        CPU1
> >         ----                        ----
> >   cpus_read_lock()
> >                                    kn->active++
> >                                    cpus_read_lock() [a]
> >   wait until kn->active == 0
> >
> > Although cpu_hotplug_lock is a RWSEM, [a] will not block in there. But as
> > lockdep annotations are added for cpu_hotplug_lock, a deadlock warning
> > would be detected:
> >
> >   ======================================================
> >   WARNING: possible circular locking dependency detected
> >   ------------------------------------------------------
> >   dmsetup/1832 is trying to acquire lock:
> >   ffff986f5a0f9f20 (kn->count#144){++++}-{0:0}, at: kernfs_remove+0x1d/0x30
> >
> >   but task is already holding lock:
> >   ffffffffa43817c0 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_destroy+0x2a/0x120
> >
> >   which lock already depends on the new lock.
> >
> >   the existing dependency chain (in reverse order) is:
> >
> >   -> #2 (slab_mutex){+.+.}-{3:3}:
> >          lock_acquire+0xe8/0x470
> >          mutex_lock_nested+0x47/0x80
> >          kmem_cache_destroy+0x2a/0x120
> >          bioset_exit+0xb5/0x100
> >          cleanup_mapped_device+0x26/0xf0 [dm_mod]
> >          free_dev+0x43/0xb0 [dm_mod]
> >          __dm_destroy+0x153/0x1b0 [dm_mod]
> >          dev_remove+0xe4/0x1a0 [dm_mod]
> >          ctl_ioctl+0x1af/0x3f0 [dm_mod]
> >          dm_ctl_ioctl+0xa/0x10 [dm_mod]
> >          do_vfs_ioctl+0xa5/0x760
> >          ksys_ioctl+0x60/0x90
> >          __x64_sys_ioctl+0x16/0x20
> >          do_syscall_64+0x8c/0x240
> >          entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> >
> >   -> #1 (cpu_hotplug_lock){++++}-{0:0}:
> >          lock_acquire+0xe8/0x470
> >          cpus_read_lock+0x39/0x100
> >          cpu_partial_store+0x44/0x80
> >          slab_attr_store+0x20/0x30
> >          kernfs_fop_write+0x101/0x1b0
> >          vfs_write+0xd4/0x1e0
> >          ksys_write+0x52/0xc0
> >          do_syscall_64+0x8c/0x240
> >          entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> >
> >   -> #0 (kn->count#144){++++}-{0:0}:
> >          check_prevs_add+0x185/0xb80
> >          __lock_acquire+0xd8f/0xe90
> >          lock_acquire+0xe8/0x470
> >          __kernfs_remove+0x25e/0x320
> >          kernfs_remove+0x1d/0x30
> >          kobject_del+0x28/0x60
> >          kmem_cache_destroy+0xf1/0x120
> >          bioset_exit+0xb5/0x100
> >          cleanup_mapped_device+0x26/0xf0 [dm_mod]
> >          free_dev+0x43/0xb0 [dm_mod]
> >          __dm_destroy+0x153/0x1b0 [dm_mod]
> >          dev_remove+0xe4/0x1a0 [dm_mod]
> >          ctl_ioctl+0x1af/0x3f0 [dm_mod]
> >          dm_ctl_ioctl+0xa/0x10 [dm_mod]
> >          do_vfs_ioctl+0xa5/0x760
> >          ksys_ioctl+0x60/0x90
> >          __x64_sys_ioctl+0x16/0x20
> >          do_syscall_64+0x8c/0x240
> >          entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> >
> >   other info that might help us debug this:
> >
> >   Chain exists of:
> >     kn->count#144 --> cpu_hotplug_lock --> slab_mutex
> >
> >    Possible unsafe locking scenario:
> >
> >          CPU0                    CPU1
> >          ----                    ----
> >     lock(slab_mutex);
> >                                  lock(cpu_hotplug_lock);
> >                                  lock(slab_mutex);
> >     lock(kn->count#144);
> >
> >    *** DEADLOCK ***
> >
> >   3 locks held by dmsetup/1832:
> >    #0: ffffffffa43fe5c0 (bio_slab_lock){+.+.}-{3:3}, at: bioset_exit+0x62/0x100
> >    #1: ffffffffa3e87c20 (cpu_hotplug_lock){++++}-{0:0}, at: kmem_cache_destroy+0x1c/0x120
> >    #2: ffffffffa43817c0 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_destroy+0x2a/0x120
> >
> >   stack backtrace:
> >   Call Trace:
> >    dump_stack+0x5c/0x80
> >    check_noncircular+0xff/0x120
> >    check_prevs_add+0x185/0xb80
> >    __lock_acquire+0xd8f/0xe90
> >    lock_acquire+0xe8/0x470
> >    __kernfs_remove+0x25e/0x320
> >    kernfs_remove+0x1d/0x30
> >    kobject_del+0x28/0x60
> >    kmem_cache_destroy+0xf1/0x120
> >    bioset_exit+0xb5/0x100
> >    cleanup_mapped_device+0x26/0xf0 [dm_mod]
> >    free_dev+0x43/0xb0 [dm_mod]
> >    __dm_destroy+0x153/0x1b0 [dm_mod]
> >    dev_remove+0xe4/0x1a0 [dm_mod]
> >    ctl_ioctl+0x1af/0x3f0 [dm_mod]
> >    dm_ctl_ioctl+0xa/0x10 [dm_mod]
> >    do_vfs_ioctl+0xa5/0x760
> >    ksys_ioctl+0x60/0x90
> >    __x64_sys_ioctl+0x16/0x20
> >    do_syscall_64+0x8c/0x240
> >    entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> >
>
> To summary the possible scenario is:
>
> - when cache is destroyed:
>         cpu_hotplug_lock
>         -> slab_mutex
>         -> wait until kn->count == 0 (because it removes sysfs objects.)
not really wait for kn->count == 0, but wait for kn->active in kernfs_drain():

        /* but everyone should wait for draining */
        wait_event(root->deactivate_waitq,
                   atomic_read(&kn->active) == KN_DEACTIVATED_BIAS);

>
> - when someone writes to cpu_partial attribute:
>         increase kn->count (incrased in kernfs_fop_write_iter(),
>         using kernfs_get_active() )
and yes, called kernfs_get_active() to hold/increment kn->active.

>         -> cpu_hotplug_lock
>         -> slab_mutex
>
> ... So there is a circular dependency when using kernfs because
> clearing sysfs stuff in kernfs  makes unexpected dependency. Right?
So it is:

      CPU0                            CPU1
        ----                            ----
  cpus_read_lock() in kmem_cache_destroy()
                                       kn->active++ in kernfs_get_active()
                                       cpus_read_lock() in
cpu_partial_store()->flush_all()
  wait until kn->active == 0 in kernfs_drain()


>
> I think it's quite unlikely but yeah, seems possible.
Interesting that it could be easily reproduced on the RT kernel.

>
> > Since cpus_read_lock() is supposed to protect the cpu related data, it
> > makes sense to fix this issue by moving cpus_read_lock() from
> > kmem_cache_destroy() to __kmem_cache_shutdown(). While at it,
> > add the missing cpus_read_lock() in slab_mem_going_offline_callback().
> >
> > Fixes: 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations __free_slab() invocations out of IRQ context")
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  mm/slab_common.c | 2 --
> >  mm/slub.c        | 4 ++--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index e5d080a93009..06ec3fa585e6 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -494,7 +494,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >       if (unlikely(!s))
> >               return;
> >
> > -     cpus_read_lock();
> >       mutex_lock(&slab_mutex);
> >
> >       s->refcount--;
> > @@ -509,7 +508,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >       }
> >  out_unlock:
> >       mutex_unlock(&slab_mutex);
> > -     cpus_read_unlock();
> >  }
>
> This code is changing lock order
> from cpu_hotplug_lock -> slab_muitex
> to slab_mutex -> cpu_hotplug_lock.
Right.

>
> >  EXPORT_SYMBOL(kmem_cache_destroy);
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index abe7db581d68..754f020235ee 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4311,7 +4311,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
> >       int node;
> >       struct kmem_cache_node *n;
> >
> > -     flush_all_cpus_locked(s);
> > +     flush_all(s);
> >       /* Attempt to free all objects */
> >       for_each_kmem_cache_node(s, node, n) {
> >               free_partial(s, n);
> > @@ -4646,7 +4646,7 @@ static int slab_mem_going_offline_callback(void *arg)
> >
> >       mutex_lock(&slab_mutex);
> >       list_for_each_entry(s, &slab_caches, list) {
> > -             flush_all_cpus_locked(s);
> > +             flush_all(s);
>
> In My Opinion, this code is wrong. Because it's called when memory
> offlining with cpu_hotplug_lock held. See function offline_pages()
> in mm/memory_hotplug.c for details.
>
> it first holds cpu_hoplug_lock by calling mem_hotplug_begin(),
> and notifies memory_chain. (so slab_mem_going_offline_callback is
> called.)
>
> I think this patch will make another possible deadlock scenario.
>
> in memory hotplugging: cpu_hotplug_lock -> slab_mutex -> cpu_hotplug_lock
> in slab cache destroying: slab_mutex -> cpu_hotplug_lock
Now I understand why cpus_read_lock() was called in kmem_cache_destroy().
I have to think about fixing it in a better way.

Thanks for the review.

>
> Thanks!,
> Hyeonggon.
>
> >               __kmem_cache_do_shrink(s);
> >       }
> >       mutex_unlock(&slab_mutex);
> > --
> > 2.27.0
> >
> >
