Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0F59AEF2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344722AbiHTP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiHTP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 11:58:35 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85BD12D06
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 08:58:33 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id q10-20020a0566022f0a00b00688d703717bso4040210iow.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 08:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=ePD9bUavyFr8jSLLbSQA5YgaIeYp711T+Ky+DVcgvA0=;
        b=llkuGrbzvhMPAImT6Jeg4BRHHo5rZqFYT1Ok8KEQ73IDJwdcjIMPEDPRzKe7p82Zdl
         JqbnUAg3F6SvhXpKTYhWfQ8clQANfhWNE/kEO2F6V7i5fJrx4Y3qBWHwe36+GW6xC7oB
         pIvcXRFEA0ck6VSQZLGEUnPlBQlS4iJoItK4rsHQT+6sN18vebs+wzrxUYkBAiTwoQMt
         iaEwRAMDRk4hxF+MlF5juJ4vk88q1undidmB3uRfR5gdbBQ5XMB8k/ITa+Wpbuumu8j8
         UPE70b75wW8+Ls9PjeR11Qai7bLh9fq9JIu0is2nR+y07iLiKrYCV8LVfwvpes+yKUz3
         rNPQ==
X-Gm-Message-State: ACgBeo0Ygl06FTOlJ41ahPidCWTsYwM93PNZAFPhgPIPZkGKZeKz1lN9
        pwFRUW1gaL5UVU9qhgerHxbW+2cwiXxY4p6fDjaquEboN3Pu
X-Google-Smtp-Source: AA6agR4k7qXWr6W4x/HblG2A9VuwXN7IaZNShihGHQF6xCr9dmrqH2gUNwOpNJfrEKcsXKd1ggeYtYtAHhKRYxsWgcgQMwMUGYmj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:2e9:41da:c76d with SMTP id
 l10-20020a056e021aaa00b002e941dac76dmr3380683ilv.45.1661011113135; Sat, 20
 Aug 2022 08:58:33 -0700 (PDT)
Date:   Sat, 20 Aug 2022 08:58:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005dd4c005e6ae49c4@google.com>
Subject: [syzbot] KASAN: vmalloc-out-of-bounds Read in kvm_put_kvm
From:   syzbot <syzbot+ee478a0237db20ef61f1@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=124e1715080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=ee478a0237db20ef61f1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1403627b080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1672d823080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee478a0237db20ef61f1@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __list_del_entry_valid+0xf2/0x110 lib/list_debug.c:59
Read of size 8 at addr ffffc900039da340 by task syz-executor260/3614

CPU: 0 PID: 3614 Comm: syz-executor260 Not tainted 5.19.0-syzkaller-13930-g7ebfc85e2cd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x59/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 __list_del_entry_valid+0xf2/0x110 lib/list_debug.c:59
 __list_del_entry include/linux/list.h:134 [inline]
 list_del include/linux/list.h:148 [inline]
 kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1290 [inline]
 kvm_put_kvm+0x130/0xb70 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1352
 kvm_vm_release+0x3f/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1375
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
RIP: 0033:0x7fd7dbdc3d39
Code: Unable to access opcode bytes at RIP 0x7fd7dbdc3d0f.
RSP: 002b:00007ffce9fd1d88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fd7dbe383f0 RCX: 00007fd7dbdc3d39
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd7dbe383f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Memory state around the buggy address:
 ffffc900039da200: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900039da280: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc900039da300: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                           ^
 ffffc900039da380: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900039da400: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
