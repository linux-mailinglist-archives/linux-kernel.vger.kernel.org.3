Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F814774E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhLPOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLPOqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:46:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E02EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:46:11 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c6so751148plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYu6jkE9mC5EqzWSMs0sHWtkpkosTO/wJoYnnIHVS8s=;
        b=yKO91YT+/Jc+If7nShBSGfZaIBlXosKfX6YRmEZnVXerxEYn1Ytd072EpSQppbKtk+
         IGwO3/h2chGq1ABTbQbnDvqVjp2ibQdtF0QkHEja1FDzx9G/u3/5TrBGYoGp0t1lsD5W
         nkZ5RzA2kwSNQpiH0xfxUDae9cvYZbsbl5mMrgt6mNUnHPqV6L3rt20tELK2GRcnZzxL
         YfChhlrSCw0mcug8o/lZ+KxcQnc+tFFkGAbwuojl241BtMef/riTpW6/t6RBX75tVbHj
         mDQGmEpq215upL3smcctREVFv5rLthDJnllAlqUqDQhHvC4Dg3N2aUrgr3n2IspynJgq
         eXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYu6jkE9mC5EqzWSMs0sHWtkpkosTO/wJoYnnIHVS8s=;
        b=49mhI8aKq/Wczi8eyFn9MCAWZbf62lkiyx5cz1r4IOhiKKrfKXxDmlv6Z248T5w+O0
         2pfSEGeOLi4SNfNmQnksBaQ0emxnvL123/Hqq95RId1Pw4YpwAZv5YJpYbBGMKaDhCkG
         4q8UE4izMQQSa9c2nqWHvEbnd5OueaBb9sUlVJYzQzi9F1mQVgkgdJ3c0ijfpGRsYDk5
         1T+SjX0ncTBiuJWGcWRPJ2kQJ6Tbv6QqwpPxinyeCSSfakDuiNbHtUHeZ78dd6f8Jlr/
         KHo3CNdl+Qs5Bebx1OAh0EFcDcbVI12nA8opXRmd6ExYBNO7XhwAPk+7YmOytaYT163e
         0nsA==
X-Gm-Message-State: AOAM5330pnhIABNbiDeK6nHeQ6xBFwuwjqn8fLriSytNYAJiD9JhU4h4
        8ThKyAPsHD6xTKuI8CC2elcGK+icbRPP/g==
X-Google-Smtp-Source: ABdhPJxqqQakxgtZ4jCpo+kNykWtVaxdYFQj/nfy5ZBD6qwDzxx30KkbRJKudiAzKAxMbXTz8FwrmA==
X-Received: by 2002:a17:90b:1e0e:: with SMTP id pg14mr6319635pjb.143.1639665970759;
        Thu, 16 Dec 2021 06:46:10 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id p2sm5642735pja.55.2021.12.16.06.46.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:46:10 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH] fuse: fix deadlock between O_TRUNC open() and non-O_TRUNC open()
Date:   Thu, 16 Dec 2021 22:45:58 +0800
Message-Id: <20211216144558.63931-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fuse_finish_open() will be called with FUSE_NOWRITE set in case of atomic
O_TRUNC open(), so commit 76224355db75 ("fuse: truncate pagecache on
atomic_o_trunc") replaced invalidate_inode_pages2() by truncate_pagecache()
in such a case to avoid the A-A deadlock. However, we found another A-B-B-A
deadlock related to the case above, which will cause the xfstests
generic/464 testcase hung in our virtio-fs test environment.

Consider two processes concurrently open one same file, one with O_TRUNC
and another without O_TRUNC. The deadlock case is described below, if
open(O_TRUNC) is already set_nowrite(acquired A), and is trying to lock
a page (acquiring B), open() could have held the page lock (acquired B),
and waiting on the page writeback (acquiring A). This would lead to
deadlocks.

This commit tries to fix it by locking inode in fuse_open_common() even
if O_TRUNC is not set. This introduces a lock C to protect the area with
A-B-B-A the deadlock rick.

open(O_TRUNC)
----------------------------------------------------------------
fuse_open_common
  lock_inode		[C acquire]
  fuse_set_nowrite	[A acquire]

  fuse_finish_open
    truncate_pagecache
      lock_page		[B acquire]
      truncate_inode_page
      unlock_page	[B release]

  fuse_release_nowrite	[A release]
  unlock_inode		[C release]
----------------------------------------------------------------

open()
----------------------------------------------------------------
fuse_open_common
  (lock_inode)		[C acquire, introduced by this commit]

  fuse_finish_open
    invalidate_inode_pages2
      lock_page		[B acquire]
        fuse_launder_page
          fuse_wait_on_page_writeback [A acquire]
      unlock_page	[B release]

  (unlock_inode)	[C release, introduced by this commit]
----------------------------------------------------------------

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/file.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..73fec30e0a37 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -229,8 +229,10 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	bool is_wb_truncate = (file->f_flags & O_TRUNC) &&
 			  fc->atomic_o_trunc &&
 			  fc->writeback_cache;
-	bool dax_truncate = (file->f_flags & O_TRUNC) &&
+	bool is_dax_truncate = (file->f_flags & O_TRUNC) &&
 			  fc->atomic_o_trunc && FUSE_IS_DAX(inode);
+	bool may_truncate = fc->atomic_o_trunc &&
+			  (fc->writeback_cache || FUSE_IS_DAX(inode));
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -239,12 +241,12 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	if (err)
 		return err;
 
-	if (is_wb_truncate || dax_truncate) {
+	if (may_truncate)
 		inode_lock(inode);
+	if (is_wb_truncate || is_dax_truncate)
 		fuse_set_nowrite(inode);
-	}
 
-	if (dax_truncate) {
+	if (is_dax_truncate) {
 		filemap_invalidate_lock(inode->i_mapping);
 		err = fuse_dax_break_layouts(inode, 0, 0);
 		if (err)
@@ -256,13 +258,13 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 		fuse_finish_open(inode, file);
 
 out:
-	if (dax_truncate)
+	if (is_dax_truncate)
 		filemap_invalidate_unlock(inode->i_mapping);
 
-	if (is_wb_truncate | dax_truncate) {
+	if (is_wb_truncate | is_dax_truncate)
 		fuse_release_nowrite(inode);
+	if (may_truncate)
 		inode_unlock(inode);
-	}
 
 	return err;
 }
-- 
2.20.1

