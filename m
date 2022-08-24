Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0059FF98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbiHXQgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiHXQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:36:34 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8882864
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:36:33 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id y1-20020a056602200100b006893cd97da9so9296786iod.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=0e2/BSTLxVDl9t2FnXBs3U/ZaI7RFyb5pQeTdPS3oe0=;
        b=yxBy+3nBIKXCCV0Tslfa9NeFcxKiKkWduRMI5Qv3OSMnYNZ4pW6j8MbkaDvzGRLf5c
         RuFfJd77u9+N6ipejTXv6sZMZpfCWGA8GeFYfLGgJeLsf2pfhEUpESzY7qqA4Z/4jIoz
         AHBDQuXpiYG+3MgGo3geJ3iGt7ye/cNrMzT+vtyelwQzKCbyTYW/8ODfBEOf8itKrPh2
         /VWi8JrS/E/jH2FJvW6NgKRgZwWuaHxYBldGxe77rMO12YvGQ0DzrhRumbcDZPm7PSlb
         yCuOtZ5RC8pU+fwX4+sAJ52XP04YXdPj9TRag/beYEjw1qA4lXeO64qK+0+ryCsQTiyp
         pnOQ==
X-Gm-Message-State: ACgBeo3Xnq0DNinhnb8TcIyWrnIUDszSantYzFMbpEGYC04BSkOynWHH
        KIhugGpIL45OnH/JPX8tcc/soP8ezoPM+/ZUJa+G+XRx6S1t
X-Google-Smtp-Source: AA6agR50Ms+DOrBZZF6YZxt6t4EkEE6W3wodds7xwFWWZ/FP+H45wm6bVOTAU4IJTMhPU7Q0bgk37aLD6+/6pFOTlILbcHhwBkjB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152e:b0:2e8:f73f:4e9e with SMTP id
 i14-20020a056e02152e00b002e8f73f4e9emr2329073ilu.61.1661358992664; Wed, 24
 Aug 2022 09:36:32 -0700 (PDT)
Date:   Wed, 24 Aug 2022 09:36:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a318805e6ff48a4@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in ni_find_attr
From:   syzbot <syzbot+69d15cab6309bffae739@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1c23f9e627a7 Linux 6.0-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=152b86a5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3045c937aad027f7
dashboard link: https://syzkaller.appspot.com/bug?extid=69d15cab6309bffae739
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1621f485080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171012d3080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69d15cab6309bffae739@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 75
ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000238
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107c58000
[0000000000000238] pgd=0800000108ac7003, p4d=0800000108ac7003, pud=0800000109389003, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3028 Comm: syz-executor245 Not tainted 6.0.0-rc2-syzkaller-16440-g1c23f9e627a7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ni_find_attr+0x54/0x43c fs/ntfs3/frecord.c:194
lr : ni_find_attr+0x54/0x43c fs/ntfs3/frecord.c:190
sp : ffff80001200b8f0
x29: ffff80001200b920 x28: 0000000000000000 x27: 00000000fffffffe
x26: 0000000000000000 x25: 0000000000000000 x24: ffff80001200b984
x23: 0000000000000000 x22: 0000000000000080 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000000000c0
x17: ffff80000dd7a698 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 00000000fffffffe x12: ffff80000d5998c8
x11: ff80800008be8ec0 x10: 0000000000000000 x9 : ffff800008be8ec0
x8 : ffff0000c5569a80 x7 : 0000000000000000 x6 : ffff80001200b984
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000080
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 ni_find_attr+0x54/0x43c fs/ntfs3/frecord.c:190
 attr_load_runs_vcn+0x6c/0x138 fs/ntfs3/attrib.c:1220
 mi_read+0x178/0x274 fs/ntfs3/record.c:151
 ntfs_read_mft fs/ntfs3/inode.c:69 [inline]
 ntfs_iget5+0x15c/0x138c fs/ntfs3/inode.c:501
 ntfs_fill_super+0x950/0x14a4 fs/ntfs/super.c:2791
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: aa0103fa aa0003f3 f81f83a8 97daea83 (f9411e7b) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa0103fa 	mov	x26, x1
   4:	aa0003f3 	mov	x19, x0
   8:	f81f83a8 	stur	x8, [x29, #-8]
   c:	97daea83 	bl	0xffffffffff6baa18
* 10:	f9411e7b 	ldr	x27, [x19, #568] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
