Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC75F508C91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380371AbiDTP5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380254AbiDTP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:57:19 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C375443E1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:54:33 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id r20-20020a056e02109400b002cc174742c9so1146097ilj.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=x+XLXhiJwur7r2ElCoLum2H1T2sjURDvAZdqJGEZZHg=;
        b=isjvPqEMxlVuxv18t7wJ33jZTTKBXshaI0C3r8uR3+tzSABwv+w0eUOWk9t25JbgwE
         MDd9kxSPzR3VBIxGiN9ZFZQ4565agDU41v+/Mu4Fv1Z4PHIfAOMccxNEbfMTBCpGFNNm
         DjhkczGvVAKB8dEnRu9a64PoGl9CF9Zprp+sTvZNCInE7Jiz/VvCW7gCaCLOl/aRbTEM
         de6+Qbe/eoEzjJsBZTuoKyZHl4oZo37F2Xkz+z+f816tcpnQbpMoBfsTN5EPxda8KitN
         2CngYP9rPXtmAtEROnsA3vFma3jPvV/xqAYMyIMQHXhJVVtWHWfApnN/CIvJJ4gfSpGD
         XK2Q==
X-Gm-Message-State: AOAM530SeYYiA3ZnJQMdSXfxljBOT24HkS4sI9lGkF0d+5a3gKBK/93K
        W/ZQ+IGgVJm2yLWz5C7ri6In5FZ5+5tUf1ni8NryO2ABm+Sq
X-Google-Smtp-Source: ABdhPJw6uDs9SLREWsdW9u4lKKJlRHybodaGf/UGj6xjQDGJfpl8aRcdLASwIoJUFHQ34Y9QpygTNuYiD8bibyvi0nT3Y8TQXMcF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4128:b0:323:62b4:30c3 with SMTP id
 ay40-20020a056638412800b0032362b430c3mr11021388jab.318.1650470072507; Wed, 20
 Apr 2022 08:54:32 -0700 (PDT)
Date:   Wed, 20 Apr 2022 08:54:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000625fa705dd1802e3@google.com>
Subject: [syzbot] kernel BUG in __filemap_get_folio
From:   syzbot <syzbot+cf4cf13056f85dec2c40@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dhowells@redhat.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, william.kucharski@oracle.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    559089e0a93d vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLO..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1306a768f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd7c9a79dfcfa205
dashboard link: https://syzkaller.appspot.com/bug?extid=cf4cf13056f85dec2c40
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16554fd0f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147f41ecf00000

The issue was bisected to:

commit 6b24ca4a1a8d4ee3221d6d44ddbb99f542e4bda3
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Sun Jun 28 02:19:08 2020 +0000

    mm: Use multi-index entries in the page cache

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173fc7d0f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14bfc7d0f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10bfc7d0f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf4cf13056f85dec2c40@syzkaller.appspotmail.com
Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")

 do_initcall_level init/main.c:1371 [inline]
 do_initcalls init/main.c:1387 [inline]
 do_basic_setup init/main.c:1406 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1613
 kernel_init+0x1a/0x1d0 init/main.c:1502
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1971!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3867 Comm: syz-executor935 Not tainted 5.18.0-rc3-syzkaller-00007-g559089e0a93d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__filemap_get_folio+0xc65/0xf00 mm/filemap.c:1971
Code: db 45 31 f6 e9 fd f5 ff ff 44 8b 6c 24 10 48 89 eb e9 f0 f5 ff ff e8 ba f5 d8 ff 48 c7 c6 80 d9 d5 89 48 89 df e8 6b 8d 0e 00 <0f> 0b e8 a4 f5 d8 ff 48 89 df 31 db e8 4a af 03 00 e9 78 f7 ff ff
RSP: 0018:ffffc900033d78b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea00014c8dc0 RCX: 0000000000000000
RDX: ffff88807bb560c0 RSI: ffffffff819f5865 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000018 R09: 00000000ffffffff
R10: ffffffff891d5eec R11: 00000000ffffffff R12: 0000000000000180
R13: 0000000000000182 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f78863e0700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002013f000 CR3: 0000000075648000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pagecache_get_page+0x2e/0x290 mm/folio-compat.c:126
 shmem_getpage_gfp+0x471/0x2370 mm/shmem.c:1812
 shmem_getpage mm/shmem.c:149 [inline]
 shmem_write_begin+0xff/0x1e0 mm/shmem.c:2446
 generic_perform_write+0x249/0x560 mm/filemap.c:3787
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3915
 generic_file_write_iter+0xd7/0x220 mm/filemap.c:3947
 call_write_iter include/linux/fs.h:2050 [inline]
 new_sync_write+0x38a/0x560 fs/read_write.c:504
 vfs_write+0x7c0/0xac0 fs/read_write.c:591
 ksys_write+0x127/0x250 fs/read_write.c:644
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f78864331c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f78863e0308 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f78864b73e8 RCX: 00007f78864331c9
RDX: 000000000208e24b RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007f78864b73e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f78864b73ec
R13: 00007f78864840ac R14: 776c613d65677568 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__filemap_get_folio+0xc65/0xf00 mm/filemap.c:1971
Code: db 45 31 f6 e9 fd f5 ff ff 44 8b 6c 24 10 48 89 eb e9 f0 f5 ff ff e8 ba f5 d8 ff 48 c7 c6 80 d9 d5 89 48 89 df e8 6b 8d 0e 00 <0f> 0b e8 a4 f5 d8 ff 48 89 df 31 db e8 4a af 03 00 e9 78 f7 ff ff
RSP: 0018:ffffc900033d78b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea00014c8dc0 RCX: 0000000000000000
RDX: ffff88807bb560c0 RSI: ffffffff819f5865 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000018 R09: 00000000ffffffff
R10: ffffffff891d5eec R11: 00000000ffffffff R12: 0000000000000180
R13: 0000000000000182 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f78863e0700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020800000 CR3: 0000000075648000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
