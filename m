Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8A3527650
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 09:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiEOHwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiEOHwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:52:11 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474A69FE1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:52:10 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i24-20020a056e021d1800b002cf0541f514so6529681ila.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FcbQnzW6R0CWEeQuNssC83OfRjg2nLpDFZovyOqX6W4=;
        b=mm/CG2WPsIm4yXGJim1BmwN3mZLw+VihTFQS6Ugyc14yiqxjdIor9+aGnJDkA3Wxo1
         gQbaeOCtiHhUB8AHOgK9wtdd1pwpBiJTaRfuRatlyAJR5T7vEQ7bHbbBmx9ivvTa+3iE
         p44BcJJC963CIC5x4Vs9OxMVnLISG8iIwwQW16e3w2TuPATVFGOi1ZGO5aUXvJg7WmRi
         OQIbQRK4GtMtZ+ujDR2qM4T0ES7zFnzdnJ69bbK2a9iX1hYxdMApiyXPEbHArK1upBLl
         4eCUg3fWRox+JDj8dqk4ino5vlVSGe+m4ViTu7dVX6Pnnz8lT22yexztfJZglCvl4v09
         UyTQ==
X-Gm-Message-State: AOAM5313pKmd7oZxtB6dBFAYAYGKPyJhcODp3GICqDzPt8q/KBG2j6wy
        lpZWwFVHV8b2Fbc/KkO/3YNQyKItSbV9MccZJ9JSTb9JXVpV
X-Google-Smtp-Source: ABdhPJzUTEG/jIV1srDEEl5z9fZ4+m1QjXl909/6UzhTBqckRRYaDaursM+xi/E8G3gCAyz2fwtfjB2g3/9faRhxIGkHgT8d0BBU
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a27:b0:2cf:91e3:362f with SMTP id
 g7-20020a056e021a2700b002cf91e3362fmr6096236ile.124.1652601129690; Sun, 15
 May 2022 00:52:09 -0700 (PDT)
Date:   Sun, 15 May 2022 00:52:09 -0700
In-Reply-To: <20220515050556.1646-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a6f4c05df082f95@google.com>
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
WARNING in mnt_check_count

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4324 at fs/namespace.c:1307 mnt_check_count fs/namespace.c:1307 [inline]
WARNING: CPU: 0 PID: 4324 at fs/namespace.c:1307 mnt_check_count+0x14a/0x210 fs/namespace.c:1301
Modules linked in:
CPU: 1 PID: 4324 Comm: syz-executor.0 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mnt_check_count fs/namespace.c:1307 [inline]
RIP: 0010:mnt_check_count+0x14a/0x210 fs/namespace.c:1301
Code: ff 89 de bf 01 00 00 00 e8 c3 ed 9d ff 83 fb 01 7e 1a 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 8b eb 9d ff e8 86 eb 9d ff <0f> 0b e8 7f eb 9d ff 49 8d be c8 00 00 00 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc90003adfe60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801613bb00 RSI: ffffffff81db555a RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81db5528 R11: 0000000000000000 R12: 0000000000000002
R13: dffffc0000000000 R14: ffff88814013cda0 R15: ffffed10280279ba
FS:  000055555725a400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb39859d090 CR3: 000000001a0ad000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fput_many.part.0+0x3d/0x1a0 fs/file_table.c:375
 fput_many fs/file_table.c:396 [inline]
 fput+0x42/0x50 fs/file_table.c:395
 filp_close+0x124/0x160 fs/open.c:1329
 close_fd+0x6f/0xa0 fs/file.c:671
 __do_sys_close fs/open.c:1342 [inline]
 __se_sys_close fs/open.c:1340 [inline]
 __x64_sys_close+0x2f/0xa0 fs/open.c:1340
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4ef943bd2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffc2b1ebbc0 EFLAGS: 00000293
 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f4ef943bd2b
RDX: 0000001b31d20000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f4ef959d960 R08: 0000000000000000 R09: 00007ffc2b1fa080
R10: 00007ffc2b1fa090 R11: 0000000000000293 R12: 0000000000015538
R13: 00007ffc2b1ebcc0 R14: 00007ffc2b1ebce0 R15: 0000000000000032
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1488f396f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12375f31f00000

