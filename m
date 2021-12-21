Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5D47B85E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhLUC2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhLUC2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:28:50 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE855C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:28:50 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 200so11000617pgg.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MH7pYtAT9fzAukQeckl+HCZps771tRVGu5kQlLXlq3k=;
        b=1+UMVDDAGt5X+2K8SrcmnRBejdnZWeVbq00615mjG735u+o1cBnFsVlq5ocYwKc3su
         9oH8zKtnKNeidf6m6HDwY+eEDL5YM4gZEEepsO/5krO5va4sbsRjIr1XfGW+xPBh6pdK
         9XI1WvND/4WtNoHPcNFYsunr8RlFnqHwaILJr3jj8rc9UQuVADVUomlLeB7OxtVrATX2
         LPL6D2McW4wZLV5KaK/eU5QC+yYSo7Y/NxptV50rJ5mfRFdOVeCDEv4b2VafU4lEnE3h
         SJqAgp6bmiuXUr96Ovnh2pPwjK5pP22FNZ1+sB4FC30x06tj8CDj7/4k67GP+adP+1L3
         srfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MH7pYtAT9fzAukQeckl+HCZps771tRVGu5kQlLXlq3k=;
        b=NzLd7yS8/be5icR3qOE+4Az3fspA/mXuiAgHO0c4loo4QNkGJu8v0/qhtTphc0ihLI
         opE1DgC4FUXuafRdUImZ6IImp+pjr7lUVwRS5esdPNUjypx7gz/6QVIvic3h339MBpQL
         Jh2KAN9F1tNkx9h3Ju/DfEaPYrwjzcdz8EmW7+Q0XY9c9aVlCwNFAaKXqt8Atau6cTHf
         qKAeUgKU7tIGVqFOfy92g2aHJnwl3J+F9Lmm0kgVdyG/AXRv+PI/dp8xV3kPLuz/4WLq
         LBK9SOrsvUoM2E0Bqbr4UBNR7lb3hUpWepHr2TF4VOa3Bzw5rmqHNR1mTxGixZesgLK8
         W2tA==
X-Gm-Message-State: AOAM530kSwhj87cGi9+uWf+HtbxVkjTtxPODbj8t2EhrYTbEnel+2VPF
        yQ0a+GbfbdeTgznQh20qMsmggA==
X-Google-Smtp-Source: ABdhPJyT3WEou35Q0MyQl4g78Eel5W9j84NcO9UiV3rwEdLLqRU/mr1Bxb7TeEfvLajqbESVPlnP1g==
X-Received: by 2002:a63:69ca:: with SMTP id e193mr957858pgc.448.1640053729667;
        Mon, 20 Dec 2021 18:28:49 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id j20sm1352154pjl.3.2021.12.20.18.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 18:28:49 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH v2] ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
Date:   Tue, 21 Dec 2021 10:28:39 +0800
Message-Id: <20211221022839.374606-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when call falloc with FALLOC_FL_ZERO_RANGE, to set an range to unwritten,
which has been already initialized. If the range is align to blocksize,
fast commit will not track range for this change.

Also track range for unwritten range in ext4_map_blocks().

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
v2: change to track unwritten range in ext4_map_blocks()
---
 fs/ext4/extents.c | 2 --
 fs/ext4/inode.c   | 7 ++++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9229ab1f99c5..6bce319f3bcd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4599,8 +4599,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret))
 		goto out_handle;
-	ext4_fc_track_range(handle, inode, offset >> inode->i_sb->s_blocksize_bits,
-			(offset + len - 1) >> inode->i_sb->s_blocksize_bits);
 	/* Zero out partial block at the edges of the range */
 	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
 	if (ret >= 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0afab6d5c65b..47ad4b8cb503 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -741,10 +741,11 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			if (ret)
 				return ret;
 		}
-		ext4_fc_track_range(handle, inode, map->m_lblk,
-			    map->m_lblk + map->m_len - 1);
 	}
-
+	if (retval > 0 && (map->m_flags & EXT4_MAP_UNWRITTEN ||
+				map->m_flags & EXT4_MAP_MAPPED))
+		ext4_fc_track_range(handle, inode, map->m_lblk,
+					map->m_lblk + map->m_len - 1);
 	if (retval < 0)
 		ext_debug(inode, "failed with err %d\n", retval);
 	return retval;
-- 
2.20.1

