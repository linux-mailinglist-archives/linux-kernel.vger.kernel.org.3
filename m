Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2914B56A341
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiGGNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbiGGNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:16:10 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EBC2A961
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:16:08 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id h18-20020a5d9712000000b00674f83a60f0so9776685iol.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oi6ePpdG99rdNTr7vl16aHsOKZPJL7r4QXfiCaOqR+g=;
        b=Cmul8wG8sCalmF9dr7UOzhoczbs9m79VX+G1EYGkJaiFuJW3i3mfmP2b/lzS51Bias
         Qh8PE6OY7JHxoWZwnTYHVYqcMlZzc82pJtWG2dKUvpSJNB58Xypdmd5puvOdI/Vbx50U
         8DBXwfHn/X/GyCQvY96SKUO2D9pKoTVq2ahodI/Zvt+m/UzDaF9ygpYRimR02nE+VkIU
         9Abggn4Q37wQcum4h7X1/Up9OUWFBGDwFHRpv6rPDatESEppx/ZtPEkxgnD6eQly6BbD
         ZmqNuO2a6DJstVIQhOBX16yMujUoPIb3IzVgQv0wHmrEuJpYLhoQ0FwLSxpxkZL8SrgU
         O1Sg==
X-Gm-Message-State: AJIora9PTmW5UzlLp17XmUf0NWWzkwXheT07nzKStYeJENo6aKXtODqk
        RZehpKk5F7WUWSYJ178uLnoy8E98k2Q3YskkKgBBND/KGghK
X-Google-Smtp-Source: AGRyM1vDlcupM1djjRO57nR48Smu/lljdaSJjqPpE6AE84U19vxcmJ0ShZQhsnEsY7Nm7tG6mnuoQ+JUkFSQYCh6FLwyUYculHB7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1565:b0:2dc:18dc:4064 with SMTP id
 k5-20020a056e02156500b002dc18dc4064mr11199643ilu.46.1657199767984; Thu, 07
 Jul 2022 06:16:07 -0700 (PDT)
Date:   Thu, 07 Jul 2022 06:16:07 -0700
In-Reply-To: <20220707105829.2104-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e224905e336e387@google.com>
Subject: Re: [syzbot] WARNING in notifier_chain_register
From:   syzbot <syzbot+5214f8dac5863061e37c@syzkaller.appspotmail.com>
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
WARNING in notifier_chain_register

------------[ cut here ]------------
notifier callback hci_suspend_notifier already registered
WARNING: CPU: 1 PID: 4179 at kernel/notifier.c:28 notifier_chain_register kernel/notifier.c:28 [inline]
WARNING: CPU: 1 PID: 4179 at kernel/notifier.c:28 notifier_chain_register+0x156/0x210 kernel/notifier.c:22
Modules linked in:
CPU: 1 PID: 4179 Comm: syz-executor.3 Not tainted 5.19.0-rc4-next-20220628-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:notifier_chain_register kernel/notifier.c:28 [inline]
RIP: 0010:notifier_chain_register+0x156/0x210 kernel/notifier.c:22
Code: 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 a5 00 00 00 49 8b 75 00 48 c7 c7 c0 d0 cb 89 e8 14 f5 e3 07 <0f> 0b 41 bc ef ff ff ff e8 5d 6f 2a 00 44 89 e0 48 83 c4 18 5b 5d
RSP: 0018:ffffc9000373fd58 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88801e825180 RCX: 0000000000000000
RDX: ffff8880735ad7c0 RSI: ffffffff81610608 RDI: fffff520006e7f9d
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88801e825180 R14: ffffffff8caa8ce8 R15: dffffc0000000000
FS:  0000555556946400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556109708 CR3: 0000000076371000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __blocking_notifier_chain_register kernel/notifier.c:266 [inline]
 blocking_notifier_chain_register+0x6f/0xc0 kernel/notifier.c:284
 hci_register_suspend_notifier net/bluetooth/hci_core.c:2752 [inline]
 hci_register_suspend_notifier+0x9d/0xc0 net/bluetooth/hci_core.c:2746
 hci_sock_release+0x4a2/0x520 net/bluetooth/hci_sock.c:890
 __sock_release+0xcd/0x280 net/socket.c:650
 sock_close+0x18/0x20 net/socket.c:1365
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f988dc3bd4b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffcc6777580 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f988dc3bd4b
RDX: 00007f988dda02e8 RSI: ffffffffffffffff RDI: 0000000000000004
RBP: 00007f988dd9d960 R08: 0000000000000000 R09: 00007f988dda02f0
R10: 00007ffcc6777680 R11: 0000000000000293 R12: 00000000000147b9
R13: 00007ffcc6777680 R14: 00007f988dd9bf60 R15: 0000000000000032
 </TASK>


Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15640350080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=5214f8dac5863061e37c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1059e134080000

