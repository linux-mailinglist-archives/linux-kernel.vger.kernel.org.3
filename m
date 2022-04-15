Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E143F502ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353934AbiDONXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352586AbiDONXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:23:18 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DE1AAC83
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:20:45 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 23FDJ3rw021361-23FDJ3s1021361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 15 Apr 2022 21:19:07 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: f2fs: remove WARN_ON in f2fs_is_valid_blkaddr
Date:   Fri, 15 Apr 2022 21:19:02 +0800
Message-Id: <20220415131902.55028-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

Syzbot triggers two WARNs in f2fs_is_valid_blkaddr and
__is_bitmap_valid. For example, in f2fs_is_valid_blkaddr,
if type is DATA_GENERIC_ENHANCE or DATA_GENERIC_ENHANCE_READ,
it invokes WARN_ON if blkaddr is not in the right range.
The call trace is as follows:

 f2fs_get_node_info+0x45f/0x1070
 read_node_page+0x577/0x1190
 __get_node_page.part.0+0x9e/0x10e0
 __get_node_page
 f2fs_get_node_page+0x109/0x180
 do_read_inode
 f2fs_iget+0x2a5/0x58b0
 f2fs_fill_super+0x3b39/0x7ca0

Fix these two WARNs by replacing WARN_ON with dump_stack.

Reported-by: syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
v1->v2: as suggested by Chao Yu, change WARN_ON to dump_stack
 fs/f2fs/checkpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f5366feea82d..4dfae0cc6b16 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -158,7 +158,7 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
 			 blkaddr, exist);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		WARN_ON(1);
+		dump_stack();
 	}
 	return exist;
 }
@@ -196,7 +196,7 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 			f2fs_warn(sbi, "access invalid blkaddr:%u",
 				  blkaddr);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			WARN_ON(1);
+			dump_stack();
 			return false;
 		} else {
 			return __is_bitmap_valid(sbi, blkaddr, type);
-- 
2.25.1

