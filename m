Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4717D53501B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245488AbiEZNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243990AbiEZNlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25E64C66
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653572494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPpYHnXIBZc98vfrpGPPeNO4G+nbrOWi/rqlDfKtk/c=;
        b=X/laqBFRVhv6WlhxpVRLhAsz0uohm0B6J6bLbFj4M4EZe3uLrghPf56sUxkd3MW+QgS9YL
        9wtB7ktGLe9WIa6a6scE0uVJalXX5nsEZzstV0dlfRqkxxQD5Rs1rRdzv8znRAPddDBd5W
        B3VUBIHBfSy3kuFzDKTM7RicjSm3iz8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-tGYkW9k3MCWUHF6gsBxOEw-1; Thu, 26 May 2022 09:41:33 -0400
X-MC-Unique: tGYkW9k3MCWUHF6gsBxOEw-1
Received: by mail-wr1-f69.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so268948wra.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPpYHnXIBZc98vfrpGPPeNO4G+nbrOWi/rqlDfKtk/c=;
        b=WQAjkjL+FGsEZ5ByC4c1/oxuNX2ZSRwEKTamgiLadCxWbVJI5zS0OtaGEf3sRgDoOg
         0OaCtM6EdcdKvJJOkm78l1d+eKqXV3vgjoRuOKb2pTSetWxuxk7Wkoo0C7aEcIpfeLpX
         DDsDq1RpVeizl4djLh+43biDnucMRBjdUUgHpUeYNppNS+goGNgKZQW9qJ+1/NnDqAB6
         ya1Kx53pw8sMIGMZx0+dvfjWYh6ZTvU/yQAohp/5H9oUQEoWPk8JdR+e43zRLuJsrbGT
         DLZNGJq18EEZVMDRZAaWJr/HHC5w4Z9mKScwiwnt+b/gurdKU3jbsXwpXHB9F/MZzBEH
         vXXw==
X-Gm-Message-State: AOAM531YjjS10LyNA/lLALKfbfH3O+PIKedQ8eI8cz4WQAyRedzlFX9a
        WrdUgllgalc8XovoqCG9lZJGQVnpffoL7kcs6sF2hAz1GYTALX5Y5iamWBmZBsP50VnTNxME7w4
        7FQzuITPs9Dcixbd70AYdg/DwQtuFxkgd+CtA5oT+M8Civz3qhRO2PHsByFoPu5CefCuuIlti8k
        4=
X-Received: by 2002:a5d:6daf:0:b0:20f:f1e7:c720 with SMTP id u15-20020a5d6daf000000b0020ff1e7c720mr10535508wrs.584.1653572491881;
        Thu, 26 May 2022 06:41:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVYTuz6x/5UvuRXjQeFp4kffPnv1D04L8SNOA7VUlENyLLGoULl5N/3tWbwS2OIqt7VfQu5Q==
X-Received: by 2002:a5d:6daf:0:b0:20f:f1e7:c720 with SMTP id u15-20020a5d6daf000000b0020ff1e7c720mr10535483wrs.584.1653572491600;
        Thu, 26 May 2022 06:41:31 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d5046000000b0020c547f75easm1765022wrt.101.2022.05.26.06.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 06:41:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Kellner <ckellner@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH v3 1/3] fat: add a vfat_rename2() and make existing .rename callback a helper
Date:   Thu, 26 May 2022 15:41:17 +0200
Message-Id: <20220526134119.242182-2-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220526134119.242182-1-javierm@redhat.com>
References: <20220526134119.242182-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently vfat only supports the RENAME_NOREPLACE flag which is handled by
the virtual file system layer but doesn't support the RENAME_EXCHANGE flag.

Add a vfat_rename2() function to be used as the .rename callback and move
the current vfat_rename() handler to a helper. This is in preparation for
implementing the RENAME_NOREPLACE flag using a different helper function.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 fs/fat/namei_vfat.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index c573314806cf..88ccb2ee3537 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -889,9 +889,8 @@ static int vfat_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int vfat_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
-		       struct dentry *old_dentry, struct inode *new_dir,
-		       struct dentry *new_dentry, unsigned int flags)
+static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
+		       struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct buffer_head *dotdot_bh;
 	struct msdos_dir_entry *dotdot_de;
@@ -902,9 +901,6 @@ static int vfat_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	int err, is_dir, update_dotdot, corrupt = 0;
 	struct super_block *sb = old_dir->i_sb;
 
-	if (flags & ~RENAME_NOREPLACE)
-		return -EINVAL;
-
 	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
 	old_inode = d_inode(old_dentry);
 	new_inode = d_inode(new_dentry);
@@ -1021,13 +1017,24 @@ static int vfat_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	goto out;
 }
 
+static int vfat_rename2(struct user_namespace *mnt_userns, struct inode *old_dir,
+			struct dentry *old_dentry, struct inode *new_dir,
+			struct dentry *new_dentry, unsigned int flags)
+{
+	if (flags & ~RENAME_NOREPLACE)
+		return -EINVAL;
+
+	/* VFS already handled RENAME_NOREPLACE, handle it as a normal rename */
+	return vfat_rename(old_dir, old_dentry, new_dir, new_dentry);
+}
+
 static const struct inode_operations vfat_dir_inode_operations = {
 	.create		= vfat_create,
 	.lookup		= vfat_lookup,
 	.unlink		= vfat_unlink,
 	.mkdir		= vfat_mkdir,
 	.rmdir		= vfat_rmdir,
-	.rename		= vfat_rename,
+	.rename		= vfat_rename2,
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
 	.update_time	= fat_update_time,
-- 
2.36.1

