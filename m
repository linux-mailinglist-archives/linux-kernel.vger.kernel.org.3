Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849B5595729
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiHPJyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiHPJxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:53:52 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3595B1146C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:42:26 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id z2-20020a921a42000000b002e5a6de09c1so3897890ill.21
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=KRPjL8GvYUvELGffbzamdGsssOGfHVZFVA/AFnScLEw=;
        b=7EW7sBtU/L0/Uu2IL1m81MVewys8GgOdPSHixd9E/zAONn+hHNfU2Kt6MFz3Rmq8yU
         JLC8vR2WYQqd9FgHV6MCcIEmRMqDn1jaXEdqqc28C68qSoMQn+9xcU3DEw+EONdkjaDV
         L52khtk5dAd1I2MZh1IOUp+IlMGJaITTcdEvkb1NAySL5JRhnGhIRG0NFTjnXD4GwDyY
         ET+z/B6LTXA/8CJOSrpisuENwpMoYxmqBob+g3RRuP4XzX2TQYI8IoqPPaVfRHEprzOo
         RCUrxbm+xImECYeB/xp615+gN/WNs5ZzAG281dSNuv1oVceVSFw9Do1QP1Cj1qtTqgIo
         bZAQ==
X-Gm-Message-State: ACgBeo0y+hhXTWyQXkMzgaQBwoIGI1l/IZ0vQKJ1Kc7B+NelAgfCoJU9
        sjOC1FPjX8JMPqoNeSQ5c0WW3xmkH5SDFhJctx9bZtmE3zjQ
X-Google-Smtp-Source: AA6agR5cgHqgAhQKLNWZHTDbmAdZbKfGXCdXvUkDp+tS9uFR94JxSZsj7BWxKclXGZs8jZm7MO5Hwn5MlNlqq3IhmdspJW6qLisK
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:2df:9b36:cf34 with SMTP id
 l15-20020a056e021aaf00b002df9b36cf34mr8972694ilv.45.1660639345593; Tue, 16
 Aug 2022 01:42:25 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:42:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b540c05e657ba2e@google.com>
Subject: [syzbot] upstream boot error: WARNING: ODEBUG bug in __do_softirq
From:   syzbot <syzbot+94c142d893fadc95fe49@syzkaller.appspotmail.com>
To:     Henry.Wang@arm.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, longpeng2@huawei.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
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

HEAD commit:    69dac8e431af Merge tag 'riscv-for-linus-5.20-mw2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12af94d3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6bcb425ba129b87
dashboard link: https://syzkaller.appspot.com/bug?extid=94c142d893fadc95fe49
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94c142d893fadc95fe49@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: active_state not available (active state 0) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 21 at lib/debugobjects.c:502 debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Modules linked in:
CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 5.19.0-syzkaller-14184-g69dac8e431af #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd e0 fe 48 8a 4c 89 ee 48 c7 c7 80 f2 48 8a e8 bf 17 39 05 <0f> 0b 83 05 45 ca dd 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc900001b7c10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: ffff888011ba1d80 RSI: ffffffff8161f148 RDI: fffff52000036f74
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000100 R11: 0000000000000001 R12: ffffffff89ee2100
R13: ffffffff8a48f760 R14: 0000000000000000 R15: ffff88800000eda9
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000bc8e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 debug_object_active_state lib/debugobjects.c:948 [inline]
 debug_object_active_state+0x1d2/0x350 lib/debugobjects.c:911
 debug_rcu_head_unqueue kernel/rcu/rcu.h:198 [inline]
 rcu_do_batch kernel/rcu/tree.c:2238 [inline]
 rcu_core+0x75e/0x1890 kernel/rcu/tree.c:2505
 __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:934 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:926
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
