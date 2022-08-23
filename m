Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA9059EB98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiHWSzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiHWSzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A0913F85
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3684A615A4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE5CC433D6;
        Tue, 23 Aug 2022 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661275285;
        bh=VFjOTpxcrlmUZh1BhEihfLloefvGcxdpOSpJmXk5h8w=;
        h=From:To:Cc:Subject:Date:From;
        b=t7e8xYLgOmpiiL+/dcP30jhAvGFS9d3MQgitnDKU+zt6hy/sVXhizXHNG7H7RbWlO
         mo+xwaLU3LfGVBWTDd6usavm9GCd0+igMvUYkEQIf31qITwwQLiELcfYBhAS/ZXd6n
         6I0XiGcnhnS5mm0pnCslR8kchFu1RlOQQuA0URaf8uyN/qKrdAvluc2lVE39+0weLL
         GUEN/O4SnRmZW+2GVE1txTiFDz+vKvMzK4z6ljkwXv71/GVajvofGPGjhkhFx3WbVh
         8F03DYCLp8ZMlpyMkUpJc1BYTr5i9NjWey+YqSz1TgeMbtjA26ooWbbyOzaD/IkWIO
         AM7yeVTNTLUDQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: increase the limit for reserve_root
Date:   Tue, 23 Aug 2022 10:21:24 -0700
Message-Id: <20220823172124.2285995-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch increases the threshold that limits the reserved root space from 0.2%
to 12.5% by using simple shift operation.

Typically Android sets 128MB, but if the storage capacity is 32GB, 0.2% which is
around 64MB becomes too small. Let's relax it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 09972b709cdd..d1b4de5b4083 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -301,10 +301,10 @@ static void f2fs_destroy_casefold_cache(void) { }
 
 static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
 {
-	block_t limit = min((sbi->user_block_count << 1) / 1000,
+	block_t limit = min((sbi->user_block_count >> 3),
 			sbi->user_block_count - sbi->reserved_blocks);
 
-	/* limit is 0.2% */
+	/* limit is 12.5% */
 	if (test_opt(sbi, RESERVE_ROOT) &&
 			F2FS_OPTION(sbi).root_reserved_blocks > limit) {
 		F2FS_OPTION(sbi).root_reserved_blocks = limit;
-- 
2.37.1.595.g718a3a8f04-goog

