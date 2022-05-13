Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7525265BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380996AbiEMPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353237AbiEMPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:14:12 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EEA53A60
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:14:09 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id f18-20020a926a12000000b002be48b02bc6so5336093ilc.17
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FOqCJn0Yov0q58rXnm48akgDZDwyOP3b7PJ5BxMMdjg=;
        b=eNB0vwOwF1cyN1eGm7jJY7OwnWW/iw94Dq4u8c/6CXLR58W0XFKRqHq5ov3n+Rz92w
         yKOIv+NtDRiLvo1J1uxNA9VJgM3nm4+vACw+nFVTgAy1CFmwwFkgMHXqhrBk5qVefz/d
         n6OOYUpcKTlpvrmjyxAVuf11UbA47O66aFtRMalMnX59E/DkLh33/pJO3r3TBa/SKXe3
         cvDQD3vmg4538sQkp07aH9jNRU/lUVl1YiXSUDemyMZRZKFjK7OomqjhKmAWP/cG6mDJ
         O6bp8R3pWb1W+OtlC2rOXWuehLm/nA/mtT2nPNLaYAS+GHVgKV9Pzxzscwq2L/nMp0g1
         1KrA==
X-Gm-Message-State: AOAM530zTHvFxcQLwYM5OMLyrsJeUDyLXIvz7cDdsMkvFMrheCRPh+xn
        80lpGuyu7U8q6H7stcF8nHwByPUuP1bXsxdqnj7x3VDgqKZv
X-Google-Smtp-Source: ABdhPJzhWa1+RD/fyQPBsDgM5d78Nxr8JK7g6tZkYsrz13+5efR398/fyVDpZk4sSR+Gv/QUn3mFotLLdEeEuo0mggSCoaxxZs5o
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ed:b0:2d0:fe2b:6d24 with SMTP id
 w13-20020a056e0213ed00b002d0fe2b6d24mr1232043ilj.97.1652454849327; Fri, 13
 May 2022 08:14:09 -0700 (PDT)
Date:   Fri, 13 May 2022 08:14:09 -0700
In-Reply-To: <20220513144536.279-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d422905dee62081@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
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
WARNING in mntput_no_expire

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4063 at fs/namespace.c:1232 mntput_no_expire+0xb02/0xfe0 fs/namespace.c:1232
Modules linked in:
CPU: 0 PID: 4063 Comm: syz-executor.4 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0xb02/0xfe0 fs/namespace.c:1232
Code: 00 48 c7 c7 80 16 db 89 c6 05 c3 c9 c8 0b 01 e8 19 58 4d 07 e9 57 ff ff ff e8 2a bf 9d ff 0f 0b e9 df f9 ff ff e8 1e bf 9d ff <0f> 0b e9 d3 f9 ff ff e8 12 bf 9d ff e8 9d b9 88 ff 31 ff 89 c3 89
RSP: 0018:ffffc9000335fc38 EFLAGS: 00010293

RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88806e651d80 RSI: ffffffff81db81c2 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: ffffffff9006e94f
R10: ffffffff81db7b7e R11: 0000000000000001 R12: ffffc9000335fc88
R13: ffff88801a842300 R14: 0000000000000002 R15: dffffc0000000000
FS:  0000555557159400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f18cda11280 CR3: 0000000077f04000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mntput fs/namespace.c:1288 [inline]
 namespace_unlock+0x3ee/0x410 fs/namespace.c:1507
 do_umount fs/namespace.c:1726 [inline]
 path_umount+0x797/0x1260 fs/namespace.c:1808
 ksys_umount fs/namespace.c:1831 [inline]
 __do_sys_umount fs/namespace.c:1836 [inline]
 __se_sys_umount fs/namespace.c:1834 [inline]
 __x64_sys_umount+0x159/0x180 fs/namespace.c:1834
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff9a7c8a557
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe33a40f28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff9a7c8a557
RDX: 00007ffe33a40ff9 RSI: 000000000000000a RDI: 00007ffe33a40ff0
RBP: 00007ffe33a40ff0 R08: 00000000ffffffff R09: 00007ffe33a40dc0
R10: 000055555715a8b3 R11: 0000000000000246 R12: 00007ff9a7ce21f8
R13: 00007ffe33a420b0 R14: 000055555715a810 R15: 00007ffe33a420f0
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=14be78aef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10db8f71f00000

