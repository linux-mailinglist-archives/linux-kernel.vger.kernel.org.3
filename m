Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65715589CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbiHDNl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiHDNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:41:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D827129CBA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9194DB82431
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B73C433B5;
        Thu,  4 Aug 2022 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659620510;
        bh=tft2ehdcPlqOGOhqquXqJ/QmYEfBenOXGUYgu/c2XrI=;
        h=From:To:Cc:Subject:Date:From;
        b=PP1IwDFDTjFeeOeQNo7hGlCkVvepWKehYd/CgEIL+ybGrIQoWxvQo1U+aYGXu3Ih9
         SJCR6pJxGtP3vgO53tFYIrmLk5xbxbiCchaQLFUmxDER5zh3NI3IkuuCC/6iqTKMII
         bPNxMiJJ8ulJgOILmzQ7GzRElWpLTsNCMy9V3ZwHSxME4gL/GOEGaQEMTTj4qCfRmn
         rMIWlrdMmgv/LpU//u0NVq1rWW5oONeY17+xQf6ecDsSpq1N3cwOzJ/DDAyMnUHp51
         aLHmC2Rnss5oC2NiUADSN+p4Gycy9sKt2Gb8hRJiHE/G5LxTB75IhVqM34mL9B9KGi
         TbbOJiRvIdHsw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: fix to check compression feature before enabling file compression
Date:   Thu,  4 Aug 2022 21:41:40 +0800
Message-Id: <20220804134140.14455-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao.yu@oppo.com>

This patch disallow to enable file compression in image which doesn't
support compression feature.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 24f5b02c78e7..4a3f4eaa3fc5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1872,6 +1872,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			if (!f2fs_disable_compressed_file(inode))
 				return -EINVAL;
 		} else {
+			if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+				return -EOPNOTSUPP;
 			if (!f2fs_may_compress(inode))
 				return -EINVAL;
 			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
-- 
2.36.1

