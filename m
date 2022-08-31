Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448E75A82BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiHaQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiHaQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:09:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5B2DB07C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:09:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 202so13886718pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tXwXRwt6PYJ+GZj5FMhmTN+Ui5iZgOEL1ZWov+LGMtM=;
        b=KJmUf5BXSPpg7KvB3wzjzdvm30RxANauiOvOfioDF4dWwZXgD1w6ty9qbgxsbkuiSV
         ioDrN971uusnz/IzGHkRw0j9+d2xJG/S5xlFqNN+fzlpnlNNf+/LDaCh3E7InWHpmIfM
         sPj73+XkyCuEOrrfw+LXRoVT1XfXIRtgzLIQQ3Gc/2PGwJ8u8hZpU0TJLYOYjMMvx/dC
         9PssJRATf+ni9dctqXVT8PlZ+9ee+TWEXokZ3rlEKiRM3HghbMsX1HTJq33D/0kolG6u
         mFiXnzGjyMJvFizMZhb28lI1/s/D1Sq2tXT5hOVYG0DgLLHnilfHHeiw0sRXa4xW3ypu
         h1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tXwXRwt6PYJ+GZj5FMhmTN+Ui5iZgOEL1ZWov+LGMtM=;
        b=b4QpNKjY+9EM1RJZ8GWM6KE8d+XLrWpgkRrk6aNRycs+PfWIwUiWdkUuUwN79P773W
         CRq5eTXaT6mTQCsrxRuX4PO/mhmLEzJDTGguIiEAaOYJhHFvs1683RxtaJRgMl/D9iCY
         o9Q3emj9eeHzFuYgW1ShHQAHEaxTQHu1xM184/4W5elQFh58tXYCcAAyAnm3KpvswhBY
         u0ASflCXWrvI9+Pj5AUNXyFvWAZHb+LLt+NoJuxrDD3pSr2pzY5BxOvU0xSathcPvTtC
         SA4vgDFiP7GcQ7EtEdyH9ZkTIBV1jWa98vsQBgNwpawt6cG3djrFjJy42ey4a/gNEbFk
         0qsA==
X-Gm-Message-State: ACgBeo0YoLelfMjCh+ns3rWcVOC9yyiBjl925zi74tYJVW9vmFTtwV+T
        6FXXFMPv5tO+i5oK04rhyoWhcJYJ6ePONnIp
X-Google-Smtp-Source: AA6agR4XllLlN3Pr/3tNp6mbc3+6FTe5x6+FEl5hhaZl7XkbH2mxdfYcpirfFSpbvtm0cJyA5XkEGw==
X-Received: by 2002:a63:8948:0:b0:430:3da6:7d45 with SMTP id v69-20020a638948000000b004303da67d45mr2055087pgd.109.1661962182401;
        Wed, 31 Aug 2022 09:09:42 -0700 (PDT)
Received: from localhost ([36.112.195.70])
        by smtp.gmail.com with ESMTPSA id u71-20020a62794a000000b005368341381fsm11566083pfc.106.2022.08.31.09.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:09:42 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com
Cc:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com,
        18801353760@163.com
Subject: [PATCH v2 0/3] ntfs: fix bugs about Attribute
Date:   Thu,  1 Sep 2022 00:09:32 +0800
Message-Id: <20220831160935.3409-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes three bugs relative to Attribute in record:

Patch 1 adds a sanity check to ensure that, attrs_offset field in
first mft record loading from disk is within bounds.

Patch 2 moves the ATTR_RECORD's bounds checking earlier, to avoid
dereferencing ATTR_RECORD before checking this ATTR_RECORD is within
bounds.

Patch 3 adds an overflow checking to avoid possible forever loop in
ntfs_attr_find().

Without patch 1 and patch 2, kernel may trigger following problem
reported by Syzkaller:
==================================================================
BUG: KASAN: use-after-free in ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
Read of size 2 at addr ffff88807e352009 by task syz-executor153/3607

[...]
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
 ntfs_attr_lookup+0x1056/0x2070 fs/ntfs/attrib.c:1193
 ntfs_read_inode_mount+0x89a/0x2580 fs/ntfs/inode.c:1845
 ntfs_fill_super+0x1799/0x9320 fs/ntfs/super.c:2854
 mount_bdev+0x34d/0x410 fs/super.c:1400
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 [...]
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001f8d400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e350
head:ffffea0001f8d400 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888011842140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
Memory state around the buggy address:
 ffff88807e351f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807e351f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807e352000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88807e352080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e352100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Although one of patch 1 or patch 2 can fix above bug,  we still
need both of them. Because patch 1 fixes the root cause, and
patch 2 not only fixes the direct cause, but also fixes the
potential out-of-bounds bug.

v1->v2:
 * Refactor check on Attribute Record Header
suggested by Dan Carpenter.
 * Add check bounds on ATTR_RECORD's length suggested
by Dan Carpenter.

Hawkins Jiawei (3):
  ntfs: fix use-after-free in ntfs_attr_find()
  ntfs: fix out-of-bounds read in ntfs_attr_find()
  ntfs: check overflow when iterates ATTR_RECORDs

 fs/ntfs/attrib.c | 28 ++++++++++++++++++++++++----
 fs/ntfs/inode.c  |  7 +++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.25.1

