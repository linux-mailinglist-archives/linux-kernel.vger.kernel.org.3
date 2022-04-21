Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8087F509AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386736AbiDUIkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386742AbiDUIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:40:15 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928B193EA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:37:25 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id q5-20020a0566022f0500b00654a56b1dfbso2842536iow.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Z3COjImbkOiEoOAzeO8GIdxDewk8AQvlhTEHNm0MlOw=;
        b=5k+Gc4hxi6fLznIIVZvasQDaY+KxNrMXKrNmvgFrGVa/+KYrmja1Jry1POYmtPgNDm
         9IX0BGrImGAk/SYfi4Drwh9A8iokimWGyiOo86jZZTHnKQV0ePNn0UXKCUlfSX1kuqzY
         sqfIT1/fJgoa5LNTK9BU4Yq7t28meZzq1YPILaRRunxFzJBConl8bFg7xm74vCOfUAx0
         knU8Wxe4c2sSMXcl0kuOaTsMxENmWreSQBX5xyh2F/j3D5sA2akgyx/uTO8AZckdjM01
         IqJd9DoVQq031TIU1wVkpMmrfTzsMjlfRQ0dgA9aPNDT1rVSVT5jnUfgaCecd2s2C1ap
         SM+A==
X-Gm-Message-State: AOAM530+b/aZtQbTeKyijknfoFXJQouTvEC7DKXS1SgwxMZjRytchf1r
        DI09E8JtNIqh+/CxIIdB0NXwZphUW/4jIX1owirl/pmhm0Yd
X-Google-Smtp-Source: ABdhPJwl3/XXfAKfEcos1SazqUljVxiPCxXMPwsY8wSp6dJPzIeZNsFQ2CEKPoASmEbz3qZzqC7Y3N4nsJfiwq7n40kifY7eBpdV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc7:b0:2cc:5965:ea80 with SMTP id
 x7-20020a056e021bc700b002cc5965ea80mr3176767ilv.221.1650530244546; Thu, 21
 Apr 2022 01:37:24 -0700 (PDT)
Date:   Thu, 21 Apr 2022 01:37:24 -0700
In-Reply-To: <000000000000f8b5ef05dd25b963@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ead34405dd2604f0@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in ntfs_fill_super
From:   syzbot <syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b253435746d9 Merge tag 'xtensa-20220416' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177e30e8f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff9f8140cbb3af7
dashboard link: https://syzkaller.appspot.com/bug?extid=1631f09646bc214d2e76
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e13cfcf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135e3008f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8189
================================================================================
UBSAN: shift-out-of-bounds in fs/ntfs3/super.c:673:16
shift exponent -192 is negative
CPU: 1 PID: 3587 Comm: syz-executor611 Not tainted 5.18.0-rc3-syzkaller-00016-gb253435746d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 ntfs_fill_super.cold+0x2bf/0x549 fs/ntfs/bitmap.c:84
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb8d7bcd7ea
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfb6d7948 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdfb6d79a0 RCX: 00007fb8d7bcd7ea
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffdfb6d7960
RBP: 00007ffdfb6d7960 R08: 00007ffdfb6d79a0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020001b80
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000110
 </TASK>
================================================================================

