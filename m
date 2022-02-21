Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E991F4BD4A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343728AbiBUESc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:18:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiBUESb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:18:31 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F5B02
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:18:08 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id m17-20020a923f11000000b002c10e8f4c44so7387823ila.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IHT/U9u+x6V9dKYrCwR3IrnVQ9f5VJ80bCFYXvfAQZg=;
        b=QpDGlU2BGqheL7SGpAoQybIsOXS4QwrI2jL/2g2OO8p5P5HLl5wPQJ4lHDypLnIDS2
         Mqtiheo/ka5aS7IY2+oUIv/OT7LPjRcvGf3yoLth0gRMi2e2rfO00AeCXt8p8XbRNvUa
         maUsunREWWoet8nTRqa1nP6TgZHrtQpdmYQZplnil9PXi6ry0PqjkDOOHaefRIhwkxxx
         oLC0i/teCHHQhMW7K+pAuntKsDD/spuXxSaLCpyfcw3zxUzOjSaHiYb0pn8+YJI1dFim
         vq7G4NbFXotHHjFNguFjVx9gdBjEQFh4n7JfE4FxupZFbQyZmnu7NDkIz8HkMVyCL7mO
         zoMg==
X-Gm-Message-State: AOAM531gEPkEBlfsApncBjVA4p+EHWl7i+QZx5QGB5zkSl2pvaS6aUBH
        Q+9W6geLA/xDavjLQKyDjJRQ8y3M43Ln7ey/WzCyr5y6FfLH
X-Google-Smtp-Source: ABdhPJy++bYypQ+Ze3dqyfyCvspYIJuHBEyZhA2P2qk1x/Vu5H1k3OAuZsGScZJIfDgrMu1gQbIf2/a6EZGkOthcEuFTHulFATqT
MIME-Version: 1.0
X-Received: by 2002:a92:d242:0:b0:2b9:a33b:9068 with SMTP id
 v2-20020a92d242000000b002b9a33b9068mr15115043ilg.144.1645417088021; Sun, 20
 Feb 2022 20:18:08 -0800 (PST)
Date:   Sun, 20 Feb 2022 20:18:08 -0800
In-Reply-To: <20220221040745.1177-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009fc5b05d87f85d7@google.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
From:   syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
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
WARNING in vhost_dev_cleanup

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4069 at drivers/vhost/vhost.c:715 vhost_dev_cleanup+0x8b8/0xbc0 drivers/vhost/vhost.c:715
Modules linked in:
CPU: 0 PID: 4069 Comm: syz-executor422 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vhost_dev_cleanup+0x8b8/0xbc0 drivers/vhost/vhost.c:715
Code: c7 85 90 01 00 00 00 00 00 00 e8 a3 6d a2 fa 48 89 ef 48 83 c4 20 5b 5d 41 5c 41 5d 41 5e 41 5f e9 7d d6 ff ff e8 88 6d a2 fa <0f> 0b e9 46 ff ff ff 48 8b 7c 24 10 e8 d7 ff e9 fa e9 75 f7 ff ff
RSP: 0018:ffffc9000280fca8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff88801cadd700 RSI: ffffffff86d67098 RDI: ffff88807b1d00b0
RBP: ffff88807b1d0000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817f1e08 R11: 0000000000000000 R12: ffff88807b1d00d0
R13: ffff88807b1d0120 R14: ffff88807b1d00d0 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561d17c43600 CR3: 0000000073741000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vhost_vsock_dev_release+0x3a4/0x4f0 drivers/vhost/vsock.c:778
 __fput+0x286/0x9f0 fs/file_table.c:313
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xb29/0x2a30 kernel/exit.c:806
 do_group_exit+0xd2/0x2f0 kernel/exit.c:935
 __do_sys_exit_group kernel/exit.c:946 [inline]
 __se_sys_exit_group kernel/exit.c:944 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f43a65e8ba9
Code: Unable to access opcode bytes at RIP 0x7f43a65e8b7f.
RSP: 002b:00007ffdf78cba98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f43a665d330 RCX: 00007f43a65e8ba9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 00007ffdf78cbc88
R10: 00007ffdf78cbc88 R11: 0000000000000246 R12: 00007f43a665d330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=16da8df2700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1682e422700000

