Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F26545DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347065AbiFJH5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347037AbiFJH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21D5B1CB714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654847856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UvTYFnM/Xxan4k4LuRTmFLCKv7+5+mh7KcxWLzDn8Q=;
        b=aA57j4xtS2w+uwQHIUZWWOyfBOi6EqPntwOL0kSUja45e0A3AcfbPwjPBicUymYvHqTqBC
        p6RGvLIdRxx4kYcm5agt0jIiQBGougLeH6l6ZgSz+bATMOl7tK8ZQ7dkCGSWinPxLMcqJU
        strDudJ4L08JgJuBw0Lt8Vifvi3Hhns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-Cac5y6pBP9OyMFVp2cOiNA-1; Fri, 10 Jun 2022 03:57:34 -0400
X-MC-Unique: Cac5y6pBP9OyMFVp2cOiNA-1
Received: by mail-wm1-f70.google.com with SMTP id z13-20020a7bc7cd000000b0039c4a238eadso4998265wmk.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UvTYFnM/Xxan4k4LuRTmFLCKv7+5+mh7KcxWLzDn8Q=;
        b=HNYyGCeNfcoTuNMlGLjQEDuYl0ngX7NKjqmVZYAbTULxpaTF31OauA+DEhwPaXLgwP
         fOd2PKu6/YxdmlEAEVTANqV9ZPspHDR15j8AyRFMsP3EjS55ewCiIV9S7RWDEPwRyxKJ
         rRYDs5Y50xkBo63twpsD40YCukfvhVPhVWClBlPen9sHIqS0kR4o89WUsSGwWM52sUEd
         3jXaKRI7scwwE6gdYjhmKh35WzjtQlD+s92weZalY4IyLcVT4voqt9kL9qzvzTi1ieQY
         CRPhBmHyytWwE5IXIwYyNAavf3m4jGuG+iUyhe3iNkgXkd4JVlr/VT4hep1AucvJIWf5
         rpqA==
X-Gm-Message-State: AOAM533GD3MOQG/IXIs7j3eRnJogfoKUY7oyt8WZHsCf54zXuqMZzfng
        EIvq1resqIyKbDp/NGhbN/uExl56Z8RiJ38q6LTeLYiLndR7VSqqr13dLJIlOujmyGzwHftmUf1
        QpdJy80kOdKSbUCZTsdlacyAMqCjTMZ+agkQ+oBcDI1YIqOrXIOHG/1m+Rz5HqmYTZJTdD1eV1u
        c=
X-Received: by 2002:a05:6000:1e1b:b0:219:e32d:cbe8 with SMTP id bj27-20020a0560001e1b00b00219e32dcbe8mr3854635wrb.129.1654847853272;
        Fri, 10 Jun 2022 00:57:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY+DGxwn0ElPtJNwPV+uaOQ1b8VDvmoDjAODTofe+2ab5W+KkmtgFAhYjducATm+l32Zd1SQ==
X-Received: by 2002:a05:6000:1e1b:b0:219:e32d:cbe8 with SMTP id bj27-20020a0560001e1b00b00219e32dcbe8mr3854605wrb.129.1654847852983;
        Fri, 10 Jun 2022 00:57:32 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm26673363wrt.7.2022.06.10.00.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 00:57:32 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Kellner <ckellner@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Peter Jones <pjones@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Carlos Maiolino <cmaiolin@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@verbum.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v6 2/4] fat: factor out reusable code in vfat_rename() as helper functions
Date:   Fri, 10 Jun 2022 09:57:19 +0200
Message-Id: <20220610075721.1182745-3-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610075721.1182745-1-javierm@redhat.com>
References: <20220610075721.1182745-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

The vfat_rename() function is quite big and there are code blocks that can
be moved into helper functions. This not only simplify the implementation
of that function but also allows these helpers to be reused.

For example, the helpers can be used by the handler of the RENAME_EXCHANGE
flag once this is implemented in a subsequent patch.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v4)

Changes in v4:
- Add new patch from OGAWA Hirofumi to use the helpers in vfat_rename().

 fs/fat/namei_vfat.c | 89 +++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 32 deletions(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 88ccb2ee3537..9c04053a8f1c 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -889,16 +889,55 @@ static int vfat_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
+static int vfat_get_dotdot_de(struct inode *inode, struct buffer_head **bh,
+			      struct msdos_dir_entry **de)
+{
+	if (S_ISDIR(inode->i_mode)) {
+		if (fat_get_dotdot_entry(inode, bh, de))
+			return -EIO;
+	}
+	return 0;
+}
+
+static int vfat_sync_ipos(struct inode *dir, struct inode *inode)
+{
+	if (IS_DIRSYNC(dir))
+		return fat_sync_inode(inode);
+	mark_inode_dirty(inode);
+	return 0;
+}
+
+static int vfat_update_dotdot_de(struct inode *dir, struct inode *inode,
+				 struct buffer_head *dotdot_bh,
+				 struct msdos_dir_entry *dotdot_de)
+{
+	fat_set_start(dotdot_de, MSDOS_I(dir)->i_logstart);
+	mark_buffer_dirty_inode(dotdot_bh, inode);
+	if (IS_DIRSYNC(dir))
+		return sync_dirty_buffer(dotdot_bh);
+	return 0;
+}
+
+static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
+{
+	inode_inc_iversion(dir);
+	fat_truncate_time(dir, ts, S_CTIME | S_MTIME);
+	if (IS_DIRSYNC(dir))
+		(void)fat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
+}
+
 static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		       struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct buffer_head *dotdot_bh;
-	struct msdos_dir_entry *dotdot_de;
+	struct msdos_dir_entry *dotdot_de = NULL;
 	struct inode *old_inode, *new_inode;
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec64 ts;
 	loff_t new_i_pos;
-	int err, is_dir, update_dotdot, corrupt = 0;
+	int err, is_dir, corrupt = 0;
 	struct super_block *sb = old_dir->i_sb;
 
 	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
@@ -909,15 +948,13 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		goto out;
 
-	is_dir = S_ISDIR(old_inode->i_mode);
-	update_dotdot = (is_dir && old_dir != new_dir);
-	if (update_dotdot) {
-		if (fat_get_dotdot_entry(old_inode, &dotdot_bh, &dotdot_de)) {
-			err = -EIO;
+	if (old_dir != new_dir) {
+		err = vfat_get_dotdot_de(old_inode, &dotdot_bh, &dotdot_de);
+		if (err)
 			goto out;
-		}
 	}
 
+	is_dir = S_ISDIR(old_inode->i_mode);
 	ts = current_time(old_dir);
 	if (new_inode) {
 		if (is_dir) {
@@ -938,21 +975,15 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	fat_detach(old_inode);
 	fat_attach(old_inode, new_i_pos);
-	if (IS_DIRSYNC(new_dir)) {
-		err = fat_sync_inode(old_inode);
-		if (err)
-			goto error_inode;
-	} else
-		mark_inode_dirty(old_inode);
+	err = vfat_sync_ipos(new_dir, old_inode);
+	if (err)
+		goto error_inode;
 
-	if (update_dotdot) {
-		fat_set_start(dotdot_de, MSDOS_I(new_dir)->i_logstart);
-		mark_buffer_dirty_inode(dotdot_bh, old_inode);
-		if (IS_DIRSYNC(new_dir)) {
-			err = sync_dirty_buffer(dotdot_bh);
-			if (err)
-				goto error_dotdot;
-		}
+	if (dotdot_de) {
+		err = vfat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
+					    dotdot_de);
+		if (err)
+			goto error_dotdot;
 		drop_nlink(old_dir);
 		if (!new_inode)
  			inc_nlink(new_dir);
@@ -962,12 +993,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	old_sinfo.bh = NULL;
 	if (err)
 		goto error_dotdot;
-	inode_inc_iversion(old_dir);
-	fat_truncate_time(old_dir, &ts, S_CTIME|S_MTIME);
-	if (IS_DIRSYNC(old_dir))
-		(void)fat_sync_inode(old_dir);
-	else
-		mark_inode_dirty(old_dir);
+	vfat_update_dir_metadata(old_dir, &ts);
 
 	if (new_inode) {
 		drop_nlink(new_inode);
@@ -987,10 +1013,9 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	/* data cluster is shared, serious corruption */
 	corrupt = 1;
 
-	if (update_dotdot) {
-		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
-		mark_buffer_dirty_inode(dotdot_bh, old_inode);
-		corrupt |= sync_dirty_buffer(dotdot_bh);
+	if (dotdot_de) {
+		corrupt |= vfat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
+						 dotdot_de);
 	}
 error_inode:
 	fat_detach(old_inode);
-- 
2.36.1

