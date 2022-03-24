Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773894E6462
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350608AbiCXNuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350690AbiCXNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:49:55 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0069225D2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:48:21 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id u15-20020a92da8f000000b002c863d2f21dso2328178iln.15
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RXcdDplmYiIu10iLNKYxW6U02q/5ql00EI27tmcwm+4=;
        b=vGF/8u/1lJ98ilH1lKD2m1sjSs6X/+WpqHN+3gcYh0djtfQ6/nSIzhwiI6CyJl5xl4
         ZKTT3G+O2Hp/IU3b0BK2T7pAPoprNNU36nqaGZ5KrlRJBAGsn70xTXW+2FGIA2ocdgjH
         KvAPrsIYFK/mnf+7rq3LoBegDERQEKiVz0NZ9w+1uIkFe8HH+A9mJraT/gg5qDrvUXVz
         ddNYjL1+W8Zrx8NcFwNtOme4HqIXu9Kjql0i5b4smVnCoQnf2QASC4a6j3FKFx8utd3h
         QbOP0gIM9XyOGxoboAY+4eCqKgDOa6KoaVlTzO+ssZcKwykOPApj2jPOjq7UHL2XIxde
         2sTA==
X-Gm-Message-State: AOAM5325B6Ywy76iYpCxNHBI0vg6CKPgzxkGPKZiXhOkD5DhHrwkhWsq
        aq7Nt1vwX959Dat5ZTP2sqhMWGAH3CLLWAqCOQVKSjz8GXZ0
X-Google-Smtp-Source: ABdhPJxQiWtHUYvdm7ZPIwcyDG+dndPDw9ksTSTh8jlOa0ZqxjDvcJD4+h8LqupS/Mhkb9J54Tsc4RI1wNHtwHsbXcazmAaDWfMZ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1a8b:b0:321:49df:5591 with SMTP id
 ce11-20020a0566381a8b00b0032149df5591mr3026097jab.246.1648129701333; Thu, 24
 Mar 2022 06:48:21 -0700 (PDT)
Date:   Thu, 24 Mar 2022 06:48:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000644f1a05daf71983@google.com>
Subject: [syzbot] KMSAN: uninit-value in do_user_addr_fault (3)
From:   syzbot <syzbot+6684a9d1b4d61d0b8f3e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com, elver@google.com,
        glider@google.com, linux-kernel@vger.kernel.org,
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

HEAD commit:    724946410067 x86: kmsan: enable KMSAN builds for x86
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1734f916700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f99026248b24e4
dashboard link: https://syzkaller.appspot.com/bug?extid=6684a9d1b4d61d0b8f3e
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b1cbf2700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131d38a6700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6684a9d1b4d61d0b8f3e@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in arch_stack_walk+0x1ad/0x3c0 arch/x86/kernel/stacktrace.c:21
 arch_stack_walk+0x1ad/0x3c0 arch/x86/kernel/stacktrace.c:21
 stack_trace_save+0x43/0x60 kernel/stacktrace.c:122
 kmsan_save_stack_with_flags mm/kmsan/core.c:80 [inline]
 kmsan_internal_chain_origin+0xa9/0x110 mm/kmsan/core.c:217
 kmsan_internal_memmove_metadata+0x1f2/0x2e0 mm/kmsan/core.c:165
 __msan_memcpy+0x65/0x90 mm/kmsan/instrumentation.c:127
 sock_write_iter+0x605/0x690 net/socket.c:1062
 do_iter_readv_writev+0xa7f/0xc70
 do_iter_write+0x52c/0x1500 fs/read_write.c:851
 vfs_writev fs/read_write.c:924 [inline]
 do_writev+0x645/0xe00 fs/read_write.c:967
 __do_sys_writev fs/read_write.c:1040 [inline]
 __se_sys_writev fs/read_write.c:1037 [inline]
 __x64_sys_writev+0xe5/0x120 fs/read_write.c:1037
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Local variable regs created at:
 __bpf_prog_run32+0x84/0x180 kernel/bpf/core.c:1796
 bpf_dispatcher_nop_func include/linux/bpf.h:785 [inline]
 __bpf_prog_run include/linux/filter.h:626 [inline]
 bpf_prog_run include/linux/filter.h:633 [inline]
 __bpf_prog_run_save_cb+0x168/0x580 include/linux/filter.h:756

CPU: 1 PID: 3474 Comm: syz-executor178 Not tainted 5.17.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
