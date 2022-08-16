Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E70F5957B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiHPKNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiHPKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:12:29 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0467FB5A4C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:06:29 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id c7-20020a056e020bc700b002e59be6ce85so4134725ilu.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=UtwS0nVyZ5kC727R08qLoiAMAPVUbacHZbVI+9xSHE0=;
        b=mO5WprcyWKNRwtvC1k6pfmHENS6clQd9LDS+bpPZpwutvxvosgwYHa83peCie74jC9
         KeBNfEahcZUGrjEcJOmjHhKZH+ZgWmJhqoKsDBWgDjNhrZNEwNB7YZFF4X2gB8L+JQDr
         QGmbE7wVdlyksdOlhwJhO7wbFFF9JiRrM5uVQeIxcz+CEoPHTgqbppVYoj1E2SzTb3IL
         BSIPRrKg/EUf4keUqKcQje0tZeKlV8IVohhYqitYg4OjX26mTEfbL8EKmu/oYf/5TYJv
         zGc8UfhSeK22zGgQm7TcMoovZktlN+NbYGrkxJaXM0sUtAS+ZGn90l4hdsX1DdMVgldw
         EJWQ==
X-Gm-Message-State: ACgBeo3FigpRkclHTkm0zllxTMqlSJT9cC83k9tADYu/KbiFMo8w7JSw
        Sye7LIgg4LwAh33taECfMShSmjeUeVVO7X2Itu6gtb3kVbUN
X-Google-Smtp-Source: AA6agR7Z/1cnGAM6piRsfrfKZLTURpPQd1CpAoJCLIRAx0bElE/Nee8SUBDwUYprfG2PsvdubL71DA/Ng8Cev+lUmOV+Rii38KYa
MIME-Version: 1.0
X-Received: by 2002:a05:6638:31c1:b0:33f:2450:46a9 with SMTP id
 n1-20020a05663831c100b0033f245046a9mr9107806jav.45.1660640788361; Tue, 16 Aug
 2022 02:06:28 -0700 (PDT)
Date:   Tue, 16 Aug 2022 02:06:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a37dc05e6581005@google.com>
Subject: [syzbot] KASAN: vmalloc-out-of-bounds Read in blocking_notifier_chain_unregister
From:   syzbot <syzbot+2fd9312f3ff65d22d06f@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, bp@suse.de, dmitry.osipenko@collabora.com,
        linux-kernel@vger.kernel.org, mirq-linux@rere.qmqm.pl,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=160d0915080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=2fd9312f3ff65d22d06f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f5b2f3080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121c0067080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2fd9312f3ff65d22d06f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in notifier_chain_unregister kernel/notifier.c:51 [inline]
BUG: KASAN: vmalloc-out-of-bounds in blocking_notifier_chain_unregister+0x230/0x290 kernel/notifier.c:329
Read of size 8 at addr ffffc900038ebbe8 by task syz-executor342/3606

CPU: 1 PID: 3606 Comm: syz-executor342 Not tainted 5.19.0-syzkaller-13930-g7ebfc85e2cd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x59/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 notifier_chain_unregister kernel/notifier.c:51 [inline]
 blocking_notifier_chain_unregister+0x230/0x290 kernel/notifier.c:329
 hci_unregister_suspend_notifier+0x73/0x90 net/bluetooth/hci_core.c:2760
 hci_unregister_dev+0x16f/0x4e0 net/bluetooth/hci_core.c:2678
 vhci_release+0x7c/0xf0 drivers/bluetooth/hci_vhci.c:568
 __fput+0x277/0x9d0 fs/file_table.c:320
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xad5/0x29b0 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f278bd0d3c9
Code: Unable to access opcode bytes at RIP 0x7f278bd0d39f.
RSP: 002b:00007ffe2fd53298 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f278bd91450 RCX: 00007f278bd0d3c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffb8 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f278bd91450
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Memory state around the buggy address:
 ffffc900038eba80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900038ebb00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc900038ebb80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                                          ^
 ffffc900038ebc00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900038ebc80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
