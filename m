Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590294E9BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbiC1QEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbiC1QEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:04:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EF85DE50
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D934BB810D5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 16:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F74BC004DD;
        Mon, 28 Mar 2022 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648483385;
        bh=P0P3Lnt4gmVt++k6Xk8i+eUeKJePtopQkH5guyzaals=;
        h=From:To:Cc:Subject:Date:From;
        b=oEzW3aC2jtw45GDsyEznM0jFg8h+Yzbq/A+p0lUe6s0UE/V+mpj8F1WgbxJpOC1T/
         yPgto4nsBiPimjOwwvze5QLkxulYoqi3uh7+YyIGHf/Em/ACHGvYfjrhw5FM3z9pNt
         CdbLyYP3WOvSLPfWzJF++nW79ZiQClnPj1D3yFuNE3QLDx29iUO6EdDNGkLfxDWWQ8
         TPJl/vI91vEINeKuW7cDofEkBBUhxPqyvQomUur8LciuSTtpnGPhcygAf1cYNpZTuh
         qRrAel1D7zGYsEMNIZZoKiAZjnkr4YEfXbxmXpJDLTlZ6OXDt74jeS8Kspx82WcLn4
         g+ERzIdLrxWew==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Wenqing Liu <wenqingliu0120@gmail.com>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: fix to do sanity check on inline_dots inode
Date:   Tue, 29 Mar 2022 00:02:53 +0800
Message-Id: <20220328160253.3102-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Wenqing reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=215765

It will cause a kernel panic with steps:
- mkdir mnt
- mount tmp40.img mnt
- ls mnt

folio_mark_dirty+0x33/0x50
f2fs_add_regular_entry+0x541/0xad0 [f2fs]
f2fs_add_dentry+0x6c/0xb0 [f2fs]
f2fs_do_add_link+0x182/0x230 [f2fs]
__recover_dot_dentries+0x2d6/0x470 [f2fs]
f2fs_lookup+0x5af/0x6a0 [f2fs]
__lookup_slow+0xac/0x200
lookup_slow+0x45/0x70
walk_component+0x16c/0x250
path_lookupat+0x8b/0x1f0
filename_lookup+0xef/0x250
user_path_at_empty+0x46/0x70
vfs_statx+0x98/0x190
__do_sys_newlstat+0x41/0x90
__x64_sys_newlstat+0x1a/0x30
do_syscall_64+0x37/0xb0
entry_SYSCALL_64_after_hwframe+0x44/0xae

The root cause is for special file: e.g. character, block, fifo or
socket file, f2fs doesn't assign address space operations pointer array
for mapping->a_ops field, so, in a fuzzed image, if inline_dots flag was
tagged in special file, during lookup(), when f2fs runs into
__recover_dot_dentries(), it will cause NULL pointer access once
f2fs_add_regular_entry() calls a_ops->set_dirty_page().

Fixes: 510022a85839 ("f2fs: add F2FS_INLINE_DOTS to recover missing dot dentries")
Reported-by: Wenqing Liu <wenqingliu0120@gmail.com>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/namei.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 906e9e301ac8..e3f23ae9bb19 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -461,6 +461,13 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 		return 0;
 	}
 
+	if (!S_ISDIR(dir->i_mode)) {
+		f2fs_err(sbi, "inconsistent inode status, skip recovering inline_dots inode (ino:%lu, i_mode:%u, pino:%u)",
+			  dir->i_ino, dir->i_mode, pino);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		return -ENOTDIR;
+	}
+
 	err = f2fs_dquot_initialize(dir);
 	if (err)
 		return err;
-- 
2.32.0

