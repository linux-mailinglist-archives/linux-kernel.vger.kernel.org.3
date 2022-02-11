Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE84B2104
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348316AbiBKJHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:07:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiBKJHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:07:18 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D80AB33
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:07:18 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id q7-20020a6bf207000000b006129589cb60so5906959ioh.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sXJ4ILM25FIiiKAYARggO6qzhK/fdMnUo0mUqpZL4S8=;
        b=8RKezOXkYHxJHr9CKTfMwaU67YLBxk4dkzfnzoxCG7i3uMFJ83aZI8+xz1bLGEIH83
         jZ1NZwG+RPOo5Ft2dz+9BLkxBhpZ95PVV29G8WGn6mYPGvbEyjHUqEmInr9uIiA6Nd8N
         WBjtpO0+c7vTb2uxQQMlKLvlrIKBBSxxsx3HAL2nL+tHpEPtObh7AR/Nal9vKOCyn5mQ
         qy/7nuMWagA7z7rDY+Wa/zSXnLCJ38yOZd3n/0ZQk0uuKMA/kfgLhorXyWttmP/4Uxch
         kdyGwAGlT9bz7vgJTnn70g0iVSycZgFcDscmYfYtDskSF3QpEK/xkoT64eIZLL6zzd5n
         8fwg==
X-Gm-Message-State: AOAM530XTuOTYeCzKThty9czI4FZbB+xzO/zvxYFg9t6SPbT8CahWTwe
        Fwlbi0JtljKWIJyHsSEVbjiNcC9Ec8jgrFIZocKAPTquEgZ3
X-Google-Smtp-Source: ABdhPJxdwF30D+sAc7HOspAj+AlL/RT/FxlOQm3wq3x3Wf1y+gDG+DisFyRMYQFQQZpc7NG8eppp12w1CCYunzi+KQNe6GZ6LkFG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d15:: with SMTP id q21mr257277jaj.153.1644570437704;
 Fri, 11 Feb 2022 01:07:17 -0800 (PST)
Date:   Fri, 11 Feb 2022 01:07:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf60b605d7ba64b2@google.com>
Subject: [syzbot] KMSAN: uninit-value in mpol_rebind_mm (2)
From:   syzbot <syzbot+ad1b8c404f0959c4bfcc@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, glider@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

HEAD commit:    85cfd6e539bd kmsan: core: delete kmsan_gup_pgd_range()
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17a505dc700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9807dd5b044fd7a
dashboard link: https://syzkaller.appspot.com/bug?extid=ad1b8c404f0959c4bfcc
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bcfdb2700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124ca21c700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad1b8c404f0959c4bfcc@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:352 [inline]
BUG: KMSAN: uninit-value in mpol_rebind_mm+0x35b/0x460 mm/mempolicy.c:383
 mpol_rebind_policy mm/mempolicy.c:352 [inline]
 mpol_rebind_mm+0x35b/0x460 mm/mempolicy.c:383
 cpuset_attach+0xe28/0x15e0 kernel/cgroup/cpuset.c:2291
 cgroup_migrate_execute+0x1023/0x1d20 kernel/cgroup/cgroup.c:2515
 cgroup_migrate kernel/cgroup/cgroup.c:2771 [inline]
 cgroup_attach_task+0x540/0x8b0 kernel/cgroup/cgroup.c:2804
 __cgroup1_procs_write+0x5cc/0x7a0 kernel/cgroup/cgroup-v1.c:520
 cgroup1_procs_write+0x97/0xb0 kernel/cgroup/cgroup-v1.c:533
 cgroup_file_write+0x4c2/0x9e0 kernel/cgroup/cgroup.c:3852
 kernfs_fop_write_iter+0x66a/0x9f0 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write fs/read_write.c:503 [inline]
 vfs_write+0x1318/0x2030 fs/read_write.c:590
 ksys_write+0x28b/0x510 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0xdb/0x120 fs/read_write.c:652
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Uninit was stored to memory at:
 __mpol_dup+0x107/0x480 mm/mempolicy.c:2326
 mpol_dup include/linux/mempolicy.h:87 [inline]
 vma_replace_policy mm/mempolicy.c:762 [inline]
 mbind_range+0x13ee/0x1e40 mm/mempolicy.c:833
 do_mbind+0x13d2/0x1b30 mm/mempolicy.c:1323
 kernel_mbind mm/mempolicy.c:1477 [inline]
 __do_sys_mbind mm/mempolicy.c:1484 [inline]
 __se_sys_mbind+0x51c/0xc80 mm/mempolicy.c:1480
 __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1480
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 slab_alloc mm/slub.c:3259 [inline]
 kmem_cache_alloc+0x902/0x11c0 mm/slub.c:3264
 mpol_new mm/mempolicy.c:293 [inline]
 do_mbind+0x8f5/0x1b30 mm/mempolicy.c:1279
 kernel_mbind mm/mempolicy.c:1477 [inline]
 __do_sys_mbind mm/mempolicy.c:1484 [inline]
 __se_sys_mbind+0x51c/0xc80 mm/mempolicy.c:1480
 __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1480
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

CPU: 0 PID: 3474 Comm: syz-executor399 Not tainted 5.16.0-rc5-syzkaller #0
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
