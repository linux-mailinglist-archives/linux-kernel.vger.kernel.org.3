Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645B259C1CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiHVOod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiHVOoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:44:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F17B1DA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:44:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 2so6221059edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=oFJI/Mr0idgUAq7eIDUbIrKCI6tcQWiMHtMX00ACmUQ=;
        b=m8ER3XcnY96YQKHRgAn9/IRFz5qiOWD9C6cgC+GoXXZMcXTZ326xWfg5qFW+y1FQ8U
         ktI8GChZGVeekrUOmHYXw3h78eJnl8dikEWx3hARBqugPyZEeNQHmXrFUmuV64IU3Ozg
         phFYonrXYsvUAehapOO9TkrLwZdqFRvCFPDVxtYLgKmloWyJKy01j1sz2pnZh0dCUVKb
         F2rNPi+dPl3kijvuRyCCewWMG+PcyGJmctebnyzcLGsMSMtCs1vFqpajNRpMLsD1o0Jd
         PYg7ZlZ/+D54gnoDNYFSEVZKoboeMLK/oTB/Sc+9DR+7eEkMmYas8Kqv3OPmKKpt4ygu
         gZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=oFJI/Mr0idgUAq7eIDUbIrKCI6tcQWiMHtMX00ACmUQ=;
        b=ePons3/zgXO25JH+1GTM9RndAh7oIS40wUbPosa4uRyxNlh4RJrq6KRRTrsTZi1xjE
         1Rw/tmtSauJOORKN+un7MoV7ZnpFkdw4D9LSc+Yx6Mirfywy0iqwRNRQIc12XS54UVzZ
         X6Z+n35HDP4SSc62zwXqyLbFtN0sQstw1otYYss84rQV11ndos5kxDIbVkcgq0rbZXpI
         nneCborxlgWQ/AvK1v9GlLrtAJnmEEDJCdx++ufWWwDHIxDFs5DnS1V6B+FQKrOegARH
         wXtTsSWNazdyBK5iWgzKnxRHMd0BFRP9e1C6EpxqIk+7h6HIcjgeQEfa3g0wDH5F/e5C
         qoIw==
X-Gm-Message-State: ACgBeo2HK45KQn50cmRf4buphDfErxZKaNqWYl6SyZedSwU4a9hUuPUQ
        1oi5PeKNb04x9d0BJdA7sLI=
X-Google-Smtp-Source: AA6agR4a8XzVAaRDAauDCYI2lofgxamTY4IXQ7ehj9SIwSg/paE4SDYde6eQBPa0GZ3DzDDM1miyyw==
X-Received: by 2002:a05:6402:4383:b0:446:d6ac:bddd with SMTP id o3-20020a056402438300b00446d6acbdddmr3117341edc.283.1661179467135;
        Mon, 22 Aug 2022 07:44:27 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id ko28-20020a170907987c00b0073d69e8299dsm3142750ejc.52.2022.08.22.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:44:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v4] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Mon, 22 Aug 2022 16:44:20 +0200
Message-Id: <20220822144420.7442-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/ufs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
requires the mapping address, so return that address from ufs_get_page()
to be used in ufs_put_page(). Where suited, use the standard helper
memzero_page() instead of open coding kmap_local_page() plus memset().

These changes are essentially ported from fs/ext2 and are largely based on
commit 782b76d7abdf ("fs/ext2: Replace kmap() with kmap_local_page()").

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

This code is not tested. I have no means to create an UFS filesystem.
Despite nothing here seems to break the strict rules about the use of
kmap_local_page(), any help with testing will be much appreciated :-)

v3 -> v4: Convert another kmap() which was overlooked. Since the code
	  changed, remove the "Reviewed-by" tag from Ira.

v2 -> v3: Rename a variable for consistency (Ira Weiny). Add a
	  "Reviewed-by" tag.

v1 -> v2: Correct some style's issues reported by checkpatch.pl.
          Remove an "inline" compiler directive from fs/ufs/ufs.h,
          Reported-by: kernel test robot <lkp@intel.com>

 fs/ufs/dir.c   | 116 +++++++++++++++++++++++++++++++------------------
 fs/ufs/namei.c |  38 ++++++++--------
 fs/ufs/ufs.h   |  12 +++--
 3 files changed, 102 insertions(+), 64 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 391efaf1d528..db7564852391 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	return err;
 }
 
-static inline void ufs_put_page(struct page *page)
+inline void ufs_put_page(struct page *page, void *page_addr)
 {
-	kunmap(page);
+	kunmap_local(page_addr);
 	put_page(page);
 }
 
@@ -72,11 +72,12 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 	ino_t res = 0;
 	struct ufs_dir_entry *de;
 	struct page *page;
-	
-	de = ufs_find_entry(dir, qstr, &page);
+	void *page_addr;
+
+	de = ufs_find_entry(dir, qstr, &page, &page_addr);
 	if (de) {
 		res = fs32_to_cpu(dir->i_sb, de->d_ino);
-		ufs_put_page(page);
+		ufs_put_page(page, page_addr);
 	}
 	return res;
 }
@@ -84,11 +85,11 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 
 /* Releases the page */
 void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
-		  struct page *page, struct inode *inode,
-		  bool update_times)
+		  struct page *page, void *page_addr,
+		  struct inode *inode, bool update_times)
 {
 	loff_t pos = page_offset(page) +
-			(char *) de - (char *) page_address(page);
+			(char *)de - (char *)page_addr;
 	unsigned len = fs16_to_cpu(dir->i_sb, de->d_reclen);
 	int err;
 
@@ -100,18 +101,17 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
 	err = ufs_commit_chunk(page, pos, len);
-	ufs_put_page(page);
+	ufs_put_page(page, page_addr);
 	if (update_times)
 		dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
 }
 
 
-static bool ufs_check_page(struct page *page)
+static bool ufs_check_page(struct page *page, char *kaddr)
 {
 	struct inode *dir = page->mapping->host;
 	struct super_block *sb = dir->i_sb;
-	char *kaddr = page_address(page);
 	unsigned offs, rec_len;
 	unsigned limit = PAGE_SIZE;
 	const unsigned chunk_mask = UFS_SB(sb)->s_uspi->s_dirblksize - 1;
@@ -186,21 +186,28 @@ static bool ufs_check_page(struct page *page)
 	return false;
 }
 
-static struct page *ufs_get_page(struct inode *dir, unsigned long n)
+/*
+ * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
+ * rules documented in kmap_local_page()/kunmap_local().
+ *
+ * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
+ * and must be treated accordingly for nesting purposes.
+ */
+static struct page *ufs_get_page(struct inode *dir, unsigned long n, void **page_addr)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
 	if (!IS_ERR(page)) {
-		kmap(page);
+		*page_addr = kmap_local_page(page);
 		if (unlikely(!PageChecked(page))) {
-			if (!ufs_check_page(page))
+			if (!ufs_check_page(page, *page_addr))
 				goto fail;
 		}
 	}
 	return page;
 
 fail:
-	ufs_put_page(page);
+	ufs_put_page(page, *page_addr);
 	return ERR_PTR(-EIO);
 }
 
@@ -226,15 +233,29 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 					fs16_to_cpu(sb, p->d_reclen));
 }
 
-struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
+/*
+ * Return the '..' directory entry and the page in which the entry was found
+ * (as a parameter - p).
+ *
+ * On Success ufs_put_page() should be called on *p.
+ *
+ * NOTE: Calls to ufs_get_page()/ufs_put_page() must be nested according to
+ * the rules documented in kmap_local_page()/kunmap_local().
+ *
+ * ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page() and
+ * must be treated accordingly for nesting purposes.
+ */
+struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p, void **pa)
 {
-	struct page *page = ufs_get_page(dir, 0);
+	void *page_addr;
+	struct page *page = ufs_get_page(dir, 0, &page_addr);
 	struct ufs_dir_entry *de = NULL;
 
 	if (!IS_ERR(page)) {
 		de = ufs_next_entry(dir->i_sb,
-				    (struct ufs_dir_entry *)page_address(page));
+				    (struct ufs_dir_entry *)page_addr);
 		*p = page;
+		*pa = page_addr;
 	}
 	return de;
 }
@@ -246,9 +267,17 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
  * returns the page in which the entry was found, and the entry itself
  * (as a parameter - res_dir). Page is returned mapped and unlocked.
  * Entry is guaranteed to be valid.
+ *
+ * On Success ufs_put_page() should be called on *res_page.
+ *
+ * NOTE: Calls to ufs_get_page()/ufs_put_page() must be nested according to
+ * the rules documented in kmap_local_page()/kunmap_local().
+ *
+ * ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page() and
+ * must be treated accordingly for nesting purposes.
  */
 struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
-				     struct page **res_page)
+				     struct page **res_page, void **res_page_addr)
 {
 	struct super_block *sb = dir->i_sb;
 	const unsigned char *name = qstr->name;
@@ -259,6 +288,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 	struct page *page = NULL;
 	struct ufs_inode_info *ui = UFS_I(dir);
 	struct ufs_dir_entry *de;
+	void *page_addr;
 
 	UFSD("ENTER, dir_ino %lu, name %s, namlen %u\n", dir->i_ino, name, namelen);
 
@@ -267,6 +297,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 
 	/* OFFSET_CACHE */
 	*res_page = NULL;
+	*res_page_addr = NULL;
 
 	start = ui->i_dir_start_lookup;
 
@@ -275,9 +306,10 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 	n = start;
 	do {
 		char *kaddr;
-		page = ufs_get_page(dir, n);
+
+		page = ufs_get_page(dir, n, &page_addr);
 		if (!IS_ERR(page)) {
-			kaddr = page_address(page);
+			kaddr = page_addr;
 			de = (struct ufs_dir_entry *) kaddr;
 			kaddr += ufs_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
@@ -285,7 +317,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 					goto found;
 				de = ufs_next_entry(sb, de);
 			}
-			ufs_put_page(page);
+			ufs_put_page(page, page_addr);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -295,6 +327,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 
 found:
 	*res_page = page;
+	*res_page_addr = page_addr;
 	ui->i_dir_start_lookup = n;
 	return de;
 }
@@ -312,6 +345,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	const unsigned int chunk_size = UFS_SB(sb)->s_uspi->s_dirblksize;
 	unsigned short rec_len, name_len;
 	struct page *page = NULL;
+	void *page_addr = NULL;
 	struct ufs_dir_entry *de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
@@ -329,12 +363,12 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	for (n = 0; n <= npages; n++) {
 		char *dir_end;
 
-		page = ufs_get_page(dir, n);
+		page = ufs_get_page(dir, n, &page_addr);
 		err = PTR_ERR(page);
 		if (IS_ERR(page))
 			goto out;
 		lock_page(page);
-		kaddr = page_address(page);
+		kaddr = page_addr;
 		dir_end = kaddr + ufs_last_byte(dir, n);
 		de = (struct ufs_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE - reclen;
@@ -365,14 +399,14 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
 		}
 		unlock_page(page);
-		ufs_put_page(page);
+		ufs_put_page(page, page_addr);
 	}
 	BUG();
 	return -EINVAL;
 
 got_it:
 	pos = page_offset(page) +
-			(char*)de - (char*)page_address(page);
+			(char *)de - (char *)page_addr;
 	err = ufs_prepare_chunk(page, pos, rec_len);
 	if (err)
 		goto out_unlock;
@@ -396,7 +430,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
-	ufs_put_page(page);
+	ufs_put_page(page, page_addr);
 out:
 	return err;
 out_unlock:
@@ -441,7 +475,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 		char *kaddr, *limit;
 		struct ufs_dir_entry *de;
 
-		struct page *page = ufs_get_page(inode, n);
+		struct page *page = ufs_get_page(inode, n, (void **)&kaddr);
 
 		if (IS_ERR(page)) {
 			ufs_error(sb, __func__,
@@ -450,7 +484,6 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 			ctx->pos += PAGE_SIZE - offset;
 			return -EIO;
 		}
-		kaddr = page_address(page);
 		if (unlikely(need_revalidate)) {
 			if (offset) {
 				offset = ufs_validate_entry(sb, kaddr, offset, chunk_mask);
@@ -476,13 +509,13 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 					       ufs_get_de_namlen(sb, de),
 					       fs32_to_cpu(sb, de->d_ino),
 					       d_type)) {
-					ufs_put_page(page);
+					ufs_put_page(page, kaddr);
 					return 0;
 				}
 			}
 			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
 		}
-		ufs_put_page(page);
+		ufs_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -493,10 +526,9 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
  * previous entry.
  */
 int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
-		     struct page * page)
+		     struct page *page, char *kaddr)
 {
 	struct super_block *sb = inode->i_sb;
-	char *kaddr = page_address(page);
 	unsigned from = ((char*)dir - kaddr) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
 	unsigned to = ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen);
 	loff_t pos;
@@ -522,7 +554,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		de = ufs_next_entry(sb, de);
 	}
 	if (pde)
-		from = (char*)pde - (char*)page_address(page);
+		from = (char *)pde - kaddr;
 
 	pos = page_offset(page) + from;
 	lock_page(page);
@@ -535,7 +567,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
 out:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	UFSD("EXIT\n");
 	return err;
 }
@@ -559,8 +591,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 		goto fail;
 	}
 
-	kmap(page);
-	base = (char*)page_address(page);
+	base = kmap_local_page(page);
 	memset(base, 0, PAGE_SIZE);
 
 	de = (struct ufs_dir_entry *) base;
@@ -577,7 +608,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
 	ufs_set_de_namlen(sb, de, 2);
 	strcpy (de->d_name, "..");
-	kunmap(page);
+	kunmap_local(base);
 
 	err = ufs_commit_chunk(page, 0, chunk_size);
 fail:
@@ -592,17 +623,18 @@ int ufs_empty_dir(struct inode * inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct page *page = NULL;
+	void *page_addr;
 	unsigned long i, npages = dir_pages(inode);
 
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
 		struct ufs_dir_entry *de;
-		page = ufs_get_page(inode, i);
 
+		page = ufs_get_page(inode, i, &page_addr);
 		if (IS_ERR(page))
 			continue;
 
-		kaddr = page_address(page);
+		kaddr = page_addr;
 		de = (struct ufs_dir_entry *)kaddr;
 		kaddr += ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
 
@@ -629,12 +661,12 @@ int ufs_empty_dir(struct inode * inode)
 			}
 			de = ufs_next_entry(sb, de);
 		}
-		ufs_put_page(page);
+		ufs_put_page(page, page_addr);
 	}
 	return 1;
 
 not_empty:
-	ufs_put_page(page);
+	ufs_put_page(page, page_addr);
 	return 0;
 }
 
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 29d5a0e0c8f0..cdf3bcf9d02e 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -210,13 +210,14 @@ static int ufs_unlink(struct inode *dir, struct dentry *dentry)
 	struct inode * inode = d_inode(dentry);
 	struct ufs_dir_entry *de;
 	struct page *page;
+	void *page_addr;
 	int err = -ENOENT;
 
-	de = ufs_find_entry(dir, &dentry->d_name, &page);
+	de = ufs_find_entry(dir, &dentry->d_name, &page, &page_addr);
 	if (!de)
 		goto out;
 
-	err = ufs_delete_entry(dir, de, page);
+	err = ufs_delete_entry(dir, de, page, page_addr);
 	if (err)
 		goto out;
 
@@ -250,27 +251,31 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct page *dir_page = NULL;
+	void *dir_page_addr;
 	struct ufs_dir_entry * dir_de = NULL;
 	struct page *old_page;
+	void *old_page_addr;
 	struct ufs_dir_entry *old_de;
 	int err = -ENOENT;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_page);
+	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_page,
+				&old_page_addr);
 	if (!old_de)
 		goto out;
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
-		dir_de = ufs_dotdot(old_inode, &dir_page);
+		dir_de = ufs_dotdot(old_inode, &dir_page, &dir_page_addr);
 		if (!dir_de)
 			goto out_old;
 	}
 
 	if (new_inode) {
 		struct page *new_page;
+		void *new_page_addr;
 		struct ufs_dir_entry *new_de;
 
 		err = -ENOTEMPTY;
@@ -278,10 +283,11 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			goto out_dir;
 
 		err = -ENOENT;
-		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_page);
+		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_page,
+					&new_page_addr);
 		if (!new_de)
 			goto out_dir;
-		ufs_set_link(new_dir, new_de, new_page, old_inode, 1);
+		ufs_set_link(new_dir, new_de, new_page, new_page_addr, old_inode, 1);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -300,29 +306,25 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	 */
 	old_inode->i_ctime = current_time(old_inode);
 
-	ufs_delete_entry(old_dir, old_de, old_page);
+	ufs_delete_entry(old_dir, old_de, old_page, old_page_addr);
 	mark_inode_dirty(old_inode);
 
 	if (dir_de) {
 		if (old_dir != new_dir)
-			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
-		else {
-			kunmap(dir_page);
-			put_page(dir_page);
-		}
+			ufs_set_link(old_inode, dir_de, dir_page,
+				     dir_page_addr, new_dir, 0);
+		else
+			ufs_put_page(dir_page, dir_page_addr);
 		inode_dec_link_count(old_dir);
 	}
 	return 0;
 
 
 out_dir:
-	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
-	}
+	if (dir_de)
+		ufs_put_page(dir_page, dir_page_addr);
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	ufs_put_page(old_page, old_page_addr);
 out:
 	return err;
 }
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 550f7c5a3636..20d224c163ab 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -102,12 +102,16 @@ extern const struct inode_operations ufs_dir_inode_operations;
 extern int ufs_add_link (struct dentry *, struct inode *);
 extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
 extern int ufs_make_empty(struct inode *, struct inode *);
-extern struct ufs_dir_entry *ufs_find_entry(struct inode *, const struct qstr *, struct page **);
-extern int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct page *);
+extern struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
+					    struct page **res_page, void **res_page_addr);
+extern int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
+			    struct page *page, char *kaddr);
 extern int ufs_empty_dir (struct inode *);
-extern struct ufs_dir_entry *ufs_dotdot(struct inode *, struct page **);
+extern struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p, void **pa);
 extern void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
-			 struct page *page, struct inode *inode, bool update_times);
+			 struct page *page, void *page_addr,
+			 struct inode *inode, bool update_times);
+extern void ufs_put_page(struct page *page, void *page_addr);
 
 /* file.c */
 extern const struct inode_operations ufs_file_inode_operations;
-- 
2.37.1

