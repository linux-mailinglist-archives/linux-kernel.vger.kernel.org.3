Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BFA582902
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiG0Ovg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiG0Ov3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:51:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D743329
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91EED618B6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB78C433D6;
        Wed, 27 Jul 2022 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658933485;
        bh=vqSpCepPlYeE/5Z30CAjJpT4GBqxXF90RajlOgrTJLI=;
        h=From:To:Cc:Subject:Date:From;
        b=rXH5gsO3xi1jppwO0JGkyyXJe6nNvBnMS+zs7n4XDocHmIURshNFiwP9Rvoei9tMX
         y35Wh76pqxyj1CSdrPxcO/UzyLcdSov0iEDMgd26FHs/IKa3ET579CqCBygxyq/igc
         HE4e0PVoxOaSB1IDj+DCQLLcTRzpVLcS3tmKIKOSjc9zkcz4XVpqIX2qY0y51xYLN2
         edOg0uEjR4ZiYyS2guPTzZvAD+1yPJLZTT3NnUY23bLFekJgNxwu8yDDGKJhN4tlKv
         r+gcZwpkwc4Ps1FoLxitZ4DkiGcpOgXgovqbFroyD0YDNfwqszAls9Q2UDs3lXzEfh
         EFTkwm1DTH7aQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>,
        Wenqing Liu <wenqingliu0120@gmail.com>
Subject: [PATCH] f2fs: fix to do sanity check on segment type in build_sit_entries()
Date:   Wed, 27 Jul 2022 22:51:05 +0800
Message-Id: <20220727145105.3502-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao.yu@oppo.com>

As Wenqing Liu <wenqingliu0120@gmail.com> reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=216285

RIP: 0010:memcpy_erms+0x6/0x10
 f2fs_update_meta_page+0x84/0x570 [f2fs]
 change_curseg.constprop.0+0x159/0xbd0 [f2fs]
 f2fs_do_replace_block+0x5c7/0x18a0 [f2fs]
 f2fs_replace_block+0xeb/0x180 [f2fs]
 recover_data+0x1abd/0x6f50 [f2fs]
 f2fs_recover_fsync_data+0x12ce/0x3250 [f2fs]
 f2fs_fill_super+0x4459/0x6190 [f2fs]
 mount_bdev+0x2cf/0x3b0
 legacy_get_tree+0xed/0x1d0
 vfs_get_tree+0x81/0x2b0
 path_mount+0x47e/0x19d0
 do_mount+0xce/0xf0
 __x64_sys_mount+0x12c/0x1a0
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The root cause is segment type is invalid, so in f2fs_do_replace_block(),
f2fs accesses f2fs_sm_info::curseg_array with out-of-range segment type,
result in accessing invalid curseg->sum_blk during memcpy in
f2fs_update_meta_page(). Fix this by adding sanity check on segment type
in build_sit_entries().

Reported-by: Wenqing Liu <wenqingliu0120@gmail.com>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/segment.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 51da73b27a45..7b1d2c29aba6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4375,6 +4375,12 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 				return err;
 			seg_info_from_raw_sit(se, &sit);
 
+			if (se->type >= NR_PERSISTENT_LOG) {
+				f2fs_err(sbi, "Invalid segment type: %u, segno: %u",
+							se->type, start);
+				return -EFSCORRUPTED;
+			}
+
 			sit_valid_blocks[SE_PAGETYPE(se)] += se->valid_blocks;
 
 			if (f2fs_block_unit_discard(sbi)) {
@@ -4423,6 +4429,13 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 			break;
 		seg_info_from_raw_sit(se, &sit);
 
+		if (se->type >= NR_PERSISTENT_LOG) {
+			f2fs_err(sbi, "Invalid segment type: %u, segno: %u",
+							se->type, start);
+			err = -EFSCORRUPTED;
+			break;
+		}
+
 		sit_valid_blocks[SE_PAGETYPE(se)] += se->valid_blocks;
 
 		if (f2fs_block_unit_discard(sbi)) {
-- 
2.36.1

