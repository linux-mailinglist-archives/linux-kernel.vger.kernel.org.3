Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DD0526F1A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiENGiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 02:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiENGiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 02:38:13 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3442DB26
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 23:38:12 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id q12-20020a0566022f0c00b0065af7776ee7so6180432iow.17
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 23:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jYmum4HCvuL1c6O6BLUBowV3gEl8fh++LJx49We21AM=;
        b=n4LF8CZKBSXQJXbhWEkwQdyzkstvwDHitSikOTmdMENJmqbtASxl9nUN2YhuLDkvU/
         7ukiCj98evN7cHCAJQ80nz4Zb4s1422LsF+/AHPZw5C+sUhFBNGZ8/HCbXguE7JseC+g
         qvKB7m1to/DuVld44DdxsHF9Fp+QJAFDfTqAzJPvunLUZ7edDSaveKbTmTl5t/hIH2S0
         GjggeDReL5tAUeESHk7fvGTVZ8uqY5AKPK6RkYA/PsOUQrUmATTMe3FjPjQm8gGe5/TO
         wnrFdfMMrzF03h/T468s8qPTRRbwG3xLaIDZJ9oWFiAeuOE+bYOil4iCvtbVlxT/xmVx
         286g==
X-Gm-Message-State: AOAM533xNTHQPUp4xfwwx6qYABwqJtZ+qeFzzTR5sn5WCTggnqAjF2jR
        UN+w2osjaKYo20u0JVrqSrGLCfoNf0VV7j8efD6PvW7uWGlJ
X-Google-Smtp-Source: ABdhPJz+hNyBcYmlrsrr0jvtcrYbxywtFbUXM/9RZ3Dzx2Iy/slYBgZ0OClUJPYGKcX/gTgg1zerPKX4f4WDziMuum1u5w5T0+Ly
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4705:b0:32b:5e0b:b58f with SMTP id
 cs5-20020a056638470500b0032b5e0bb58fmr4603060jab.34.1652510288574; Fri, 13
 May 2022 23:38:08 -0700 (PDT)
Date:   Fri, 13 May 2022 23:38:08 -0700
In-Reply-To: <20220514062752.900-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bcfbd705def30863@google.com>
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
WARNING: CPU: 1 PID: 4281 at fs/namespace.c:1225 mntput_no_expire+0x979/0xfe0 fs/namespace.c:1225
Modules linked in:
CPU: 1 PID: 4281 Comm: syz-executor.3 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0x979/0xfe0 fs/namespace.c:1225
Code: 04 00 00 48 8b 35 0f a4 dd 0b b9 01 00 00 00 bf 08 00 00 00 48 c7 c2 60 fe f0 8b e8 41 0d 72 ff e9 01 f9 ff ff e8 37 bf 9d ff <0f> 0b e9 b6 f8 ff ff e8 2b bf 9d ff 0f 0b e9 aa f8 ff ff e8 1f bf
RSP: 0018:ffffc9000388fd78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888015df8000 RSI: ffffffff81db81a9 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81db7a48 R11: 0000000000000000 R12: 0000000000000002
R13: ffff888019de1380 R14: dffffc0000000000 R15: ffffed10033bc27a
FS:  00005555555f0400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555563e6848 CR3: 000000007f64c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mntput+0x67/0x90 fs/namespace.c:1288
 __fput+0x3ba/0x9d0 fs/file_table.c:333
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8b4ea3bd2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007fffd543b3b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f8b4ea3bd2b
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f8b4eb9d960 R08: 0000000000000000 R09: 00007fffd547d080
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000169e6
R13: 00007fffd543b4b0 R14: 00007fffd543b4d0 R15: 0000000000000032
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=11d1bd99f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c96d96f00000

