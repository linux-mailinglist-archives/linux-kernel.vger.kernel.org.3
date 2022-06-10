Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774B8545DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbiFJH5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346874AbiFJH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FD431CB735
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654847857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATkm+EAS67CnW4t/j84Y6CR89852slTzLc67eEvXk84=;
        b=URwKekbtS3voKHIDNkRRtSaCC3BdrRFeLUXXpG/0Vor8+x2KoaTlsq8+tY/BTrqpoxD0qw
        hzhmLSlcoNXv64yXS/BZeEgato1XPpZXjo/wYaRw3q8taVzsxmsRkkAc4DnlyhsAMtJNvT
        AGBhQTmsgUi3DLf+Q9WggEnrmCUOVXk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-vBB-3pHdOH-KFf90kFWZ4A-1; Fri, 10 Jun 2022 03:57:36 -0400
X-MC-Unique: vBB-3pHdOH-KFf90kFWZ4A-1
Received: by mail-wm1-f71.google.com with SMTP id c125-20020a1c3583000000b003978decffedso940900wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATkm+EAS67CnW4t/j84Y6CR89852slTzLc67eEvXk84=;
        b=uU7BAVwMPXOXnvo/ul7xpo9hj9UfyQsGjRhBOeLiPfifN5JY0JHU5E7ZjOMO/Vzqf0
         1u7067PfMMbfMuHpa7SbQKZCOyDIExcxGN90Pauk1pno+16qt2NNgAaD9I14Z6BRY6NP
         oC0NsC1PwB4gHTYMwRP+9IWeTEKg4agry8s3IoGN8TQT7R6IAbsOjgId3FIKaZu7DjXT
         CurjbKDA/YT0uFgC1MDk/pWPW8MLpGVlQJRK2OI63no7tjNzXpo8VN8wS0oVTyXW/HZF
         EObkkeXUyZ5+qrOjpbyuYoGU3oeeROpa1AP8C7mnPrS/gdpRH+TS1tVNvdN4ovSC3/X9
         YvCQ==
X-Gm-Message-State: AOAM532BRQMtvwDTESLY91lwa6oUhET6g8d3i/+GXBZGUFrdmbsMhyXl
        wGgbEdgqblXorGfF0yrn2S4dXr0b3Z1TBN6U7aoRlFBfm+9gqFyfX2Cwy2wDivHlUpy/nockYiY
        DZ9FqU4VvT4TkKypWgUMn9tyHzqPNyoBtsLcM6ZYXQnvFpxGRyfTSTleiD4jvvxAMH3hhDEzKGb
        4=
X-Received: by 2002:a05:6000:1e04:b0:217:88ff:eb86 with SMTP id bj4-20020a0560001e0400b0021788ffeb86mr28802977wrb.351.1654847854699;
        Fri, 10 Jun 2022 00:57:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQlwFK+FH4sMjCahy974jb0qPsptlEfGDrmM5xqbhSNgopqZIh4JoK76okVhVbqzw+BLOGCw==
X-Received: by 2002:a05:6000:1e04:b0:217:88ff:eb86 with SMTP id bj4-20020a0560001e0400b0021788ffeb86mr28802943wrb.351.1654847854416;
        Fri, 10 Jun 2022 00:57:34 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm26673363wrt.7.2022.06.10.00.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 00:57:34 -0700 (PDT)
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
Subject: [PATCH v6 3/4] fat: add renameat2 RENAME_EXCHANGE flag support
Date:   Fri, 10 Jun 2022 09:57:20 +0200
Message-Id: <20220610075721.1182745-4-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610075721.1182745-1-javierm@redhat.com>
References: <20220610075721.1182745-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The renameat2 RENAME_EXCHANGE flag allows to atomically exchange two paths
but is currently not supported by the Linux vfat filesystem driver.

Add a vfat_rename_exchange() helper function that implements this support.

The super block lock is acquired during the operation to ensure atomicity,
and in the error path actions made are reversed also with the mutex held.

It makes the operation as transactional as possible, within the limitation
impossed by vfat due not having a journal with logs to replay.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v6:
- Simplify logic to determine if nlink have to modified (OGAWA Hirofumi).

Changes in v5:
- Only update nlink for different parent dirs and file types (OGAWA Hirofumi).

Changes in v4:
- Rebase the patch on top of OGAWA Hirofumi proposed changes.
- Drop iversion increment for old and new file inodes (OGAWA Hirofumi).

Changes in v2:
- Only update the new_dir inode version and timestamps if != old_dir
  (Alex Larsson).
- Add some helper functions to avoid duplicating code (OGAWA Hirofumi).
- Use braces for multi-lines blocks even if are one statement (OGAWA Hirofumi).
- Mention in commit message that the operation is as transactional as possible
  but within the vfat limitations of not having a journal (Colin Walters).

 fs/fat/namei_vfat.c | 123 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 9c04053a8f1c..21620054e1c4 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1042,13 +1042,134 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	goto out;
 }
 
+static void vfat_exchange_ipos(struct inode *old_inode, struct inode *new_inode,
+			       loff_t old_i_pos, loff_t new_i_pos)
+{
+	fat_detach(old_inode);
+	fat_detach(new_inode);
+	fat_attach(old_inode, new_i_pos);
+	fat_attach(new_inode, old_i_pos);
+}
+
+static void vfat_move_nlink(struct inode *src, struct inode *dst)
+{
+	drop_nlink(src);
+	inc_nlink(dst);
+}
+
+static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
+				struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct buffer_head *old_dotdot_bh = NULL, *new_dotdot_bh = NULL;
+	struct msdos_dir_entry *old_dotdot_de = NULL, *new_dotdot_de = NULL;
+	struct inode *old_inode, *new_inode;
+	struct timespec64 ts = current_time(old_dir);
+	loff_t old_i_pos, new_i_pos;
+	int err, corrupt = 0;
+	struct super_block *sb = old_dir->i_sb;
+
+	old_inode = d_inode(old_dentry);
+	new_inode = d_inode(new_dentry);
+
+	/* Acquire super block lock for the operation to be atomic */
+	mutex_lock(&MSDOS_SB(sb)->s_lock);
+
+	/* if directories are not the same, get ".." info to update */
+	if (old_dir != new_dir) {
+		err = vfat_get_dotdot_de(old_inode, &old_dotdot_bh,
+					 &old_dotdot_de);
+		if (err)
+			goto out;
+
+		err = vfat_get_dotdot_de(new_inode, &new_dotdot_bh,
+					 &new_dotdot_de);
+		if (err)
+			goto out;
+	}
+
+	old_i_pos = MSDOS_I(old_inode)->i_pos;
+	new_i_pos = MSDOS_I(new_inode)->i_pos;
+
+	vfat_exchange_ipos(old_inode, new_inode, old_i_pos, new_i_pos);
+
+	err = vfat_sync_ipos(old_dir, new_inode);
+	if (err)
+		goto error_exchange;
+	err = vfat_sync_ipos(new_dir, old_inode);
+	if (err)
+		goto error_exchange;
+
+	/* update ".." directory entry info */
+	if (old_dotdot_de) {
+		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
+					    old_dotdot_de);
+		if (err)
+			goto error_old_dotdot;
+	}
+	if (new_dotdot_de) {
+		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
+					    new_dotdot_de);
+		if (err)
+			goto error_new_dotdot;
+	}
+
+	/* if cross directory and only one is a directory, adjust nlink */
+	if (!old_dotdot_de != !new_dotdot_de) {
+		if (old_dotdot_de)
+			vfat_move_nlink(old_dir, new_dir);
+		else
+			vfat_move_nlink(new_dir, old_dir);
+	}
+
+	vfat_update_dir_metadata(old_dir, &ts);
+	/* if directories are not the same, update new_dir as well */
+	if (old_dir != new_dir)
+		vfat_update_dir_metadata(new_dir, &ts);
+
+out:
+	brelse(old_dotdot_bh);
+	brelse(new_dotdot_bh);
+	mutex_unlock(&MSDOS_SB(sb)->s_lock);
+
+	return err;
+
+error_new_dotdot:
+	if (new_dotdot_de) {
+		corrupt |= vfat_update_dotdot_de(new_dir, new_inode,
+						 new_dotdot_bh, new_dotdot_de);
+	}
+
+error_old_dotdot:
+	if (old_dotdot_de) {
+		corrupt |= vfat_update_dotdot_de(old_dir, old_inode,
+						 old_dotdot_bh, old_dotdot_de);
+	}
+
+error_exchange:
+	vfat_exchange_ipos(old_inode, new_inode, new_i_pos, old_i_pos);
+	corrupt |= vfat_sync_ipos(new_dir, new_inode);
+	corrupt |= vfat_sync_ipos(old_dir, old_inode);
+
+	if (corrupt < 0) {
+		fat_fs_error(new_dir->i_sb,
+			     "%s: Filesystem corrupted (i_pos %lld, %lld)",
+			     __func__, old_i_pos, new_i_pos);
+	}
+	goto out;
+}
+
 static int vfat_rename2(struct user_namespace *mnt_userns, struct inode *old_dir,
 			struct dentry *old_dentry, struct inode *new_dir,
 			struct dentry *new_dentry, unsigned int flags)
 {
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
 		return -EINVAL;
 
+	if (flags & RENAME_EXCHANGE) {
+		return vfat_rename_exchange(old_dir, old_dentry,
+					    new_dir, new_dentry);
+	}
+
 	/* VFS already handled RENAME_NOREPLACE, handle it as a normal rename */
 	return vfat_rename(old_dir, old_dentry, new_dir, new_dentry);
 }
-- 
2.36.1

