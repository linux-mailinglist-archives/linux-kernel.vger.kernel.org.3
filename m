Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9B455176B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbiFTL1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbiFTL1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:27:33 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A5D15FE2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:27:33 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id n20-20020a6b7214000000b00669cae33d00so5942178ioc.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=22nVBBfe4tIIVDMPCzCiMVpzsm6lVoVyYpGtO5bnuDc=;
        b=wjtXaTWsyLdi6q7RjsEupi0ed14DtT6ZO4gBsb2lGWXziCn/sGcqOyZtN22HFIAzW/
         K4aojTHXOKWxaVQIaQGi0Cw5Vi9blpByMcljbCjRxI2HTTTj1MrpXutCKD1uWLNZWpGg
         NTi00iariLypLJJKz0H91u3YuYnBmLFh1gqrnMEz9bAX6U9fKpdI66yAPocyKLFSlIdB
         T8t4hFziNAKqj8Isaah4t2G6+rhND+NXBPZboRVxvyxCMJ+JIljAd6I4bBLseV0mnBEC
         0GPVVYMGjChPpprx0KO/czv1z7FGrvCaQy8zMBCGOE+cSmoGi2Q0vNuQKJj9zZTdC/mk
         KBOA==
X-Gm-Message-State: AJIora+8mjFUFLDWXqWy3G8PK5hfHUhWxDJeBl08MuFa1LrUSUOC7QO6
        Eb8B/Xf8IqiKBSUSXjB08/tcboLi3+L0a8yRVeUMod/TSHQ1
X-Google-Smtp-Source: AGRyM1uZVqZNypIPsntJ0rczFRz1VroYrhpXvAa1Nkm2aCB0TnEj+tDUEjzz+J5+YhCNSbBGmqyT3Im5W0PmtPXJbmYdyUMaRhXf
MIME-Version: 1.0
X-Received: by 2002:a05:6638:190f:b0:339:bc9b:4d90 with SMTP id
 p15-20020a056638190f00b00339bc9b4d90mr683573jal.153.1655724452470; Mon, 20
 Jun 2022 04:27:32 -0700 (PDT)
Date:   Mon, 20 Jun 2022 04:27:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5e6b605e1df63be@google.com>
Subject: [syzbot] BUG: scheduling while atomic in exit_to_user_mode_prepare
From:   syzbot <syzbot+0b658e1b540fcfc0be70@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1584bc0ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4154677977b1776
dashboard link: https://syzkaller.appspot.com/bug?extid=0b658e1b540fcfc0be70
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b658e1b540fcfc0be70@syzkaller.appspotmail.com

BUG: scheduling while atomic: syz-executor.3/16818/0x00000002
no locks held by syz-executor.3/16818.
Modules linked in:
Preemption disabled at:
[<ffffffff81bc96e5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
[<ffffffff81bc96e5>] rmqueue mm/page_alloc.c:3858 [inline]
[<ffffffff81bc96e5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.c:4293
Kernel panic - not syncing: scheduling while atomic
CPU: 1 PID: 16818 Comm: syz-executor.3 Not tainted 5.19.0-rc2-next-20220615-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 panic+0x2d7/0x636 kernel/panic.c:274
 __schedule_bug.cold+0x10c/0x143 kernel/sched/core.c:5690
 schedule_debug kernel/sched/core.c:5719 [inline]
 __schedule+0x31a8/0x4c00 kernel/sched/core.c:6354
 schedule+0xd2/0x1f0 kernel/sched/core.c:6532
 exit_to_user_mode_loop kernel/entry/common.c:157 [inline]
 exit_to_user_mode_prepare+0x142/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f6012689152
Code: 00 00 00 00 00 0f 1f 00 41 f7 c1 ff 0f 00 00 75 27 55 48 89 fd 53 89 cb 48 85 ff 74 3b 41 89 da 48 89 ef b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 5b 5d c3 0f 1f 00 48 c7 c0 b8 ff ff ff 64
RSP: 002b:00007ffd01d6ca18 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: 00007f60137cb000 RBX: 0000000000020022 RCX: 00007f6012689152
RDX: 0000000000000000 RSI: 0000000000021000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffd01d6cc20
R13: 00007f6011dff700 R14: 0000000000000000 R15: 0000000000022000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
