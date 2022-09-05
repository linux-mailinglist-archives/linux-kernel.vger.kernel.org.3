Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618FA5ACF0B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiIEJmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiIEJmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:42:40 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B314E86B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:42:38 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id g5-20020a92cda5000000b002e954ecceb0so6929049ild.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 02:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=X3yk1eG/DV5Le3kCaxu0Ha0WlwBmmsjzDesiw7cpZEM=;
        b=m353b/CB6VKG+uq/1wHpxSPS9qbX6DoEIyMfJIlyqWlrJ5FKRG5Nu1dNu01U6jcmCm
         w+Zn3YOnmp5Y3kys3hl+jPvqIL2rf+W+wPKMk7Y+9AKeDbFId67zHwQuzoAK/DiSx37K
         E31YXiHddY+MHJ7T8dq1UNNZUP6PijhY0vL13WndhzMzTutRGQX9XwQp35ZCv/2zLQAR
         WX/CoNdFK8XXecp0ialVy+yE9U6EMyoZwMboyR3RSdSUIpLnLl4FbCiInB5MzmsultLN
         gZXyDm3m19rb8gCO6v8TQ0AmE4AM7N4QhsZf3hCqw/aIibpLuo1kjTPQ351s9bs5IwPQ
         LsOw==
X-Gm-Message-State: ACgBeo0T4N/QA4uKzUTwZHs471gvb3P+e7KS3D/5jNgG/VdbXV9230Xc
        kWBi+e7G+E31sE1oqVxs11eslwrR4SHJd8VdyFt9VBk2QBFn
X-Google-Smtp-Source: AA6agR681pLVYWY+KeBgzKX9+rikNjuvJjzOHnLjjwGbsfRlpFuTOZTpFMkAnpkeOJPO2pxVhl1tiE5zgmk1B1bKRzs0I0FHvOSO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2c:b0:2ee:5b19:fbf4 with SMTP id
 m12-20020a056e021c2c00b002ee5b19fbf4mr8438540ilh.131.1662370957895; Mon, 05
 Sep 2022 02:42:37 -0700 (PDT)
Date:   Mon, 05 Sep 2022 02:42:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e2d4305e7eae644@google.com>
Subject: [syzbot] WARNING: refcount bug in drm_gem_object_handle_put_unlocked
From:   syzbot <syzbot+c512687fff9d22327436@syzkaller.appspotmail.com>
To:     airlied@linux.ie, christian.koenig@amd.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17ae17bd080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=c512687fff9d22327436
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e8fee5080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b6bf13080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c512687fff9d22327436@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 3029 at lib/refcount.c:28 refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
Modules linked in:
CPU: 0 PID: 3029 Comm: syz-executor717 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
lr : refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
sp : ffff80001200baa0
x29: ffff80001200baa0 x28: 00000000000a201d x27: 0000000000002000
x26: dead000000000100 x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000003 x19: ffff80000d937000 x18: 00000000000000c0
x17: ffff80000dd7a698 x16: ffff80000dbb8658 x15: ffff0000c10a4f80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c10a4f80
x11: ff808000081c39dc x10: 0000000000000000 x9 : 9016e5cf66052a00
x8 : 9016e5cf66052a00 x7 : ffff800008197c8c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000026
Call trace:
 refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 kref_put include/linux/kref.h:64 [inline]
 __drm_gem_object_put include/drm/drm_gem.h:381 [inline]
 drm_gem_object_put include/drm/drm_gem.h:394 [inline]
 drm_gem_object_handle_put_unlocked+0x178/0x190 drivers/gpu/drm/drm_gem.c:240
 drm_gem_object_release_handle+0x90/0xa8 drivers/gpu/drm/drm_gem.c:259
 idr_for_each+0xf0/0x174 lib/idr.c:208
 drm_gem_release+0x30/0x48 drivers/gpu/drm/drm_gem.c:932
 drm_file_free+0x220/0x2cc drivers/gpu/drm/drm_file.c:281
 drm_close_helper drivers/gpu/drm/drm_file.c:308 [inline]
 drm_release+0x108/0x22c drivers/gpu/drm/drm_file.c:495
 __fput+0x198/0x3bc fs/file_table.c:320
 ____fput+0x20/0x30 fs/file_table.c:353
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x26c/0xbb8 kernel/exit.c:795
 do_group_exit+0x60/0xe8 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __wake_up_parent+0x0/0x40 kernel/exit.c:934
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 12698
hardirqs last  enabled at (12697): [<ffff8000081c1c48>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (12698): [<ffff80000bffe9cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (12442): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (12417): [<ffff800008104658>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (12417): [<ffff800008104658>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
