Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE6F55CA33
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbiF0QMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiF0QME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:12:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDD8140D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:11:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x138so6782826pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QSB6tq8B5cwtKotfoR7RizrMhJVAHRxsw0c1BjDvvhU=;
        b=i1hJ5DeEmoJYw2l4WQ8n43hSRbva2Sb4StNNmtaZWKUsIcFH7+qAbQMp95fEXhcdKL
         y2QDy7UFUTWaaRaWuHHxxG0zmJfziSuXNLxsdvh0W+P981Pk6b+yEhvfsZqUOsbB2wmF
         dgXa+OntMLCe3PgtwnD3GwuXDHmFyJeinJwad8oDdW48lXs2TC45pgkyaYLSAHUfCMrK
         WpDDRsewu0tHaECxeW7/Z9fsfCnMdh6aai60ucHX/wo3FpVMfdY+BdOycO6Ih8eZZXlW
         xMa0RGitHiz1KRfr/pQKku02BnSNVWiAtnZigz55uWUaLzYOEnTdqly3qcaQUxhBryBu
         44Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QSB6tq8B5cwtKotfoR7RizrMhJVAHRxsw0c1BjDvvhU=;
        b=HE5nJtICSGRiZz3gjYtnqEkV94twcqWWNOdATtKnG2Tp2f7+DehF27i41EWb2Hcq22
         Pit3vIQX4SzPCGzteblFB4HUIKW3WaWlWl1ovYoc+thisiJRcVC14M0M33M7i7sOawUZ
         D0UVc+yGBS7FJ4ytT6QCIv2FDQbp0xoNG6Igejj4W0SHK0N+sZTOqd2/CXuNyuLkzFvo
         OcSlgjSybX8J2LbFfmP6f4agL8f6PCbvQ578fUtZK5aMEO0RDvuzXbpRBfKd31DmAZG9
         Gq7dNiso8M3Nn2j2NdF3KFzpy2F9QUYz30ZGfr2b2MzIoZ44ZnHo3FcphNYW96iIvkAx
         bcwA==
X-Gm-Message-State: AJIora/J2/HqRlpYJgSHhyX/cT5NZWuv4XEUq5SC5taIh/VCZm+Hf2ss
        B7APwZJRyY7/Tn9kwOdG9uu2BlxZxxpB+A==
X-Google-Smtp-Source: AGRyM1s/pLm96R1iZU+IkUHBDnPQBfn+/TP68BwerIAfBOBnIss7A/K8cEUKr+Vra3JLYWh1gB6zSw==
X-Received: by 2002:a63:8f13:0:b0:40c:f042:13a8 with SMTP id n19-20020a638f13000000b0040cf04213a8mr13708678pgd.619.1656346318584;
        Mon, 27 Jun 2022 09:11:58 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902dacb00b001635b86a790sm7568586plx.44.2022.06.27.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:11:57 -0700 (PDT)
Date:   Mon, 27 Jun 2022 09:11:54 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in hugepage_vma_check
Message-ID: <YrnWykdEI4N1ONMx@google.com>
References: <0000000000003189f305e19f5d3e@google.com>
 <20220617165256.b5b9b257b30bc1dbb21fc8c6@linux-foundation.org>
 <Yq0Y0B1XGNIbCveO@casper.infradead.org>
 <CAHbLzkofHiQiRU3QBmK3Tr9xozSt1EFtT4hCLh5w_Mcspm35Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkofHiQiRU3QBmK3Tr9xozSt1EFtT4hCLh5w_Mcspm35Hg@mail.gmail.com>
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

On 17 Jun 17:33, Yang Shi wrote:
> On Fri, Jun 17, 2022 at 5:14 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jun 17, 2022 at 04:52:56PM -0700, Andrew Morton wrote:
> > > On Fri, 17 Jun 2022 00:04:23 -0700 syzbot <syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com> wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    c6d7e3b385f1 Add linux-next specific files for 20220616
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=10d9fb1bf00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9d495405e4a98620
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=4d875b4d2e2b60bae9b4
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com
> > > >
> > > > ==================================================================
> > > > BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> > > > BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
> > > > BUG: KASAN: null-ptr-deref in hugepage_vma_check+0x8e/0x750 mm/huge_memory.c:82
> > > > Read of size 8 at addr 00000000000005a8 by task syz-executor.5/21978
> > >
> > > vma->vm_mm is NULL in show_smap->hugepage_vma_check().
> > >
> > > Perhaps m_start() should be checking the mm after taking
> > > mmap_read_lock() instead of before?
> > >
> > > Matthew, you mucked with it last ;) Can you please take a look?
> >
> > I think this is Yang Shi's fault.  The last patch in that series which
> > touches this area does:
> >
> >         seq_printf(m, "THPeligible:    %d\n",
> > -                  hugepage_vma_check(vma, vma->vm_flags, true));
> > +                  hugepage_vma_check(vma, vma->vm_flags, true, false));
> >
> > and hugepage_vma_check() does:
> >
> >         if ((vm_flags & VM_NOHUGEPAGE) ||
> >             test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> >                 return false;
> >
> > Before those patches, it calls transparent_hugepage_active() which
> > does not (afaict) touch vma->vm_mm.
> 
> No, transparent_hugepage_active() also could touch vma->vm_mm. The
> above code was transhuge_vma_enabled() called by
> transparent_hugepage_active() before my patch, my patch just
> open-coded it.
> 
> But hugepage_vma_check() does check vma in different order from
> transparent_hugepage_active(), so the old code may not reach it at
> all.
> 
> And I don't think the mm could go away since it is pinned, but the
> returned vma may not belong to this mm, for example, gate vma which
> doesn't have a mm. Its size is PAGE_SIZE, so the old code returns
> earlier before touching mm.
> 
> One possible solution is to move vma size check before touching mm, like:
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2e2a8b5bc567..1a9f15a89091 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -73,6 +73,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>                         unsigned long vm_flags,
>                         bool smaps, bool in_pf)
>  {
> +       /*
> +        * Check alignment for file vma and size for both file and anon vma.
> +        *
> +        * Skip the check for page fault. Huge fault does the check in fault
> +        * handlers. And this check is not suitable for huge PUD fault.
> +        */
> +       if (!in_pf &&
> +           !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
> +               return false;
> +
>         /*
>          * Explicitly disabled through madvise or prctl, or some
>          * architectures may disable THP for some mappings, for
> @@ -99,16 +109,6 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>         if (vm_flags & VM_NO_KHUGEPAGED)
>                 return false;
> 
> -       /*
> -        * Check alignment for file vma and size for both file and anon vma.
> -        *
> -        * Skip the check for page fault. Huge fault does the check in fault
> -        * handlers. And this check is not suitable for huge PUD fault.
> -        */
> -       if (!in_pf &&
> -           !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
> -               return false;
> -
>         /*
>          * Enabled via shmem mount options or sysfs settings.
>          * Must be done before hugepage flags check since shmem has its
> 
> Or we may have to check gate vma explicitly.
>

I think this is already fixed already with Andrew's fix in mm-unstable:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index df04c0057271..fbe02815c41a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -73,6 +73,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
                        unsigned long vm_flags,
                        bool smaps)
 {
+       if (!vma->vm_mm)
+               return false;
+
        if (!transhuge_vma_enabled(vma, vm_flags))
                return false;

Which isn't included in the tree testing here. IMHO this is cleaner than messing
with an already subtle ordering.


> >
> > I haven't been paying attention to that patch series, so I don't have
> > a constructive suggestion for how to fix.
> >
> > > > CPU: 0 PID: 21978 Comm: syz-executor.5 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > > >  kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
> > > >  check_region_inline mm/kasan/generic.c:183 [inline]
> > > >  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
> > > >  instrument_atomic_read include/linux/instrumented.h:71 [inline]
> > > >  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
> > > >  hugepage_vma_check+0x8e/0x750 mm/huge_memory.c:82
> > > >  show_smap+0x1c6/0x470 fs/proc/task_mmu.c:866
> > > >  traverse.part.0+0xcf/0x5f0 fs/seq_file.c:111
> > > >  traverse fs/seq_file.c:101 [inline]
> > > >  seq_read_iter+0x90f/0x1280 fs/seq_file.c:195
> > > >  seq_read+0x337/0x4b0 fs/seq_file.c:162
> > > >  do_loop_readv_writev fs/read_write.c:763 [inline]
> > > >  do_loop_readv_writev fs/read_write.c:750 [inline]
> > > >  do_iter_read+0x4f8/0x750 fs/read_write.c:805
> > > >  vfs_readv+0xe5/0x150 fs/read_write.c:923
> > > >  do_preadv fs/read_write.c:1015 [inline]
> > > >  __do_sys_preadv fs/read_write.c:1065 [inline]
> > > >  __se_sys_preadv fs/read_write.c:1060 [inline]
> > > >  __x64_sys_preadv+0x22b/0x310 fs/read_write.c:1060
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > > RIP: 0033:0x7f5c1d889109
> > > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > > RSP: 002b:00007f5c1ea69168 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
> > > > RAX: ffffffffffffffda RBX: 00007f5c1d99bf60 RCX: 00007f5c1d889109
> > > > RDX: 0000000000000001 RSI: 00000000200006c0 RDI: 0000000000000005
> > > > RBP: 00007f5c1d8e305d R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 00000000fffffffe R11: 0000000000000246 R12: 0000000000000000
> > > > R13: 00007ffd8514b43f R14: 00007f5c1ea69300 R15: 0000000000022000
> > > >  </TASK>
> > > > ==================================================================
> > > >
> > > >
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
