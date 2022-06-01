Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEAD53ABF0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356345AbiFARcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356317AbiFARcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8DBA4969F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654104739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPpYHnXIBZc98vfrpGPPeNO4G+nbrOWi/rqlDfKtk/c=;
        b=C4faVBtu5SVjPWHmlXS4Ub4OxO84MNKj1a9c+WHq6uOfo2iZ9qK7djXa8CRu+VxAXIpHEq
        WDVn9Q476ChG45IRv4IHcDtwyhKNNqABl/uZhR/YKe0lfcUKraYdRmLX6LyBkihmixlxuk
        YPLHTrEwHTWzQU36P0xIXm9dplWUX0c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-zMwmhTKFOZyQ93Xj3I5EMg-1; Wed, 01 Jun 2022 13:32:18 -0400
X-MC-Unique: zMwmhTKFOZyQ93Xj3I5EMg-1
Received: by mail-wm1-f72.google.com with SMTP id m31-20020a05600c3b1f00b003973a563605so1233319wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 10:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPpYHnXIBZc98vfrpGPPeNO4G+nbrOWi/rqlDfKtk/c=;
        b=rfSbMxsnCj4ENBNZNRkV4PnTOaH/rZsqZE/Shp/XZCg0kcselxGikBwe8lTYY26Ndn
         /1RnpgcCDTA5dYpLEwA3hF2LDKD3Gvz2N3sITj3NRssJEcGVlNuEWfq/gX8q5fl5paae
         0qgN3qN1azRKnfumw5fIBKj5xVB9ohQfPoUsXbb4LEn3LnGBMk8ZhoKEoMr5zO4XusnQ
         9ReZzqhUV9Zym2fmAqCJyTxwTGrXdNsUqsXU74GS7PZKrGhzqrnCg+VFF8fwUutoVZby
         wlj0VlMPbXuvUw9B97VBdq3v7AG7XG+mcq5pn08UqK9c6CaiWN31jY218+jjb9eOiuiS
         NIYQ==
X-Gm-Message-State: AOAM530z5hgRZ8aDi/6Xm8kBenCIqABJemrSwpuwA5uH4cgxM1tiXDI/
        bAhIbkn7LvgZgswt6soGkRn9hupZHbPVuI3qGvqdSDv6aAV8k+roh5/MldKqq07+7WLEpnB/ulK
        kkTKqfup+l28jGScx4/381bUHrfJau5LzhVigb9ppAZzyJDbKGnbw1MDkruQMhBO1U0fr/QhP3n
        A=
X-Received: by 2002:adf:f543:0:b0:20d:80e:dde with SMTP id j3-20020adff543000000b0020d080e0ddemr416223wrp.269.1654104736798;
        Wed, 01 Jun 2022 10:32:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFt4kSB0J1yMSflWtg8+2t1z+6EiKuq0CkHuJQlcL8A8zszR+zmZxYet5a5WuR7xmVQm2Mtg==
X-Received: by 2002:adf:f543:0:b0:20d:80e:dde with SMTP id j3-20020adff543000000b0020d080e0ddemr416198wrp.269.1654104736545;
        Wed, 01 Jun 2022 10:32:16 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c2cce00b0039751bb8c62sm6525625wmc.24.2022.06.01.10.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 10:32:16 -0700 (PDT)
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
Subject: [PATCH v4 1/4] fat: add a vfat_rename2() and make existing .rename callback a helper
Date:   Wed,  1 Jun 2022 19:32:01 +0200
Message-Id: <20220601173204.1372569-2-javierm@redhat.com>
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

