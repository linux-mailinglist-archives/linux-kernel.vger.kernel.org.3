Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE5479B26
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 15:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhLROEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 09:04:25 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:34427 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhLROEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 09:04:23 -0500
Received: by mail-il1-f197.google.com with SMTP id h10-20020a056e021b8a00b002a3f246adeaso3033495ili.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 06:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=p9weZrbhbMWwsfKPE7dVXuUEsd7QPkZdiaPp2RwnUuU=;
        b=wj1CZa0iJoyW5clW/9CfR0A8K4Jz0eMhFmLTqchW0WOyECPKmUATDmpMJIIaxChg/P
         wIT0k8I6e8iPInVx099XJjY62Oqg74U5Yhfpp6D22Uuo3l+FOALQzgLv5gdgTJKtVvyg
         N/P/KE8hsjwtruS00NCcVVAW6SzOwC3j1aIhhRzuQ7hRKKGBvYow2p06hwfA5v23dSHo
         781sH/4q4xU0jw/92GIHEQat0ZGR6+8bPJEF6lNzmFcc6/HDC2t8MfYJu1gBhvLsJZWY
         f/nKfVFQV77icV/xvzB6xveuFsXYp+sWivXjzMwCKcGEf6CaIMjbHvGiQ3WYBfu6kKjI
         aTxg==
X-Gm-Message-State: AOAM531amz+TOVk3vVOBEh+v7Oz/ffqNZKxIZLbSbo/c+g05PvO0wOtX
        e7kEA6rS0c4TnfEtdV5KDLp1XhbQ5LGepvxRkPDcL0xVBpph
X-Google-Smtp-Source: ABdhPJwg+s+FzqsSVARK5Ra54kR9DLeVVtUU6EdkokG9Ie0WeU/qe8MB2gNsoUzpNvNOsSqxNxYjUEgHgsAKx3CzOsL9hMiaXGvn
MIME-Version: 1.0
X-Received: by 2002:a92:c246:: with SMTP id k6mr3719889ilo.280.1639836262943;
 Sat, 18 Dec 2021 06:04:22 -0800 (PST)
Date:   Sat, 18 Dec 2021 06:04:22 -0800
In-Reply-To: <00000000000021bb9b05d14bf0c7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1504c05d36c21ea@google.com>
Subject: Re: [syzbot] WARNING in page_counter_cancel (3)
From:   syzbot <syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    fbf252e09678 Add linux-next specific files for 20211216
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1797de99b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7fcbb9aa19a433c8
dashboard link: https://syzkaller.appspot.com/bug?extid=bc9e2d2dbcb347dd215a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135d179db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113edb6db00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com

R13: 00007ffdeb858640 R14: 00007ffdeb858680 R15: 0000000000000004
 </TASK>
------------[ cut here ]------------
page_counter underflow: -4294966651 nr_pages=4294967295
WARNING: CPU: 1 PID: 3665 at mm/page_counter.c:56 page_counter_cancel+0xcf/0xe0 mm/page_counter.c:56 mm/page_counter.c:56
Modules linked in:
CPU: 1 PID: 3665 Comm: syz-executor933 Not tainted 5.16.0-rc5-next-20211216-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:page_counter_cancel+0xcf/0xe0 mm/page_counter.c:56 mm/page_counter.c:56
Code: c7 04 24 00 00 00 00 45 31 f6 eb 97 e8 ba 77 af ff 4c 89 ea 48 89 ee 48 c7 c7 60 fe b8 89 c6 05 5f b3 b5 0b 01 e8 a6 85 48 07 <0f> 0b eb a8 4c 89 e7 e8 d5 85 fa ff eb c7 0f 1f 00 41 56 41 55 49
RSP: 0018:ffffc90002b1f620 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff88807b6e8120 RCX: 0000000000000000
RDX: ffff88807ad31d40 RSI: ffffffff815f4748 RDI: fffff52000563eb6
RBP: ffffffff00000285 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815ee4ae R11: 0000000000000000 R12: ffff88807b6e8120
R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
FS:  000055555596c300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000007f24a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_counter_uncharge+0x2e/0x60 mm/page_counter.c:159 mm/page_counter.c:159
 drain_stock+0xc1/0x170 mm/memcontrol.c:2172 mm/memcontrol.c:2172
 refill_stock+0x131/0x1b0 mm/memcontrol.c:2224 mm/memcontrol.c:2224
 __sk_mem_reduce_allocated+0x24d/0x550 net/core/sock.c:2951 net/core/sock.c:2951
 __mptcp_rmem_reclaim net/mptcp/protocol.c:169 [inline]
 __mptcp_rmem_reclaim net/mptcp/protocol.c:169 [inline] net/mptcp/protocol.c:978
 __mptcp_mem_reclaim_partial+0x124/0x410 net/mptcp/protocol.c:978 net/mptcp/protocol.c:978
 mptcp_mem_reclaim_partial net/mptcp/protocol.c:985 [inline]
 mptcp_alloc_tx_skb net/mptcp/protocol.c:1215 [inline]
 mptcp_mem_reclaim_partial net/mptcp/protocol.c:985 [inline] net/mptcp/protocol.c:1282
 mptcp_alloc_tx_skb net/mptcp/protocol.c:1215 [inline] net/mptcp/protocol.c:1282
 mptcp_sendmsg_frag+0x1ada/0x2410 net/mptcp/protocol.c:1282 net/mptcp/protocol.c:1282
 __mptcp_push_pending+0x232/0x7a0 net/mptcp/protocol.c:1548 net/mptcp/protocol.c:1548
 mptcp_release_cb+0xfe/0x200 net/mptcp/protocol.c:3013 net/mptcp/protocol.c:3013
 release_sock+0xb4/0x1b0 net/core/sock.c:3312 net/core/sock.c:3312
 sk_stream_wait_memory+0x608/0xed0 net/core/stream.c:145 net/core/stream.c:145
 mptcp_sendmsg+0x8df/0x1300 net/mptcp/protocol.c:1745 net/mptcp/protocol.c:1745
 inet6_sendmsg+0x99/0xe0 net/ipv6/af_inet6.c:641 net/ipv6/af_inet6.c:641
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg_nosec net/socket.c:704 [inline] net/socket.c:724
 sock_sendmsg+0xcf/0x120 net/socket.c:724 net/socket.c:724
 sock_write_iter+0x289/0x3c0 net/socket.c:1057 net/socket.c:1057
 call_write_iter include/linux/fs.h:2079 [inline]
 call_write_iter include/linux/fs.h:2079 [inline] fs/read_write.c:503
 new_sync_write+0x429/0x660 fs/read_write.c:503 fs/read_write.c:503
 vfs_write+0x7cd/0xae0 fs/read_write.c:590 fs/read_write.c:590
 ksys_write+0x1ee/0x250 fs/read_write.c:643 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4cc423cf49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdeb8585f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4cc423cf49
RDX: 0000000000017f88 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007ffdeb858620 R08: 0000000000000001 R09: 00007ffdeb858630
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00007ffdeb858640 R14: 00007ffdeb858680 R15: 0000000000000004
 </TASK>

