Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA0C4C8D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiCAN6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiCAN6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:58:11 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DF81AF27
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:57:28 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id q6-20020a056e0215c600b002c2c4091914so6798495ilu.14
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 05:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=COnmWy2PDlokv2F1f1FF/zq+rFMiwHy/7fWAZjLIy2g=;
        b=jVi4bRB1frSSC3bELZj1k3b3kBrRei/NNUyrxZb/fJmencoU+5apqZm5ZMk4jeuq0c
         rg4BEn7yNiE6VJD6YPyGaNnS/EtZyR23Y4N0XURszxr/pQzhP6wqlZKR1PbMiS6yhZfm
         tZtrvl6oH8P/ATCG1CKSvSppaVhRxi2FjiclU9ddddcNLqI0KiY9idTZISlm7DQb6B6z
         JKLydoqNpUlFqMPwy/ACqELocxbTDirQNBiTLBMgSgQNqkNW3cUOOD310JgeN082PMZl
         oAX6TWWBqpsRwXx/TSQ8gqW8d/OPZzPN1HkzGhE42TR3YgVKXtk6eXDjSAjV3uOqgq8o
         WQtw==
X-Gm-Message-State: AOAM533xlIRwkFa0IhfbhH4Z8JopK3JYMWQMM9v3yFNeY9BQe1G0WVYf
        a7XnX7zZSUmAdhZ5iBr6CWrjFCICfHeXG4EUQEHV+wHmVMpK
X-Google-Smtp-Source: ABdhPJzrxtqihhuYiMNQ66RtSpbdAMSQXwzQVXnsEW1a3OQ4TJi5G+vM5W956sgkrHXXD58hy+79XIbB4bJUJYbzqaaOwzBEd7c8
MIME-Version: 1.0
X-Received: by 2002:a5e:c64a:0:b0:640:7b5a:3446 with SMTP id
 s10-20020a5ec64a000000b006407b5a3446mr19135818ioo.82.1646143047916; Tue, 01
 Mar 2022 05:57:27 -0800 (PST)
Date:   Tue, 01 Mar 2022 05:57:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ee0ca05d9288b83@google.com>
Subject: [syzbot] kernel BUG in hugepage_add_anon_rmap
From:   syzbot <syzbot+d7ed29a6231d3747fb31@syzkaller.appspotmail.com>
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

HEAD commit:    196d330d7fb1 Add linux-next specific files for 20220222
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15b0618a700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45b71d0aea81d553
dashboard link: https://syzkaller.appspot.com/bug?extid=d7ed29a6231d3747fb31
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7ed29a6231d3747fb31@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/rmap.c:2330!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4289 Comm: syz-executor.0 Not tainted 5.17.0-rc5-next-20220222-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:hugepage_add_anon_rmap+0x1f5/0x240 mm/rmap.c:2330
Code: 89 ef e8 6e ad f8 ff 0f 0b e8 77 b2 c4 ff 48 83 eb 01 e9 a6 fe ff ff e8 69 b2 c4 ff 48 83 eb 01 e9 ff fe ff ff e8 5b b2 c4 ff <0f> 0b e8 54 b2 c4 ff 0f 0b e8 4d b2 c4 ff 49 8d 6c 24 ff eb b4 48
RSP: 0018:ffffc9000fa8f9b8 EFLAGS: 00010216
RAX: 0000000000002b78 RBX: 0000000000000000 RCX: ffffc90003bd1000
RDX: 0000000000040000 RSI: ffffffff81b47f75 RDI: 0000000000000003
RBP: ffffea0001008040 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81b47eab R11: 0000000000000000 R12: ffff88801e231210
R13: 0000000020400000 R14: ffff8880738f8700 R15: 0000000000000000
FS:  00007f1a19594700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f33cc0df300 CR3: 000000001ca70000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 remove_migration_pte+0x5fd/0xc50 mm/migrate.c:234
 rmap_walk_anon+0x44b/0x9e0 mm/rmap.c:2236
 rmap_walk+0x92/0xd0 mm/rmap.c:2302
 remove_migration_ptes mm/migrate.c:271 [inline]
 unmap_and_move_huge_page mm/migrate.c:1259 [inline]
 migrate_pages+0x1709/0x4030 mm/migrate.c:1379
 do_mbind mm/mempolicy.c:1334 [inline]
 kernel_mbind+0x4d7/0x7d0 mm/mempolicy.c:1481
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1a18489059
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1a19594168 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f1a1859c030 RCX: 00007f1a18489059
RDX: 0000000000000000 RSI: 0000000000800000 RDI: 0000000020001000
RBP: 00007f1a184e308d R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe5da8cc9f R14: 00007f1a19594300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hugepage_add_anon_rmap+0x1f5/0x240 mm/rmap.c:2330
Code: 89 ef e8 6e ad f8 ff 0f 0b e8 77 b2 c4 ff 48 83 eb 01 e9 a6 fe ff ff e8 69 b2 c4 ff 48 83 eb 01 e9 ff fe ff ff e8 5b b2 c4 ff <0f> 0b e8 54 b2 c4 ff 0f 0b e8 4d b2 c4 ff 49 8d 6c 24 ff eb b4 48
RSP: 0018:ffffc9000fa8f9b8 EFLAGS: 00010216
RAX: 0000000000002b78 RBX: 0000000000000000 RCX: ffffc90003bd1000
RDX: 0000000000040000 RSI: ffffffff81b47f75 RDI: 0000000000000003
RBP: ffffea0001008040 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81b47eab R11: 0000000000000000 R12: ffff88801e231210
R13: 0000000020400000 R14: ffff8880738f8700 R15: 0000000000000000
FS:  00007f1a19594700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f33cc0df300 CR3: 000000001ca70000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
