Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FC458AB7A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiHENUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiHENUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:20:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF0E29823
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:20:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w14so2609636plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=dcjIT1g0RtFKgH5EkyMJsy1rJrd93nNrE+p7/OkVeLg=;
        b=GKWrYDIzWoZ5X4vJXNLyCTeurJShxbWFGF1MGwCJVRVn9Lfh6hH0oPZeDxMIzvaDt6
         omiY8LhyvqlYDECeD9TgltYv8wRVjjMigqkSQTQgh5zNWeRd3+VHAxxGMEXHiVucuGSS
         SzPBdmrvGYfULHjJkhSHrYILRPGYFWWwo5bDgaZy9IiT+Oq3WQZZ0zUNtSF55JMQRr9u
         0soKYt5nPrl3ePVhN4imhRnqssAeOP32yhhNs469RiawxmdaMP/ySGjCg0JAmOUp4hEu
         jAI8aXPnJ/ZQMQPqXM6V6VtDh9LD9AH+dZWt6uzC2FY/iq3I1tinHWEILP3JYbBL8S6I
         xGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=dcjIT1g0RtFKgH5EkyMJsy1rJrd93nNrE+p7/OkVeLg=;
        b=5/sfeork+E9KNAw45QbSuRX6OYhhUTB8/36ljckOQQ70QJ18Jv4/QbHkTYwh7/BQ0W
         p9LQR1w9+YzT7ccn7zBQTHB08WIE+5y3Hskx92jaVHTW2tdpE8TmK/9hVuIcDm0FBF/+
         4qZl3dE+uY1Tm8a5VQrrv15q926gv4hYaIFAvMxNXpJ6CEY+b9n8HDBWcfALx/l+yyGI
         +DhopmBEciDeKaEH71itSG3sFIPUJ5ijrR38eelxZ0Wy4CqQp+9bblmqf4Ny5ZPccTex
         H4xGm0Rr4kbF/FVWlWjQVhiJU/gGBmzjSU+sQ7VxmCPRDfTJsveto7FRJ8u+LxnzlItc
         NpiQ==
X-Gm-Message-State: ACgBeo1kLE8fAAVLfAa3wfIkzB4+REYSHZ+diwWVFf5ZQ45TKll1NeYQ
        l9hY3L0oK7DpcgdIigeeRxnNbw==
X-Google-Smtp-Source: AA6agR5Uw1FO39ZriroJot/zJqQ35F6AuTQRe3bn0VVE7eWp5+j84Ai4POahvu6hbOAfU8NxT/C1UQ==
X-Received: by 2002:a17:90b:3511:b0:1f4:e0cd:1e04 with SMTP id ls17-20020a17090b351100b001f4e0cd1e04mr16532665pjb.154.1659705602470;
        Fri, 05 Aug 2022 06:20:02 -0700 (PDT)
Received: from bogon.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id a125-20020a621a83000000b0052dc5c14ee2sm2936716pfa.194.2022.08.05.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 06:20:01 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org (open list:FUSE: FILESYSTEM IN USERSPACE),
        linux-kernel@vger.kernel.org (open list)
Cc:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH] fuse: invalidate dentry on EEXIST creates or ENOENT deletes
Date:   Fri,  5 Aug 2022 21:18:22 +0800
Message-Id: <20220805131823.83544-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kernel creates a file which already exists on the server (EEXIST), we'd
better invalidate its negative dentry cache. Similarly, if kernel wants
to delete a file that is already deleted on the server (ENOENT), we can
also invalidate its positive dentry cache. This commit does this by
setting the fuse dentry timeout to 0 using fuse_invalidate_entry().

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/dir.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 74303d6e987b..3bb34a849831 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -669,7 +669,8 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
-	}
+	} else if (err == -EEXIST)
+		fuse_invalidate_entry(entry);
 out_dput:
 	dput(res);
 	return err;
@@ -758,6 +759,8 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	return 0;
 
  out_put_forget_req:
+	if (err == -EEXIST)
+		fuse_invalidate_entry(entry);
 	kfree(forget);
 	return err;
 }
@@ -892,7 +895,7 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	if (!err) {
 		fuse_dir_changed(dir);
 		fuse_entry_unlinked(entry);
-	} else if (err == -EINTR)
+	} else if (err == -EINTR || err == -ENOENT)
 		fuse_invalidate_entry(entry);
 	return err;
 }
@@ -915,7 +918,7 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	if (!err) {
 		fuse_dir_changed(dir);
 		fuse_entry_unlinked(entry);
-	} else if (err == -EINTR)
+	} else if (err == -EINTR || err == -ENOENT)
 		fuse_invalidate_entry(entry);
 	return err;
 }
@@ -956,7 +959,7 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 		/* newent will end up negative */
 		if (!(flags & RENAME_EXCHANGE) && d_really_is_positive(newent))
 			fuse_entry_unlinked(newent);
-	} else if (err == -EINTR) {
+	} else if (err == -EINTR || err == -ENOENT) {
 		/* If request was interrupted, DEITY only knows if the
 		   rename actually took place.  If the invalidation
 		   fails (e.g. some process has CWD under the renamed
-- 
2.20.1

