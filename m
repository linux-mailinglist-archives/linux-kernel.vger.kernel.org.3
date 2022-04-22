Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE850ADE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443472AbiDVCnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443450AbiDVCm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:42:58 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3026627F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:40:06 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id y19-20020a056e02119300b002c2d3ef05bfso3632602ili.18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0E1wTgmw4tAhJxDZt8mvnlOyonouEGkIe5cDD3EeSIk=;
        b=Faz+B5vitLxgmZ4WT534YS0Swj5c+1fjgzgOloQK/WgBymwCJXMMDStaZJ+CZXCdQ3
         hLzzX8RW57TIoN/j6WTRluAvhOnv3EqLIOBLg8ef0p0mUYHeYtU+9lSVh8tSS3R3Ubq6
         5hATNJHKvyqNr3ostcPf6L+VLRZ5pMqrsdcvRgujQPL4REn8ta5AtEjnjA2h8ma0BohY
         Dwzb2g8qKwcptFSci2Q/3sSGXNwU6V5y17Tfwv3vkjalDLun/QM81/nyjTProIENjiUO
         /fM5QxvfNoB9khCqWdb1NTZPvwdGQTHn79LAGhpYZKXOcy7LxyYXn/hfwXIwtTriosJc
         45/w==
X-Gm-Message-State: AOAM531UOb7H8NUs01D/DHCsK4SciQkGwISpmfyEI8uosfrjSdP2wzyJ
        HfcJ9tZJesnPuk/WGMBxyu+JgxnBZVfTQHoatPUaxcxrBW2J
X-Google-Smtp-Source: ABdhPJyuXAIKd5sEJnop+a/QplH1hLkVCQWaCfQdy0XpRMkfSD5Ic+Ovnmcc+ECGIefpGm4NenK/sii6s12XCim/oMcYqYXn+mDk
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d6:b0:323:cda4:170d with SMTP id
 y22-20020a05663824d600b00323cda4170dmr1148106jat.269.1650595206316; Thu, 21
 Apr 2022 19:40:06 -0700 (PDT)
Date:   Thu, 21 Apr 2022 19:40:06 -0700
In-Reply-To: <20220422023004.2640-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0c6aa05dd3524de@google.com>
Subject: Re: [syzbot] kernel BUG in __filemap_get_folio
From:   syzbot <syzbot+cf4cf13056f85dec2c40@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __filemap_get_folio

 debug_vm_pgtable+0x2a51/0x2ae3 mm/debug_vm_pgtable.c:1332
 do_one_initcall+0x103/0x650 init/main.c:1298
 do_initcall_level init/main.c:1371 [inline]
 do_initcalls init/main.c:1387 [inline]
 do_basic_setup init/main.c:1406 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1613
 kernel_init+0x1a/0x1d0 init/main.c:1502
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1973!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4328 Comm: syz-executor.3 Not tainted 5.18.0-rc3-syzkaller-00007-g559089e0a93d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__filemap_get_folio+0x8e7/0x10f0 mm/filemap.c:1973
Code: 4f f9 d8 ff 31 ff 89 ee e8 26 fd d8 ff 40 84 ed 0f 85 a3 fb ff ff e8 38 f9 d8 ff 48 c7 c6 80 d9 d5 89 48 89 df e8 d9 92 0e 00 <0f> 0b e8 22 f9 d8 ff 48 89 df e8 ea a6 03 00 e9 b3 fb ff ff e8 10
RSP: 0018:ffffc90003bcf8b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea00017a8e00 RCX: 0000000000000000
RDX: ffff888070958080 RSI: ffffffff819f54e7 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000018 R09: 00000000ffffffff
R10: ffffffff891d5eec R11: 00000000ffffffff R12: 00000000000001c0
R13: 0000000000000182 R14: dffffc0000000000 R15: 0000000000000001
FS:  00007f882e7ff700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcfb963000 CR3: 000000006e26f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pagecache_get_page+0x2e/0x290 mm/folio-compat.c:126
 shmem_getpage_gfp+0x471/0x2370 mm/shmem.c:1812
 shmem_getpage mm/shmem.c:149 [inline]
 shmem_write_begin+0xff/0x1e0 mm/shmem.c:2446
 generic_perform_write+0x249/0x560 mm/filemap.c:3789
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3917
 generic_file_write_iter+0xd7/0x220 mm/filemap.c:3949
 call_write_iter include/linux/fs.h:2050 [inline]
 new_sync_write+0x38a/0x560 fs/read_write.c:504
 vfs_write+0x7c0/0xac0 fs/read_write.c:591
 ksys_write+0x127/0x250 fs/read_write.c:644
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f882d6890e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f882e7ff168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f882d79bf60 RCX: 00007f882d6890e9
RDX: 000000000208e24b RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007f882d6e308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdca7b7e2f R14: 00007f882e7ff300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__filemap_get_folio+0x8e7/0x10f0 mm/filemap.c:1973
Code: 4f f9 d8 ff 31 ff 89 ee e8 26 fd d8 ff 40 84 ed 0f 85 a3 fb ff ff e8 38 f9 d8 ff 48 c7 c6 80 d9 d5 89 48 89 df e8 d9 92 0e 00 <0f> 0b e8 22 f9 d8 ff 48 89 df e8 ea a6 03 00 e9 b3 fb ff ff e8 10
RSP: 0018:ffffc90003bcf8b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea00017a8e00 RCX: 0000000000000000
RDX: ffff888070958080 RSI: ffffffff819f54e7 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000018 R09: 00000000ffffffff
R10: ffffffff891d5eec R11: 00000000ffffffff R12: 00000000000001c0
R13: 0000000000000182 R14: dffffc0000000000 R15: 0000000000000001
FS:  00007f882e7ff700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcfb963000 CR3: 000000006e26f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         559089e0 vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLO..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=13406b44f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd7c9a79dfcfa205
dashboard link: https://syzkaller.appspot.com/bug?extid=cf4cf13056f85dec2c40
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1705002cf00000

