Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0895A82C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiHaQMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiHaQM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:12:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC3D11F1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:12:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q15so9513978pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=f8MgvGh+ksHn1mHkWpjvZ43exvRjNzmYkYNUVIU3dnI=;
        b=N9vsfmbi93IeCMV0maJHVIvMTC6H2nPgQxnlPoOFJFEQzYYzYI3FxpE9EKxTENxN76
         HlxRpRUP0AlmAskrDYhxf9LUQ+I+eFP/e5H+lB6j01dDuB0FubyTBGhLoMrrub7ZPXer
         uYyc/gmNhT7dZQiyUTV59Fc2p6/i59TEQrVLfeTnC1WlIckL3GOIsGOvZD91mLeZjIrE
         8Gy2V5wsSUBmoJdZfftBrHRu+snegVnG4Hc2v2DkEOZPqfEpb1nnaD1amm3of49arl+U
         Mq9mSbSq5VQhT8uDrUjkwj19rYYW9qdkg6Xx4o6t5pX3XD3JoCv1zvrxMlL/MWIb9ET+
         ohEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f8MgvGh+ksHn1mHkWpjvZ43exvRjNzmYkYNUVIU3dnI=;
        b=Qdn+ZvFOXvugQf9X0NgFPUD3U2GzWQ0ujso9pk/yfnE/s8t8+fXOSl4X1s/CrJNELn
         qEN2SXFs8VK5BYqO8mCNzPSrQ6TSG4+bBdvtNH9DmjH+narGwjaIsxRqpRukN2J/3GwT
         z+VgUF6jWcbujJzzj6mYrNlBJMlWdB1XLJRcv48k2Kvuk3t2WvzY/XHrz0JOmaY5AzfH
         OGWwdWosDd0FbNTc9tkQZX+gDRgpBYKrNQHmlh2wmac+/nRPRecrq2G4tBETOBpfV0mE
         GzVFSvwvOFrBRmphDUM1uZu4fyazf1+xgSEEkff99QiGwVtjl/k8VXb3ens3ZgLJ2uOn
         SVlA==
X-Gm-Message-State: ACgBeo1/KDHbHbwlnF49Gsf4f9K2vYMZmLOoLnlqpX+CajiA81KmoQKu
        I25XDeveNgT9VtGijuc1Kzc=
X-Google-Smtp-Source: AA6agR5sUHH4T3dAKze9jkp5hKoKpRegW3m0w6N5czp+D02Q+Qy6zxLre8UGpdUtsxYF5C5OthN1DQ==
X-Received: by 2002:a63:256:0:b0:42f:b14b:2085 with SMTP id 83-20020a630256000000b0042fb14b2085mr6104065pgc.189.1661962341421;
        Wed, 31 Aug 2022 09:12:21 -0700 (PDT)
Received: from localhost ([36.112.195.70])
        by smtp.gmail.com with ESMTPSA id x11-20020a17090ab00b00b001fbc0e9edafsm1470409pjq.56.2022.08.31.09.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:12:21 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     akpm@linux-foundation.org, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com,
        18801353760@163.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 2/3] ntfs: fix out-of-bounds read in ntfs_attr_find()
Date:   Thu,  1 Sep 2022 00:09:36 +0800
Message-Id: <20220831160935.3409-3-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831160935.3409-1-yin31149@gmail.com>
References: <20220831160935.3409-1-yin31149@gmail.com>
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

Kernel will iterates over ATTR_RECORDs in mft record in ntfs_attr_find().
To ensure access on these ATTR_RECORDs are within bounds, kernel will
do some checking during iteration.

The problem is that during checking whether ATTR_RECORD's name is within
bounds, kernel will dereferences the ATTR_RECORD name_offset field,
before checking this ATTR_RECORD strcture is within bounds. This problem
may result out-of-bounds read in ntfs_attr_find(), reported by
Syzkaller:

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

This patch solves it by moving the ATTR_RECORD strcture's bounds
checking earlier, then checking whether ATTR_RECORD's name
is within bounds. What's more, this patch also add some comments
to improve its maintainability.

Reported-and-tested-by: syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com
Signed-off-by: chenxiaosong (A) <chenxiaosong2@huawei.com>
Link: https://lore.kernel.org/all/1636796c-c85e-7f47-e96f-e074fee3c7d3@huawei.com/
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://groups.google.com/g/syzkaller-bugs/c/t_XdeKPGTR4/m/LECAuIGcBgAJ
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v1->v2:
 * Refactor check on Attribute Record Header
suggested by Dan Carpenter.

 fs/ntfs/attrib.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 52615e6090e1..cec4be2a2d23 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -594,11 +594,23 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
 	for (;;	a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
 		u8 *mrec_end = (u8 *)ctx->mrec +
 		               le32_to_cpu(ctx->mrec->bytes_allocated);
-		u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
-			       a->name_length * sizeof(ntfschar);
-		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
-		    name_end > mrec_end)
+		u8 *name_end;
+
+		/* check whether ATTR_RECORD wrap */
+		if ((u8 *)a < (u8 *)ctx->mrec)
+			break;
+
+		/* check whether Attribute Record Header is within bounds */
+		if ((u8 *)a > mrec_end ||
+		    (u8 *)a + sizeof(ATTR_RECORD) > mrec_end)
 			break;
+
+		/* check whether ATTR_RECORD's name is within bounds */
+		name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
+			   a->name_length * sizeof(ntfschar);
+		if (name_end > mrec_end)
+			break;
+
 		ctx->attr = a;
 		if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
 				a->type == AT_END))
-- 
2.25.1

