Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B4E526246
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380394AbiEMMs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359455AbiEMMsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:48:20 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F5338199
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:48:17 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d9-20020a056e02214900b002d0f136e101so1953755ilv.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2equbNaPfgasvfYEN7NhsqVtNOekW648pZCBoPVHPgg=;
        b=mCnq6TJAdi/gpC1aBckPy/yTLXafFH7JBzQkXr2ICYPuB8mNcUqNV1XYLkNlvD2A/w
         TxAKDWc03jD9i4fvxsFf2EL5rWD8WgUFgmFateiMDzktuaKSju3oXRVWJqtXEKXS4/0E
         Lrnm0U+aTwMyRVLA45Z1VJJIyybwwessh1hU1CqhRKlQgEfh7GVjjv6215bVUpYi7Yl7
         s5wUX0B8OGgmfq4g+5cbgKfub/d/H+Ocly6rLADnqS5MouESKfB+JtzqzguWAYuMC8Jh
         GulL2uK9DbhhC3YVfAp2JYmj5JKxxUqZKizhJT93JyE769v0zCwfjFMoYkJs+Ux51bqR
         zo8Q==
X-Gm-Message-State: AOAM531eBtEO0/LL1KIeasYAQPVxVOhut7Aolofaxq79Q4MxPJQb6zNe
        bFwzLQCLwo5hu9uw9kZ31DUCWIQUpjBeNcj5407eWvPx7KWQ
X-Google-Smtp-Source: ABdhPJy5pUkBHu82xOpHLcU2+fnLHD9Gzv17QMQfmR5ISLGFV3OgJAYFcRsOLump0yDQim1QuotsfMYPidBvazHgqJxSRL4upiQz
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1481:b0:32b:d931:1b57 with SMTP id
 j1-20020a056638148100b0032bd9311b57mr2600086jak.180.1652446097206; Fri, 13
 May 2022 05:48:17 -0700 (PDT)
Date:   Fri, 13 May 2022 05:48:17 -0700
In-Reply-To: <20220513123641.6379-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a270ff05dee416ef@google.com>
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
WARNING: CPU: 1 PID: 4387 at fs/namespace.c:1228 mntput_no_expire+0x985/0xfe0 fs/namespace.c:1228
Modules linked in:
CPU: 1 PID: 4387 Comm: syz-executor.4 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0x985/0xfe0 fs/namespace.c:1228
Code: 00 00 00 bf 08 00 00 00 48 c7 c2 e0 fd f0 8b e8 b1 0e 72 ff e9 01 f9 ff ff e8 a7 c0 9d ff 0f 0b e9 b6 f8 ff ff e8 9b c0 9d ff <0f> 0b e9 aa f8 ff ff e8 8f c0 9d ff e8 ca d0 91 07 31 ff 89 c3 89
RSP: 0018:ffffc90003fb7d78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: ffff88806bd9d880 RSI: ffffffff81db8045 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81db78ee R11: 0000000000000000 R12: 0000000000000002
R13: ffff88801f142600 R14: dffffc0000000000 R15: ffffed1003e284ca
FS:  00005555562ef400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f71d6e99ff8 CR3: 000000006b3ca000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mntput+0x67/0x90 fs/namespace.c:1290
 __fput+0x3ba/0x9d0 fs/file_table.c:333
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f043643bd2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffecc2e9cc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f043643bd2b
RDX: 0000001b31320000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f043659d960 R08: 0000000000000000 R09: 00007ffecc37f080
R10: 00007ffecc37f090 R11: 0000000000000293 R12: 0000000000016ea4
R13: 00007ffecc2e9dc0 R14: 00007ffecc2e9de0 R15: 0000000000000032
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=103e78aef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14aafa9ef00000

