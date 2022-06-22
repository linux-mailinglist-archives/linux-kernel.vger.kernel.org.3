Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9589C556EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359829AbiFVXNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358749AbiFVXNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:13:24 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B246390
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:13:20 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id s16-20020a056602241000b0067276d240e3so1096024ioa.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MomU7bIoJuWVlY/2Bf1iAKYewaUl77BXPmEN6eAnyC0=;
        b=jfqLdVhd7pbB29FKxE66DU/zscArWGt8NBwu+B/tbC8s/KpNPrgVZRK2Wk9SkCJzjI
         j5bA5w4dAh+1IRHXHHgzVVJQZxoxn5hU4in88Nw/eY8n18QL/4OiCm+TJeKnEJWNXn8y
         fI0+MyR2NNtmNuB3n+jAwwLmLCEc1fzbtdpr1x2N+tAiZZLCLGh7aS7CP5GjDuapzORT
         5ixYM8Ikbj43D22fWIhXe0d9uxStVqUCkkBkKHdivEj5ufbB69Y3d1ZZ/iQZooa4pb1q
         DghltSkn0+hxbzkIG7mdq4ABw0wn7ZPKMBkW5whiaMb/v2SJkRzig+OIEn5EpK9J8j7j
         QFnw==
X-Gm-Message-State: AJIora/Whxl7CgYPHjb4WFaq/QvNdnn/QNkXlhdLY6h1ELct4V0b0bmW
        lvtjmj75nH1+9hhlQc0IsbsC/wfiZkaZ8kWGFF0H48JM4Lna
X-Google-Smtp-Source: AGRyM1uvwe9S1dSRxy2ige/+9VWLfdcKoGrwPHYeSRXbaTJUr6ig6rYj2YZADOTU2K78J7mQgwy83cu5jMECWk5MlDeiQsKnNzCi
MIME-Version: 1.0
X-Received: by 2002:a05:6638:30f:b0:339:d7d8:c21f with SMTP id
 w15-20020a056638030f00b00339d7d8c21fmr3603458jap.247.1655939599469; Wed, 22
 Jun 2022 16:13:19 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:13:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098972c05e2117b39@google.com>
Subject: [syzbot] memory leak in kobject_set_name_vargs (5)
From:   syzbot <syzbot+7381dc4ad60658ca4c05@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    4b35035bcf80 Merge tag 'nfs-for-5.19-2' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16db143ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3136c902c03fdd37
dashboard link: https://syzkaller.appspot.com/bug?extid=7381dc4ad60658ca4c05
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111c8c1ff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7381dc4ad60658ca4c05@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811943b700 (size 32):
  comm "syz-executor.7", pid 3953, jiffies 4294958653 (age 15.830s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814b7106>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814b7193>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239acd2>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff8249179b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82491c1d>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82491c1d>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e2c07a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81e1482c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81e004db>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81e004db>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8163fb5b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815d95c8>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff8161d097>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff8161d097>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff8161dcce>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8161dcce>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8161dcce>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8161dcce>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845a9cb5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845a9cb5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
