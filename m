Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7895403AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbiFGQY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiFGQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:24:23 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0306C6D968
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:24:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id l3-20020a05660227c300b0065a8c141580so8286602ios.19
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 09:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ndnbQPXIfIB+41eA5XK3lm1GuhYKxN1ZpG46L3Kj5rU=;
        b=Xugy5WTNE7BO2mf1qrBPcrPF2Q4eF9h4Qd8+TAuJ2qRxzKV8uVlPF4Hbh+yi9UAmPm
         EnCSkig0y0HcXaBYUWaz9pg+ISnQ6k9upqKKDLOv6LPzxluR2VUtU2Pmx5N6Ub7jj/Hc
         G/H9OkhNWg0nZ641ddZj0j/LmPT5KwHmnmBBgLl/q+2y+uUYDAKjKDkvesLaqzsZDfAl
         /95MzWq+cr/nwozpBQjQpG2wsnzXMUwsutsFPZNh9+HDsAD65BWeRPJzQRHf8wstx91Z
         2iSqOmOmFvM5hs9J6S8x55qk1MRsWMyew9YrARL+Vyvl5DKeLj8fvwLg4IB4KOWqOdxS
         7jQQ==
X-Gm-Message-State: AOAM532PbN1iHwjDHrdXLAnDhWurTC+wpCp9W6NBHVA5JK+cQTbLzvk/
        Qd/uAY0RyYPzjPcIlcoMba8K1E+ucxHhaGgQ5k0H5AxOQb9m
X-Google-Smtp-Source: ABdhPJwd4EvLPq3B9U/k6O+usjT7wDELCPHkcJt6slaAZOLk3GsDiONn87WcA6uXkK1DfQOHYO0yFNrY8tj2i4AbkAt7iRpVqEQN
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:2d3:e79f:2fc1 with SMTP id
 k10-20020a92c24a000000b002d3e79f2fc1mr15901315ilo.250.1654619061331; Tue, 07
 Jun 2022 09:24:21 -0700 (PDT)
Date:   Tue, 07 Jun 2022 09:24:21 -0700
In-Reply-To: <0000000000003fc46005e0db5390@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063ade705e0de053e@google.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Write in check_move_unevictable_pages
From:   syzbot <syzbot+8847ae8c7bc46bc9c10e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    73d0e32571a0 Add linux-next specific files for 20220607
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=130bde07f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=448ee2b64e828049
dashboard link: https://syzkaller.appspot.com/bug?extid=8847ae8c7bc46bc9c10e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14359627f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177d5f3ff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8847ae8c7bc46bc9c10e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in folio_batch_add include/linux/pagevec.h:130 [inline]
BUG: KASAN: vmalloc-out-of-bounds in check_move_unevictable_pages+0x3f6/0x440 mm/vmscan.c:4857
BUG: KASAN: vmalloc-out-of-bounds in folio_batch_add include/linux/pagevec.h:130 [inline]
BUG: KASAN: vmalloc-out-of-bounds in check_move_unevictable_pages+0x3f6/0x440 mm/vmscan.c:4857
Write of size 8 at addr ffffc90002d30008 by task syz-executor102/3610

CPU: 0 PID: 3610 Comm: syz-executor102 Not tainted 5.19.0-rc1-next-20220607-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 folio_batch_add include/linux/pagevec.h:130 [inline]
 check_move_unevictable_pages+0x3f6/0x440 mm/vmscan.c:4857
 drm_gem_check_release_pagevec drivers/gpu/drm/drm_gem.c:511 [inline]
 drm_gem_put_pages+0x29f/0x3f0 drivers/gpu/drm/drm_gem.c:639
 drm_gem_shmem_put_pages_locked+0x13e/0x230 drivers/gpu/drm/drm_gem_shmem_helper.c:237
 drm_gem_shmem_put_pages drivers/gpu/drm/drm_gem_shmem_helper.c:252 [inline]
 drm_gem_shmem_vm_close+0x45/0x70 drivers/gpu/drm/drm_gem_shmem_helper.c:588
 remove_vma+0x81/0x130 mm/mmap.c:187
 exit_mmap+0x2a1/0x750 mm/mmap.c:3215
 __mmput+0x128/0x4c0 kernel/fork.c:1180
 mmput+0x5c/0x70 kernel/fork.c:1201
 exit_mm kernel/exit.c:510 [inline]
 do_exit+0xa18/0x2a00 kernel/exit.c:782
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f0a6ae36299
Code: Unable to access opcode bytes at RIP 0x7f0a6ae3626f.
RSP: 002b:00007ffe4d7cbe58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f0a6aeaa270 RCX: 00007f0a6ae36299
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000100000000
R10: 0000000000000012 R11: 0000000000000246 R12: 00007f0a6aeaa270
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90002d28000, ffffc90002d31000) created by:
 kernel_clone+0xe7/0xab0 kernel/fork.c:2648

Memory state around the buggy address:
 ffffc90002d2ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90002d2ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90002d30000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                      ^
 ffffc90002d30080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90002d30100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================

