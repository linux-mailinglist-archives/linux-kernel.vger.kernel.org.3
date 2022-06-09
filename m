Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC495447B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbiFIJhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbiFIJhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B1642CE36
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654767424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OgRi0PKD0VO5dANyO2dDI6iaCmLjQgKbnL82bbRFxuc=;
        b=GG0lgiANkRjyfy4FcB5A1bf/TgcxdpOBtj1BrYjYkkpYi4JvENPfu4+xqBPPVNGlVQqOdg
        GFcl89zwVkMFnI/UnMT8kvUR+KHbVCQIi9x4SousmQsOZmMmT6tZva+8b4TltpjwAn6pXs
        bbpGo5JH026Yj+Lp8l8sHkcXxew1Lfo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-veaLGNnUPRilc3Auy9AxNA-1; Thu, 09 Jun 2022 05:36:55 -0400
X-MC-Unique: veaLGNnUPRilc3Auy9AxNA-1
Received: by mail-wr1-f69.google.com with SMTP id y2-20020adff142000000b0021581245fa1so4229903wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OgRi0PKD0VO5dANyO2dDI6iaCmLjQgKbnL82bbRFxuc=;
        b=arwT+acxcyupFhw2epTLyT9OyREcOZUs9VNkJPkRaXqG+/l20Wv0adL+AbyGdMqcPt
         vtKPv3losgy2GkWrc7VMiCtfj69dT3/MxVGsfwm+P3d/2URDjHBoIhUJtq58wH2UGlVV
         g8FZWMbat51IO9ch3B9AFncmhJYSge0Ap9eCu3++D2quhlf1S3aOV4WBTiI6zoNNw1QV
         JfMkZn+FmPzg/emZDSG6Or4kklTlOPEhotXSmL1+z7UU3QQpna4vFVFbOXGowzscE96l
         xdUf2Abpjinx5DPq105xL7sDjRUvp0FrtYuXasAk+vjxTjdK4OWqmG6BcCzCDvoPP4om
         Yn5w==
X-Gm-Message-State: AOAM530uK5Qc6wqyiag8oGGbz5nSciZ/MzXkCAt/cX/g/QjkE2FdNkKM
        9UgiroG8Pxt9oEBJ93ivtkLNGs8xm1RMOBGG2s4jXUwOtq1co7weI3IpcsnSc+kc0UCbIoXHkwN
        vpdZd1Bb8EO7kZa9/7m2E3tadN7c1r14i++RbmfaCbzT+fk3ZU1/eo2Rt5+3zAr+ZCDVcFFgbII
        8=
X-Received: by 2002:a05:6000:188b:b0:218:5d79:dc6e with SMTP id a11-20020a056000188b00b002185d79dc6emr8071911wri.183.1654767413821;
        Thu, 09 Jun 2022 02:36:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvw/z8WVJ+iV9KsL3eBAQMwTrCO7rkZ9WddMOPuseWcJhnVi9NOQjMtd16CYXi2hVkDcC08A==
X-Received: by 2002:a05:6000:188b:b0:218:5d79:dc6e with SMTP id a11-20020a056000188b00b002185d79dc6emr8071880wri.183.1654767413559;
        Thu, 09 Jun 2022 02:36:53 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00397122e63b6sm27385580wms.29.2022.06.09.02.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:36:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@verbum.org>,
        Alberto Ruiz <aruiz@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Kellner <ckellner@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Carlos Maiolino <cmaiolin@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v5 3/4] fat: add renameat2 RENAME_EXCHANGE flag support
Date:   Thu,  9 Jun 2022 11:36:36 +0200
Message-Id: <20220609093638.664034-4-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609093638.664034-1-javierm@redhat.com>
References: <20220609093638.664034-1-javierm@redhat.com>
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

 fs/fat/namei_vfat.c | 124 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 9c04053a8f1c..4aa096a15e59 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1042,13 +1042,135 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
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
+static void vfat_update_nlink(struct inode *dir, struct inode *inode)
+{
+		if (S_ISDIR(inode->i_mode))
+			drop_nlink(dir);
+		else
+			inc_nlink(dir);
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
+
+	if (new_dotdot_de) {
+		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
+					    new_dotdot_de);
+		if (err)
+			goto error_new_dotdot;
+	}
+
+	vfat_update_dir_metadata(old_dir, &ts);
+	/* if directories are not the same, update new_dir as well */
+	if (old_dir != new_dir) {
+		vfat_update_dir_metadata(new_dir, &ts);
+		/* nlink only needs to be updated if the file types differ */
+		if (old_inode->i_mode != new_inode->i_mode) {
+			vfat_update_nlink(old_dir, old_inode);
+			vfat_update_nlink(new_dir, new_inode);
+		}
+	}
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

