Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB458B339
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbiHFBb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 21:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiHFBbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 21:31:23 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D13113D70
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 18:31:22 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id a17-20020a056e0208b100b002dc52b51d98so2729378ilt.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 18:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=kViDafhpg8RBdwcxqN1yEho5G75K5q5OgcgtEcZ2P5E=;
        b=kdzrnZwqgJ+bMZUUe3AApaUBb0HKQe+nuLyFL7Pkn+0Sb2unh78HX0VeGMm8+3H8Ks
         En0MhfWpNzlaudRg2e0kqBF9/zpjm9owC7lebJcQ9qIN27Ru/QuywZfMYz4aVGst3tGI
         dorrkaRDbIoDh+GZfarvPdgGVrc0DY1iksSFMaRfkd4dhenJqEPQZP80e7V8h9ahgNpG
         2aHA0cFmJ4NAmTpBIPCbCi97Z+LpRZe+a7IHJUjK/H/VC0Fk0zCRllqh7AQfUUFSn5l0
         1skhaVu0SNSpb/ROisITCOej0Pg6KMczdsndWh6jdrS7nPtBCMF7Dt75dTDFaUM6w6mP
         3GTQ==
X-Gm-Message-State: ACgBeo2jQkTm0YYlcmSW6+b7gor7Nh9r47q6eF9An7QV4fphC/yRAL0V
        HyN8GaR9/FabMP5TQGaNXT95PI8UR/jw0Rdu+ji0TS1pK/vl
X-Google-Smtp-Source: AA6agR4PyWBvzx+pnDuyDZdmqbDJCCBqB9HliMHsJLBlR1jrIG0SkFjxCnO1JpVviUuVhH9YcNUR/i93hh4S1b8T3wQsPc/B9NCC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f0a:b0:342:7bf2:ee19 with SMTP id
 ck10-20020a0566383f0a00b003427bf2ee19mr4103797jab.192.1659749481543; Fri, 05
 Aug 2022 18:31:21 -0700 (PDT)
Date:   Fri, 05 Aug 2022 18:31:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004387dc05e5888ae5@google.com>
Subject: [syzbot] KASAN: invalid-access Read in copy_page
From:   syzbot <syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tongtiangen@huawei.com,
        vincenzo.frascino@arm.com, wangkefeng.wang@huawei.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9e2f40233670 Merge tag 'x86_sgx_for_v6.0-2022-08-03.1' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16181cbc080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=886e7348b2982e4d
dashboard link: https://syzkaller.appspot.com/bug?extid=c2c79c6d6eddc5262b77
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: invalid-access in copy_page+0x10/0xd0 arch/arm64/lib/copy_page.S:26
Read at addr f5ff000017f2e000 by task syz-executor.1/2218
Pointer tag: [f5], memory tag: [f2]

CPU: 1 PID: 2218 Comm: syz-executor.1 Not tainted 5.19.0-syzkaller-10532-g9e2f40233670 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.part.0+0xcc/0xe0 arch/arm64/kernel/stacktrace.c:182
 dump_backtrace arch/arm64/kernel/stacktrace.c:188 [inline]
 show_stack+0x18/0x5c arch/arm64/kernel/stacktrace.c:189
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x68/0x84 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:313 [inline]
 print_report+0xfc/0x5f0 mm/kasan/report.c:429
 kasan_report+0x8c/0xb0 mm/kasan/report.c:491
 __do_kernel_fault+0x104/0x1c0 arch/arm64/mm/fault.c:319
 do_bad_area arch/arm64/mm/fault.c:469 [inline]
 do_tag_check_fault+0x78/0x90 arch/arm64/mm/fault.c:738
 do_mem_abort+0x48/0xa0 arch/arm64/mm/fault.c:814
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:366
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:417
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 copy_page+0x10/0xd0 arch/arm64/lib/copy_page.S:26
 copy_user_highpage+0x18/0x4c arch/arm64/mm/copypage.c:34
 __wp_page_copy_user mm/memory.c:2848 [inline]
 wp_page_copy+0xa0/0x790 mm/memory.c:3109
 do_wp_page+0x150/0x6a4 mm/memory.c:3471
 handle_pte_fault mm/memory.c:4925 [inline]
 __handle_mm_fault+0x6c4/0xf84 mm/memory.c:5046
 handle_mm_fault+0xe8/0x25c mm/memory.c:5144
 __do_page_fault arch/arm64/mm/fault.c:502 [inline]
 do_page_fault+0x140/0x3b0 arch/arm64/mm/fault.c:602
 do_mem_abort+0x48/0xa0 arch/arm64/mm/fault.c:814
 el0_da+0x48/0xbc arch/arm64/kernel/entry-common.c:502
 el0t_64_sync_handler+0x134/0x1b0 arch/arm64/kernel/entry-common.c:645
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581

The buggy address belongs to the physical page:
page:000000003e6672be refcount:3 mapcount:2 mapping:0000000000000000 index:0xffffffffe pfn:0x57f2e
memcg:fbff00001ded8000
anon flags: 0x1ffc2800208001c(uptodate|dirty|lru|swapbacked|arch_2|node=0|zone=0|lastcpupid=0x7ff|kasantag=0xa)
raw: 01ffc2800208001c fffffc00004f91c8 fcff00001d1b1000 f1ff00000510b231
raw: 0000000ffffffffe 0000000000000000 0000000300000001 fbff00001ded8000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff000017f2de00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
 ffff000017f2df00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
>ffff000017f2e000: f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2
                   ^
 ffff000017f2e100: f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2
 ffff000017f2e200: f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2 f2
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
