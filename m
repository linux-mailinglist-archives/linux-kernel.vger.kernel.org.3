Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFCE59B2E1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiHUIzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHUIzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:55:35 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0751DF93
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:55:32 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id g13-20020a056602072d00b0068825561753so4278026iox.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=qISROVWWrPyKJgInOgPEXrCvubnUvxSYeQv3adn55zA=;
        b=polE9Em/N4hGzQW4BvFFg4JbHamHXAEGRVAe2t9p0JYoKhDBr9Nr2FKJ+IRj253ScO
         9txnL6Kc0BIBvHbRJX5se3BeO47DcM+R+tahefOBbOUSIHm/hERttS0Ly57ijVZkgQQQ
         hKEmrj/5q4nc3Y3qc0UWF6qHpChs1BFX4klvgavxHY3Vly+kdz5KBOb++9n+FJhH19oD
         TmyABQAmkyl2ceEs0rbQHBIj8P3JZmH4lYuxwIJEvhD5jFPMVOMs09sqXSSOXWlbc/JO
         8a618BOe8N0FW807DPXs1FSTRP4I9uzKuonAeNc+nXxj8qFwvqTXAAa4WBnQmMCHx8gb
         yauA==
X-Gm-Message-State: ACgBeo0tAZnuPvm0w+ptTQv9gPkXzC5QuwtPmKZe2rMEpNRiLuPhhBIK
        p5MrAnyXkOKvy+klxm9xHU3TDN58/sjDwt3Ug8OAQuOGVgI1
X-Google-Smtp-Source: AA6agR6NAhk1Y1uBvaS/b/JDcl9gf1cMZf/4WwhqrCEOITGkuQTmqsrNT3gmz47MYG+sH2FbalHMsCkHTewF6tqJ/1ltR0HGht3x
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cd:b0:2de:73e8:3f0 with SMTP id
 s13-20020a056e0218cd00b002de73e803f0mr7520567ilu.69.1661072132281; Sun, 21
 Aug 2022 01:55:32 -0700 (PDT)
Date:   Sun, 21 Aug 2022 01:55:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000641ee505e6bc7e3c@google.com>
Subject: [syzbot] general protection fault in binder_alloc_print_pages
From:   syzbot <syzbot+a75ebe0452711c9e56d9@syzkaller.appspotmail.com>
To:     arve@android.com, brauner@kernel.org, cmllamas@google.com,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
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

HEAD commit:    95d10484d66e Add linux-next specific files for 20220817
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111364f3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f5fa747986be53a
dashboard link: https://syzkaller.appspot.com/bug?extid=a75ebe0452711c9e56d9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149f9067080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161a9fc3080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a75ebe0452711c9e56d9@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000025: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000128-0x000000000000012f]
CPU: 0 PID: 3609 Comm: syz-executor323 Not tainted 6.0.0-rc1-next-20220817-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__lock_acquire+0xd83/0x56d0 kernel/locking/lockdep.c:4923
Code: 9b 0e 41 bf 01 00 00 00 0f 86 c8 00 00 00 89 05 63 56 9b 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 4e 31 00 00 49 81 3e 60 84 51 8f 0f 84 4c f3 ff
RSP: 0018:ffffc900038df6a0 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 1ffff9200071bf03 RCX: 0000000000000001
RDX: 0000000000000025 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1bbd60a R11: 0000000000000000 R12: 0000000000000000
R13: ffff888026b68000 R14: 0000000000000128 R15: 0000000000000001
FS:  0000555555ed8300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffb27bfa130 CR3: 000000001e324000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 down_read+0x98/0x450 kernel/locking/rwsem.c:1499
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 binder_alloc_print_pages+0x65/0x420 drivers/android/binder_alloc.c:936
 print_binder_proc_stats drivers/android/binder.c:6289 [inline]
 stats_show+0x417/0x620 drivers/android/binder.c:6352
 seq_read_iter+0x4f5/0x1280 fs/seq_file.c:230
 seq_read+0x16d/0x210 fs/seq_file.c:162
 full_proxy_read+0x118/0x180 fs/debugfs/file.c:231
 do_loop_readv_writev fs/read_write.c:750 [inline]
 do_loop_readv_writev fs/read_write.c:737 [inline]
 do_iter_read+0x4f8/0x750 fs/read_write.c:792
 vfs_readv+0xe5/0x150 fs/read_write.c:910
 do_preadv fs/read_write.c:1002 [inline]
 __do_sys_preadv fs/read_write.c:1052 [inline]
 __se_sys_preadv fs/read_write.c:1047 [inline]
 __x64_sys_preadv+0x22b/0x310 fs/read_write.c:1047
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ffb27b890c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe668da498 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ffb27b890c9
RDX: 0000000000000001 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffb27bf6e40
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe668da4d0
R13: 00007ffe668da4c0 R14: 00007ffe668da4b0 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xd83/0x56d0 kernel/locking/lockdep.c:4923
Code: 9b 0e 41 bf 01 00 00 00 0f 86 c8 00 00 00 89 05 63 56 9b 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 4e 31 00 00 49 81 3e 60 84 51 8f 0f 84 4c f3 ff
RSP: 0018:ffffc900038df6a0 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 1ffff9200071bf03 RCX: 0000000000000001
RDX: 0000000000000025 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1bbd60a R11: 0000000000000000 R12: 0000000000000000
R13: ffff888026b68000 R14: 0000000000000128 R15: 0000000000000001
FS:  0000555555ed8300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffb27bfa130 CR3: 000000001e324000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	41 bf 01 00 00 00    	mov    $0x1,%r15d
   6:	0f 86 c8 00 00 00    	jbe    0xd4
   c:	89 05 63 56 9b 0e    	mov    %eax,0xe9b5663(%rip)        # 0xe9b5675
  12:	e9 bd 00 00 00       	jmpq   0xd4
  17:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1e:	fc ff df
  21:	4c 89 f2             	mov    %r14,%rdx
  24:	48 c1 ea 03          	shr    $0x3,%rdx
* 28:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2c:	0f 85 4e 31 00 00    	jne    0x3180
  32:	49 81 3e 60 84 51 8f 	cmpq   $0xffffffff8f518460,(%r14)
  39:	0f                   	.byte 0xf
  3a:	84 4c f3 ff          	test   %cl,-0x1(%rbx,%rsi,8)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
