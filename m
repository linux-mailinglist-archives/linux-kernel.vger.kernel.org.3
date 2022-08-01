Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAB1586E17
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiHAPxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiHAPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:53:17 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CF639B91
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:53:12 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o9-20020a056e0214c900b002dc29c288bfso6905461ilk.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=bK840S31wvjhJpvFujDOJzZOOevyh1Lvd1pyKumeyCM=;
        b=m7d4hDRqtH557hQHDMLSR743mZhU3cFoNeEJUkztKJZCDpr+D2peGrXtje/KoeZi46
         3Rf2bl4jMqoUMTz/r4YGR9wCj9xARvS5WIrWHzYwR+mQvgra3/ySlp+Jz7ART7EnDkzT
         zLB2AIcj9tkF33vAzSuYE/BZFbHuvjSYpbv5VQNq/ydia/GVBRlBaAS8slHp3JHYIOfe
         1oKfxM7mMn3L7RVfgnjhAuzR1PF1pxO0C3WLyu+ws0FwvE1fLatPROck0dihjp/LxFVP
         sFvEDRoma9ObCTyLAp+3LRPEXmfzKPODuLVYKYA6okusMRTw4SkaWTnUJLVjQbrbvlcV
         NOqA==
X-Gm-Message-State: ACgBeo1E/+WGuXzUFHIG5b/gYm9f6X2gq3wBf0XB/YIDkYYz2CCnjwuQ
        W1JN+znIUTk9vF5voIv/KvY0w5p5SDUuHmHfGCQcFgCOS98r
X-Google-Smtp-Source: AA6agR6Pa/wYRSjkSeUFzdwCQ6zGAdPZWeUZLPWRfs0kol+bJm93H6Ac5nY9NZdx9R1AJQoqcGUqSnXrlc8RkvB+oz1RfTclUGWK
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4705:b0:342:74bb:dfa3 with SMTP id
 cs5-20020a056638470500b0034274bbdfa3mr2264863jab.1.1659369192287; Mon, 01 Aug
 2022 08:53:12 -0700 (PDT)
Date:   Mon, 01 Aug 2022 08:53:12 -0700
In-Reply-To: <20220801154220.186048-1-khalid.masum.92@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041f57405e52fff3d@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
From:   syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>
To:     dan.carpenter@oracle.com, deller@gmx.de, khalid.masum.92@gmail.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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
KASAN: vmalloc-out-of-bounds Write in imageblit

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fast_imageblit drivers/video/fbdev/core/sysimgblt.c:257 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x1ed0/0x2240 drivers/video/fbdev/core/sysimgblt.c:323
Write of size 4 at addr ffffc90004261000 by task syz-executor.4/4191

CPU: 0 PID: 4191 Comm: syz-executor.4 Not tainted 5.19.0-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 fast_imageblit drivers/video/fbdev/core/sysimgblt.c:257 [inline]
 sys_imageblit+0x1ed0/0x2240 drivers/video/fbdev/core/sysimgblt.c:323
 drm_fb_helper_sys_imageblit drivers/gpu/drm/drm_fb_helper.c:825 [inline]
 drm_fbdev_fb_imageblit+0x15c/0x350 drivers/gpu/drm/drm_fb_helper.c:2328
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:139 [inline]
 bit_putcs+0x6e1/0xd20 drivers/video/fbdev/core/bitblit.c:188
 fbcon_putcs+0x314/0x3e0 drivers/video/fbdev/core/fbcon.c:1285
 do_update_region+0x399/0x630 drivers/tty/vt/vt.c:676
 redraw_screen+0x61f/0x740 drivers/tty/vt/vt.c:1035
 fbcon_do_set_font+0x5eb/0x6f0 drivers/video/fbdev/core/fbcon.c:2435
 fbcon_set_font+0x89d/0xab0 drivers/video/fbdev/core/fbcon.c:2522
 con_font_set drivers/tty/vt/vt.c:4666 [inline]
 con_font_op+0x73a/0xc90 drivers/tty/vt/vt.c:4710
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0x1efa/0x2b20 drivers/tty/vt/vt_ioctl.c:752
 tty_ioctl+0xbbd/0x15e0 drivers/tty/tty_io.c:2778
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff9cac89109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff9cbd6c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff9cad9c030 RCX: 00007ff9cac89109
RDX: 0000000020000040 RSI: 0000000000004b72 RDI: 0000000000000004
RBP: 00007ff9cbd6c1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd34c3bf8f R14: 00007ff9cbd6c300 R15: 0000000000022000
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90003f61000, ffffc90004262000) created by:
 drm_gem_shmem_vmap_locked drivers/gpu/drm/drm_gem_shmem_helper.c:319 [inline]
 drm_gem_shmem_vmap+0x3d7/0x5a0 drivers/gpu/drm/drm_gem_shmem_helper.c:366

Memory state around the buggy address:
 ffffc90004260f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004260f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90004261000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90004261080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90004261100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


Tested on:

commit:         3d7cb6b0 Linux 5.19
git tree:       https://github.com/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11b85261080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70dd99d568a89e0
dashboard link: https://syzkaller.appspot.com/bug?extid=14b0e8f3fd1612e35350
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f0a73c080000

