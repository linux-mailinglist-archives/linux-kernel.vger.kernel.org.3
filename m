Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440FD4BD3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbiBUC0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:26:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiBUC03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:26:29 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530CE3C704
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:26:07 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id r16-20020a92ac10000000b002c1ec9fa8edso2637940ilh.23
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FLwQOddtIlWkGpBYYANzUNIF6D9LoZwdhUWtL7kN+6U=;
        b=6ZFAkgwG49SIE96npzeTaoyY/Wx5/god9mt/eUvHKzAndkOv8AOUwY/PYjiUQECZ46
         qz7ZNk6NdpY7Mvy+EyZmG+KwI0xRQmuPGVqK2UCNpI5t6NKTbfAE+BQB6cdKAbqgC5r+
         usuui9iJJIzu7b8xqbeuqnkJaaa+X1AOTJsNR3T7mBDOdPWxx5Z4n1NlXdoFtwYumLFy
         kq3wzE6JYwpE/nPbVoigR2oUl6Thrm0p8hqRRH57OPWgJqpkBJ9GIToIoDDtUVlZ3noo
         mlHkvzGF433qgOZ6NVkJAHrWIi6LV4pAPp3gZIMZYFGIA5Dblo8ULdg6ou+xdt8Bg5Tn
         wn6Q==
X-Gm-Message-State: AOAM530U+noP9QPDS/f61C51nssx+b00QuvL66pIE16EzLTyg9Nndyrz
        LsEnyNB6aNPpdMgfcWk9p5wiDcueOP4IK2fRbJyDGxLKMFwa
X-Google-Smtp-Source: ABdhPJx2sJsvNh0IU/Yj/qLg77hai0/BvG9yvXt2L5DGOLEonC0cQH6P/Ea7+FEL9Jzk63OL4UojEY7PPa1e0Yfm6RqYI9akS3Eq
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3711:b0:30d:6027:b980 with SMTP id
 k17-20020a056638371100b0030d6027b980mr13981620jav.87.1645410366709; Sun, 20
 Feb 2022 18:26:06 -0800 (PST)
Date:   Sun, 20 Feb 2022 18:26:06 -0800
In-Reply-To: <20220221021208.1109-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ae0e505d87df42c@google.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
From:   syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in vhost_get_vq_desc

------------[ cut here ]------------
kernel BUG at drivers/vhost/vhost.c:2337!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4061 Comm: vhost-4060 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vhost_get_vq_desc+0x1d43/0x22c0 drivers/vhost/vhost.c:2337
Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 57 59 28 fd e9 74 ff ff ff e8 fd c7 a1 fa <0f> 0b e8 f6 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000204fb88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888077138000 RSI: ffffffff86d71623 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff86d7071c R11: 0000000000000000 R12: ffff888079664d68
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888079664bb0
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc525c41d0 CR3: 000000001816c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vhost_vsock_handle_tx_kick+0x277/0xa20 drivers/vhost/vsock.c:522
 vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vhost_get_vq_desc+0x1d43/0x22c0 drivers/vhost/vhost.c:2337
Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 57 59 28 fd e9 74 ff ff ff e8 fd c7 a1 fa <0f> 0b e8 f6 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000204fb88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888077138000 RSI: ffffffff86d71623 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff86d7071c R11: 0000000000000000 R12: ffff888079664d68
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888079664bb0
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 000000001816c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=128be8ea700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1651c3d2700000

