Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9B253ECE7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiFFRTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiFFRSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:18:44 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10BE49F1E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:17:34 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i18-20020a926d12000000b002d1b13b896cso12046254ilc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 10:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mZfUGMs7eL3mD41zDkppqh4PJO52IPs0PIfKTV0a1/8=;
        b=dbd4Wzvnkk2C4pZ231SpN2P8BTu65NqR4G7B9lEoAVnCEvGVeczrtE00vxjX85uL0q
         zGZUOCkXACGBunX6mIlfAAHz6yqb/Iu5CgltjqcatHSDXDJMKxtIriIO3jQWjzSmWmlq
         uT1LmJtqPX4Xs7xroLU6R/9sgW6T5m+QDRscAv7DvYXmswDKRCTIyRpRgZ9aLdgTPRyA
         COilXIP6HaOEDInAojyAsbzl+iPpTBKUuMpT9CJJTFhATXqP7MBPdfdk1r01dfg7/7eI
         wQIchTNSDu8cX55c29XbMYz04kJBTL+OKvYEMrRAeYGjLDd/UxzVEpswhfU/q9wO7WgE
         ecbQ==
X-Gm-Message-State: AOAM531DsCfgng1xzj60/+y9zjTmkzJSTjeDYJLIDuEFbdGogug65qlw
        9DDiymdnnR3qyLN/MsOaDlw5X/A7O0PgC5T6lEenGtNaD9JH
X-Google-Smtp-Source: ABdhPJwE48Kd0NUkzrSjTTsK8LA2mYKPlez1cDcJzAFvNPewZxhpx7mwI7SQ73JuIaLBaz5H6CvHP/9flL2wu/D6VZXacNRu/Sdt
MIME-Version: 1.0
X-Received: by 2002:a02:6d61:0:b0:32b:fb61:9d88 with SMTP id
 e33-20020a026d61000000b0032bfb619d88mr13200879jaf.184.1654535854176; Mon, 06
 Jun 2022 10:17:34 -0700 (PDT)
Date:   Mon, 06 Jun 2022 10:17:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db448c05e0caa5ba@google.com>
Subject: [syzbot] WARNING in register_shrinker_prepared
From:   syzbot <syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    1cfd968b58a1 Add linux-next specific files for 20220603
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f7b6b3f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7da8386e3742814f
dashboard link: https://syzkaller.appspot.com/bug?extid=300d27c79fe6d4cbcc39
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103e5177f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13545057f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 20
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3694 at mm/vmscan.c:681 register_shrinker_prepared+0x119/0x150 mm/vmscan.c:681
Modules linked in:
CPU: 0 PID: 3694 Comm: syz-executor250 Not tainted 5.18.0-next-20220603-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:register_shrinker_prepared+0x119/0x150 mm/vmscan.c:681
Code: ff 89 c5 89 c6 e8 87 18 d1 ff 85 ed 75 17 e8 2e 1c d1 ff 5b 48 c7 c7 60 dd e7 8b 5d 41 5c 41 5d e9 6c d2 b3 ff e8 17 1c d1 ff <0f> 0b eb e0 e8 5e f7 1d 00 eb be 4c 89 e7 e8 e4 f7 1d 00 eb 81 e8
RSP: 0018:ffffc900030c7c80 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880238eba80 RSI: ffffffff81a965c9 RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000001 R12: ffff88807ebca7a0
R13: ffff8880770347a0 R14: ffffffff8c50df80 R15: ffff888011c82c00
FS:  000055555733f300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007effd0fd11d0 CR3: 00000000203c8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sget+0x472/0x580 fs/super.c:631
 mount_bdev+0xf8/0x450 fs/super.c:1342
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1501
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7effd0ff93fa
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce9034038 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffce9034090 RCX: 00007effd0ff93fa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffce9034050
RBP: 00007ffce9034050 R08: 00007ffce9034090 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000218
R13: 0000000000000004 R14: 0000000000000005 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
