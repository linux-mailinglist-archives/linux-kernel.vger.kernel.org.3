Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCFB59587C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiHPKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiHPKfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:35:40 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AA2F5AA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:39:23 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id y4-20020a056e021be400b002e5a1e77e04so4008322ilv.22
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=3F94oICmWCDWUulfqYiU++BfIXaXsChc7TIeYe2T9OI=;
        b=v+CRecs2uTAwtjqKw9VnBV4+qNP4Rbf8gxbBKAqTirGn81kHtXoXj6jAcRffWVkYHx
         gICN4ohlvBjStadVAhSGj9JU0c4kPw8uMSw5xeP7RKJ0leGtA2bg4DIb1yheVK8bShnH
         WhwnpZ8HXFXc0DOREShs5yG07jLCy083BCyrfmAy9m1qObIbQ/Seav3Z2IjI9FtmyJVl
         pC5IQhKW9ajGmVj5v9DmTKBAtYM31dvILXD8nuu/xisbs/V5iQ4hHRM6tzCYvhswlCvx
         ds0pgjrBZhntq+NN5FBoTrVXvCAN8UKIQ++QwyL0oCCRbphXb2DtmjIQVCmhHYmvetkF
         kwfw==
X-Gm-Message-State: ACgBeo1T3PJUPHX8scfUnVN8YnOq1WI3XBkPGG8/dMZWFYliCUvcGEpZ
        +cWHmuvNQKrxcru3tE5MWNPBw5bleAqzKejw+R+Aq0IvWGTV
X-Google-Smtp-Source: AA6agR68w5QeoJEHatLxiQsYYVW/IqV+vOr/RfxLHn375quqwzYIaWdjiAyFEulGSEhIfYMHi1iZNZvM0nrDuYG+euMzh2BbyrlG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8e1:b0:2e3:34cf:2519 with SMTP id
 n1-20020a056e0208e100b002e334cf2519mr9529574ilt.70.1660639162545; Tue, 16 Aug
 2022 01:39:22 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:39:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000623d9a05e657af56@google.com>
Subject: [syzbot] upstream boot error: WARNING: locking bug in __anon_vma_prepare
From:   syzbot <syzbot+80f7b10866c848183bb6@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
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

syzbot found the following issue on:

HEAD commit:    4a9350597aff Merge tag 'sound-fix-6.0-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106daf73080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4757943c2b26daff
dashboard link: https://syzkaller.appspot.com/bug?extid=80f7b10866c848183bb6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80f7b10866c848183bb6@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 1099 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4727 [inline]
WARNING: CPU: 0 PID: 1099 at kernel/locking/lockdep.c:231 __lock_acquire+0xac2/0x1f60 kernel/locking/lockdep.c:5003
Modules linked in:
CPU: 0 PID: 1099 Comm: kworker/u4:5 Not tainted 5.19.0-syzkaller-14090-g4a9350597aff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:hlock_class kernel/locking/lockdep.c:231 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4727 [inline]
RIP: 0010:__lock_acquire+0xac2/0x1f60 kernel/locking/lockdep.c:5003
Code: bc 0c 00 0f 85 2b fa ff ff 31 db 48 c7 c7 60 74 ad 8a 48 c7 c6 00 77 ad 8a 31 c0 e8 98 12 e8 ff 48 ba 00 00 00 00 00 fc ff df <0f> 0b e9 25 fa ff ff e8 22 c7 c8 02 85 c0 0f 84 b1 06 00 00 48 c7
RSP: 0000:ffffc9000468f528 EFLAGS: 00010046
RAX: cd292025beaed200 RBX: 0000000000000000 RCX: ffff888020338000
RDX: dffffc0000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff816d56dd R09: fffff520008d1e21
R10: fffff520008d1e21 R11: 1ffff920008d1e20 R12: 0000000000040000
R13: ffff888020338000 R14: 00000000000413c1 R15: ffff888020338ae8
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000ca8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 __anon_vma_prepare+0x198/0x400 mm/rmap.c:209
 anon_vma_prepare include/linux/rmap.h:156 [inline]
 do_anonymous_page+0xe4e/0x1150 mm/memory.c:4082
 handle_pte_fault mm/memory.c:4909 [inline]
 __handle_mm_fault mm/memory.c:5053 [inline]
 handle_mm_fault+0x186b/0x35c0 mm/memory.c:5151
 faultin_page mm/gup.c:955 [inline]
 __get_user_pages+0x516/0x1230 mm/gup.c:1195
 __get_user_pages_locked mm/gup.c:1399 [inline]
 __get_user_pages_remote+0x1c2/0x750 mm/gup.c:2109
 get_arg_page fs/exec.c:222 [inline]
 copy_string_kernel+0x286/0x510 fs/exec.c:639
 kernel_execve+0x5cb/0xa00 fs/exec.c:1993
 call_usermodehelper_exec_async+0x262/0x3b0 kernel/umh.c:112
 ret_from_fork+0x1f/0x30
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
