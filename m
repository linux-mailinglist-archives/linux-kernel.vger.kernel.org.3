Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0482F52674F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382441AbiEMQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiEMQn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:43:26 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE941115A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:43:24 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id j4-20020a92c204000000b002caad37af3fso5471051ilo.22
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0W9T2wystivB2OujRrEIfS0+3KCHZDuoJ2h6yVrcIaw=;
        b=tiJ/z4bcaNezMnB9zkAvWjA62anmf9l+F2CZu12tjerOqBQKIoBu7ss67KkNaoxPZC
         35WduTei4Nua+1W7vEMMgF+ZQLPBmACDN6uM8+byD6CGLk3EwWPH8HYbgeluWGNIh2E7
         SbljcCU5nNVySrxjq859+VY6PShtQVsq+Nbx4ahxPAWzdpD4S3MMNztP70bGaS+m5DBb
         3VNDrmkyyeisl1/JeO/TLoac2e6McK3u0MudAyu9XUu8Q8uYPwlGZw2m73TAO/Wp9wDi
         Gfw3+0YeaOHrCQt4Agp1PBnjdAV+RuehJleAWe8CFqygfPEkF/ZZ9jKYzGiP2TDf9gqx
         CfCA==
X-Gm-Message-State: AOAM5319MEZ1mB0sjTBkRvoa2b7rTc/mvJfFUGrg2LD0vEPMi07horxi
        GeQG0yb56QezpL7xMK1VXd8mJ1OpPGJ1aSMIYoKTIZL0eoyK
X-Google-Smtp-Source: ABdhPJwnFkntrZUNqSgr3xZJpvd9eZDjD6KwXQq2Hw1vd6eConHGW9+H3PUEkKcpyrwhCyVoW9RaMWKM/rWsHJDmdqvdBMYe++av
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2243:b0:657:c8eb:dc44 with SMTP id
 o3-20020a056602224300b00657c8ebdc44mr2606190ioo.145.1652460204012; Fri, 13
 May 2022 09:43:24 -0700 (PDT)
Date:   Fri, 13 May 2022 09:43:24 -0700
In-Reply-To: <000000000000ef451a05dee0f2b1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077377c05dee75f63@google.com>
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
From:   syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=174ae715f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
dashboard link: https://syzkaller.appspot.com/bug?extid=acf65ca584991f3cc447
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11531766f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce5a9ef00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3611 at mm/hugetlb.c:6250 follow_hugetlb_page+0x1326/0x1c80 mm/hugetlb.c:6250
Modules linked in:
CPU: 1 PID: 3611 Comm: syz-executor603 Not tainted 5.18.0-rc6-next-20220513-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:follow_hugetlb_page+0x1326/0x1c80 mm/hugetlb.c:6250
Code: 89 44 24 70 e8 2b 1d b7 ff 48 8b 44 24 70 48 85 c0 0f 84 f1 07 00 00 e8 88 1a b7 ff 48 83 ed 01 e9 09 fb ff ff e8 7a 1a b7 ff <0f> 0b 48 8b 7c 24 30 bb f4 ff ff ff e8 69 74 b8 07 4c 8b a4 24 b8
RSP: 0018:ffffc90002f6f7e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801bdd4e00 RCX: 0000000000000000
RDX: ffff88801e4e3a80 RSI: ffffffff81c38f76 RDI: 0000000000000003
RBP: ffffea0001fe8680 R08: 0000000000000000 R09: 0000000000000003
R10: ffffffff81b128fb R11: 0000000000000008 R12: 000000000000001a
R13: ffff88801bdd4e00 R14: ffff88801bdd5600 R15: 0000000000000019
FS:  0000555556ad2300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000458 CR3: 000000001e850000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __get_user_pages+0x27a/0xfa0 mm/gup.c:1146
 __get_user_pages_locked mm/gup.c:1365 [inline]
 __gup_longterm_locked+0x1d5/0xfe0 mm/gup.c:1985
 pin_user_pages+0x8e/0xe0 mm/gup.c:3118
 io_sqe_buffer_register+0x254/0x1710 fs/io_uring.c:10537
 io_sqe_buffers_register.cold+0x28e/0x443 fs/io_uring.c:10664
 __io_uring_register fs/io_uring.c:12682 [inline]
 __do_sys_io_uring_register+0xd21/0x1930 fs/io_uring.c:12816
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f5f42760cc9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffc3407aa8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f5f42760cc9
RDX: 0000000020000380 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f5f42724e70 R08: 0000000010000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f5f42724f00
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

