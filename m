Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47769550160
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383726AbiFRAdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiFRAdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:33:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35342C655
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:33:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h1so5117562plf.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kh1rQFupl/d97pl16VFBuVSFs7/1XuofViM8mwLyjeE=;
        b=MhmFu9ozQxp8a/zJRez/+o3bR73WgzKH3YDh32OBaSyBc9iAsNHj2BUeaD5Jr96u/7
         PUD0ZCIohjFSkjyXXtBrN6kvEb4NBkM+RDqEmcrgtyTAwie3f+52XuMLsyULs3ZR76yH
         ZejcmcieYEtTVcSx/curimkcLZIEeYaQMC7i0yHp1aI2HJfSGO3od5EuSKb55L0v4UkT
         aXg4itLHwoDJczUeVcwSB4EChoHKTYfrxA7QQnnEuYXtQdf2nujV8aNH0porvh5VoBGY
         LgLq7EA7kIBayvXhmiSJhW2dFeeENo0qnM2OekfTE23XKmuq80Buu6797zjuf4wE68Wl
         kFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kh1rQFupl/d97pl16VFBuVSFs7/1XuofViM8mwLyjeE=;
        b=oonXompZQ786FlgBeKwQwcUSIZeMgDa1Z+BFyCL5L01T2dQW9XSKbdMrbpclAVIW0D
         1g4XAVO1DodVhlbGej+CNzVxQH/zEvko6m05/0oXK+5aAuzF1lC+MNa3RfOdbeEGThzE
         s21+hfMLGoq6G1R5aDn8rxbIHeN+AKzCpBibZvZd5asbJLjjuW4h4H5GqWIdAN4D/sTY
         W2lgf4FV6ZxnpKixw2csW1HoWgokc1WZiUHAX/RDMZzhIaLJjKC+HvZ1gcDR+e7NFwXm
         nYsuIS2a3VKs8CYkwDcAglKtrwhsFFXCQmGXx3W1tMN747S01ZiXOQ/5pPO3nRXwVBu0
         8aqw==
X-Gm-Message-State: AJIora+37mXziyx1BP4Lyxop8Vjj4X/X9nUaSLTjn9u7ixZU2lpkWu5G
        DrAeGQn5e0cta4bqmnZxfebk9fjhB9i3UQSVlEI=
X-Google-Smtp-Source: AGRyM1un7r64qjpH5saHTyKLfPEpotyKoycFOHpAjlMiNqTFniXAV7Wn63s/mN1faN768A2sXy78hUpDyurDZR8HXiM=
X-Received: by 2002:a17:903:32c4:b0:167:6e6f:204b with SMTP id
 i4-20020a17090332c400b001676e6f204bmr12336308plr.117.1655512398259; Fri, 17
 Jun 2022 17:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003189f305e19f5d3e@google.com> <20220617165256.b5b9b257b30bc1dbb21fc8c6@linux-foundation.org>
 <Yq0Y0B1XGNIbCveO@casper.infradead.org>
In-Reply-To: <Yq0Y0B1XGNIbCveO@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 17 Jun 2022 17:33:05 -0700
Message-ID: <CAHbLzkofHiQiRU3QBmK3Tr9xozSt1EFtT4hCLh5w_Mcspm35Hg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in hugepage_vma_check
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 5:14 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jun 17, 2022 at 04:52:56PM -0700, Andrew Morton wrote:
> > On Fri, 17 Jun 2022 00:04:23 -0700 syzbot <syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    c6d7e3b385f1 Add linux-next specific files for 20220616
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10d9fb1bf00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9d495405e4a98620
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4d875b4d2e2b60bae9b4
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> > > BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
> > > BUG: KASAN: null-ptr-deref in hugepage_vma_check+0x8e/0x750 mm/huge_memory.c:82
> > > Read of size 8 at addr 00000000000005a8 by task syz-executor.5/21978
> >
> > vma->vm_mm is NULL in show_smap->hugepage_vma_check().
> >
> > Perhaps m_start() should be checking the mm after taking
> > mmap_read_lock() instead of before?
> >
> > Matthew, you mucked with it last ;) Can you please take a look?
>
> I think this is Yang Shi's fault.  The last patch in that series which
> touches this area does:
>
>         seq_printf(m, "THPeligible:    %d\n",
> -                  hugepage_vma_check(vma, vma->vm_flags, true));
> +                  hugepage_vma_check(vma, vma->vm_flags, true, false));
>
> and hugepage_vma_check() does:
>
>         if ((vm_flags & VM_NOHUGEPAGE) ||
>             test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>                 return false;
>
> Before those patches, it calls transparent_hugepage_active() which
> does not (afaict) touch vma->vm_mm.

No, transparent_hugepage_active() also could touch vma->vm_mm. The
above code was transhuge_vma_enabled() called by
transparent_hugepage_active() before my patch, my patch just
open-coded it.

But hugepage_vma_check() does check vma in different order from
transparent_hugepage_active(), so the old code may not reach it at
all.

And I don't think the mm could go away since it is pinned, but the
returned vma may not belong to this mm, for example, gate vma which
doesn't have a mm. Its size is PAGE_SIZE, so the old code returns
earlier before touching mm.

One possible solution is to move vma size check before touching mm, like:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2e2a8b5bc567..1a9f15a89091 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -73,6 +73,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
                        unsigned long vm_flags,
                        bool smaps, bool in_pf)
 {
+       /*
+        * Check alignment for file vma and size for both file and anon vma.
+        *
+        * Skip the check for page fault. Huge fault does the check in fault
+        * handlers. And this check is not suitable for huge PUD fault.
+        */
+       if (!in_pf &&
+           !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
+               return false;
+
        /*
         * Explicitly disabled through madvise or prctl, or some
         * architectures may disable THP for some mappings, for
@@ -99,16 +109,6 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
        if (vm_flags & VM_NO_KHUGEPAGED)
                return false;

-       /*
-        * Check alignment for file vma and size for both file and anon vma.
-        *
-        * Skip the check for page fault. Huge fault does the check in fault
-        * handlers. And this check is not suitable for huge PUD fault.
-        */
-       if (!in_pf &&
-           !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
-               return false;
-
        /*
         * Enabled via shmem mount options or sysfs settings.
         * Must be done before hugepage flags check since shmem has its

Or we may have to check gate vma explicitly.

>
> I haven't been paying attention to that patch series, so I don't have
> a constructive suggestion for how to fix.
>
> > > CPU: 0 PID: 21978 Comm: syz-executor.5 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > >  kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
> > >  check_region_inline mm/kasan/generic.c:183 [inline]
> > >  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
> > >  instrument_atomic_read include/linux/instrumented.h:71 [inline]
> > >  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
> > >  hugepage_vma_check+0x8e/0x750 mm/huge_memory.c:82
> > >  show_smap+0x1c6/0x470 fs/proc/task_mmu.c:866
> > >  traverse.part.0+0xcf/0x5f0 fs/seq_file.c:111
> > >  traverse fs/seq_file.c:101 [inline]
> > >  seq_read_iter+0x90f/0x1280 fs/seq_file.c:195
> > >  seq_read+0x337/0x4b0 fs/seq_file.c:162
> > >  do_loop_readv_writev fs/read_write.c:763 [inline]
> > >  do_loop_readv_writev fs/read_write.c:750 [inline]
> > >  do_iter_read+0x4f8/0x750 fs/read_write.c:805
> > >  vfs_readv+0xe5/0x150 fs/read_write.c:923
> > >  do_preadv fs/read_write.c:1015 [inline]
> > >  __do_sys_preadv fs/read_write.c:1065 [inline]
> > >  __se_sys_preadv fs/read_write.c:1060 [inline]
> > >  __x64_sys_preadv+0x22b/0x310 fs/read_write.c:1060
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > RIP: 0033:0x7f5c1d889109
> > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f5c1ea69168 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
> > > RAX: ffffffffffffffda RBX: 00007f5c1d99bf60 RCX: 00007f5c1d889109
> > > RDX: 0000000000000001 RSI: 00000000200006c0 RDI: 0000000000000005
> > > RBP: 00007f5c1d8e305d R08: 0000000000000000 R09: 0000000000000000
> > > R10: 00000000fffffffe R11: 0000000000000246 R12: 0000000000000000
> > > R13: 00007ffd8514b43f R14: 00007f5c1ea69300 R15: 0000000000022000
> > >  </TASK>
> > > ==================================================================
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
