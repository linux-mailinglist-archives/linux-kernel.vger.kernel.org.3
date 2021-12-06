Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C9A46995A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbhLFOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:48:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47614 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238895AbhLFOsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:48:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0661F612EE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F72C341C7;
        Mon,  6 Dec 2021 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638801881;
        bh=+wGjoWxtrdJzbDER7vNy2XoGsXgjIrVFYt/HaUrfQKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhTdYDSmLMO39Gk9mgAJAdhsGEzVXNyea1u1iSkFyZBCqmVHkbTtU+X3oFKi34UFX
         ueXDyXf7y2ggUAr/pNFLZbJsTk0SyeQA/6IwYfvaD48iCZltyv4lvcOrQoGUyXQZUc
         o4EQoCzIO5hx76W/OTtwIEyR7ZIepDip9Frak1sjL/9nMwzdxnvu2WnvQ8lQIvSa4a
         V+RMr6QNLGlnq33iSPxEcwxWEDZCyauJFPvxVy6oFOERQNQ48Nn8Mg873XACgepRFS
         fBSQaZ/c4BNo+V8OgWOS5vK0O8hazX8gIRhSK/IKsrvsFcee0Tm9HCabM39eXGANxa
         coJpXyYw+mMYw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: fix to avoid panic in is_alive() if metadata is inconsistent
Date:   Mon,  6 Dec 2021 22:44:20 +0800
Message-Id: <20211206144421.3735-2-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206144421.3735-1-chao@kernel.org>
References: <20211206144421.3735-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As report by Wenqing Liu in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=215231

If we enable CONFIG_F2FS_CHECK_FS config, and with fuzzed image attached
in above link, we will encounter panic when executing below script:

1. mkdir mnt
2. mount -t f2fs tmp1.img mnt
3. touch tmp

F2FS-fs (loop11): mismatched blkaddr 5765 (source_blkaddr 1) in seg 3
kernel BUG at fs/f2fs/gc.c:1042!
 do_garbage_collect+0x90f/0xa80 [f2fs]
 f2fs_gc+0x294/0x12a0 [f2fs]
 f2fs_balance_fs+0x2c5/0x7d0 [f2fs]
 f2fs_create+0x239/0xd90 [f2fs]
 lookup_open+0x45e/0xa90
 open_last_lookups+0x203/0x670
 path_openat+0xae/0x490
 do_filp_open+0xbc/0x160
 do_sys_openat2+0x2f1/0x500
 do_sys_open+0x5e/0xa0
 __x64_sys_openat+0x28/0x40

Previously, f2fs tries to catch data inconcistency exception in between
SSA and SIT table during GC, however once the exception is caught, it will
call f2fs_bug_on to hang kernel, it's not needed, instead, let's set
SBI_NEED_FSCK flag and skip migrating current block.

Fixes: bbf9f7d90f21 ("f2fs: Fix indefinite loop in f2fs_gc()")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e0bdc4361a9b..3e64b234df21 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1039,7 +1039,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
 				f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u",
 					 blkaddr, source_blkaddr, segno);
-				f2fs_bug_on(sbi, 1);
+				set_sbi_flag(sbi, SBI_NEED_FSCK);
 			}
 		}
 #endif
-- 
2.32.0

