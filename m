Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA1532432
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiEXHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbiEXHgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62CFE41611
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653377788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aaq+8mBUqU62y0VEllgQncQ09kUyTKPkA4vCRiJz8W0=;
        b=HgFhgt/QcTgK5PgQ1tqtaEPJAoEa0v8sOjhIzL4KXj46f4I2c9XvaT8eV5I6lX038V8nyp
        iWp0rydDOUPZR0hTJzkgmNQ6+aVapTp1fwzv9JkJeE0bRxZB0XCoioqwUtPfFkU82AWudE
        pPjOgndM/6rukUGSYNWsoYdV7Ze47Jk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-kUJwZJ1XOeSC_hUUP-fgew-1; Tue, 24 May 2022 03:36:27 -0400
X-MC-Unique: kUJwZJ1XOeSC_hUUP-fgew-1
Received: by mail-wr1-f71.google.com with SMTP id e7-20020adfa747000000b0020fe61b0c62so1018180wrd.22
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aaq+8mBUqU62y0VEllgQncQ09kUyTKPkA4vCRiJz8W0=;
        b=2/hMv5d461vOCwa+t/ycjy7I2V1T8XnAqYKZSM9DYUiH83vWIMiztOX9iptOq8SxMI
         OR2CusEGJuvBdmUPO9d5L2KONAtaDc0jL1Z3W6l9q7xCZGg1+4Jx5P8CQFJnRtYACBjg
         C/mAphSGKCG0QfX4/bTcFOwsjQR7Bq9/Ihd6n28r8WkxQfEwa22VzWrMsr0Ic638j9oe
         v3XffaH+hW/K6yzq1SmmiAOugztxIJXD47d3lI/IwecZBcpw0e6MCoipfToPChdCcJvU
         IQuYsWgnCkxoffTy4UJwipkuEi3CZ6q8pHJX4fj9114PBdQ6V7OKNnpdeFPyH34RxL5r
         TlCg==
X-Gm-Message-State: AOAM532a28x17y8IYH3x8dwVHZssV2Ehmxlo0vuzrCuv3Z3VNs7AroA9
        EqO3JCnvFRKBkIQmhOf+/nVi547+bxGoy0nuM8mhELuwV5kBxsYqDAbMOi33m3uo+6YK3a94U2V
        VMvr9nSe/z+Q1YfI2e6urLrF5J4INGB7frbjKuPryDBtFXyaX3QN8yrTB66nM9vr1Qx9FiLFdLV
        4=
X-Received: by 2002:a05:600c:3542:b0:394:6e2f:ffa2 with SMTP id i2-20020a05600c354200b003946e2fffa2mr2468591wmq.132.1653377785901;
        Tue, 24 May 2022 00:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfr923KFwhNSGBDP0eAbz0FKOw7EdGcC26QgZCBbJPbNjaaTj9l7/mPo8Si8fG92veWfpcnA==
X-Received: by 2002:a05:600c:3542:b0:394:6e2f:ffa2 with SMTP id i2-20020a05600c354200b003946e2fffa2mr2468551wmq.132.1653377785470;
        Tue, 24 May 2022 00:36:25 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f2-20020adfc982000000b0020c5253d927sm12202174wrh.115.2022.05.24.00.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:36:25 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH v2 2/3] fat: add renameat2 RENAME_EXCHANGE flag support
Date:   Tue, 24 May 2022 09:36:03 +0200
Message-Id: <20220524073604.247790-3-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524073604.247790-1-javierm@redhat.com>
References: <20220524073604.247790-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Changes in v2:
- Only update the new_dir inode version and timestamps if != old_dir
  (Alex Larsson).
- Add some helper functions to avoid duplicating code (OGAWA Hirofumi).
- Use braces for multi-lines blocks even if are one statement (OGAWA Hirofumi).
- Mention in commit message that the operation is as transactional as possible
  but within the vfat limitations of not having a journal (Colin Walters).

 fs/fat/namei_vfat.c | 174 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 173 insertions(+), 1 deletion(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 88ccb2ee3537..97caec8c5207 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1017,13 +1017,185 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	goto out;
 }
 
+/* Helpers for vfat_rename_exchange() */
+
+static int vfat_get_dotdot_info(struct inode *inode, struct buffer_head **dotdot_bh,
+				struct msdos_dir_entry **dotdot_de)
+{
+	if (!S_ISDIR(inode->i_mode))
+		return 0;
+
+	return fat_get_dotdot_entry(inode, dotdot_bh, dotdot_de);
+}
+
+static void vfat_exchange_dentries(struct inode *old_inode, struct inode *new_inode,
+				   loff_t old_i_pos, loff_t new_i_pos)
+{
+	fat_detach(old_inode);
+	fat_detach(new_inode);
+
+	fat_attach(old_inode, new_i_pos);
+	fat_attach(new_inode, old_i_pos);
+}
+
+static int vfat_sync_after_exchange(struct inode *dir, struct inode *inode)
+{
+	int err = 0;
+
+	if (IS_DIRSYNC(dir))
+		err = fat_sync_inode(inode);
+	else
+		mark_inode_dirty(inode);
+
+	return err;
+}
+
+static int vfat_update_dotdot_info(struct buffer_head *dotdot_bh, struct msdos_dir_entry *dotdot_de,
+				   struct inode *dir, struct inode *inode)
+{
+	int err = 0;
+
+	fat_set_start(dotdot_de, MSDOS_I(dir)->i_logstart);
+	mark_buffer_dirty_inode(dotdot_bh, inode);
+
+	if (IS_DIRSYNC(dir))
+		err = sync_dirty_buffer(dotdot_bh);
+
+	return err;
+}
+
+static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
+{
+	inode_inc_iversion(dir);
+	fat_truncate_time(dir, ts, S_CTIME | S_MTIME);
+
+	if (IS_DIRSYNC(dir))
+		(void)fat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
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
+		err = vfat_get_dotdot_info(old_inode, &old_dotdot_bh, &old_dotdot_de);
+		if (err)
+			goto out;
+
+		err = vfat_get_dotdot_info(new_inode, &new_dotdot_bh, &new_dotdot_de);
+		if (err)
+			goto out;
+	}
+
+	old_i_pos = MSDOS_I(old_inode)->i_pos;
+	new_i_pos = MSDOS_I(new_inode)->i_pos;
+
+	/* exchange the two dentries */
+	vfat_exchange_dentries(old_inode, new_inode, old_i_pos, new_i_pos);
+
+	err = vfat_sync_after_exchange(old_dir, new_inode);
+	if (err)
+		goto error_exchange;
+
+	err = vfat_sync_after_exchange(new_dir, old_inode);
+	if (err)
+		goto error_exchange;
+
+	/* update ".." directory entry info */
+	if (old_dotdot_de) {
+		err = vfat_update_dotdot_info(old_dotdot_bh, old_dotdot_de, new_dir, old_inode);
+		if (err)
+			goto error_old_dotdot;
+
+		drop_nlink(old_dir);
+		inc_nlink(new_dir);
+	}
+
+	if (new_dotdot_de) {
+		err = vfat_update_dotdot_info(new_dotdot_bh, new_dotdot_de, old_dir, new_inode);
+		if (err)
+			goto error_new_dotdot;
+
+		drop_nlink(new_dir);
+		inc_nlink(old_dir);
+	}
+
+	/* update inode version and timestamps */
+	inode_inc_iversion(old_inode);
+	inode_inc_iversion(new_inode);
+
+	vfat_update_dir_metadata(old_dir, &ts);
+
+	/* if directories are not the same, update new_dir as well */
+	if (old_dir != new_dir)
+		vfat_update_dir_metadata(new_dir, &ts);
+out:
+	brelse(old_dotdot_bh);
+	brelse(new_dotdot_bh);
+	mutex_unlock(&MSDOS_SB(sb)->s_lock);
+
+	return err;
+
+error_new_dotdot:
+	/* data cluster is shared, serious corruption */
+	corrupt = 1;
+
+	if (new_dotdot_de) {
+		corrupt |= vfat_update_dotdot_info(new_dotdot_bh, new_dotdot_de,
+						   new_dir, new_inode);
+	}
+
+error_old_dotdot:
+	/* data cluster is shared, serious corruption */
+	corrupt = 1;
+
+	if (old_dotdot_de) {
+		corrupt |= vfat_update_dotdot_info(old_dotdot_bh, old_dotdot_de,
+						   old_dir, old_inode);
+	}
+
+error_exchange:
+	vfat_exchange_dentries(old_inode, new_inode, new_i_pos, old_i_pos);
+
+	if (corrupt) {
+		corrupt |= fat_sync_inode(old_inode);
+		corrupt |= fat_sync_inode(new_inode);
+	}
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
 
+	if (flags & RENAME_EXCHANGE)
+		return vfat_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
+
 	/* VFS already handled RENAME_NOREPLACE, handle it as a normal rename */
 	return vfat_rename(old_dir, old_dentry, new_dir, new_dentry);
 }
-- 
2.36.1

