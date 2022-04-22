Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4B550ACC3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389015AbiDVA2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiDVA2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:28:10 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D43E012
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:25:18 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id j4-20020a92c204000000b002caad37af3fso3508024ilo.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gFC7W2s6oSubrSu0fyNGzhidvpEcSg46xUzNZTApaeo=;
        b=Pl40VNUcJ2Olum8qA5pRzNKuJuH4Lzuah7W+YTBpyssPiC5UkUhaVVyVJ8exeLzJlC
         SsXUA8IsqEs5t5oC2D8CLGRCMA3hD6WgNuIrD1sSF65qTFW/ZIgMSYPron/iu+g5pFxI
         d60HRX7fVcVQao7fKHgUbrSFakSMdc5VAOIt2++0eWJx2rMLYhqTC4I+Q/R4t7u0OaKq
         6BU4HFvVt/nEWviAksx2usXrL3ehPoiWx0lgHmlVQqzfXkh03UA3zj3YrzjsiHAJCqeB
         ZfuSPNwgZZ7yJsVVXs0p2C+ihVFnP83vz5E1d/S7aMNc1z8I46zsQEtP9NuJO9MqYeB8
         T55A==
X-Gm-Message-State: AOAM533ZVZ91QiHdDWSbFfRoVUglenz8wr2UjHlr9jGboDqMUIYcKJ7c
        7E2i2Wn4EbSOVdlkR84NTOJuTPl0HdqbKFQAn4p5hJBNziLH
X-Google-Smtp-Source: ABdhPJx/2viaval3/ZhAHpFIqYJYvjfyU84RgvwvpNdj7J5HUdwQZ0WJ6Ia951WwSakArsGuqhFvt6ihOTquDPliyWvSC3mr0JSL
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1409:b0:5e7:487:133c with SMTP id
 t9-20020a056602140900b005e70487133cmr921327iov.196.1650587118290; Thu, 21 Apr
 2022 17:25:18 -0700 (PDT)
Date:   Thu, 21 Apr 2022 17:25:18 -0700
In-Reply-To: <20220422001413.2515-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db4b1e05dd334209@google.com>
Subject: Re: [syzbot] kernel BUG in __filemap_get_folio
From:   syzbot <syzbot+cf4cf13056f85dec2c40@syzkaller.appspotmail.com>
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
kernel BUG in __filemap_get_folio

 shrink_dcache_parent+0x1fe/0x3c0 fs/dcache.c:1628
 do_one_tree fs/dcache.c:1682 [inline]
 shrink_dcache_for_umount+0x71/0x330 fs/dcache.c:1699
 generic_shutdown_super+0x68/0x400 fs/super.c:444
 kill_anon_super fs/super.c:1056 [inline]
 kill_litter_super+0x6e/0xa0 fs/super.c:1065
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1974!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4274 Comm: syz-executor.1 Not tainted 5.18.0-rc3-syzkaller-00007-g559089e0a93d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__filemap_get_folio+0xc2b/0x1290 mm/filemap.c:1974
Code: 0b f6 d8 ff 31 ff 89 ee e8 e2 f9 d8 ff 40 84 ed 0f 85 54 f8 ff ff e8 f4 f5 d8 ff 48 c7 c6 80 d9 d5 89 48 89 df e8 35 91 0e 00 <0f> 0b 44 8b 6c 24 10 31 db 45 31 f6 e9 05 f6 ff ff 44 8b 6c 24 10
RSP: 0018:ffffc90003ab78b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea00018c8500 RCX: 0000000000000000
RDX: ffff8880738f8280 RSI: ffffffff819f582b RDI: 0000000000000003
RBP: 0000000000000000 R08: 000000000000001c R09: 00000000ffffffff
R10: ffffffff891d5eec R11: 00000000ffffffff R12: 00000000000001c0
R13: 0000000000000182 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f1719c18700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b2bd6c058 CR3: 00000000775ab000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pagecache_get_page+0x2e/0x290 mm/folio-compat.c:126
 shmem_getpage_gfp+0x471/0x2370 mm/shmem.c:1812
 shmem_getpage mm/shmem.c:149 [inline]
 shmem_write_begin+0xff/0x1e0 mm/shmem.c:2446
 generic_perform_write+0x249/0x560 mm/filemap.c:3790
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3918
 generic_file_write_iter+0xd7/0x220 mm/filemap.c:3950
 call_write_iter include/linux/fs.h:2050 [inline]
 new_sync_write+0x38a/0x560 fs/read_write.c:504
 vfs_write+0x7c0/0xac0 fs/read_write.c:591
 ksys_write+0x127/0x250 fs/read_write.c:644
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1718a890e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1719c18168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1718b9bf60 RCX: 00007f1718a890e9
RDX: 000000000208e24b RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007f1718ae308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd921fc6af R14: 00007f1719c18300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__filemap_get_folio+0xc2b/0x1290 mm/filemap.c:1974
Code: 0b f6 d8 ff 31 ff 89 ee e8 e2 f9 d8 ff 40 84 ed 0f 85 54 f8 ff ff e8 f4 f5 d8 ff 48 c7 c6 80 d9 d5 89 48 89 df e8 35 91 0e 00 <0f> 0b 44 8b 6c 24 10 31 db 45 31 f6 e9 05 f6 ff ff 44 8b 6c 24 10
RSP: 0018:ffffc90003ab78b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea00018c8500 RCX: 0000000000000000
RDX: ffff8880738f8280 RSI: ffffffff819f582b RDI: 0000000000000003
RBP: 0000000000000000 R08: 000000000000001c R09: 00000000ffffffff
R10: ffffffff891d5eec R11: 00000000ffffffff R12: 00000000000001c0
R13: 0000000000000182 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f1719c18700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb799b6c058 CR3: 00000000775ab000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         559089e0 vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLO..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=17daede8f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd7c9a79dfcfa205
dashboard link: https://syzkaller.appspot.com/bug?extid=cf4cf13056f85dec2c40
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e90f84f00000

