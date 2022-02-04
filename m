Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF904A93F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243205AbiBDGWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiBDGWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:22:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A9CC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 22:22:37 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id e28so4277403pfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 22:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YaSJoP96T3D2QmZxW9SI04LkqzI0nZ9drAFbXZpt/E=;
        b=HOEEmx7DPzqKAU/GEPrndeDb6MOcOFwvYYCIhCbW+RvXpNaDVkYZKCkFXux+hBBXEZ
         UyOUnHHM6RnG+H5UAbsQm6Uu1joJ7sC17gxAeiDOIqqTAO/z5Oa36hiNUv816BgsuI3r
         7B1OrlE14ZGeAaNEqzkqKW0pbr/HQFRKuVhBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YaSJoP96T3D2QmZxW9SI04LkqzI0nZ9drAFbXZpt/E=;
        b=he643pSXHN9QltPUk1KZbs3Chs89bWygEEr4ahjNVNsx0PR65dghxagcYOX/0fiSkc
         wodziWxo3oiOS78b9UeqrVvPWerSv3vBpAOeK6pGk55hx4XPTrN44pSW3oZJGVnkVZr1
         /04JzI32+rP62WHAe0MkxlIdpd46vn6L64kjeD6B93JZowxm3OUQoH59VXCq8/xGdhoY
         gd8e+v4vNEVlYkmgIiPmDtATzIdtea8+5KThje5e9s3xSu+QMSeJu5df9NsB3KzUojKH
         B2NmgpNkqif5S2O68iCpk74vdxLYmC1XX78l/9kFW5ba7QI4BZTS+Vfc4AMjOP8qoao1
         apkw==
X-Gm-Message-State: AOAM533BpLBj2DfpX1Sjf8ppCqx3Vy5O1aDfVIHyvZ2H7AYuoF/UXwQy
        9fnMqcogxYwTH4ZVyLFRJTZnqg==
X-Google-Smtp-Source: ABdhPJwpzQrkJyrMpwnQOVZi8dOIa/chlikj8khM3q4YW2ptFGfjJlAQwAU7Saqtt1arjI0FX0cXlA==
X-Received: by 2002:a63:491d:: with SMTP id w29mr1260160pga.366.1643955756818;
        Thu, 03 Feb 2022 22:22:36 -0800 (PST)
Received: from localhost ([2620:15c:202:201:11e4:4141:5c3b:691])
        by smtp.gmail.com with UTF8SMTPSA id y15sm997639pfi.87.2022.02.03.22.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 22:22:35 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     hirofumi@mail.parknet.co.jp
Cc:     dlunev@chromium.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] Revert "fat: add simple validation for directory inode"
Date:   Thu,  3 Feb 2022 22:22:32 -0800
Message-Id: <20220204062232.3410036-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a3082d526f2d406d4b488e49a508a0062a23314f.

The reverted commit adds check for FAT images. However, the tools used
for creating images for the Lego Mindstrom EV3 are not adding '.' and
'..' entry in the 'Projects' directory.
Without this fix, the kernel can not fill the inode structure for
'Projects' directory.

See https://github.com/microsoft/pxt-ev3/issues/980
And https://github.com/microsoft/uf2-linux/issues/6

With the patch reverted, we can mount an image copied from the EV3

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 fs/fat/inode.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a6f1c6d426d1..45c8dcc10547 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -494,24 +494,6 @@ static int fat_calc_dir_size(struct inode *inode)
 	return 0;
 }
 
-static int fat_validate_dir(struct inode *dir)
-{
-	struct super_block *sb = dir->i_sb;
-
-	if (dir->i_nlink < 2) {
-		/* Directory should have "."/".." entries at least. */
-		fat_fs_error(sb, "corrupted directory (invalid entries)");
-		return -EIO;
-	}
-	if (MSDOS_I(dir)->i_start == 0 ||
-	    MSDOS_I(dir)->i_start == MSDOS_SB(sb)->root_cluster) {
-		/* Directory should point valid cluster. */
-		fat_fs_error(sb, "corrupted directory (invalid i_start)");
-		return -EIO;
-	}
-	return 0;
-}
-
 /* doesn't deal with root inode */
 int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 {
@@ -538,10 +520,6 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 
 		set_nlink(inode, fat_subdirs(inode));
-
-		error = fat_validate_dir(inode);
-		if (error < 0)
-			return error;
 	} else { /* not a directory */
 		inode->i_generation |= 1;
 		inode->i_mode = fat_make_mode(sbi, de->attr,
-- 
2.35.0.263.gb82422642f-goog

