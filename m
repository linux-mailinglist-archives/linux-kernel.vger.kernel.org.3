Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CED52CF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiESJYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiESJYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3E49A76ED
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652952252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17jbVsw+moEo6hJdd/lN8c/+3+IYlduGpqbhyDnKS8E=;
        b=K0cmh4zrnteiWxB6Q4dFZihhTcvJ2tk3u2PoQGIw+H9LB31llvmgJLMa+OMoCZEMAkIqw0
        ZCtYBzHB11OEuJSEXK1EYO5zypnvgApKwQQxAVWfLdiKZh+Fouvl7dVkw9+g9yrLCPlfGF
        TdfWM+xGGewWPZRtvpQoJZz/5XHxt/o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-2UpCg0R-MquPz8GcXgB4WQ-1; Thu, 19 May 2022 05:24:11 -0400
X-MC-Unique: 2UpCg0R-MquPz8GcXgB4WQ-1
Received: by mail-wm1-f72.google.com with SMTP id v124-20020a1cac82000000b003948b870a8dso4260279wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17jbVsw+moEo6hJdd/lN8c/+3+IYlduGpqbhyDnKS8E=;
        b=NOaLjEhATRwWrBFFzihWHGQ57ei4ILE4YFOZb/8EwoDJUXFLFg7HiWwNDuSHUNdmNV
         Umw/VgJE+MGFk+V/vmmzJC6PPlUpu9qAFUBLlAVag8k6Zi81PMIebfXxiD/4KYBftmRJ
         9Ucu5X3ElPx4kRJTwe43wMhspnXhgcepIAj7Et9leWcLUEU5hmLUdt9Ne51r496K8ZZ4
         i0JLJj6qzJwZPSxOCP1bCktdVs/4IKctoAy1BkPAZNl3rMBChK/ODfp5usrvfjZb6ujS
         4w9MtQ+t3Zpime1wVpu9wIdk/FaPjvQUzH5FopSgZjecS9YYC1oA/hE2NE8EylFZOUAR
         TjRA==
X-Gm-Message-State: AOAM530zDv/xcka1EdwqAtY+k213Ox6qMLH8pSG6+dj+TNURzGJ7QVC/
        ChCInPrQ0xkZW57ZgJ6N2buGDeSjmnCJaSGm6X0A/4kvon/GVt/JR/YyXQ3xCzD/ie0lYP8iOp7
        3HKx461njpy+UHnZVoGtmwinD+67g7Y5ydWCLY310AL8f53lsWQbpWTJP7tvQbFHNrLU4xf8egg
        E=
X-Received: by 2002:adf:d090:0:b0:20d:3d4:8845 with SMTP id y16-20020adfd090000000b0020d03d48845mr3268331wrh.162.1652952250463;
        Thu, 19 May 2022 02:24:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+cy933X3rEwzU9/Ah7qzOGFkRbtoIk3v5PlWkKn+OSJkQqFhd2q0Nx9n+x09aDxK01OAu4A==
X-Received: by 2002:adf:d090:0:b0:20d:3d4:8845 with SMTP id y16-20020adfd090000000b0020d03d48845mr3268310wrh.162.1652952250251;
        Thu, 19 May 2022 02:24:10 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d6b8a000000b0020c5253d8fasm4104647wrx.70.2022.05.19.02.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 02:24:09 -0700 (PDT)
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
Subject: [RFC PATCH 1/3] fat: add a vfat_rename2() and make existing .rename callback a helper
Date:   Thu, 19 May 2022 11:23:41 +0200
Message-Id: <20220519092343.2776414-2-javierm@redhat.com>
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

Currently vfat only supports the RENAME_NOREPLACE flag which is handled by
the virtual file system layer but doesn't support the RENAME_EXCHANGE flag.

Add a vfat_rename2() function to be used as the .rename callback and move
the current vfat_rename() handler to a helper. This is in preparation for
implementing the RENAME_NOREPLACE flag using a different helper function.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

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
2.35.1

