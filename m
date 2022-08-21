Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4291159B236
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiHUGEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 02:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUGEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 02:04:30 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00E13D5E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 23:04:26 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o5-20020a056e02102500b002ddcc65029cso6134866ilj.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 23:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=eiOKoRIU1+xFjf/aE71+N+iYxiQOMVc1VHmaZYZoLKc=;
        b=l6uOo7O2ndePNlh/8Wd82uw0VDy4OqrxBsD/xvtUhs2xd3EI1K6Kj2nul6Dh8DrVsY
         xTN/gvm7ivHj++Ed3+ffrfKuPWmiHmCz3I3GsLCwenvlTUM9CsiqVOrWZZ2LQPz2XZP8
         xFT+fma2OtLvySVCVQTx8XC7ngdQsxFaTcDriLPC8CRuF/VGeHY6E5j0GaJG9fxGRDof
         Uk+8aQcdRnHLEwtXD7j2azj6jtVtAWJpggkMNc6xG4JJ42SCF6DW3KWGdVnFt42ussUb
         TUGncdS1kPPO0ODyL8Ag0bhOjNGYOV6biws8YwY7wqQl63Wt7DDpL7lUEfcs+Eu5/UIg
         m4tg==
X-Gm-Message-State: ACgBeo1F3gXKQWnFCfCmlnBb242db3C7Ct9yv+lirV+ZacLujduhXpah
        UInIkm2sdpzGf8qo+PPdhvkp+T7I/sSv30JtHlmZ8tFUWRAx
X-Google-Smtp-Source: AA6agR6yQxP7vNKRh7ejBJqqFYTGDVClpxObxinukbCVLN5ruYCg1piFZNbcLiWI2iT4bzfE9OkVebJIC0PK3H3FR2fs+wZlKIUl
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3798:b0:346:9d8a:ebcd with SMTP id
 w24-20020a056638379800b003469d8aebcdmr6574189jal.257.1661061866353; Sat, 20
 Aug 2022 23:04:26 -0700 (PDT)
Date:   Sat, 20 Aug 2022 23:04:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e7b2605e6ba1a41@google.com>
Subject: [syzbot] general protection fault in binder_alloc_new_buf
From:   syzbot <syzbot+f7dc54e5be28950ac459@syzkaller.appspotmail.com>
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

HEAD commit:    8755ae45a9e8 Add linux-next specific files for 20220819
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a879e3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=f7dc54e5be28950ac459
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1114a92d080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17693aa5080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f7dc54e5be28950ac459@syzkaller.appspotmail.com

binder: 3755:3755 ioctl c0306201 20001480 returned -14
general protection fault, probably for non-canonical address 0xdffffc0000000025: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000128-0x000000000000012f]
CPU: 0 PID: 3755 Comm: syz-executor229 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
syz-executor229[3755] cmdline: ./syz-executor2294415195
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__lock_acquire+0xd83/0x56d0 kernel/locking/lockdep.c:4923
Code: 9b 0e 41 bf 01 00 00 00 0f 86 c8 00 00 00 89 05 63 56 9b 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 4e 31 00 00 49 81 3e 60 84 51 8f 0f 84 4c f3 ff
RSP: 0018:ffffc90003c1f268 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 1ffff92000783e7c RCX: 0000000000000001
RDX: 0000000000000025 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1bbd792 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807a289d80 R14: 0000000000000128 R15: 0000000000000001
FS:  0000555556fed300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa1152711f0 CR3: 0000000072080000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 down_read+0x98/0x450 kernel/locking/rwsem.c:1499
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 binder_alloc_new_buf_locked drivers/android/binder_alloc.c:405 [inline]
 binder_alloc_new_buf+0xa5/0x19e0 drivers/android/binder_alloc.c:593
 binder_transaction+0x242e/0x9a80 drivers/android/binder.c:3199
 binder_thread_write+0x664/0x3220 drivers/android/binder.c:3986
 binder_ioctl_write_read drivers/android/binder.c:5036 [inline]
 binder_ioctl+0x3470/0x6d00 drivers/android/binder.c:5323
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa1151fd439
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc9354bf38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa1151fd439
RDX: 0000000020000380 RSI: 00000000c0306201 RDI: 0000000000000003
RBP: 0000000000000000 R08: 000000001526ae40 R09: 000000001526ae40
R10: 000000001526ae40 R11: 0000000000000246 R12: 000000000000c3f0
R13: 00007ffc9354bf60 R14: 00007ffc9354bf50 R15: 00007ffc9354bf44
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xd83/0x56d0 kernel/locking/lockdep.c:4923
Code: 9b 0e 41 bf 01 00 00 00 0f 86 c8 00 00 00 89 05 63 56 9b 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 4e 31 00 00 49 81 3e 60 84 51 8f 0f 84 4c f3 ff
RSP: 0018:ffffc90003c1f268 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 1ffff92000783e7c RCX: 0000000000000001
RDX: 0000000000000025 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1bbd792 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807a289d80 R14: 0000000000000128 R15: 0000000000000001
FS:  0000555556fed300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa1152711f0 CR3: 0000000072080000 CR4: 00000000003506f0
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
