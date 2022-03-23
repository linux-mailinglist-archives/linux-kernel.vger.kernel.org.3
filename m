Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F089D4E5B04
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345031AbiCWWEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiCWWEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:04:53 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DA95AEDE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:03:21 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id m16-20020a928710000000b002c7be7653d1so1695386ild.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ISGqVSm6Ir+00rcAc+WQ5+odIl4TYWEpdFcmjq5RRow=;
        b=pRxMg1rj3tAIqZYoPL8ZvKMW5IvghoUeHwmmwfd4Z2zrqEIxjYGWbTLql/Q6/vprFm
         hdA7eO9UWPeYmtO/d7FFer3cfeQuxYhJvBlU4MftCovGlDH6R8XB8Kld4+KuSi/wAWEt
         HzzmVwIUhlcUGev8Lna+Oj0i/LYJaxToXv7gxLMdCxrGlDs8IctwKXebHhC4kKsTGsPI
         y8CEIzamdw9iiXctzltCQTEaLFlTvklT3IE61FxVan+UriP6RtD4QPV7jCsCbpni+bq5
         8F9697hnEVl43IdobDz7DxcJuSKmqKOrXudDL4amL0QtqoT0X6XfUvGEGs2ohem2A8Gr
         pEJA==
X-Gm-Message-State: AOAM532vZV7XbarvuEvpjyGGhcmC0MIXXanmrB4IIkMb52zQLxc5fCEm
        Iie7WVwW6yAp9mVWrm3DrgPQY4XJSKmnvBwQBFp7P78imURX
X-Google-Smtp-Source: ABdhPJyrjoD5KYwMeW60CxcHPuAaZiRYM8wjbFac0GuArSE1fgjuoh/YSfRju7wlFl+RTXz2kLCSJMF2BJ6xj7sIficSZxQu18nT
MIME-Version: 1.0
X-Received: by 2002:a6b:c842:0:b0:645:c339:38c7 with SMTP id
 y63-20020a6bc842000000b00645c33938c7mr1136766iof.26.1648073001056; Wed, 23
 Mar 2022 15:03:21 -0700 (PDT)
Date:   Wed, 23 Mar 2022 15:03:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cabcb505dae9e577@google.com>
Subject: [syzbot] general protection fault in list_lru_add
From:   syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
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

Hello,

syzbot found the following issue on:

HEAD commit:    6b1f86f8e9c7 Merge tag 'folio-5.18b' of git://git.infradea..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1330b513700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b99d35252f93aed2
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c45ccc7d5d45fc5965
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142a1f25700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1618e40b700000

The issue was bisected to:

commit 5abc1e37afa0335c52608d640fd30910b2eeda21
Author: Muchun Song <songmuchun@bytedance.com>
Date:   Tue Mar 22 21:41:19 2022 +0000

    mm: list_lru: allocate list_lru_one only when needed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ea4c71700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=101a4c71700000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ea4c71700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com
Fixes: 5abc1e37afa0 ("mm: list_lru: allocate list_lru_one only when needed")

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 2964 Comm: udevd Tainted: G        W         5.17.0-syzkaller-02172-g6b1f86f8e9c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:list_add_tail include/linux/list.h:102 [inline]
RIP: 0010:list_lru_add+0x277/0x510 mm/list_lru.c:129
Code: 04 64 4d 8d 7c c7 10 4c 89 3c 24 e8 c3 f6 ca ff 49 8d 47 08 48 89 c2 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 02 00 00 4d 8b 77 08 48 89 df 48 8b 14 24 4c
RSP: 0018:ffffc90002c17db0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88823bc54fc0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff81acf7ad RDI: ffffffff8d93ddd0
RBP: ffff8880256da7f0 R08: 0000000000000000 R09: ffffffff8d93ddd7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88807fb2a880 R14: 0000000000000080 R15: 0000000000000000
FS:  00007f711b82e840(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f565fc7a718 CR3: 000000001a735000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 d_lru_add fs/dcache.c:431 [inline]
 retain_dentry fs/dcache.c:685 [inline]
 dput+0x7a7/0xdb0 fs/dcache.c:908
 __fput+0x3ab/0x9f0 fs/file_table.c:330
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:190 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:222
 __syscall_exit_to_user_mode_work kernel/entry/common.c:304 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:315
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f711b92a467
Code: 44 00 00 48 8b 15 11 aa 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb bc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 e1 a9 0c 00 f7 d8 64 89 02 b8
RSP: 002b:00007ffe9fd16aa8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 000055991078b240 RCX: 00007f711b92a467
RDX: 00007f711b9f1780 RSI: 0000000000000000 RDI: 000000000000000c
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f711b9f5a60
R10: 0000000000000200 R11: 0000000000000202 R12: 00007f711b9f2380
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:list_add_tail include/linux/list.h:102 [inline]
RIP: 0010:list_lru_add+0x277/0x510 mm/list_lru.c:129
Code: 04 64 4d 8d 7c c7 10 4c 89 3c 24 e8 c3 f6 ca ff 49 8d 47 08 48 89 c2 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 02 00 00 4d 8b 77 08 48 89 df 48 8b 14 24 4c
RSP: 0018:ffffc90002c17db0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88823bc54fc0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff81acf7ad RDI: ffffffff8d93ddd0
RBP: ffff8880256da7f0 R08: 0000000000000000 R09: ffffffff8d93ddd7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88807fb2a880 R14: 0000000000000080 R15: 0000000000000000
FS:  00007f711b82e840(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f565fc7a718 CR3: 000000001a735000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	04 64                	add    $0x64,%al
   2:	4d 8d 7c c7 10       	lea    0x10(%r15,%rax,8),%r15
   7:	4c 89 3c 24          	mov    %r15,(%rsp)
   b:	e8 c3 f6 ca ff       	callq  0xffcaf6d3
  10:	49 8d 47 08          	lea    0x8(%r15),%rax
  14:	48 89 c2             	mov    %rax,%rdx
  17:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 4d 02 00 00    	jne    0x281
  34:	4d 8b 77 08          	mov    0x8(%r15),%r14
  38:	48 89 df             	mov    %rbx,%rdi
  3b:	48 8b 14 24          	mov    (%rsp),%rdx
  3f:	4c                   	rex.WR


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
