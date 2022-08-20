Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185AD59ADBD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345951AbiHTL6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345917AbiHTL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:58:34 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9E2BB30
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 04:58:33 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e2-20020a056e020b2200b002e1a5b67e29so4981215ilu.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 04:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=vy3gLv5pvPQlLz2bjwfmQURwI/ANJztqCqsTatb7lPc=;
        b=q4kzDloJQLtQ4culHFUed4un1O0xbhzZwQf5Ud0mvNe1x+YUuCfQ9B0ydzB1YcGKSV
         9Zdxz3/PBwbjrfX3NLda3BRKHYR7QFDAh5hl9PdrSnSca+JJNrhuenQ1Z/3SdLVZDv2+
         dkQQZ1CdcErl2CBlaZGpyTJVG4Xuz51Jnnv1lDM/XZr7KWHwI86oyKf3irZ/UtsQpL7G
         v/rdrNrGNWXLhRF0Y3r0WuE6WJDdOwkkLH5wq3olqD//A0Ba15s/kOgA7H6fuyTaohUd
         gdJW5BCrF7nK5G+EW13Z82O0EyprDb1kkZEi5FgiBV/jCFFgmQJws4YaUISaBo9af+JA
         uCSw==
X-Gm-Message-State: ACgBeo0sVY4WVRXNWmd9OOACTxC5ID1cPsUmtBJwr/fXe9689+a9E09l
        7bOM4G42KZETl0/hyEcrt2poXQrRuEkNTgjnYIpyQfPx1jU4
X-Google-Smtp-Source: AA6agR42s0Q0/ClM39KKuAgSZ1cZ949PdC2kNOjk+fj2W/VpQvCJ6SFgRvV4AKLjivqd5ZqOQ3G3ZG2+U4IPcuN0qZnCCyqt7jZr
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c5:b0:689:5640:5b0f with SMTP id
 b5-20020a05660214c500b0068956405b0fmr3941282iow.70.1660996712989; Sat, 20 Aug
 2022 04:58:32 -0700 (PDT)
Date:   Sat, 20 Aug 2022 04:58:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d0b1905e6aaef64@google.com>
Subject: [syzbot] memory leak in vhci_write
From:   syzbot <syzbot+8f819e36e01022991cfa@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1206e2d3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e4b25d26c713a1b
dashboard link: https://syzkaller.appspot.com/bug?extid=8f819e36e01022991cfa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e8bd97080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143c9fc3080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f819e36e01022991cfa@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810d81ac00 (size 240):
  comm "syz-executor219", pid 3615, jiffies 4294947117 (age 12.320s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff838733d9>] __alloc_skb+0x1f9/0x270 net/core/skbuff.c:418
    [<ffffffff833f742f>] alloc_skb include/linux/skbuff.h:1257 [inline]
    [<ffffffff833f742f>] bt_skb_alloc include/net/bluetooth/bluetooth.h:469 [inline]
    [<ffffffff833f742f>] vhci_get_user drivers/bluetooth/hci_vhci.c:391 [inline]
    [<ffffffff833f742f>] vhci_write+0x5f/0x230 drivers/bluetooth/hci_vhci.c:511
    [<ffffffff815e398d>] call_write_iter include/linux/fs.h:2192 [inline]
    [<ffffffff815e398d>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff815e398d>] vfs_write+0x42d/0x540 fs/read_write.c:578
    [<ffffffff815e3cdd>] ksys_write+0x9d/0x160 fs/read_write.c:631
    [<ffffffff845e0645>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845e0645>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
