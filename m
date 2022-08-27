Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E05A3333
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 02:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbiH0Aof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 20:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345138AbiH0Aoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:44:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469ABEA32B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:44:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pm13so3011757pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6JTim4nPtQtPEg9O17WZ92ebDi9nsN3vvJLg6si7U+4=;
        b=hy9zDsLU1GpQMWDqN7TakU+s2i2SxyKg0kGWZrYloRny5Hph3DZT6z3t1gNAvNsI7C
         cIAzCKRsemzBdWgPrw3U0R3Qb/9sRBFEhxa6GVtHr8kqm4fnUcHErs8pIBL7g7ZE7xCI
         xkmyVivcf3Ngj978357lc809XVWDgox5FZuwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6JTim4nPtQtPEg9O17WZ92ebDi9nsN3vvJLg6si7U+4=;
        b=cpSGcqqyCGXtx7TgWGJ6mZIWyS89t3QWHyRKju3YDEOZGUJhMpVSxXFwZLSfVyKlXV
         jF/OrDlnPHQGaZogm128grgS0Hjcxfs6bAuaXZ6GdsIWxeAxnSDIxEXMindeRI33CPSl
         GURyES2L6Sk3cWIZnu4Z5qL6wgrVukgXkosV1PiZeHzFaHfDxcfU4AuvyokUbp5SiKHS
         FfEnpMuWOUy2QO3quezYAARdcoxaixs7uXHT19byVNPZPXZud82HWUYYgU9wjIlLCH+4
         H1rDLw5G8fA93dwf6h+45EfauXS2g/fjXsJ7gb5cAEo9/fM3n2NSh5Poq6bl/k0ib6HE
         AdRg==
X-Gm-Message-State: ACgBeo37LGxW/a75SKuAL7u9nCnrbyl1UTY0vWSagWFNdagtQX9+kdHQ
        5qmzuryUVjmrBfY1duRKFjYz64AmZABmyg==
X-Google-Smtp-Source: AA6agR62d3r9eNiCVwM6BiQcyCqVFzJF+RYsTRs2rWLA6fZuMfYYGaTvWnmg7BQzQs4CxZJV3GnXLw==
X-Received: by 2002:a17:90b:4a4e:b0:1fb:a13:3730 with SMTP id lb14-20020a17090b4a4e00b001fb0a133730mr6781924pjb.136.1661561070769;
        Fri, 26 Aug 2022 17:44:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f351:6a22:e571:bde5])
        by smtp.gmail.com with UTF8SMTPSA id s3-20020a170902ea0300b0016f02fceff4sm2294706plg.57.2022.08.26.17.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 17:44:30 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] tracefs: Only clobber mode/uid/gid on remount if asked
Date:   Fri, 26 Aug 2022 17:44:17 -0700
Message-Id: <20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
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

Users may have explicitly configured their tracefs permissions; we
shouldn't overwrite those just because a second mount appeared.

Only clobber if the options were provided at mount time.

Note: the previous behavior was especially surprising in the presence of
automounted /sys/kernel/debug/tracing/.

  # Don't change /sys/kernel/tracing/ permissions on automount.
  umount /sys/kernel/debug/tracing/
  stat /sys/kernel/debug/tracing/.

  # Don't change /sys/kernel/tracing/ permissions.
  mount -t tracefs none /mnt/foo

  # Change /sys/kernel/tracing/ mode and uid, but not gid.
  mount -t tracefs -o uid=bar,mode=0750 none /mnt/baz

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
I'm open to writing an LTP test case for this, if that seems like a good
idea.

 fs/tracefs/inode.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 81d26abf486f..da85b3979195 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -141,6 +141,8 @@ struct tracefs_mount_opts {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
+	/* Opt_* bitfield. */
+	unsigned int opts;
 };
 
 enum {
@@ -241,6 +243,7 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 	kgid_t gid;
 	char *p;
 
+	opts->opts = 0;
 	opts->mode = TRACEFS_DEFAULT_MODE;
 
 	while ((p = strsep(&data, ",")) != NULL) {
@@ -275,24 +278,36 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 		 * but traditionally tracefs has ignored all mount options
 		 */
 		}
+
+		opts->opts |= BIT(token);
 	}
 
 	return 0;
 }
 
-static int tracefs_apply_options(struct super_block *sb)
+static int tracefs_apply_options(struct super_block *sb, bool remount)
 {
 	struct tracefs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = d_inode(sb->s_root);
 	struct tracefs_mount_opts *opts = &fsi->mount_opts;
 
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
 
-	inode->i_uid = opts->uid;
+	if (!remount || opts->opts & BIT(Opt_uid))
+		inode->i_uid = opts->uid;
 
-	/* Set all the group ids to the mount option */
-	set_gid(sb->s_root, opts->gid);
+	if (!remount || opts->opts & BIT(Opt_gid)) {
+		/* Set all the group ids to the mount option */
+		set_gid(sb->s_root, opts->gid);
+	}
 
 	return 0;
 }
@@ -307,7 +322,7 @@ static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto fail;
 
-	tracefs_apply_options(sb);
+	tracefs_apply_options(sb, true);
 
 fail:
 	return err;
@@ -359,7 +374,7 @@ static int trace_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_op = &tracefs_super_operations;
 
-	tracefs_apply_options(sb);
+	tracefs_apply_options(sb, false);
 
 	return 0;
 
-- 
2.37.2.672.g94769d06f0-goog

