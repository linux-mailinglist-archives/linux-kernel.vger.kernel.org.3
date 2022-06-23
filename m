Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE2C5575F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiFWIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFWIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:54:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9041B10559;
        Thu, 23 Jun 2022 01:54:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so1931459pjz.1;
        Thu, 23 Jun 2022 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=CgKFu42pVNbutALOPAyFG9CSppEVlH9cLVPLNYXxSDc=;
        b=TgWNIU0sVyugoVfuKJctmkNZR5g0jvh0wU5ej56Yfj8LnJBA9GMeWdwdhUSMYSgoXs
         vQDKVqw/SQcLjxA6/cIeb94CZs1VsmNQ6GwJB6IJv0D225ciqF3j0ah5Dwf5EqDSVesa
         CtyH9WAqCOdvoJk/R+N1Skk10gECKlAb6cb3lXNW1C/t3+kk7Y+WxD7UhsX5Rg34YvAD
         ka98Ju44pZ9q5Uyu484L4Bu1HrO6aFYSqCJ4MbLOeuNZRKcysCfXRBVL6aNmIBRT68eB
         ofV6E8LNIUBAeYDxaouMz9r1DAJmdqTBJA/as3Zg5s1BJrN41K9F11mCIQGtkPe6QYno
         lVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CgKFu42pVNbutALOPAyFG9CSppEVlH9cLVPLNYXxSDc=;
        b=P6STkgsi6t+yRoJNKGvwwsqqGAAor0X6/lv7QdmsshA7STrWGTV+kfEqnI+puH7nCZ
         TfE/M0oKVd0rBvg0q1A3Eq/JEJkDOOlqJID1rOJw1qfWyYAcFAXyQa2hKLUKY5D5Ufqt
         8wIbXLJYQtiZIiyacAaJUuj1wUUqprFRLlXTSnEKD5aXvydO8LyPbFtWhhMI14I9Wdtp
         4PVL3rOab6tPK1zpPB/LC+5ruRbGulw5bEhFsS/kMatyiYehcU18QkxsQyTU0mjERatC
         IPPjZy7H/Mb5pSOnvzq4p+LBUGU8rSnPZBG9vA7UaR0Edb6ZJTRKRKpMMLa6etmJdFvZ
         Tt2g==
X-Gm-Message-State: AJIora90Y4I9dMjoEHFOZhTz9dML/G4pJoLesQMiUmEpUWCLBQwqK85v
        tujgDnYHUWh3zMfaE//PpNOfDk8WoBM=
X-Google-Smtp-Source: AGRyM1tNpAW10PD5eKdQZl31km1eJxSPdtLnll6TymTdk56uqdX65PxOh8YNlwmE9ykHzAVYf+K1Sg==
X-Received: by 2002:a17:903:120f:b0:15f:99f:9597 with SMTP id l15-20020a170903120f00b0015f099f9597mr38034320plh.45.1655974447951;
        Thu, 23 Jun 2022 01:54:07 -0700 (PDT)
Received: from carrot.localdomain (i114-185-17-44.s42.a014.ap.plala.or.jp. [114.185.17.44])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7952b000000b0052521fd273fsm8387644pfp.218.2022.06.23.01.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 01:54:05 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: fix incorrect masking of permission flags for symlinks
Date:   Thu, 23 Jun 2022 17:54:01 +0900
Message-Id: <1655974441-5612-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The permission flags of newly created symlinks are wrongly dropped on
nilfs2 with the current umask value even though symlinks should have
777 (rwxrwxrwx) permissions:

 $ umask
 0022
 $ touch file && ln -s file symlink; ls -l file symlink
 -rw-r--r--. 1 root root 0 Jun 23 16:29 file
 lrwxr-xr-x. 1 root root 4 Jun 23 16:29 symlink -> file

This fixes the bug by inserting a missing check that excludes
symlinks.

Reported-by: Tommy Pettersson <ptp@lysator.liu.se>
Reported-by: Ciprian Craciun <ciprian.craciun@gmail.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/nilfs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 1344f7d475d3..aecda4fc95f5 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -198,6 +198,9 @@ static inline int nilfs_acl_chmod(struct inode *inode)
 
 static inline int nilfs_init_acl(struct inode *inode, struct inode *dir)
 {
+	if (S_ISLNK(inode->i_mode))
+		return 0;
+
 	inode->i_mode &= ~current_umask();
 	return 0;
 }
-- 
1.8.3.1

