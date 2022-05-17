Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184E752A080
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbiEQLfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiEQLfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:35:11 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2C72717E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:35:10 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l13-20020a056e0212ed00b002d07cd1db63so7642684iln.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FkY6wA5Kc8BpmjekXlBJGuJOJHx9rxAyEBHBHuyzTL8=;
        b=TTYrejGhWfE17IKyUjC8aAGCRW+ZYq6uq55HWxvWj4MXP1JzHL9NFNqRr16VrMADmY
         F5w3MPr3fkx7NJ0t0qm6PhP+2jxoRUxGcBCNv4kAIY37f158RRdZPd6t1/0PU1TvVeW2
         OtHwCTxcd4G4EBuC8URK1kTFSO+3p6ipoCYJnEUhgSXaLbQU47bUKMDrGSpN+XF6MkuZ
         sUpSUXVVVd6ny7QLvVKNrAAeIwv7swJ8/lgq+ZmeR648ZHQ4XgegzMWSq4zQwHI9KIor
         raGmer0ABQWRef6HsWDNIDP5XgKJB4wVvjCmHO3W5KHAbfqI8ZKeMO1oVOALkEJOI5m6
         H9XA==
X-Gm-Message-State: AOAM533xbdXQx2CXgXgnfh0djeq19kRmbgj4Jt14M3t04RdCbRikaib1
        T4uBlgoaF/OtZbopnXYnFNlllDcJZKEKpDT504V8cWtd6w/d
X-Google-Smtp-Source: ABdhPJwF+dz8wsHIXhj0sW0JLk3zUAJ5JZRZtsYREEoA9W2MtmjkreDnLc6q0Znbbsg+YXutDzUJxeteHGEtyBU4S0QugRMpasrw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:b:b0:32e:3b8d:3e5d with SMTP id
 z11-20020a056638000b00b0032e3b8d3e5dmr4245685jao.91.1652787309767; Tue, 17
 May 2022 04:35:09 -0700 (PDT)
Date:   Tue, 17 May 2022 04:35:09 -0700
In-Reply-To: <20220517111247.2103-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cf04605df3388a8@google.com>
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
WARNING: CPU: 0 PID: 4042 at fs/namespace.c:1239 mntput_no_expire+0xb02/0xfe0 fs/namespace.c:1239
Modules linked in:
CPU: 0 PID: 4042 Comm: syz-executor.2 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0xb02/0xfe0 fs/namespace.c:1239
Code: 00 48 c7 c7 c0 16 db 89 c6 05 33 c9 c8 0b 01 e8 c9 55 4d 07 e9 57 ff ff ff e8 2a bd 9d ff 0f 0b e9 df f9 ff ff e8 1e bd 9d ff <0f> 0b e9 d3 f9 ff ff e8 12 bd 9d ff e8 4d b7 88 ff 31 ff 89 c3 89
RSP: 0018:ffffc9000313fcf0 EFLAGS: 00010293

RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801ba15880 RSI: ffffffff81db8412 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: ffffffff9006e94f
R10: ffffffff81db7dce R11: 0000000000000001 R12: ffffc9000313fd40
R13: ffff88801f6ea800 R14: 0000000000000002 R15: dffffc0000000000
FS:  000055555676b400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff05411c78 CR3: 000000007a034000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 path_umount+0x7d4/0x1260 fs/namespace.c:1819
 ksys_umount fs/namespace.c:1838 [inline]
 __do_sys_umount fs/namespace.c:1843 [inline]
 __se_sys_umount fs/namespace.c:1841 [inline]
 __x64_sys_umount+0x159/0x180 fs/namespace.c:1841
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f67c148a557
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7f7ec938 EFLAGS: 00000246
 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f67c148a557
RDX: 00007ffc7f7eca0a RSI: 000000000000000a RDI: 00007ffc7f7eca00
RBP: 00007ffc7f7eca00 R08: 00000000ffffffff R09: 00007ffc7f7ec7d0
R10: 000055555676c8b3 R11: 0000000000000246 R12: 00007f67c14e21f8
R13: 00007ffc7f7edac0 R14: 000055555676c810 R15: 00007ffc7f7edb00
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=10df1295f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f621b9f00000

