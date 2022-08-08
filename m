Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E258C8F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiHHNFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243050AbiHHNFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:05:36 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76113BAE
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:05:35 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id n13-20020a056e02140d00b002dfa5464967so5123698ilo.19
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=n6ROnGRPeHKbMDkjBCI+NrZj8XSZt/pq4k4SlgJSBxA=;
        b=oBkHWZGuinfPGCcfM/i9XcyJaxuRcL2jONrA+02sJfD5uXYj/ESLM9DOdhH/T4/XPb
         V/ZCIZdIAd7xAszAJl2fC7edyYRNgTdAt1wuTALwDgMWFo7063s+VGtJ+FNbZC5/Ur/j
         c/t2suzvf1pTcaxFuenrolFddyrpYDcIiwR2cZa/1uiqCaPV99DxxrV3+Mm/xWbLW2mM
         Mk2f3wfyMMssbAG7izW7la3yzySENHwAaTNf+U8h/3RCMDMGqRK8F2wePiYom6nev9Zc
         CcueOoJyq5zBUVPjobPYFXwq2ceGTZs1LKdYk8HBn8AUkVgX79byyDBhvnWAuwMi4Sjg
         j5PA==
X-Gm-Message-State: ACgBeo1onVUR59I2VrBZdJVRhJIyTa10bxleo5McYVIiuOmpux151Lg8
        exuECbXqOis+87oAwjvw1NVv8c8fCQFW4Ek+QSSgi1NSi9cB
X-Google-Smtp-Source: AA6agR5woTsLLFreeMQmbnK4S0UNyNON4F4diygZs6lq/PrvL8V8SMhBoJr194h34ZCxT1n5sYnsoA5SGioiaEurNxK3ynQ1ebxr
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168d:b0:67c:44c3:9ba5 with SMTP id
 s13-20020a056602168d00b0067c44c39ba5mr7502643iow.190.1659963934890; Mon, 08
 Aug 2022 06:05:34 -0700 (PDT)
Date:   Mon, 08 Aug 2022 06:05:34 -0700
In-Reply-To: <000000000000b7352e05e5b61f84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ade42905e5ba78e0@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in gsmld_receive_buf
From:   syzbot <syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14a27066080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=e3563f0c94e188366dbb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164eb3ca080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17327ce1080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 74c90067 P4D 74c90067 PUD 74c53067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3606 Comm: syz-executor237 Not tainted 5.19.0-next-20220808-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000387fcf0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff88801bbdf000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801bbdf000
RBP: ffffc9000387fda1 R08: 0000000000000001 R09: 0000000000000004
R10: 0000000000000000 R11: 1ffffffff1ffa9ce R12: 0000000000000001
R13: 0000000000000000 R14: ffffc9000387fd90 R15: dffffc0000000000
FS:  0000555556e8d300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000001c7e0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gsmld_receive_buf+0x1c2/0x2f0 drivers/tty/n_gsm.c:2861
 tiocsti drivers/tty/tty_io.c:2293 [inline]
 tty_ioctl+0xa75/0x15d0 drivers/tty/tty_io.c:2692
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f76c0e5eb59
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe9a4f7c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f76c0e5eb59
RDX: 0000000020000040 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 00007f76c0e22d00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f76c0e22d90
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000387fcf0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff88801bbdf000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801bbdf000
RBP: ffffc9000387fda1 R08: 0000000000000001 R09: 0000000000000004
R10: 0000000000000000 R11: 1ffffffff1ffa9ce R12: 0000000000000001
R13: 0000000000000000 R14: ffffc9000387fd90 R15: dffffc0000000000
FS:  0000555556e8d300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000001c7e0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

