Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89395B2AEC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIIAO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiIIAN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:13:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487EA112136
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:13:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b144so87811pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 17:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IIv0Wd8V42Sm0RjU0iSsF5/LDAY3qL0xYf2961AQt8A=;
        b=Iqh33wq5RnBx2adRKf9efuWpC1AeeOA0JuhXpGfUsEJSPa+7S0INvedW0wcVLd/Ri5
         Lqyir+8U9Utba4PM7gYZHb2wwcAAHO1SV02i3mkabizomCQ7rGz2BiaIF/F6GWwqxFUh
         JbofYWR4vjg0sY2+VSHT2HGFHz8K3NyFJALBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IIv0Wd8V42Sm0RjU0iSsF5/LDAY3qL0xYf2961AQt8A=;
        b=5ECJjYcm1J/1X20UErwfX6UwS8l+uHM3wRAfTTreRRqEnVZOu58IQXPrs8xu2iZ8xc
         VNt5plfUpz5AedpEaMZphuO5/eIshR8KdTh+5AAGvPhLslEJ2i78cksO2S5taII+TyO6
         w/zqODqRrttM4K+zbxmq5eJ8zTrmfccDahFJTBdMtte0Mw5lDudkmaMzIoCyTCiuFhSF
         nLmC61+m++lerjzfSZu1FBYTs1iayBKt2tZkV8zQGjkPj98s9BN5aA3RIaTuldSHgQUi
         P0O665Izl5v1QXpZQ+lpwsF2EWlzvLRfJImDralnj9aG12vQGLtkb6AbA+e/9GFJ6J8Q
         3Dbw==
X-Gm-Message-State: ACgBeo1R6LfSemvdG2tghx8AMqeuEYU+RREtbLrfNAP8xYs+Qd7Ibdv7
        KuWxeR6kwOlXNhf63wgtDWWFxw==
X-Google-Smtp-Source: AA6agR5fGUqjqTCMm+pIkqzG0OwF8mzO+AD75vrlf8aBUi+ZExBbCUQWFZYycAHfYWHGcSu02NcBIQ==
X-Received: by 2002:a63:1853:0:b0:41d:70c0:978e with SMTP id 19-20020a631853000000b0041d70c0978emr10177984pgy.32.1662682412712;
        Thu, 08 Sep 2022 17:13:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:da1a:c731:7561:7e5b])
        by smtp.gmail.com with UTF8SMTPSA id r8-20020aa79ec8000000b0053653c6b9f9sm189830pfq.204.2022.09.08.17.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 17:13:32 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] debugfs: Only clobber mode/uid/gid on remount if asked
Date:   Thu,  8 Sep 2022 17:13:22 -0700
Message-Id: <20220908171319.v2.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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

Existing behavior:

  ## Pre-existing status: debugfs is 0755.
  # chmod 755 /sys/kernel/debug/
  # stat -c '%A' /sys/kernel/debug/
  drwxr-xr-x

  ## New mount sets kernel-default permissions:
  # mount -t debugfs none /mnt/foo
  # stat -c '%A' /mnt/foo
  drwx------

  ## Unexpected: the original mount changed permissions:
  # stat -c '%A' /sys/kernel/debug
  drwx------

New behavior:

  ## Pre-existing status: debugfs is 0755.
  # chmod 755 /sys/kernel/debug/
  # stat -c '%A' /sys/kernel/debug/
  drwxr-xr-x

  ## New mount inherits existing permissions:
  # mount -t debugfs none /mnt/foo
  # stat -c '%A' /mnt/foo
  drwxr-xr-x

  ## Expected: old mount is unchanged:
  # stat -c '%A' /sys/kernel/debug
  drwxr-xr-x

Full test cases are being submitted to LTP.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Temporary LTP branch here:
https://github.com/computersforpeace/ltp/commits/debugfs

I'll put in an LTP pull request once the kernel tree actually contains
my patches.

Companion patch:
  tracefs: Only clobber mode/uid/gid on remount if asked
  https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/commit/?h=trace-v6.0-rc4&id=47311db8e8f33011d90dee76b39c8886120cdda4

Changes in v2:
* Update commit description
* Include LTP patch in notes
* Split from tracefs patch

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
2.37.2.789.g6183377224-goog

