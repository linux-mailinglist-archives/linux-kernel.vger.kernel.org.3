Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1A58F703
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiHKEjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiHKEjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:39:10 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8BC4A82A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:39:08 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id j8-20020a6b7948000000b0067c2923d1b8so9032738iop.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=PJ6eD7IGIv0bVGmHdInkGzEGqwSJCBaB6NsgompZ0bE=;
        b=uQ0tGF6AEIc45vPoaFGUYth+86Z/swxnbmm9wPTol6HjFl5CLzUEOOKz2Z7jDq9C59
         WMd1optXMCUzSOo+w91mBcmMR4euEUIpUqIr498NFekzOSy7GJpvNKi2KCsWV2BdGpSr
         1ay+HgvKIzCGMeMhgLCjCiDcKDPQyj1x17orkrlOfKBrNvd7T/UWJgplYpb4mZzddlAS
         WrJmc90KGWlnlbVCdPYV/F7iVbGyknyCya4Pb+i2CgGX7TXc4PuEaEtnjxQvrRyKWrge
         NA+hdT/teHFR5aUmZMzoTzSxteQLJyyXVyHitVKMfsqg1A2dn/11kiwQLqCkrEueEXNr
         XAAQ==
X-Gm-Message-State: ACgBeo30sEFG2lOAmUO32OcM+5qdVlN9IuV9VfmKuiXwJQzwUapQJ56X
        PbfqZ7RCFO4Rg5fOQN5mtrrMr+wID7+LP8zGuUASdWsJgtPd
X-Google-Smtp-Source: AA6agR6ZLwECHmuKPAhaXhA6JKxqHwFTimcRugIBv1VJqekVpIqKmilxwrSQ2OE65Uc4f2VJSW951l6N73KmOM8wDaY79nXy3cGg
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4916:b0:342:786d:6093 with SMTP id
 cx22-20020a056638491600b00342786d6093mr14841015jab.105.1660192747527; Wed, 10
 Aug 2022 21:39:07 -0700 (PDT)
Date:   Wed, 10 Aug 2022 21:39:07 -0700
In-Reply-To: <20220810223415.2743-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9a4a505e5efbe81@google.com>
Subject: Re: [syzbot] INFO: task hung in __generic_file_fsync (3)
From:   syzbot <syzbot+ed920a72fd23eb735158@syzkaller.appspotmail.com>
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
WARNING in inode_dio_wait

------------[ cut here ]------------
__inode_dio_wait schedule_timeout(30 * HZ) timeout
WARNING: CPU: 0 PID: 4182 at fs/inode.c:2381 __inode_dio_wait fs/inode.c:2381 [inline]
WARNING: CPU: 0 PID: 4182 at fs/inode.c:2381 inode_dio_wait+0x28c/0x2e0 fs/inode.c:2400
Modules linked in:
CPU: 0 PID: 4182 Comm: syz-executor.1 Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__inode_dio_wait fs/inode.c:2381 [inline]
RIP: 0010:inode_dio_wait+0x28c/0x2e0 fs/inode.c:2400
Code: 9d ff 45 84 ed 0f 85 2b ff ff ff e8 7e de 9d ff 48 c7 c6 a0 bb db 89 48 c7 c7 a0 b3 db 89 c6 05 8c 38 ca 0b 01 e8 85 f3 55 07 <0f> 0b e9 05 ff ff ff e8 58 de 9d ff 4c 89 fe 4c 89 f7 e8 1d 57 7e
RSP: 0018:ffffc9000394fc30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88806c341430 RCX: 0000000000000000
RDX: ffff888024d35880 RSI: ffffffff81611718 RDI: fffff52000729f78
RBP: ffff88806c34163c R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000007
R13: 0000000000000000 R14: ffffffff8ba0acc0 R15: ffffc9000394fc78
FS:  00007f5e4b930700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c3b3bffda0 CR3: 00000000716e3000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 fat_setattr+0x3de/0x13c0 fs/fat/file.c:509
 notify_change+0xcd0/0x1440 fs/attr.c:418
 do_truncate+0x13c/0x200 fs/open.c:65
 do_sys_ftruncate+0x536/0x730 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5e4a889209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5e4b930168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f5e4a99bf60 RCX: 00007f5e4a889209
RDX: 0000000000000000 RSI: 00000000010099b8 RDI: 0000000000000004
RBP: 00007f5e4a8e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcd40a747f R14: 00007f5e4b930300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         200e340f Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=118a0697080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=176c15dd080000

