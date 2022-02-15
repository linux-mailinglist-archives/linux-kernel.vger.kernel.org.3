Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EAB4B7581
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242922AbiBOSLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:11:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbiBOSLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:11:16 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B6119433
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:11:05 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j2so58832402ybu.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLXQM8t6+uoAMZ+mvQGmuttsgeLGP4nPmbwY/NIlyEk=;
        b=dfi79U+Y9ipNFYbKzTQ907TBgxpNzm2X0SthcXxIecZ58GVPqTOED9oq9QPXw0DvpG
         c+t5YRU/h3T589UJBBwBB6eScJiHxDR+tW1JlmBpedOikBg3OKTQOSLFW4ld9SV/IeqM
         R6InlDDQwIbis6JN8L+8nuWRzKECW6H6sJ7L+7KO+wT3IuHFn5FiHw/4ULd7zEgqJ/Tr
         6idsqxi1+Tt678pj/I2xr1Y1X6hnIY6YDKEAUkCgrs2Mty1KuXuj/MWaM/z/b/2spHen
         WumghLrdizW7TGRH67hPy/Av6Nek9kPxvEp1QMey64nFqHjmyhLZbYk2ywrCanbyvjC+
         WMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLXQM8t6+uoAMZ+mvQGmuttsgeLGP4nPmbwY/NIlyEk=;
        b=ZzlFZKBBmcieKKphpWrhBfiEEwFYxkWrZhnBmbYqiR2+/uFLK39YlLnLxE1HNSvY1u
         cYy5LrolA/KDxv/UQ98nDJhNEWd3camsSzjVCjDW9oc3I5eKlY5ejuPHQ5r3fH12jOGJ
         jrfhMvVatHUyGH7fJR0mL/8lAmV1WtY9xZklY5KJRgXHK5P8q86pweGUVRWR1g0hTsZJ
         bFe81SZ6/DJ7Z20J2C6gkDjb6YNByJABrTkDZGTuhB2QXw/taYOFj+2LOL3XGGS5H3qN
         BkCdyNEZjSmVz2/S6/J30IVG8/frFj3V2xTX+Mea/DUXXfYuPzmZeElba3Ma4dLrNWbR
         QUtw==
X-Gm-Message-State: AOAM530t3eLa7caTeesv6HjogpSFcvhG0SQ4dzvci4sgbBT5fioMyRKf
        Az0srF1Q2vZe4+7tANGDVulk/vZQi4+49M2EV07Rbg==
X-Google-Smtp-Source: ABdhPJwDkHrq9LOdXqUa28Rx6guKXdUgO+svNocn1EwvffOvTx8EXjB/Sh9bvYNDxqrkb19nCimhBK2NmNbA0qB76WY=
X-Received: by 2002:a81:138a:: with SMTP id 132mr60496ywt.514.1644948664409;
 Tue, 15 Feb 2022 10:11:04 -0800 (PST)
MIME-Version: 1.0
References: <00000000000072ef2c05d7f81950@google.com> <CAHbLzkpr=xHC7C2+wkOGUB24924T4L1Lx_v+m1Ke8Ku3ym7wYw@mail.gmail.com>
 <Ygt5cAS78BFxVwkg@dhcp22.suse.cz> <CAJuCfpGf8HLh=tfrnK3VFd2QO9bgzuM9HyDY8PYYxJkbdbmYRA@mail.gmail.com>
 <CAHbLzkpKGq8XaLx3G1=oJ-TsZiqC+A+CaVK5=Mjzo1Jo0qA3DQ@mail.gmail.com>
In-Reply-To: <CAHbLzkpKGq8XaLx3G1=oJ-TsZiqC+A+CaVK5=Mjzo1Jo0qA3DQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 15 Feb 2022 10:10:53 -0800
Message-ID: <CAJuCfpE833u+Z909yaLgGEJV7O10fVw-_eG1nH=w4b3+PbxrLg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __oom_reap_task_mm
To:     Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        syzbot <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
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

On Tue, Feb 15, 2022 at 9:53 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Feb 15, 2022 at 9:34 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > ->
> > On Tue, Feb 15, 2022 at 1:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > [Add Suren - and keeping the full message for reference. My comment in
> > > inlined]
> > >
> > > On Mon 14-02-22 11:07:05, Yang Shi wrote:
> > > > On Mon, Feb 14, 2022 at 2:44 AM syzbot
> > > > <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    e6251ab4551f Merge tag 'nfs-for-5.17-2' of git://git.linux..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1229b2f8700000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=2ccf63a4bd07cf39cab0
> > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > userspace arch: i386
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
> > > > >
> > > > > ==================================================================
> > > > > BUG: KASAN: use-after-free in can_madv_lru_vma mm/internal.h:76 [inline]
> > > > > BUG: KASAN: use-after-free in __oom_reap_task_mm+0x3a4/0x400 mm/oom_kill.c:529
> > > > > Read of size 8 at addr ffff88807b868ba8 by task syz-executor.2/12778
> > > > >
> > > > > CPU: 0 PID: 12778 Comm: syz-executor.2 Not tainted 5.17.0-rc3-syzkaller-00029-ge6251ab4551f #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > > > >  print_address_description.constprop.0.cold+0x8d/0x336 mm/kasan/report.c:255
> > > > >  __kasan_report mm/kasan/report.c:442 [inline]
> > > > >  kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
> > > > >  can_madv_lru_vma mm/internal.h:76 [inline]
> > > > >  __oom_reap_task_mm+0x3a4/0x400 mm/oom_kill.c:529
> > > > >  __do_sys_process_mrelease+0x3f2/0x450 mm/oom_kill.c:1196
> > > > >  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> > > > >  __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
> > > > >  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> > > > >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > > > > RIP: 0023:0xf6e70549
> > > > > Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> > > > > RSP: 002b:00000000f586a5cc EFLAGS: 00000296 ORIG_RAX: 00000000000001c0
> > > > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000000
> > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > > > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > > > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > >  </TASK>
> > > > >
> > > > > Allocated by task 12778:
> > > > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > > > >  kasan_set_track mm/kasan/common.c:45 [inline]
> > > > >  set_alloc_info mm/kasan/common.c:436 [inline]
> > > > >  __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
> > > > >  kasan_slab_alloc include/linux/kasan.h:260 [inline]
> > > > >  slab_post_alloc_hook mm/slab.h:732 [inline]
> > > > >  slab_alloc_node mm/slub.c:3230 [inline]
> > > > >  slab_alloc mm/slub.c:3238 [inline]
> > > > >  kmem_cache_alloc+0x202/0x3a0 mm/slub.c:3243
> > > > >  vm_area_dup+0x88/0x2b0 kernel/fork.c:357
> > > > >  dup_mmap kernel/fork.c:554 [inline]
> > > > >  dup_mm+0x5fa/0x13e0 kernel/fork.c:1451
> > > > >  copy_mm kernel/fork.c:1503 [inline]
> > > > >  copy_process+0x71f8/0x7300 kernel/fork.c:2164
> > > > >  kernel_clone+0xe7/0xab0 kernel/fork.c:2555
> > > > >  __do_compat_sys_ia32_clone+0xac/0xe0 arch/x86/kernel/sys_ia32.c:254
> > > > >  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> > > > >  __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
> > > > >  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> > > > >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > > > >
> > > > > Freed by task 12780:
> > > > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > > > >  kasan_set_track+0x21/0x30 mm/kasan/common.c:45
> > > > >  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
> > > > >  ____kasan_slab_free mm/kasan/common.c:366 [inline]
> > > > >  ____kasan_slab_free+0x130/0x160 mm/kasan/common.c:328
> > > > >  kasan_slab_free include/linux/kasan.h:236 [inline]
> > > > >  slab_free_hook mm/slub.c:1728 [inline]
> > > > >  slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
> > > > >  slab_free mm/slub.c:3509 [inline]
> > > > >  kmem_cache_free+0xd8/0x340 mm/slub.c:3526
> > > > >  remove_vma+0x135/0x170 mm/mmap.c:189
> > > > >  exit_mmap+0x29a/0x670 mm/mmap.c:3186
> > > > >  __mmput+0x122/0x4b0 kernel/fork.c:1114
> > > > >  mmput+0x56/0x60 kernel/fork.c:1135
> > > > >  exit_mm kernel/exit.c:507 [inline]
> > > > >  do_exit+0xa3c/0x2a30 kernel/exit.c:793
> > > > >  do_group_exit+0xd2/0x2f0 kernel/exit.c:935
> > > > >  get_signal+0x4b0/0x28c0 kernel/signal.c:2862
> > > > >  arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
> > > > >  handle_signal_work kernel/entry/common.c:148 [inline]
> > > > >  exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
> > > > >  exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
> > > > >  __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
> > > > >  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
> > > > >  __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
> > > > >  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> > > > >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > > >
> > > > It seems process_mrelease() may be racy with exiting. mmgrab() just
> > > > pin mm struct, but doesn't guarantee the associated address space
> > > > still exists. mmget or mmget_not_zero() may be needed at first glance.
> > >
> > > This is what process_mrelease used to do before ba535c1caf3e
> > > ("mm/oom_kill: allow process_mrelease to run under mmap_lock
> > > protection"). It shouldn't be really necessary because of the
> > > synchronization that happens on the exit_mmap level. There were some
> > > patches in that area and I am not sure whether something is still
> > > hanging in the Andrew's queue. Suren will surely know better.
> >
> > Correct, the proposed change is what we were doing before 64591e8605d6
> > ("mm: protect free_pgtables with mmap_lock write lock in exit_mmap")
> > and ba535c1caf3e ("mm/oom_kill: allow process_mrelease to run under
> > mmap_lock protection"). The first patch changed exit_mmap to call
> > unlock_range, free_pgtables and remove_vma under mmap_write_lock and
> > the second patch calls __oom_reap_task_mm under mmap_read_lock. From
> > the call stack IIUC __oom_reap_task_mm at
> > https://elixir.bootlin.com/linux/v5.17-rc4/source/mm/oom_kill.c#L1196
> > is racing with remove_vma at
> > https://elixir.bootlin.com/linux/v5.17-rc4/source/mm/mmap.c#L3186. The
> > mmap_lock should prevent this race and I don't see anything missing in
> > Andrew's tree. I'll go over the code again and re-check but so far I
> > don't see how this race could occur.
>
> Isn't the below race possible?
>
>           CPU A                                     CPU B
> exiting:
>   mmap_write_lock
>   remove_vma()
>   mmap_write_unlock
>                                                 process_mrelease:
>                                                   mmap_read_lock
>                                                   __oom_reap_task_mm
>                                                   mmap_read_unlock
>

Sure, that sequence (would not call it a race) is possible but in this
case __oom_reap_task_mm will find no vmas in the mm because exit_mmap
freed and removed all of them.

> >
> > >
> > > > The below untested patch (compiled) may be able to fix it.
> > > >
> > > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > > index 832fb330376e..c389995bcc71 100644
> > > > --- a/mm/oom_kill.c
> > > > +++ b/mm/oom_kill.c
> > > > @@ -1185,9 +1185,11 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd,
> > > > unsigned int, flags)
> > > >         if (!reap)
> > > >                 goto drop_mm;
> > > >
> > > > +       if (!mmget_not_zero(mm))
> > > > +               goto drop_mm;
> > > >         if (mmap_read_lock_killable(mm)) {
> > > >                 ret = -EINTR;
> > > > -               goto drop_mm;
> > > > +               goto put_mm;
> > > >         }
> > > >         /*
> > > >          * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
> > > > @@ -1197,6 +1199,8 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd,
> > > > unsigned int, flags)
> > > >                 ret = -EAGAIN;
> > > >         mmap_read_unlock(mm);
> > > >
> > > > +put_mm:
> > > > +       mmput(mm);
> > > >  drop_mm:
> > > >         mmdrop(mm);
> > > >  put_task:
> > > >
> > > > >
> > > > > The buggy address belongs to the object at ffff88807b868b58
> > > > >  which belongs to the cache vm_area_struct of size 200
> > > > > The buggy address is located 80 bytes inside of
> > > > >  200-byte region [ffff88807b868b58, ffff88807b868c20)
> > > > > The buggy address belongs to the page:
> > > > > page:ffffea0001ee1a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b868
> > > > > memcg:ffff88804fe94a01
> > > > > flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
> > > > > raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888140006a00
> > > > > raw: 0000000000000000 00000000000f000f 00000001ffffffff ffff88804fe94a01
> > > > > page dumped because: kasan: bad access detected
> > > > > page_owner tracks the page as allocated
> > > > > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 3175, ts 344170603641, free_ts 344164018467
> > > > >  prep_new_page mm/page_alloc.c:2434 [inline]
> > > > >  get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
> > > > >  __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
> > > > >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2271
> > > > >  alloc_slab_page mm/slub.c:1799 [inline]
> > > > >  allocate_slab mm/slub.c:1944 [inline]
> > > > >  new_slab+0x28a/0x3b0 mm/slub.c:2004
> > > > >  ___slab_alloc+0x87c/0xe90 mm/slub.c:3018
> > > > >  __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3105
> > > > >  slab_alloc_node mm/slub.c:3196 [inline]
> > > > >  slab_alloc mm/slub.c:3238 [inline]
> > > > >  kmem_cache_alloc+0x35c/0x3a0 mm/slub.c:3243
> > > > >  vm_area_dup+0x88/0x2b0 kernel/fork.c:357
> > > > >  dup_mmap kernel/fork.c:554 [inline]
> > > > >  dup_mm+0x5fa/0x13e0 kernel/fork.c:1451
> > > > >  copy_mm kernel/fork.c:1503 [inline]
> > > > >  copy_process+0x71f8/0x7300 kernel/fork.c:2164
> > > > >  kernel_clone+0xe7/0xab0 kernel/fork.c:2555
> > > > >  __do_sys_clone+0xc8/0x110 kernel/fork.c:2672
> > > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > page last free stack trace:
> > > > >  reset_page_owner include/linux/page_owner.h:24 [inline]
> > > > >  free_pages_prepare mm/page_alloc.c:1352 [inline]
> > > > >  free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1404
> > > > >  free_unref_page_prepare mm/page_alloc.c:3325 [inline]
> > > > >  free_unref_page_list+0x1a9/0xfa0 mm/page_alloc.c:3441
> > > > >  release_pages+0x317/0x1220 mm/swap.c:980
> > > > >  tlb_batch_pages_flush mm/mmu_gather.c:50 [inline]
> > > > >  tlb_flush_mmu_free mm/mmu_gather.c:243 [inline]
> > > > >  tlb_flush_mmu mm/mmu_gather.c:250 [inline]
> > > > >  tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:341
> > > > >  exit_mmap+0x21b/0x670 mm/mmap.c:3180
> > > > >  __mmput+0x122/0x4b0 kernel/fork.c:1114
> > > > >  mmput+0x56/0x60 kernel/fork.c:1135
> > > > >  exit_mm kernel/exit.c:507 [inline]
> > > > >  do_exit+0xa3c/0x2a30 kernel/exit.c:793
> > > > >  do_group_exit+0xd2/0x2f0 kernel/exit.c:935
> > > > >  get_signal+0x4b0/0x28c0 kernel/signal.c:2862
> > > > >  arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
> > > > >  handle_signal_work kernel/entry/common.c:148 [inline]
> > > > >  exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
> > > > >  exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
> > > > >  __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
> > > > >  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
> > > > >  __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
> > > > >  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> > > > >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > > > >
> > > > > Memory state around the buggy address:
> > > > >  ffff88807b868a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > >  ffff88807b868b00: fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb
> > > > > >ffff88807b868b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > >                                   ^
> > > > >  ffff88807b868c00: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
> > > > >  ffff88807b868c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > ==================================================================
> > > > > ----------------
> > > > > Code disassembly (best guess):
> > > > >    0:   03 74 c0 01             add    0x1(%rax,%rax,8),%esi
> > > > >    4:   10 05 03 74 b8 01       adc    %al,0x1b87403(%rip)        # 0x1b8740d
> > > > >    a:   10 06                   adc    %al,(%rsi)
> > > > >    c:   03 74 b4 01             add    0x1(%rsp,%rsi,4),%esi
> > > > >   10:   10 07                   adc    %al,(%rdi)
> > > > >   12:   03 74 b0 01             add    0x1(%rax,%rsi,4),%esi
> > > > >   16:   10 08                   adc    %cl,(%rax)
> > > > >   18:   03 74 d8 01             add    0x1(%rax,%rbx,8),%esi
> > > > >   1c:   00 00                   add    %al,(%rax)
> > > > >   1e:   00 00                   add    %al,(%rax)
> > > > >   20:   00 51 52                add    %dl,0x52(%rcx)
> > > > >   23:   55                      push   %rbp
> > > > >   24:   89 e5                   mov    %esp,%ebp
> > > > >   26:   0f 34                   sysenter
> > > > >   28:   cd 80                   int    $0x80
> > > > > * 2a:   5d                      pop    %rbp <-- trapping instruction
> > > > >   2b:   5a                      pop    %rdx
> > > > >   2c:   59                      pop    %rcx
> > > > >   2d:   c3                      retq
> > > > >   2e:   90                      nop
> > > > >   2f:   90                      nop
> > > > >   30:   90                      nop
> > > > >   31:   90                      nop
> > > > >   32:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
> > > > >   39:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
> > > > >
> > > > >
> > > > > ---
> > > > > This report is generated by a bot. It may contain errors.
> > > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > >
> > > > > syzbot will keep track of this issue. See:
> > > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > > >
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
