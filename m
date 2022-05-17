Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE052AE48
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiEQWtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiEQWtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:49:08 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2B953708
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:49:07 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id e10-20020a056602158a00b0065a9bede1c4so13317411iow.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=C5tbz7L6ZC70ZmPXy4SlO57rkraDyi8Sv2/GOu0X9Y8=;
        b=bZYlujERcH5tlev35PJUesL4N3R9nXA8z9w7fEJVPq4je5hn6mE6OYolgmcJHCZSa2
         xqCgEkD3cXgJaJGcXOXTw4XAWWcG39Nuz6ebeW+UyeA1yd2vtcbNVcruBD7CJYwbE/Qk
         oNIsQURXNEcHF94+MQxV9gCSPXKENP5fP5hHwCDDMfL8TKrqs8sZ4KT2wAarrcSOGJND
         A2hjjO2hjFpHH8RXVDZUi+BVMFoWJtFIhALMd/cSuH8fXPErzlbuo3awBKXQhPGmJj/d
         4b4q5m5oaDGmeTS3/GO5LybdmwXaTSsBih7ld1ovQZ0ccOsQcXlqRIIdH+jGZi+I4KU9
         FDWQ==
X-Gm-Message-State: AOAM533E1NSUFk7K75t3kARrNq0JZKDG2r7caamQGaciyK6aXTOObZU/
        F3NPxvl08RtoXmjL5OmtVpBJ3TEhOKHhQa9vFcJGhx7viWl7
X-Google-Smtp-Source: ABdhPJxFO+q1ewwiIRLvzkMe9aIdaCrUmRb2JUBOui2twRMZ1GON+O9rfQVoP+zSaZmpMx2GTlmsDVDf3dv30O98d3pItYjgt0Rt
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a8:b0:32b:5d5c:7f9d with SMTP id
 w40-20020a05663837a800b0032b5d5c7f9dmr13422573jal.3.1652827747134; Tue, 17
 May 2022 15:49:07 -0700 (PDT)
Date:   Tue, 17 May 2022 15:49:07 -0700
In-Reply-To: <20220517223806.2299-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be329205df3cf252@google.com>
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
WARNING: CPU: 1 PID: 4486 at fs/namespace.c:1285 mntput_no_expire+0x985/0xfe0 fs/namespace.c:1285
Modules linked in:

CPU: 1 PID: 4486 Comm: syz-executor.3 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0x985/0xfe0 fs/namespace.c:1285
Code: 00 00 00 bf 08 00 00 00 48 c7 c2 60 fe f0 8b e8 91 0b 72 ff e9 01 f9 ff ff e8 d7 bd 9d ff 0f 0b e9 b6 f8 ff ff e8 cb bd 9d ff <0f> 0b e9 aa f8 ff ff e8 bf bd 9d ff e8 aa dd 91 07 31 ff 89 c3 89
RSP: 0018:ffffc90004857d78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: ffff888018b80000 RSI: ffffffff81db8365 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81db7c0e R11: 0000000000000000 R12: 0000000000000002
R13: ffff88801d671e00 R14: dffffc0000000000 R15: ffffed1003ace3ca
FS:  0000555555fbb400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556f3e848 CR3: 000000001f615000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mntput+0x67/0x90 fs/namespace.c:1347
 __fput+0x3ba/0x9d0 fs/file_table.c:333
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3b7a03bd2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffe9eb268b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f3b7a03bd2b
RDX: 0000001b2ff20000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f3b7a19d960 R08: 0000000000000000 R09: 00007ffe9ebbf080
R10: 00007ffe9ebbf090 R11: 0000000000000293 R12: 00000000000181f5
R13: 00007ffe9eb269b0 R14: 00007ffe9eb269d0 R15: 0000000000000032
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=15ee4759f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1108ae3af00000

