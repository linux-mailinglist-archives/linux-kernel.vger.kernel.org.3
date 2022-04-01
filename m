Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6B4EE598
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbiDABLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbiDABK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:10:58 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F49727CF6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:09:10 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id o17-20020a92c691000000b002c2c04aebe7so873039ilg.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cbo/jShsFUAGlPs6dVTq7WbfSsRkM0N8e/bH+Ub2H5A=;
        b=fcx0VbAYTdQNH/7A8jaxpmiuuonEX309csQMP+m4+p5jpHwUxCHk+C6YrnPD58h8+/
         gCU1vIfdDv6OUE5LNhYGQ/p2JDwDU7y9967se1PzyfjYL2HQWNldo841BVT7QXoGTzv5
         iTliz9R5+ss+9yAND/v4W9NOE6XM2h0Xe6eJYqprobM4qufxuGeVycfu7q7dGxOu+Wj4
         VEMVrhWjZdWRLm2yHv5eaf9ledzgX6+R/Mv3y0prxWc93msR/QwGClB9dgLTGQ1jbLIR
         BBwP072iYtNGbG/3Xk9pc99ZD0KxZbkvCU+CmkehTiJ5e9+nOE6XUTjIgeYb7bteBHWj
         0x6Q==
X-Gm-Message-State: AOAM531YskuIDMakytlVAiRFUUurO+Sy2jIy+fTgdciPXb+8E2S8nH6x
        fSbrXFjnkThAodF8CeJx+B6G0Syk9X2rs39+A+OmAdQ8k1uC
X-Google-Smtp-Source: ABdhPJz/yDuL3P4Ht8vpgJFNyxlwqHA2nVEnERi7rPqOSYJE5xVtonfQVHGBU0Vo00tdNlmI0jX0epB+rsHn8gf/MKS6QbBmdhGc
MIME-Version: 1.0
X-Received: by 2002:a02:2715:0:b0:323:55f3:8ae6 with SMTP id
 g21-20020a022715000000b0032355f38ae6mr4598241jaa.192.1648775349530; Thu, 31
 Mar 2022 18:09:09 -0700 (PDT)
Date:   Thu, 31 Mar 2022 18:09:09 -0700
In-Reply-To: <20220401005730.4812-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005fb8305db8d6d24@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_xtp_rx_dat_one (3)
From:   syzbot <syzbot+a9dce1ff45c3bbeceb3a@syzkaller.appspotmail.com>
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
WARNING in j1939_session_deactivate_activate_next

vcan0: j1939_xtp_rx_abort_one: 0xffff888010f92000: 0x00000: (3) A timeout occurred and this is the connection abort to close the session.
vcan0: j1939_xtp_rx_abort_one: 0xffff88807c1b1000: 0x00000: (3) A timeout occurred and this is the connection abort to close the session.
vcan0: j1939_xtp_rx_abort_one: 0xffff88801af96000: 0x00000: (3) A timeout occurred and this is the connection abort to close the session.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 21 at net/can/j1939/transport.c:1088 j1939_session_deactivate net/can/j1939/transport.c:1088 [inline]
WARNING: CPU: 1 PID: 21 at net/can/j1939/transport.c:1088 j1939_session_deactivate_activate_next+0x95/0xd3 net/can/j1939/transport.c:1098
Modules linked in:
CPU: 1 PID: 21 Comm: ksoftirqd/1 Tainted: G        W         5.17.0-syzkaller-08652-gae085d7f9365-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:j1939_session_deactivate net/can/j1939/transport.c:1088 [inline]
RIP: 0010:j1939_session_deactivate_activate_next+0x95/0xd3 net/can/j1939/transport.c:1098
Code: 03 38 d0 7c 0c 84 d2 74 08 4c 89 ef e8 75 69 69 f8 8b 5d 28 bf 01 00 00 00 89 de e8 76 c3 1d f8 83 fb 01 77 07 e8 4c c1 1d f8 <0f> 0b e8 45 c1 1d f8 48 89 ef e8 5d 22 dd fe 4c 89 e7 89 c3 e8 c3
RSP: 0018:ffffc900001b79b0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000100
RDX: ffff888011a59d00 RSI: ffffffff895adaf4 RDI: 0000000000000003
RBP: ffff88801af96000 R08: 0000000000000001 R09: ffff88801af9602b
R10: ffffffff895adaea R11: 000000000000001d R12: ffff88801e58d070
R13: ffff88801af96028 R14: ffff88807ba16418 R15: ffffffff8ae458c0
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056002b304fe8 CR3: 000000001b125000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 j1939_xtp_rx_abort_one.cold+0x20b/0x33c net/can/j1939/transport.c:1338
 j1939_xtp_rx_abort net/can/j1939/transport.c:1349 [inline]
 j1939_tp_cmd_recv net/can/j1939/transport.c:2098 [inline]
 j1939_tp_recv+0xb28/0xcb0 net/can/j1939/transport.c:2131
 j1939_can_recv+0x6ff/0x9a0 net/can/j1939/main.c:108
 deliver net/can/af_can.c:574 [inline]
 can_rcv_filter+0x5d4/0x8d0 net/can/af_can.c:608
 can_receive+0x31d/0x580 net/can/af_can.c:665
 can_rcv+0x120/0x1c0 net/can/af_can.c:696
 __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5405
 __netif_receive_skb+0x24/0x1b0 net/core/dev.c:5519
 process_backlog+0x3a0/0x7c0 net/core/dev.c:5847
 __napi_poll+0xb3/0x6e0 net/core/dev.c:6413
 napi_poll net/core/dev.c:6480 [inline]
 net_rx_action+0x8ec/0xc60 net/core/dev.c:6567
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>


Tested on:

commit:         ae085d7f mm: kfence: fix missing objcg housekeeping fo..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=16ab36fd700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bae4cd50262530e
dashboard link: https://syzkaller.appspot.com/bug?extid=a9dce1ff45c3bbeceb3a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151c6fbb700000

