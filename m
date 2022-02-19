Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D9E4BC85C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 13:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242224AbiBSMA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 07:00:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242211AbiBSMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 07:00:26 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E95DE5F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 04:00:08 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso6333791iov.16
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 04:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=L/vDtC736fZ13z2ml2gWQI7yv+OuKqvCVkJ7nsafods=;
        b=XrA/1Eh0kTO3AG/bkzVme8T7AmdGDKs3G/k0vwXG383BDD3Yp/BIj+Qx21pAx85zBa
         9zC4DT/5qkdpS6OrXpjyJebaAC9kuzadLvuU1Xg5oAeZrjtcPfFBXfBdym1tqJPTWjFQ
         xqv3k+9M41rTIqEBkQC4Cou2u339xLvcEYviBUvCIEyXc/YGjiC1srSAo4FMC1qq91gn
         MMOphXb2bC8yvd9eypp1FARKuhWoPGtI5EwK9tjlM3c3hIRusrVbVKef1MMH/9X7ymCQ
         sfPCqEGJvkcKRYpgl14aT5mrZmHn23fSku8+N/MA4DL5GlXal5cG1hCrKnpn+zLJCECs
         l10A==
X-Gm-Message-State: AOAM531Mdnr5YkMoLGBRpDh2lRrDAywekK+joxkBFybO++0CNHMEOiCp
        Vxbd71ytithgCVfPaNILgo1VU2Lto9RNH72DmRIj6NRyA6NO
X-Google-Smtp-Source: ABdhPJwlLkRhTW6+scXC9+4YtbH8M8g53savRJBdac5PoBmFu0JXRYf/EtGiWA7ynHJxsR7GZRq/1VaDLlHTrFpH2mgN1GtMm38E
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:2b6:ae9d:67bf with SMTP id
 i2-20020a056e021b0200b002b6ae9d67bfmr8694459ilv.19.1645272007587; Sat, 19 Feb
 2022 04:00:07 -0800 (PST)
Date:   Sat, 19 Feb 2022 04:00:07 -0800
In-Reply-To: <20220219114936.747-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000923d1c05d85dbd3d@google.com>
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
WARNING: CPU: 1 PID: 4052 at drivers/vhost/vhost.c:715 vhost_dev_cleanup+0x8b8/0xbc0 drivers/vhost/vhost.c:715
Modules linked in:
CPU: 1 PID: 4052 Comm: syz-executor213 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vhost_dev_cleanup+0x8b8/0xbc0 drivers/vhost/vhost.c:715
Code: c7 85 90 01 00 00 00 00 00 00 e8 83 6e a2 fa 48 89 ef 48 83 c4 20 5b 5d 41 5c 41 5d 41 5e 41 5f e9 7d d6 ff ff e8 68 6e a2 fa <0f> 0b e9 46 ff ff ff 48 8b 7c 24 10 e8 b7 00 ea fa e9 75 f7 ff ff
RSP: 0018:ffffc90001d2fca8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff8880229e8000 RSI: ffffffff86d66fb8 RDI: ffff8880794300b0
RBP: ffff888079430000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817f1e08 R11: 0000000000000000 R12: ffff8880794300d0
R13: ffff888079430120 R14: ffff8880794300d0 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 0000000019a2f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vhost_vsock_dev_release+0x36e/0x4b0 drivers/vhost/vsock.c:771
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
RIP: 0033:0x7f2b623eaba9
Code: Unable to access opcode bytes at RIP 0x7f2b623eab7f.
RSP: 002b:00007ffd86806ac8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f2b6245f330 RCX: 00007f2b623eaba9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 00007ffd86806cb8
R10: 00007ffd86806cb8 R11: 0000000000000246 R12: 00007f2b6245f330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=11ece422700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f7f94c700000

