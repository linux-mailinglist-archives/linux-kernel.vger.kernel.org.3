Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8AD48FB31
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 07:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiAPGfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 01:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiAPGfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 01:35:24 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C04C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 22:35:24 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e8so3399132plh.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 22:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zne7mnhvAzDFNuFH1mp9mOfxLAxrjEZQOMQAG7PSICA=;
        b=LKbv4aCfd6hCRCI7sCN7X1QxxjG7Y/Xtf8t5L+GbkW20xGdymPDFgcevArXTXQkfiV
         P/4Q4609SjQiJtW3EwMUGncMc3Qp9LZMsxKbP/49nFeRAQeQDH/MN3oP1lhX/cjQWL3q
         rI2c3PJ52l0RDVkZjdxu0N2rKdd2/bgomWv3fTsQHxtWEyjIUktNShoWAqYgE3trsCai
         SfE3Fha0Bq9xTl/yzj2wK9Jgw+CUOynivlZsaoc+cFzJsuXtROPGp6iuCSUAGIdQ+eBr
         7FtlV8q95WgZ39y1SvxdhLx/rBaNdcVxCci5rpNNw+VIS1BqG6aWjkVVZwaCkSzDakyG
         9+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zne7mnhvAzDFNuFH1mp9mOfxLAxrjEZQOMQAG7PSICA=;
        b=z/dJ1FQilLZ0Dqc5LQ9VKgY2EZ5K6V7IMqqyPvr4oleweclTqEw9FwReQX9U0Q8XLR
         j6Oc9ZuRFbNiFF/WW6n+SbjcIl6hioClVDjhyHDrHgZ4A6+nN72ICLIBsjsduJBo2fva
         Vj7o/6Srdbh32Gc8RCJ5lsjMt87RBbz5leJHZaOGSZ9HezlVar4IMvprvVBV6f/OVEjM
         xgddFCCasuWxT979fNA6hN9L6VG9aoBEZ1LiOmdif7NCuhtud7Dcf68BiQaJUb85xPx+
         IdRzjlB4kN9BPMAfBmam4HAm+6mQv7tIXLMibtcOc+xvle417KYlWBF+G6upnBDbpEXh
         1ZuQ==
X-Gm-Message-State: AOAM532Z67vt9jefzE5yqvq//YNQH3BhIJQLTrU+C8S00gT8hfcvefjE
        Q1sJO6XfuAHEvQ87aB/eDS4=
X-Google-Smtp-Source: ABdhPJw8Jsr/BKO3pjb5WfWQRsBtl4xDOXq9GUwZZMPtJzLmYMZjYdn7Ko0NBDzhiEbOc4vg+FOT3g==
X-Received: by 2002:a17:902:f54e:b0:14a:59b4:8849 with SMTP id h14-20020a170902f54e00b0014a59b48849mr17117398plf.90.1642314923432;
        Sat, 15 Jan 2022 22:35:23 -0800 (PST)
Received: from ip-172-31-30-232.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id bf5sm11738796pjb.52.2022.01.15.22.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 22:35:22 -0800 (PST)
Date:   Sun, 16 Jan 2022 06:35:17 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH] mm: slub: fix a deadlock warning in kmem_cache_destroy
Message-ID: <YeO8pcs866Iu2iJX@ip-172-31-30-232.ap-northeast-1.compute.internal>
References: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 09:23:16AM -0500, Xin Long wrote:
> cpus_read_lock() is introduced into kmem_cache_destroy() by
> commit 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations
> __free_slab() invocations out of IRQ context"), and it could cause
> a deadlock.
> 
> As Antoine pointed out, when one thread calls kmem_cache_destroy(), it is
> blocking until kn->active becomes 0 in kernfs_drain() after holding
> cpu_hotplug_lock. While in another thread, when calling kernfs_fop_write(),
> it may try to hold cpu_hotplug_lock after incrementing kn->active by
> calling kernfs_get_active():
>

Hello. can you give me a link of related the thread?

>         CPU0                        CPU1
>         ----                        ----
>   cpus_read_lock()
>                                    kn->active++
>                                    cpus_read_lock() [a]
>   wait until kn->active == 0
> 
> Although cpu_hotplug_lock is a RWSEM, [a] will not block in there. But as
> lockdep annotations are added for cpu_hotplug_lock, a deadlock warning
> would be detected:
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   ------------------------------------------------------
>   dmsetup/1832 is trying to acquire lock:
>   ffff986f5a0f9f20 (kn->count#144){++++}-{0:0}, at: kernfs_remove+0x1d/0x30
> 
>   but task is already holding lock:
>   ffffffffa43817c0 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_destroy+0x2a/0x120
> 
>   which lock already depends on the new lock.
> 
>   the existing dependency chain (in reverse order) is:
> 
>   -> #2 (slab_mutex){+.+.}-{3:3}:
>          lock_acquire+0xe8/0x470
>          mutex_lock_nested+0x47/0x80
>          kmem_cache_destroy+0x2a/0x120
>          bioset_exit+0xb5/0x100
>          cleanup_mapped_device+0x26/0xf0 [dm_mod]
>          free_dev+0x43/0xb0 [dm_mod]
>          __dm_destroy+0x153/0x1b0 [dm_mod]
>          dev_remove+0xe4/0x1a0 [dm_mod]
>          ctl_ioctl+0x1af/0x3f0 [dm_mod]
>          dm_ctl_ioctl+0xa/0x10 [dm_mod]
>          do_vfs_ioctl+0xa5/0x760
>          ksys_ioctl+0x60/0x90
>          __x64_sys_ioctl+0x16/0x20
>          do_syscall_64+0x8c/0x240
>          entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> 
>   -> #1 (cpu_hotplug_lock){++++}-{0:0}:
>          lock_acquire+0xe8/0x470
>          cpus_read_lock+0x39/0x100
>          cpu_partial_store+0x44/0x80
>          slab_attr_store+0x20/0x30
>          kernfs_fop_write+0x101/0x1b0
>          vfs_write+0xd4/0x1e0
>          ksys_write+0x52/0xc0
>          do_syscall_64+0x8c/0x240
>          entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> 
>   -> #0 (kn->count#144){++++}-{0:0}:
>          check_prevs_add+0x185/0xb80
>          __lock_acquire+0xd8f/0xe90
>          lock_acquire+0xe8/0x470
>          __kernfs_remove+0x25e/0x320
>          kernfs_remove+0x1d/0x30
>          kobject_del+0x28/0x60
>          kmem_cache_destroy+0xf1/0x120
>          bioset_exit+0xb5/0x100
>          cleanup_mapped_device+0x26/0xf0 [dm_mod]
>          free_dev+0x43/0xb0 [dm_mod]
>          __dm_destroy+0x153/0x1b0 [dm_mod]
>          dev_remove+0xe4/0x1a0 [dm_mod]
>          ctl_ioctl+0x1af/0x3f0 [dm_mod]
>          dm_ctl_ioctl+0xa/0x10 [dm_mod]
>          do_vfs_ioctl+0xa5/0x760
>          ksys_ioctl+0x60/0x90
>          __x64_sys_ioctl+0x16/0x20
>          do_syscall_64+0x8c/0x240
>          entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> 
>   other info that might help us debug this:
> 
>   Chain exists of:
>     kn->count#144 --> cpu_hotplug_lock --> slab_mutex
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(slab_mutex);
>                                  lock(cpu_hotplug_lock);
>                                  lock(slab_mutex);
>     lock(kn->count#144);
> 
>    *** DEADLOCK ***
> 
>   3 locks held by dmsetup/1832:
>    #0: ffffffffa43fe5c0 (bio_slab_lock){+.+.}-{3:3}, at: bioset_exit+0x62/0x100
>    #1: ffffffffa3e87c20 (cpu_hotplug_lock){++++}-{0:0}, at: kmem_cache_destroy+0x1c/0x120
>    #2: ffffffffa43817c0 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_destroy+0x2a/0x120
> 
>   stack backtrace:
>   Call Trace:
>    dump_stack+0x5c/0x80
>    check_noncircular+0xff/0x120
>    check_prevs_add+0x185/0xb80
>    __lock_acquire+0xd8f/0xe90
>    lock_acquire+0xe8/0x470
>    __kernfs_remove+0x25e/0x320
>    kernfs_remove+0x1d/0x30
>    kobject_del+0x28/0x60
>    kmem_cache_destroy+0xf1/0x120
>    bioset_exit+0xb5/0x100
>    cleanup_mapped_device+0x26/0xf0 [dm_mod]
>    free_dev+0x43/0xb0 [dm_mod]
>    __dm_destroy+0x153/0x1b0 [dm_mod]
>    dev_remove+0xe4/0x1a0 [dm_mod]
>    ctl_ioctl+0x1af/0x3f0 [dm_mod]
>    dm_ctl_ioctl+0xa/0x10 [dm_mod]
>    do_vfs_ioctl+0xa5/0x760
>    ksys_ioctl+0x60/0x90
>    __x64_sys_ioctl+0x16/0x20
>    do_syscall_64+0x8c/0x240
>    entry_SYSCALL_64_after_hwframe+0x6a/0xdf
>

To summary the possible scenario is:

- when cache is destroyed:
	cpu_hotplug_lock
	-> slab_mutex 
	-> wait until kn->count == 0 (because it removes sysfs objects.)

- when someone writes to cpu_partial attribute:
	increase kn->count (incrased in kernfs_fop_write_iter(),
	using kernfs_get_active() )
	-> cpu_hotplug_lock
	-> slab_mutex

... So there is a circular dependency when using kernfs because
clearing sysfs stuff in kernfs  makes unexpected dependency. Right?

I think it's quite unlikely but yeah, seems possible.

> Since cpus_read_lock() is supposed to protect the cpu related data, it
> makes sense to fix this issue by moving cpus_read_lock() from
> kmem_cache_destroy() to __kmem_cache_shutdown(). While at it,
> add the missing cpus_read_lock() in slab_mem_going_offline_callback().
> 
> Fixes: 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations __free_slab() invocations out of IRQ context")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  mm/slab_common.c | 2 --
>  mm/slub.c        | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e5d080a93009..06ec3fa585e6 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -494,7 +494,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (unlikely(!s))
>  		return;
>  
> -	cpus_read_lock();
>  	mutex_lock(&slab_mutex);
>  
>  	s->refcount--;
> @@ -509,7 +508,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	}
>  out_unlock:
>  	mutex_unlock(&slab_mutex);
> -	cpus_read_unlock();
>  }

This code is changing lock order
from cpu_hotplug_lock -> slab_muitex
to slab_mutex -> cpu_hotplug_lock.

>  EXPORT_SYMBOL(kmem_cache_destroy);
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index abe7db581d68..754f020235ee 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4311,7 +4311,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>  	int node;
>  	struct kmem_cache_node *n;
>  
> -	flush_all_cpus_locked(s);
> +	flush_all(s);
>  	/* Attempt to free all objects */
>  	for_each_kmem_cache_node(s, node, n) {
>  		free_partial(s, n);
> @@ -4646,7 +4646,7 @@ static int slab_mem_going_offline_callback(void *arg)
>  
>  	mutex_lock(&slab_mutex);
>  	list_for_each_entry(s, &slab_caches, list) {
> -		flush_all_cpus_locked(s);
> +		flush_all(s);

In My Opinion, this code is wrong. Because it's called when memory
offlining with cpu_hotplug_lock held. See function offline_pages()
in mm/memory_hotplug.c for details.

it first holds cpu_hoplug_lock by calling mem_hotplug_begin(),
and notifies memory_chain. (so slab_mem_going_offline_callback is
called.)

I think this patch will make another possible deadlock scenario.

in memory hotplugging: cpu_hotplug_lock -> slab_mutex -> cpu_hotplug_lock
in slab cache destroying: slab_mutex -> cpu_hotplug_lock

Thanks!,
Hyeonggon.

>  		__kmem_cache_do_shrink(s);
>  	}
>  	mutex_unlock(&slab_mutex);
> -- 
> 2.27.0
> 
> 
