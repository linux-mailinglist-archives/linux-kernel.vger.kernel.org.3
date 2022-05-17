Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40352AA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347234AbiEQSMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351966AbiEQSM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:12:27 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E5D51329
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:12:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id i66-20020a6bb845000000b00657bac76fb4so12897931iof.15
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2SsZ2ZnxG5ZHDadCbewwN19Op2p0c/n0nLkBUlfR4vg=;
        b=4Xvmjyop7jkxszKVdNJvv5KlK4NFmEdll3nUo0nnsn+s/UbpDkuuWM4xZ10aO/gXHz
         EuajZx4G2JuqCET2nR+BUXhmrq7T8O49+I5MsbBo/sJfRAb5PzS2m7xA3F3NAktD9VCh
         wZkUlYBOOo4jfaXJqH7nH0fRJSJIjk8ImPTgksyNvCy5cTMiNLNjPjbHu8Qss0Bt1mOZ
         GreD5fUng8LHDQFQmGrPmTYht0tNBIucYhrJ9TcGAEg9GsJZTR05m1zqD1taJvaN46l8
         c+4HyquM/B56HVLQ9AOzNqkmkybw6CTPmlkY4Ubp2vlvkF4h9ppVrFngj2VxcxgIUmnb
         uCvQ==
X-Gm-Message-State: AOAM533mpOKiJXOIePcK4GFXibmWJv0wB8HrbHOnrQitjmoXLbiSOL9C
        7VrZBpbA8+RbJu+akTCHymA+Ubsu2zR1ghaYZoH+e6VZ4P+w
X-Google-Smtp-Source: ABdhPJwcnaHdiWL01/DHKvxOr0NKEflr4qJALuXhXs/4Hbw/fL+3YOfdtmmi4/0tM0ETEpBEZHEJQTfMiRBya4qQtEIvOzvq2kAK
MIME-Version: 1.0
X-Received: by 2002:a02:234a:0:b0:32a:f07c:e8 with SMTP id u71-20020a02234a000000b0032af07c00e8mr12249927jau.87.1652811141389;
 Tue, 17 May 2022 11:12:21 -0700 (PDT)
Date:   Tue, 17 May 2022 11:12:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6a32905df3914e1@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in nfnetlink_unbind
From:   syzbot <syzbot+4903218f7fba0a2d6226@syzkaller.appspotmail.com>
To:     ali.abdallah@suse.com, coreteam@netfilter.org, davem@davemloft.net,
        edumazet@google.com, fw@strlen.de, kadlec@netfilter.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        ozsh@nvidia.com, pabeni@redhat.com, pablo@netfilter.org,
        paulb@nvidia.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    d887ae3247e0 octeontx2-pf: Remove unnecessary synchronize_..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=118621f1f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1aab282dc5dd920
dashboard link: https://syzkaller.appspot.com/bug?extid=4903218f7fba0a2d6226
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c775bef00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1428ee59f00000

The issue was bisected to:

commit 2794cdb0b97bfe62d25c996c8afe4832207e78bc
Author: Florian Westphal <fw@strlen.de>
Date:   Mon Apr 25 13:15:41 2022 +0000

    netfilter: nfnetlink: allow to detect if ctnetlink listeners exist

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14885b35f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16885b35f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12885b35f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4903218f7fba0a2d6226@syzkaller.appspotmail.com
Fixes: 2794cdb0b97b ("netfilter: nfnetlink: allow to detect if ctnetlink listeners exist")

================================================================================
UBSAN: array-index-out-of-bounds in net/netfilter/nfnetlink.c:697:28
index 10 is out of range for type 'int [10]'
CPU: 1 PID: 3606 Comm: syz-executor222 Not tainted 5.18.0-rc6-syzkaller-01525-gd887ae3247e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:283
 nfnetlink_unbind+0x38c/0x3b0 net/netfilter/nfnetlink.c:697
 netlink_release+0xa8f/0x1db0 net/netlink/af_netlink.c:773
 __sock_release+0xcd/0x280 net/socket.c:650
 sock_close+0x18/0x20 net/socket.c:1365
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:37 [inline]
 do_exit+0xaff/0x2a00 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f23ae868639
Code: Unable to access opcode bytes at RIP 0x7f23ae86860f.
RSP: 002b:00007ffe9dd00178 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f23ae8dc270 RCX: 00007f23ae868639
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f23ae8dc270
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
