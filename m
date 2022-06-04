Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4B53D5AF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 07:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbiFDFvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 01:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiFDFvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 01:51:18 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395D739BA3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 22:51:17 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id c1-20020a928e01000000b002d1b20aa761so7701229ild.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 22:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZNRbz2iBg6v7J+xx5ymCMwjK4KXnnSGkvyMngzV3K+Q=;
        b=FrZ1rjEBa3Iisq/5t+PllZTKBG/IKKeO2JvQYTaL6eD0Td0wF/HIcqPqSgXDHr/nrI
         h+jYDEePJXmXR3nRVYzujjPDuwLn3BpP8TG8qqHpEUUXel0zGuRGfgAmTuqmOSsW1y2h
         LIA2eSI2ROwzrxCGLp7MvjMuMkEfwNs7T++Mn2cjWzXgj2L4SnNEoRlGZPrxoBlFCJjg
         3ZXgX060wOby32a1fHiPH6YjUWy/cYbfYOowimmN4Zj6nnuQu15opj/wryrNv1fKgCS5
         7wK9szRyhFJlZPfuYt1HpPRSsCzX7ZaeMp8GRhsTxm/lIzvXfVITcpCbjgBxxl5ZjeDf
         if4g==
X-Gm-Message-State: AOAM532/e9TteQS/eXbAi7eQEENTZot7jiynraTxULsy9HNZAR9uK8l2
        QVk+O6t28v3HF6rydrDH941U3RuNuiA96raoMBYDG93kdsbK
X-Google-Smtp-Source: ABdhPJx1VKBWP7HaV0Zwl4LfC34vNHHsn0b/OlsV0Fb1NrNBGjwyyK1cZ1VKaVLRioeEw+nwpmTK7Sx3Z5rA+XLDYLAa6aj0CGef
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14cf:b0:330:f947:2ab7 with SMTP id
 l15-20020a05663814cf00b00330f9472ab7mr7348270jak.309.1654321876548; Fri, 03
 Jun 2022 22:51:16 -0700 (PDT)
Date:   Fri, 03 Jun 2022 22:51:16 -0700
In-Reply-To: <20220604053504.5470-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbc48f05e098d360@google.com>
Subject: Re: [syzbot] possible deadlock in j1939_sk_queue_drop_all
From:   syzbot <syzbot+3bd970a1887812621b4c@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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
possible deadlock in j1939_sk_queue_drop_all

======================================================
WARNING: possible circular locking dependency detected
5.18.0-syzkaller-12234-g50fd82b3a9a9-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/4079 is trying to acquire lock:
ffff88807462f5c8 (&jsk->sk_session_queue_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:354 [inline]
ffff88807462f5c8 (&jsk->sk_session_queue_lock){+.-.}-{2:2}, at: j1939_sk_queue_drop_all+0x40/0x2f0 net/can/j1939/socket.c:139

but task is already holding lock:
ffff888022b210d0
 (&priv->j1939_socks_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:354 [inline]
 (&priv->j1939_socks_lock){+.-.}-{2:2}, at: j1939_sk_netdev_event_netdown+0x28/0x160 net/can/j1939/socket.c:1266

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2
 (&priv->j1939_socks_lock){+.-.}-{2:2}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:354 [inline]
       j1939_sk_errqueue+0x9f/0x1a0 net/can/j1939/socket.c:1078
       j1939_session_destroy+0x301/0x3d0 net/can/j1939/transport.c:269
       __j1939_session_release net/can/j1939/transport.c:288 [inline]
       kref_put include/linux/kref.h:65 [inline]
       j1939_session_put net/can/j1939/transport.c:293 [inline]
       j1939_session_deactivate_locked net/can/j1939/transport.c:1075 [inline]
       j1939_session_deactivate_locked+0x293/0x340 net/can/j1939/transport.c:1063
       j1939_cancel_active_session+0x184/0x370 net/can/j1939/transport.c:2197
       j1939_netdev_notify+0x191/0x1d0 net/can/j1939/main.c:371
       notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
       call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1943
       call_netdevice_notifiers_extack net/core/dev.c:1981 [inline]
       call_netdevice_notifiers net/core/dev.c:1995 [inline]
       __dev_notify_flags+0x1da/0x2b0 net/core/dev.c:8571
       dev_change_flags+0x112/0x170 net/core/dev.c:8607
       do_setlink+0x961/0x3bb0 net/core/rtnetlink.c:2780
       __rtnl_newlink+0xd6a/0x17e0 net/core/rtnetlink.c:3546
       rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
       rtnetlink_rcv_msg+0x43a/0xc90 net/core/rtnetlink.c:6089
       netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
       sock_sendmsg_nosec net/socket.c:714 [inline]
       sock_sendmsg+0xcf/0x120 net/socket.c:734
       ____sys_sendmsg+0x6eb/0x810 net/socket.c:2492
       ___sys_sendmsg+0xf3/0x170 net/socket.c:2546
       __sys_sendmsg net/socket.c:2575 [inline]
       __do_sys_sendmsg net/socket.c:2584 [inline]
       __se_sys_sendmsg net/socket.c:2582 [inline]
       __x64_sys_sendmsg+0x132/0x220 net/socket.c:2582
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

-> #1 (&priv->active_session_list_lock
){+.-.}-{2:2}
:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:354 [inline]
       j1939_session_list_lock net/can/j1939/transport.c:238 [inline]
       j1939_session_activate+0x43/0x4b0 net/can/j1939/transport.c:1567
       j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:181 [inline]
       j1939_sk_queue_activate_next+0x29b/0x460 net/can/j1939/socket.c:205
       j1939_session_deactivate_activate_next net/can/j1939/transport.c:1101 [inline]
       j1939_session_completed+0x19a/0x1f0 net/can/j1939/transport.c:1219
       j1939_xtp_rx_eoma_one net/can/j1939/transport.c:1398 [inline]
       j1939_xtp_rx_eoma+0x2a6/0x5f0 net/can/j1939/transport.c:1413
       j1939_tp_cmd_recv net/can/j1939/transport.c:2102 [inline]
       j1939_tp_recv+0x930/0xcb0 net/can/j1939/transport.c:2147
       j1939_can_recv+0x6ff/0x9a0 net/can/j1939/main.c:108
       deliver net/can/af_can.c:574 [inline]
       can_rcv_filter+0x5d4/0x8d0 net/can/af_can.c:608
       can_receive+0x31d/0x580 net/can/af_can.c:665
       can_rcv+0x120/0x1c0 net/can/af_can.c:696
       __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5478
       __netif_receive_skb+0x24/0x1b0 net/core/dev.c:5592
       process_backlog+0x3a0/0x7c0 net/core/dev.c:5920
       __napi_poll+0xb3/0x6e0 net/core/dev.c:6486
       napi_poll net/core/dev.c:6553 [inline]
       net_rx_action+0x9c1/0xd90 net/core/dev.c:6664
       __do_softirq+0x29b/0x9c2 kernel/softirq.c:571
       run_ksoftirqd kernel/softirq.c:934 [inline]
       run_ksoftirqd+0x2d/0x60 kernel/softirq.c:926
       smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
       kthread+0x2e9/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

-> #0 (&jsk->sk_session_queue_lock){+.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5665 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:354 [inline]
       j1939_sk_queue_drop_all+0x40/0x2f0 net/can/j1939/socket.c:139
       j1939_sk_netdev_event_netdown+0x7b/0x160 net/can/j1939/socket.c:1272
       j1939_netdev_notify+0x199/0x1d0 net/can/j1939/main.c:372
       notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
       call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1943
       call_netdevice_notifiers_extack net/core/dev.c:1981 [inline]
       call_netdevice_notifiers net/core/dev.c:1995 [inline]
       __dev_notify_flags+0x1da/0x2b0 net/core/dev.c:8571
       dev_change_flags+0x112/0x170 net/core/dev.c:8607
       do_setlink+0x961/0x3bb0 net/core/rtnetlink.c:2780
       __rtnl_newlink+0xd6a/0x17e0 net/core/rtnetlink.c:3546
       rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
       rtnetlink_rcv_msg+0x43a/0xc90 net/core/rtnetlink.c:6089
       netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
       sock_sendmsg_nosec net/socket.c:714 [inline]
       sock_sendmsg+0xcf/0x120 net/socket.c:734
       ____sys_sendmsg+0x6eb/0x810 net/socket.c:2492
       ___sys_sendmsg+0xf3/0x170 net/socket.c:2546
       __sys_sendmsg net/socket.c:2575 [inline]
       __do_sys_sendmsg net/socket.c:2584 [inline]
       __se_sys_sendmsg net/socket.c:2582 [inline]
       __x64_sys_sendmsg+0x132/0x220 net/socket.c:2582
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

other info that might help us debug this:

Chain exists of:
  &jsk->sk_session_queue_lock --> 
&priv->active_session_list_lock --> &priv->j1939_socks_lock


 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&priv->j1939_socks_lock);
                               lock(&priv->active_session_list_lock);
                               lock(
&priv->j1939_socks_lock);
  lock(
&jsk->sk_session_queue_lock);

 *** DEADLOCK ***

2 locks held by syz-executor.0/4079:
 #0: ffffffff8d5937e8 (rtnl_mutex
){+.+.}-{3:3}
, at: rtnl_lock net/core/rtnetlink.c:74 [inline]
, at: rtnetlink_rcv_msg+0x3e5/0xc90 net/core/rtnetlink.c:6086
 #1: ffff888022b210d0 (&priv->j1939_socks_lock
){+.-.}-{2:2}
, at: spin_lock_bh include/linux/spinlock.h:354 [inline]
, at: j1939_sk_netdev_event_netdown+0x28/0x160 net/can/j1939/socket.c:1266

stack backtrace:
CPU: 0 PID: 4079 Comm: syz-executor.0 Not tainted 5.18.0-syzkaller-12234-g50fd82b3a9a9-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:354 [inline]
 j1939_sk_queue_drop_all+0x40/0x2f0 net/can/j1939/socket.c:139
 j1939_sk_netdev_event_netdown+0x7b/0x160 net/can/j1939/socket.c:1272
 j1939_netdev_notify+0x199/0x1d0 net/can/j1939/main.c:372
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1943
 call_netdevice_notifiers_extack net/core/dev.c:1981 [inline]
 call_netdevice_notifiers net/core/dev.c:1995 [inline]
 __dev_notify_flags+0x1da/0x2b0 net/core/dev.c:8571
 dev_change_flags+0x112/0x170 net/core/dev.c:8607
 do_setlink+0x961/0x3bb0 net/core/rtnetlink.c:2780
 __rtnl_newlink+0xd6a/0x17e0 net/core/rtnetlink.c:3546
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
 rtnetlink_rcv_msg+0x43a/0xc90 net/core/rtnetlink.c:6089
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2492
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2546
 __sys_sendmsg net/socket.c:2575 [inline]
 __do_sys_sendmsg net/socket.c:2584 [inline]
 __se_sys_sendmsg net/socket.c:2582 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2582
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f106a489109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f106b644168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f106a59c030 RCX: 00007f106a489109
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000005
RBP: 00007f106a4e308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcb00ebfaf R14: 00007f106b644300 R15: 0000000000022000
 </TASK>
A link change request failed with some changes committed already. Interface vxcan0 may have been left with an inconsistent configuration, please check.


Tested on:

commit:         50fd82b3 Merge tag 'docs-5.19-2' of git://git.lwn.net/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14f3f82bf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc5a30a131480a80
dashboard link: https://syzkaller.appspot.com/bug?extid=3bd970a1887812621b4c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ee5177f00000

