Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B0A518EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiECUeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiECUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2644920F78
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F0160FD6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3540C385B1;
        Tue,  3 May 2022 20:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651609844;
        bh=mVOGOpBYm+Bzhe/7VV0Fmk4EZbmIIpgNhl6/C1CkJlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEYQfHh8q/fYnUgf6snM5cXsjOCXkcs50x7ugGNUOG0SaivZSJgrAHBGPF+CyO6wM
         D0+W6cAwprtt8rExly4zdSAKRu5xSgZf6awUjKJlXPmCRMg+FfeDTmibtWqjnajGnM
         eqtj4GLrLSGDqGaQDr8ZbOBnOHOPJWDi1GU3Ku97qG+Revw7GNwxEZD1TdGTd0IikF
         4Lyx+/srcisy9Zp83jt6t1vWhHKpGmlC/9nCrcIUnpemqo5yCetFu85O3Mg182pAsY
         M01K0wth2JG8uAaQBQi5yJ0e52dTkSCgL6BWUoYriNUqu3HJ1HE8vwfH3f8K5gJyyk
         cDrPM3qieTqxg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid to select pinned section during checkpoint=disable
Date:   Tue,  3 May 2022 13:30:40 -0700
Message-Id: <20220503203040.365028-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220503203040.365028-1-jaegeuk@kernel.org>
References: <20220503203040.365028-1-jaegeuk@kernel.org>
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

The f2fs_gc uses a bitmap to indicate pinned sections, but when disabling
chckpoint, we call f2fs_gc() with NULL_SEGNO which selects the same dirty
segment as a victim all the time, resulting in checkpoint=disable failure.
Let's pick another one, if we fail to collect it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4d47723523c3..5ba8104e138b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1838,10 +1838,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	if (gc_type == FG_GC)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
-	if (sync)
-		goto stop;
-
-	if (!has_not_enough_free_secs(sbi, sec_freed, 0))
+	if (!has_not_enough_free_secs(sbi, sec_freed, 0) && seg_freed)
 		goto stop;
 
 	if (skipped_round <= MAX_SKIP_GC_COUNT || skipped_round * 2 < round) {
-- 
2.36.0.464.gb9c8b46e94-goog

