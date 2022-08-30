Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEBA5A591C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiH3CHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiH3CHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:07:40 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D7685FED
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:07:37 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so5759254ioz.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=nanlXxexgS+sOF5IoFqJSnLgZ6XGRaUU/Yg3caHCrs0=;
        b=h4IkBbelhyAKl0hoISoIlPlZrhg2IkxUuVxYPqgjl1PjG0g9Q9kl2ULqisn98JhkjY
         crWoDt9LSlJ4mctp9eZ3xoM8pUkdPb2BaFww8zq214GQcS+v8DMO6L0wgUV2fg0foh6e
         V3Lg9k+ThRKcnwNMbXRHTZCywImCC/a2zCz8YmaAEV23MeTsAkZHOcEPgvOfKGJE4joQ
         yfXh2jjfEOpxCSGBamsrogUgM/8bqusRPg0xo9UHrozvJr+p5h7wPc54Biyt4jAexnmX
         R18BS+gsmH296fCcs5zHiCLyuvdupA8F84iMlUnC06g3RatwINQRVvpNIksLIvATXHgr
         Gf1Q==
X-Gm-Message-State: ACgBeo1bOciFeBfsqVsRj6GSB4k3ShNfqT9Jfziw40qCSlyocQ2j4cBA
        Yp0IsozPyi04Mxtsqt4YPe6MbPWi2vQIVB8WbDw/8Gq2vC3e
X-Google-Smtp-Source: AA6agR4B8qi4WR//ItzKCj0XTwNjcyLlpHmq0otQ6G5gBGcmL+NN9MjbONt712HvELxGKjJNK7OABib+s5rP8zbbD/iFhdxbUXHN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2190:b0:349:e1e8:18cb with SMTP id
 s16-20020a056638219000b00349e1e818cbmr11167728jaj.257.1661825256409; Mon, 29
 Aug 2022 19:07:36 -0700 (PDT)
Date:   Mon, 29 Aug 2022 19:07:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016512d05e76bd837@google.com>
Subject: [syzbot] upstream test error: WARNING in __queue_work
From:   syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>
To:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

HEAD commit:    4c612826bec1 Merge tag 'net-6.0-rc3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120ebce7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=312be25752c7fe30
dashboard link: https://syzkaller.appspot.com/bug?extid=243b7d89777f90f7613b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com

Bluetooth: hci0: command 0x0409 tx timeout
------------[ cut here ]------------
WARNING: CPU: 0 PID: 52 at kernel/workqueue.c:1438 __queue_work+0xe3f/0x1210 kernel/workqueue.c:1438
Modules linked in:
CPU: 0 PID: 52 Comm: kworker/0:2 Not tainted 6.0.0-rc2-syzkaller-00159-g4c612826bec1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events hci_cmd_timeout
RIP: 0010:__queue_work+0xe3f/0x1210 kernel/workqueue.c:1438
Code: e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 29 09 79 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 9a 5f 2d 00 85 db 75 42 e8 d1 62 2d 00 <0f> 0b e9 41 f8 ff ff e8 c5 62 2d 00 0f 0b e9 d3 f7 ff ff e8 b9 62
RSP: 0018:ffffc90000947c60 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff88802c83e200 RCX: 0000000000000000
RDX: ffff88801538a180 RSI: ffffffff814dd75f RDI: ffff88802c83e208
RBP: 0000000000000008 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000200000 R11: 0000000000000000 R12: ffff8880266b4c70
R13: 0000000000000000 R14: ffff888014b1e000 R15: ffff888014b1e000
FS:  0000000000000000(0000) GS:ffff88802c800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0003d1e80 CR3: 00000000155b2000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0xee/0x110 kernel/workqueue.c:1545
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
