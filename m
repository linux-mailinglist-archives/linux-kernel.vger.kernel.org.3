Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DFF523D52
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245748AbiEKTVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346762AbiEKTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:21:34 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3044C5D5E1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:21:33 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id q12-20020a0566022f0c00b0065af7776ee7so1696459iow.17
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ot1OWyPBUaYmsL/rpRXMCMJU20uzrbWIkZX+H6+xufs=;
        b=PRFfHllMoEa4IT5+E8XIyfHO/YPhzkdEtI6671LOjGnH2aGxLxnNXTW7LwA8Oz/WEW
         PrSkd8GMa6TxJdomT/6s/qujNhxWfOpsUOaWRjPVWCytGf+cEMN4aE0w8YoM3YNIqVMF
         yAFv1vB525+S+BlfIKAMtLvD/aJKs7rEaAk3FraKs8L3pf1k8fo3hNQUMUdFoUrZr6mI
         9Fvi3svUmOS091GEvCE1/WCQZp/RhzQs6DI6Q0ZFdVPpHJuAhTDAGA93cMH/NLMjQego
         2pJu/cTO9NEaJsZn2q9qkqtkQstzh4us8GDcy+eCTfP+rac2jSZ4tgQu31R6tKmSXHgA
         15MQ==
X-Gm-Message-State: AOAM5329RmKVcFv7P3MF09HJiXXE1/rTySgbQutf75SLc5hi0SJHgMLZ
        lofIOZdFCDKWlpl7OUOrDtoJy/wM6DDMjCMCiM9J4OoX8dls
X-Google-Smtp-Source: ABdhPJyvOsk/u2xVrvdbkaOMguoZ2YYFEphNw6wj66dFQA7gnt8Ylv8Ln1GUDoRgRJ+1nTHEacRmiGq5+0TafVTg7ibH/nyElN6P
MIME-Version: 1.0
X-Received: by 2002:a05:6638:cd3:b0:32a:eec5:bbca with SMTP id
 e19-20020a0566380cd300b0032aeec5bbcamr13461113jak.99.1652296892381; Wed, 11
 May 2022 12:21:32 -0700 (PDT)
Date:   Wed, 11 May 2022 12:21:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000557fe905dec159a6@google.com>
Subject: [syzbot] memory leak in blk_ioprio_init
From:   syzbot <syzbot+5d564137a4c4677abcf1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    feb9c5e19e91 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104f2666f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f33cdac6164584bd
dashboard link: https://syzkaller.appspot.com/bug?extid=5d564137a4c4677abcf1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12071811f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ffd166f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d564137a4c4677abcf1@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810a36cc80 (size 64):
  comm "syz-executor844", pid 3616, jiffies 4294958438 (age 12.560s)
  hex dump (first 32 bytes):
    80 99 ca 85 ff ff ff ff 40 16 93 04 81 88 ff ff  ........@.......
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82338d25>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff82338d25>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff82338d25>] blk_ioprio_init+0x25/0xf0 block/blk-ioprio.c:233
    [<ffffffff8233169d>] blkcg_init_queue+0xcd/0x1f0 block/blk-cgroup.c:1216
    [<ffffffff82317c6e>] __alloc_disk_node+0x11e/0x230 block/genhd.c:1381
    [<ffffffff82317db5>] __blk_alloc_disk+0x35/0x70 block/genhd.c:1421
    [<ffffffff832f7574>] md_alloc+0x5d4/0x830 drivers/md/md.c:5697
    [<ffffffff832f7839>] md_probe+0x69/0x70 drivers/md/md.c:5746
    [<ffffffff8231858a>] blk_request_module+0x8a/0x110 block/genhd.c:716
    [<ffffffff822e79f7>] blkdev_get_no_open+0x77/0xc0 block/bdev.c:737
    [<ffffffff822e7a63>] blkdev_get_by_dev.part.0+0x23/0x520 block/bdev.c:794
    [<ffffffff822e7fcb>] blkdev_get_by_dev+0x6b/0x80 block/bdev.c:850
    [<ffffffff822e9337>] blkdev_open+0xb7/0x130 block/fops.c:498
    [<ffffffff815b4be6>] do_dentry_open+0x1e6/0x650 fs/open.c:824
    [<ffffffff815db0a1>] do_open fs/namei.c:3476 [inline]
    [<ffffffff815db0a1>] path_openat+0x18a1/0x1e70 fs/namei.c:3609
    [<ffffffff815ddd71>] do_filp_open+0xc1/0x1b0 fs/namei.c:3636
    [<ffffffff815b83bd>] do_sys_openat2+0xed/0x260 fs/open.c:1213
    [<ffffffff815b8e0f>] do_sys_open fs/open.c:1229 [inline]
    [<ffffffff815b8e0f>] __do_sys_openat fs/open.c:1245 [inline]
    [<ffffffff815b8e0f>] __se_sys_openat fs/open.c:1240 [inline]
    [<ffffffff815b8e0f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1240

BUG: memory leak
unreferenced object 0xffff88810f6c7780 (size 96):
  comm "syz-executor844", pid 3616, jiffies 4294958438 (age 12.560s)
  hex dump (first 32 bytes):
    c0 9f ca 85 ff ff ff ff 40 16 93 04 81 88 ff ff  ........@.......
    01 00 00 00 00 00 00 00 80 cc 36 0a 81 88 ff ff  ..........6.....
  backtrace:
    [<ffffffff8233b228>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8233b228>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8233b228>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff823316f5>] blkcg_init_queue+0x125/0x1f0 block/blk-cgroup.c:1224
    [<ffffffff82317c6e>] __alloc_disk_node+0x11e/0x230 block/genhd.c:1381
    [<ffffffff82317db5>] __blk_alloc_disk+0x35/0x70 block/genhd.c:1421
    [<ffffffff832f7574>] md_alloc+0x5d4/0x830 drivers/md/md.c:5697
    [<ffffffff832f7839>] md_probe+0x69/0x70 drivers/md/md.c:5746
    [<ffffffff8231858a>] blk_request_module+0x8a/0x110 block/genhd.c:716
    [<ffffffff822e79f7>] blkdev_get_no_open+0x77/0xc0 block/bdev.c:737
    [<ffffffff822e7a63>] blkdev_get_by_dev.part.0+0x23/0x520 block/bdev.c:794
    [<ffffffff822e7fcb>] blkdev_get_by_dev+0x6b/0x80 block/bdev.c:850
    [<ffffffff822e9337>] blkdev_open+0xb7/0x130 block/fops.c:498
    [<ffffffff815b4be6>] do_dentry_open+0x1e6/0x650 fs/open.c:824
    [<ffffffff815db0a1>] do_open fs/namei.c:3476 [inline]
    [<ffffffff815db0a1>] path_openat+0x18a1/0x1e70 fs/namei.c:3609
    [<ffffffff815ddd71>] do_filp_open+0xc1/0x1b0 fs/namei.c:3636
    [<ffffffff815b83bd>] do_sys_openat2+0xed/0x260 fs/open.c:1213
    [<ffffffff815b8e0f>] do_sys_open fs/open.c:1229 [inline]
    [<ffffffff815b8e0f>] __do_sys_openat fs/open.c:1245 [inline]
    [<ffffffff815b8e0f>] __se_sys_openat fs/open.c:1240 [inline]
    [<ffffffff815b8e0f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1240



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
