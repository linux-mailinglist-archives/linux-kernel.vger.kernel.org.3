Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4524853ABF3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356362AbiFARcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356342AbiFARcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E0C94926A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654104741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6eMKpD/mGKmJJS6uppDKQiAUieabwGpSUh8uzV1ii0=;
        b=S4FqCAVDuwhwPK9Eywr6Kge+7n6E7II0YQV7jH47QbLHRvd+iX3GQ+0lH+/0bBt2/7D7QO
        W1vAtAVa6orZqmIkf3778+K0+ZOUmWFNSf9bo+64QiPnPOca0LQcSt4vIHZqwWJu7m3qCC
        LASRZMcSEC5cpl82l+M4EW+kBLCC5Sc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-cOY_Ac33N4GftXHycbzdQw-1; Wed, 01 Jun 2022 13:32:20 -0400
X-MC-Unique: cOY_Ac33N4GftXHycbzdQw-1
Received: by mail-wm1-f71.google.com with SMTP id u12-20020a05600c19cc00b0038ec265155fso3704022wmq.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 10:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6eMKpD/mGKmJJS6uppDKQiAUieabwGpSUh8uzV1ii0=;
        b=ZivUaxN4vZEih2HV6bAh9mJJjC/0znuHFPmCUFWuUd8h7u4KUDL4RC2jcmtKnIWlxE
         mVet9HR+zchEl9eBLPB7ziFZD4WvVI4HYWpz9kMJ3ST/j7Bxv270hqn2fhvDwFt9heNJ
         6lhw7WtPo2tl+OG4aIWg+yrbhFXfNKoKFQm1lp8ReQ53CgeDqsCGUF947Q8dsdOD6MRs
         +ywfoRCUImMdzgx/XkX3RBbBFCpPKoliWPDAo08p5NwLYWbcvwqRSO3d45G4TA8Z8tyA
         snOlFfBfLK7O+AKiPH+8ECmPR62O3vpqqHtWSZR9JvheE0mUCNwKEcNrhYIVSiQhiZ2e
         ZUEw==
X-Gm-Message-State: AOAM533CjNsD++cR4qdQnzu9GD/xNJPeBtRiFb1dC9Qh17HBd7WlXk3M
        aBYEzZiRwJwjH7afCgznlO3DCUvaSoE3WRMgwVswbVT+nPZ99MsWXvOaBfekwu4UxI4XAks0vsD
        1WS9U9bJdGRV1xSNX0YGEWDdZsrDSMVTe5liRu+/si7OQC4YunEggcocM6tFdkYHfOfnrDFZGGL
        w=
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id n16-20020a7bc5d0000000b00389fe853d79mr30081532wmk.77.1654104739077;
        Wed, 01 Jun 2022 10:32:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg1Ay7mO1KlJaXVQExeECd7gxByNNKImo1aPTamB1fVDaJXVOZ8+IMcN90vhEGo5MIz333KA==
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id n16-20020a7bc5d0000000b00389fe853d79mr30081498wmk.77.1654104738745;
        Wed, 01 Jun 2022 10:32:18 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c2cce00b0039751bb8c62sm6525625wmc.24.2022.06.01.10.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 10:32:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 3/4] fat: add renameat2 RENAME_EXCHANGE flag support
Date:   Wed,  1 Jun 2022 19:32:03 +0200
Message-Id: <20220601173204.1372569-4-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601173204.1372569-1-javierm@redhat.com>
References: <20220601173204.1372569-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 fs/fat/namei_vfat.c | 114 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 9c04053a8f1c..725ab9404c53 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1042,13 +1042,125 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
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
+		drop_nlink(old_dir);
+		inc_nlink(new_dir);
+	}
+
+	if (new_dotdot_de) {
+		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
+					    new_dotdot_de);
+		if (err)
+			goto error_new_dotdot;
+		drop_nlink(new_dir);
+		inc_nlink(old_dir);
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

