Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4AE4771D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhLPMbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:31:18 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:33456 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhLPMbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:31:17 -0500
Received: by mail-io1-f70.google.com with SMTP id 85-20020a6b0258000000b005ed47a95f03so23213511ioc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nb8+2lBSILFE6UU/ftaAQ2l3qcGXhi1ECfZtZX/zKu4=;
        b=OWU7QDMv0Yv8+oFddTFDtTPsLJpqxzBEpqVNXJJ6yA3TXHPZkVWxY+IuVE3r546VQ0
         xpsoWnpusgipB07WPkS9smK7XtJKI+V0ZBOApelrlSSKTAp7cDMbYVFWGT3MuXEzrRRe
         2p8VKV1QFYGjGKZdfM7jCFFMqGOVNts1vF99k1UP+xqpezRPHdnXAdfFEVLEOyhY8PVD
         XLzSIA+rU/+qem9kZa1/Wl+y2OGzrnwC9XEW79TO22w1CGpEue585odtIQZeQursxft9
         8vhdqW7vyOG2I9OLHlQlUn94NQ+kKi1IsGAo4jYbrWdwSfu3Q1d3jyI+/dZkjYU/QElU
         Z0AA==
X-Gm-Message-State: AOAM5310RnV+GwRjFng8deIDSJg9nel0BWBb+3//UrUjCV3wxnBvYe+x
        dBzDUFD6bEQD68EgH8KKwqvnSGZiqKkyX7W1s2tHdSdV8YiU
X-Google-Smtp-Source: ABdhPJylspzn8wUIltPJlmP3hxLPJuB9f2MJeQOfXd+Zqh1tkv5D6R9j3MDhzMYZ6FlSxF/UskxRCTTlFIYTEbQN2r1ALhWGMNWD
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c8:: with SMTP id z8mr9303792ilu.271.1639657877023;
 Thu, 16 Dec 2021 04:31:17 -0800 (PST)
Date:   Thu, 16 Dec 2021 04:31:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050314505d3429981@google.com>
Subject: [syzbot] kernel BUG in lbmIODone
From:   syzbot <syzbot+52ddb6c83a04ca55f975@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a763d5a5abd6 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14556c83b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5247c9e141823545
dashboard link: https://syzkaller.appspot.com/bug?extid=52ddb6c83a04ca55f975
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52ddb6c83a04ca55f975@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_logmgr.c:2313 assert(bp->l_flag & lbmRELEASE)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_logmgr.c:2313!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13 Comm: ksoftirqd/0 Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:lbmIODone.cold+0xc9/0x116 fs/jfs/jfs_logmgr.c:2313
Code: 68 c3 b3 f8 eb d3 e8 31 89 6d f8 48 c7 c1 e0 8a e6 89 ba 09 09 00 00 48 c7 c6 20 89 e6 89 48 c7 c7 60 89 e6 89 e8 ec 12 f8 ff <0f> 0b e8 0b 89 6d f8 48 c7 c1 20 8b e6 89 ba 0a 09 00 00 48 c7 c6
RSP: 0018:ffffc90000f3fc88 EFLAGS: 00010082
RAX: 000000000000003f RBX: ffff8880208bf100 RCX: 0000000000000000
RDX: ffff888011c86040 RSI: ffffffff815e52a8 RDI: fffff520001e7f83
RBP: 0000000000000020 R08: 000000000000003f R09: 0000000000000000
R10: ffffffff815df04e R11: 0000000000000000 R12: 0000000000000246
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3fa25ed000 CR3: 00000000412c7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bio_endio+0x5ec/0x770 block/bio.c:1489
 req_bio_endio block/blk-mq.c:674 [inline]
 blk_update_request+0x46a/0x1400 block/blk-mq.c:742
 blk_mq_end_request+0x4b/0x80 block/blk-mq.c:821
 lo_complete_rq+0x1c2/0x280 drivers/block/loop.c:369
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:892
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace 7200a80d946f066f ]---
RIP: 0010:lbmIODone.cold+0xc9/0x116 fs/jfs/jfs_logmgr.c:2313
Code: 68 c3 b3 f8 eb d3 e8 31 89 6d f8 48 c7 c1 e0 8a e6 89 ba 09 09 00 00 48 c7 c6 20 89 e6 89 48 c7 c7 60 89 e6 89 e8 ec 12 f8 ff <0f> 0b e8 0b 89 6d f8 48 c7 c1 20 8b e6 89 ba 0a 09 00 00 48 c7 c6
RSP: 0018:ffffc90000f3fc88 EFLAGS: 00010082
RAX: 000000000000003f RBX: ffff8880208bf100 RCX: 0000000000000000
RDX: ffff888011c86040 RSI: ffffffff815e52a8 RDI: fffff520001e7f83
RBP: 0000000000000020 R08: 000000000000003f R09: 0000000000000000
R10: ffffffff815df04e R11: 0000000000000000 R12: 0000000000000246
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3fa25ed000 CR3: 00000000412c7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
