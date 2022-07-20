Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E857B2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbiGTIaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240484AbiGTIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:30:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49275246E;
        Wed, 20 Jul 2022 01:30:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y9so15880117pff.12;
        Wed, 20 Jul 2022 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4hnXU+gPzGHldVhXjvL5+wspZw5HKKLAhcUlf3OAD8=;
        b=bJmh8wkgWva5xdCx1aG3wwUoj8xELEjbIMuXU331lihAZGLYCF5HJByv3Yq8mnhKz9
         T+hp/Wbww+vpaw5kZecvQU6nZxBCyg+6NBQJ2aLNsm5YlmK/X1wPJt1iXSRVpFSB+FyG
         vF6o+yIav6X9ECvw8KTNGLZ9L5sKDD1W7DJPbsuwBHZas/yDnXi/w1a7umvY54J4W3kt
         ZZjrArbBWMcjxVAakrZir3qJzTynOti+J+klnI60HhCtGZ8/0OfvWoCq5zqfddFx+5jL
         Wz8PNDGVlRgIMVqwEwSzfl+MVVIEB9or19MnkbM8h4DZzd0Jtz98o/YwMVkCI0EVDGEK
         ZPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4hnXU+gPzGHldVhXjvL5+wspZw5HKKLAhcUlf3OAD8=;
        b=pM3k9sURtM38n8n7LzgAGt5LIO9T3s3kbPcYr8IzS0HfDGJ/H8rU+FWLWfb+4CbhAn
         5y5OIxvRk9pleTlWcywS5GlDV2OExzQGbmMvd6ap1qsXEDs+MjQG0wwcId9iT1LLVha7
         AaaWtifnSnaXh0o2tpBLpqvcQNJ2//gVs5NU4Zz78IatGMVpQMGJ3hpaGDZP6hfJQLgc
         nzOeaDuCh4XEz6p1YWW3nVUoaR570SkGPPLmbQ18oZBuj5iYV122HAIZTk8d3ULw3Iwy
         UbyfgtFSI5HDYeA5elJuwtU+C5hJpScbQntLPPtN5b6ojPMlbZ08tfb+SAJzPcCPF8IG
         kjmg==
X-Gm-Message-State: AJIora/25oH+pmvpJ9948Bppx25RYKp8iyMVtpK/e5PB7NLfenDGoHks
        SJrZv09ugZt8071cgBMZfT04IhOUGxMYz+0gVpM=
X-Google-Smtp-Source: AGRyM1v6N5d/3DkFIAN6gT5Njylwu8qjeffwTXoW1ZZJGFhV6g9kTocC4weOGY+xKmUIBqKJ5WhT1g==
X-Received: by 2002:a05:6a00:1690:b0:517:cc9e:3e2d with SMTP id k16-20020a056a00169000b00517cc9e3e2dmr38029541pfc.0.1658305842147;
        Wed, 20 Jul 2022 01:30:42 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090adc8300b001ecbd9aa1a7sm1003424pjv.1.2022.07.20.01.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 01:30:41 -0700 (PDT)
From:   zengjx95@gmail.com
To:     reiserfs-devel@vger.kernel.org
Cc:     willy@infradead.org, jlayton@kernel.org,
        damien.lemoal@opensource.wdc.com, jack@suse.cz,
        edward.shishkin@gmail.com, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, kasong@tencent.com,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] fs/reiserfs/inode: remove dead code in _get_block_create_0()
Date:   Wed, 20 Jul 2022 16:30:29 +0800
Message-Id: <20220720083029.1065578-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
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

From: Zeng Jingxiang <linuszeng@tencent.com>

Since commit 27b3a5c51b50 ("kill-the-bkl/reiserfs: drop the fs race
watchdog from _get_block_create_0()"), which removed a label that may
have the pointer 'p' touched in its control flow, related if statements
now eval to constant value now. Just remove them.

Assigning value NULL to p here
293     char *p = NULL;

In the following conditional expression, the value of p is always NULL,
As a result, the kunmap() cannot be executed.
308	if (p)
309		kunmap(bh_result->b_page);

355	if (p)
356		kunmap(bh_result->b_page);

366	if (p)
367		kunmap(bh_result->b_page);

Also, the kmap() cannot be executed.
399	if (!p)
400		p = (char *)kmap(bh_result->b_page);

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 fs/reiserfs/inode.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 0cffe054b78e..fe26e1746af9 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -305,8 +305,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 	result = search_for_position_by_key(inode->i_sb, &key, &path);
 	if (result != POSITION_FOUND) {
 		pathrelse(&path);
-		if (p)
-			kunmap(bh_result->b_page);
 		if (result == IO_ERROR)
 			return -EIO;
 		/*
@@ -352,8 +350,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 		}
 
 		pathrelse(&path);
-		if (p)
-			kunmap(bh_result->b_page);
 		return ret;
 	}
 	/* requested data are in direct item(s) */
@@ -363,8 +359,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 		 * when it is stored in direct item(s)
 		 */
 		pathrelse(&path);
-		if (p)
-			kunmap(bh_result->b_page);
 		return -ENOENT;
 	}
 
@@ -396,9 +390,7 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 	 * sure we need to.  But, this means the item might move if
 	 * kmap schedules
 	 */
-	if (!p)
-		p = (char *)kmap(bh_result->b_page);
-
+	p = (char *)kmap(bh_result->b_page);
 	p += offset;
 	memset(p, 0, inode->i_sb->s_blocksize);
 	do {
-- 
2.27.0

