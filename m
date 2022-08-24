Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED059FF91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiHXQfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiHXQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:35:32 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BC80F4C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:35:31 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so12922914ilu.17
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=SAh57rTjphZIWff57ut959PhYNidmDvkR6EstUizDYg=;
        b=QKLZbtgUA8tHyu4sTVX1Go7z9a1kVE9VEoKUFZNnRhAtUu+9gV1T7QcPatBsfglsYD
         4KIP1RscyXAFMowZ0B0mLJfoXRYcVBwnOw3q9d7Kkm3q3Zt0qb2+ie5t/5BNjtLZ7rMT
         eMzU9vRCSmZfJEvxwI10VHP5xRWrBEYZX4VIjh73YhlFB8eH/b+41osdzP1rKt3cwkQV
         nNiwZ1fq0TqGr3lhkH0ypP09ucfKeZRHopT8AgK8Jmq5Oh5nHfBy4J5/Sxl4MthCKHSr
         ub8bX9/X6Nv1M/nO84qcJrC+cNuet3B589w+1j3vHTkdyIQdWxkZjtoNRldTabpttBeQ
         cJVQ==
X-Gm-Message-State: ACgBeo1pEJ/4cPW8WqtYWxCCcivcf32xNmuqsQTK0WFIhAnzKMLT9Ju+
        sj14xDBdG4gDl6Aqf315xaoPU7iYePKIq0mM+O/24NJ1VXxY
X-Google-Smtp-Source: AA6agR6ZBN+WFXvWU4gkmCBNPwWt+c3aM7f4qneAfNHwmFoJDz3AphkWJNHmAzr5AZ7WMJX524bl6IM1YG4a3ZVE27us75gCT8Rx
MIME-Version: 1.0
X-Received: by 2002:a05:6638:160a:b0:349:d991:d929 with SMTP id
 x10-20020a056638160a00b00349d991d929mr8183409jas.144.1661358930466; Wed, 24
 Aug 2022 09:35:30 -0700 (PDT)
Date:   Wed, 24 Aug 2022 09:35:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e51e3e05e6ff44db@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in tty_ldisc_receive_buf
From:   syzbot <syzbot+be4b95faeb7a9073bb88@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=177ac367080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3045c937aad027f7
dashboard link: https://syzkaller.appspot.com/bug?extid=be4b95faeb7a9073bb88
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1701758d080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17473aad080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be4b95faeb7a9073bb88@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010b44f000
[0000000000000000] pgd=080000010b5f3003, p4d=080000010b5f3003, pud=080000010b1ce003, pmd=0000000000000000
Internal error: Oops: 86000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 28 Comm: kworker/u4:1 Not tainted 6.0.0-rc2-syzkaller-16440-g1c23f9e627a7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
Workqueue: events_unbound flush_to_ldisc
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : gsmld_receive_buf+0x140/0x214 drivers/tty/n_gsm.c:2861
sp : ffff80000f603c30
x29: ffff80000f603c40 x28: 0000000000000000 x27: 00000000000003d9
x26: 0000000000000000 x25: 0000000000000000 x24: ffff80000d937000
x23: ffff80000d681e40 x22: ffff0000c929b800 x21: 0000000000000000
x20: ffff80000c205988 x19: ffff0000c91cf446 x18: ffff80000d2dec40
x17: 0000000000000008 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000004 x12: ffff80000d681e78
x11: ff808000098e7e04 x10: 0000000000000000 x9 : ffff8000098e7e04
x8 : 0000000000000000 x7 : ffff8000098dac3c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 00000000000003da
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c929b800
Call trace:
 0x0
 tty_ldisc_receive_buf+0xb8/0xcc drivers/tty/tty_buffer.c:461
 tty_port_default_receive_buf+0x54/0x8c drivers/tty/tty_port.c:39
 receive_buf drivers/tty/tty_buffer.c:511 [inline]
 flush_to_ldisc+0x150/0x358 drivers/tty/tty_buffer.c:561
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
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
