Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D36B529FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbiEQKmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344397AbiEQKl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:41:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F0DBF7B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F26C7B81829
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95684C34100;
        Tue, 17 May 2022 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652784105;
        bh=rEjHDbuf51t9QAOOo/GMmQiQFx59C37vt/2A1ZBKTyE=;
        h=From:To:Cc:Subject:Date:From;
        b=LkbnQ0viorSecGNLevKgXLYcHzYv0JUcwbBmLFv1aMjGQEBoXZ/q/kjqZ/Jd+Eds4
         WdCH5ZWwQAC/5V9eVmkYwq9nj4pmVGgr5dldC3EJqTRwN+9kbcWEV3CIy4Y8h6p2ZA
         5VZi9GocsHbsvHHJQPlYn1aUMeOmY5AhpFybGYgDcMafKKyKItCZvI/FMymFIkA9X1
         /LPH4Lbc+RTy/r1K3y6Hh7lU1a4QRutqz1H5/DzdwNRIiPR47zCBsmSmy813ggwqI9
         Kwy//d9KWMhkejdiSChQrcgNYGxdGI0zUAB4Xdjib+/SgNgFqo74u8XdVC4dyRXw3S
         3HZ8ZqSa6pTqg==
From:   Chao Yu <chao@kernel.org>
To:     xiang@kernel.org
Cc:     chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH v2] erofs: support idmapped mounts
Date:   Tue, 17 May 2022 18:41:03 +0800
Message-Id: <20220517104103.3570721-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables idmapped mounts for erofs, since all dedicated helpers
for this functionality existsm, so, in this patch we just pass down the
user_namespace argument from the VFS methods to the relevant helpers.

Simple idmap example on erofs image:

1. mkdir dir
2. touch dir/file
3. mkfs.erofs erofs.img dir
4. mount -t erofs -o loop erofs.img  /mnt/erofs/

5. ls -ln /mnt/erofs/
total 0
-rw-rw-r-- 1 1000 1000 0 May 17 15:26 file

6. mount-idmapped --map-mount b:1000:1001:1 /mnt/erofs/ /mnt/scratch_erofs/

7. ls -ln /mnt/scratch_erofs/
total 0
-rw-rw-r-- 1 1001 1001 0 May 17 15:26 file

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
v2:
- fix testcase pointed out by Christian Brauner.
 fs/erofs/inode.c | 2 +-
 fs/erofs/super.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index e8b37ba5e9ad..5320bf52c1ce 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -370,7 +370,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_IMMUTABLE);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(mnt_userns, inode, stat);
 	return 0;
 }
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0c4b41130c2f..7dc5f2e8ddee 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -781,7 +781,7 @@ static struct file_system_type erofs_fs_type = {
 	.name           = "erofs",
 	.init_fs_context = erofs_init_fs_context,
 	.kill_sb        = erofs_kill_sb,
-	.fs_flags       = FS_REQUIRES_DEV,
+	.fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("erofs");
 
-- 
2.25.1

