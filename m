Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9826852CF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiESJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbiESJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFCBA66691
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652952253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/xhrdt07itf9QlFZRajP4erMObfKTorbLnIbRKwLGQ=;
        b=HGMt7GLDgZx7WOdAT2EsYD/0wVQKGNDX62vaPoQO47YaVZyF1ZGC8a6AdJM9j4LDCLW/DJ
        3J9WOU+SYA5irceV6AACTjY5RayUnif5mr4/MSOUb44zv8tCwpxxziHXls4HNHqsN3lBDu
        KIy17yKRCgY3cajKIdedx3P0vkvDC64=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-k_VW5I2dNfq2oLAnDodf0A-1; Thu, 19 May 2022 05:24:12 -0400
X-MC-Unique: k_VW5I2dNfq2oLAnDodf0A-1
Received: by mail-wr1-f70.google.com with SMTP id e6-20020adfef06000000b0020d08e465e2so1343046wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/xhrdt07itf9QlFZRajP4erMObfKTorbLnIbRKwLGQ=;
        b=uTxMaz7wPR+UEwdxEHnk/3olvXJbFAmHTDE4xbA5eEYIooKiyeDJ0HmwBOqFvq/HYD
         Q0cW14aLVQnYgS4ycslIBdG//ULEk9QGUck5Wa2n8ifZA+WA4HKiJQRm7hOanf6njWL1
         YLlpkIETXGX41fRjzoTqN5sYappYml2aZ2CzYANf7BU0SbWueRU5wQG7ckfRpdwBR/iw
         eqDRn2fpaYgjvh/qYorN7ZZ3gdhwbQQXdpwoe5JdcTgkf6G0oyQDvDPVBgJRvKCU7OHG
         3/0hNliwDHvPyFiZUSEFTTE+AfAaTI9HAriHsxt/qSOhap6PkzYVIwDpK8PbvdwHYK1E
         vAag==
X-Gm-Message-State: AOAM530gP72/AlrixoT8MhxxR6Eheb8umcmAsi/fAxdONfBjbz+I7bq0
        Ks1fC8e5gf0+f+OtLuI3dBoURqtA1Pous8cRzUiWvxsXSGyjm28efdUdn8IVuT2EggIGjrTfeqa
        qJOVOC+pJZUZh2iTSpnaPAezX9wK4S5PLYdxmhLRKNXtXVVJL/EfgJI0D7sSYArmzkwozNyXbi7
        4=
X-Received: by 2002:adf:d183:0:b0:20d:8dc:eb5c with SMTP id v3-20020adfd183000000b0020d08dceb5cmr3217834wrc.444.1652952251531;
        Thu, 19 May 2022 02:24:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9KjewAa3UsgrAsT0rCnyFAOZdwCKgaZ2SXH4nprB/UJrNJr3qx40PioIubAm3dHXxl835uw==
X-Received: by 2002:adf:d183:0:b0:20d:8dc:eb5c with SMTP id v3-20020adfd183000000b0020d08dceb5cmr3217804wrc.444.1652952251226;
        Thu, 19 May 2022 02:24:11 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d6b8a000000b0020c5253d8fasm4104647wrx.70.2022.05.19.02.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 02:24:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [RFC PATCH 2/3] fat: add renameat2 RENAME_EXCHANGE flag support
Date:   Thu, 19 May 2022 11:23:42 +0200
Message-Id: <20220519092343.2776414-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220519092343.2776414-1-javierm@redhat.com>
References: <20220519092343.2776414-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
and in the error path actions made are reversed also with the mutex held,
making the whole operation transactional.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 fs/fat/namei_vfat.c | 153 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 1 deletion(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 88ccb2ee3537..6415a59eed13 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1017,13 +1017,164 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	goto out;
 }
 
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
+		if (S_ISDIR(old_inode->i_mode))
+			if (fat_get_dotdot_entry(old_inode, &old_dotdot_bh, &old_dotdot_de)) {
+				err = -EIO;
+				goto out;
+			}
+
+		if (S_ISDIR(new_inode->i_mode))
+			if (fat_get_dotdot_entry(new_inode, &new_dotdot_bh, &new_dotdot_de)) {
+				err = -EIO;
+				goto out;
+			}
+	}
+
+	/* exchange the two dentries */
+	old_i_pos = MSDOS_I(old_inode)->i_pos;
+	new_i_pos = MSDOS_I(new_inode)->i_pos;
+
+	fat_detach(old_inode);
+	fat_detach(new_inode);
+
+	fat_attach(old_inode, new_i_pos);
+	fat_attach(new_inode, old_i_pos);
+
+	if (IS_DIRSYNC(old_dir)) {
+		err = fat_sync_inode(new_inode);
+		if (err)
+			goto error_exchange;
+	} else {
+		mark_inode_dirty(new_inode);
+	}
+
+	if (IS_DIRSYNC(new_dir)) {
+		err = fat_sync_inode(old_inode);
+		if (err)
+			goto error_exchange;
+	} else {
+		mark_inode_dirty(old_inode);
+	}
+
+	/* update ".." directory entry info */
+	if (old_dotdot_de) {
+		fat_set_start(old_dotdot_de, MSDOS_I(new_dir)->i_logstart);
+		mark_buffer_dirty_inode(old_dotdot_bh, old_inode);
+		if (IS_DIRSYNC(new_dir)) {
+			err = sync_dirty_buffer(old_dotdot_bh);
+			if (err)
+				goto error_old_dotdot;
+		}
+		drop_nlink(old_dir);
+		inc_nlink(new_dir);
+	}
+
+	if (new_dotdot_de) {
+		fat_set_start(new_dotdot_de, MSDOS_I(old_dir)->i_logstart);
+		mark_buffer_dirty_inode(new_dotdot_bh, new_inode);
+		if (IS_DIRSYNC(old_dir)) {
+			err = sync_dirty_buffer(new_dotdot_bh);
+			if (err)
+				goto error_new_dotdot;
+		}
+		drop_nlink(new_dir);
+		inc_nlink(old_dir);
+	}
+
+	/* update inode version and timestamps */
+	inode_inc_iversion(old_dir);
+	inode_inc_iversion(new_dir);
+	inode_inc_iversion(old_inode);
+	inode_inc_iversion(new_inode);
+
+	fat_truncate_time(old_dir, &ts, S_CTIME | S_MTIME);
+	fat_truncate_time(new_dir, &ts, S_CTIME | S_MTIME);
+
+	if (IS_DIRSYNC(old_dir))
+		(void)fat_sync_inode(old_dir);
+	else
+		mark_inode_dirty(old_dir);
+
+	if (IS_DIRSYNC(new_dir))
+		(void)fat_sync_inode(new_dir);
+	else
+		mark_inode_dirty(new_dir);
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
+		fat_set_start(new_dotdot_de, MSDOS_I(new_dir)->i_logstart);
+		mark_buffer_dirty_inode(new_dotdot_bh, new_inode);
+		corrupt |= sync_dirty_buffer(new_dotdot_bh);
+	}
+
+error_old_dotdot:
+	/* data cluster is shared, serious corruption */
+	corrupt = 1;
+
+	if (old_dotdot_de) {
+		fat_set_start(old_dotdot_de, MSDOS_I(old_dir)->i_logstart);
+		mark_buffer_dirty_inode(old_dotdot_bh, old_inode);
+		corrupt |= sync_dirty_buffer(old_dotdot_bh);
+	}
+
+error_exchange:
+	fat_detach(old_inode);
+	fat_detach(new_inode);
+
+	fat_attach(old_inode, old_i_pos);
+	fat_attach(new_inode, new_i_pos);
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
2.35.1

