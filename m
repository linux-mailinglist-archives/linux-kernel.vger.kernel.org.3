Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B45710BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiGLDRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiGLDRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E68FD7E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86DEB61716
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1A4C34115;
        Tue, 12 Jul 2022 03:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657595842;
        bh=pJZwIkZ8d/iC0FwubEOjyhKFFCOrbXxtTAMZJdtPyTo=;
        h=From:To:Cc:Subject:Date:From;
        b=FRI10TJMayIxzm0DK/SF54vPHxcSJF4ng0Y875nqKyU/93VneHNsvfKJGHciOt8fd
         mtUKqFEq2WGPnnJ8iDOXL16bdL8PGz88wlHUmEwZtMuvIcbUWXCnsztWJi04JJD10W
         Zp+DHemKT78QQ4BjYEQIIGmPsLebvg/0z/zGtbpFm/mNlwu1XNotvuJXtKrQGabwxD
         6yc5af56XEnp6hKgjIwisxOXXXijom/7RoeP5lDGCuEbEtF34BbD54F3Gbddx6Un6j
         uZcA9yU95J+fIho9wXmBqi8IsKAs1/dbFoMZ8eTKllg9PmKqccOFtXmeF5JzomilBN
         yRKnGZWQr4A1Q==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: fix to check inline_data during compressed inode conversion
Date:   Tue, 12 Jul 2022 11:17:15 +0800
Message-Id: <20220712031715.355222-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When converting inode to compressed one via ioctl, it needs to check
inline_data, since inline_data flag and compressed flag are incompatible.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1d97d06e0d87..60508a949dda 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4417,7 +4417,7 @@ static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
 static inline bool f2fs_may_compress(struct inode *inode)
 {
 	if (IS_SWAPFILE(inode) || f2fs_is_pinned_file(inode) ||
-				f2fs_is_atomic_file(inode))
+		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode))
 		return false;
 	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
 }
-- 
2.25.1

