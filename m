Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0424F55357E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352298AbiFUPKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352432AbiFUPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:10:27 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343A62980C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:10:24 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id 199-20020a6b01d0000000b00669bf42cd4cso7767546iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=orJv/QF6/hQyCVCkoKcPGnTko1ommFIuCUIXzQv7jwI=;
        b=o0EjqohNBH2uYuANd+A9t6Uf5p6MsNY+BhadMBz9kSOYEs77jToGhKRGPYzu0qrpmZ
         wbVn7NVCnAuAqZkTFjQPyBZa/xSOeLAAKHFCj0RGSWzCHGgLNx7h+8WotylCcSvUo/eU
         09PZy/+5q64OoueOMuYVGD6W0i6Ljup44IiuLy4tEpSph2HUY6Cnhis192xhUYn84wze
         rEl4nBnkEgdJQMqfxfQiuqJFaGC5DAJE141AQheqDFQ/qn6PncCZaRiD0J2hY1YOqSbG
         iVHTSVWMPTAQIU06G5s6tLY5Kjkxn2omw8pK35+iZnJeV0koJSxQOrCMJXrD7jQ7SO0y
         7IOg==
X-Gm-Message-State: AJIora8ZoB/DCMQRUFKCnR41zyNWZSiLS5UkKq+JuvDOd+UrAqpgJRfF
        Z0w8SkjCoxedNP+j23fKYQcazXLhymH6KmC0gKx0CGHc2Jom
X-Google-Smtp-Source: AGRyM1uQePVfTEOaeMTn3UjYHAfWksYYYP9NNjLMDbV9XXmg8SbP7RQv1ctWcAVbgaMBbfkmJYBmZfY0sUmZ9N6xFYOzCpoj0C5G
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c86:b0:2d9:333f:5b9d with SMTP id
 w6-20020a056e021c8600b002d9333f5b9dmr1266033ill.36.1655824223607; Tue, 21 Jun
 2022 08:10:23 -0700 (PDT)
Date:   Tue, 21 Jun 2022 08:10:23 -0700
In-Reply-To: <0000000000003189f305e19f5d3e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8a4a905e1f69ec4@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in hugepage_vma_check
From:   syzbot <syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, shy828301@gmail.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    34d1d36073ea Add linux-next specific files for 20220621
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a34140080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b24b62d1c051cfc8
dashboard link: https://syzkaller.appspot.com/bug?extid=4d875b4d2e2b60bae9b4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14097a3ff00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1466c63ff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d875b4d2e2b60bae9b4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: null-ptr-deref in hugepage_vma_check+0x8e/0x750 mm/huge_memory.c:82
Read of size 8 at addr 00000000000005a8 by task syz-executor405/3606

CPU: 0 PID: 3606 Comm: syz-executor405 Not tainted 5.19.0-rc3-next-20220621-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 hugepage_vma_check+0x8e/0x750 mm/huge_memory.c:82
 show_smap+0x1c6/0x470 fs/proc/task_mmu.c:866
 traverse.part.0+0xcf/0x5f0 fs/seq_file.c:111
 traverse fs/seq_file.c:101 [inline]
 seq_read_iter+0x90f/0x1280 fs/seq_file.c:195
 seq_read+0x337/0x4b0 fs/seq_file.c:162
 do_loop_readv_writev fs/read_write.c:763 [inline]
 do_loop_readv_writev fs/read_write.c:750 [inline]
 do_iter_read+0x4f8/0x750 fs/read_write.c:805
 vfs_readv+0xe5/0x150 fs/read_write.c:923
 do_preadv fs/read_write.c:1015 [inline]
 __do_sys_preadv fs/read_write.c:1065 [inline]
 __se_sys_preadv fs/read_write.c:1060 [inline]
 __x64_sys_preadv+0x22b/0x310 fs/read_write.c:1060
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fcb44a75239
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffedce269f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcb44a75239
RDX: 0000000000000001 RSI: 00000000200006c0 RDI: 0000000000000003
RBP: 00007ffedce26a00 R08: 0000000000000000 R09: 65732f636f72702f
R10: 00000000fffffffe R11: 0000000000000246 R12: 00007fcb44a39120
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
==================================================================

