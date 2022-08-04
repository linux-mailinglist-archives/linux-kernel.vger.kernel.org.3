Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4836758A2FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiHDWAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHDWAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:00:32 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1CF64E5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:00:30 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id u9-20020a056e021a4900b002dc685a1c13so539165ilv.19
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=f2Aq/HQcpNyfdVHUFhRZWedlVxHPyLOZz5MBuiByUsk=;
        b=hBS3IROtPn+lL0cXWd872bZD+EVv9nWBR1K2j2oSKPtX0WnFV5VIisKV6lYS8A2LJD
         SP2SK47M/nM8TpvM8hkCO1tFVQ05ZSja56IYPgo7i2g934uCJD4t2Uy31Cil9yV2HTlL
         StQ1xr/4XQ7rYgl0NCCLZRaaKZg6b19exbRYFFBs1o+tTjEgZgR88KxY3RjhEx+3uI3B
         unCTlwzWQIPV+velrn+eiI5y8j8OolMYDafSK140/YKz2Xnsp87+TUc9p0iY3OP7XBrd
         mvzwjf5ziUYfwU6Rqlkw/nCRDoidX3Z4vOcGgKva2SH5zaEzcer6kOgZaubLp7G/xUXS
         Xn/w==
X-Gm-Message-State: ACgBeo2OjqT4ShN3W/gDl50KXw6b02ODbBdlDqYxCcdqtuyyM8NrNz/9
        shjpyzahcSLyFebUt/Nt+JPWxsmOozVxskCJ7mXzcDx6IzsV
X-Google-Smtp-Source: AA6agR6UO2jX0H6ux3HhMNmK48a5RJrx/3oBOt3s5qq66mkkN/XpwUWyRNwi9js457ioUD80EldS/JL/fNDyVLs5tImnonGdYwwb
MIME-Version: 1.0
X-Received: by 2002:a92:ce81:0:b0:2dc:fbec:d023 with SMTP id
 r1-20020a92ce81000000b002dcfbecd023mr1625181ilo.155.1659650429687; Thu, 04
 Aug 2022 15:00:29 -0700 (PDT)
Date:   Thu, 04 Aug 2022 15:00:29 -0700
In-Reply-To: <00000000000098972c05e2117b39@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005022af05e5717ac8@google.com>
Subject: Re: [syzbot] memory leak in kobject_set_name_vargs (5)
From:   syzbot <syzbot+7381dc4ad60658ca4c05@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b44f2fd87919 Merge tag 'drm-next-2022-08-03' of git://anon..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105fdbca080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=358668a360d9b702
dashboard link: https://syzkaller.appspot.com/bug?extid=7381dc4ad60658ca4c05
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c685ca080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120a0fe2080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7381dc4ad60658ca4c05@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 25.990s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 27.260s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 28.520s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 31.000s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 31.040s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 31.080s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
executing program
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
executing program
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory

