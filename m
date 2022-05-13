Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932FC526AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384069AbiEMUMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiEMUMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:12:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6735DA13
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:12:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id a191so8478839pge.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nt40yUzlBHoLUVCBrOlBzxtPmGAd3cELYj+mEwUWwiA=;
        b=VUOI2bSKu2qpEN65hDZ5cqpQGuXOIK8PeJCJQDqRkZ2NOrp66jGtOPFZJJiM64b/QD
         4cgWmyS0Jm0IxqTX0FnJhRiDq+P2AIV10qMoFV3dbp9RVvACwXd9pU43vSpEHu08yGyr
         2SDcXqmR1cgZWD+C9ZLHkmwe9UNJKGEmmxjLNaLLmC1Yq0H7yfAz/TGS4+idjQ1hj72Z
         Rjd42YxBB6+IckPVxlmJJG6ovHEOa4OSNt5ErzEwnOW1qayGT/Hv/w+CBJRnf0KGqIMY
         V9y3VD7hwhtU6A7BJcMw8d+1FB0RXQuQ7BraztqrLu5+LvCPRnVPhs6Jn9EGgSHgLDNc
         MqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nt40yUzlBHoLUVCBrOlBzxtPmGAd3cELYj+mEwUWwiA=;
        b=eFZeyd3HMUwDZODiP7GK5i9GvtFqHx05udNvIONIAcCYYUcgr/5LBiTdVM2dNvHad0
         hxcQju33EVvV9TBOyVDD0v7fEoqAl0pyle6RkKXIYriaC9TDPEQw+0E3aRaFK2KlOJ/Q
         u/z8Dq1R5zr4GhO/OuIfNAI3lRBROoi0PZLqwr85psTAN9GOxl64mQ9c2rIz42YZe/Z1
         NQRkT7PtTbw3c0fEZ7gIZK21GsVsw46ZgOVgWNTuunqE3RNu/4y/EWEVOHCgZTmbhiUx
         CdCpUQmEbQTFf73cd7/cVR1x+hHvKJrISAVxdhV7M076LL0cBROrvibWg6Cy7V0AvO7y
         +AJw==
X-Gm-Message-State: AOAM533czE6MU0Wc5hZqqI+yr+3ETQyEIXT7nUpMO8/pf5mBaeDjQ5/8
        YKhUfEBfeh/9ua2yn3NGRMr9IMqykX8KwIKyfEE=
X-Google-Smtp-Source: ABdhPJyy4FcwjQn9196OysQz7nQ9yIGIdon48WqCwUTozrukU/aF0TOYLaNBOivBpGv3lmWs5VWFlwMi1oDeV6Jth/M=
X-Received: by 2002:a62:e518:0:b0:4fa:9333:ddbd with SMTP id
 n24-20020a62e518000000b004fa9333ddbdmr6050235pff.11.1652472767389; Fri, 13
 May 2022 13:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris> <yt9dk0apbicu.fsf@linux.ibm.com>
In-Reply-To: <yt9dk0apbicu.fsf@linux.ibm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 13 May 2022 13:12:33 -0700
Message-ID: <CAHbLzkr5hWqJ_242kG13bJsdH8Rn1SbJOwnYHg2xxdFF2C-YiQ@mail.gmail.com>
Subject: Re: [PATCH] mapletree-vs-khugepaged
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, May 13, 2022 at 7:47 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>
> Heiko Carstens <hca@linux.ibm.com> writes:
>
> > On Thu, Apr 28, 2022 at 10:20:40AM -0700, Guenter Roeck wrote:
> >> On Wed, Apr 27, 2022 at 03:10:45PM -0700, Andrew Morton wrote:
> >> > Fix mapletree for patch series "Make khugepaged collapse readonly FS THP
> >> > more consistent", v3.
> >> >
> >> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> >> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >>
> >> This patch causes all my sparc64 boot tests to fail. Bisect and crash logs
> >> attached.
> >>
> >> Guenter
> >>
> >> ---
> >> [   12.624703] Unable to handle kernel paging request at virtual address 0e00000000000000
> >> [   12.624793] tsk->{mm,active_mm}->context = 0000000000000005
> >> [   12.624823] tsk->{mm,active_mm}->pgd = fffff800048b8000
> >> [   12.624849]               \|/ ____ \|/
> >> [   12.624849]               "@'/ .. \`@"
> >> [   12.624849]               /_| \__/ |_\
> >> [   12.624849]                  \__U_/
> >> [   12.624874] init(1): Oops [#1]
> >> [   12.625194] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc4-next-20220428 #1
> >> [   12.625421] TSTATE: 0000009911001606 TPC: 00000000005e6330 TNPC: 00000000005e6334 Y: 00000000    Not tainted
> >> [   12.625455] TPC: <mmap_region+0x150/0x700>
> >> [   12.625503] g0: 0000000000619a00 g1: 0000000000000000 g2: fffff8000488b200 g3: 0000000000000000
> >> [   12.625537] g4: fffff8000414a9a0 g5: fffff8001dd3e000 g6: fffff8000414c000 g7: 0000000000000000
> >> [   12.625569] o0: 0000000000000000 o1: 0000000000000000 o2: 0000000001167b68 o3: 0000000000f51bb8
> >> [   12.625601] o4: fffff80100301fff o5: fffff8000414fc20 sp: fffff8000414f341 ret_pc: 00000000005e6310
> >> [   12.625630] RPC: <mmap_region+0x130/0x700>
> >> [   12.625692] l0: fffff8000488b260 l1: 000000000000008b l2: fffff80100302000 l3: 0000000000000000
> >> [   12.625725] l4: fffff80100301fff l5: 0000000000000000 l6: 30812c2a1dd8556f l7: fffff8000414b438
> >> [   12.625762] i0: fffff800044f58a0 i1: fffff801001ec000 i2: 0e00000000000000 i3: 0000000000000075
> >> [   12.625795] i4: 0000000000000000 i5: fffff8000414fde0 i6: fffff8000414f461 i7: 00000000005e6c58
> >> [   12.625833] I7: <do_mmap+0x378/0x500>
> >> [   12.625906] Call Trace:
> >> [   12.626006] [<00000000005e6c58>] do_mmap+0x378/0x500
> >> [   12.626092] [<00000000005bdc98>] vm_mmap_pgoff+0x78/0x100
> >> [   12.626112] [<00000000005e3d24>] ksys_mmap_pgoff+0x164/0x1c0
> >> [   12.626129] [<0000000000406294>] linux_sparc_syscall+0x34/0x44
> >> [   12.626198] Disabling lock debugging due to kernel taint
> >> [   12.626286] Caller[00000000005e6c58]: do_mmap+0x378/0x500
> >> [   12.626335] Caller[00000000005bdc98]: vm_mmap_pgoff+0x78/0x100
> >> [   12.626354] Caller[00000000005e3d24]: ksys_mmap_pgoff+0x164/0x1c0
> >> [   12.626371] Caller[0000000000406294]: linux_sparc_syscall+0x34/0x44
> >> [   12.626390] Caller[fffff8010001d88c]: 0xfffff8010001d88c
> >> [   12.626537] Instruction DUMP:
> >> [   12.626567]  a6100008
> >> [   12.626678]  02c68006
> >> [   12.626685]  01000000
> >> [   12.626690] <c25e8000>
> >> [   12.626696]  80a04012
> >> [   12.626701]  22600077
> >> [   12.626707]  c25ea088
> >> [   12.626712]  22c4c00a
> >> [   12.626717]  f277a7c7
> >> [   12.626728]
> >> [   12.627169] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> >
> > FWIW, same on s390 - linux-next is completely broken. Note: I didn't
> > bisect, but given that the call trace, and even the failing address
> > match, I'm quite confident it is the same reason.
> >
> > Unable to handle kernel pointer dereference in virtual kernel address space
> > Failing address: 0e00000000000000 TEID: 0e00000000000803
> > Fault in home space mode while using kernel ASCE.
> > AS:00000000bac44007 R3:00000001ffff0007 S:00000001fffef800 P:000000000000003d
> > Oops: 0038 ilc:3 [#1] SMP
> > CPU: 3 PID: 79757 Comm: pt_upgrade_race Tainted: G            E K   5.18.0-20220428.rc4.git500.bdc61aad77fa.300.fc35.s390x+next #1
> > Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
> > Krnl PSW : 0704c00180000000 00000000b912c9a2 (mmap_region+0x1a2/0x8a8)
> >            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> > Krnl GPRS: 0000000000000000 0e00000000000000 0000000000000000 0000000000000000
> >            ffffffffffffffff 000000000000000f 00000380016b3d98 0000080000100000
> >            000000008364c100 0000080000000000 0000000000100077 0e00000000000000
> >            00000000909da100 00000380016b3c58 00000000b912c982 00000380016b3b40
> > Krnl Code: 00000000b912c992: a774002c          brc     7,00000000b912c9ea
> >            00000000b912c996: ecb80225007c      cgij    %r11,0,8,00000000b912cde0
> >           #00000000b912c99c: e310f0f80004      lg      %r1,248(%r15)
> >           >00000000b912c9a2: e37010000020      cg      %r7,0(%r1)
> >            00000000b912c9a8: a784010b          brc     8,00000000b912cbbe
> >            00000000b912c9ac: e310f0e80004      lg      %r1,232(%r15)
> >            00000000b912c9b2: ec180013007c      cgij    %r1,0,8,00000000b912c9d8
> >            00000000b912c9b8: e310f0e80004      lg      %r1,232(%r15)
> > Call Trace:
> >  [<00000000b912c9a2>] mmap_region+0x1a2/0x8a8
> > ([<00000000b912c982>] mmap_region+0x182/0x8a8)
> >  [<00000000b912d492>] do_mmap+0x3ea/0x4c8
> >  [<00000000b90fb9cc>] vm_mmap_pgoff+0xd4/0x170
> >  [<00000000b9129c9a>] ksys_mmap_pgoff+0x62/0x238
> >  [<00000000b912a034>] __s390x_sys_old_mmap+0x74/0x98
> >  [<00000000b9a78ff8>] __do_syscall+0x1d8/0x200
> >  [<00000000b9a872a2>] system_call+0x82/0xb0
> > Last Breaking-Event-Address:
> >  [<00000000b9b9e678>] __s390_indirect_jump_r14+0x0/0xc
> > Kernel panic - not syncing: Fatal exception: panic_on_oops
>
> Starting today we're still seeing the same crash with linux-next from
> (next-20220513):
>
> [  211.937897] CPU: 7 PID: 535 Comm: pt_upgrade Not tainted 5.18.0-rc6-11648-g76535d42eb53-dirty #732
> [  211.937902] Unable to handle kernel pointer dereference in virtual kernel address space
> [  211.937903] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> [  211.937906] Failing address: 0e00000000000000 TEID: 0e00000000000803
> [  211.937909] Krnl PSW : 0704c00180000000 0000001ca52f06d6
> [  211.937910] Fault in home space mode while using kernel ASCE.
> [  211.937917] AS:0000001ca6e24007 R3:0000001fffff0007 S:0000001ffffef800 P:000000000000003d
> [  211.937914]  (mmap_region+0x19e/0x848)
> [  211.937929]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [  211.937939] Krnl GPRS: 0000000000000000 0e00000000000000 0000000000000000 0000000000000000
> [  211.937942]            ffffffff00000f0f ffffffffffffffff 0e00000000000000 0000040000001000
> [  211.937945]            0000000083551900 0000040000000000 00000000000000fb 000003800070fc58
> [  211.937947]            000000008f490000 0000000000000000 0000001ca52f06b6 000003800070fb48
> [  211.937959] Krnl Code: 0000001ca52f06c6: a7740021            brc     7,0000001ca52f0708
> [  211.937959]            0000001ca52f06ca: ec6801b3007c        cgij    %r6,0,8,0000001ca52f0a30
> [  211.937959]           #0000001ca52f06d0: e310f0f80004        lg      %r1,248(%r15)
> [  211.937959]           >0000001ca52f06d6: e37010000020        cg      %r7,0(%r1)
> [  211.937959]            0000001ca52f06dc: a78400ea            brc     8,0000001ca52f08b0
> [  211.937959]            0000001ca52f06e0: e310f0f00004        lg      %r1,240(%r15)
> [  211.937959]            0000001ca52f06e6: ec180008007c        cgij    %r1,0,8,0000001ca52f06f6
> [  211.937959]            0000001ca52f06ec: e39010080020        cg      %r9,8(%r1)
> [  211.937973] Call Trace:
> [  211.937975]  [<0000001ca52f06d6>] mmap_region+0x19e/0x848
> [  211.937978] ([<0000001ca52f06b6>] mmap_region+0x17e/0x848)
> [  211.937981]  [<0000001ca52f116a>] do_mmap+0x3ea/0x4c8
> [  211.937983]  [<0000001ca52bed12>] vm_mmap_pgoff+0xda/0x178
> [  211.937987]  [<0000001ca52ed5ea>] ksys_mmap_pgoff+0x62/0x238
> [  211.937989]  [<0000001ca52ed992>] __s390x_sys_old_mmap+0x7a/0xa0
> [  211.937993]  [<0000001ca5c4ef5c>] __do_syscall+0x1d4/0x200
> [  211.937999]  [<0000001ca5c5d572>] system_call+0x82/0xb0
> [  211.938002] Last Breaking-Event-Address:
> [  211.938003]  [<0000001ca5888616>] mas_prev+0xb6/0xc0
> [  211.938010] Oops: 0038 ilc:3 [#2]
> [  211.938011] Kernel panic - not syncing: Fatal exception: panic_on_oops
> [  211.938012] SMP
> [  211.938014] Modules linked in:
> 07: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 0000001C
> A50679A6
>
> IS that issue supposed to be fixed? git bisect pointed me to
>
> # bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
>   'mm-everything' of
>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>
> which isn't really helpful.
>
> Anything we could help with debugging this?

I think this is the same issue. In the initial report, you bisected to
"Fix mapletree for patch series "Make khugepaged collapse readonly FS
THP more consistent", v3.", this was used to fix the build error when
applying "Make khugepaged collapse readonly FS THP more consistent" on
top of Liam's maple tree series. You could find the patch at:
https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next-history/+/41fd8be857ee43f2f466fca7c2b66fea39f6540d%5E%21/mm/mmap.c.
It converted two new khugepaged_enter_vma_merge() calls from Liam's
series to khugepaged_enter_vma().

Then the "Make khugepaged collapse readonly FS THP more consistent"
was dropped due to some other reasons, and it was re-added around May
11.

Liam's maple tree series added two new khugepaged_enter_vma_merge()
calls, then my series converted khugepaged_enter_vma_merge() to
khugepaged_enter_vma() by patch "mm: khugepaged: make
hugepage_vma_check() non-static" and "mm: khugepaged: introduce
khugepaged_enter_vma() helper".

But the two patches should not change how khugepaged_enter_vma_merge()
works, just rearranged some code. Anyway khugepaged_enter_vma() would
check a lot stuff from vma, if vma is not fully initialized it may
have NULL pointer dereference, but the weird thing is it works for x86
(sorry, I just have x86 machine for testing).

So I'm not sure whether the failure is caused by Liam's patch or mine.
So, could you please apply the blow debug patch then try to boot?
Thanks.

diff --git a/mm/mmap.c b/mm/mmap.c
index 67aa1d2a959b..7b860ad9d847 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2651,10 +2651,8 @@ unsigned long mmap_region(struct file *file,
unsigned long addr,

        /* Actually expand, if possible */
        if (vma &&
-           !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-               khugepaged_enter_vma(vma, vm_flags);
+           !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next))
                goto expanded;
-       }

        mas.index = addr;
        mas.last = end - 1;
@@ -3074,7 +3072,6 @@ static int do_brk_flags(struct ma_state *mas,
struct vm_area_struct *vma,
                        anon_vma_interval_tree_post_update_vma(vma);
                        anon_vma_unlock_write(vma->anon_vma);
                }
-               khugepaged_enter_vma(vma, flags);
                goto out;
        }

>
> Thanks
> Sven
>
