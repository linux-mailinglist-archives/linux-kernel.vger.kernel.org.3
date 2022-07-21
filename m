Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0957C1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiGUBAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGUA77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:59:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948873919;
        Wed, 20 Jul 2022 17:59:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id va17so568567ejb.0;
        Wed, 20 Jul 2022 17:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hViWjF/I1R4hCcCcryP6mPbMLMwJNsrP9GvF7zpczDs=;
        b=A5spFfm8f4L4ed3O4vn2vkaxH3hp9OMAuO+RyO/1jYzAN0P/5J/cjqbC+4+OKY0Dkh
         l5ofD4xwnhFsH98q2w74Q2xC65vGVAQp9Q3J6iOiOcjj0dA5e2aeAdIOnnP5x5GMdKQ6
         sFoIykgWn5MSrL8C34opOcGeZ0pib//y0AP1OrU6HX10KfLl/53na0unUOjXSd8tQM4y
         rnBcCTfA3S0QvKXP+EC7a6lvdgoGXbVBjtwcfnhcHsjZgz8ZuSNf/ig7x0kWSkpOODUV
         vcLGIl1wGuSJo9vdE7zCUHai0phCSEopcPT07Y3z+ycmfjXEPEJMbd4UlA8+aymwT2jc
         UbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hViWjF/I1R4hCcCcryP6mPbMLMwJNsrP9GvF7zpczDs=;
        b=IaRkfKWDgk/0BrBa8Ez46LeELaodh+Zqf4Pm/Nd/wNcCxRaJwTaUPxzG3jHzbXm8WY
         jP+C/ufIgRy2IvmtVXBaPAFZR+CtlfCMI0BYoJHEQSc+57I37eaV3iuXzoh6HIduhiJ1
         0W8v7X2T8iBD3q7xPLp8Xxx86iLrZjsEV3hCOGWeuWd4U9sY3nPxpXjajB10t6yPZmpr
         YjPxHm7UXRCl6mAzZEbDuaPq+iM0iWMqmp8fejtLMOGWV9LTWAuSDpkvxMXiABvUgN+R
         B8G17cBmfkIa6tjODsaJBS/9WgqCoM2+NBZmEUUBnhvKJYAvKYKas9cBr3hj+Or8QT+D
         w6aw==
X-Gm-Message-State: AJIora/zlwlB/fI0F9D8ILKFyTy2fYh/2eJuF5+E2hjROxNyFCbg9VUB
        s613VwT5KJkqinCwVE3oojnE8cRW65uvmDj0swk=
X-Google-Smtp-Source: AGRyM1sBgOper2kOyuae8SYOQAE9pbGxgmjR3hxNpemBUWxYwzm8aKv0Q2NSZR+HunIRuCBlmU9JZjZqpKEeCtRNSTY=
X-Received: by 2002:a17:907:6e0e:b0:72b:9ec4:2ba2 with SMTP id
 sd14-20020a1709076e0e00b0072b9ec42ba2mr36744544ejc.300.1658365195884; Wed, 20
 Jul 2022 17:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK-7J+fkLceCTCqGoz_tNcN85iDVsMjeecfBZ-Eq9ZE5qVj3A@mail.gmail.com>
 <YtScSS/uqhL0+5S3@casper.infradead.org>
In-Reply-To: <YtScSS/uqhL0+5S3@casper.infradead.org>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Wed, 20 Jul 2022 17:59:44 -0700
Message-ID: <CANX2M5btE1kCoXMN_hH6iBhQ9ox0124HmHYicpG7k5dA1a9i5w@mail.gmail.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Read in cleanup_bitmap_list
To:     Matthew Wilcox <willy@infradead.org>
Cc:     jlayton@kernel.org, neilb@suse.de,
        damien.lemoal@opensource.wdc.com, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Content-Type: multipart/mixed; boundary="00000000000068e44805e4463c16"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000068e44805e4463c16
Content-Type: text/plain; charset="UTF-8"

On Sun, Jul 17, 2022 at 4:33 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jul 17, 2022 at 03:24:33PM -0700, Dipanjan Das wrote:
> > Hi,
> >
> > We would like to report the following bug which has been found by our
> > modified version of syzkaller.
>
> Modified how?

We are from an academic research group. The bugs we are reporting are
the outcome of an academic research project. Since this is a work-in-progress,
which is why, we cannot unfortunately reveal much details at the moment.

> Something you need to understand is that we are
> _drowning_ in syzbot bug reports.  We are not short on bugs to fix, we
> are short on people to fix them.  Having a new source of bug reports
> is just not helpful.

We understand the frustration. We deeply apologize for our last bug report
not being very helpful. We struggled a bit to come up with a syzkaller
reproducer.
Please find it attached. The repro needs to be run like:

./syz-execprog -executor=./syz-executor -repeat=0 -procs=16 -cover=0 repro.syz

Unfortunately, the repro is not "one-shot", it takes 1K-2K executions
(which syz-execprog  will do anyway)
to trigger the bug which takes less than five minutes for us. Please
let us know if/what more we can do
to help the developers root cause/fix the issue.

> If you're generating these bug reports by fuzzing a filesystem image,
> then I can see how it happens.  If it's a normal filesystem image,
> then the code looks fine.

We are not specifically mutating the filesystem image as part of our
modification.
That said, it seems syzkaller's syz_mount_image pseudo syscall already generates
filesystem images on the fly. Therefore, your first suspicion may very
well be correct.

>
> The obvious integer overflow is:
>
>                                    unsigned int bmap_nr)
> ...
>         int mem = bmap_nr * sizeof(struct reiserfs_bitmap_node *);
>
> but I don't even know if that's where to look.
>
> > ======================================================
> > description: KASAN: vmalloc-out-of-bounds Read in cleanup_bitmap_list
> > affected file: fs/reiserfs/journal.c
> > kernel version: 5.19-rc6
> > kernel commit: 32346491ddf24599decca06190ebca03ff9de7f8
> > git tree: upstream
> > kernel config: attached
> > crash reproducer: none
> > ======================================================
> > Crash log:
> >
> > BUG: KASAN: vmalloc-out-of-bounds in
> > cleanup_bitmap_list.isra.0.part.0+0x4a0/0x5e0
> > fs/reiserfs/journal.c:231
> > Read of size 8 at addr ffffc900136dd008 by task syz-executor.2/13172
> >
> > CPU: 0 PID: 13172 Comm: syz-executor.2 Tainted: G           OE
> > 5.19.0-rc6-g2eae0556bb9d #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1.1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  print_address_description mm/kasan/report.c:313 [inline]
> >  print_report.cold+0x176/0x659 mm/kasan/report.c:429
> >  kasan_report+0x8a/0x1b0 mm/kasan/report.c:491
> >  cleanup_bitmap_list.isra.0.part.0+0x4a0/0x5e0 fs/reiserfs/journal.c:231
> >  cleanup_bitmap_list fs/reiserfs/journal.c:227 [inline]
> >  free_list_bitmaps+0x68/0x100 fs/reiserfs/journal.c:249
> >  free_journal_ram+0xfc/0x500 fs/reiserfs/journal.c:1887
> >  do_journal_release fs/reiserfs/journal.c:1960 [inline]
> >  journal_release_error+0x72/0x90 fs/reiserfs/journal.c:1978
> >  reiserfs_fill_super+0x114d/0x2f10 fs/reiserfs/super.c:2225
> >  mount_bdev+0x34d/0x410 fs/super.c:1367
> >  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
> >  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
> >  do_new_mount fs/namespace.c:3040 [inline]
> >  path_mount+0x1228/0x1cb0 fs/namespace.c:3370
> >  do_mount+0xf3/0x110 fs/namespace.c:3383
> >  __do_sys_mount fs/namespace.c:3591 [inline]
> >  __se_sys_mount fs/namespace.c:3568 [inline]
> >  __x64_sys_mount+0x18f/0x230 fs/namespace.c:3568
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f121408fe8e
> > Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> > 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> > 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f121266a9f8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> > RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f121408fe8e
> > RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f121266aa50
> > RBP: 00007f121266aa90 R08: 00007f121266aa90 R09: 0000000020000000
> > R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
> > R13: 0000000020000100 R14: 00007f121266aa50 R15: 0000000020000040
> >  </TASK>
> >
> > The buggy address belongs to the virtual mapping at
> >  [ffffc900136dd000, ffffc900136df000) created by:
> >  reiserfs_allocate_list_bitmaps+0x54/0x100 fs/reiserfs/journal.c:290
> >
> > The buggy address belongs to the physical page:
> > page:ffffea00054c2700 refcount:1 mapcount:0 mapping:0000000000000000
> > index:0x0 pfn:0x15309c
> > flags: 0x17ff00000000000(node=0|zone=2|lastcpupid=0x7ff)
> > raw: 017ff00000000000 0000000000000000 dead000000000122 0000000000000000
> > raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask
> > 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 13172,
> > tgid 13167 (syz-executor.2), ts 141798727963, free_ts 133661424124
> >  set_page_owner include/linux/page_owner.h:31 [inline]
> >  post_alloc_hook mm/page_alloc.c:2449 [inline]
> >  prep_new_page+0x297/0x330 mm/page_alloc.c:2456
> >  get_page_from_freelist+0x2142/0x3c80 mm/page_alloc.c:4198
> >  __alloc_pages+0x321/0x710 mm/page_alloc.c:5426
> >  __alloc_pages_bulk+0x974/0x1590 mm/page_alloc.c:5374
> >  alloc_pages_bulk_array_mempolicy+0x12d/0x430 mm/mempolicy.c:2367
> >  vm_area_alloc_pages mm/vmalloc.c:2899 [inline]
> >  __vmalloc_area_node mm/vmalloc.c:2995 [inline]
> >  __vmalloc_node_range+0x52f/0x1360 mm/vmalloc.c:3165
> >  __vmalloc_node mm/vmalloc.c:3230 [inline]
> >  vzalloc+0x67/0x80 mm/vmalloc.c:3303
> >  reiserfs_allocate_list_bitmaps+0x54/0x100 fs/reiserfs/journal.c:290
> >  journal_init+0x3ca/0x64d0 fs/reiserfs/journal.c:2732
> >  reiserfs_fill_super+0xbbb/0x2f10 fs/reiserfs/super.c:2024
> >  mount_bdev+0x34d/0x410 fs/super.c:1367
> >  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
> >  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
> >  do_new_mount fs/namespace.c:3040 [inline]
> >  path_mount+0x1228/0x1cb0 fs/namespace.c:3370
> >  do_mount+0xf3/0x110 fs/namespace.c:3383
> >  __do_sys_mount fs/namespace.c:3591 [inline]
> >  __se_sys_mount fs/namespace.c:3568 [inline]
> >  __x64_sys_mount+0x18f/0x230 fs/namespace.c:3568
> > page last free stack trace:
> >  reset_page_owner include/linux/page_owner.h:24 [inline]
> >  free_pages_prepare mm/page_alloc.c:1371 [inline]
> >  free_pcp_prepare+0x51f/0xd00 mm/page_alloc.c:1421
> >  free_unref_page_prepare mm/page_alloc.c:3343 [inline]
> >  free_unref_page+0x19/0x5b0 mm/page_alloc.c:3438
> >  kasan_depopulate_vmalloc_pte+0x5c/0x70 mm/kasan/shadow.c:359
> >  apply_to_pte_range mm/memory.c:2625 [inline]
> >  apply_to_pmd_range mm/memory.c:2669 [inline]
> >  apply_to_pud_range mm/memory.c:2705 [inline]
> >  apply_to_p4d_range mm/memory.c:2741 [inline]
> >  __apply_to_page_range+0x66e/0xf50 mm/memory.c:2775
> >  kasan_release_vmalloc+0xa2/0xb0 mm/kasan/shadow.c:469
> >  __purge_vmap_area_lazy+0x8fe/0x1c90 mm/vmalloc.c:1722
> >  drain_vmap_area_work+0x52/0xe0 mm/vmalloc.c:1751
> >  process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
> >  worker_thread+0x623/0x1070 kernel/workqueue.c:2436
> >  kthread+0x2e9/0x3a0 kernel/kthread.c:376
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> >
> > Memory state around the buggy address:
> >  ffffc900136dcf00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> >  ffffc900136dcf80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > >ffffc900136dd000: 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> >                       ^
> >  ffffc900136dd080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> >  ffffc900136dd100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > ==================================================================
> >
> > --
> > Thanks & Regards,
> >
> > Dipanjan
>
>

--00000000000068e44805e4463c16
Content-Type: application/octet-stream; name="repro.syz"
Content-Disposition: attachment; filename="repro.syz"
Content-Transfer-Encoding: base64
Content-ID: <f_l5uazygw0>
X-Attachment-Id: f_l5uazygw0

cjAgPSBvcGVuYXQkdmNzKDB4ZmZmZmZmZmZmZmZmZmY5YywgJigweDdmMDAwMDAwMDA4MCksIDB4
MTQyMDAsIDB4MCkKcjEgPSBzeXpfZ2VuZXRsaW5rX2dldF9mYW1pbHlfaWQkbDJ0cCgmKDB4N2Yw
MDAwMDAwMTAwKSwgMHhmZmZmZmZmZmZmZmZmZmZmKQpyMiA9IG9wZW5hdCR2Y3MoMHhmZmZmZmZm
ZmZmZmZmZjljLCAmKDB4N2YwMDAwMDAwMDgwKSwgMHgxNDIwMCwgMHgwKQpyMyA9IHN5el9nZW5l
dGxpbmtfZ2V0X2ZhbWlseV9pZCRsMnRwKCYoMHg3ZjAwMDAwMDAxMDApLCAweGZmZmZmZmZmZmZm
ZmZmZmYpCnNlbmRtc2ckTDJUUF9DTURfU0VTU0lPTl9HRVQocjIsICYoMHg3ZjAwMDAwMDAyMDAp
PXsmKDB4N2YwMDAwMDAwMGMwKT17MHgxMCwgMHgwLCAweDAsIDB4MjAwMDB9LCAweGMsICYoMHg3
ZjAwMDAwMDAxYzApPXsmKDB4N2YwMDAwMDAwMjgwKT1BTlk9W10sIDB4NTh9LCAweDEsIDB4MCwg
MHgwLCAweDIwMDAwMGQwfSwgMHg0MDAwKQpzZW5kbXNnJEwyVFBfQ01EX1NFU1NJT05fR0VUKHIw
LCAmKDB4N2YwMDAwMDAwMjAwKT17JigweDdmMDAwMDAwMDBjMCk9ezB4MTAsIDB4MCwgMHgwLCAw
eDEwMDAwMDAwfSwgMHhjLCAmKDB4N2YwMDAwMDAwMWMwKT17JigweDdmMDAwMDAwMDI0MCk9QU5Z
PVtAQU5ZQkxPQj0iYWI5NWExODY4ZGNjYTA2MTAxOGNmZWI1MDIwMDAwMDAiLCBAQU5ZUkVTMTY9
cjEsIEBBTllSRVM2ND1yM10sIDB4NTh9LCAweDEsIDB4MCwgMHgwLCAweDIwMDAwMGQwfSwgMHg0
MDAwKQppb2N0bCREUk1fSU9DVExfU1lOQ09CSl9GRF9UT19IQU5ETEVfRkQoMHhmZmZmZmZmZmZm
ZmZmZmZmLCAweGMwMTA2NGMyLCAmKDB4N2YwMDAwMDAwMDQwKT17PHI0PT4weDB9KQppb2N0bCRE
Uk1fSU9DVExfU1lOQ09CSl9SRVNFVChyMCwgMHhjMDEwNjRjNCwgJigweDdmMDAwMDAwMDBjMCk9
eyYoMHg3ZjAwMDAwMDAwODApPVtyNCwgMHgwLCAweDBdLCAweDN9KQpzeXpfbW91bnRfaW1hZ2Uk
cmVpc2VyZnMoJigweDdmMDAwMDAwMDAwMCksICYoMHg3ZjAwMDAwMDAxMDApPScuL2ZpbGUwXHgw
MCcsIDB4MCwgMHgyLCAmKDB4N2YwMDAwMDAwMjAwKT1beyYoMHg3ZjAwMDAwMTAwMDApPSIwMDQw
MDAwMGVjMWYwMDAwMTMyMDAwMDAxMjAwMDAwMDAwMDAwMDAwMDAyMDAwMDAwMDAxMDAwMDYxMWNh
ZDQ5ZTEwMDAwMDAxZTAwMDAwMDAwMDAwMDAwMDAxMGVjMDMwMjAwMDEwMDUyNjU0OTczNDU3MjMz
NDY3MyIsIDB4M2QsIDB4MTAwMDB9LCB7JigweDdmMDAwMDAxMGUwMCk9IjAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDEyMDAwMDAwMDAwMDAwMDAwMDIwMDAwMDAwMDEwMDAwNjExY2FkNDkiLCAweDIw
LCAweDIwMTIwMDB9XSwgMHgwLCAmKDB4N2YwMDAwMDExMTAwKSkKcjUgPSBzeXpfb3Blbl9kZXYk
bG9vcCgmKDB4N2YwMDAwMDAwMWMwKSwgMHgyLCAweDEpCnB3cml0ZXYocjUsICYoMHg3ZjAwMDAw
MDA0MDApPVt7JigweDdmMDAwMDAwMDMwMCk9Ijk3IiwgMHg3ZmZmZjAwMH1dLCAweDEsIDB4ZWRj
LCAweDgwMDAwMDApCnI2ID0gb3BlbmF0JHZjcygweGZmZmZmZmZmZmZmZmZmOWMsICYoMHg3ZjAw
MDAwMDAwODApLCAweDE0MjAwLCAweDApCnI3ID0gc3l6X2dlbmV0bGlua19nZXRfZmFtaWx5X2lk
JGwydHAoJigweDdmMDAwMDAwMDEwMCksIDB4ZmZmZmZmZmZmZmZmZmZmZikKcjggPSBvcGVuYXQk
dmNzKDB4ZmZmZmZmZmZmZmZmZmY5YywgJigweDdmMDAwMDAwMDA4MCksIDB4MTQyMDAsIDB4MCkK
cjkgPSBzeXpfZ2VuZXRsaW5rX2dldF9mYW1pbHlfaWQkbDJ0cCgmKDB4N2YwMDAwMDAwMTAwKSwg
MHhmZmZmZmZmZmZmZmZmZmZmKQpzZW5kbXNnJEwyVFBfQ01EX1NFU1NJT05fR0VUKHI4LCAmKDB4
N2YwMDAwMDAwMjAwKT17JigweDdmMDAwMDAwMDBjMCk9ezB4MTAsIDB4MCwgMHgwLCAweDEwMDAw
MDAwfSwgMHhjLCAmKDB4N2YwMDAwMDAwMWMwKT17JigweDdmMDAwMDAwMDE0MCk9QU5ZPVtAQU5Z
QkxPQj0nWFx4MDBceDAwXHgwMCcsIEBBTllSRVMxNj1yOSwgQEFOWUJMT0I9IjAwMDQyN2JkNzAw
MGZkZGJkZjI1MDgwMDAwMDAwNTAwMTQwMDAwMDAwMDAwMDgwMDBiMDAwMjAwMDAwMDA2MDAwMzAw
MDgwMDAwMDAwNjAwMWMwMDA5MDAwMDAwMDUwMDA0MDAwMDAwMDAwMDA2MDAxZDAwMDkwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAzOSJdLCAweDU4fSwgMHgxLCAweDAsIDB4MCwgMHgyMDAwMDBkMH0s
IDB4NDAwMCkKaW9jdGwkTE9PUF9DT05GSUdVUkUocjgsIDB4NGMwYSwgJigweDdmMDAwMDAwMDU4
MCk9e3I1LCAweDgsIHsweDAsIDB4MCwgMHgwLCAweDksIDB4MCwgMHgwLCAweDYsIDB4ZCwgMHgx
NCwgIjNiMWY0YWM4YWVhOTUzOTk2YWQwNGE1N2UzODAzYmZhNDEyYThjZWQ2MTI4YTAzNWQwNGRk
M2Y4YmE3ODdhNTZhMjNiYzc1ZWJmZDJlOTIwZGMwOTUxZTJlMjI2NWU1ZjBhMTdiNjNhN2VkNDgz
MDE1YTZiYjkwZjNkZDExOTAzIiwgImRlNWQ2ZWQ3OTgxYTJiOGVhOWEyZDYwYTZiYjBhMzRiNzVk
OTJlZTM2ODg0MmNhNWIyYjJlZmY0MmY0NGY1YmUwNWRmOGZkN2EyODg4YTg0Mjg1ZjdmZDM4ODM3
YmNhNGE5OGM0NzY4ZGY5M2NlNmI2NTYxYWI1MmJhMjY5MGE0IiwgIjE1OTJjMjg5OGRiOTc1ZTdm
NmJhNTNlZGY0OGNiMmIxNDhjYWVjOWM1YjkxMjljN2QxNjFhZWQ4YWFmYjYyZWQiLCBbMHgxMDAw
MDAwMDEsIDB4OV19fSkKc2VuZG1zZyRMMlRQX0NNRF9TRVNTSU9OX0dFVChyNiwgJigweDdmMDAw
MDAwMDIwMCk9eyYoMHg3ZjAwMDAwMDAwYzApPXsweDEwLCAweDAsIDB4MCwgMHgxMDAwMDAwMH0s
IDB4YywgJigweDdmMDAwMDAwMDFjMCk9eyYoMHg3ZjAwMDAwMDA0NDApPUFOWT1bQEFOWUJMT0I9
J1hceDAwXHgwMFx4MDAnLCBAQU5ZUkVTMTY9cjcsIEBBTllCTE9CPSIwMDA0MjdiZDcwMDBmZGRi
ZGYyNTA4MDAwMDAwMDUwMDE0MDAwMDAwMDAwNjAwMDMwMDA4MDAwMDAwMDYwMDFjMDAwOTAwZjEw
MDA1YWQ0MzAwMDQwMDAwMDAwMDAwMDYwMDFkMDAwOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDM5
N2EyNTEzOGJmNjk4OTE3OTk4MTUzOWE0Y2RkYTc1MDA5NGIzYzYxMzcwMTBkZmM0ZTA5ZTlhYzk5
YjJkMGNlNTc0Y2JhYWJjYTI4ODhjNGQ3ZDIwZDQ0YjFhMGUwODA3MmY3ODIwYzQ0Mzk3NDhmYTNk
YzIzNTQwMTg1NmM4M2YwODAwNjU5N2ZlNGU4OWRiODM1ZjM1ODc3ZWFhNmY5MzI3ZDU2Zjk0Nzcw
MWUwODNhMzQ5NDAzODc0MjkyNTgxZGIzZDJlZWVmOWE3MjZmYTU0ODdlZWQzZTUxZmFiMmYwNDcw
NTJhZDNiOTFlNDgxMGM4ZTI4Nzg3M2NiZjBkNzg5MGQ0Y2U0YmI3N2Y3YmNkZmY5ZGJmZTIzZWY1
ZWI2YWE0MWZiZWNhNDJkNzc0NDM0M2E2MTkxMDZjOTkyMjA0YWRlMTI5ODI1N2MyYTM4OTdiOGRj
ODcxNDI1YmExOTk4YzNkYjMxOGE3MzQzYTc3ZjE5YTFkZDhlNTcwMCIvMjY1XSwgMHg1OH0sIDB4
MSwgMHgwLCAweDAsIDB4MjAwMDAwZDB9LCAweDQwMDApCmlvY3RsJExPT1BfR0VUX1NUQVRVUzY0
KHI2LCAweDRjMDUsICYoMHg3ZjAwMDAwMDAwMDApKQo=
--00000000000068e44805e4463c16--
