Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903F649291D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344183AbiARPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:00:39 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:39609 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbiARPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:00:34 -0500
Received: by mail-il1-f197.google.com with SMTP id u7-20020a056e02170700b002b54e12bb9eso13861794ill.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 07:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JQlTbA6+YjZ7/xARdHk/c5Khre58MY9UXtPTEtteDJ0=;
        b=mHf9MiWIBbzWWxpF0wyWdLEPndgYz7NLR75D12YP029mAX9JKbftB8BnZP8zrIMq+S
         E5xvpyY8D40yXEMIms8A28hKammHMVik55iPlrTR2msw0RRWCVNZPFi2Hb7zRXxmKwg3
         AA7q9QOfBu51ArT3F8+O8jJRTUcjx7KZxgFzYsSgvxBLMgp16/YtsNNbkGqptffWx/Sq
         xyCkqzdoOeYB1s/mPN/DPOZ2W1gYloLGrjQyaePzrAEY8OiMSBAH7cE6kfThA+VftwEB
         4FJV++BjGqSkvv45RlNo3ZgFpZehBGAYHuZouKmvx+PTho0A3a+pc7ClK9k5Q19upnzK
         QypQ==
X-Gm-Message-State: AOAM531MM8L2yVYFVQHZRejfI6LOjv/LKogDy2QhJ+JSjUlrq962kmTq
        4mxorlOZekKP5x9XKW6l7krZaLJc4YWCUL8hu1CdqWmSiVMn
X-Google-Smtp-Source: ABdhPJwBIX9BpgakaefFJcxmSPHb1wNaeldbJxTQNaQQRFSnu61yr3GRRP4LapGU26hWnEt8Kgha3neHZty+ApMPIQ/ietrXCW0B
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cd:: with SMTP id 13mr14512618ilx.139.1642518033901;
 Tue, 18 Jan 2022 07:00:33 -0800 (PST)
Date:   Tue, 18 Jan 2022 07:00:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2b07b05d5dc87cc@google.com>
Subject: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f079ab01b560 Merge tag 'iomap-5.17' of git://git.infradead..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f575cfb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=788482192d4000d
dashboard link: https://syzkaller.appspot.com/bug?extid=5b129e8586277719bab3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com

RBP: 00007fb28e1911d0 R08: 0000000020000280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffe01f9c0cf R14: 00007fb28e191300 R15: 0000000000022000
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 9511 Comm: syz-executor.1 Not tainted 5.16.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0x81/0xf0 lib/list_debug.c:51
Code: 0f 84 19 69 35 05 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 1a 69 35 05 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 51 49 8b 14 24 48 39 ea 0f 85 d1 68 35 05 49 8d 7d
RSP: 0018:ffffc9000714fa10 EFLAGS: 00010256
RAX: dffffc0000000000 RBX: ffffffff89ec31a0 RCX: ffffffff815d148a
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888148f8ddd8
RBP: ffff888148f8ddd0 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000e29f38 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880293d0a00
FS:  00007fb28e191700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5cb26cf310 CR3: 00000000799aa000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __list_del_entry include/linux/list.h:134 [inline]
 list_del include/linux/list.h:148 [inline]
 fscache_free_cookie fs/fscache/cookie.c:71 [inline]
 fscache_free_cookie+0x77/0x330 fs/fscache/cookie.c:66
 fscache_alloc_cookie+0x67a/0x790 fs/fscache/cookie.c:195
 __fscache_acquire_cookie+0x16c/0x600 fs/fscache/cookie.c:296
 fscache_acquire_cookie include/linux/fscache.h:334 [inline]
 v9fs_cache_session_get_cookie+0xf2/0x2f0 fs/9p/cache.c:60
 v9fs_session_init+0xe02/0x1780 fs/9p/v9fs.c:472
 v9fs_mount+0x73/0xa80 fs/9p/vfs_super.c:125
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1500
 do_new_mount fs/namespace.c:2994 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3324
 do_mount fs/namespace.c:3337 [inline]
 __do_sys_mount fs/namespace.c:3545 [inline]
 __se_sys_mount fs/namespace.c:3522 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3522
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb28f81beb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb28e191168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fb28f92ef60 RCX: 00007fb28f81beb9
RDX: 0000000020000b80 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 00007fb28e1911d0 R08: 0000000020000280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffe01f9c0cf R14: 00007fb28e191300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace e959b745799b2618 ]---
RIP: 0010:__list_del_entry_valid+0x81/0xf0 lib/list_debug.c:51
Code: 0f 84 19 69 35 05 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 1a 69 35 05 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 51 49 8b 14 24 48 39 ea 0f 85 d1 68 35 05 49 8d 7d
RSP: 0018:ffffc9000714fa10 EFLAGS: 00010256
RAX: dffffc0000000000 RBX: ffffffff89ec31a0 RCX: ffffffff815d148a
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888148f8ddd8
RBP: ffff888148f8ddd0 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000e29f38 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880293d0a00
FS:  00007fb28e191700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5cb26cf310 CR3: 00000000799aa000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	0f 84 19 69 35 05    	je     0x535691f
   6:	48 b8 22 01 00 00 00 	movabs $0xdead000000000122,%rax
   d:	00 ad de
  10:	49 39 c4             	cmp    %rax,%r12
  13:	0f 84 1a 69 35 05    	je     0x5356933
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 51                	jne    0x81
  30:	49 8b 14 24          	mov    (%r12),%rdx
  34:	48 39 ea             	cmp    %rbp,%rdx
  37:	0f 85 d1 68 35 05    	jne    0x535690e
  3d:	49                   	rex.WB
  3e:	8d                   	.byte 0x8d
  3f:	7d                   	.byte 0x7d


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
