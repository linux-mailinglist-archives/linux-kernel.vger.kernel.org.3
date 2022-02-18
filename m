Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1A44BAF20
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiBRBVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:21:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiBRBVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:21:36 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08052DF402
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:21:20 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i7-20020a056e020ec700b002be118c9b21so3028890ilk.20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PI4bJ+3UyFNIhL2gM6ZjIwlHECbqteu1Qx27eZtjvq0=;
        b=o8ii6/4vDN5iCFJR3cf1Y2mc3/zZ05z29YjmGur2dgzR8ANPiq+MilNkhxp4Ud+Ixs
         JR0pe98GuAarvQ/xe0UjjkmhKfEUe9PzVdKsqeJjafvZBBW9+wHFFQ1m4/Gp7fTvrtpz
         Qr/ipaHUYEdRNeADP+5GLpaT2Jt5d1ddAR7UlwopAJrJPDmvnuHCjxfPBj8U+LCQG04/
         nGS/j0cG2AIiUMSHwPwKQmtdCmNlO41DRYU9QAB1zmvfn8N9dw02RdmdHH9v3s0fFkP6
         WTF9v+701PQgaBs+ZCL0EFtfmu6LYLY0azPBhmlSN2QbUAoABYVFC4+RPDgywpI0+cv6
         3kLw==
X-Gm-Message-State: AOAM531zGSgQ33CHaRdoaz8Y9tZ2glFWFx+DPYWn+gdH3eqSk0DMpujQ
        oWpQd+qR8VQKxeHLc+2x0hWTaQZyvAUjJR7UQIxlERFMU7zQ
X-Google-Smtp-Source: ABdhPJzMJrON2BfGCITlW3+eDZBkMBVufcpwdoMqqQUBSQYi62zjJDqVxJCzoKejc1qpyiIQn37+6yEdGUiIUI4TInkv67gcdYe3
MIME-Version: 1.0
X-Received: by 2002:a02:a1d6:0:b0:314:af71:b38a with SMTP id
 o22-20020a02a1d6000000b00314af71b38amr323871jah.95.1645147280047; Thu, 17 Feb
 2022 17:21:20 -0800 (PST)
Date:   Thu, 17 Feb 2022 17:21:20 -0800
In-Reply-To: <00000000000070ac6505d7d9f7a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b07b305d840b30f@google.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
From:   syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
To:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f71077a4d84b Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104c04ca700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1362e232700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11373a6c700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at drivers/vhost/vhost.c:2335!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3597 Comm: vhost-3596 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vhost_get_vq_desc+0x1d43/0x22c0 drivers/vhost/vhost.c:2335
Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 b7 59 28 fd e9 74 ff ff ff e8 5d c8 a1 fa <0f> 0b e8 56 c8 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90001d1fb88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880234b0000 RSI: ffffffff86d715c3 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff86d706bc R11: 0000000000000000 R12: ffff888072c24d68
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888072c24bb0
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 000000007902c000 CR4: 00000000003506e0
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
RSP: 0018:ffffc90001d1fb88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880234b0000 RSI: ffffffff86d715c3 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff86d706bc R11: 0000000000000000 R12: ffff888072c24d68
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888072c24bb0
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 000000007902c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

