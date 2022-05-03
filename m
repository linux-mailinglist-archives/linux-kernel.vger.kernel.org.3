Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A7B518EE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiECUe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbiECUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:34:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB924BF3
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C83DB820CB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD220C385A9;
        Tue,  3 May 2022 20:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651609842;
        bh=XuBREE6g46APypvC2dWPjYla3kMTxG8UR8mmKhvjx6U=;
        h=From:To:Cc:Subject:Date:From;
        b=sttJSLn0i/QQDPKkIHO2wumlL00Mb6Ufs3lbXtgxBQBI8dHx3ogwik7mSMJzhm9sd
         W4CzPZC5WThrVxMXwjlyYwuLWOcGe1oxAdEWkFiNz/6BKwXz4yDPl/ZFOYBnY7FAHm
         du/QULgIq7aXVuh1wacfU5Qu9nt5Lro7qgEFtmoT2NvLucZ18diHMc6JJ0BiaoOP1X
         1BoRdf1KeMfVQjoyno55p4OWFhyWSy28C9Zra0S3nlRo/zQMchAGsCESpTlv9Y2phs
         u8DpBmWxyQPnK0p403eZ3dOfWypIH06EfcZA7+yOYMvMX+5yztCy4LHAkzSjtiX1Vx
         cItGGeWkCnNLg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Byungki Lee <dominicus79@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: write checkpoint during FG_GC
Date:   Tue,  3 May 2022 13:30:39 -0700
Message-Id: <20220503203040.365028-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
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

From: Byungki Lee <dominicus79@gmail.com>

If there's not enough free sections each of which consistis of large segments,
we can hit no free section for upcoming section allocation. Let's reclaim some
prefree segments by writing checkpoints.

Signed-off-by: Byungki Lee <dominicus79@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index eddd2e81a2a2..4d47723523c3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1841,23 +1841,31 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	if (sync)
 		goto stop;
 
-	if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
-		if (skipped_round <= MAX_SKIP_GC_COUNT ||
-					skipped_round * 2 < round) {
-			segno = NULL_SEGNO;
-			goto gc_more;
-		}
+	if (!has_not_enough_free_secs(sbi, sec_freed, 0))
+		goto stop;
 
-		if (first_skipped < last_skipped &&
-				(last_skipped - first_skipped) >
-						sbi->skipped_gc_rwsem) {
-			f2fs_drop_inmem_pages_all(sbi, true);
-			segno = NULL_SEGNO;
-			goto gc_more;
-		}
-		if (gc_type == FG_GC && !is_sbi_flag_set(sbi, SBI_CP_DISABLED))
+	if (skipped_round <= MAX_SKIP_GC_COUNT || skipped_round * 2 < round) {
+
+		/* Write checkpoint to reclaim prefree segments */
+		if (free_sections(sbi) < NR_CURSEG_PERSIST_TYPE &&
+				prefree_segments(sbi) &&
+				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
 			ret = f2fs_write_checkpoint(sbi, &cpc);
-	}
+			if (ret)
+				goto stop;
+		}
+		segno = NULL_SEGNO;
+		goto gc_more;
+	}
+	if (first_skipped < last_skipped &&
+			(last_skipped - first_skipped) >
+					sbi->skipped_gc_rwsem) {
+		f2fs_drop_inmem_pages_all(sbi, true);
+		segno = NULL_SEGNO;
+		goto gc_more;
+	}
+	if (gc_type == FG_GC && !is_sbi_flag_set(sbi, SBI_CP_DISABLED))
+		ret = f2fs_write_checkpoint(sbi, &cpc);
 stop:
 	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
 	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = init_segno;
-- 
2.36.0.464.gb9c8b46e94-goog

