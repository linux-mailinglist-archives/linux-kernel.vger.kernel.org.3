Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C331F5A740B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiHaCow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiHaCot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:44:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650FA193
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:44:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 199so13094906pfz.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fiOKZnNdxmLYNBXMmqi3GFFdRwsFMJMRCNCo8og41hE=;
        b=E5sLVuRg4Ke/M/hekHh6NqNyJoXPQnXvAE9dm9Xl+Tp72T4sV2Fq0HVFKUzlJRRmwe
         6nxBecHlXvyNVbcGal2R33DWmh7Z2usuupIFftXcPjvQtqIvWRH/0ZTqWF7NryJOaBvs
         zMmpyWa2GCI7qvVqNtYwueh4zIz6HzleTiSD0Q30O/aV7WmNyQ+JJnpUlc9IybGycBC3
         EleuV082Hr32YeAju4zzyFgcsGrGlvl2zFr1csLdOc+l0euoxmIoNH+C0FFBGkB3CNOX
         XPDzWse6gM0S9L6dt+Z6UAq4Pe/fEP/Zynan0zAps7SfbnFaoTqsVww7tbvw2xl2njzD
         HY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fiOKZnNdxmLYNBXMmqi3GFFdRwsFMJMRCNCo8og41hE=;
        b=DErEX/6jEGhXHaJzYTLSSUvqWi4OfvLNCyd4LocP57VKllFxVpPalrWtbo3w/nUPUa
         w7u9YvaoEmzEtUlHnZgV6xAQCA0TL4VoC71AwTi2jJe3oeS4/8t0na2utZfRgUHcy8dZ
         QucuH6WNUKawevy1nqFREiUaUhlAWDe/ysyAcTdbef6PR8MIrRKiVde3TrE18WnmYVEN
         D5f4SQiI/YwX+uRMrhSBNJLcxtG7OfM1fjt90rq/wth52I/3QM/DYnD9LwsMIKg9d5GQ
         Gbg6SZyrA9x8J71I3E9MLaMi3Z7Tt1BDFYAZBX6Knf+vtagmcH2BQ6+omSy7hjEFo2u3
         hmew==
X-Gm-Message-State: ACgBeo2D4LWYaJXYL8lJ2EEznVPdQSlNdYq3QDf38EohlL2SSb+Hnw3N
        WapmShlIJD06pdQBfgKyLuY=
X-Google-Smtp-Source: AA6agR6uw20aC5DxdaKyiK6ooFu7KbSn4emVYsN+t7F4FHXZDhXDAmVmzBwHDJQ8haxCTDGes/aTGg==
X-Received: by 2002:a05:6a00:804:b0:52f:43f9:b634 with SMTP id m4-20020a056a00080400b0052f43f9b634mr24307126pfk.62.1661913885905;
        Tue, 30 Aug 2022 19:44:45 -0700 (PDT)
Received: from localhost ([36.112.86.8])
        by smtp.gmail.com with ESMTPSA id c73-20020a621c4c000000b00536779d43e7sm9997205pfc.201.2022.08.30.19.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 19:44:45 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     akpm@linux-foundation.org, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com,
        18801353760@163.com
Subject: [PATCH 1/3] ntfs: fix use-after-free in ntfs_attr_find()
Date:   Wed, 31 Aug 2022 10:43:34 +0800
Message-Id: <44b15fb54dbc5b5d8c8726e957d494d38538789e.1661875711.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661875711.git.yin31149@gmail.com>
References: <cover.1661875711.git.yin31149@gmail.com>
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

Syzkaller reported use-after-free read as follows:
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

Kernel will loads $MFT/$DATA's first mft record in
ntfs_read_inode_mount().

Yet the problem is that after loading, kernel doesn't check whether
attrs_offset field is a valid value.

To be more specific, if attrs_offset field is larger
than bytes_allocated field, then it may trigger the out-of-bounds read
bug(reported as use-after-free bug) in ntfs_attr_find(), when kernel
tries to access the corresponding mft record's attribute.

This patch solves it by adding the sanity check between attrs_offset
field and bytes_allocated field, after loading the first mft record.

Reported-and-tested-by: syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/ntfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index db0f1995aedd..08c659332e26 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1829,6 +1829,13 @@ int ntfs_read_inode_mount(struct inode *vi)
 		goto err_out;
 	}
 
+	/* Sanity check offset to the first attribute */
+	if (le16_to_cpu(m->attrs_offset) >= le32_to_cpu(m->bytes_allocated)) {
+		ntfs_error(sb, "Incorrect mft offset to the first attribute %u in superblock.",
+			       le16_to_cpu(m->attrs_offset));
+		goto err_out;
+	}
+
 	/* Need this to sanity check attribute list references to $MFT. */
 	vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
 
-- 
2.25.1

