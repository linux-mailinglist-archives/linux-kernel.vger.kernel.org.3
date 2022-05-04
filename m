Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4722B51AEF0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377541AbiEDU0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349645AbiEDU0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:26:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A3D4EDE1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D001B612A8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 20:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256CEC385A4;
        Wed,  4 May 2022 20:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651695776;
        bh=Pvp/ayE3bEr1ThzltiOs0liNClPGDqGM57U4y3ZJCs4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Jb1H+umWfnfEpWqRV20Q4YhcGwRLYGWiL464vbh1AFJeLggogbh3DgfdhCRMeUThT
         XNv5jkVDb09twhYv4kQ1HPTEvqpD1A9rDMXWas6eF0Jch8V8bWocjrGjgjvTI+7mDE
         k7Y4wuNJ7sFd1PkbhH3cM6NHpPU1kH27+95u07THwk2LSvSKMFS64PEaeWAgBWwbUB
         /5eZqJHkZ1yfcpEKtZl1G8IndjStS3uqXjjaoyGrAFWo2Peiti6Tcqz7VBE9BDTxu8
         bqmYMdQzVyQ4v5wiU/pYIPJu5AEzmRtqdnpmupU4kAkDSIubdwgG8wWaPAPEOM0Vya
         PG1KYfPHXeaQg==
Date:   Wed, 4 May 2022 13:22:54 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2 v2] f2fs: avoid to select pinned section during
 checkpoint=disable
Message-ID: <YnLgnhiJtrutv8nw@google.com>
References: <20220503203040.365028-1-jaegeuk@kernel.org>
 <20220503203040.365028-2-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503203040.365028-2-jaegeuk@kernel.org>
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

 Change log from v1:
  - keep sync condition to stop GC

 fs/f2fs/gc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4d47723523c3..441190ab8593 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1838,10 +1838,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	if (gc_type == FG_GC)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
-	if (sync)
-		goto stop;
-
-	if (!has_not_enough_free_secs(sbi, sec_freed, 0))
+	if ((!has_not_enough_free_secs(sbi, sec_freed, 0) || sync) && seg_freed)
 		goto stop;
 
 	if (skipped_round <= MAX_SKIP_GC_COUNT || skipped_round * 2 < round) {
-- 
2.36.0.464.gb9c8b46e94-goog

