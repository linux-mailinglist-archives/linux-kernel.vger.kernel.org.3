Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ABA54F0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380244AbiFQGId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiFQGIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:08:23 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD7BF5E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 23:08:22 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id p12-20020a056e02144c00b002d196a4d73eso2103147ilo.18
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 23:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Vq64f5Yo+ZtrtgGuEyyE62AarYLrNtpZHBOYMYaaxMA=;
        b=KuT3hGUxpBqXVMvAfcbJ9yU3z1Tzjzyni4sEextHkyMnG7UlHxBXiTbvAcGpg0cbhL
         uqrPhGCJ4D28bNNtXBiBllbq6lDlIlo66MPpa8BH3lau9t8pV63MZdcOSM8S7J5oOpEY
         AivMX8L188sPwaIqBZZkE/zoheuBMOyLXjO5/mx6o+33ef9JKK46nRtM1rGRadEXa8FB
         xcRVXf/kn4EfG65Lt0Z6xL/KMnr8K9YN4WFYFM3b2D3ScN5A+H8Pncpnea5RSiwW77oD
         5yZOoLXB6ydHjri3ZvoaqjtkGaEqSZ7v3fmofKTn3FGlSoGDF1tBr0eRpG7kOUe+wWk/
         TbNg==
X-Gm-Message-State: AJIora+EU4y929JdLgO2t7sTFzdxzcJaWSdFcv/RVPsquKFj07LwS16r
        8OtkFtUOPlEjp/dOymXSihDBOR3zXg8j0NWowL9wx+ASxiUw
X-Google-Smtp-Source: AGRyM1uIshwWCyv7TkGRHyahmmRuS34MIaMCsxXFhmcyVSjmXS7wBjO3gpKmH/gG/4El87wExy+vL9asjrU8IT3zlKTmnoMkpGin
MIME-Version: 1.0
X-Received: by 2002:a92:511:0:b0:2d7:9136:4d0b with SMTP id
 q17-20020a920511000000b002d791364d0bmr4703340ile.266.1655446101950; Thu, 16
 Jun 2022 23:08:21 -0700 (PDT)
Date:   Thu, 16 Jun 2022 23:08:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da07e205e19e94cf@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in __purge_vmap_area_lazy
From:   syzbot <syzbot+0bce0ec817c084f98c56@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    6012273897fe Add linux-next specific files for 20220615
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16d2f608080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4154677977b1776
dashboard link: https://syzkaller.appspot.com/bug?extid=0bce0ec817c084f98c56
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0bce0ec817c084f98c56@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/vmalloc.c:1759
BUG: sleeping function called from invalid context at mm/vmalloc.c:1759
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1795, name: kworker/1:2
preempt_count: 2, expected: 1
RCU nest depth: 0, expected: 0
4 locks held by kworker/1:2/1795:
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90006c07da8 (drain_vmap_work){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffffffff8bebb028 (vmap_purge_lock){+.+.}-{3:3}, at: drain_vmap_area_work+0x44/0xe0 mm/vmalloc.c:1781
 #3: ffffffff8bebb2f8 (free_vmap_area_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:360 [inline]
 #3: ffffffff8bebb2f8 (free_vmap_area_lock){+.+.}-{2:2}, at: __cond_resched_lock+0xa6/0xe0 kernel/sched/core.c:8306
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 1795 Comm: kworker/1:2 Not tainted 5.19.0-rc2-next-20220615-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events drain_vmap_area_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9823
 __purge_vmap_area_lazy+0x95c/0x1c50 mm/vmalloc.c:1759
 drain_vmap_area_work+0x52/0xe0 mm/vmalloc.c:1782
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
BUG: workqueue leaked lock or atomic: kworker/1:2/0x00000001/1795
     last function: drain_vmap_area_work
no locks held by kworker/1:2/1795.
CPU: 1 PID: 1795 Comm: kworker/1:2 Tainted: G        W         5.19.0-rc2-next-20220615-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events drain_vmap_area_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 process_one_work.cold+0x96/0xb8 kernel/workqueue.c:2304
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
BUG: scheduling while atomic: kworker/1:2/1795/0x00000002
no locks held by kworker/1:2/1795.
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
