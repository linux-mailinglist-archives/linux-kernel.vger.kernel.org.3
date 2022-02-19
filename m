Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7E4BC878
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 14:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiBSNBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 08:01:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiBSNB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 08:01:29 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BA31FFF7F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 05:01:11 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id b22-20020a6b6716000000b0064070ce7b49so4228281ioc.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 05:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Fl+5n1jjz3m84AqaKPaTylYfodG3ttae4QcHqpR94z0=;
        b=GYE4HJsU3pKB4jvVOPZqqA3vqbtJVpOvUmzrPtYB2l3Je75ccQcbwItvluzKBh5HvE
         eYacyoD6D9CjwaE81mxJKptLatpdp0M8PcgVY2QzR/uxTFD2LN3HSOQ2VoNTjZ2n2GBj
         MGFyctscVpwS1qtmuovDNyxEIeMkAEqmCZ/EIXAtEA43LVkjjhx9xmBbrC4/cYpe0LRA
         T1dpwVeYCF6vg+w+N/hRtETsSC1xn/SQJz9jOP4sswPtH89WfHztq4NgI9QAimDI6bJc
         vj68wmLYD8+AQ3+Q4/tQg3p2an7G8rePU5rHH0bF0HfHV9M/wdft89/ukgLQ+GXyZf25
         qgpg==
X-Gm-Message-State: AOAM533GGk0jIzkcMYfU94i1IA4LBk5YtQdc2l4K5gm0MoelVAAJggHA
        xReYCMqYrUOee7re+nuFcvHqmCJxKSbmc+8uiirYORwUxdq3
X-Google-Smtp-Source: ABdhPJwXgfsqVH95fQpRwUN9c0iKCYH2k3ZDXnelYs+gRCiFjS1ehvyyeQAsO7CS5n8ALAaCnJ8cpDaydi+pMUBdcxMJmnoHjKH6
MIME-Version: 1.0
X-Received: by 2002:a6b:117:0:b0:634:4788:28e1 with SMTP id
 23-20020a6b0117000000b00634478828e1mr9024537iob.72.1645275670473; Sat, 19 Feb
 2022 05:01:10 -0800 (PST)
Date:   Sat, 19 Feb 2022 05:01:10 -0800
In-Reply-To: <20220219125100.835-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5720605d85e97d7@google.com>
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
kernel BUG at drivers/vhost/vhost.c:2338!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4071 Comm: vhost-4070 Not tainted 5.17.0-rc4-syzkaller-00054-gf71077a4d84b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vhost_get_vq_desc+0x1dc5/0x2350 drivers/vhost/vhost.c:2338
Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 25 59 28 fd e9 74 ff ff ff e8 cb c7 a1 fa <0f> 0b e8 c4 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc900028bfb78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801cbd1d00 RSI: ffffffff86d71655 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff86d7072d R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88806ffc4bb0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 000000001d077000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vhost_vsock_handle_tx_kick+0x277/0xa20 drivers/vhost/vsock.c:522
 vhost_worker+0x2e9/0x3e0 drivers/vhost/vhost.c:374
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vhost_get_vq_desc+0x1dc5/0x2350 drivers/vhost/vhost.c:2338
Code: 00 00 00 48 c7 c6 20 2c 9d 8a 48 c7 c7 98 a6 8e 8d 48 89 ca 48 c1 e1 04 48 01 d9 e8 25 59 28 fd e9 74 ff ff ff e8 cb c7 a1 fa <0f> 0b e8 c4 c7 a1 fa 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc900028bfb78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801cbd1d00 RSI: ffffffff86d71655 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff86d7072d R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88806ffc4bb0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc7293991d0 CR3: 000000001d077000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=11e82d7a700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11857326700000

