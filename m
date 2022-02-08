Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE6C4AD378
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349712AbiBHIb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349663AbiBHIbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:31:24 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ACBC0401F6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:31:22 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id n13-20020a056602340d00b006361f2312deso10892684ioz.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FLyZSs3ebVVisW8BXRm0I+PVP9xcVAwmbkFnRlIj1nU=;
        b=EIKeNiAx/8r/5elD7d8K3e4tx4WPbaOQUQ+XcdmNZiSqK0RiQJ0liZc1tlncwnDWuM
         GRWQsY/8l0DiwnhhCRtrtIoFnD+jSQLzKMxH7nSSRMgm2/9fVIe+UaEu6Zi4gt/b9rLq
         C7wyuo8GZKOuHEo/sKQTXl0nd4CaPEaxeI5aghVDAr65p7gaF0P9ZM3BAGkbyp+YivDP
         TbrQu8bNWos2qvn1EEQyVHsW4XSbRXiKLPr7DwQrc7hstGZfdWwAwBsbVPQdCXZPg6CH
         7F8jfQXm++6xYVh/2B2nOfoDSKkNkRzxfBaUq73BFEhw4VBXuZhE/elAvCaNODDW8RMn
         BJzA==
X-Gm-Message-State: AOAM530EMnWqNOdfm6BpsJNPQTzbPFHEp0+8zoHElKJph/bJnqYfSx0t
        tHaYe70TgJs0uB0Vxn2Yk90mgzyn+ylAt8uJixvTppz0/N/N
X-Google-Smtp-Source: ABdhPJxHmkkqXuhPRzuy23I8bk48WbkFeCurfAw6YtA7sSRp/CsrBKf711a+2mwoKfp4HnMcccbl6Q5Yf6KNVko2w3ycu9SD7lJj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a87:: with SMTP id k7mr1623976ilv.259.1644309081847;
 Tue, 08 Feb 2022 00:31:21 -0800 (PST)
Date:   Tue, 08 Feb 2022 00:31:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b97df105d77d8a9b@google.com>
Subject: [syzbot] WARNING in fpregs_assert_state_consistent
From:   syzbot <syzbot+3c0a98026cec79f550a2@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
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

HEAD commit:    ef6b35306dd8 Add linux-next specific files for 20220204
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14d34d0c700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0431e0b00810b4f
dashboard link: https://syzkaller.appspot.com/bug?extid=3c0a98026cec79f550a2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c0a98026cec79f550a2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3586 at arch/x86/kernel/fpu/core.c:768 fpregs_assert_state_consistent arch/x86/kernel/fpu/core.c:768 [inline]
WARNING: CPU: 0 PID: 3586 at arch/x86/kernel/fpu/core.c:768 fpregs_assert_state_consistent+0x80/0xe0 arch/x86/kernel/fpu/core.c:761
Modules linked in:
CPU: 0 PID: 3586 Comm: syz-fuzzer Not tainted 5.17.0-rc2-next-20220204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fpregs_assert_state_consistent arch/x86/kernel/fpu/core.c:768 [inline]
RIP: 0010:fpregs_assert_state_consistent+0x80/0xe0 arch/x86/kernel/fpu/core.c:761
Code: e9 55 ca 4c 00 e8 50 ca 4c 00 e8 db 97 2b 08 89 c3 65 48 8b 05 e9 90 d6 7e 4c 8d a5 80 18 00 00 49 39 c4 74 10 e8 30 ca 4c 00 <0f> 0b 5b 5d 41 5c e9 25 ca 4c 00 e8 20 ca 4c 00 4c 89 e2 48 b8 00
RSP: 0018:ffffc90001acfef0 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807f2e9d40 RSI: ffffffff812bdec0 RDI: 0000000000000000
RBP: ffff88807f2e9d40 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff812bde8e R11: 0000000000000000 R12: ffff88807f2eb5c0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000000c000030490(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6371976520 CR3: 000000007f14b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_exit_to_user_mode_prepare arch/x86/include/asm/entry-common.h:56 [inline]
 exit_to_user_mode_prepare+0x57/0x290 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x5edb02
Code: cc cc cc cc cc cc cc cc 49 3b 66 10 0f 86 fd 01 00 00 48 83 ec 48 48 89 6c 24 40 48 8d 6c 24 40 48 89 44 24 50 48 89 5c 24 58 <48> 8b 13 48 8b 70 20 8b 78 18 eb 06 48 89 fa 44 89 c7 48 89 54 24
RSP: 002b:000000c000241b28 EFLAGS: 00000216
RAX: 000000c0006c4000 RBX: 000000c0006c4028 RCX: 00000000000032c6
RDX: 0000000000008000 RSI: 000000c0006c4000 RDI: 0000000000000009
RBP: 000000c000241b68 R08: 00000000000032c5 R09: 000000c0006ca000
R10: 0000000000004d3b R11: 0000000000003250 R12: 0000000000002000
R13: 0000000000002dab R14: 000000c00029aea0 R15: 0000000000000002
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
