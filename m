Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77F554FFFC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347027AbiFQWbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbiFQWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:31:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480FA62225
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D94D7B82A33
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 22:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7747BC3411D;
        Fri, 17 Jun 2022 22:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655505088;
        bh=5Fok1MzW22buXw55Kbx09DXpCWfLARQYnQkHsxPjVgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIXPSr8/QcfEZ1emcqB4Hnk6NDOOenE6LPPApd5hObqqpIADJnvMH4tbKGbfYSbS5
         2yJ82RFPDkY7CayPZaf/mGleS7xkj8Yrv726HU+vG/yoOqJgaIsgkENBahhMcAYAqf
         qKDFP6CdZjJBKOAQAlUkKzIIozRRu/bn1GfuHJx/DohDdltCVgCgg7BDxUPRLAaaF4
         LBhxTH55RjNFNXHSAoqM9zW8BKUcFpfZx6w8dnh7jTEo7+Ncakn531PCa75p5Bp8Bk
         sXydQ9Q1Nwvx8BlouFOp5S0DTTrStzbXbeaR0sYUbuTKxzLu8qb5du9GvoK2JFapam
         oRqm1qNFx1/gg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: do not skip updating inode when retrying to flush node page
Date:   Fri, 17 Jun 2022 15:31:06 -0700
Message-Id: <20220617223106.3517374-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220617223106.3517374-1-jaegeuk@kernel.org>
References: <20220617223106.3517374-1-jaegeuk@kernel.org>
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

Let's try to flush dirty inode again to improve subtle i_blocks mismatch.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 836c79a20afc..4181d03a7ef7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1943,7 +1943,6 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 			bool submitted = false;
-			bool may_dirty = true;
 
 			/* give a priority to WB_SYNC threads */
 			if (atomic_read(&sbi->wb_sync_req[NODE]) &&
@@ -1996,11 +1995,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			}
 
 			/* flush dirty inode */
-			if (IS_INODE(page) && may_dirty) {
-				may_dirty = false;
-				if (flush_dirty_inode(page))
-					goto lock_node;
-			}
+			if (IS_INODE(page) && flush_dirty_inode(page))
+				goto lock_node;
 write_node:
 			f2fs_wait_on_page_writeback(page, NODE, true, true);
 
-- 
2.36.1.476.g0c4daa206d-goog

