Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB56159BF33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiHVMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiHVMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:03:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775EECE09
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:03:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E20CB34506;
        Mon, 22 Aug 2022 12:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661169813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6GGe1B1GcDSiVUcTHVHFJ2yjgqtF8csatDB5bOHinE=;
        b=deOW83m0Kc3UdTqvUwVAJx0rOjSGlq4gLtF8eDIyyTRcnTESuFVc6JpaAsykMH8R0DKbne
        5LZGP1x1Q3KjitVlE9B+SyD56Rv7FXBcnX7zfTDay6HPjBYKkx0e5YjFf9CRgSECADPVdc
        L/2QTHerj/nu4oVI0x+iqHroSuuj6+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661169813;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6GGe1B1GcDSiVUcTHVHFJ2yjgqtF8csatDB5bOHinE=;
        b=0jzeqjBx2hbiawBNHDbMgby4rWkjRuR/OuN+2I7XB2PYOrO7aEJjITH4xnXtx4jYlZyk+o
        SfbwDSU1i/DEeOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B138C13523;
        Mon, 22 Aug 2022 12:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +raXKpVwA2P1PgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 22 Aug 2022 12:03:33 +0000
Message-ID: <ac08e3f6-f167-2382-5266-959e7339c04a@suse.cz>
Date:   Mon, 22 Aug 2022 14:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] mm/slab_common: Deleting kobject in kmem_cache_destroy()
 without holding slab_mutex/cpu_hotplug_lock
To:     Waiman Long <longman@redhat.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Xin Long <lucien.xin@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220809205901.76595-1-longman@redhat.com>
 <48b66d90-34ae-8666-d9ee-2d36c82a6653@suse.cz>
 <34d80543-322f-9c76-ad7d-d7c734163fa0@redhat.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <34d80543-322f-9c76-ad7d-d7c734163fa0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 16:08, Waiman Long wrote:
> On 8/10/22 05:34, Vlastimil Babka wrote:
>> On 8/9/22 22:59, Waiman Long wrote:
>>> A circular locking problem is reported by lockdep due to the following
>>> circular locking dependency.
>>>
>>>    +--> cpu_hotplug_lock --> slab_mutex --> kn->active#126 --+
>>>    |                                                         |
>>>    +---------------------------------------------------------+
>>
>> This sounded familiar and I've found a thread from January:
>>
>> https://lore.kernel.org/all/388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com/
>>
>> But that seemed to be specific to RHEL-8 RT kernel and not reproduced with
>> mainline. Is it different this time? Can you share the splats?
> 
> I think this is easier to reproduce on a RT kernel, but it also happens in a
> non-RT kernel. One example splat that I got was
> 
> [ 1777.114757] ======================================================
> [ 1777.121646] WARNING: possible circular locking dependency detected
> [ 1777.128544] 4.18.0-403.el8.x86_64+debug #1 Not tainted
> [ 1777.134280] ------------------------------------------------------

Yeah that's non-RT, but still 4.18 kernel, as in Xin Long's thread
referenced above. That wasn't reproducible in current mainline and I would
expect yours also isn't, because it would be reported by others too.

Also in both cases the lockdep (in 4.18) seems to have issue with
cpus_read_lock() which is a rwsem taken for read, so not really exclusive in
order to cause the reported deadlock.

So I suspected lockdep was improved since 4.18 to not report a false
positive, but we never confirmed.

So I'm still not convinced mainline needs any fix right now, but I'll check
the v3 anyway in case it simplifies things wrt the kernfs locking, which
does complicate stuff in any case.

> [ 1777.141176] slub_cpu_partia/4113 is trying to acquire lock:
> [ 1777.147395] ffffffffaef95b20 (cpu_hotplug_lock){++++}-{0:0}, at:
> cpu_partial_store+0x47/0xa0
> [ 1777.156837]
>                but task is already holding lock:
> [ 1777.163346] ffff88811bd17578 (kn->count#126){++++}-{0:0}, at:
> kernfs_fop_write+0x1d0/0x410
> [ 1777.172591]
>                which lock already depends on the new lock.
> 
> [ 1777.181718]
>                the existing dependency chain (in reverse order) is:
> [ 1777.190070]
>                -> #2 (kn->count#126){++++}-{0:0}:
> [ 1777.196688]        lock_acquire+0x1db/0x8e0
> [ 1777.201360]        __kernfs_remove+0x617/0x800
> [ 1777.206320]        kernfs_remove+0x1d/0x30
> [ 1777.210891]        kobject_del+0x8e/0x150
> [ 1777.215360]        kmem_cache_destroy+0x10d/0x130
> [ 1777.220615]        bioset_exit+0x1e3/0x2c0
> [ 1777.225189]        blk_release_queue+0x20d/0x310
> [ 1777.230336]        kobject_release+0x105/0x390
> [ 1777.235296] scsi_device_dev_release_usercontext+0x5e3/0xd60
> [ 1777.242198]        execute_in_process_context+0x27/0x130
> [ 1777.248131]        device_release+0xa1/0x210
> [ 1777.252899]        kobject_release+0x105/0x390
> [ 1777.257857]        scsi_alloc_sdev+0xa1e/0xc80
> [ 1777.262820]        scsi_probe_and_add_lun+0x809/0x2da0
> [ 1777.268557]        __scsi_scan_target+0x1c1/0xb60
> [ 1777.273801]        scsi_scan_channel+0xe2/0x150
> [ 1777.278855]        scsi_scan_host_selected+0x1fb/0x2a0
> [ 1777.284590]        do_scan_async+0x3e/0x440
> [ 1777.289258]        async_run_entry_fn+0xd8/0x660
> [ 1777.294413]        process_one_work+0x919/0x17c0
> [ 1777.299568]        worker_thread+0x87/0xb40
> [ 1777.304227]        kthread+0x30d/0x3c0
> [ 1777.308411]        ret_from_fork+0x3a/0x50
> [ 1777.312984]
>                -> #1 (slab_mutex){+.+.}-{3:3}:
> [ 1777.319309]        lock_acquire+0x1db/0x8e0
> [ 1777.323978]        __mutex_lock+0x154/0x15d0
> [ 1777.328745]        kmem_cache_destroy+0x3f/0x130
> [ 1777.333898]        bioset_exit+0x1e3/0x2c0
> [ 1777.338469]        blk_release_queue+0x20d/0x310
> [ 1777.343623]        kobject_release+0x105/0x390
> [ 1777.348582] scsi_device_dev_release_usercontext+0x5e3/0xd60
> [ 1777.355481]        execute_in_process_context+0x27/0x130
> [ 1777.361409]        device_release+0xa1/0x210
> [ 1777.366175]        kobject_release+0x105/0x390
> [ 1777.371135]        scsi_alloc_sdev+0xa1e/0xc80
> [ 1777.376096]        scsi_probe_and_add_lun+0x809/0x2da0
> [ 1777.381824]        __scsi_scan_target+0x1c1/0xb60
> [ 1777.387073]        scsi_scan_channel+0xe2/0x150
> [ 1777.392128]        scsi_scan_host_selected+0x1fb/0x2a0
> [ 1777.397864]        do_scan_async+0x3e/0x440
> [ 1777.402533]        async_run_entry_fn+0xd8/0x660
> [ 1777.407688]        process_one_work+0x919/0x17c0
> [ 1777.412841]        worker_thread+0x87/0xb40
> [ 1777.417509]        kthread+0x30d/0x3c0
> [ 1777.421693]        ret_from_fork+0x3a/0x50
> [ 1777.426263]
>                -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> [ 1777.433168]        check_prevs_add+0x3fa/0x18b0
> [ 1777.438226]        __lock_acquire+0x21b3/0x2b80
> [ 1777.443273]        lock_acquire+0x1db/0x8e0
> [ 1777.447940]        cpus_read_lock+0x40/0xc0
> [ 1777.452611]        cpu_partial_store+0x47/0xa0
> [ 1777.457571]        slab_attr_store+0x20/0x30
> [ 1777.462338]        kernfs_fop_write+0x255/0x410
> [ 1777.467394]        vfs_write+0x157/0x460
> [ 1777.471777]        ksys_write+0xb8/0x170
> [ 1777.476155]        do_syscall_64+0xa5/0x450
> [ 1777.480828]        entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> [ 1777.487041]
>                other info that might help us debug this:
> 
> [ 1777.495975] Chain exists of:
>                  cpu_hotplug_lock --> slab_mutex --> kn->count#126
> 
> [ 1777.507443]  Possible unsafe locking scenario:
> 
> [ 1777.514049]        CPU0                    CPU1
> [ 1777.519102]        ----                    ----
> [ 1777.524155]   lock(kn->count#126);
> [ 1777.527956]                                lock(slab_mutex);
> [ 1777.534274] lock(kn->count#126);
> [ 1777.540885]   lock(cpu_hotplug_lock);
> [ 1777.544964]
>                 *** DEADLOCK ***
> 
> [ 1777.551570] 3 locks held by slub_cpu_partia/4113:
> [ 1777.556820]  #0: ffff8881319884d0 (sb_writers#4){.+.+}-{0:0}, at:
> vfs_write+0x31c/0x460
> [ 1777.565771]  #1: ffff888161d39490 (&of->mutex){+.+.}-{3:3}, at:
> kernfs_fop_write+0x1ad/0x410
> [ 1777.575203]  #2: ffff88811bd17578 (kn->count#126){++++}-{0:0}, at:
> kernfs_fop_write+0x1d0/0x410
> [ 1777.584928]
>                stack backtrace:
> [ 1777.589792] CPU: 65 PID: 4113 Comm: slub_cpu_partia Kdump: loaded Not
> tainted 4.18.0-403.el8.x86_64+debug #1
> [ 1777.600767] Hardware name: Lenovo ThinkSystem SR635 -[7Y98XXXXXX]-/System
> Board, BIOS CFE103A 07/04/2019
> [ 1777.611342] Call Trace:
> [ 1777.614072]  dump_stack+0x5c/0x80
> [ 1777.617777]  check_noncircular+0x27f/0x320
> [ 1777.622352]  ? print_circular_bug+0x440/0x440
> [ 1777.627215]  ? kernel_text_address+0x125/0x140
> [ 1777.632170]  ? mark_lock.part.31+0xf4/0xd40
> [ 1777.636841]  ? is_dynamic_key+0x220/0x220
> [ 1777.641326]  check_prevs_add+0x3fa/0x18b0
> [ 1777.645798]  ? sched_clock+0x5/0x10
> [ 1777.649695]  ? sched_clock_cpu+0x18/0x1e0
> [ 1777.654175]  ? check_irq_usage+0xa20/0xa20
> [ 1777.658750]  ? find_held_lock+0x1c0/0x1c0
> [ 1777.663225]  ? sched_clock_cpu+0x18/0x1e0
> [ 1777.667705]  __lock_acquire+0x21b3/0x2b80
> [ 1777.672192]  lock_acquire+0x1db/0x8e0
> [ 1777.676279]  ? cpu_partial_store+0x47/0xa0
> [ 1777.680854]  ? rcu_read_unlock+0x50/0x50
> [ 1777.685239]  ? sysfs_file_ops+0x160/0x160
> [ 1777.689718]  cpus_read_lock+0x40/0xc0
> [ 1777.693806]  ? cpu_partial_store+0x47/0xa0
> [ 1777.698380]  cpu_partial_store+0x47/0xa0
> [ 1777.702761]  slab_attr_store+0x20/0x30
> [ 1777.706944]  kernfs_fop_write+0x255/0x410
> [ 1777.711424]  vfs_write+0x157/0x460
> [ 1777.715224]  ksys_write+0xb8/0x170
> [ 1777.719023]  ? __ia32_sys_read+0xb0/0xb0
> [ 1777.723406]  ? lockdep_hardirqs_on_prepare+0x294/0x3e0
> [ 1777.729144]  ? do_syscall_64+0x22/0x450
> [ 1777.733429]  do_syscall_64+0xa5/0x450
> [ 1777.737518]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> [ 1777.743159] RIP: 0033:0x7f4fe9b2ead8
> [ 1777.747153] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00
> f3 0f 1e fa 48 8d 05 45 4c 2a 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48>
> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
> [ 1777.768112] RSP: 002b:00007ffcc2173d48 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 1777.776565] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
> 00007f4fe9b2ead8
> [ 1777.784530] RDX: 0000000000000002 RSI: 000055d41293eb70 RDI:
> 0000000000000001
> [ 1777.792495] RBP: 000055d41293eb70 R08: 000000000000000a R09:
> 0000000000000003
> [ 1777.800459] R10: 000000000000000a R11: 0000000000000246 R12:
> 00007f4fe9dcf6e0
> [ 1777.808425] R13: 0000000000000002 R14: 00007f4fe9dca860 R15:
> 0000000000000002
> 
> The cpu_partial_store() method call flush_all() which takes the
> cpu_hotplug_lock completing the cycle.
> 
> Cheers,
> Longman
> 

