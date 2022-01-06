Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2489485EED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbiAFCp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbiAFCpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:45:49 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB1DC06118A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:45:48 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r5so1342785pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 18:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pB9ixd309jdajttTHm9n2WuXxz/2zgca6PMdCtbA1H8=;
        b=sqp4SRvOVax4jD2sd2uTEErw/3HlMsCT8Kq+lArtmcRL/R/BceBTImeqHLY/+V1ki2
         ofzk1QXs3EsDndi+227ANu85vtUI16kMg+j7kYkuDxGG5VDag5qC9M9VL+e7EVa8Xi1d
         p/u7MtxcJndcyKPPP3U8SVB8I+5j1jum55VV6QQla4hvmjw0xAX+uBu4scGSEOw2XnBl
         BL/A5Ir5y3s2oUXUH6nHmaEJlzoSGjuJebXDQkQ5nQSQvirX+okqc9ts0+5jCEPEEOlY
         AsLDgcwVfn3e65XkOEZL3qT4Xx6UAeXZ1LHxEeMKZ7ZcAGo5wpmCF3UbkdYttekugo84
         c9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pB9ixd309jdajttTHm9n2WuXxz/2zgca6PMdCtbA1H8=;
        b=BJcDgp1WjMIps9fbw08su7njQ2bQv5WHUpXQ8yB4e/wvUQXZgA5/CXHl2XF/TkCPIT
         PfIsIk4DKV94EataBicZHRGh4NlM6MZElxBvrrz1Tpi/lFWWdVQ3YjlZAdEW6b0N6cYm
         OBOpJ455zANucDAGbNI48b3Pk+kzERXN9m3C3IDFhXOuc45styNLqTYlU81voP59/2+h
         y3r/7krsX2tCCj378nF4NRLPo2zCUEgluMTuOjbxFaeyBNh751O/x4nptBihvWZi4axC
         Qfy/3WrEyUOw5X3BiA/5pdPKKjv5xS9oE1oTltuxj3IuvyR4ctoxEMOYqYTS9IWaiofA
         0ctA==
X-Gm-Message-State: AOAM530pSxK12dOw8PX43Rc+G3hHc7grO7Z9sRKWbBqWf8z6pBYhnHRo
        xDS8OPYo8G74anP1iIdxJGFMXFuTIbqc2A==
X-Google-Smtp-Source: ABdhPJz1EAGyp79Lg8XVJc3VyhIObQSQ4Y2rSML71svFGe1MFS8/xezpM7v46uLzSYa389+jmuPzUg==
X-Received: by 2002:a05:6a00:174d:b0:4bb:cbd7:c556 with SMTP id j13-20020a056a00174d00b004bbcbd7c556mr49331875pfc.26.1641437148543;
        Wed, 05 Jan 2022 18:45:48 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id p12sm414244pfo.95.2022.01.05.18.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 18:45:48 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH 2/2] ext4: modify the logic of ext4_mb_new_blocks_simple
Date:   Thu,  6 Jan 2022 10:45:18 +0800
Message-Id: <20220106024518.8161-3-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106024518.8161-1-yinxin.x@bytedance.com>
References: <20220106024518.8161-1-yinxin.x@bytedance.com>
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

