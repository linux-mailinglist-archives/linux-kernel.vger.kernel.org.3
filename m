Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D53557C97A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiGULCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiGULCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:02:17 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997FF8149A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:02:16 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id q129-20020a6b8e87000000b0067bd5d1cb57so311459iod.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=M8ZizpHpfrGSxQiIYqy1DmxQ+15fCaCZe+0mIGksBFM=;
        b=00bz93PQqwlmNbKjofzEKT5JCvn437wt7p/LnCadgoSkWP27axKjzTdrenotNTMheU
         nqfSQXKbN8DEYHEa96TY4paDmv3VT0veVAL6jSJqNCom0KFhRM0nIeuuFZHb1Y/l/FpO
         hYtDDIy+E382WVpjAkra9/MoDshR92ekTbfmv9vufNVRW6hoZgbiABMLwFYu0QSRb0KK
         mO3Cje33ljjEBJulZikxmymGPYC9JfUPkANvUm2k0fiG87RLnvBKio9+X+fqy6V0iQGP
         vRB9cSropQ2ZlHgxTEMgRqhUBCSwDzpmaQfthEM2t/sOXqp/qyIOiFgiDPK55rC/sPOu
         Jwlg==
X-Gm-Message-State: AJIora9fwXkhRtVIHmweKfQ90KywRbZj2gCaKQW9Y/x7Q7n/Q18UP4s4
        7ljSwYaM1xuDJ1m+9rGjvP/uHoKXPUEhKZVMdWj/AnlePpbs
X-Google-Smtp-Source: AGRyM1sLTRhFVHk5Kql2pVEaT9ApbDbC16t1EUA7NhuhptQJ1sDHxu8jlGwS6bgCj4WMPI1VHiLQdZEPAajn6kgxmiTB/Sqlw8Bc
MIME-Version: 1.0
X-Received: by 2002:a92:6f0a:0:b0:2d9:24b5:9401 with SMTP id
 k10-20020a926f0a000000b002d924b59401mr19811523ilc.89.1658401335873; Thu, 21
 Jul 2022 04:02:15 -0700 (PDT)
Date:   Thu, 21 Jul 2022 04:02:15 -0700
In-Reply-To: <20220721104919.1900-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008518a505e44ea6a6@google.com>
Subject: Re: [syzbot] WARNING: still has locks held in tls_rx_reader_lock
From:   syzbot <syzbot+16e72110feb2b653ef27@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in tls_rx_reader_unlock

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4109 at net/tls/tls_sw.c:1840 tls_rx_reader_unlock+0x140/0x1c0 net/tls/tls_sw.c:1840
Modules linked in:
CPU: 1 PID: 4109 Comm: syz-executor.0 Not tainted 5.19.0-rc6-syzkaller-01454-ge22c88799f26-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:tls_rx_reader_unlock+0x140/0x1c0 net/tls/tls_sw.c:1840
Code: 0f b6 04 02 84 c0 74 02 7e 41 44 0f b6 ab 40 02 00 00 31 ff 44 89 ee e8 fe 12 79 f9 45 84 ed 0f 85 23 ff ff ff e8 f0 16 79 f9 <0f> 0b e9 17 ff ff ff 4c 89 ef e8 91 64 c6 f9 e9 eb fe ff ff 48 89
RSP: 0018:ffffc9000334f9b8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807c3d4000 RCX: 0000000000000000
RDX: ffff88807bfc3b00 RSI: ffffffff88015a50 RDI: 0000000000000001
RBP: ffff88807c3d4240 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000008a07a R12: ffff88807e6c2640
R13: 0000000000000000 R14: ffff88807c3d4000 R15: 0000000000000000
FS:  00007f1c67eb0700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c67eb0718 CR3: 000000006f5ed000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tls_sw_recvmsg+0x62b/0x1c20 net/tls/tls_sw.c:2063
 inet6_recvmsg+0x115/0x5e0 net/ipv6/af_inet6.c:672
 sock_recvmsg_nosec net/socket.c:995 [inline]
 sock_recvmsg net/socket.c:1013 [inline]
 sock_recvmsg net/socket.c:1009 [inline]
 sock_read_iter+0x337/0x470 net/socket.c:1086
 call_read_iter include/linux/fs.h:2052 [inline]
 new_sync_read+0x4f9/0x5f0 fs/read_write.c:401
 vfs_read+0x492/0x5d0 fs/read_write.c:482
 ksys_read+0x1e8/0x250 fs/read_write.c:620
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1c66c89199
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1c67eb0168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f1c66d9c030 RCX: 00007f1c66c89199
RDX: 00000000000000c1 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f1c66ce313b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff352268cf R14: 00007f1c67eb0300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         e22c8879 Merge branch '100GbE' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16c9eaac080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c46ba1483fd8356
dashboard link: https://syzkaller.appspot.com/bug?extid=16e72110feb2b653ef27
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1644ab8c080000

