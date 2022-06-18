Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA365507CD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 03:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiFSAzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 20:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSAzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 20:55:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FB5BE07
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 17:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3A88B80B3F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB3DC3411A;
        Sun, 19 Jun 2022 00:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655600141;
        bh=Y1pY1dTeemIGkfSVJrQX+Eq3dkLnscBf5JndGotxl+w=;
        h=From:To:Cc:Subject:Date:From;
        b=ZddnPrdb25S2Mxs6xdlu3Tfh/9GngPK2LG2wF6CBGjRq8U6gaWJy8/xhLCratMnqa
         U3NS6ZraMnDoa2RroNZRXYiOi2NyKtHi8jsvTbcWGV29kKDHqkAtU+FTg1MrdgT8BC
         cpy7+LjAO5gL79p3ram6orvA97R3fjYnGsyjMJErJ+ByvH3O2siKNHjTzYXHw7jUxD
         eOJyS+Wwz76L+6Jj5unDe/frWDVIRAOCgUIeqM5Sj+4IV4Ml9mF6RG58LNxTEDl1+U
         9k8m6O2xWQFdddSiGbiXdDwhzytcnSBoEm25wX+r4u2z52aw+lprlHOAYPZZ9vKp0W
         xEtmHkH3307Og==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: initialize page_array_entry slab only if compression feature is on
Date:   Sun, 19 Jun 2022 01:51:55 +0800
Message-Id: <20220618175155.3908-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, in image which doesn't support compression feature,
page_array_entry will be initialized w/o use.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/compress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 24824cd96f36..fa237e5c7173 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1908,6 +1908,9 @@ int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi)
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	char slab_name[32];
 
+	if (!f2fs_sb_has_compression(sbi))
+		return 0;
+
 	sprintf(slab_name, "f2fs_page_array_entry-%u:%u", MAJOR(dev), MINOR(dev));
 
 	sbi->page_array_slab_size = sizeof(struct page *) <<
-- 
2.36.1

