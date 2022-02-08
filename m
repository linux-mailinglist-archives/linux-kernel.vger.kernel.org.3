Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50524AD132
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiBHFly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiBHFkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:40:32 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD210C0401F0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:40:30 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id n20-20020a6bed14000000b0060faa0aefd3so10626531iog.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NVEYrJM0C3B0DWqVYowPI6bzh3KUToVqmgGzHv+vXCQ=;
        b=jajnMVKgR3D8r9j+sAQ36qWyCWPMsb7Se00AjRDVRtRhi7OJA1gGJnWSlDe/Sq6DAc
         fAbtukZ6cLkhjqu7oPoxfhQBM5nQjqjfZwNmGvw/NDsU4IpUFBbugZJKjX/bir+Ej/m8
         l776wQcH9Rp+DaYBVUk7KAWtbamwhCVnUFd6S9jhrVtkZAELo6wog9cZDCbWtWGD6bsY
         Jw3+caKxMjq4qxkZlecIfm9RyFYlolgvJpuC9n23V95gGH9vfug6TVr1l+bh3xL/YSby
         N45iq3CWacdJVz3O1BK6RTGRRR1vluXIyJNAgtGgretNQZZA3naN7nIWUiSmMnvPZujk
         B0bQ==
X-Gm-Message-State: AOAM532edbneMNy/YX9bAvRScbROLIZo/S9mpV2H0eNtih0NaroDQhPp
        La4PTm36AHSfYH/carbgXGMhGIIs5gNofvls+qhh+N1yO2BT
X-Google-Smtp-Source: ABdhPJwLZLDaZfItvI/FjsAH813l0hh7diG5+FTlYeAhKB9UntHVkhqPOESjyLXH9GxA56pxarOniC87xi34KrKsGbjRmS+msCyo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1348:: with SMTP id u8mr1445462jad.204.1644298830219;
 Mon, 07 Feb 2022 21:40:30 -0800 (PST)
Date:   Mon, 07 Feb 2022 21:40:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae0f7b05d77b27b5@google.com>
Subject: [syzbot] WARNING in blk_register_tracepoints
From:   syzbot <syzbot+c54ded83396afee31eb1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    d8ad2ce873ab Merge tag 'ext4_for_linus_stable' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15665db2700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee3797346aa03884
dashboard link: https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e00d84700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119fd0c2700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=171a984fb00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=149a984fb00000
console output: https://syzkaller.appspot.com/x/log.txt?x=109a984fb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c54ded83396afee31eb1@syzkaller.appspotmail.com

RBP: 00007ffc2d88d100 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3595 at kernel/trace/blktrace.c:1090 blk_register_tracepoints+0x2dc/0x3a0 kernel/trace/blktrace.c:1090
Modules linked in:
CPU: 0 PID: 3595 Comm: syz-executor147 Not tainted 5.17.0-rc2-syzkaller-00398-gd8ad2ce873ab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:blk_register_tracepoints+0x2dc/0x3a0 kernel/trace/blktrace.c:1090
Code: 48 c7 c7 00 3d 82 8d e8 f2 69 fb ff 31 ff 89 c3 89 c6 e8 e7 a8 f9 ff 85 db 0f 85 ba 00 00 00 5b e9 b9 a6 f9 ff e8 b4 a6 f9 ff <0f> 0b e9 4b fd ff ff e8 a8 a6 f9 ff 0f 0b e9 6c fd ff ff e8 9c a6
RSP: 0018:ffffc9000279fbc0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: 0000000000000000
RDX: ffff888023011d00 RSI: ffffffff817ed1dc RDI: 0000000000000003
RBP: ffff8881469d4300 R08: 0000000000000000 R09: ffffc9000279fa67
R10: ffffffff817ecf26 R11: 0000000000000000 R12: ffffc9000279fc70
R13: ffff8881469d4328 R14: ffff8881470196d0 R15: ffff8881469d4330
FS:  0000555556142300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc2d88d0c8 CR3: 00000000715ef000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 get_probe_ref kernel/trace/blktrace.c:326 [inline]
 do_blk_trace_setup+0x9c3/0xc80 kernel/trace/blktrace.c:570
 __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:589
 blk_trace_setup+0x43/0x60 kernel/trace/blktrace.c:607
 sg_ioctl_common drivers/scsi/sg.c:1123 [inline]
 sg_ioctl+0x257/0x2780 drivers/scsi/sg.c:1165
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f7e080026d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc2d88d0e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f7e080026d9
RDX: 0000000020000140 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007ffc2d88d100 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
