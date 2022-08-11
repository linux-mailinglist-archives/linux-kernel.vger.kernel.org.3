Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1758F863
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiHKHa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiHKHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:30:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7655360686
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:30:24 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id w7-20020a5d9607000000b0067c6030dfb8so9276977iol.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=ptVmYRpwTAytzOHzbgC20ow8CMCrSc5Emaonu1zpz28=;
        b=ye0+VO0iG5EqJRDjet4y1HZlB4l54nWIdfCd1RepfFgL801nZe6PRHC7leKca7fXd4
         zjyI8tJ3ZOXGgAg4ZUD6VC26oCbqWp9h4t8oO8/aNOr+QFyiEADPTuC0doWOHzQ0nI9F
         ukO9YsqFc/R2sSMKn7bRbOIqTjJF9Hkk8FsJz93TDLs1+v7Z31U2qTi1p/PO8Dgj5l4L
         rYKARPF759WIN0/1Mp5IAVJTpGhofdioh5oFqUenVegXpt8xYzLchxbjVcWIRsgvZGzI
         F8O0Occ5BJXEguR2sehLyYkbeGpJWjjEXBMN/aNKQM6wupB0AUZImkAoI/ouwoquAKY2
         uSCQ==
X-Gm-Message-State: ACgBeo1/cQqwMnTRrz/sjZhWLtRp+hpUhjY/uPRsQ5OzGHnVEb6qtwQw
        WmOaE57NJbWma9Idize4b/UxBUhWfHfQtp0cw3MQcLQm64QL
X-Google-Smtp-Source: AA6agR7n8ModS4mXaGNjkSgPePwM3F5tqh0nLBPknJFmuWgnQktnnBkuAQMrgPfKQd0xPUs8wBzCIyp75OES6ntoFGPVnHMibpKH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3687:b0:685:973:79d with SMTP id
 bf7-20020a056602368700b006850973079dmr5350109iob.135.1660203023762; Thu, 11
 Aug 2022 00:30:23 -0700 (PDT)
Date:   Thu, 11 Aug 2022 00:30:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c8ca505e5f22348@google.com>
Subject: [syzbot] linux-next boot error: WARNING: refcount bug in delayed_put_task_struct
From:   syzbot <syzbot+36587b4177139ad51b15@syzkaller.appspotmail.com>
To:     brauner@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
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

HEAD commit:    40d43a7507e1 Add linux-next specific files for 20220811
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16cca697080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5ae8cfa8d7075d1
dashboard link: https://syzkaller.appspot.com/bug?extid=36587b4177139ad51b15
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36587b4177139ad51b15@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 21 at lib/refcount.c:28 refcount_warn_saturate+0x1d1/0x1e0 lib/refcount.c:28
Modules linked in:

CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 5.19.0-next-20220811-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:refcount_warn_saturate+0x1d1/0x1e0 lib/refcount.c:28
Code: e9 db fe ff ff 48 89 df e8 3c ee ca fd e9 8a fe ff ff e8 c2 95 7e fd 48 c7 c7 40 b8 48 8a c6 05 c5 2b cc 09 01 e8 4c ac 3c 05 <0f> 0b e9 af fe ff ff 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 55
RSP: 0000:ffffc900001b7d10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888011a49d80 RSI: ffffffff8161f1f8 RDI: fffff52000036f94
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000100 R11: 0000000000000001 R12: ffff88801faebb00
R13: ffff88801faebb28 R14: ffffc900001b7dc8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000bc8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 put_task_struct include/linux/sched/task.h:118 [inline]
 delayed_put_task_struct+0x2de/0x330 kernel/exit.c:177
 rcu_do_batch kernel/rcu/tree.c:2245 [inline]
 rcu_core+0x7b5/0x1890 kernel/rcu/tree.c:2505
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
