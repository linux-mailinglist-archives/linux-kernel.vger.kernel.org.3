Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E829754D381
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349911AbiFOVRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349919AbiFOVRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:17:39 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E43BF55
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:17:36 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id j39so12961460vsv.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GUIT1vqvv3V8seFbVZNTO1ARaGDvndthM8JRGSxc/J8=;
        b=Cd8l/vOrCZXKD4K4O7qchiKbzPoQdmD0ecKW7uvFVl7QA65YwVBcmreew+2XisLyqy
         lEFxpuAHeNK2zHj0xm6CjZEba8gwQxPndIEecdotsEbWARIY2NlArXGUg5mQOS/8WgIi
         prp2Zo3q17hzLuPv21fyMDQYT8vHoMaT+M/aZnOnBDRDWZMV7tXpueRAGuVcG/Bojb6r
         +ZPg+PJr7UB/GLJsjvgPa1AUl+UV5SRpGQsT2AWbPE28alngedUC5Dpu7GDMOxuas+I8
         7JZV3Mpms/ySNWhZHd1734d8zJTInsdA+mgqVauFGblV/EurH+Pl5HOVve6RXG9NTmPS
         WNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUIT1vqvv3V8seFbVZNTO1ARaGDvndthM8JRGSxc/J8=;
        b=bF835Pzu9iiDT7JmQiWAOHNKSZMIyzIowZq4dshLshwjL4G8HJovgaUUNvQeyoBgqH
         0/t9m+z5pUQFh1KzX3VlEixhuA380lLjtW3XZSVlMMRI+XpwE8mC0d3x2gG+yYs7+cZL
         3du43qZVkJmYk7vVWZ+eVGu2OoT0l8qnTxqc9fqF0arbwEtVmypG5pKnSxIBi1mTAMP1
         uXKikCQBfAZrXBqCpuy+Q8GWIRD6JnfAy+tLJd2LhbgrptP4YFDdw/nPcMbfNX2s1VF9
         xIDVa1aZh6f0DBVwwUkajYL6juBsfFAaeHh8Un5sbMtEFTzxi+Vmj02uFBTHplPrA6Ll
         BRnA==
X-Gm-Message-State: AJIora+Nh7MeQ4bT7u+DfwZqQ0HrVIJJE1k3GEmSSwxfXOVKtziNcJNX
        0yurpnSN3G2TsI/4pRmi4F+SWivKRu1RY4q5VPhX0w==
X-Google-Smtp-Source: AGRyM1u2zBUmwdJorHNhqevYp67/A7UFgHfr7Vv12xghzQ4kvPK9NyVlY6UG2Kl9AQLkvr9hN48s78ryg31ErIoH0Xs=
X-Received: by 2002:a67:f3d0:0:b0:34b:b52d:d676 with SMTP id
 j16-20020a67f3d0000000b0034bb52dd676mr879697vsn.6.1655327855127; Wed, 15 Jun
 2022 14:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com> <20220504011345.662299-13-Liam.Howlett@oracle.com>
 <Yp3udPy0vuDK8khc@qian> <20220606161940.fh5edq5nyz4jru2u@revolver>
 <Yp4uD8uWB3rit/Ee@qian> <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
 <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
 <20220615142508.mtp65w6tdiurtvcn@revolver> <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
 <20220615185500.i5bzt7srzm6q72na@revolver> <CAOUHufY5dBrNc81oDnmKSyRY2d3=e0CZJiXaOUBs=LFoUBDJUg@mail.gmail.com>
In-Reply-To: <CAOUHufY5dBrNc81oDnmKSyRY2d3=e0CZJiXaOUBs=LFoUBDJUg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 15 Jun 2022 15:16:59 -0600
Message-ID: <CAOUHufZa9G2VDHLPsNmp3yRyXqYCE-3-nT6P7+uf-gbgyOHXYQ@mail.gmail.com>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Wed, Jun 15, 2022 at 1:05 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Jun 15, 2022 at 12:55 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> >
> > * Yu Zhao <yuzhao@google.com> [220615 14:08]:
> > > On Wed, Jun 15, 2022 at 8:25 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > > >
> > > > * Yu Zhao <yuzhao@google.com> [220611 17:50]:
> > > > > On Sat, Jun 11, 2022 at 2:11 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 6, 2022 at 10:40 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 06, 2022 at 04:19:52PM +0000, Liam Howlett wrote:
> > > > > > > > Does your syscall fuzzer create a reproducer?  This looks like arm64
> > > > > > > > and says 5.18.0-next-20220603 again.  Was this bisected to the patch
> > > > > > > > above?
> > > > > > >
> > > > > > > This was triggered by running the fuzzer over the weekend.
> > > > > > >
> > > > > > > $ trinity -C 160
> > > > > > >
> > > > > > > No bisection was done. It was only brought up here because the trace
> > > > > > > pointed to do_mas_munmap() which was introduced here.
> > > > > >
> > > > > > Liam,
> > > > > >
> > > > > > I'm getting a similar crash on arm64 -- the allocator is madvise(),
> > > > > > not mprotect(). Please take a look.
> > > > >
> > > > > Another crash on x86_64, which seems different:
> > > >
> > > > Thanks for this.  I was able to reproduce the other crashes that you and
> > > > Qian reported.  I've sent out a patch set to Andrew to apply to the
> > > > branch which includes the fix for them and an unrelated issue discovered
> > > > when I wrote the testcases to cover what was going on here.
> > >
> > > Thanks. I'm restarting the test and will report the results in a few hours.
> > >
> > > > > BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> > > > > Write of size 136 at addr ffff88c5a2319c80 by task stress-ng/18461
> > >                                                        ^^^^^^^^^
> > >
> > > > As for this crash, I was unable to reproduce and the code I just sent
> > > > out changes this code a lot.  Was this running with "trinity -c madvise"
> > > > or another use case/fuzzer?
> > >
> > > This is also stress-ng (same as the one on arm64). The test stopped
> > > before it could try syzkaller (fuzzer).
> >
> > Thanks.  What are the arguments to stress-ng you use?  I've run
> > "stress-ng --class vm -a 20 -t 600s --temp-path /tmp" until it OOMs on
> > my vm, but it only has 8GB of ram.
>
> Yes, I used the same parameters with 512GB of RAM, and the kernel with
> KASAN and other debug options.

Sorry, Liam. I got the same crash :(

9d27f2f1487a (tag: mm-everything-2022-06-14-19-05, akpm/mm-everything)
00d4d7b519d6 fs/userfaultfd: Fix vma iteration in mas_for_each() loop
55140693394d maple_tree: Make mas_prealloc() error checking more generic
2d7e7c2fcf16 maple_tree: Fix mt_destroy_walk() on full non-leaf non-alloc nodes
4d4472148ccd maple_tree: Change spanning store to work on larger trees
ea36bcc14c00 test_maple_tree: Add tests for preallocations and large
spanning writes
0d2aa86ead4f mm/mlock: Drop dead code in count_mm_mlocked_page_nr()

==================================================================
BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
Write of size 136 at addr ffff88c35a3b9e80 by task stress-ng/19303

CPU: 66 PID: 19303 Comm: stress-ng Tainted: G S        I       5.19.0-smp-DEV #1
Call Trace:
 <TASK>
 dump_stack_lvl+0xc5/0xf4
 print_address_description+0x7f/0x460
 print_report+0x10b/0x240
 ? mab_mas_cp+0x2d9/0x6c0
 kasan_report+0xe6/0x110
 ? mast_spanning_rebalance+0x2634/0x29b0
 ? mab_mas_cp+0x2d9/0x6c0
 kasan_check_range+0x2ef/0x310
 ? mab_mas_cp+0x2d9/0x6c0
 ? mab_mas_cp+0x2d9/0x6c0
 memcpy+0x44/0x70
 mab_mas_cp+0x2d9/0x6c0
 mas_spanning_rebalance+0x1a3e/0x4f90
 ? stack_trace_save+0xca/0x160
 ? stack_trace_save+0xca/0x160
 mas_wr_spanning_store+0x16c5/0x1b80
 mas_wr_store_entry+0xbf9/0x12e0
 mas_store_prealloc+0x205/0x3c0
 do_mas_align_munmap+0x6cf/0xd10
 do_mas_munmap+0x1bb/0x210
 ? down_write_killable+0xa6/0x110
 __vm_munmap+0x1c4/0x270
 __x64_sys_munmap+0x60/0x70
 do_syscall_64+0x44/0xa0
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x589827
Code: 00 00 00 48 c7 c2 98 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff
ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 98 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee601ec08 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000400000000000 RCX: 0000000000589827
RDX: 0000000000000000 RSI: 00007ffffffff000 RDI: 0000000000000000
RBP: 00000000004cf000 R08: 00007ffee601ec40 R09: 0000000000923bf0
R10: 0000000000000008 R11: 0000000000000206 R12: 0000000000001000
R13: 00000000004cf040 R14: 0000000000000002 R15: 00007ffee601ed58
 </TASK>

Allocated by task 19303:
 __kasan_slab_alloc+0xaf/0xe0
 kmem_cache_alloc_bulk+0x261/0x360
 mas_alloc_nodes+0x2d7/0x4d0
 mas_preallocate+0xe2/0x230
 do_mas_align_munmap+0x1ce/0xd10
 do_mas_munmap+0x1bb/0x210
 __vm_munmap+0x1c4/0x270
 __x64_sys_munmap+0x60/0x70
 do_syscall_64+0x44/0xa0
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88c35a3b9e00
 which belongs to the cache maple_node of size 256
The buggy address is located 128 bytes inside of
 256-byte region [ffff88c35a3b9e00, ffff88c35a3b9f00)

The buggy address belongs to the physical page:
page:00000000325428b6 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x435a3b9
flags: 0x1400000000000200(slab|node=1|zone=1)
raw: 1400000000000200 ffffea010d71a5c8 ffffea010d71dec8 ffff88810004ff00
raw: 0000000000000000 ffff88c35a3b9000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88c35a3b9e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88c35a3b9e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88c35a3b9f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88c35a3b9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88c35a3ba000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
