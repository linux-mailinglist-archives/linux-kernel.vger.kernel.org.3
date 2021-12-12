Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3D471A9E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhLLOS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:18:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38938 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhLLOS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:18:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B1CD9CE0B66
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 14:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DCBC341C5;
        Sun, 12 Dec 2021 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639318704;
        bh=vHEegeDN9TpY8LC9UjSd5Q4VU5L1v3FFcVMkQUhz5GY=;
        h=From:To:Cc:Subject:Date:From;
        b=XGa5on+6YdNFNzaaHutU0uuyWlXPFgLnNy7jqbO1oUQ0qxq3Lrc23bp74KK7YQtgT
         mXpUFlII5HS1Abzr7X1rilgObnVSm/huRH5d2pPi6w4CUH2UplIZzZep/INJs8SNpU
         1P+Ym8qzGt1HvHNE2iqp7mTM4D1sJJn+jPhWnqDCuYjP1L+MQ1waAnsGIxjeXogy93
         lmXp2v0HNFsJkcQ2e4GlUrwuOTNndhcMrmX2x+Su/RQQ70/O4Cz4aiExmOPSQ+x77N
         IvGfMa7gVFHY/jgodZbahXN8mXOpjTcfI6eNxdaC3bPUjLgM2YHqZA87xcyYN5S11c
         XgTNpqCdVrgQg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to check available space of CP area correctly in update_ckpt_flags()
Date:   Sun, 12 Dec 2021 20:28:12 +0800
Message-Id: <20211212122812.8132-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, nat_bit area may be persisted across boundary of CP area during
nat_bit rebuilding.

Fixes: 94c821fb286b ("f2fs: rebuild nat_bits during umount")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f1693d45bb78..2011e9742443 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1302,8 +1302,8 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unsigned long flags;
 
 	if (cpc->reason & CP_UMOUNT) {
-		if (le32_to_cpu(ckpt->cp_pack_total_block_count) >
-			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks) {
+		if (le32_to_cpu(ckpt->cp_pack_total_block_count) +
+			NM_I(sbi)->nat_bits_blocks > sbi->blocks_per_seg) {
 			clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
 			f2fs_notice(sbi, "Disable nat_bits due to no space");
 		} else if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG) &&
-- 
2.32.0

