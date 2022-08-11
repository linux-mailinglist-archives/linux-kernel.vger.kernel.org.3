Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A6F58F6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiHKE2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiHKE2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:28:10 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AAD2A721
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:28:08 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id v20-20020a5ec114000000b00682428f8d31so9058514iol.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=1fG6vnw/OOzyw9CFKDsXSOWOXHtvCj5eOaEAMYM3v6E=;
        b=QqkAosOIZ7DlYz2AcQH2dsFfg4X7b2DFtu/NpQgxtM4RVcXrRtgyv4x0ueMeCfFP3y
         0U5xu6j6oWH2II0eSN3vB+I68//ahB3e/IHbNFhqwV5yOehsB+0Qr5Ql8p5KghxMSZ07
         3aUgxbMljxXrW4+05SD+goG5OrpcF1sbPkaC/slUTpHUR2Z+H7IKbfTSXq/WwcXrACI2
         nDrg9w93EyJp5TH5jFdebiYX1JPgKKzXlVwHNFyv6lvYJqAsr6iO8/dN3me07EtzEgd6
         Q75CPzOhjt4KIVGRYCL5gcfHzJtTdyK5cgKDzdWUnGNq8dyBywmo25moKKrP5LUztCKL
         EB2Q==
X-Gm-Message-State: ACgBeo1k7OLhpBWGZnn4sTIl0hOOzmt17Z0DPDRLlf8a+iqgBAjcNXer
        6CimdoQXo5oVo29zTxTtQg2mrM4HuuH4sEI+no3QYtvbKPvs
X-Google-Smtp-Source: AA6agR5F7iEntHJQWaW4AoXqRlJTPJFVIA22olt5THQjR+jd5WWqoIYcnkeSwiuj1F3XEfFYo74RvYhiSWPlQDB/DbR/zN1yrOoL
MIME-Version: 1.0
X-Received: by 2002:a05:6638:478b:b0:342:7afd:8206 with SMTP id
 cq11-20020a056638478b00b003427afd8206mr14659827jab.181.1660192087662; Wed, 10
 Aug 2022 21:28:07 -0700 (PDT)
Date:   Wed, 10 Aug 2022 21:28:07 -0700
In-Reply-To: <20220810221908.2686-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4e68605e5ef97f4@google.com>
Subject: Re: [syzbot] INFO: task hung in __generic_file_fsync (3)
From:   syzbot <syzbot+ed920a72fd23eb735158@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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
WARNING in inode_dio_wait

------------[ cut here ]------------
__inode_dio_wait schedule_timeout(30 * HZ) timeout
WARNING: CPU: 1 PID: 4223 at fs/inode.c:2381 __inode_dio_wait fs/inode.c:2381 [inline]
WARNING: CPU: 1 PID: 4223 at fs/inode.c:2381 inode_dio_wait+0x28c/0x2e0 fs/inode.c:2400
Modules linked in:
CPU: 1 PID: 4223 Comm: syz-executor.2 Not tainted 5.19.0-syzkaller-02972-g200e340f2196-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__inode_dio_wait fs/inode.c:2381 [inline]
RIP: 0010:inode_dio_wait+0x28c/0x2e0 fs/inode.c:2400
Code: 9d ff 45 84 ed 0f 85 2b ff ff ff e8 7e de 9d ff 48 c7 c6 a0 bb db 89 48 c7 c7 a0 b3 db 89 c6 05 8c 38 ca 0b 01 e8 85 f3 55 07 <0f> 0b e9 05 ff ff ff e8 58 de 9d ff 4c 89 fe 4c 89 f7 e8 1d 57 7e
RSP: 0018:ffffc90003aafc30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88806a005ff0 RCX: 0000000000000000
RDX: ffff88801c5f5880 RSI: ffffffff81611718 RDI: fffff52000755f78
RBP: ffff88806a0061fc R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000007
R13: 0000000000000000 R14: ffffffff8ba0dce0 R15: ffffc90003aafc78
FS:  00007f7e298af700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dd6735d848 CR3: 0000000020d2b000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 fat_setattr+0x3de/0x13c0 fs/fat/file.c:509
 notify_change+0xcd0/0x1440 fs/attr.c:418
 do_truncate+0x13c/0x200 fs/open.c:65
 do_sys_ftruncate+0x536/0x730 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7e28689209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7e298af168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f7e2879bf60 RCX: 00007f7e28689209
RDX: 0000000000000000 RSI: 00000000010099b8 RDI: 0000000000000004
RBP: 00007f7e286e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff0662fb6f R14: 00007f7e298af300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         200e340f Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15dbd773080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fd97bb080000

