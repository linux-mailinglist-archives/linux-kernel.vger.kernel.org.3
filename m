Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DE5545DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346970AbiFJH5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347035AbiFJH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 486BB1CB700
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654847854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPpYHnXIBZc98vfrpGPPeNO4G+nbrOWi/rqlDfKtk/c=;
        b=YoEMvr7LBNPOAbkEUAIiEdC3paoJBH8lMNTORsdFXDF8pCjT2EkDOtjHcRI7H1Y8LpJ4hm
        fqYU5VNFYFJ9Xu6B/8w3Uh7K4f+nJ4qDEZ99HP5kDxTsYQlm/ibnADJ5Z8fuu5bLJBeA/r
        bObfXAtGS7hyVtXo6bnapjfbevVwYgo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-HY0a2PTXPvCLj_4vwjwxLQ-1; Fri, 10 Jun 2022 03:57:33 -0400
X-MC-Unique: HY0a2PTXPvCLj_4vwjwxLQ-1
Received: by mail-wm1-f71.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso964871wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPpYHnXIBZc98vfrpGPPeNO4G+nbrOWi/rqlDfKtk/c=;
        b=TQTRgEXDCsgk2CFUc1tElrCVlvCAP9KBBQcPWYaTJQ2s9rEBYP0HtU+QJzovPrimpC
         plL3YSYSjIkqPZIqIDIl5oKX2VPP+S/5qqmTFtluuUYZpuFhGYbR3kUdLHDhssbyyV5M
         +Eja009bGsgaFSsUA9y6mREn1S+ObPYLATRoH1rd4S07HMb8lzFgzWOLSWvQrE2nC3P/
         oN8qGHRqirNa7usuPrXu19hlsg7R5tt3kJCVjLRKgf6ZijcJjDKdI3i16lZ8BS6TEpcF
         24eQsbtg0bGnf9aobmoWq1H8SmZBK3wIb3Hkzv+VmKYexgnmbt8B1f8v55TEO9GdZiw3
         7/6A==
X-Gm-Message-State: AOAM530xoSFu63T1yTnXH7+BXY/Q8n1TEEJXaz97sELozxyCly8Ie6Ft
        y5nwMHhvScU+9fCfy1wkwY64dXvdiRwaG/prjV9fyxc8ce7zVnpOCsOS3rACYB/aVK4do88CtwS
        ShzzUIJiyJvrsso00P9QyHjpYv98zE1tvaHSPoyEFpclEAIWpXBL13FW0r7DX8Ck9ZgAh+hbpyD
        U=
X-Received: by 2002:a05:600c:3495:b0:39c:6a72:f286 with SMTP id a21-20020a05600c349500b0039c6a72f286mr7524529wmq.116.1654847852114;
        Fri, 10 Jun 2022 00:57:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgWTcfEx07dyJt9OHzUm9JUAGAHTErpr/4wjbKLCjZlo56Z7ixSmHdUFl3hD1fJRT96/dN2w==
X-Received: by 2002:a05:600c:3495:b0:39c:6a72:f286 with SMTP id a21-20020a05600c349500b0039c6a72f286mr7524493wmq.116.1654847851725;
        Fri, 10 Jun 2022 00:57:31 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm26673363wrt.7.2022.06.10.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 00:57:31 -0700 (PDT)
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
Subject: [PATCH v6 1/4] fat: add a vfat_rename2() and make existing .rename callback a helper
Date:   Fri, 10 Jun 2022 09:57:18 +0200
Message-Id: <20220610075721.1182745-2-javierm@redhat.com>
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

