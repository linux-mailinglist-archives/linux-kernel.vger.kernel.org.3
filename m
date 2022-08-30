Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A725A65F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiH3OKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiH3OKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E83E2AE2B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B27F61511
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50062C433D6;
        Tue, 30 Aug 2022 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661868618;
        bh=9jvmfxVkEDEXTF+mMxMl1gFBBTusiLQ4TP5tx3/ow2U=;
        h=From:To:Cc:Subject:Date:From;
        b=LL8l90mImhJxlaekcy63LJKtXNiuQGiW07yMVKoDLBIxRsgypBjk4hR8aa68GeNqW
         JL2J643sZgxkKO+YA4QXeeAfI6bpib4bt+KBbQDaYV/PsYEaazCt0aHe0U7Tnp9NTz
         KKT/LyE1kHkdyxbsj0xqX6d4rvVUY+l+dVBHwnz+UyUyud9W6wPFX5iZkQFo+HqLGC
         KdDQVWp+yUk4niFGNfQM+O9Tosd4sGX1izEVdjH0MHSkEz0F9XSr9aeVrXqc5Ybni0
         ckdggUJDG5WTnT4B5GYA0qtEI1rzVdyMimGz2fMu1lEC6hCHebBSJNsLq4veI+dqmm
         bl9gtp0ry5YTQ==
From:   Chao Yu <chao@kernel.org>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        chao@kernel.org, jaegeuk@kernel.org, Chao Yu <chao.yu@oppo.com>,
        stable@kernel.org,
        syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
Subject: [PATCH] mm/slub: fix to return errno if kmalloc() fails
Date:   Tue, 30 Aug 2022 22:10:09 +0800
Message-Id: <20220830141009.150075-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Chao Yu <chao.yu@oppo.com>

In create_unique_id(), kmalloc(, GFP_KERNEL) can fail due to
out-of-memory, if it fails, return errno correctly rather than
triggering panic via BUG_ON();

kernel BUG at mm/slub.c:5893!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP

Call trace:
 sysfs_slab_add+0x258/0x260 mm/slub.c:5973
 __kmem_cache_create+0x60/0x118 mm/slub.c:4899
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x19c/0x31c mm/slab_common.c:335
 kmem_cache_create+0x1c/0x28 mm/slab_common.c:390
 f2fs_kmem_cache_create fs/f2fs/f2fs.h:2766 [inline]
 f2fs_init_xattr_caches+0x78/0xb4 fs/f2fs/xattr.c:808
 f2fs_fill_super+0x1050/0x1e0c fs/f2fs/super.c:4149
 mount_bdev+0x1b8/0x210 fs/super.c:1400
 f2fs_mount+0x44/0x58 fs/f2fs/super.c:4512
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568

Cc: <stable@kernel.org>
Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 mm/slub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..e6f3727b9ad2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5890,7 +5890,8 @@ static char *create_unique_id(struct kmem_cache *s)
 	char *name = kmalloc(ID_STR_LENGTH, GFP_KERNEL);
 	char *p = name;
 
-	BUG_ON(!name);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
 
 	*p++ = ':';
 	/*
@@ -5948,6 +5949,8 @@ static int sysfs_slab_add(struct kmem_cache *s)
 		 * for the symlinks.
 		 */
 		name = create_unique_id(s);
+		if (IS_ERR(name))
+			return PTR_ERR(name);
 	}
 
 	s->kobj.kset = kset;
-- 
2.25.1

