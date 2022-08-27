Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766555A3332
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 02:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345133AbiH0Aoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 20:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiH0Aoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:44:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9E0EA32B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:44:29 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g189so2821733pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=AeF5UjauZ4cxLdwG16cc9PyRRCH352X72B0wsJdtiC0=;
        b=JNawRDATTyCUOF3ePGLGTTld/aziTxWNAPZ/9QyplpeUpDAi2FJ9+lgB+VyohcnEIk
         v+/EgG7SAu2B1dw/FYJUD0Xj5f3e8yqIZJzyp1ztOEOcIvvthiRnV34/KytSrNT8rZz1
         n3pEAg2vnSa9A67mrNj+rC0HnRiCQ5C+bNlLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=AeF5UjauZ4cxLdwG16cc9PyRRCH352X72B0wsJdtiC0=;
        b=7yU58XCjQj1AFpG5h9rcA0C17qeQ2vpL7j8Dq1+7lPA9DM13M8xokiZ1hmhgZXm5Sh
         0wgDkBMYBMCvr42fCquGPEGceDAJA/wTsB35jM/zRML3cWC7ybv3xgFYZwiFDfRWi81p
         gDvxZ94yKgS77abhUb4mR/KdM2RXGy3yRu0Em7dDYrxp4pz/7bIg5LbxtoNpRcxkrZIL
         Lg/KYFl+QQXdflkSwbv6FW347egixVnGi5f4TcoW1WWyB98iS6wAQiGnAzlvE61TrviA
         d93iDoOqBkzxmSoKTqM5EtFQLgXjcp9x/qmR9/FkFEYi5x63pAAe8MGaIN4M96bm/zAu
         dD1g==
X-Gm-Message-State: ACgBeo1fxVFSCnj5yRIGiVnpDeLs6alRa+QtHb2eF+1qsZub+Ko9dBd6
        fsvzktadpFceYq4Z+D9zBE/0BA==
X-Google-Smtp-Source: AA6agR4/PsPvD/4lgDefpw9KNyNxzLYnXW2WLTucK4IJd0A+Nbw7ZH0/+lar2rhzFpbEV6z0h93pjg==
X-Received: by 2002:a63:224a:0:b0:41e:1d36:5063 with SMTP id t10-20020a63224a000000b0041e1d365063mr5085643pgm.568.1661561068898;
        Fri, 26 Aug 2022 17:44:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f351:6a22:e571:bde5])
        by smtp.gmail.com with UTF8SMTPSA id n10-20020a170902f60a00b001714853e503sm2229649plg.36.2022.08.26.17.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 17:44:28 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/2] debugfs: Only clobber mode/uid/gid on remount if asked
Date:   Fri, 26 Aug 2022 17:44:16 -0700
Message-Id: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users may have explicitly configured their debugfs permissions; we
shouldn't overwrite those just because a second mount appeared.

Only clobber if the options were provided at mount time.

  # Don't change /sys/kernel/debug/ permissions.
  mount -t debugfs none /mnt/foo

  # Change /sys/kernel/debug/ mode and uid, but not gid.
  mount -t debugfs -o uid=bar,mode=0750 none /mnt/baz

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
I'm open to writing an LTP test case for this, if that seems like a good
idea.

 fs/debugfs/inode.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 3dcf0b8b4e93..1e36ce013631 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -82,6 +82,8 @@ struct debugfs_mount_opts {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
+	/* Opt_* bitfield. */
+	unsigned int opts;
 };
 
 enum {
@@ -111,6 +113,7 @@ static int debugfs_parse_options(char *data, struct debugfs_mount_opts *opts)
 	kgid_t gid;
 	char *p;
 
+	opts->opts = 0;
 	opts->mode = DEBUGFS_DEFAULT_MODE;
 
 	while ((p = strsep(&data, ",")) != NULL) {
@@ -145,22 +148,34 @@ static int debugfs_parse_options(char *data, struct debugfs_mount_opts *opts)
 		 * but traditionally debugfs has ignored all mount options
 		 */
 		}
+
+		opts->opts |= BIT(token);
 	}
 
 	return 0;
 }
 
-static int debugfs_apply_options(struct super_block *sb)
+static int debugfs_apply_options(struct super_block *sb, bool remount)
 {
 	struct debugfs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = d_inode(sb->s_root);
 	struct debugfs_mount_opts *opts = &fsi->mount_opts;
 
-	inode->i_mode &= ~S_IALLUGO;
-	inode->i_mode |= opts->mode;
+	/*
+	 * On remount, only reset mode/uid/gid if they were provided as mount
+	 * options.
+	 */
+
+	if (!remount || opts->opts & BIT(Opt_mode)) {
+		inode->i_mode &= ~S_IALLUGO;
+		inode->i_mode |= opts->mode;
+	}
+
+	if (!remount || opts->opts & BIT(Opt_uid))
+		inode->i_uid = opts->uid;
 
-	inode->i_uid = opts->uid;
-	inode->i_gid = opts->gid;
+	if (!remount || opts->opts & BIT(Opt_gid))
+		inode->i_gid = opts->gid;
 
 	return 0;
 }
@@ -175,7 +190,7 @@ static int debugfs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto fail;
 
-	debugfs_apply_options(sb);
+	debugfs_apply_options(sb, true);
 
 fail:
 	return err;
@@ -257,7 +272,7 @@ static int debug_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &debugfs_super_operations;
 	sb->s_d_op = &debugfs_dops;
 
-	debugfs_apply_options(sb);
+	debugfs_apply_options(sb, false);
 
 	return 0;
 
-- 
2.37.2.672.g94769d06f0-goog

