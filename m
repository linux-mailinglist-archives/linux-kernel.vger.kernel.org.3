Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98959C0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiHVNr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiHVNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:46:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C4E31DC2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:46:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x23so9961938pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=VM1LOnfvG6lRye3k9GzMe4BVO/yQlLzRyWScu+FkURY=;
        b=QXFfnLmeZXSqG03B54twCsq5akj/c8JDncdjiD4zQ7etZ0T9KsvOR1S7aYLuHdQfV9
         yLPNvtKQF3760ale5O6k2UU1ytxwcg1SARWu7blaYGvAJ3yPMVkwPtdWoxIdhKN/Nj+8
         CH3Vy9i+PN3R6wW0qYpnL4S59DZH+O0tKJlz/5hlGNErm/B6q+HMWXmAbhgYqern/ID1
         tCmnojM1Nn4slOGvQk+p/rh5WHrGbrukU+11GVV90kOolGYRb+GDcYO1aTe+subHJdl1
         J6Ws4VRoTyac6VlniFwBY6kVrXQZ/YzIO90B5yF+6zMRwgldQpyg9YdwgHKvXPQ1kzIx
         dsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=VM1LOnfvG6lRye3k9GzMe4BVO/yQlLzRyWScu+FkURY=;
        b=ohq46zGU/V0HnlKWCMBB+oyWZb5cOeHLcVvVWThXkn1l7aOM2kf+d+7ZPjbfIy/oct
         6is4vCtwuR7pH1MZ2/+ziCQQ/1DsxYNRwFd7ZmjBuiBLyb4yWmxMUGuJcFNTCzA68bQd
         wTD5eK+Z0clVYKgtiAnLStqbNC/bJ3OX/hPGawK/Jls/MEFNAVwof10a2lcKQo0vMJfK
         /ryXgrGhjnB/lDbhjIxTEngYYtR7PXtKsJLyIrB5qatsHzLHubYNP6Wssracaybr9Wlz
         P26CkO/NF6woJBByXaDg9trADS1jC94AKYSC57XD2MH4qFCvUQGpJT5e84VC9VW8EIzp
         cUeg==
X-Gm-Message-State: ACgBeo0GgBSORbES81sITY10ydUKwJBICnQ3/S3ne5q2okcwFQPTRS/d
        PIgnu3Ocl52cwhfaGP8xI/k=
X-Google-Smtp-Source: AA6agR4VHYcU1AMDSG0zQmGzOsMBQAMX9s+oPEL1S4/zxG1ppXNYCkj8O6NfRqSGab1I0shu3sRISA==
X-Received: by 2002:a17:902:eb43:b0:172:cd04:a3c9 with SMTP id i3-20020a170902eb4300b00172cd04a3c9mr12372219pli.111.1661175968099;
        Mon, 22 Aug 2022 06:46:08 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902d2d200b001713af9e85dsm1721510plc.180.2022.08.22.06.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 06:46:06 -0700 (PDT)
Date:   Mon, 22 Aug 2022 22:46:01 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Waiman Long <longman@redhat.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Xin Long <lucien.xin@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab_common: Deleting kobject in kmem_cache_destroy()
 without holding slab_mutex/cpu_hotplug_lock
Message-ID: <YwOImVd+nRUsSAga@hyeyoo>
References: <20220809205901.76595-1-longman@redhat.com>
 <48b66d90-34ae-8666-d9ee-2d36c82a6653@suse.cz>
 <34d80543-322f-9c76-ad7d-d7c734163fa0@redhat.com>
 <ac08e3f6-f167-2382-5266-959e7339c04a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac08e3f6-f167-2382-5266-959e7339c04a@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 02:03:33PM +0200, Vlastimil Babka wrote:
> On 8/10/22 16:08, Waiman Long wrote:
> > On 8/10/22 05:34, Vlastimil Babka wrote:
> >> On 8/9/22 22:59, Waiman Long wrote:
> >>> A circular locking problem is reported by lockdep due to the following
> >>> circular locking dependency.
> >>>
> >>>    +--> cpu_hotplug_lock --> slab_mutex --> kn->active#126 --+
> >>>    |                                                         |
> >>>    +---------------------------------------------------------+
> >>
> >> This sounded familiar and I've found a thread from January:
> >>
> >> https://lore.kernel.org/all/388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com/
> >>
> >> But that seemed to be specific to RHEL-8 RT kernel and not reproduced with
> >> mainline. Is it different this time? Can you share the splats?
> > 
> > I think this is easier to reproduce on a RT kernel, but it also happens in a
> > non-RT kernel. One example splat that I got was
> > 
> > [ 1777.114757] ======================================================
> > [ 1777.121646] WARNING: possible circular locking dependency detected
> > [ 1777.128544] 4.18.0-403.el8.x86_64+debug #1 Not tainted
> > [ 1777.134280] ------------------------------------------------------
> 
> Yeah that's non-RT, but still 4.18 kernel, as in Xin Long's thread
> referenced above. That wasn't reproducible in current mainline and I would
> expect yours also isn't, because it would be reported by others too.

I can confirm this splat is reproducible on 6.0-rc1 when conditions below are met:
	1) Lockdep is enabled
	2) kmem_cache_destroy() is executed at least once (e.g. loading slub_kunit module)
	3) flush_all() is executed at least once (e.g. writing to /sys/kernel/<slab>/cpu_partial)

[   51.408901] ======================================================
[   51.409925] WARNING: possible circular locking dependency detected
[   51.410940] 6.0.0-rc1+ #1554 Tainted: G    B            N
[   51.411845] ------------------------------------------------------
[   51.412855] sh/578 is trying to acquire lock:
[   51.413578] ffffffff8307d890 (cpu_hotplug_lock){++++}-{0:0}, at: cpu_partial_store+0x56/0xa0
[   51.414948] 
[   51.414948] but task is already holding lock:
[   51.415908] ffff888103166740 (kn->active#43){++++}-{0:0}, at: kernfs_fop_write_iter+0x118/0x210
[   51.417270] 
[   51.417270] which lock already depends on the new lock.
[   51.417270] 
[   51.417825] 
[   51.417825] the existing dependency chain (in reverse order) is:
[   51.418336] 
[   51.418336] -> #2 (kn->active#43){++++}-{0:0}:
[   51.418744]        __kernfs_remove+0x2fe/0x3b0
[   51.419054]        kernfs_remove+0x36/0x50
[   51.419337]        __kobject_del+0x2e/0xd0
[   51.419622]        kobject_del+0xf/0x20
[   51.419912]        kmem_cache_destroy+0xd8/0x110
[   51.420273]        test_exit+0x1a/0x30
[   51.420570]        kunit_try_run_case+0x65/0x80
[   51.420926]        kunit_generic_run_threadfn_adapter+0x16/0x30
[   51.421391]        kthread+0xf2/0x120
[   51.421699]        ret_from_fork+0x22/0x30
[   51.422042] 
[   51.422042] -> #1 (slab_mutex){+.+.}-{3:3}:
[   51.422513]        __mutex_lock+0xa5/0x9a0
[   51.422858]        kmem_cache_destroy+0x26/0x110
[   51.423241]        test_exit+0x1a/0x30
[   51.423557]        kunit_try_run_case+0x65/0x80
[   51.423938]        kunit_generic_run_threadfn_adapter+0x16/0x30
[   51.424432]        kthread+0xf2/0x120
[   51.424739]        ret_from_fork+0x22/0x30
[   51.425080] 
[   51.425080] -> #0 (cpu_hotplug_lock){++++}-{0:0}:
[   51.425593]        __lock_acquire+0x1122/0x1dd0
[   51.425971]        lock_acquire+0xd5/0x300
[   51.426312]        cpus_read_lock+0x3c/0xd0
[   51.426660]        cpu_partial_store+0x56/0xa0
[   51.427030]        slab_attr_store+0x20/0x40
[   51.427388]        kernfs_fop_write_iter+0x15b/0x210
[   51.427798]        vfs_write+0x346/0x4c0
[   51.428128]        ksys_write+0x65/0xf0
[   51.428457]        do_syscall_64+0x5c/0x90
[   51.428801]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   51.429262] 
[   51.429262] other info that might help us debug this:
[   51.429262] 
[   51.429918] Chain exists of:
[   51.429918]   cpu_hotplug_lock --> slab_mutex --> kn->active#43
[   51.429918] 
[   51.430763]  Possible unsafe locking scenario:
[   51.430763] 
[   51.431251]        CPU0                    CPU1
[   51.431629]        ----                    ----
[   51.432008]   lock(kn->active#43);
[   51.432293]                                lock(slab_mutex);
[   51.432754]                                lock(kn->active#43);
[   51.433219]   lock(cpu_hotplug_lock);
[   51.433508] 
[   51.433508]  *** DEADLOCK ***
[   51.433508] 
[   51.433963] 3 locks held by sh/578:
[   51.434224]  #0: ffff88811a982460 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x65/0xf0
[   51.434800]  #1: ffff88811a8ea888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x110/0x210
[   51.435478]  #2: ffff888103166740 (kn->active#43){++++}-{0:0}, at: kernfs_fop_write_iter+0x118/0x0
[   51.436174] 
[   51.436174] stack backtrace:
[   51.436539] CPU: 4 PID: 578 Comm: sh Tainted: G    B            N 6.0.0-rc1+ #1554
[   51.437130] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[   51.437803] Call Trace:
[   51.438008]  <TASK>
[   51.438187]  dump_stack_lvl+0x56/0x73
[   51.438493]  check_noncircular+0x102/0x120
[   51.438831]  __lock_acquire+0x1122/0x1dd0
[   51.439162]  lock_acquire+0xd5/0x300
[   51.439444]  ? cpu_partial_store+0x56/0xa0
[   51.439773]  cpus_read_lock+0x3c/0xd0
[   51.440063]  ? cpu_partial_store+0x56/0xa0
[   51.440402]  cpu_partial_store+0x56/0xa0
[   51.440730]  slab_attr_store+0x20/0x40
[   51.441039]  kernfs_fop_write_iter+0x15b/0x210
[   51.441387]  vfs_write+0x346/0x4c0
[   51.441666]  ksys_write+0x65/0xf0
[   51.441942]  do_syscall_64+0x5c/0x90
[   51.442237]  ? asm_exc_page_fault+0x22/0x30
[   51.442578]  ? lockdep_hardirqs_on+0x7d/0x100
[   51.442931]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   51.443359] RIP: 0033:0x7f6428c9415c
[   51.443645] Code: 8b 7c 24 08 89 c5 e8 c5 ff ff ff 89 ef 89 44 24 08 e8 e8 13 03 00 8b 44 24 08 43
[   51.445133] RSP: 002b:00007fff556ee9d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   51.445742] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6428c9415c
[   51.446316] RDX: 0000000000000002 RSI: 000055e65f1c17f0 RDI: 0000000000000001
[   51.446862] RBP: 000055e65f1c17f0 R08: fefefefefefefeff R09: fffffeffffff0000
[   51.447415] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[   51.447994] R13: 00007f6428c79690 R14: 0000000000000001 R15: 00007fff556eea48
[   51.448552]  </TASK>

> Also in both cases the lockdep (in 4.18) seems to have issue with
> cpus_read_lock() which is a rwsem taken for read, so not really exclusive in
> order to cause the reported deadlock.

Agreed.

> So I suspected lockdep was improved since 4.18 to not report a false
> positive, but we never confirmed.

Seems not improved as it reports on 6.0-rc1.
May fix lockdep instead of fixing SLUB?

> So I'm still not convinced mainline needs any fix right now, but I'll check
> the v3 anyway in case it simplifies things wrt the kernfs locking, which
> does complicate stuff in any case.
> 
> > [ 1777.141176] slub_cpu_partia/4113 is trying to acquire lock:
> > [ 1777.147395] ffffffffaef95b20 (cpu_hotplug_lock){++++}-{0:0}, at:
> > cpu_partial_store+0x47/0xa0
> > [ 1777.156837]
> >                but task is already holding lock:
> > [ 1777.163346] ffff88811bd17578 (kn->count#126){++++}-{0:0}, at:
> > kernfs_fop_write+0x1d0/0x410
> > [ 1777.172591]
> >                which lock already depends on the new lock.
> > 
> > [ 1777.181718]
> >                the existing dependency chain (in reverse order) is:
> > [ 1777.190070]
> >                -> #2 (kn->count#126){++++}-{0:0}:
> > [ 1777.196688]        lock_acquire+0x1db/0x8e0
> > [ 1777.201360]        __kernfs_remove+0x617/0x800
> > [ 1777.206320]        kernfs_remove+0x1d/0x30
> > [ 1777.210891]        kobject_del+0x8e/0x150
> > [ 1777.215360]        kmem_cache_destroy+0x10d/0x130
> > [ 1777.220615]        bioset_exit+0x1e3/0x2c0
> > [ 1777.225189]        blk_release_queue+0x20d/0x310
> > [ 1777.230336]        kobject_release+0x105/0x390
> > [ 1777.235296] scsi_device_dev_release_usercontext+0x5e3/0xd60
> > [ 1777.242198]        execute_in_process_context+0x27/0x130
> > [ 1777.248131]        device_release+0xa1/0x210
> > [ 1777.252899]        kobject_release+0x105/0x390
> > [ 1777.257857]        scsi_alloc_sdev+0xa1e/0xc80
> > [ 1777.262820]        scsi_probe_and_add_lun+0x809/0x2da0
> > [ 1777.268557]        __scsi_scan_target+0x1c1/0xb60
> > [ 1777.273801]        scsi_scan_channel+0xe2/0x150
> > [ 1777.278855]        scsi_scan_host_selected+0x1fb/0x2a0
> > [ 1777.284590]        do_scan_async+0x3e/0x440
> > [ 1777.289258]        async_run_entry_fn+0xd8/0x660
> > [ 1777.294413]        process_one_work+0x919/0x17c0
> > [ 1777.299568]        worker_thread+0x87/0xb40
> > [ 1777.304227]        kthread+0x30d/0x3c0
> > [ 1777.308411]        ret_from_fork+0x3a/0x50
> > [ 1777.312984]
> >                -> #1 (slab_mutex){+.+.}-{3:3}:
> > [ 1777.319309]        lock_acquire+0x1db/0x8e0
> > [ 1777.323978]        __mutex_lock+0x154/0x15d0
> > [ 1777.328745]        kmem_cache_destroy+0x3f/0x130
> > [ 1777.333898]        bioset_exit+0x1e3/0x2c0
> > [ 1777.338469]        blk_release_queue+0x20d/0x310
> > [ 1777.343623]        kobject_release+0x105/0x390
> > [ 1777.348582] scsi_device_dev_release_usercontext+0x5e3/0xd60
> > [ 1777.355481]        execute_in_process_context+0x27/0x130
> > [ 1777.361409]        device_release+0xa1/0x210
> > [ 1777.366175]        kobject_release+0x105/0x390
> > [ 1777.371135]        scsi_alloc_sdev+0xa1e/0xc80
> > [ 1777.376096]        scsi_probe_and_add_lun+0x809/0x2da0
> > [ 1777.381824]        __scsi_scan_target+0x1c1/0xb60
> > [ 1777.387073]        scsi_scan_channel+0xe2/0x150
> > [ 1777.392128]        scsi_scan_host_selected+0x1fb/0x2a0
> > [ 1777.397864]        do_scan_async+0x3e/0x440
> > [ 1777.402533]        async_run_entry_fn+0xd8/0x660
> > [ 1777.407688]        process_one_work+0x919/0x17c0
> > [ 1777.412841]        worker_thread+0x87/0xb40
> > [ 1777.417509]        kthread+0x30d/0x3c0
> > [ 1777.421693]        ret_from_fork+0x3a/0x50
> > [ 1777.426263]
> >                -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> > [ 1777.433168]        check_prevs_add+0x3fa/0x18b0
> > [ 1777.438226]        __lock_acquire+0x21b3/0x2b80
> > [ 1777.443273]        lock_acquire+0x1db/0x8e0
> > [ 1777.447940]        cpus_read_lock+0x40/0xc0
> > [ 1777.452611]        cpu_partial_store+0x47/0xa0
> > [ 1777.457571]        slab_attr_store+0x20/0x30
> > [ 1777.462338]        kernfs_fop_write+0x255/0x410
> > [ 1777.467394]        vfs_write+0x157/0x460
> > [ 1777.471777]        ksys_write+0xb8/0x170
> > [ 1777.476155]        do_syscall_64+0xa5/0x450
> > [ 1777.480828]        entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> > [ 1777.487041]
> >                other info that might help us debug this:
> > 
> > [ 1777.495975] Chain exists of:
> >                  cpu_hotplug_lock --> slab_mutex --> kn->count#126
> > 
> > [ 1777.507443]  Possible unsafe locking scenario:
> > 
> > [ 1777.514049]        CPU0                    CPU1
> > [ 1777.519102]        ----                    ----
> > [ 1777.524155]   lock(kn->count#126);
> > [ 1777.527956]                                lock(slab_mutex);
> > [ 1777.534274] lock(kn->count#126);
> > [ 1777.540885]   lock(cpu_hotplug_lock);
> > [ 1777.544964]
> >                 *** DEADLOCK ***
> > 
> > [ 1777.551570] 3 locks held by slub_cpu_partia/4113:
> > [ 1777.556820]  #0: ffff8881319884d0 (sb_writers#4){.+.+}-{0:0}, at:
> > vfs_write+0x31c/0x460
> > [ 1777.565771]  #1: ffff888161d39490 (&of->mutex){+.+.}-{3:3}, at:
> > kernfs_fop_write+0x1ad/0x410
> > [ 1777.575203]  #2: ffff88811bd17578 (kn->count#126){++++}-{0:0}, at:
> > kernfs_fop_write+0x1d0/0x410
> > [ 1777.584928]
> >                stack backtrace:
> > [ 1777.589792] CPU: 65 PID: 4113 Comm: slub_cpu_partia Kdump: loaded Not
> > tainted 4.18.0-403.el8.x86_64+debug #1
> > [ 1777.600767] Hardware name: Lenovo ThinkSystem SR635 -[7Y98XXXXXX]-/System
> > Board, BIOS CFE103A 07/04/2019
> > [ 1777.611342] Call Trace:
> > [ 1777.614072]  dump_stack+0x5c/0x80
> > [ 1777.617777]  check_noncircular+0x27f/0x320
> > [ 1777.622352]  ? print_circular_bug+0x440/0x440
> > [ 1777.627215]  ? kernel_text_address+0x125/0x140
> > [ 1777.632170]  ? mark_lock.part.31+0xf4/0xd40
> > [ 1777.636841]  ? is_dynamic_key+0x220/0x220
> > [ 1777.641326]  check_prevs_add+0x3fa/0x18b0
> > [ 1777.645798]  ? sched_clock+0x5/0x10
> > [ 1777.649695]  ? sched_clock_cpu+0x18/0x1e0
> > [ 1777.654175]  ? check_irq_usage+0xa20/0xa20
> > [ 1777.658750]  ? find_held_lock+0x1c0/0x1c0
> > [ 1777.663225]  ? sched_clock_cpu+0x18/0x1e0
> > [ 1777.667705]  __lock_acquire+0x21b3/0x2b80
> > [ 1777.672192]  lock_acquire+0x1db/0x8e0
> > [ 1777.676279]  ? cpu_partial_store+0x47/0xa0
> > [ 1777.680854]  ? rcu_read_unlock+0x50/0x50
> > [ 1777.685239]  ? sysfs_file_ops+0x160/0x160
> > [ 1777.689718]  cpus_read_lock+0x40/0xc0
> > [ 1777.693806]  ? cpu_partial_store+0x47/0xa0
> > [ 1777.698380]  cpu_partial_store+0x47/0xa0
> > [ 1777.702761]  slab_attr_store+0x20/0x30
> > [ 1777.706944]  kernfs_fop_write+0x255/0x410
> > [ 1777.711424]  vfs_write+0x157/0x460
> > [ 1777.715224]  ksys_write+0xb8/0x170
> > [ 1777.719023]  ? __ia32_sys_read+0xb0/0xb0
> > [ 1777.723406]  ? lockdep_hardirqs_on_prepare+0x294/0x3e0
> > [ 1777.729144]  ? do_syscall_64+0x22/0x450
> > [ 1777.733429]  do_syscall_64+0xa5/0x450
> > [ 1777.737518]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> > [ 1777.743159] RIP: 0033:0x7f4fe9b2ead8
> > [ 1777.747153] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00
> > f3 0f 1e fa 48 8d 05 45 4c 2a 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48>
> > 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
> > [ 1777.768112] RSP: 002b:00007ffcc2173d48 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000001
> > [ 1777.776565] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
> > 00007f4fe9b2ead8
> > [ 1777.784530] RDX: 0000000000000002 RSI: 000055d41293eb70 RDI:
> > 0000000000000001
> > [ 1777.792495] RBP: 000055d41293eb70 R08: 000000000000000a R09:
> > 0000000000000003
> > [ 1777.800459] R10: 000000000000000a R11: 0000000000000246 R12:
> > 00007f4fe9dcf6e0
> > [ 1777.808425] R13: 0000000000000002 R14: 00007f4fe9dca860 R15:
> > 0000000000000002
> > 
> > The cpu_partial_store() method call flush_all() which takes the
> > cpu_hotplug_lock completing the cycle.
> > 
> > Cheers,
> > Longman
> > 
> 

-- 
Thanks,
Hyeonggon
