Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB01C5A7409
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiHaCoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiHaCoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:44:04 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FEC9A680
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:44:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f12so12728778plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=FRE/1ksuSSeACOgW8Zc4uX4HOs5MJlmYY/kqqHzt/Fk=;
        b=gnD04PAlmm/9p9VyMh4iQh//Y3UDpGQ+JHZj76GIO9PkV+jq+d2hsnNuLxyMlxwehK
         a00d2W8vZy7eHaD7ws6YeyLkb3ZZWBmqQ635ZRubW8KxicWRGVHt8uKeCxBDmhJfMLRN
         v0w+BR5Y7z+9nTzMchFin+u/20s+3cuQsQ31DabeDl7UkjT/iT8pJpPq98arR+u9YEuH
         Aar2XPa3My2knd3WlwQuRN5cMcZqQuFCdZpEBK2BDpPSxoVZCNEHSWnJOoFrG3cef4Ln
         mbFGUtHigNtNg+ZrgeBH8OzK1QUW6eM7sRsv7UNx3iBODSvs5vueSV7pbsNUXX7HNyWS
         HoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=FRE/1ksuSSeACOgW8Zc4uX4HOs5MJlmYY/kqqHzt/Fk=;
        b=hU5akWFgvYFkuqY66ZzUx3D4w2NH1sezEVarcgyCG0FvckXYhtOiMYXFsBFmH+C+gH
         bq1z0G5mozICn06st/ynr9Mlr4OLzPCSzFD6cNpSRPP9I9dH5moA0Ra2K5oIT9EL8Nc6
         ToCUAqWtPmiyaftt3+EbJYJcFLqe1nieLdPZCjU8MwlgNY+wlJ+7zJGeMorJaU/q4XuJ
         IkzdeLtFK2hpnxuE1Jxb0OwyCoU+/dEBB4wSvgoilArg/DJ0VqRHaXnsoYDPp5rYOnOX
         5aLWpoG/nWXz+7Ovq4SUghut3R4sAgBmKSa3hI8py3qvkEVZKyfy3vt5Uopmv38CPeN6
         /DYw==
X-Gm-Message-State: ACgBeo31cvePk3lrkFqhNjIOCx8ID73n6WhgVmozuhEG8biNmyiYyO6i
        i9KMum1amHIAMZ9z58K032M=
X-Google-Smtp-Source: AA6agR5sFi9yFt0P4zW1TS5NqH5+dEPmWaLX3IT8sXZwgYuCMT28UyAikwbOBFg/4VIq5hoDUrP2Xw==
X-Received: by 2002:a17:90b:2bca:b0:1fd:a06b:ef4f with SMTP id ru10-20020a17090b2bca00b001fda06bef4fmr1018294pjb.201.1661913842674;
        Tue, 30 Aug 2022 19:44:02 -0700 (PDT)
Received: from localhost ([36.112.86.8])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b0016d1b70872asm10307294ple.134.2022.08.30.19.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 19:44:02 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com
Cc:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com,
        18801353760@163.com
Subject: [PATCH 0/3] ntfs: fix bugs about Attribute
Date:   Wed, 31 Aug 2022 10:43:32 +0800
Message-Id: <cover.1661875711.git.yin31149@gmail.com>
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

Hawkins Jiawei (3):
  ntfs: fix use-after-free in ntfs_attr_find()
  ntfs: fix out-of-bounds read in ntfs_attr_find()
  ntfs: check overflow when iterates ATTR_RECORDs

 fs/ntfs/attrib.c | 23 +++++++++++++++++++----
 fs/ntfs/inode.c  |  7 +++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.25.1

