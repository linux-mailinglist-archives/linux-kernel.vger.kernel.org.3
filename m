Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AC3526F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiENHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiENHmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 03:42:10 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFBC10E
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 00:42:09 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l8-20020a056e021aa800b002cf778c63caso6138355ilv.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 00:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=66SfWWT/Kgd0cwKkjXIliDpxWdKNjgHrzpUgHW4YCvQ=;
        b=MSTyppmFW9t6TynnpzO5HkxK4ngMuHeLnkNqTLApnqcYx2JhCGVwu871VK+do06UU8
         krgY4uEBVxrEcVEGEBo2WPGEyJR4+MBYwsOuEewuMmbP+iZ8BfVPKfkhZrR1nNtCWScb
         8R5dmtNQZLpZap8JKGgkt07jhU5vw3jeb+PDIgba8LHpop5EtXKtHTMsicFQUJ7kDlo8
         qBoyfwG+fuDBh5n8gI0EWklzInuok2IiL//s8+W+Pu8C24PTBkTJW4cfT2XqHhsuk8pj
         /nZWH2l2m/SdycHdUBwpih7c0HgNMmuxQmH1nzWPANYnix4fNAAAsR5TCQvkIfWH7hGX
         lvJA==
X-Gm-Message-State: AOAM530chMCMKM3wijaRxnwm7HvJ7kBeY/xhHkmsTjWplwoGTxYgSjBy
        iotKuD2CYFPKrBNLqzZac966P+Q7dxX/EPnS6XhXtBqWp7lY
X-Google-Smtp-Source: ABdhPJxr65NmOs3PCbdc9b5xq1jkO6FmqFvlvWu55eyQMduqrjtv2d/AEKb4s3358KB/FdyPkL8Q6MfDlllo2okVxIloYLxIeM4j
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d8f:b0:32b:c2f6:a2a2 with SMTP id
 l15-20020a0566380d8f00b0032bc2f6a2a2mr4442548jaj.124.1652514129154; Sat, 14
 May 2022 00:42:09 -0700 (PDT)
Date:   Sat, 14 May 2022 00:42:09 -0700
In-Reply-To: <20220514073117.965-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a796d405def3edbd@google.com>
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
WARNING: CPU: 0 PID: 4055 at fs/namespace.c:1232 mntput_no_expire+0xb02/0xfe0 fs/namespace.c:1232
Modules linked in:
CPU: 0 PID: 4055 Comm: syz-executor.4 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0xb02/0xfe0 fs/namespace.c:1232
Code: 00 48 c7 c7 80 16 db 89 c6 05 c3 9d c8 0b 01 e8 19 2b 4d 07 e9 57 ff ff ff e8 2a 92 9d ff 0f 0b e9 df f9 ff ff e8 1e 92 9d ff <0f> 0b e9 d3 f9 ff ff e8 12 92 9d ff e8 9d 8c 88 ff 31 ff 89 c3 89
RSP: 0018:ffffc9000334fcf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807e7b1d80 RSI: ffffffff81dbaec2 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: ffffffff9006e94f
R10: ffffffff81dba87e R11: 0000000000000001 R12: ffffc9000334fd40
R13: ffff888077683b00 R14: 0000000000000002 R15: dffffc0000000000
FS:  0000555556613400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcf211088a5 CR3: 00000000740bc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 path_umount+0x7d4/0x1260 fs/namespace.c:1814
 ksys_umount fs/namespace.c:1833 [inline]
 __do_sys_umount fs/namespace.c:1838 [inline]
 __se_sys_umount fs/namespace.c:1836 [inline]
 __x64_sys_umount+0x159/0x180 fs/namespace.c:1836
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa5afe8a557
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc6ec4cb58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa5afe8a557
RDX: 00007ffc6ec4cc29 RSI: 000000000000000a RDI: 00007ffc6ec4cc20
RBP: 00007ffc6ec4cc20 R08: 00000000ffffffff R09: 00007ffc6ec4c9f0
R10: 00005555566148b3 R11: 0000000000000246 R12: 00007fa5afee21f8
R13: 00007ffc6ec4dce0 R14: 0000555556614810 R15: 00007ffc6ec4dd20
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=132990c6f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ff8456f00000

