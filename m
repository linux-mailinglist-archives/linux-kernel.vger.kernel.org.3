Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7DE59FF92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiHXQfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiHXQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:35:31 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0EA80B63
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:35:30 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o5-20020a056e02102500b002ddcc65029cso12931011ilj.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=XRsedfIcW+HglbEqbIPeqE6h3oV5yzf+0kc6Op+llds=;
        b=LnWNZid72NLQVSB5ZZ5x10LJm9Et8StkBfWTXkYv0igcqUs7udh03ydHYx50wA5xBF
         RDBUmLCDOaiFabdv4FkqN5iafu33RtNJ+sVWFU24H4MvKu1jgW+7YGfutXPZoxjdUcGu
         HHxe2KCAUfo9fQu/dYy0OVrprgPsUoA7QIvxuT4nWnawc2mki1AZ7S1hI9LeolDW/bsT
         ag0zEewpvRiXU7M4ypQZyjDdmrvCefCLFqepEO5SJMmQJzJQI+ze0tmPf2Wfmrcnk5jk
         9JPQHRxoDCbuWE99OzgOxjxNjJ5dZy1q/n9uzvBxQYohU7V/g+uDZD4ReA2hLt74PQJB
         luSA==
X-Gm-Message-State: ACgBeo0Rdms+gndUhBshi/6hv39nshhuGj7EWQHPH1h95+uPKzlx7KnD
        2J2y1zpR+RaN3vjeUfXyBdr4IZDzzpftKEqoyMQCX+/7Rx49
X-Google-Smtp-Source: AA6agR52F0vRGuU+pk1JcZsAkSpStS/VeWOcdJw9MHIiOCddfHTkFh2uX8a7912W44VdA1iEhOkZZByZj+LgeKjMXimkfJOgPtLF
MIME-Version: 1.0
X-Received: by 2002:a92:dc0a:0:b0:2e9:4fa6:f6df with SMTP id
 t10-20020a92dc0a000000b002e94fa6f6dfmr2552053iln.203.1661358930205; Wed, 24
 Aug 2022 09:35:30 -0700 (PDT)
Date:   Wed, 24 Aug 2022 09:35:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e12a9005e6ff4417@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in tiocsti
From:   syzbot <syzbot+032314e8d7de2bdb97f7@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1c23f9e627a7 Linux 6.0-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17eefdcb080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3045c937aad027f7
dashboard link: https://syzkaller.appspot.com/bug?extid=032314e8d7de2bdb97f7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1190eb6b080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a1e50d080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+032314e8d7de2bdb97f7@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010b28b000
[0000000000000000] pgd=080000010b411003, p4d=080000010b411003, pud=080000010b47b003, pmd=0000000000000000
Internal error: Oops: 86000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3028 Comm: syz-executor908 Not tainted 6.0.0-rc2-syzkaller-16440-g1c23f9e627a7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : gsmld_receive_buf+0x140/0x214 drivers/tty/n_gsm.c:2861
sp : ffff80000ffe3cb0
x29: ffff80000ffe3cc0 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: ffff80000d937000
x23: ffff80000d681e40 x22: ffff0000cb2dc000 x21: ffff80000ffe3d21
x20: ffff80000c205988 x19: ffff80000ffe3d24 x18: 00000000000000c0
x17: ffff80000dd7a698 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000004 x12: ffff80000d681e78
x11: ff808000098e7e04 x10: 0000000000000000 x9 : ffff8000098e7e04
x8 : 0000000000000000 x7 : ffff8000098dcea4 x6 : 0000000000000000
x5 : ffff80000e087890 x4 : 0000000000000002 x3 : 0000000000000001
x2 : ffff80000ffe3d20 x1 : 0000000000000000 x0 : ffff0000cb2dc000
Call trace:
 0x0
 tiocsti+0x168/0x1c4 drivers/tty/tty_io.c:2293
 tty_ioctl+0x284/0x9f4 drivers/tty/tty_io.c:2692
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: bad PC value
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
