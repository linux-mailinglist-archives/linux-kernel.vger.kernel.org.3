Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48964BD5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbiBUFve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:51:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344759AbiBUFvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:51:32 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEFC50E35
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:51:10 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id i17-20020a925411000000b002bf4c9c4142so7550845ilb.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oFTZPPPDp+E3KmXwYZ2ShLtu8kgqqthciGAXO68iAuM=;
        b=b//RxxOFXe0GWiKRTRoDIKN8EUVgtaWshdEeMxCsCyF7DOHmHPgn9n+x1oHsItwF6e
         Je4g+PQ/3lBhwdt7/N8HIrTSvex3myp9O7H6C1ZXAh19jNzBphbr/PGhRHxS1s6/JIRO
         M8oY0pC2KSlu28B4uRXppe1zzekX6rCpxXZWCxaYYQSANQ3BsBJyYHlHWGFfIJIQINXI
         mMoQVQsMclmXmcnosv3677KF4oGcXN0ZkkNWLwIgoZzlqPn+rzbbf9sJyDLTCGwKpaI2
         RTvsuxZmAI2lzw0VhUFLG4kB5LA3kCtgpkNgzyk3du3yMLRd1gySj0zs24/OKXiYfhvP
         I4cg==
X-Gm-Message-State: AOAM531vYM6hvPtkjJBzDp9/tO2XHWROHiAK061/TE8FeXP9A5yO+k5I
        VrQR8XTF3w6qM0A2vhp+7FtJKkWFlE7eEjOo+G3ThlEIcN1z
X-Google-Smtp-Source: ABdhPJwxOqvNErZWhVFiW1dQnBDMWQ4SwUsUH1+TO4/VrO2Kz0v+wyqHKEJh9C+0t/ITjplEVVXNqArynxyYREx8yDFcx9xgD2nj
MIME-Version: 1.0
X-Received: by 2002:a6b:e707:0:b0:640:7c3f:e93d with SMTP id
 b7-20020a6be707000000b006407c3fe93dmr10338368ioh.114.1645422669660; Sun, 20
 Feb 2022 21:51:09 -0800 (PST)
Date:   Sun, 20 Feb 2022 21:51:09 -0800
In-Reply-To: <20220221054115.1270-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb058005d880d185@google.com>
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
WARNING: CPU: 0 PID: 4098 at drivers/vhost/vhost.c:717 vhost_dev_cleanup+0x8f8/0xc20 drivers/vhost/vhost.c:717
Modules linked in:
CPU: 1 PID: 4098 Comm: syz-executor375 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vhost_dev_cleanup+0x8f8/0xc20 drivers/vhost/vhost.c:717
Code: c7 85 90 01 00 00 00 00 00 00 e8 43 4b a2 fa 48 89 ef 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f e9 1d b4 ff ff e8 28 4b a2 fa <0f> 0b e9 49 ff ff ff 48 8b 7c 24 10 e8 77 dd e9 fa e9 93 f7 ff ff
RSP: 0018:ffffc9000296fca0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff88807b86d700 RSI: ffffffff86d692f8 RDI: ffff888077fd00b0
RBP: ffff888077fd0000 R08: 0000000000000000 R09: ffff888077fd00d3
R10: ffffed100effa01a R11: 0000000000000001 R12: ffff888077fd00d0
R13: ffff888077fd0120 R14: ffff888077fd00d0 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f118cbe2130 CR3: 0000000020703000 CR4: 00000000003506e0
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
RIP: 0033:0x7f118cb6fba9
Code: Unable to access opcode bytes at RIP 0x7f118cb6fb7f.
RSP: 002b:00007ffcb8cb7868 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f118cbe4330 RCX: 00007f118cb6fba9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 00007ffcb8cb7a58
R10: 00007ffcb8cb7a58 R11: 0000000000000246 R12: 00007f118cbe4330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=14df1346700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108c4b4a700000

