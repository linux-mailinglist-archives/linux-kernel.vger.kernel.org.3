Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209795447B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiFIJhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242516AbiFIJg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CA6928E30
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654767413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPpYHnXIBZc98vfrpGPPeNO4G+nbrOWi/rqlDfKtk/c=;
        b=CSGLSnmFMRJ2m8g4U9LiTMcoVjjO2Y4SeFRNjTO2/yze+jw+Xm03scjykEHa2V+OIMXgSD
        BmNh78qZoMQnUakWf1KiAIzdUlm9QyJ3k+yQPADw64Qsf+txYRa/hXE2aHqSTkhUI9aR/W
        mvO5ZQ5UQYBFxYWG2w/waSk4Hh6K21s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-uhaPHohYM3Ot5m0oL10eAw-1; Thu, 09 Jun 2022 05:36:52 -0400
X-MC-Unique: uhaPHohYM3Ot5m0oL10eAw-1
Received: by mail-wm1-f71.google.com with SMTP id j31-20020a05600c1c1f00b0039c481c4664so3953198wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPpYHnXIBZc98vfrpGPPeNO4G+nbrOWi/rqlDfKtk/c=;
        b=HtaQKE8A4zNm30udXXuZI61C9z+I9OHF3SEqHlL7cMgw1pXGCvoOvyd/S7Bj85DEJV
         HxFWXblQDw1J4V/cImDjg63J21MkrmyKluJPXm7WJfBDhlztgaIcwbiw4jmf+Pb7A/Eq
         luGVASBLbMcDw5XomVPHHx5Zg5UmyxD+LL1zlm6LuqmR0oQJskrOPmCR9tzcbxB5eZEn
         Lou3Rlmls+9SplET8wpw9XDBUrjRSOKk/tMLCmwK4qiTNPp3dWgeCB2KbkOLRu7XMPUI
         765CR5xE0woXu9e5DzQG//If/LpSXvl46PUr7JzGnrHzBCj4dWORJS4EMuT5PUm3gpUZ
         HXcg==
X-Gm-Message-State: AOAM533t2NEzs8mViK8yc/WMkzLk3DDMdZRtOJs+igaZUrm5a9HPuco7
        eGt5SbZJOvdlUrzIJlqSnNDiLeweqSF2+XeoVKjwUY+A90Yrt7iXvA+RXOPAiFQ4k8CbMao/X8X
        OXBJBiy5ENED/lAY6/ACq+II6YtVYVX/l/DrqJk+jyeY06NM7xFkjTCnIv1Br6g6he8y/OqdnvM
        w=
X-Received: by 2002:adf:d1ca:0:b0:218:47e1:ab0b with SMTP id b10-20020adfd1ca000000b0021847e1ab0bmr16907164wrd.90.1654767411231;
        Thu, 09 Jun 2022 02:36:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymFw6eUMkR7CNYmHzwLfgqtmOzRz6ug7p6629lFPTqTuSd5slid+3U6WpmMw011viGhpAfeQ==
X-Received: by 2002:adf:d1ca:0:b0:218:47e1:ab0b with SMTP id b10-20020adfd1ca000000b0021847e1ab0bmr16907129wrd.90.1654767410957;
        Thu, 09 Jun 2022 02:36:50 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00397122e63b6sm27385580wms.29.2022.06.09.02.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:36:50 -0700 (PDT)
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
Subject: [PATCH v5 1/4] fat: add a vfat_rename2() and make existing .rename callback a helper
Date:   Thu,  9 Jun 2022 11:36:34 +0200
Message-Id: <20220609093638.664034-2-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609093638.664034-1-javierm@redhat.com>
References: <20220609093638.664034-1-javierm@redhat.com>
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

