Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C52F5477BF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 23:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiFKVuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 17:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFKVuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 17:50:16 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63016B0AE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:50:15 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id f13so2530619vsp.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FxRAnApl9O9gl/NzwDHlcZtmDBjvFMwKmdyfegMAGc=;
        b=sm3ibBex4lRMcmvPiQTDSpGYwGMr1sZr7UTpdNdPDjt/jcS0WHoTa08VHubIXIAlnq
         /DD6KIFB3hkMfp1znswwKGLw044QrXAj7HVmy/Qv+2Vf8YyIB2xbVmDrmXlae9b2Dtxv
         tK1dWCrKg9VvGWJVZFujsq+35cOagMmX7uXCcFhIHChxKC/GRhdYavSKGO2d42C8csjr
         vYkrNo7mBihZQBFXUTrLBO+XZ9F0cWqy8+StVQaQWcyAouvxU8sm6ixZqWT2HY8+QfUg
         7NIDRF0fs5WTgY8cih/nY1pnMjt0TzoE4MLsSIBrt0mWNwq+FymX/WoPdqJ3OiZTgJWI
         +ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FxRAnApl9O9gl/NzwDHlcZtmDBjvFMwKmdyfegMAGc=;
        b=IjYDSLkJejVk1pfGdD/XsEGnjs+KU4vVCgfYupvK5B8IVnlapbPBatI8U8pmZKzMfK
         o9xxJinUdq+Wa/2UACPJO4Po7HdaA33zU5oRsKvwLDERNDfSdCgQAdOthR9ejlDKC0uf
         oslDEmGRZ4hTPhEmuD47wqlhuwFzfjF+qaePeZz4kRGgYEnui+eV3bXxKtROi5JHA33L
         xS7N6KbnH7SoCHbSASe4V1eOBEtnBXgyfAf+cWfKaxCxuayVGeVO4nvb+Z9rMBxC/gSz
         4o9gmW5BCZ8YtTMmuLAxvHh9ZHcVWt/QsM1jsl9s/D0t+jhCDfTnpVW10j6i60pdkvu/
         PC4w==
X-Gm-Message-State: AOAM530KOiJLJ5vEOw3GBABMpqeCfdoVGR1OgD7eSmGrcnzcjnaAIrfk
        1FPhW/O5GzzAfI8dfiCsG3ly82R4hcNRFbZpzrz0yQ==
X-Google-Smtp-Source: ABdhPJwlJrKcevOr0rHdmUJ6fKPcoVbOLPzsIXOzCG2vctXy9URDKiK9K2K4Up1HqmZ7TwT/goqsS7bI5mexkF/yYVg=
X-Received: by 2002:a05:6102:214c:b0:34b:b31d:1a50 with SMTP id
 h12-20020a056102214c00b0034bb31d1a50mr15257615vsg.41.1654984214792; Sat, 11
 Jun 2022 14:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com> <20220504011345.662299-13-Liam.Howlett@oracle.com>
 <Yp3udPy0vuDK8khc@qian> <20220606161940.fh5edq5nyz4jru2u@revolver>
 <Yp4uD8uWB3rit/Ee@qian> <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
In-Reply-To: <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 11 Jun 2022 15:49:38 -0600
Message-ID: <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
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

On Sat, Jun 11, 2022 at 2:11 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Jun 6, 2022 at 10:40 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
> >
> > On Mon, Jun 06, 2022 at 04:19:52PM +0000, Liam Howlett wrote:
> > > Does your syscall fuzzer create a reproducer?  This looks like arm64
> > > and says 5.18.0-next-20220603 again.  Was this bisected to the patch
> > > above?
> >
> > This was triggered by running the fuzzer over the weekend.
> >
> > $ trinity -C 160
> >
> > No bisection was done. It was only brought up here because the trace
> > pointed to do_mas_munmap() which was introduced here.
>
> Liam,
>
> I'm getting a similar crash on arm64 -- the allocator is madvise(),
> not mprotect(). Please take a look.

Another crash on x86_64, which seems different:

==================================================================
BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
Write of size 136 at addr ffff88c5a2319c80 by task stress-ng/18461

CPU: 66 PID: 18461 Comm: stress-ng Tainted: G S        I       5.19.0-smp-DEV #1
Call Trace:
 <TASK>
 dump_stack_lvl+0xc5/0xf4
 print_address_description+0x7f/0x460
 print_report+0x10b/0x240
 ? mab_mas_cp+0x2d9/0x6c0
 kasan_report+0xe6/0x110
 ? mab_mas_cp+0x2d9/0x6c0
 kasan_check_range+0x2ef/0x310
 ? mab_mas_cp+0x2d9/0x6c0
 memcpy+0x44/0x70
 mab_mas_cp+0x2d9/0x6c0
 mas_spanning_rebalance+0x1a45/0x4d70
 ? stack_trace_save+0xca/0x160
 ? stack_trace_save+0xca/0x160
 mas_wr_spanning_store+0x16a4/0x1ad0
 mas_wr_spanning_store+0x16a4/0x1ad0
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
RSP: 002b:00007fff9276c518 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000400000000000 RCX: 0000000000589827
RDX: 0000000000000000 RSI: 00007ffffffff000 RDI: 0000000000000000
RBP: 00000000004cf000 R08: 00007fff9276c550 R09: 0000000000923bf0
R10: 0000000000000008 R11: 0000000000000206 R12: 0000000000001000
R13: 00000000004cf040 R14: 0000000000000004 R15: 00007fff9276c668
 </TASK>

Allocated by task 18461:
 __kasan_slab_alloc+0xaf/0xe0
 kmem_cache_alloc_bulk+0x261/0x360
 mas_alloc_nodes+0x2d7/0x4d0
 mas_preallocate+0xe0/0x220
 do_mas_align_munmap+0x1ce/0xd10
 do_mas_munmap+0x1bb/0x210
 __vm_munmap+0x1c4/0x270
 __x64_sys_munmap+0x60/0x70
 do_syscall_64+0x44/0xa0
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88c5a2319c00
 which belongs to the cache maple_node of size 256
The buggy address is located 128 bytes inside of
 256-byte region [ffff88c5a2319c00, ffff88c5a2319d00)

The buggy address belongs to the physical page:
page:000000000a5cfe8b refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x45a2319
flags: 0x1400000000000200(slab|node=1|zone=1)
raw: 1400000000000200 ffffea01168dea88 ffffea0116951f48 ffff88810004ff00
raw: 0000000000000000 ffff88c5a2319000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88c5a2319c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88c5a2319c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88c5a2319d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88c5a2319d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88c5a2319e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
