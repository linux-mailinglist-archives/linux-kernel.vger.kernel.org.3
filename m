Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F244757A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhLOLS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhLOLS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:18:58 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B03C061574;
        Wed, 15 Dec 2021 03:18:57 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id z8so32765558ljz.9;
        Wed, 15 Dec 2021 03:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iD5FS+pADzZEToC0e34KFGL1GiX7ZefxDv3Wj+qX1Pg=;
        b=p6e2OpvTxtT69msu1IjC0hRcI5eRMoNLKgZjH7+WewhPkJ3CP6Gbx9vf+oO/K4aCRg
         7BlENv3osqMFZFrWbn8gosKoWnBg0wbO7gr8jnRIq56047unumIpGEaSgZIgWvNXcUDQ
         wwdkAMPENzlS0ep683rwitRkudK23gHXzRyFoa3h+tS8OaHuazFoptkG/Wa4D/xgIRjY
         xGWvCeTb5Yt7nW+IxKJcAR2RIvyl0CVKkavn6l8t6OyE+y3KFxPvE/cLH3560avzunwT
         RIdF1PSC+ljac5MBZ45hmDwlBZWc10lY9hiPNwStitwOtVWmtuUBIlXjzbyIr1ocnM2p
         Y3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iD5FS+pADzZEToC0e34KFGL1GiX7ZefxDv3Wj+qX1Pg=;
        b=mL5EFkVyCPaF0pi0MzFkSGbiKNlSCYcGyrT35PHXuXIONhiW0AbD7Kyy9jGJqexr9/
         6SpZ8C7hGKpnmKotUNhR/oNplfuQV1En5RvDDOgbTmIUZcoSt5ybo34dr+ENEmoh/M6O
         C4mYnJ824h2/RZMUvAJY+NGMdIawMBwNiOoVGuF5S7FccLNDFpFoANkhMP+1EZVTYchQ
         7avwM90DYZyGBJGCo2Q8qMWQaNpMDwux0RLnFFy+JdbvYanyGKzm8FFbr5yqYQMevQ7a
         sdcgaVRoLz2o55O8awzMdjaNa0f2MWcK2AzcmsrkfvdsT27sSgeXO/Dw7DWhpbnm3FlH
         oQRA==
X-Gm-Message-State: AOAM531HATDLqlZbe13PAxykFj6Yw3X0afMJDS+afqka5m92TNZDUOmV
        iV0RX+Bfi37dh3eYRDX6BxCUpSl0N8Ji/dtF
X-Google-Smtp-Source: ABdhPJwhWwHdT5c0tsrQjMSgAZQ2T7IO0GiPrMfJFNR/4LYdF1jUpXfO+Rt0eCmZxqLL0o+HbJsyMQ==
X-Received: by 2002:a2e:8691:: with SMTP id l17mr9337171lji.119.1639567135698;
        Wed, 15 Dec 2021 03:18:55 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n17sm383906ljg.128.2021.12.15.03.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 03:18:54 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH RESEND] ext4: Replace ext4_kvfree_array_rcu() by kvfree_rcu() API
Date:   Wed, 15 Dec 2021 12:18:38 +0100
Message-Id: <20211215111845.2514-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215111845.2514-1-urezki@gmail.com>
References: <20211215111845.2514-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ext4_kvfree_array_rcu() function was introduced in order to
release some memory after a grace period during resizing of a
partition. An object that is freed does not contain any rcu_head
filed.

To do so, it requires to allocate some extra memory for a special
structure that has an rcu_head filed and pointer one where a freed
memory is attached. Finally call_rcu() API is invoked.

Since we have a single argument of kvfree_rcu() API, we can easily
replace all that tricky code by one single call that does the same
but in more efficient way.

TO: "Theodore Ts'o" <tytso@mit.edu>
TO: linux-ext4@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 fs/ext4/ext4.h    |  1 -
 fs/ext4/mballoc.c |  2 +-
 fs/ext4/resize.c  | 31 ++-----------------------------
 fs/ext4/super.c   |  2 +-
 4 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 404dd50856e5..7e8ff3ac2beb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3089,7 +3089,6 @@ extern int ext4_generic_delete_entry(struct inode *dir,
 extern bool ext4_empty_dir(struct inode *inode);
 
 /* resize.c */
-extern void ext4_kvfree_array_rcu(void *to_free);
 extern int ext4_group_add(struct super_block *sb,
 				struct ext4_new_group_data *input);
 extern int ext4_group_extend(struct super_block *sb,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 215b7068f548..b0469f7a5c55 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3109,7 +3109,7 @@ int ext4_mb_alloc_groupinfo(struct super_block *sb, ext4_group_t ngroups)
 	rcu_assign_pointer(sbi->s_group_info, new_groupinfo);
 	sbi->s_group_info_size = size / sizeof(*sbi->s_group_info);
 	if (old_groupinfo)
-		ext4_kvfree_array_rcu(old_groupinfo);
+		kvfree_rcu(old_groupinfo);
 	ext4_debug("allocated s_groupinfo array for %d meta_bg's\n",
 		   sbi->s_group_info_size);
 	return 0;
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index b63cb88ccdae..ac6aa037aaab 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -17,33 +17,6 @@
 
 #include "ext4_jbd2.h"
 
-struct ext4_rcu_ptr {
-	struct rcu_head rcu;
-	void *ptr;
-};
-
-static void ext4_rcu_ptr_callback(struct rcu_head *head)
-{
-	struct ext4_rcu_ptr *ptr;
-
-	ptr = container_of(head, struct ext4_rcu_ptr, rcu);
-	kvfree(ptr->ptr);
-	kfree(ptr);
-}
-
-void ext4_kvfree_array_rcu(void *to_free)
-{
-	struct ext4_rcu_ptr *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
-
-	if (ptr) {
-		ptr->ptr = to_free;
-		call_rcu(&ptr->rcu, ext4_rcu_ptr_callback);
-		return;
-	}
-	synchronize_rcu();
-	kvfree(to_free);
-}
-
 int ext4_resize_begin(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -906,7 +879,7 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	n_group_desc[gdb_num] = gdb_bh;
 	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
 	EXT4_SB(sb)->s_gdb_count++;
-	ext4_kvfree_array_rcu(o_group_desc);
+	kvfree_rcu(o_group_desc);
 
 	lock_buffer(EXT4_SB(sb)->s_sbh);
 	le16_add_cpu(&es->s_reserved_gdt_blocks, -1);
@@ -969,7 +942,7 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 
 	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
 	EXT4_SB(sb)->s_gdb_count++;
-	ext4_kvfree_array_rcu(o_group_desc);
+	kvfree_rcu(o_group_desc);
 	return err;
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 111b0498a232..3942cd271a00 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2759,7 +2759,7 @@ int ext4_alloc_flex_bg_array(struct super_block *sb, ext4_group_t ngroup)
 	rcu_assign_pointer(sbi->s_flex_groups, new_groups);
 	sbi->s_flex_groups_allocated = size;
 	if (old_groups)
-		ext4_kvfree_array_rcu(old_groups);
+		kvfree_rcu(old_groups);
 	return 0;
 }
 
-- 
2.30.2

