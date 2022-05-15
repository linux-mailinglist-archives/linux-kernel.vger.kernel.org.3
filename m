Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2825277DC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 15:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiEONoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbiEONmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 09:42:11 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC222BEF
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 06:42:10 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id s129-20020a6b2c87000000b00657c1a3b52fso8597087ios.21
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 06:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1ru3926cFJy1q+zyH9RAiMupcjPm+Vd42xBJWFMU7ZQ=;
        b=ZQZbAqtiPKntWBHwi4xy/IAJOK3oQvYuhisVH1eD4eNyz8w3C+JG/ERX9plKGN7rxP
         Lem6ATB+aGjRkDad32VpvkL4HpS5YAPCkQkYNzZoI85n3uOOG/Kjro/QfeCuO1foCLri
         JNTcdt2Kv/TlJlazVWTEVoogwADonmsiUlwv9tVjRJN7wkJxEhGDKYKyYNA8PSa/xTAa
         SNX0o+t4IV6s9OTGnzDQpYIK2XAj/YTgpwIbbiHorX00pMOBimHbigBQ7pIMYhHZCCX8
         cI2HLtUgu5Wkr92lfm2JbH1MKz0234jj/E5UPku+N/UuwxjWyCVt4+Hgc+SZpAP+tf41
         eA8w==
X-Gm-Message-State: AOAM530GOGPmWafRN+c2/lnOoQHq8MXhXJDpXTiGazVhrK+VMPuyfle/
        uit2x2e/chzfBb6uxc3ItqGssu16GrGlEx65uI3JNBqlkXWJ
X-Google-Smtp-Source: ABdhPJwehSqd/WHDAuVRDTV+r1zqvaZoWZqU4ocMxflpuOnjMdIxro9nVX4L7L3kflbSSAN3J7/WHzKazjoXTSmkAb6F28ffPk7+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12eb:b0:2cf:541:f51b with SMTP id
 l11-20020a056e0212eb00b002cf0541f51bmr6692512iln.173.1652622129378; Sun, 15
 May 2022 06:42:09 -0700 (PDT)
Date:   Sun, 15 May 2022 06:42:09 -0700
In-Reply-To: <20220515133111.1864-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f83aa705df0d12b2@google.com>
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
WARNING in cleanup_mnt

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4044 at fs/namespace.c:1177 cleanup_mnt+0x416/0x540 fs/namespace.c:1177
Modules linked in:

CPU: 1 PID: 4044 Comm: syz-executor.0 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:cleanup_mnt+0x416/0x540 fs/namespace.c:1177
Code: 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 f1 9f 89 ff e8 5c b3 9d ff 48 89 df e8 84 52 06 00 e9 40 fd ff ff e8 4a b3 9d ff <0f> 0b e9 ff fc ff ff e8 2e 44 e9 ff eb ab 48 c7 c7 a0 26 b9 8d e8
RSP: 0018:ffffc900031efe78 EFLAGS: 00010293

RAX: 0000000000000000 RBX: ffff88814013dc80 RCX: 0000000000000000
RDX: ffff888073a85880 RSI: ffffffff81db8d96 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81db8a93 R11: 0000000000000001 R12: 00000000ffffffff
R13: 0000000000000002 R14: dffffc0000000000 R15: ffffed1028027b9a
FS:  0000555556e94400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4df11a0000 CR3: 000000007054d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f832748a557
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0b9d39f8 EFLAGS: 00000246
 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f832748a557
RDX: 00007ffc0b9d3ac9 RSI: 000000000000000a RDI: 00007ffc0b9d3ac0
RBP: 00007ffc0b9d3ac0 R08: 00000000ffffffff R09: 00007ffc0b9d3890
R10: 0000555556e958b3 R11: 0000000000000246 R12: 00007f83274e21f8
R13: 00007ffc0b9d4b80 R14: 0000555556e95810 R15: 00007ffc0b9d4bc0
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=17d119aef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ab09a5f00000

