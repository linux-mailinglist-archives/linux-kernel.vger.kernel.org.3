Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD8C4AB352
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 03:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348620AbiBGCVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 21:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiBGCVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 21:21:04 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1EBC061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 18:21:03 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id bt13so11855052ybb.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 18:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmPjm9NOq3opgjf5KUwCZVh2Aj0cOyox++gkNIUUwuw=;
        b=P8qj1oM7kM5pP+2fdgmKV+xA/ca+sJzdPSw8WFeDsOGMtacQJZFYwsHmpmTgKkg9RA
         y8/U6WzyFLYOUDrmMvvHdl5Pv4PBEDjP+hDjJlUll+En0VPy8MW3q0oNfB+9x79WJK9I
         WmD/PnEQl5CadbotQk0acwLmexu4CK/j0OzowI4BcDksWZ+4M229HjTrnehksauzRaUT
         qx6dVDiMX/kJveDexwCy18nIVSWpKCHOPaE/zddbzm2d8Eekg/zYY32MXOPm2/IR5/LA
         pYDUpYsFm3eTQ55AtiQEagmmC4NFu03up++hgeqasvauXemZOWoLYC204kItsn12RR+B
         v47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmPjm9NOq3opgjf5KUwCZVh2Aj0cOyox++gkNIUUwuw=;
        b=C2awMKcPTfYGTKawpi2qNvxEK1ivsI+aPrdmvQ3RHBw/ljCcv1zpnLxNjyBh8uE/3A
         OnzlcjiMKQMBDhXgdQposJSOxk9DvDW1ZTDBdY3Ye5MGDsjtS6/pLr+PzbkZKWCxgblt
         0Ix6jNAqdpzoDuac1Gt1nTGfSSOkDowp4q1HPnkcEFc+nT8z8LVMcm2zsCz9d/kaCuyC
         LhSsX/we2eiyWLYe/MSZpMGZpeyIWSuHi4ufuJSzFPby24IRyAGcFlLapO7aPa3ly7bS
         FsYO16l+iaZU29vEC1zyfQ09EyjbCAfuhbYL0UhmPSq5zuOTzeuyKs41pBFyyyT5F4nq
         dfXA==
X-Gm-Message-State: AOAM532r9Rq3mn7bsI5J162MMnhtQvl5KqNFQmpA4AOc0BqP8mYo8zyV
        QfTjo2TrX9bBtRkUAoI5Mn/Q9XIlnuXUkpx5ijCTDBMdGQbvNhVX
X-Google-Smtp-Source: ABdhPJyQxDAhg1NSiShGVcml92xkzaBr6/KgZMFcQfCxe50QZtEvbRZqc9HbmfUUrinHs7xYWwiXcQym7XfV7GGfsxM=
X-Received: by 2002:a81:1b4e:: with SMTP id b75mr9129564ywb.295.1644200462054;
 Sun, 06 Feb 2022 18:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20220207014955.GA33412@xsang-OptiPlex-9020>
In-Reply-To: <20220207014955.GA33412@xsang-OptiPlex-9020>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 6 Feb 2022 18:20:50 -0800
Message-ID: <CANn89i+iE899BXqkMde8moNbqt8fWmt7O3mGqKt8M5wt=v58Hw@mail.gmail.com>
Subject: Re: [ip6mr] f2f2325ec7: BUG:KASAN:use-after-free_in_ip6mr_sk_done
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 6, 2022 at 5:50 PM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: f2f2325ec79970807012dfc9e716cdbb02d9b574 ("ip6mr: ip6mr_sk_done() can exit early in common cases")
> url: https://github.com/0day-ci/linux/commits/Biju-Das/dt-bindings-net-renesas-etheravb-Document-RZ-V2L-SoC/20220207-042554
>

Yes, syzbot found it yesterday, and the fix is sent for review. thanks.

https://patchwork.kernel.org/project/netdevbpf/patch/20220206143348.350693-1-eric.dumazet@gmail.com/


> in testcase: trinity
> version: trinity-x86_64-608712d8-1_20220128
> with following parameters:
>
>         runtime: 300s
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [ 43.727566][ T7] BUG: KASAN: use-after-free in ip6mr_sk_done (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 net/ipv6/ip6mr.c:1578)
> [   43.728665][    T7] Read of size 4 at addr ffff88810eb94888 by task kworker/u4:0/7
> [   43.729851][    T7]
> [   43.730219][    T7] CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 5.17.0-rc2-00638-gf2f2325ec799 #1
> [   43.731561][    T7] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   43.732945][    T7] Workqueue: netns cleanup_net
> [   43.733744][    T7] Call Trace:
> [   43.734297][    T7]  <TASK>
> [ 43.734792][ T7] dump_stack_lvl (lib/dump_stack.c:107)
> [ 43.735543][ T7] print_address_description+0x21/0x180
> [ 43.736636][ T7] ? ip6mr_sk_done (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 net/ipv6/ip6mr.c:1578)
> [ 43.737405][ T7] kasan_report.cold (mm/kasan/report.c:443 mm/kasan/report.c:459)
> [ 43.738113][ T7] ? ip6mr_sk_done (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 net/ipv6/ip6mr.c:1578)
> [ 43.738764][ T7] kasan_check_range (mm/kasan/generic.c:190)
> [ 43.739475][ T7] ip6mr_sk_done (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 net/ipv6/ip6mr.c:1578)
> [ 43.740207][ T7] rawv6_close (net/ipv6/raw.c:1202)
> [ 43.743739][ T7] inet_release (net/ipv4/af_inet.c:429)
> [ 43.747360][ T7] __sock_release (net/socket.c:651)
> [ 43.749878][ T7] igmp6_net_exit (net/ipv6/mcast.c:3174)
> [ 43.752005][ T7] ops_exit_list+0x98/0x180
> [ 43.754973][ T7] cleanup_net (net/core/net_namespace.c:599 (discriminator 3))
> [ 43.757738][ T7] ? peernet2id_alloc (net/core/net_namespace.c:553)
> [ 43.760247][ T7] ? __schedule (kernel/sched/core.c:6174)
> [ 43.762857][ T7] process_one_work (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:212 include/trace/events/workqueue.h:108 kernel/workqueue.c:2312)
> [ 43.765808][ T7] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2455)
> [ 43.768529][ T7] ? process_one_work (kernel/workqueue.c:2397)
> [ 43.771855][ T7] kthread (kernel/kthread.c:377)
> [ 43.775300][ T7] ? kthread_complete_and_exit (kernel/kthread.c:332)
> [ 43.778982][ T7] ret_from_fork (arch/x86/entry/entry_64.S:301)
> [   43.782691][    T7]  </TASK>
> [   43.786069][    T7]
> [   43.789270][    T7] Allocated by task 1:
> [ 43.792813][ T7] kasan_save_stack (mm/kasan/common.c:39)
> [ 43.796486][ T7] __kasan_kmalloc (mm/kasan/common.c:45 mm/kasan/common.c:436 mm/kasan/common.c:515 mm/kasan/common.c:524)
> [ 43.799875][ T7] fib_create_info (include/linux/slab.h:586 include/linux/slab.h:715 net/ipv4/fib_semantics.c:1442)
> [ 43.803543][ T7] fib_table_insert (net/ipv4/fib_trie.c:1224)
> [ 43.807195][ T7] fib_magic+0x297/0x440
> [ 43.810869][ T7] fib_add_ifaddr (net/ipv4/fib_frontend.c:1129)
> [ 43.814464][ T7] fib_netdev_event (net/ipv4/fib_frontend.c:1465 (discriminator 3))
> [ 43.818098][ T7] raw_notifier_call_chain (kernel/notifier.c:89 kernel/notifier.c:392)
> [ 43.821558][ T7] __dev_notify_flags (net/core/dev.c:1931 net/core/dev.c:1945 net/core/dev.c:8177)
> [ 43.824595][ T7] dev_change_flags (net/core/dev.c:8217)
> [ 43.827778][ T7] ip_auto_config (net/ipv4/ipconfig.c:224 net/ipv4/ipconfig.c:1502)
> [ 43.831118][ T7] do_one_initcall (init/main.c:1300)
> [ 43.834106][ T7] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613)
> [ 43.837190][ T7] kernel_init (init/main.c:1504)
> [ 43.839802][ T7] ret_from_fork (arch/x86/entry/entry_64.S:301)
> [   43.842527][    T7]
> [   43.844785][    T7] Freed by task 7:
> [   43.845862][  T660] VFS: Warning: trinity-c3 using old stat() call. Recompile your binary.
> [ 43.847180][ T7] kasan_save_stack (mm/kasan/common.c:39)
> [ 43.847193][ T7] kasan_set_track (mm/kasan/common.c:45)
> [ 43.847198][ T7] kasan_set_free_info (mm/kasan/generic.c:372)
> [ 43.858233][ T7] __kasan_slab_free (mm/kasan/common.c:368 mm/kasan/common.c:328 mm/kasan/common.c:374)
> [ 43.861032][ T7] kfree (mm/slub.c:1754 mm/slub.c:3509 mm/slub.c:4562)
> [ 43.863634][ T7] ops_exit_list+0x98/0x180
> [ 43.866428][ T7] cleanup_net (net/core/net_namespace.c:599 (discriminator 3))
> [ 43.868846][ T7] process_one_work (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:212 include/trace/events/workqueue.h:108 kernel/workqueue.c:2312)
> [ 43.871491][ T7] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2455)
> [ 43.874217][ T7] kthread (kernel/kthread.c:377)
> [ 43.876775][ T7] ret_from_fork (arch/x86/entry/entry_64.S:301)
> [   43.879429][    T7]
> [   43.881813][    T7] Last potentially related work creation:
> [ 43.884669][ T7] kasan_save_stack (mm/kasan/common.c:39)
> [ 43.887467][ T7] __kasan_record_aux_stack (mm/kasan/generic.c:348)
> [ 43.890366][ T7] call_rcu (kernel/rcu/tree.c:3027 kernel/rcu/tree.c:3106)
> [ 43.893057][ T7] fib_create_info (net/ipv4/fib_semantics.c:1574)
> [ 43.895888][ T7] fib_table_insert (net/ipv4/fib_trie.c:1224)
> [ 43.898686][ T7] fib_magic+0x297/0x440
> [ 43.901503][ T7] fib_add_ifaddr (net/ipv4/fib_frontend.c:1129)
> [ 43.904283][ T7] fib_netdev_event (net/ipv4/fib_frontend.c:1465 (discriminator 3))
> [ 43.906925][ T7] raw_notifier_call_chain (kernel/notifier.c:89 kernel/notifier.c:392)
> [ 43.909660][ T7] __dev_notify_flags (net/core/dev.c:1931 net/core/dev.c:1945 net/core/dev.c:8177)
> [ 43.912346][ T7] dev_change_flags (net/core/dev.c:8217)
> [ 43.915108][ T7] ip_auto_config (net/ipv4/ipconfig.c:224 net/ipv4/ipconfig.c:1502)
> [ 43.917827][ T7] do_one_initcall (init/main.c:1300)
> [ 43.920549][ T7] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613)
> [ 43.923383][ T7] kernel_init (init/main.c:1504)
> [ 43.926096][ T7] ret_from_fork (arch/x86/entry/entry_64.S:301)
> [   43.928757][    T7]
> [   43.931153][    T7] The buggy address belongs to the object at ffff88810eb94800
> [   43.931153][    T7]  which belongs to the cache kmalloc-256 of size 256
> [   43.937453][    T7] The buggy address is located 136 bytes inside of
> [   43.937453][    T7]  256-byte region [ffff88810eb94800, ffff88810eb94900)
> [   43.943729][    T7] The buggy address belongs to the page:
> [   43.946822][    T7] page:00000000392d4f15 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10eb94
> [   43.950810][    T7] head:00000000392d4f15 order:1 compound_mapcount:0
> [   43.954208][    T7] flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> [   43.957836][    T7] raw: 0017ffffc0010200 dead000000000100 dead000000000122 ffff888100041b40
> [   43.961613][    T7] raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> [   43.965353][    T7] page dumped because: kasan: bad access detected
> [   43.968765][    T7] page_owner tracks the page as allocated
> [   43.971860][    T7] page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, ts 24086391223, free_ts 24079533892
> [ 43.979986][ T7] prep_new_page (include/linux/page_owner.h:31 mm/page_alloc.c:2427 mm/page_alloc.c:2434)
> [ 43.983297][ T7] get_page_from_freelist (mm/page_alloc.c:4171)
> [ 43.986879][ T7] __alloc_pages (mm/page_alloc.c:5390)
> [ 43.990280][ T7] alloc_page_interleave (arch/x86/include/asm/jump_label.h:27 mm/mempolicy.c:2118)
> [ 43.993759][ T7] allocate_slab (mm/slub.c:1799 mm/slub.c:1944)
> [ 43.997239][ T7] ___slab_alloc (mm/slub.c:3018)
> [ 44.000639][ T7] __slab_alloc+0x1c/0x40
> [ 44.004090][ T7] __kmalloc (mm/slub.c:3196 mm/slub.c:3238 mm/slub.c:4420)
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.17.0-rc2-00638-gf2f2325ec799 .config
>         make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
>         make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
>         cd <mod-install-dir>
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>
> Thanks,
> Oliver Sang
>
