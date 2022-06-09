Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D45C5447B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242710AbiFIJhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbiFIJg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74A022AE1E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654767414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UvTYFnM/Xxan4k4LuRTmFLCKv7+5+mh7KcxWLzDn8Q=;
        b=QGsSuitqFZGU75WBo8c3QUjYVw5J1DzV31oRgPwEWnhASPKdfwPxxBZRkEqePa2cfOxbyb
        p7/J0XFm0LXl+uKjmqMctGo9w88LGaw7BXVkkqKZu0V8QC652ZOaLIaHqgz6zq9Mo/Pa7Q
        vhRAgAKvcie2hz7RURm6MRx5d5yV/6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-3md41eXgMB-ztbZ8jCz5Bg-1; Thu, 09 Jun 2022 05:36:53 -0400
X-MC-Unique: 3md41eXgMB-ztbZ8jCz5Bg-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a05600c1c8500b003974c5d636dso11128374wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UvTYFnM/Xxan4k4LuRTmFLCKv7+5+mh7KcxWLzDn8Q=;
        b=W0gF48nKoSO6T9KjGp8mGQ9fbVhsHxiLL/uQxwT/kJVJFVsWOunw76GXZkybB9ElsG
         NL5jAP00NP4IGlCu9P2cyYyDnb4/VXoZvoomX0Tp5p58pARk7ZcdD6hVqu/r9HZIRacO
         PmCB3OHlwT8VRYqxgVabaqI7YFmXrHbXmzSJ3vbh63x6oXswdJoSs70Iq3XM9QlEBtV2
         yeMiJx7oeUScQk5BlXWIdAKhrJKWgtfz7VbiegYgJDQX2/gdxL5LZrA3AuB3EOGx+XuW
         CuplXbkqM67azpOMAQWzScM9YEyqsdOjoDaqvWLuHi2eF9OSRKV8njC2oMIbkjC01tDy
         1eYg==
X-Gm-Message-State: AOAM533TesrPmBykZjh+KPRJkfXPT+0ntgEKrxxxji09J7VkhQ3T68Fw
        HsmwlthndiEsEA1sNaTfLQ1j7q5us2kB/Iy8w6/p99X21xDaMYKVVK4qoAx7W36UgdK76RijJ7Z
        gLL/RhNoerXANCWDymnSH0S0pJfYQzLSH1JMJI38jNcAm7tYBrZCe3T7w+mcXM3k5n6jD7yK6FP
        8=
X-Received: by 2002:a5d:47c1:0:b0:217:1959:3bf5 with SMTP id o1-20020a5d47c1000000b0021719593bf5mr24815402wrc.319.1654767412360;
        Thu, 09 Jun 2022 02:36:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/vk0jTmvLixTNTZ4cEfwH6NOZxQ1acz3ugi2ZEReCLpUZFSF42fv907hzDvm0X2jMXV0Cgw==
X-Received: by 2002:a5d:47c1:0:b0:217:1959:3bf5 with SMTP id o1-20020a5d47c1000000b0021719593bf5mr24815364wrc.319.1654767412065;
        Thu, 09 Jun 2022 02:36:52 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00397122e63b6sm27385580wms.29.2022.06.09.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:36:51 -0700 (PDT)
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
Subject: [PATCH v5 2/4] fat: factor out reusable code in vfat_rename() as helper functions
Date:   Thu,  9 Jun 2022 11:36:35 +0200
Message-Id: <20220609093638.664034-3-javierm@redhat.com>
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

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

The vfat_rename() function is quite big and there are code blocks that can
be moved into helper functions. This not only simplify the implementation
of that function but also allows these helpers to be reused.

For example, the helpers can be used by the handler of the RENAME_EXCHANGE
flag once this is implemented in a subsequent patch.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v4)

Changes in v4:
- Add new patch from OGAWA Hirofumi to use the helpers in vfat_rename().

 fs/fat/namei_vfat.c | 89 +++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 32 deletions(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 88ccb2ee3537..9c04053a8f1c 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -889,16 +889,55 @@ static int vfat_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
+static int vfat_get_dotdot_de(struct inode *inode, struct buffer_head **bh,
+			      struct msdos_dir_entry **de)
+{
+	if (S_ISDIR(inode->i_mode)) {
+		if (fat_get_dotdot_entry(inode, bh, de))
+			return -EIO;
+	}
+	return 0;
+}
+
+static int vfat_sync_ipos(struct inode *dir, struct inode *inode)
+{
+	if (IS_DIRSYNC(dir))
+		return fat_sync_inode(inode);
+	mark_inode_dirty(inode);
+	return 0;
+}
+
+static int vfat_update_dotdot_de(struct inode *dir, struct inode *inode,
+				 struct buffer_head *dotdot_bh,
+				 struct msdos_dir_entry *dotdot_de)
+{
+	fat_set_start(dotdot_de, MSDOS_I(dir)->i_logstart);
+	mark_buffer_dirty_inode(dotdot_bh, inode);
+	if (IS_DIRSYNC(dir))
+		return sync_dirty_buffer(dotdot_bh);
+	return 0;
+}
+
+static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
+{
+	inode_inc_iversion(dir);
+	fat_truncate_time(dir, ts, S_CTIME | S_MTIME);
+	if (IS_DIRSYNC(dir))
+		(void)fat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
+}
+
 static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		       struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct buffer_head *dotdot_bh;
-	struct msdos_dir_entry *dotdot_de;
+	struct msdos_dir_entry *dotdot_de = NULL;
 	struct inode *old_inode, *new_inode;
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec64 ts;
 	loff_t new_i_pos;
-	int err, is_dir, update_dotdot, corrupt = 0;
+	int err, is_dir, corrupt = 0;
 	struct super_block *sb = old_dir->i_sb;
 
 	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
@@ -909,15 +948,13 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		goto out;
 
-	is_dir = S_ISDIR(old_inode->i_mode);
-	update_dotdot = (is_dir && old_dir != new_dir);
-	if (update_dotdot) {
-		if (fat_get_dotdot_entry(old_inode, &dotdot_bh, &dotdot_de)) {
-			err = -EIO;
+	if (old_dir != new_dir) {
+		err = vfat_get_dotdot_de(old_inode, &dotdot_bh, &dotdot_de);
+		if (err)
 			goto out;
-		}
 	}
 
+	is_dir = S_ISDIR(old_inode->i_mode);
 	ts = current_time(old_dir);
 	if (new_inode) {
 		if (is_dir) {
@@ -938,21 +975,15 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	fat_detach(old_inode);
 	fat_attach(old_inode, new_i_pos);
-	if (IS_DIRSYNC(new_dir)) {
-		err = fat_sync_inode(old_inode);
-		if (err)
-			goto error_inode;
-	} else
-		mark_inode_dirty(old_inode);
+	err = vfat_sync_ipos(new_dir, old_inode);
+	if (err)
+		goto error_inode;
 
-	if (update_dotdot) {
-		fat_set_start(dotdot_de, MSDOS_I(new_dir)->i_logstart);
-		mark_buffer_dirty_inode(dotdot_bh, old_inode);
-		if (IS_DIRSYNC(new_dir)) {
-			err = sync_dirty_buffer(dotdot_bh);
-			if (err)
-				goto error_dotdot;
-		}
+	if (dotdot_de) {
+		err = vfat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
+					    dotdot_de);
+		if (err)
+			goto error_dotdot;
 		drop_nlink(old_dir);
 		if (!new_inode)
  			inc_nlink(new_dir);
@@ -962,12 +993,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	old_sinfo.bh = NULL;
 	if (err)
 		goto error_dotdot;
-	inode_inc_iversion(old_dir);
-	fat_truncate_time(old_dir, &ts, S_CTIME|S_MTIME);
-	if (IS_DIRSYNC(old_dir))
-		(void)fat_sync_inode(old_dir);
-	else
-		mark_inode_dirty(old_dir);
+	vfat_update_dir_metadata(old_dir, &ts);
 
 	if (new_inode) {
 		drop_nlink(new_inode);
@@ -987,10 +1013,9 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	/* data cluster is shared, serious corruption */
 	corrupt = 1;
 
-	if (update_dotdot) {
-		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
-		mark_buffer_dirty_inode(dotdot_bh, old_inode);
-		corrupt |= sync_dirty_buffer(dotdot_bh);
+	if (dotdot_de) {
+		corrupt |= vfat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
+						 dotdot_de);
 	}
 error_inode:
 	fat_detach(old_inode);
-- 
2.36.1

