Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF124CCB6D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiCDBuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiCDBuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:50:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963D113AC4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 17:49:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05D861919
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6992C004E1;
        Fri,  4 Mar 2022 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646358571;
        bh=U1b317/wpcSgTU7Qr1li/gOaprCbUdBb29db2JJVOyM=;
        h=From:To:Cc:Subject:Date:From;
        b=L9yD5otWB5qDhe2cbNJm2JTJ0aI5ueAn5Wspes/inr35LmG+7sZi/k5NsVlwKrIlc
         0ljAK2m1NlLHfctSQABTBaFnHphwph0wPoBnDEZeXjENbf2nSuZwjiLT/33oWwC8M2
         9eE0jdRCs7V8Txnz3CHDZ2UUpch6jY5V/EgJUTRlNBLGtLQcpbFQgvjieqsd4KsyCB
         5VVoKdNvbH/m9b+l2JYYaa56GWRHiwTZ9u3nrewo+kmtclEJ1lIqa+88gAVG4y6EZj
         B1v6z4GNYYZrRjES6vN/5OQGsOyWqkpGQ6HYWcrKKUbeey6FK2G9iO2cxTKO7FsBGG
         xdQKxfid9ABzQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to do sanity check on curseg->alloc_type
Date:   Fri,  4 Mar 2022 09:49:13 +0800
Message-Id: <20220304014913.3966369-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Wenqing Liu reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=215657

- Overview
UBSAN: array-index-out-of-bounds in fs/f2fs/segment.c:3460:2 when mount and operate a corrupted image

- Reproduce
tested on kernel 5.17-rc4, 5.17-rc6

1. mkdir test_crash
2. cd test_crash
3. unzip tmp2.zip
4. mkdir mnt
5. ./single_test.sh f2fs 2

- Kernel dump
[   46.434454] loop0: detected capacity change from 0 to 131072
[   46.529839] F2FS-fs (loop0): Mounted with checkpoint version = 7548c2d9
[   46.738319] ================================================================================
[   46.738412] UBSAN: array-index-out-of-bounds in fs/f2fs/segment.c:3460:2
[   46.738475] index 231 is out of range for type 'unsigned int [2]'
[   46.738539] CPU: 2 PID: 939 Comm: umount Not tainted 5.17.0-rc6 #1
[   46.738547] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   46.738551] Call Trace:
[   46.738556]  <TASK>
[   46.738563]  dump_stack_lvl+0x47/0x5c
[   46.738581]  ubsan_epilogue+0x5/0x50
[   46.738592]  __ubsan_handle_out_of_bounds+0x68/0x80
[   46.738604]  f2fs_allocate_data_block+0xdff/0xe60 [f2fs]
[   46.738819]  do_write_page+0xef/0x210 [f2fs]
[   46.738934]  f2fs_do_write_node_page+0x3f/0x80 [f2fs]
[   46.739038]  __write_node_page+0x2b7/0x920 [f2fs]
[   46.739162]  f2fs_sync_node_pages+0x943/0xb00 [f2fs]
[   46.739293]  f2fs_write_checkpoint+0x7bb/0x1030 [f2fs]
[   46.739405]  kill_f2fs_super+0x125/0x150 [f2fs]
[   46.739507]  deactivate_locked_super+0x60/0xc0
[   46.739517]  deactivate_super+0x70/0xb0
[   46.739524]  cleanup_mnt+0x11a/0x200
[   46.739532]  __cleanup_mnt+0x16/0x20
[   46.739538]  task_work_run+0x67/0xa0
[   46.739547]  exit_to_user_mode_prepare+0x18c/0x1a0
[   46.739559]  syscall_exit_to_user_mode+0x26/0x40
[   46.739568]  do_syscall_64+0x46/0xb0
[   46.739584]  entry_SYSCALL_64_after_hwframe+0x44/0xae

The root cause is we missed to do sanity check on curseg->alloc_type,
result in out-of-bound accessing on sbi->block_count[] array, fix it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 56211e201d51..012524db7437 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4793,6 +4793,13 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
 
 		sanity_check_seg_type(sbi, curseg->seg_type);
 
+		if (curseg->alloc_type != LFS && curseg->alloc_type != SSR) {
+			f2fs_err(sbi,
+				 "Current segment has invalid alloc_type:%d",
+				 curseg->alloc_type);
+			return -EFSCORRUPTED;
+		}
+
 		if (f2fs_test_bit(blkofs, se->cur_valid_map))
 			goto out;
 
-- 
2.25.1

