Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51625A3E14
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiH1OfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 10:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiH1OfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:35:10 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E440C205F2;
        Sun, 28 Aug 2022 07:35:07 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-33dc31f25f9so141357927b3.11;
        Sun, 28 Aug 2022 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=L7p2fwvxLt8klY9HmVYKZQ+T4ndQ2z3sJvLvDAL9H4I=;
        b=c3vUV9Avy1zJzePFlO4RzGyAhmXtEQ5USGZtKpnfA/rlQpPNcc8goIjTqeNlikTUSk
         oja4q3Hn7+XMktkKvNu7MOhLaYoPHZVRqQgc8sgGE+2ZrpPWEzpBKaNrVHn1IPeSoXlP
         2kQcBStHVNbKmVMoxnm8u15Ppjcx2/bSZFOZPKZKXIkFWW95DoFcE/EWG+Q97XjkjUOt
         XWa9jZ9usIIxCmI8xw73qVo68paWIlTjIsAcsc8HwzJ7I+t+J26Ro2rQ3Juv+o0f9eWN
         gBYkkWaRYtelFTNY+FFlBEmu/hsn9EezdLPLJy0fbK0Vt2kJvZWXocQC6gQK+96IZlD2
         r9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=L7p2fwvxLt8klY9HmVYKZQ+T4ndQ2z3sJvLvDAL9H4I=;
        b=4foZbHBy+m8dk9fnxN9dNOeWZSLPMNQJRglMebHk26zenvXkqM1XQ76S/SECg3di7S
         YhNps61Dm+/yoEb/65js0jXqe0vMzdEVxvn20EvUwa7DOB2r2TOIRcfRRm3HWI/XQR3P
         Jxfbr057v9PoNNrV+MaIArGcml5Rq3TkeUb0CE2y1XF8cpuJ4ldgsAs3zBaDrlGYg44+
         dU077a7GPA6zFJIUVaDKvW2h6spbBxmjHUk3x5bczIwYKttgMgfNvKBFycKebENX+W+5
         0s7Oq8VKinr4KURsgK5Codh9GDONDoozwqmXvm4zmMQ1z/UlaGHVj0fdrkcJkhwAiI1s
         VzJw==
X-Gm-Message-State: ACgBeo2nEXvbWCPdGNUUOFdnaB64eZeVQD/6Bn+v6oxLn3imdp8B1SPV
        5uKgHOqMofDT5q7TZtGr3osop01KKQA7c+PE6lXCZnSd0upBs0pW
X-Google-Smtp-Source: AA6agR5/BXsmaULJ/frA2pXy0N4/lsJ/CuEw3jScIHAzcdoqV1jd3ECni0cwlsnnBlM2DFUsHBfcEw/tz+xq3QikrKM=
X-Received: by 2002:a25:d791:0:b0:695:9953:d27b with SMTP id
 o139-20020a25d791000000b006959953d27bmr5403124ybg.61.1661697306815; Sun, 28
 Aug 2022 07:35:06 -0700 (PDT)
MIME-Version: 1.0
From:   Jiacheng Xu <578001344xu@gmail.com>
Date:   Sun, 28 Aug 2022 22:34:52 +0800
Message-ID: <CAO4S-meHv6Z-Wr1ZLz6j=i7fWkhPijv0CxE5JOFDWJOFH=C_3w@mail.gmail.com>
Subject: WARNING in md_alloc
To:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, mcgrof@kernel.org
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using modified Syzkaller to fuzz the Linux kernel-5.15.58, the
following crash was triggered.

HEAD commit: 568035b01cfb Linux-5.15.58
git tree: upstream

console output:
https://drive.google.com/file/d/1FU_URJHWwRs2KtNZ26WzxlSGE95DWBxe/view?usp=sharing
kernel config: https://drive.google.com/file/d/1wgIUDwP5ho29AM-K7HhysSTfWFpfXYkG/view?usp=sharing
syz repro: https://drive.google.com/file/d/1RYMFWOThdDCrjoFgRZrzfzXJP2AjHOLW/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1ODU9zL9mWsfjlQJzz4WjS8IfDlvt_68F/view?usp=sharing

Environment:
Ubuntu 20.04 on Linux 5.4.0
QEMU 4.2.1:
qemu-system-x86_64 \
  -m 2G \
  -smp 2 \
  -kernel /home/workdir/bzImage \
  -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
  -drive file=/home/workdir/stretch.img,format=raw \
  -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
  -net nic,model=e1000 \
  -enable-kvm \
  -nographic \
  -pidfile vm.pid \
  2>&1 | tee vm.log

If you fix this issue, please add the following tag to the commit:
Reported-by:  Jiacheng Xu<stitch@zju.edu.cn>

==========================================================
loop7: detected capacity change from 0 to 96
NILFS (loop7): broken superblock, retrying with spare superblock
(blocksize = 1024)
NILFS (loop7): broken superblock, retrying with spare superblock
(blocksize = 2048)
NILFS (loop7): mounting unchecked fs
NILFS (loop7): recovery complete
sp0: Synchronizing with TNC
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 2 PID: 7259 Comm: syz-executor Not tainted 5.15.58 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail.cold+0x5/0xa lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1337
 slab_pre_alloc_hook mm/slab.h:494 [inline]
 slab_alloc_node mm/slub.c:3129 [inline]
 slab_alloc mm/slub.c:3223 [inline]
 kmem_cache_alloc+0x4e/0x820 mm/slub.c:3228
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:593
 kernfs_new_node+0x93/0x120 fs/kernfs/dir.c:655
 __kernfs_create_file+0x51/0x350 fs/kernfs/file.c:985
 sysfs_add_file_mode_ns+0x226/0x540 fs/sysfs/file.c:317
 sysfs_create_file_ns+0x131/0x1c0 fs/sysfs/file.c:343
 sysfs_create_file include/linux/sysfs.h:607 [inline]
 device_create_file+0xe6/0x1d0 drivers/base/core.c:2762
 device_add+0x5b0/0x1d40 drivers/base/core.c:3338
 device_add_disk+0x2fd/0xf90 block/genhd.c:446
 add_disk include/linux/genhd.h:212 [inline]
 md_alloc+0x947/0x11c0 drivers/md/md.c:5714
 md_probe+0x69/0x70 drivers/md/md.c:5744
 blk_request_module+0x111/0x1d0 block/genhd.c:681
 blkdev_get_no_open+0x178/0x1e0 block/bdev.c:740
 blkdev_get_by_dev block/bdev.c:804 [inline]
 blkdev_get_by_dev+0x73/0x900 block/bdev.c:790
 swsusp_check+0x97/0x2f0 kernel/power/swap.c:1526
 software_resume kernel/power/hibernate.c:977 [inline]
 software_resume+0x124/0x230 kernel/power/hibernate.c:912
 resume_store+0xf1/0x130 kernel/power/hibernate.c:1179
 kobj_attr_store+0x50/0x80 lib/kobject.c:856
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2087 [inline]
 new_sync_write+0x432/0x660 fs/read_write.c:507
 vfs_write+0x67a/0xae0 fs/read_write.c:594
 ksys_write+0x12d/0x250 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7f85eaf61dfd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f85e84c9c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f85eb0880a0 RCX: 00007f85eaf61dfd
RDX: 000000000000fdef RSI: 0000000020002500 RDI: 000000000000000d
RBP: 00007f85e84c9c90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001a
R13: 00007ffe899206df R14: 00007ffe89920880 R15: 00007f85e84c9dc0
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 2 PID: 7259 at block/genhd.c:544
device_add_disk+0x383/0xf90 block/genhd.c:544
Modules linked in:
CPU: 2 PID: 7259 Comm: syz-executor Not tainted 5.15.58 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:device_add_disk+0x383/0xf90 block/genhd.c:544
Code: 74 08 3c 03 0f 8e 02 0a 00 00 8b 5d 00 bf 03 01 00 00 89 de e8
1e 2b a6 fd 81 fb 03 01 00 00 0f 84 3b 02 00 00 e8 ad 29 a6 fd <0f> 0b
41 bc 01 00 00 00 e8 a0 29 a6 fd 44 89 e0 48 83 c4 38 5b 5d
RSP: 0018:ffffc9000826fa08 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000009 RCX: 0000000000040000
RDX: ffffc900018d1000 RSI: ffff888108590000 RDI: 0000000000000002
RBP: ffff888104e6e000 R08: ffffffff83d022a3 R09: 0000000000000103
R10: 0000000000000005 R11: ffffed1021112187 R12: 00000000fffffff4
R13: ffff888108890c00 R14: ffff888104e6e004 R15: ffff888104e6e080
FS:  00007f85e84ca700(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560a42f27150 CR3: 0000000016364000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 add_disk include/linux/genhd.h:212 [inline]
 md_alloc+0x947/0x11c0 drivers/md/md.c:5714
 md_probe+0x69/0x70 drivers/md/md.c:5744
 blk_request_module+0x111/0x1d0 block/genhd.c:681
 blkdev_get_no_open+0x178/0x1e0 block/bdev.c:740
 blkdev_get_by_dev block/bdev.c:804 [inline]
 blkdev_get_by_dev+0x73/0x900 block/bdev.c:790
 swsusp_check+0x97/0x2f0 kernel/power/swap.c:1526
 software_resume kernel/power/hibernate.c:977 [inline]
 software_resume+0x124/0x230 kernel/power/hibernate.c:912
 resume_store+0xf1/0x130 kernel/power/hibernate.c:1179
 kobj_attr_store+0x50/0x80 lib/kobject.c:856
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2087 [inline]
 new_sync_write+0x432/0x660 fs/read_write.c:507
 vfs_write+0x67a/0xae0 fs/read_write.c:594
 ksys_write+0x12d/0x250 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7f85eaf61dfd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f85e84c9c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f85eb0880a0 RCX: 00007f85eaf61dfd
RDX: 000000000000fdef RSI: 0000000020002500 RDI: 000000000000000d
RBP: 00007f85e84c9c90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001a
R13: 00007ffe899206df R14: 00007ffe89920880 R15: 00007f85e84c9dc0
 </TASK>
