Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D675270E2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiENL7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 07:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiENL7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 07:59:12 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F8493
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:59:10 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id g11-20020a056e021a2b00b002cf48b48824so6197692ile.21
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IyoNlAKbF13TqKxWU7SrUTKrE/pWtgxFJ/3Qj3qti3Y=;
        b=7ePmOfURb4W9cR+hhzQt9jgOxTGrL7q+9HyyROGu2r7XXpOWTuDYImyhPSAhoaB0lN
         ja27DSYqZTHouZRGeObvyjfjXodIz75IOvgXRFOqDBVnLkMRUAVU9GqHBIJsHqdpYlHv
         Cg9pbT5bUrxmby9LLwRuidt5e3UyVuTcmgsKmW6Rr4ITEaCJwKuNzfG3okRQJRTYpn5W
         b1ggPWyRi3sp/5v5A9H+eOXV3u+idA9MDN2hTYALSlqHvGg/oxs+a1ty3Xl3xiIOZ2kn
         WipQ+Lsz4FgzHaJD+NEsp8MhhnlT3hZmnSOxjc05uibxIIYNnshXOPoSYBT79zanib+P
         /cqg==
X-Gm-Message-State: AOAM5300VKfWAcQgBrgk1+1gGx1XdsMq9dv//fWNx9uuAkRQJlAdLa24
        wXEXIA4RHuT2V4NmQ08HnYv/6z69ZPZ4E4V8msisJW2lJhEN
X-Google-Smtp-Source: ABdhPJwltmcUTIqaiMQO74PSKdZjmCJpv6DMcSYFvtXuaGoERRlD+HHYocclGVh2lADJmVTyalILq3pFAK/KQSZuNIjGvSF6xu1I
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b8a:b0:2cf:7255:d2d0 with SMTP id
 h10-20020a056e021b8a00b002cf7255d2d0mr4834783ili.142.1652529549540; Sat, 14
 May 2022 04:59:09 -0700 (PDT)
Date:   Sat, 14 May 2022 04:59:09 -0700
In-Reply-To: <20220514114718.1254-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c803b305def78496@google.com>
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
WARNING: CPU: 0 PID: 4445 at fs/namespace.c:1226 mntput_no_expire+0x985/0xfe0 fs/namespace.c:1226
Modules linked in:

CPU: 0 PID: 4445 Comm: syz-executor.3 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0x985/0xfe0 fs/namespace.c:1226
Code: 00 00 00 bf 08 00 00 00 48 c7 c2 60 fe f0 8b e8 51 e1 71 ff e9 01 f9 ff ff e8 47 93 9d ff 0f 0b e9 b6 f8 ff ff e8 3b 93 9d ff <0f> 0b e9 aa f8 ff ff e8 2f 93 9d ff e8 6a a3 91 07 31 ff 89 c3 89
RSP: 0018:ffffc9000459fd78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: ffff8880220f3b00 RSI: ffffffff81dbada5 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81dba64e R11: 0000000000000000 R12: 0000000000000002
R13: ffff88807bd12900 R14: dffffc0000000000 R15: ffffed100f7a252a
FS:  0000555555d3b400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd780a50a0 CR3: 000000007cff9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mntput+0x67/0x90 fs/namespace.c:1288
 __fput+0x3ba/0x9d0 fs/file_table.c:333
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f59ef83bd2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffdc9489d50 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f59ef83bd2b
RDX: 0000001b31020000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f59ef99d960 R08: 0000000000000000 R09: 00007ffdc9495080
R10: 00007ffdc9495090 R11: 0000000000000293 R12: 0000000000016fbc
R13: 00007ffdc9489e50 R14: 00007ffdc9489e70 R15: 0000000000000032
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1794b83af00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10404456f00000

