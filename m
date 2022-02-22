Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1364BEEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbiBVA0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 19:26:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiBVA0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 19:26:45 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C924F23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:26:21 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso5978981ioh.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2tzfhNFPXiDcKBOJhfAym7/RHASpGhVL7U/0gzTBYyI=;
        b=FNdf2gmnKjiKcnsIaqqiFtoCLZxFQPbDuYIxkFcOu0bmmu/HMmyQhcUj7uBFUiIHfG
         vDx4EHcMDyuuk8ZCjXRJW6RFglmQHbQ8LKknymThle9XXgWLOdl2t+iZCwQ/OdWlmqYK
         alNXKskDmWiJGw0kzdkqxWkKPIOFvJ5qm0TRFE7OCM8nb4WiI8WLcExRfJgZfkscArd3
         rhjm7+rs9vWcJKedriuKMHOwKlyfgY1zibXI9k7lfaEDyRZhL8oUA9IZiOtdOGN2Q1Ab
         /hytWc+zRoNBonJNVwyOHNNNM87xw+CuGFLWqaGrLrZKANmAEDSWD7UBXr4hlXGRo7DZ
         Itbw==
X-Gm-Message-State: AOAM530JfkglNWk00amOOakBelOBQyDR5of8AeDosBKQr3oINw6rTapB
        EAwfUbnBjQce0SayOPKpv2UKrlHJVbgrlkLPicj/IWnj27mr
X-Google-Smtp-Source: ABdhPJxGzE8bVTG3MOIbzgos8UPZ1VbK4YY1RYjB43tBG+phgy/1vm6EkkAYVp5WKPQNVnWB5XCSwnl5lQaL8twNbcpXetCWcVO1
MIME-Version: 1.0
X-Received: by 2002:a92:d7c2:0:b0:2c2:5e29:b95f with SMTP id
 g2-20020a92d7c2000000b002c25e29b95fmr911767ilq.132.1645489580626; Mon, 21 Feb
 2022 16:26:20 -0800 (PST)
Date:   Mon, 21 Feb 2022 16:26:20 -0800
In-Reply-To: <20220222001455.1737-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef576b05d8906592@google.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
From:   syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in vhost_vsock_handle_tx_kick

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:577
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 4050, name: vhost-4049
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by vhost-4049/4050:
 #0: ffff88806f3e4c20 (&vq->mutex){+.+.}-{3:3}, at: vhost_vsock_handle_tx_kick+0xbf/0xa10 drivers/vhost/vsock.c:508
 #1: ffff88806ee92f20 (&ctx->wqh){....}-{2:2}, at: eventfd_signal+0x77/0x1c0 fs/eventfd.c:75
irq event stamp: 158
hardirqs last  enabled at (157): [<ffffffff81ad847c>] lockless_pages_from_mm mm/gup.c:2851 [inline]
hardirqs last  enabled at (157): [<ffffffff81ad847c>] internal_get_user_pages_fast+0x17cc/0x2510 mm/gup.c:2893
hardirqs last disabled at (158): [<ffffffff8950a9ce>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (158): [<ffffffff8950a9ce>] _raw_spin_lock_irqsave+0x4e/0x50 kernel/locking/spinlock.c:162
softirqs last  enabled at (0): [<ffffffff8145328c>] copy_process+0x1eec/0x7300 kernel/fork.c:2109
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 4050 Comm: vhost-4049 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9577
 __mutex_lock_common kernel/locking/mutex.c:577 [inline]
 __mutex_lock+0x9f/0x12f0 kernel/locking/mutex.c:733
 vhost_vsock_handle_tx_kick+0xbf/0xa10 drivers/vhost/vsock.c:508
 vhost_poll_wakeup+0xd5/0x130 drivers/vhost/vhost.c:174
 __wake_up_common+0x147/0x650 kernel/sched/wait.c:108
 eventfd_signal+0x129/0x1c0 fs/eventfd.c:81
 vhost_update_used_flags drivers/vhost/vhost.c:1979 [inline]
 vhost_update_used_flags+0x34c/0x3d0 drivers/vhost/vhost.c:1966
 vhost_disable_notify drivers/vhost/vhost.c:2560 [inline]
 vhost_disable_notify+0xbe/0x190 drivers/vhost/vhost.c:2552
 vhost_vsock_handle_tx_kick+0x187/0xa10 drivers/vhost/vsock.c:516
 vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

=============================
[ BUG: Invalid wait context ]
5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0 Tainted: G        W        
-----------------------------
vhost-4049/4050 is trying to lock:
ffff88806f3e4c20 (&vq->mutex){+.+.}-{3:3}, at: vhost_vsock_handle_tx_kick+0xbf/0xa10 drivers/vhost/vsock.c:508
other info that might help us debug this:
context-{4:4}
2 locks held by vhost-4049/4050:
 #0: ffff88806f3e4c20 (&vq->mutex){+.+.}-{3:3}, at: vhost_vsock_handle_tx_kick+0xbf/0xa10 drivers/vhost/vsock.c:508
 #1: ffff88806ee92f20 (&ctx->wqh){....}-{2:2}, at: eventfd_signal+0x77/0x1c0 fs/eventfd.c:75
stack backtrace:
CPU: 1 PID: 4050 Comm: vhost-4049 Tainted: G        W         5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4678 [inline]
 check_wait_context kernel/locking/lockdep.c:4739 [inline]
 __lock_acquire.cold+0xc5/0x3a9 kernel/locking/lockdep.c:4977
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __mutex_lock_common kernel/locking/mutex.c:600 [inline]
 __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
 vhost_vsock_handle_tx_kick+0xbf/0xa10 drivers/vhost/vsock.c:508
 vhost_poll_wakeup+0xd5/0x130 drivers/vhost/vhost.c:174
 __wake_up_common+0x147/0x650 kernel/sched/wait.c:108
 eventfd_signal+0x129/0x1c0 fs/eventfd.c:81
 vhost_update_used_flags drivers/vhost/vhost.c:1979 [inline]
 vhost_update_used_flags+0x34c/0x3d0 drivers/vhost/vhost.c:1966
 vhost_disable_notify drivers/vhost/vhost.c:2560 [inline]
 vhost_disable_notify+0xbe/0x190 drivers/vhost/vhost.c:2552
 vhost_vsock_handle_tx_kick+0x187/0xa10 drivers/vhost/vsock.c:516
 vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
BUG: scheduling while atomic: vhost-4049/4050/0x00000002
INFO: lockdep is turned off.
Modules linked in:
irq event stamp: 158
hardirqs last  enabled at (157): [<ffffffff81ad847c>] lockless_pages_from_mm mm/gup.c:2851 [inline]
hardirqs last  enabled at (157): [<ffffffff81ad847c>] internal_get_user_pages_fast+0x17cc/0x2510 mm/gup.c:2893
hardirqs last disabled at (158): [<ffffffff8950a9ce>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (158): [<ffffffff8950a9ce>] _raw_spin_lock_irqsave+0x4e/0x50 kernel/locking/spinlock.c:162
softirqs last  enabled at (0): [<ffffffff8145328c>] copy_process+0x1eec/0x7300 kernel/fork.c:2109
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<0000000000000000>] 0x0


Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=12c557bc700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1651ba96700000

