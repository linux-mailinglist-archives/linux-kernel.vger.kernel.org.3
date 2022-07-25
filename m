Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0457FD43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiGYKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiGYKTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:19:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617BF1572E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:19:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y141so9990463pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=h8vFO57HHWS7qwyEQBYh03ndUw4GyOD/NZFyb9S7lBc=;
        b=ibGbRhtFwGpqm+iND5PFg5YLbEgCzhQ5X2eUbHDyxR5NP+75nL1T+W53yQlvfNrBKw
         wGGL6uhic+9Cy1ev1n9wsmvjZ4CyMoO5HahttoLSmCdCyYpUML9PW4HFSO3njbJ1Jgyu
         VpfkfJMUzcw/9srk6aDtVyJ+/POs7wH+BT/ugwRm/dei12tOhnA1RiYHjYR+Xief+M2G
         SK7XPdZpTZoSYZN3fFfpfUBn5YOHypp6VTTkJbdpRjA/8C9/CYa6SuKFfVbXOaYwcz6X
         xLKZIDyMT7CR+7JflLHAHN7zr2I6s6tjvzinS6Rs4NtiYcKTWVWu8Km4WR2gmm3/mcxp
         7aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=h8vFO57HHWS7qwyEQBYh03ndUw4GyOD/NZFyb9S7lBc=;
        b=yEEVy8iZSwYOtYtsn9aH5/ymjVo/EVEpoz/U1VHn27QsHGd+w8ZzYylDjgXFDGhxWG
         IlLg8EqWE6E/DvaAt7fh+dMp8F57LWmXbJLqnbQ8K8SbdW81XPUga+jJzfdbXDrDffj9
         s8tDDWQwhOeGqDgDWRcouf45JG5AknE10FJQbixY0L3H2jXwXjSrMoATA27fXFFrxsOh
         UYSkwNmBEYQF8mmDvkQmBBQVIyvBLe8qqEq0u4zADPT8qSmsWakWsUF6lWRhdyEX9f9j
         dwX1m6S1fFIIonBOokT1rjI7+qhrcrvJtGKMxColnzq4xmyIfSsouFg7AZHsrxeATGPH
         8UjQ==
X-Gm-Message-State: AJIora/w6ON254HLAcp4ArxbkjMbMUEBVHFhZnsJzZPnEN78wGHkWwFu
        YdRKlSurAUA3tfHphx18IBqsCKvkM88=
X-Google-Smtp-Source: AGRyM1vjjP6XoEnhfKbcOOTRq6bBlhgLcOIagCKRCrGdUz9DkcwYO4u+/fUyZO+Z/e6ixdBg3O/wMw==
X-Received: by 2002:a62:7bd7:0:b0:52b:1d57:e098 with SMTP id w206-20020a627bd7000000b0052b1d57e098mr11835857pfc.19.1658744369804;
        Mon, 25 Jul 2022 03:19:29 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w205-20020a627bd6000000b005286697ec68sm9087618pfc.133.2022.07.25.03.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 03:19:29 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: [PATCH RESEND] f2fs: fix to remove F2FS_COMPR_FL and tag F2FS_NOCOMP_FL at the same time
Date:   Mon, 25 Jul 2022 18:16:33 +0800
Message-Id: <20220725101633.213733-1-chaoliu719@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Liu <liuchao@coolpad.com>

If the inode has the compress flag, it will fail to use
'chattr -c +m' to remove its compress flag and tag no compress flag.
However, the same command will be successful when executed again,
as shown below:

  $ touch foo.txt
  $ chattr +c foo.txt
  $ chattr -c +m foo.txt
  chattr: Invalid argument while setting flags on foo.txt
  $ chattr -c +m foo.txt
  $ f2fs_io getflags foo.txt
  get a flag on foo.txt ret=0, flags=nocompression,inline_data

Fix this by removing some checks in f2fs_setflags_common()
that do not affect the original logic. I go through all the
possible scenarios, and the results are as follows. Bold is
the only thing that has changed.

+---------------+-----------+-----------+----------+
|               |            file flags            |
+ command       +-----------+-----------+----------+
|               | no flag   | compr     | nocompr  |
+---------------+-----------+-----------+----------+
| chattr +c     | compr     | compr     | -EINVAL  |
| chattr -c     | no flag   | no flag   | nocompr  |
| chattr +m     | nocompr   | -EINVAL   | nocompr  |
| chattr -m     | no flag   | compr     | no flag  |
| chattr +c +m  | -EINVAL   | -EINVAL   | -EINVAL  |
| chattr +c -m  | compr     | compr     | compr    |
| chattr -c +m  | nocompr   | *nocompr* | nocompr  |
| chattr -c -m  | no flag   | no flag   | no flag  |
+---------------+-----------+-----------+----------+

Link: https://lore.kernel.org/linux-f2fs-devel/20220621064833.1079383-1-chaoliu719@gmail.com/
Fixes: 4c8ff7095bef ("f2fs: support data compression")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Chao Liu <liuchao@coolpad.com>
---
 fs/f2fs/file.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index daaa0dfd2d2e..0c3ae5993b7a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1873,10 +1873,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 		if (masked_flags & F2FS_COMPR_FL) {
 			if (!f2fs_disable_compressed_file(inode))
 				return -EINVAL;
-		}
-		if (iflags & F2FS_NOCOMP_FL)
-			return -EINVAL;
-		if (iflags & F2FS_COMPR_FL) {
+		} else {
 			if (!f2fs_may_compress(inode))
 				return -EINVAL;
 			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
@@ -1885,10 +1882,6 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			set_compress_context(inode);
 		}
 	}
-	if ((iflags ^ masked_flags) & F2FS_NOCOMP_FL) {
-		if (masked_flags & F2FS_COMPR_FL)
-			return -EINVAL;
-	}

 	fi->i_flags = iflags | (fi->i_flags & ~mask);
 	f2fs_bug_on(F2FS_I_SB(inode), (fi->i_flags & F2FS_COMPR_FL) &&
--
2.36.1
