Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D9B4CC608
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiCCTaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiCCTaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:30:13 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F2918E430
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 11:29:27 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id c13-20020a5e8f0d000000b00644c39c4c69so4100690iok.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 11:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RvfzRuIjzXeV56b1mRFLXFY+p/ycge3TMt6j8QIdRXg=;
        b=Y/nK6I6UqSKswOtRnIQxmG3CMVNMoCbajvpHptg863vZXArpy0MH9/B9HgSxAGfn9z
         AbqNFk/po+mWSd4WasxVlmWUYwF47u6pJsLVuMNpvod55XvTZi/S7+GkOmhvUMgEgdqC
         9jmhGpQIYw9I8Bvi9oT+2ypq9o19A+EW3X7L4Y4lftfrSN42M6GYTG0KMb8HICtuWc4t
         /n5p7Y1+2Uk3h1qKTKJjmPkYePyEH1AnDj4ubs7tDk3R7ps9LmDNy8i0COTPRGoeBhnJ
         fz+lqPScFBOLOysfVZBH0+bKmoCPsZUgoCXsaJp6Kidnr9jmSqedY8vUuJno+D9gJBNY
         PsLg==
X-Gm-Message-State: AOAM530Hs1oTuw1P/u5574c3goumE59G0DoL/hLSc1R2kdGBcV5u9Cri
        KEnWhSh96uljj+eH5mDPK1tiQJlNdLr1UeAqmYnl4QZVB1Ek
X-Google-Smtp-Source: ABdhPJzUTAaA/byxOffRax7TszOB4dPGuWt1MdkQS0ngFiiHxVQpxAFrKZZu9OzlQwtoxwNuGlvNJDnknDD5HUyikzlUMeUyBzoc
MIME-Version: 1.0
X-Received: by 2002:a02:69cc:0:b0:314:3518:780b with SMTP id
 e195-20020a0269cc000000b003143518780bmr29956636jac.133.1646335766948; Thu, 03
 Mar 2022 11:29:26 -0800 (PST)
Date:   Thu, 03 Mar 2022 11:29:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091f0b805d9556a82@google.com>
Subject: [syzbot] WARNING in usbtmc_ioctl/usb_submit_urb
From:   syzbot <syzbot+a48e3d1a875240cab5de@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    2293be58d6a1 Merge tag 'trace-v5.17-rc4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166215b6700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b9a7fa580ff2b33
dashboard link: https://syzkaller.appspot.com/bug?extid=a48e3d1a875240cab5de
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172cdd12700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170790e6700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f51482700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f51482700000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f51482700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a48e3d1a875240cab5de@syzkaller.appspotmail.com

usb 5-1: BOGUS control dir, pipe 80001e80 doesn't match bRequestType 0
WARNING: CPU: 0 PID: 3813 at drivers/usb/core/urb.c:412 usb_submit_urb+0x13a5/0x1970 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 0 PID: 3813 Comm: syz-executor122 Not tainted 5.17.0-rc5-syzkaller-00306-g2293be58d6a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x13a5/0x1970 drivers/usb/core/urb.c:410
Code: 4c 24 38 8a 04 01 84 c0 0f 85 ad 05 00 00 45 0f b6 06 48 c7 c7 c0 f0 26 8b 48 8b 74 24 20 4c 89 e2 89 d9 31 c0 e8 3b 4b 58 fb <0f> 0b e9 0b f0 ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c a8 ed ff
RSP: 0018:ffffc90002c3fa40 EFLAGS: 00010246
RAX: 1323d10499d7ec00 RBX: 0000000080001e80 RCX: ffff88801c2c5700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff816aea02 R09: fffffbfff1ffbbde
R10: fffffbfff1ffbbde R11: 0000000000000000 R12: ffff88801d757618
R13: ffff88801d79d000 R14: ffff88801da98b18 R15: ffff88807a91f0a8
FS:  00005555574a2300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa78ffa04d0 CR3: 00000000195f0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_start_wait_urb+0x113/0x530 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x2a5/0x4b0 drivers/usb/core/message.c:153
 usbtmc_ioctl_request drivers/usb/class/usbtmc.c:1947 [inline]
 usbtmc_ioctl+0x164e/0x20e0 drivers/usb/class/usbtmc.c:2090
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe3805832a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec2198ee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007fe3805832a9
RDX: 0000000020000140 RSI: 00000000c0105b08 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 000000000000000f R11: 0000000000000246 R12: 00000000000530bd
R13: 00007ffec2198efc R14: 00007ffec2198f10 R15: 00007ffec2198f00
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
