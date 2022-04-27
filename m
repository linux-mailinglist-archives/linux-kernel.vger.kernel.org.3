Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B65A511A28
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiD0NYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiD0NXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:23:43 -0400
Received: from mail-io1-xd46.google.com (mail-io1-xd46.google.com [IPv6:2607:f8b0:4864:20::d46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFD2D7A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:20:21 -0700 (PDT)
Received: by mail-io1-xd46.google.com with SMTP id d19-20020a0566022d5300b0065499cd4a73so2272117iow.14
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0HeRjMQ5Gk682aDL8RE02ZjSUks4bcwfNrNycajs9W4=;
        b=31YhJHIVZ5snNwnuZeXYTuf4SBhhvHOyz7hm5l3L1D4aWgjwPUZUhC0ER1/tVAAZ7t
         TSu99wa7gH8lQHV3chzny5Vs6Qf7Bti3QNT5RxBYrihFzFwKdj8S8+U4zy0AyiDnWL1E
         aaEEX88rk2rI/EgjAr2DCmXs8xwucRfGodM4JnVJErT7kDoVVhcKURQwnAuS5D6G0HhP
         7C+Gg6lKRjqaPeCcGRcQwer1VK3/VEis8PCo8s6GyRT1AbxKb3f0dOdZSaLqRJY488z8
         YGgEsHdDjvQ8ixNgh7FdivljSlr24bET6cbNgIXxxmq/eeyr+0dBLDvGZTYR3UVweGu3
         4Peg==
X-Gm-Message-State: AOAM533iqwKuysxDOV+6YAOzvmImGfFNgH1+7g0FsVsbop5Qg22wvQU+
        TeZbzZXJiPQyPGHb0LoNfI4B0wT5GeyM6p7XAEC/zYRgj7AQ
X-Google-Smtp-Source: ABdhPJwEYdyTfbYiVy/vKw1D8ERT/PZgdQPVn4H4ontcFJyzHBTy3UJBtaghDc5OxxTuRqFSxTpPUyHeWyJ7ZhDykCQxRz+AdbhC
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1409:b0:5e7:487:133c with SMTP id
 t9-20020a056602140900b005e70487133cmr3368591iov.196.1651065320802; Wed, 27
 Apr 2022 06:15:20 -0700 (PDT)
Date:   Wed, 27 Apr 2022 06:15:20 -0700
In-Reply-To: <000000000000a23c8505dda227eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f28f0005dda29992@google.com>
Subject: Re: [syzbot] WARNING in vma_merge
From:   syzbot <syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f02ac5c95dfd Add linux-next specific files for 20220427
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=105a33a2f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9256c70f586da8a
dashboard link: https://syzkaller.appspot.com/bug?extid=7728e4ab5371cebc9c00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f76f82f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b42c3cf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3593 at mm/mmap.c:1072 vma_merge+0x428/0x950 mm/mmap.c:1072
Modules linked in:
CPU: 1 PID: 3593 Comm: syz-executor549 Not tainted 5.18.0-rc4-next-20220427-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vma_merge+0x428/0x950 mm/mmap.c:1072
Code: 00 e8 5c 1f c4 ff e8 57 1f c4 ff 45 31 f6 e8 4f 1f c4 ff 4c 89 f0 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 38 1f c4 ff <0f> 0b e9 6c fd ff ff e8 2c 1f c4 ff 48 8d bd 88 00 00 00 48 b8 00
RSP: 0018:ffffc90002edfd10 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000008102073 RCX: 0000000000000000
RDX: ffff88801d0a3a80 RSI: ffffffff81b62968 RDI: 0000000000000003
RBP: ffff88807e550bd0 R08: 0000000021001000 R09: 0000000000000000
R10: ffffffff81b626ce R11: 0000000000000000 R12: 0000555557211000
R13: 00005555571ef000 R14: ffff88807e550d80 R15: ffff88807e550d80
FS:  00005555571ef300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005564400b0df0 CR3: 0000000073d7f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mlock_fixup+0x349/0x7f0 mm/mlock.c:420
 apply_mlockall_flags+0x2be/0x440 mm/mlock.c:691
 __do_sys_mlockall+0x222/0x4b0 mm/mlock.c:719
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9cdd5a1f99
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffecfa63c98 EFLAGS: 00000246 ORIG_RAX: 0000000000000097
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9cdd5a1f99
RDX: 00007f9cdd5a1f99 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f9cdd565f80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9cdd566010
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

