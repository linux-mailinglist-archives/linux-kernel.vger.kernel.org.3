Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881A24B1619
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbiBJTRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:17:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbiBJTRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:17:19 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626E114A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:17:19 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id r4-20020a6b4404000000b00614d5a865f7so4740314ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dhTqdS5BhFkXmeRR/16Vvef9lka+5JexgN00dZ10W4A=;
        b=qX+zVfrr/fMODwIiz0k8DovIPJOvP4KClpJui84j4b2Y+SDfB3V0aHnvl8GqOAwcKJ
         YzX7SwFk7sQ+XeYTgR+xJ0Nwp95BikbUM5m5SwZ+u/4DXSz2VzbWldCJaJv4sZaRVUqv
         tjUg7WIRHWybRn1D/3qzHhZabaKl85g1I3AN0IXTwWPAk3CiDkisk4sk9zAhHwYSoYsg
         xoLee1KLF0awogmFudwZo0M+eY6ajLyV7pAJpzrsGWR0slAYVnSWX826dORem2ezUcf1
         FSi5wCayBzH2LyaZfpez+oTQjXdpr6tWePVP1tGRx9eJp8RK+dvm3W+6RS3rheBu/bCV
         IwQw==
X-Gm-Message-State: AOAM531nCWM667RDbVMZeCm44UuPG2dZMsOAqxaz6lfWkylOdDpaqTwH
        6xm2LU7q3P9flV7UTxKJ9iRAkuHAw/yO6Pwy0fAZd4VVDsf9
X-Google-Smtp-Source: ABdhPJyBLvgOembLjlTMGygnb+NRkBqPrV4hZGpY8vwXOKFzRYp15MkEXO5VJ1WTtgeZRcU3bBjqxSDDaE+3jSaIe2VrDXyLosRY
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a26:: with SMTP id 6mr5028413jao.34.1644520638577;
 Thu, 10 Feb 2022 11:17:18 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:17:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d025d05d7aecc00@google.com>
Subject: [syzbot] general protection fault in blk_mq_free_rqs
From:   syzbot <syzbot+7295389ef2000630244b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    90c9e950c0de Merge tag 'for-linus-5.17a-rc3-tag' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137905dc700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee3797346aa03884
dashboard link: https://syzkaller.appspot.com/bug?extid=7295389ef2000630244b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10801462700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135d7524700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b09d42700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b09d42700000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b09d42700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7295389ef2000630244b@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 3605 Comm: syz-executor139 Not tainted 5.17.0-rc2-syzkaller-00353-g90c9e950c0de #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:blk_mq_clear_rq_mapping block/blk-mq.c:3061 [inline]
RIP: 0010:blk_mq_free_rqs+0x399/0x910 block/blk-mq.c:3106
Code: de e8 8b 83 ac fd 83 fb 3f 0f 87 04 c3 49 05 e8 5d 81 ac fd b8 00 10 00 00 89 d9 48 d3 e0 4c 01 e8 48 89 44 24 08 48 8b 04 24 <0f> b6 00 84 c0 74 08 3c 03 0f 8e bb 03 00 00 41 8b 1f 31 ff 31 ed
RSP: 0018:ffffc900027afaf8 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000004 RCX: 0000000000000004
RDX: ffff888074ef3a00 RSI: ffffffff83cbf733 RDI: 0000000000000003
RBP: ffff888071ce6000 R08: 000000000000003f R09: ffffffff8ffbf99f
R10: ffffffff83cbf725 R11: 0000000000000246 R12: dffffc0000000000
R13: ffff88801a380000 R14: ffff88801a23f000 R15: 0000000000000000
FS:  00007f894cb64700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f894cc20aa3 CR3: 0000000021f45000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 blk_mq_sched_free_rqs block/blk-mq-sched.c:629 [inline]
 blk_mq_sched_free_rqs+0x16c/0x270 block/blk-mq-sched.c:618
 elevator_switch_mq+0xed/0x720 block/elevator.c:600
 blk_mq_elv_switch_none block/blk-mq.c:4445 [inline]
 __blk_mq_update_nr_hw_queues block/blk-mq.c:4498 [inline]
 blk_mq_update_nr_hw_queues+0x3f1/0xd30 block/blk-mq.c:4548
 nbd_start_device+0x157/0xd10 drivers/block/nbd.c:1347
 nbd_start_device_ioctl drivers/block/nbd.c:1397 [inline]
 __nbd_ioctl drivers/block/nbd.c:1471 [inline]
 nbd_ioctl+0x5f3/0xb10 drivers/block/nbd.c:1511
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f894cbb7349
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f894cb642e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f894cc3c4e0 RCX: 00007f894cbb7349
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000007
RBP: 00007f894cc091ac R08: 0000000000000002 R09: 0000000000003331
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f894cc3c4ec
R13: 00007f894cb642f0 R14: 00007f894cc3c4e8 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:blk_mq_clear_rq_mapping block/blk-mq.c:3061 [inline]
RIP: 0010:blk_mq_free_rqs+0x399/0x910 block/blk-mq.c:3106
Code: de e8 8b 83 ac fd 83 fb 3f 0f 87 04 c3 49 05 e8 5d 81 ac fd b8 00 10 00 00 89 d9 48 d3 e0 4c 01 e8 48 89 44 24 08 48 8b 04 24 <0f> b6 00 84 c0 74 08 3c 03 0f 8e bb 03 00 00 41 8b 1f 31 ff 31 ed
RSP: 0018:ffffc900027afaf8 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000004 RCX: 0000000000000004
RDX: ffff888074ef3a00 RSI: ffffffff83cbf733 RDI: 0000000000000003
RBP: ffff888071ce6000 R08: 000000000000003f R09: ffffffff8ffbf99f
R10: ffffffff83cbf725 R11: 0000000000000246 R12: dffffc0000000000
R13: ffff88801a380000 R14: ffff88801a23f000 R15: 0000000000000000
FS:  00007f894cb64700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f894cc20aa3 CR3: 0000000021f45000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 8b 83 ac fd       	callq  0xfdac8390
   5:	83 fb 3f             	cmp    $0x3f,%ebx
   8:	0f 87 04 c3 49 05    	ja     0x549c312
   e:	e8 5d 81 ac fd       	callq  0xfdac8170
  13:	b8 00 10 00 00       	mov    $0x1000,%eax
  18:	89 d9                	mov    %ebx,%ecx
  1a:	48 d3 e0             	shl    %cl,%rax
  1d:	4c 01 e8             	add    %r13,%rax
  20:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  25:	48 8b 04 24          	mov    (%rsp),%rax
* 29:	0f b6 00             	movzbl (%rax),%eax <-- trapping instruction
  2c:	84 c0                	test   %al,%al
  2e:	74 08                	je     0x38
  30:	3c 03                	cmp    $0x3,%al
  32:	0f 8e bb 03 00 00    	jle    0x3f3
  38:	41 8b 1f             	mov    (%r15),%ebx
  3b:	31 ff                	xor    %edi,%edi
  3d:	31 ed                	xor    %ebp,%ebp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
