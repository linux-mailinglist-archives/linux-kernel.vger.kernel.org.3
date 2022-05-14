Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46B352715C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiENNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiENNkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:40:09 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5581C22517
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 06:40:08 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id k14-20020a0566022a4e00b0065ae0c238aeso6850245iov.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 06:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=INdvROdDh/6zEjEhZ8TMAIUkIHaBkIrSGppOJMwXt/k=;
        b=jNCTbMzbw8pWqwxI+jZPsBTGaJq57ebgv8oNqBL0xwVsE0tNgaWC1E9qT7cr3pmIsU
         cR8fNsroIphLzHgII24WtgiiLxY3zRv2hxoMOeKgFJ6RyEFYJEWJ06cT7epz/mJFv+tc
         BybhX2S8Bi/y+viu7Jf3+QkZFuJZ4VNDNchGK10hpj6J9jCDg2YeoG56InO9vUEVhDw4
         LrzoGe6GJ9hzob+5JifJVwxgGCmySRz0WL30DbMs/jCwg8ZkDaWgj8DN/N6LvuaViXOF
         t3C+sm4jG0F12F0Zi+blnFt69hQQoeqJVPf1QK283fwmQBZngLyxhuauZUBYai25S4cr
         rjOA==
X-Gm-Message-State: AOAM530uJuygDyVWbWb7VvpELZLFD8HdjJRUDb7mUH6MiGvkemUl8igA
        iXsFPY6Jai2sBhb3mgaqVJoOt5epRH+T/OS8iP0AzThUVG10
X-Google-Smtp-Source: ABdhPJxL4EnCKoIrzsJYoSv4QnUHHbWGupM9x+McF0L0ELkiNhzxiJRLyyLf4Bjim/s0gcJVxJWF4AAmhI+kJD2lkuOUwiCwmHhu
MIME-Version: 1.0
X-Received: by 2002:a92:c7ce:0:b0:2cd:5ffd:9f5e with SMTP id
 g14-20020a92c7ce000000b002cd5ffd9f5emr5113471ilk.34.1652535607775; Sat, 14
 May 2022 06:40:07 -0700 (PDT)
Date:   Sat, 14 May 2022 06:40:07 -0700
In-Reply-To: <20220514132858.1322-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e15b2705def8ed12@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
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
WARNING in mntput_no_expire

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4205 at fs/namespace.c:1226 mntput_no_expire+0x979/0xfe0 fs/namespace.c:1226
Modules linked in:
CPU: 1 PID: 4205 Comm: syz-executor.2 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0x979/0xfe0 fs/namespace.c:1226
Code: 04 00 00 48 8b 35 ef 77 dd 0b b9 01 00 00 00 bf 08 00 00 00 48 c7 c2 60 fe f0 8b e8 21 e1 71 ff e9 01 f9 ff ff e8 17 93 9d ff <0f> 0b e9 b6 f8 ff ff e8 0b 93 9d ff 0f 0b e9 aa f8 ff ff e8 ff 92
RSP: 0018:ffffc9000374fd78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802467bb00 RSI: ffffffff81dbadc9 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81dba668 R11: 0000000000000000 R12: 0000000000000002
R13: ffff888079fad500 R14: dffffc0000000000 R15: ffffed100f3f5aaa
FS:  0000555556994400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555572e8848 CR3: 000000006a5f1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mntput+0x67/0x90 fs/namespace.c:1289
 __fput+0x3ba/0x9d0 fs/file_table.c:333
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3c1a63bd2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffd7174ab10 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f3c1a63bd2b
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f3c1a79d960 R08: 0000000000000000 R09: 00007ffd71751080
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000142ec
R13: 00007ffd7174ac10 R14: 00007ffd7174ac30 R15: 0000000000000032
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=124eef66f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123ae715f00000

