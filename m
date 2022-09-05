Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D11F5ADAEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiIEVjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiIEVji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:39:38 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7C211464
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:39:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a15so6984649qko.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7qVIvFlvWkNvvtVd1M1BtkuWZfdGL7+HAzjBJqQnjRA=;
        b=jUyW+eASCSHN4X0drP9Ma7QhcjFO2rhQHOAZlT0bMehHkcW4GhtyaF5lAzC91Ux5Wz
         umGhPL71ElHP6Pynrl1W5vwYXyzjLfHSRvFn4VPFqN2TtYrKZ1CGU6nFuEzoR0COOhz6
         8UEoHltZ7UnjJGylylZduGgAnXzk61Hw8TiTUE42oSbY0+ixiQeFUHXT2ILCLaPr5PZ4
         14/9YbIdRjJqa5QcujwwJPvftYSEUGq/xhCJf7rv2Bm/jY+Hn5s6cQrWVTEbgzi2L/xN
         Vd0H4gAlA7N3aECwWXm9B2MGVCx297JmfMzCuxPFPT7e7yfqjftwb5EVUwXfEbm/XC2q
         Igtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7qVIvFlvWkNvvtVd1M1BtkuWZfdGL7+HAzjBJqQnjRA=;
        b=VdBNkbc38dFLb/KRwnwwom2BOih8GWQVUD2sPNPwYTdc1yRawnbVvt+qMQg0nBTBDr
         vKFzY40CfM0/JgHVYuoFjJ/K2CkQvWZtvyCrahyHXfwX1uNmYikWd56Dgf+tM/o9LA7v
         d2k7aiSCgjdJA9/IZjt7J5Dso97HtmMdZJ+O2u9dpa3/5hDV+M+dRcDdlLfF1N6E59zY
         O1Gf03pHE3mIBjGyALy3QPH2ACX3QVf/STpm19+jj16L2NVGiozX2A97xnNxmzD2nLIr
         EY6OQKvwQedhZOWT5jYN/zQgmJNBSdFnmicDQ6EZH66xJ9YzN/AI1BfH7THCQn92GU1+
         An9w==
X-Gm-Message-State: ACgBeo0zaovFHjp3qTI3KvmYfUjpGPbvFJ/4Smp9mdZKAY599hgZWkx7
        GdaDoD00eDs/B4T6HdGW2JjF0sn3N3OsOsw6ZNE=
X-Google-Smtp-Source: AA6agR6jZtYB8zYlYHRCxPLuuqavJJT+nNd3G3SbMLm1rgEzXZ36gv3iKG2ehx5Te/9NrfpdYmktoE84Kkc2YuBles8=
X-Received: by 2002:a05:620a:1298:b0:6be:9bec:b555 with SMTP id
 w24-20020a05620a129800b006be9becb555mr23002303qki.146.1662413975229; Mon, 05
 Sep 2022 14:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004387dc05e5888ae5@google.com>
In-Reply-To: <0000000000004387dc05e5888ae5@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 5 Sep 2022 23:39:24 +0200
Message-ID: <CA+fCnZc9u+QrF-JCQSA+uCM9-egh_=9x4hPdJng6T_uh6XWMZQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: invalid-access Read in copy_page
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tongtiangen@huawei.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        syzbot <syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

Syzbot reported an issue with MTE tagging of user pages, see the report below.

Possibly, it's related to your "mm: kasan: Skip unpoisoning of user
pages" series. However, I'm not sure what the issue is.

Do you have any ideas?

Thanks!

On Sat, Aug 6, 2022 at 3:31 AM syzbot
<syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9e2f40233670 Merge tag 'x86_sgx_for_v6.0-2022-08-03.1' of ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16181cbc080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=886e7348b2982e4d
> dashboard link: https://syzkaller.appspot.com/bug?extid=c2c79c6d6eddc5262b77
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: invalid-access in copy_page+0x10/0xd0 arch/arm64/lib/copy_page.S:26
> Read at addr f5ff000017f2e000 by task syz-executor.1/2218
> Pointer tag: [f5], memory tag: [f2]
>
> CPU: 1 PID: 2218 Comm: syz-executor.1 Not tainted 5.19.0-syzkaller-10532-g9e2f40233670 #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace.part.0+0xcc/0xe0 arch/arm64/kernel/stacktrace.c:182
>  dump_backtrace arch/arm64/kernel/stacktrace.c:188 [inline]
>  show_stack+0x18/0x5c arch/arm64/kernel/stacktrace.c:189
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x68/0x84 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:313 [inline]
>  print_report+0xfc/0x5f0 mm/kasan/report.c:429
>  kasan_report+0x8c/0xb0 mm/kasan/report.c:491
>  __do_kernel_fault+0x104/0x1c0 arch/arm64/mm/fault.c:319
>  do_bad_area arch/arm64/mm/fault.c:469 [inline]
>  do_tag_check_fault+0x78/0x90 arch/arm64/mm/fault.c:738
>  do_mem_abort+0x48/0xa0 arch/arm64/mm/fault.c:814
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:366
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:417
>  el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
>  copy_page+0x10/0xd0 arch/arm64/lib/copy_page.S:26
>  copy_user_highpage+0x18/0x4c arch/arm64/mm/copypage.c:34
>  __wp_page_copy_user mm/memory.c:2848 [inline]
>  wp_page_copy+0xa0/0x790 mm/memory.c:3109
>  do_wp_page+0x150/0x6a4 mm/memory.c:3471
>  handle_pte_fault mm/memory.c:4925 [inline]
>  __handle_mm_fault+0x6c4/0xf84 mm/memory.c:5046
>  handle_mm_fault+0xe8/0x25c mm/memory.c:5144
>  __do_page_fault arch/arm64/mm/fault.c:502 [inline]
>  do_page_fault+0x140/0x3b0 arch/arm64/mm/fault.c:602
>  do_mem_abort+0x48/0xa0 arch/arm64/mm/fault.c:814
>  el0_da+0x48/0xbc arch/arm64/kernel/entry-common.c:502
>  el0t_64_sync_handler+0x134/0x1b0 arch/arm64/kernel/entry-common.c:645
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
>
> The buggy address belongs to the physical page:
> page:000000003e6672be refcount:3 mapcount:2 mapping:0000000000000000 index:0xffffffffe pfn:0x57f2e
> memcg:fbff00001ded8000
> anon flags: 0x1ffc2800208001c(uptodate|dirty|lru|swapbacked|arch_2|node=0|zone=0|lastcpupid=0x7ff|kasantag=0xa)
> raw: 01ffc2800208001c fffffc00004f91c8 fcff00001d1b1000 f1ff00000510b231
> raw: 0000000ffffffffe 0000000000000000 0000000300000001 fbff00001ded8000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff000017f2de00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
>  ffff000017f2df00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
> >ffff000017f2e000: f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2
>                    ^
>  ffff000017f2e100: f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2
>  ffff000017f2e200: f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
