Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00869471971
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 10:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhLLJRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 04:17:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52578 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhLLJRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 04:17:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3DCF4CE0B0D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 09:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D73C341C6;
        Sun, 12 Dec 2021 09:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639300621;
        bh=elxtjfKOhvAqmW+8MXAqawaVNnq4o0koS73lDKUoLus=;
        h=From:To:Cc:Subject:Date:From;
        b=tNp8drbx6GuzqUybqonJytE1Tz6DSkkDJZmCRv+WeUm90IWESDgxKAtpV8kt3Jqr+
         7AxTzONGEryLfP6023Wdj1UYsL9eRAyStLBWRdN/orBV+K0GviRkySm/JPlX6iApBy
         KkRM2llg3ZgyKie8M1WTlhmEKVfXUo5ti3Abece8nGRIHM055AaYTuNDpnouTTFTTn
         DCuuuHg3oqfhnnaW9GJyC/X0eE/kCeVjWoYdCGSQv8vM3H5McnRX8eIX1K0APs1jlo
         rv+WTirXbnYftuczuQbJLU4TeqviVSbh8HpcnmF7rX/D6oRBuaAYk1yQeIYtoXnDcX
         B3ovDj4G8XJbQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: clean up __find_inline_xattr() with __find_xattr()
Date:   Sun, 12 Dec 2021 17:16:56 +0800
Message-Id: <20211212091656.6404-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleanup, no logic change.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/xattr.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 797ac505a075..8e5cd9c916ff 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -226,15 +226,18 @@ static inline const struct xattr_handler *f2fs_xattr_handler(int index)
 }
 
 static struct f2fs_xattr_entry *__find_xattr(void *base_addr,
-				void *last_base_addr, int index,
-				size_t len, const char *name)
+				void *last_base_addr, void **last_addr,
+				int index, size_t len, const char *name)
 {
 	struct f2fs_xattr_entry *entry;
 
 	list_for_each_xattr(entry, base_addr) {
 		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
-			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr)
+			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
+			if (last_addr)
+				*last_addr = entry;
 			return NULL;
+		}
 
 		if (entry->e_name_index != index)
 			continue;
@@ -254,19 +257,9 @@ static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
 	unsigned int inline_size = inline_xattr_size(inode);
 	void *max_addr = base_addr + inline_size;
 
-	list_for_each_xattr(entry, base_addr) {
-		if ((void *)entry + sizeof(__u32) > max_addr ||
-			(void *)XATTR_NEXT_ENTRY(entry) > max_addr) {
-			*last_addr = entry;
-			return NULL;
-		}
-		if (entry->e_name_index != index)
-			continue;
-		if (entry->e_name_len != len)
-			continue;
-		if (!memcmp(entry->e_name, name, len))
-			break;
-	}
+	entry = __find_xattr(base_addr, max_addr, last_addr, index, len, name);
+	if (!entry)
+		return NULL;
 
 	/* inline xattr header or entry across max inline xattr size */
 	if (IS_XATTR_LAST_ENTRY(entry) &&
@@ -368,7 +361,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	else
 		cur_addr = txattr_addr;
 
-	*xe = __find_xattr(cur_addr, last_txattr_addr, index, len, name);
+	*xe = __find_xattr(cur_addr, last_txattr_addr, NULL, index, len, name);
 	if (!*xe) {
 		f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
 								inode->i_ino);
@@ -659,7 +652,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	last_base_addr = (void *)base_addr + XATTR_SIZE(inode);
 
 	/* find entry with wanted name. */
-	here = __find_xattr(base_addr, last_base_addr, index, len, name);
+	here = __find_xattr(base_addr, last_base_addr, NULL, index, len, name);
 	if (!here) {
 		f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
 								inode->i_ino);
-- 
2.32.0

