Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743B3471973
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 10:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhLLJSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 04:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhLLJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 04:17:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C152C061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 01:17:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 580BACE0B17
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 09:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A740AC341C5;
        Sun, 12 Dec 2021 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639300675;
        bh=4UhWf3Jd+rOdwe6f4ewKSADPW73hEhAJ7GGD4MoB2XE=;
        h=From:To:Cc:Subject:Date:From;
        b=mwrO35RVUT5ypEFRh5RiDrbPXWDtoAtHcZqTNbCCXrVnT/RDgWAt833oWxAYMf9IO
         ic9QKj5m1pjxjZXdWiYYUZl+lmRgP61QrMn/ygHiNY/t7GV1sMQw8FzuM5QVIROg3l
         fmwd02iMgejt9fWrA82pIk+zvb5qNLUDOQ3AeZexWmDoc9PGG1w+IyE+hTARkyB0Yy
         Lgbd4ijXfKfbvlVovB5sN7MCfEYOYzOJupNZzogqcqbXtR40aaSU49kCuLP+7jc3gY
         VmG54UBm8KibdVu3ziNWoAx/AsxNLCxNV0RPYKv4rZh1W8hzYCMfLnixEIn5v8RKZt
         KVWz9GPSE4oTg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: support fault injection to f2fs_trylock_op()
Date:   Sun, 12 Dec 2021 17:17:51 +0800
Message-Id: <20211212091751.6499-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs: support fault injection for f2fs_trylock_op()

This patch supports to inject fault into f2fs_trylock_op().

Usage:
a) echo 65536 > /sys/fs/f2fs/<dev>/inject_type or
b) mount -o fault_type=65536 <dev> <mountpoint>

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/filesystems/f2fs.rst | 1 +
 fs/f2fs/f2fs.h                     | 5 +++++
 fs/f2fs/super.c                    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index d7b84695f56a..4a2426f0485a 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -198,6 +198,7 @@ fault_type=%d		 Support configuring fault injection type, should be
 			 FAULT_WRITE_IO		  0x000004000
 			 FAULT_SLAB_ALLOC	  0x000008000
 			 FAULT_DQUOT_INIT	  0x000010000
+			 FAULT_LOCK_OP		  0x000020000
 			 ===================	  ===========
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d2d3b2332e79..f0bee78ce1f3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -56,6 +56,7 @@ enum {
 	FAULT_WRITE_IO,
 	FAULT_SLAB_ALLOC,
 	FAULT_DQUOT_INIT,
+	FAULT_LOCK_OP,
 	FAULT_MAX,
 };
 
@@ -2096,6 +2097,10 @@ static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 
 static inline int f2fs_trylock_op(struct f2fs_sb_info *sbi)
 {
+	if (time_to_inject(sbi, FAULT_LOCK_OP)) {
+		f2fs_show_injection_info(sbi, FAULT_LOCK_OP);
+		return 0;
+	}
 	return down_read_trylock(&sbi->cp_rwsem);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 666dc9aed262..053b508d1e4f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -59,6 +59,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_WRITE_IO]	= "write IO error",
 	[FAULT_SLAB_ALLOC]	= "slab alloc",
 	[FAULT_DQUOT_INIT]	= "dquot initialize",
+	[FAULT_LOCK_OP]		= "lock_op",
 };
 
 void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
-- 
2.32.0

