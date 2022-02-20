Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAD34BCE9C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 14:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbiBTNUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 08:20:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiBTNUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 08:20:30 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CD1424AD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 05:20:08 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id d194-20020a6bcdcb000000b0063a4e3b9da6so8396925iog.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 05:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PxiYsB68bMJBRDStT8Q66zeZicqp8GKsGnbo6+7iasQ=;
        b=FPWmAhnX4v2ALcs/mQ68Fohw5noTkZfEjR51fD6Ch97PQBCdsyInoVPq7AKMwWSEOL
         fp17FelfaZho4Ig5EtH6P+Xmm8Y8n9wv7MvYh0xzhMiYBZy8nFMFi/6bWp919xBBOhZL
         IcirgZWJEEcgpnHuFdo41549/QkTIfxAhXhO53LCkaQwgE/bVFwbbrlWkEPzRA4L6zTU
         O9bWYOZ/S5ZPmcEjdIDeCI2VYBpV4R+m7GlZcHqMTrxHNQIXC8Tb3DD+mfOApUWooAQO
         mYvdj6GP1qtMAsdbwxDcv/YOCg5zZrgBmfh8SCxWg6eOTRDqlTIorqtgApC/VlON4Cwa
         aHig==
X-Gm-Message-State: AOAM5325yBB7bxMEJnR4wWhYakMHd4JaAEq3OnjCfTSt5WUN6FniKqT/
        hzItYGbfaSwCjlalM0R4VOyQsuk8KHa6l/m3SnED8ZkOiQAw
X-Google-Smtp-Source: ABdhPJx2l1wrYHFYY4RP7srumSWdJBEUIPsnZmkvsKnd9Yc/h9YUaWw+LHEEleAVlMSqm5hYUdy1AxyVqJpEwi5MCvM2hTowC+yR
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1594:b0:640:7236:e6ea with SMTP id
 e20-20020a056602159400b006407236e6eamr9868298iow.23.1645363207448; Sun, 20
 Feb 2022 05:20:07 -0800 (PST)
Date:   Sun, 20 Feb 2022 05:20:07 -0800
In-Reply-To: <20220220075826-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081acbc05d872f93c@google.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
From:   syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
To:     dvyukov@google.com, hdanton@sina.com, jasowang@redhat.com,
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
kernel BUG at drivers/vhost/vhost.c:2335!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4048 Comm: vhost-4047 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vhost_get_vq_desc+0x1d43/0x22c0 drivers/vhost/vhost.c:2335
Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 b7 59 28 fd e9 74 ff ff ff e8 5d c8 a1 fa <0f> 0b e8 56 c8 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90001affb88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801c9c5700 RSI: ffffffff86d715c3 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff86d706bc R11: 0000000000000000 R12: ffff888073b44d68
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888073b44bb0
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 0000000079bfe000 CR4: 00000000003506e0
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
RIP: 0010:vhost_get_vq_desc+0x1d43/0x22c0 drivers/vhost/vhost.c:2335
Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 b7 59 28 fd e9 74 ff ff ff e8 5d c8 a1 fa <0f> 0b e8 56 c8 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90001affb88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801c9c5700 RSI: ffffffff86d715c3 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff86d706bc R11: 0000000000000000 R12: ffff888073b44d68
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888073b44bb0
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005619d349f018 CR3: 0000000079bfe000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=161cf916700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13500f0e700000

