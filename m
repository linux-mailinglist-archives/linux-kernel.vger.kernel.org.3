Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375BC532430
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiEXHgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiEXHgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 637FB50E0B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653377787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPpYHnXIBZc98vfrpGPPeNO4G+nbrOWi/rqlDfKtk/c=;
        b=QHyw8IHQEz6QYN4ZFcB+PD4jghKTRtFQq+C0pduSt7aKn47EdM7UG+xSf4F3QPBv3kSKU3
        xX9slm6HE8A6lC1LvfEhhk4ATEwwVvjIfDl10VOSyEP/Ho/f+YH59KOtttoMXB50HGMyQF
        7VeGEzKg+3YPeEXYA7HX4Aijz2BhV8I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-5KAyOmSPNNG3jYCGv1Q7ow-1; Tue, 24 May 2022 03:36:25 -0400
X-MC-Unique: 5KAyOmSPNNG3jYCGv1Q7ow-1
Received: by mail-wr1-f70.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so4486124wrg.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPpYHnXIBZc98vfrpGPPeNO4G+nbrOWi/rqlDfKtk/c=;
        b=MNSC6tzH+QLS5U9uf+LY5R8HfWtZaq5kSHA1FKoVjDFSmb1Hrwl+NB/DQWFtnzJ2ER
         PPBUxm9kYRmOLzgt3H/ii6pecNjIBNQnI4P5iw52+G+QvzwJ5tHXEcKLENVv7WKQozFW
         Qwr581UT/1lNmy/nhUx6hFVamhIMFepEURAtRmzk/MVK2U+eCL0/NcQH/B5NQw7iXW87
         0GFz2cOVl6p84x+OiNol0D+rROk2h1fV8tbEldeSqdtlYqa2ZuUDq9B/TUvRMjySJbwv
         o1YDoSMQVf6almeMUC3H/pFQk0S2MxFwFjm/HUufTb35gQGMD6CJtCI07Bq7m0XKlTH+
         DTLw==
X-Gm-Message-State: AOAM531oEvc2pyjJHP8p6K6GAr50JzJBa/MEKWh8h3AtFi23K+iqDc6O
        SNbFF9Nep+3Az6eJWMBuxLww9V/PXa2hcDRWTLn8KHG7XwnHEq4KWEfyLs2+dk/QKvn1MnEZ/o6
        5EzIltTnxpQFm0CTtQAZprQd+q1ph0rWOomRu1FmnhD8vch25RxXxTrS+JUScmkcNRnD5l4prwn
        Q=
X-Received: by 2002:a1c:cc07:0:b0:397:b2f:ac59 with SMTP id h7-20020a1ccc07000000b003970b2fac59mr2402568wmb.157.1653377784581;
        Tue, 24 May 2022 00:36:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuUGmmf6De8j0Vb1q2r+xRSubiNWQ86vtCLBVplu81PlvJpiqs971RkOnFdaBSvgbgP5aABg==
X-Received: by 2002:a1c:cc07:0:b0:397:b2f:ac59 with SMTP id h7-20020a1ccc07000000b003970b2fac59mr2402537wmb.157.1653377784301;
        Tue, 24 May 2022 00:36:24 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f2-20020adfc982000000b0020c5253d927sm12202174wrh.115.2022.05.24.00.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:36:23 -0700 (PDT)
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
Subject: [PATCH v2 1/3] fat: add a vfat_rename2() and make existing .rename callback a helper
Date:   Tue, 24 May 2022 09:36:02 +0200
Message-Id: <20220524073604.247790-2-javierm@redhat.com>
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

