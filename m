Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0B559A20
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiFXNK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiFXNK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:10:27 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3AE33E3D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:10:23 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i8-20020a056e020d8800b002d931252904so1338198ilj.23
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DMZzzlCWQIrOcclOW2v2ds15+2khTdlV1bCS793JLOU=;
        b=CrBT8SOg09YBBy8FwW7SPAPQD7qsF5qTacnPiB9ZgkgO/VDsepvOuw4UXb1y+Ksxq0
         tKeWvYticZIORZp9B3OEFoH2igFuEMOnCdmPmeo/+88PrL6AQ6PGW98AWuQPFv+ZSzxh
         7Bqpx28/NvFnWuBQ+Y46rbe9EA86qu0fiQ59oIc0r9JHdQCgs1nP5wArAPC9o0D2uQZy
         JYgiB6mK4iEFZZtffioWusve3F+tbsTVHSBF8LZpGS0F1EEgiODeTYZRnNPmd7PaCFhr
         EhepfpOZ0dgg5//zZOKJJrs9KToEcbrrzHzn3dIDDcmnIpcfXKurXeeLltCfTpDwFP2q
         DGiQ==
X-Gm-Message-State: AJIora+fT3bNIQVEJvoz5DzdOTSevWpJ+oYE4UCLbfTBqlRuHN7DGMat
        EVNG9PnUDr16uIre/QksFDB/D5p8uyVNQbvUhL4dg4+/P8t9
X-Google-Smtp-Source: AGRyM1vIQeJ1flCg5zQGSPZf3mXdlWbgCLpIqKOJc+UdGrzRz3HlncH9djdUMnqVceAReR2H/0TWz6LVKy2IHqWAP2a4mAD8oolI
MIME-Version: 1.0
X-Received: by 2002:a05:6602:148b:b0:657:c59b:f336 with SMTP id
 a11-20020a056602148b00b00657c59bf336mr7480652iow.141.1656076222953; Fri, 24
 Jun 2022 06:10:22 -0700 (PDT)
Date:   Fri, 24 Jun 2022 06:10:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd80ab05e2314a27@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Read in ida_free (2)
From:   syzbot <syzbot+aa620fb1ece874a3f34c@syzkaller.appspotmail.com>
To:     Julia.Lawall@inria.fr, andreyknvl@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, hdanton@sina.com, jannh@google.com,
        jj251510319013@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, schspa@gmail.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    08897940f458 Add linux-next specific files for 20220623
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14fc8c60080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb185a52c6ad0a8e
dashboard link: https://syzkaller.appspot.com/bug?extid=aa620fb1ece874a3f34c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116b4140080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ab12e4080000

The issue was bisected to:

commit f2d8c2606825317b77db1f9ba0fc26ef26160b30
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Mon Jun 13 14:17:03 2022 +0000

    usb: gadget: Fix non-unique driver names in raw-gadget driver

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b40318080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17b40318080000
console output: https://syzkaller.appspot.com/x/log.txt?x=13b40318080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa620fb1ece874a3f34c@syzkaller.appspotmail.com
Fixes: f2d8c2606825 ("usb: gadget: Fix non-unique driver names in raw-gadget driver")

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: null-ptr-deref in ida_free+0x1b6/0x2e0 lib/idr.c:510
Read of size 8 at addr 0000000000000000 by task syz-executor185/3627

CPU: 1 PID: 3627 Comm: syz-executor185 Not tainted 5.19.0-rc3-next-20220623-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 ida_free+0x1b6/0x2e0 lib/idr.c:510
 dev_free+0xec/0x700 drivers/usb/gadget/legacy/raw_gadget.c:212
 kref_put include/linux/kref.h:65 [inline]
 raw_release+0x219/0x290 drivers/usb/gadget/legacy/raw_gadget.c:424
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xb05/0x2a00 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f12d28b6bd9
Code: Unable to access opcode bytes at RIP 0x7f12d28b6baf.
RSP: 002b:00007ffea2859da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f12d292b3f0 RCX: 00007f12d28b6bd9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 000000000000000b
R10: 00007ffea2857e00 R11: 0000000000000246 R12: 00007f12d292b3f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
