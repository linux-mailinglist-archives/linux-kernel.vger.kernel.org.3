Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5145A591B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiH3CHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH3CHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:07:40 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BE285FE8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:07:36 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so5759250ioz.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=/susuB4bWTEj0QkQMkfrXYQFqQbxx9j42ERlkoMdKqY=;
        b=ztkcZVpPWCKIXgSeDyLl0wA4wMGpzBWF6wXSVq0HE8yy4tozSfU4EMHCaEElceKUbd
         OElpeRxE/juG8rBqx47CeErjfca2liCJNs5Mg43qx6fYiwEJ7DdCwkdxa1SqO4rnkkXH
         K3DHYtwcUZEnjnRD7Z8FCyT6mg8Sxc5j8/l1f4eljkiSYNqFPxODFWsGLXeCKHk7g3mM
         OWRpACdSVUEVHrbLCfugsfn9RIngE0BKFTvg6Un0UF+4sstIuvzPgkNYpjJnpaRVPn/S
         PvFk7oh9faQmPXZWzxdwzZ8f25diDVGx/RAafEK2vh5PvU7aIL1PqBuQ06q8P0E+O4w2
         6xvg==
X-Gm-Message-State: ACgBeo0H7FH2HVW5ZNOgRnEmWstavdHxvI99Ges8k7z4Wh+zLGs0Efpx
        Uhd63PUhSfe7/n5yXC8w85Hkh0AaNIVPGefzGGa/7+zv1T9B
X-Google-Smtp-Source: AA6agR6H583WZokxgJup7/CfnPNDFN7QkuKD6mT2r7o0ST4USxCKmDQkfZyE0F0jTRh8jiryV2z3gsJ3sDZapLxH3plWYP83CiYt
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d0d:b0:689:8260:e11d with SMTP id
 c13-20020a0566022d0d00b006898260e11dmr10252556iow.153.1661825256152; Mon, 29
 Aug 2022 19:07:36 -0700 (PDT)
Date:   Mon, 29 Aug 2022 19:07:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001266a205e76bd8a7@google.com>
Subject: [syzbot] WARNING in blocking_notifier_chain_register
From:   syzbot <syzbot+737584027829ab465c9f@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, bp@suse.de, dmitry.osipenko@collabora.com,
        linux-kernel@vger.kernel.org, mirq-linux@rere.qmqm.pl,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16517dad080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=737584027829ab465c9f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dc7ac7080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13525513080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+737584027829ab465c9f@syzkaller.appspotmail.com

------------[ cut here ]------------
notifier callback hci_suspend_notifier already registered
WARNING: CPU: 0 PID: 7032 at kernel/notifier.c:29 notifier_chain_register kernel/notifier.c:28 [inline]
WARNING: CPU: 0 PID: 7032 at kernel/notifier.c:29 __blocking_notifier_chain_register kernel/notifier.c:266 [inline]
WARNING: CPU: 0 PID: 7032 at kernel/notifier.c:29 blocking_notifier_chain_register+0xa4/0x188 kernel/notifier.c:284
Modules linked in:
CPU: 0 PID: 7032 Comm: syz-executor176 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : notifier_chain_register kernel/notifier.c:28 [inline]
pc : __blocking_notifier_chain_register kernel/notifier.c:266 [inline]
pc : blocking_notifier_chain_register+0xa4/0x188 kernel/notifier.c:284
lr : notifier_chain_register kernel/notifier.c:28 [inline]
lr : __blocking_notifier_chain_register kernel/notifier.c:266 [inline]
lr : blocking_notifier_chain_register+0xa4/0x188 kernel/notifier.c:284
sp : ffff800014c83c70
x29: ffff800014c83c70 x28: 00000000002e0003 x27: 0000000000000000
x26: ffff0000ca608ea0 x25: 0000000000000000 x24: ffff0000cb0a1108
x23: ffff0000c9313110 x22: 0000000000000000 x21: ffff0000cb0a1108
x20: ffff0000cb0a1108 x19: ffff80000d3c1040 x18: 0000000000000169
x17: ffff80000c04d6bc x16: ffff80000dbb8658 x15: ffff0000c10f8000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c10f8000
x11: ff808000081c39dc x10: 0000000000000000 x9 : 98b98071cf41c600
x8 : 98b98071cf41c600 x7 : ffff800008197c8c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000039
Call trace:
 notifier_chain_register kernel/notifier.c:28 [inline]
 __blocking_notifier_chain_register kernel/notifier.c:266 [inline]
 blocking_notifier_chain_register+0xa4/0x188 kernel/notifier.c:284
 register_pm_notifier+0x28/0x38 kernel/power/main.c:73
 hci_register_suspend_notifier+0x48/0x64 net/bluetooth/hci_core.c:2749
 hci_sock_release+0x1a8/0x360 net/bluetooth/hci_sock.c:890
 __sock_release net/socket.c:650 [inline]
 sock_close+0x50/0xf0 net/socket.c:1365
 __fput+0x198/0x3bc fs/file_table.c:320
 ____fput+0x20/0x30 fs/file_table.c:353
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1d0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 1032
hardirqs last  enabled at (1031): [<ffff8000081c1c48>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (1032): [<ffff80000bffe9cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (1006): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (985): [<ffff800008104658>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (985): [<ffff800008104658>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
