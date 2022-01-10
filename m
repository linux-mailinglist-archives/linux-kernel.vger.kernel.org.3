Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF189488F13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 04:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbiAJDwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 22:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238425AbiAJDwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 22:52:12 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0FFC061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 19:52:12 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i6so10853646pla.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 19:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pB9ixd309jdajttTHm9n2WuXxz/2zgca6PMdCtbA1H8=;
        b=JiSVlDh8pZAweLjogrN0kItEt37c3PSlPokmWmgOa3LUMXXdshgqk0qCC/hNfEmxkl
         JLGCmQlnoZvE7ID8Ud4iUHoVwGtEqQqNjCl+IzHxZ52ph7lYy4+2CmWEYc1PGy62fgFu
         HmaZSoyNxBFbCaageCC0uoto2M0BDXf4ZadWJwe3iG9uRxm9V0X2gzASl07sKTLk7rWK
         1me5a25xnZQKtBwmEBsorWdlp1rHcWjWvTa6jgkLm4VxNFkBjgIMS8dfjaKMgRHn255Y
         V89ZP4+vE44EQ1AY0dcZNURpc4mrErmw61/Hrc9JtSlayB7I6lNT7eW6D8zLKRTcpNFX
         tVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pB9ixd309jdajttTHm9n2WuXxz/2zgca6PMdCtbA1H8=;
        b=Da7AqFN8iij6WZx02g8cnWoco1FzUKtrQ+U8JwUGw4a1GPiSAMp2cmvz2qGrUST4MO
         /3hdauaFL1nqTb4e5Ds2QO053ERIx12d7riQB+R4oBrFL9MLxVsljdZstYKlN4wn0OXz
         lZrnSSt+p3o5m1ivrRu5jhfJgenQRVi620xfIWpmpMMG+56G2eHYIZeQh76fc+2P1w83
         fgAxd3FDVaU2+yV+KYXQVymBTsi6p2ndiZyU4pSCIz2xhcbDYBqlMASjgpcuuSqdYaav
         wq00lhzNaUNxmxLx0CIwrPfC5SWlxzHSV5UUqGbHSOM9cGingHRlY3AunP45ZYO/Is/p
         9CNg==
X-Gm-Message-State: AOAM530iIXajkIhwaGEz0EWDFFpm89cuSklSo4hg6AIzm2r4P/ZDisvO
        W/GBPNu9JIdKPfpE4YfX2hnENw==
X-Google-Smtp-Source: ABdhPJyMSTHmHtRjgnnOsrjOHTZlabUIYWfszTl11z8L0Kp1Yi8K9dWOOyzv03+lx04yv/iSFCSe9Q==
X-Received: by 2002:a17:902:c406:b0:14a:4178:af93 with SMTP id k6-20020a170902c40600b0014a4178af93mr1195818plk.154.1641786731979;
        Sun, 09 Jan 2022 19:52:11 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id h3sm6772748pjk.48.2022.01.09.19.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 19:52:11 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH v2 2/2] ext4: modify the logic of ext4_mb_new_blocks_simple
Date:   Mon, 10 Jan 2022 11:51:41 +0800
Message-Id: <20220110035141.1980-3-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110035141.1980-1-yinxin.x@bytedance.com>
References: <20220110035141.1980-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for now in ext4_mb_new_blocks_simple, if we found a block which
should be excluded then will switch to next group, this may
probably cause 'group' run out of range.

change to check next block in the same group when get a block should
be excluded. Also change the searche range to EXT4_CLUSTERS_PER_GROUP
and add error checking.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/ext4/mballoc.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 215b7068f548..31a00b473f3e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5757,7 +5757,8 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 	struct super_block *sb = ar->inode->i_sb;
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int i = sb->s_blocksize;
+	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
+	ext4_grpblk_t i = 0;
 	ext4_fsblk_t goal, block;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 
@@ -5779,19 +5780,26 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 		ext4_get_group_no_and_offset(sb,
 			max(ext4_group_first_block_no(sb, group), goal),
 			NULL, &blkoff);
-		i = mb_find_next_zero_bit(bitmap_bh->b_data, sb->s_blocksize,
+		while (1) {
+			i = mb_find_next_zero_bit(bitmap_bh->b_data, max,
 						blkoff);
+			if (i >= max)
+				break;
+			if (ext4_fc_replay_check_excluded(sb,
+				ext4_group_first_block_no(sb, group) + i)) {
+				blkoff = i + 1;
+			} else
+				break;
+		}
 		brelse(bitmap_bh);
-		if (i >= sb->s_blocksize)
-			continue;
-		if (ext4_fc_replay_check_excluded(sb,
-			ext4_group_first_block_no(sb, group) + i))
-			continue;
-		break;
+		if (i < max)
+			break;
 	}
 
-	if (group >= ext4_get_groups_count(sb) && i >= sb->s_blocksize)
+	if (group >= ext4_get_groups_count(sb) || i >= max) {
+		*errp = -ENOSPC;
 		return 0;
+	}
 
 	block = ext4_group_first_block_no(sb, group) + i;
 	ext4_mb_mark_bb(sb, block, 1, 1);
-- 
2.20.1

