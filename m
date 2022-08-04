Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB94589757
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiHDFaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiHDFaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:30:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF2937F9F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:30:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y23so10667951ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 22:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uxn4ZMmx203WyOlSVHDAZZ2QkYW3oqKlf8ih7gOJLnk=;
        b=lLQxvyHvx/3rSn3OOh5hrXaiIxuWrgi5BJsmJOY3SHUfBtpiGAuBPLHWhCq8woPyVn
         9qHFOvW4QzuQzEI2D+GDZ517t6en3Cu5ooj8WFYjQ9C3Vd6Q9vyBuqPmdhKK6oBmseFB
         FYYRJLjiEBkK0fFWh7ewCMPBqh8a30fJR1VbtM9jEAG98GVfOyCK0nP3iL4BMwJq5Knf
         65y3j9b2n2M+/juywtwuDE2r8/2ZFW7kEMW49kb6SKp0PvUL7jvQVgGMC55i9Drv20Ss
         0IZiavEcWLnfMmou8KX2MDI9Uvw4iYB4DuJ6n2JdmCEoesKnWFQjynzaLzwU++D7lOB2
         XALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uxn4ZMmx203WyOlSVHDAZZ2QkYW3oqKlf8ih7gOJLnk=;
        b=DgHZDYdjQqXCQMBZ90YYac3LcXfJSaZzsNEl2ZrV2Q323GvdIy+PSLS8RUOmiECs4+
         /jl73xl+AR+5xzva3hcmUgzjT/8Gxu38x1ydfwp0UwVc0kaaufjhf74li+60slSgmbm0
         8h4wlyiLovDsbnKd1kB8ItV+m1ICMgqm++9QadhyCcYd/akOjAjHooLckMO9vrFlWyEY
         m6mgk9ZyEEXrStzI4x/1o9z5JI5K1hnQoqHPj4BfykcfKLj//LgQf8z0t00cTpygFpqe
         9J6CdU3q165gLhlDLDSMvbyIozHhWSL4Z8xNfgt9xUTgYNE3u6n0q3a+sz0yAd0Pzj2r
         vyBw==
X-Gm-Message-State: ACgBeo3CDhLmtcDNYZhcO0IYhWCpCSQCbwST7Vges6dgIUpPUnc+dFNg
        EUWtZu049YdCNZDC3elkTI8l62QxAn6Ko0TPrAE2DQ==
X-Google-Smtp-Source: AA6agR7raR6yR9Gk4kq2pWN/JukLAC7hPtGF3ABVdbOWH7tEdtreK7xCt3hgltvbkoqs9ZhJiHj8UIJQ5ZSpY0tqwa8=
X-Received: by 2002:a2e:a5ca:0:b0:25e:1c49:70f4 with SMTP id
 n10-20020a2ea5ca000000b0025e1c4970f4mr46659ljp.4.1659591008148; Wed, 03 Aug
 2022 22:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000098a0105e557f130@google.com> <YuqqLfu1E62PqnKS@monkey>
 <YuriiFpv/enJW1oE@xz-m1.local>
In-Reply-To: <YuriiFpv/enJW1oE@xz-m1.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Aug 2022 07:29:56 +0200
Message-ID: <CACT4Y+ZpLmRLouc+q0vMskPQ0-d5LKKwCoKw-twZ8E9W0vqETg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in hugetlb_change_protection
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

,On Wed, 3 Aug 2022 at 23:03, Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Mike,
>
> Thanks for forwarding.
>
> On Wed, Aug 03, 2022 at 10:02:37AM -0700, Mike Kravetz wrote:
> > I'll start looking at this, but adding Peter this may be related to his
> > recent changes.
> > --
> > Mike Kravetz
> >
> > On 08/03/22 08:32, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    e65c6a46df94 Merge tag 'drm-fixes-2022-07-30' of git://ano..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=139cc282080000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=26034e6fe0075dad
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=824e71311e757a9689ff
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 make_pte_marker_entry include/linux/swapops.h:319 [inline]
>
> This is the warning code I added to make sure pte marker won't be created
> if not configured at all:
>
> static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> {
>         /* This should never be called if !CONFIG_PTE_MARKER */
>         WARN_ON_ONCE(1);
>         return swp_entry(0, 0);
> }
>
> The stack below comes from a UFFDIO_WRITEPROTECT, however logically it
> shouldn't really reach there - if with !PTE_MARKER then it must be with
> !PTE_MARKER_UFFD_WP, then we should have returned "false" if hugetlb wanted
> to register with uffd-wp:
>
> static inline bool vma_can_userfault(struct vm_area_struct *vma,
>                                      unsigned long vm_flags)
> {
>         if (vm_flags & VM_UFFD_MINOR)
>                 return is_vm_hugetlb_page(vma) || vma_is_shmem(vma);
>
> #ifndef CONFIG_PTE_MARKER_UFFD_WP
>         /*
>          * If user requested uffd-wp but not enabled pte markers for
>          * uffd-wp, then shmem & hugetlbfs are not supported but only
>          * anonymous.
>          */
>         if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
>                 return false;
> #endif
>         return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
>             vma_is_shmem(vma);
> }
>
> Then the UFFDIO_WRITEPROTECT should have failed already.. at:
>
>         if (!userfaultfd_wp(dst_vma))
>                 goto out_unlock;
>
> in mwriteprotect_range().
>
> I still have no idea how the bot managed to trigger a real wr-protect upon
> this vma (which I don't think should have registered with uffd-wp but maybe
> it can be worked around somehow..).  However to make this even safer we can
> also guard the pte marker callers with CONFIG_PTE_MARKER_UFFD_WP. Patch
> attached for that, but since this seems to have no reproducer yet maybe no
> easy way to verify it.
>
> At the meantime, I'd also like to double check the kernel config to make
> sure CONFIG_PTE_MARKER_UFFD_WP will always be unset when CONFIG_PTE_MARKER=n.
> Anyone knows where I can fetch the config somewhere?

Hi Peter,

If you mean the kernel config for the kernel that produces the
WARNING, it's in the report above under the "kernel config" link.

Note that so far it was triggered only once:
https://syzkaller.appspot.com/bug?extid=824e71311e757a9689ff
which may suggest a very narrow race condition.



> Thanks,
>
> > > WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 make_pte_marker include/linux/swapops.h:342 [inline]
> > > WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 hugetlb_change_protection+0xf85/0x1610 mm/hugetlb.c:6392
> > > Modules linked in:
> > > CPU: 1 PID: 28745 Comm: syz-executor.3 Not tainted 5.19.0-rc8-syzkaller-00146-ge65c6a46df94 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > > RIP: 0010:make_pte_marker_entry include/linux/swapops.h:319 [inline]
> > > RIP: 0010:make_pte_marker include/linux/swapops.h:342 [inline]
> > > RIP: 0010:hugetlb_change_protection+0xf85/0x1610 mm/hugetlb.c:6392
> > > Code: e8 d0 5a b7 ff 0f b6 94 24 80 00 00 00 48 8b 84 24 98 00 00 00 84 d2 0f 84 ef 02 00 00 49 89 c4 e9 48 fb ff ff e8 ab 5e b7 ff <0f> 0b 48 b9 00 00 00 00 00 fc ff df 48 89 d8 48 c1 e8 03 80 3c 08
> > > RSP: 0018:ffffc90014cc7780 EFLAGS: 00010212
> > > RAX: 000000000000082a RBX: ffff88807750e820 RCX: ffffc90006723000
> > > RDX: 0000000000040000 RSI: ffffffff81c30c25 RDI: 0000000000000007
> > > RBP: ffff888074de5ea0 R08: 0000000000000007 R09: 0000000000000000
> > > R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000000000004 R15: ffff88801fcc8e00
> > > FS:  0000000000000000(0000) GS:ffff8880b9b00000(0063) knlGS:00000000f7f06b40
> > > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > > CR2: 0000000020000040 CR3: 000000001b84c000 CR4: 00000000003526e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  change_protection+0x96b/0x3ad0 mm/mprotect.c:463
> > >  mwriteprotect_range+0x387/0x5c0 mm/userfaultfd.c:759
> > >  userfaultfd_writeprotect fs/userfaultfd.c:1823 [inline]
> > >  userfaultfd_ioctl+0x438/0x4340 fs/userfaultfd.c:1997
> > >  compat_ptr_ioctl+0x67/0x90 fs/ioctl.c:906
> > >  __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:968
> > >  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> > >  __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
> > >  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> > >  entry_SYSENTER_compat_after_hwframe+0x70/0x82
> > > RIP: 0023:0xf7f0b549
> > > Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> > > RSP: 002b:00000000f7f065cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000c018aa06
> > > RDX: 00000000200000c0 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > >  </TASK>
> > > ----------------
> > > Code disassembly (best guess):
> > >    0:       03 74 c0 01             add    0x1(%rax,%rax,8),%esi
> > >    4:       10 05 03 74 b8 01       adc    %al,0x1b87403(%rip)        # 0x1b8740d
> > >    a:       10 06                   adc    %al,(%rsi)
> > >    c:       03 74 b4 01             add    0x1(%rsp,%rsi,4),%esi
> > >   10:       10 07                   adc    %al,(%rdi)
> > >   12:       03 74 b0 01             add    0x1(%rax,%rsi,4),%esi
> > >   16:       10 08                   adc    %cl,(%rax)
> > >   18:       03 74 d8 01             add    0x1(%rax,%rbx,8),%esi
> > >   1c:       00 00                   add    %al,(%rax)
> > >   1e:       00 00                   add    %al,(%rax)
> > >   20:       00 51 52                add    %dl,0x52(%rcx)
> > >   23:       55                      push   %rbp
> > >   24:       89 e5                   mov    %esp,%ebp
> > >   26:       0f 34                   sysenter
> > >   28:       cd 80                   int    $0x80
> > > * 2a:       5d                      pop    %rbp <-- trapping instruction
> > >   2b:       5a                      pop    %rdx
> > >   2c:       59                      pop    %rcx
> > >   2d:       c3                      retq
> > >   2e:       90                      nop
> > >   2f:       90                      nop
> > >   30:       90                      nop
> > >   31:       90                      nop
> > >   32:       8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
> > >   39:       8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
