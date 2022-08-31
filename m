Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA655A740C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiHaCpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiHaCpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:45:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4703F402D1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:45:12 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f4so12331137pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CXM0BCPgoVC12DmYCojWwdFvUytvEBCLNePtQadj2oc=;
        b=RVrp23ebjjGVegEPHJqgy0ff2qLxN53Gg1HWF5r/YiVv77Kgq4GIhwO9kVn2Wm/P0u
         avkIr1rT9ecWhiSnp0wCBNBj9pvXAeyRloR3sz7I35GpBGLXoxWRbvoQbgsES1wfgW0L
         hJD3ddwoHspu4Fls+KGySLdVid65hq0HsIPmOsE2NIAnaSOvdxbPO4n9VA70UT4VocfU
         gW+rmTe6jK5+DhaXHRtclDYpNfuYu6MdL/KjDmH+Tp+FnTgxFm5ipbECtqTTb9KwURKb
         zO8x3wsUyfA0CyAh84GYnl/5j5WggZZHMHR3ATmuT4MkyXoyPptGhT/E3MbyWloeBH7b
         4AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CXM0BCPgoVC12DmYCojWwdFvUytvEBCLNePtQadj2oc=;
        b=seNcKSnABJsowkD3zKT/I9+8GaWWXx/3n9aOlhSGZUlQhS0ida61CIDzo5ZoK4y+Wr
         FDSCNrZpDk4pnZHO9VCSNuwxPIwoItNAne317Mywu6cz+Htlx0lwPMf4B8juhvlX1Qjb
         tzp7C/wdcK6JSLMV9e1X01UNqk2mhL29BqH2WmQlbz+CYmvN5+rtyuYSQCLGhtEhzmI/
         3DgzPsQflDOAKuO1zVXECWn2/VE65UEqlXakhMuMUIJ6ByiGF3uOs2KBhdXdsk9btvAV
         uSnmytG2zo34SXMOPT/QbUCyf1q31HeYbMn/Q8Gx0EPymKgHA7g8p0Mmb1VBpA+7ZCgm
         kmZw==
X-Gm-Message-State: ACgBeo2t19ncNHwOHloplDY/OSYHhAViO4jN6/DHO7wT3D/PTX/rRcQ6
        +bFfc5JzDJIw50Ia70m0pCU=
X-Google-Smtp-Source: AA6agR6x/Yx9xBLRaRcgkEuApEi/oYC26IR8aGl/VlV9rHwPX9GFwlqYUbc+Eywr/HgKCZGRAEdjMw==
X-Received: by 2002:a05:6a00:1827:b0:538:3d5f:fd3 with SMTP id y39-20020a056a00182700b005383d5f0fd3mr12463402pfa.28.1661913912405;
        Tue, 30 Aug 2022 19:45:12 -0700 (PDT)
Received: from localhost ([36.112.86.8])
        by smtp.gmail.com with ESMTPSA id b5-20020a1709027e0500b0016c1b178628sm10310035plm.269.2022.08.30.19.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 19:45:12 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     akpm@linux-foundation.org, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com,
        18801353760@163.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/3] ntfs: fix out-of-bounds read in ntfs_attr_find()
Date:   Wed, 31 Aug 2022 10:43:36 +0800
Message-Id: <8a43c95b068e4ca404e864d64a2a44d357754e5c.1661875711.git.yin31149@gmail.com>
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
 fs/ntfs/attrib.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 52615e6090e1..904734e34507 100644
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
+		u8 *name_end, *arec_head_end;
+
+		/* check for wrap around */
+		if ((u8 *)a < (u8 *)ctx->mrec)
+			break;
+
+		/* check whether Attribute Record Header is within bounds */
+		arec_head_end = (u8 *)a + sizeof(ATTR_RECORD);
+		if (arec_head_end < (u8 *)a || arec_head_end > mrec_end)
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

