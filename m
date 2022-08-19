Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F0E59919A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbiHSAJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbiHSAJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:09:26 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84D2C876F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:09:24 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i20-20020a056e020d9400b002e377b02d4cso2152059ilj.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Cgqnygv45IvmE/0nA636AfgKPr1Y9HZ7ogG80q4bafI=;
        b=ArVsMiczBNh/EQGgpz/JZ73iP/XEkya9eEgMlccCmsQ6ZiyrX4QAoMOrQM7rJoHZw2
         McFZE8MIfViVmGUQcB3b8MN6ZiD6r3nkoLl7/dYDQR/cZHHxhKO5ZnCj7o76LR9Hab+t
         WwJ9Nfushbu74ISqe/qOTbOeRpuHuXZ08S39al03FlZZNRVFSU4/qiFYq83rQjIZfGp/
         3SDhmmSrFMcg5E8sqCYtUv9B1x+/ujw8N0Rqk2Ruz9tY2CohwdL1NiVxK9jH5qIcvdQ4
         1vYRDn9sZTsxXXw5rppe1yuAh8+I6qHD74YALTTOWM3Ir/PHuwTMXAMSy9CdECKtUnOd
         b1Fg==
X-Gm-Message-State: ACgBeo14SCvkxCLOsl3mbfTgVuhHle6jtfPLuvYP+ooi0Ys/0E4tJ06x
        cXAVH1FB9LcI4CoGpvTiAcb9uffc9A+ZSFaI61sNHuQCO/ka
X-Google-Smtp-Source: AA6agR5Th/47m9oDxR6e09YyIyM4u883zYiv57Xptl+BEAqccJCssp1yY4RYeXlYdcyQ/z/03m3XavyH1f3JkfswClq+JWxRywbt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:2de:de3e:6c5a with SMTP id
 f12-20020a056e020b4c00b002dede3e6c5amr2568816ilu.6.1660867764236; Thu, 18 Aug
 2022 17:09:24 -0700 (PDT)
Date:   Thu, 18 Aug 2022 17:09:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b37dc05e68ce911@google.com>
Subject: [syzbot] general protection fault in release_udmabuf
From:   syzbot <syzbot+c80e9ef5d8bb45894db0@syzkaller.appspotmail.com>
To:     christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        kraxel@redhat.com, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1331f447080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=c80e9ef5d8bb45894db0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1601336b080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d3292d080000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e01a3d080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e01a3d080000
console output: https://syzkaller.appspot.com/x/log.txt?x=11e01a3d080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c80e9ef5d8bb45894db0@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 3609 Comm: syz-executor487 Not tainted 5.19.0-syzkaller-13930-g7ebfc85e2cd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:dma_unmap_sgtable include/linux/dma-mapping.h:378 [inline]
RIP: 0010:put_sg_table drivers/dma-buf/udmabuf.c:89 [inline]
RIP: 0010:release_udmabuf+0xcb/0x4f0 drivers/dma-buf/udmabuf.c:114
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2b 04 00 00 48 8d 7d 0c 4c 8b 63 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 e2
RSP: 0018:ffffc900037efd30 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffff8cb67800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff84ad27e0 RDI: 0000000000000000
RBP: fffffffffffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000008c07c R12: ffff88801fa05000
R13: ffff888073db07e8 R14: ffff888025c25440 R15: 0000000000000000
FS:  0000555555fc4300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc1c0ce06e4 CR3: 00000000715e6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dma_buf_release+0x157/0x2d0 drivers/dma-buf/dma-buf.c:78
 __dentry_kill+0x42b/0x640 fs/dcache.c:612
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x806/0xdb0 fs/dcache.c:913
 __fput+0x39c/0x9d0 fs/file_table.c:333
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 ptrace_notify+0x114/0x140 kernel/signal.c:2353
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work kernel/entry/common.c:249 [inline]
 syscall_exit_to_user_mode_prepare+0x129/0x280 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0x9/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc1c0c35b6b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffd78a06090 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007fc1c0c35b6b
RDX: 0000000020000280 RSI: 0000000040086200 RDI: 0000000000000006
RBP: 0000000000000007 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000000c
R13: 0000000000000003 R14: 00007fc1c0cfe4a0 R15: 00007ffd78a06140
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dma_unmap_sgtable include/linux/dma-mapping.h:378 [inline]
RIP: 0010:put_sg_table drivers/dma-buf/udmabuf.c:89 [inline]
RIP: 0010:release_udmabuf+0xcb/0x4f0 drivers/dma-buf/udmabuf.c:114
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2b 04 00 00 48 8d 7d 0c 4c 8b 63 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 e2
RSP: 0018:ffffc900037efd30 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffff8cb67800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff84ad27e0 RDI: 0000000000000000
RBP: fffffffffffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000008c07c R12: ffff88801fa05000
R13: ffff888073db07e8 R14: ffff888025c25440 R15: 0000000000000000
FS:  0000555555fc4300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564b46eeb2c8 CR3: 00000000715e6000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 2b 04 00 00    	jne    0x43c
  11:	48 8d 7d 0c          	lea    0xc(%rbp),%rdi
  15:	4c 8b 63 30          	mov    0x30(%rbx),%r12
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 e2                	test   %esp,%edx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
