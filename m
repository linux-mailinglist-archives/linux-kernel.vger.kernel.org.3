Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761295438C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245358AbiFHQV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245383AbiFHQV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:21:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EC142A3D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01288617D6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5339EC34116;
        Wed,  8 Jun 2022 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654705315;
        bh=lPh3hZRcFpvlW3S4ihSANExlRpTo4MEmTcXEXEF5gwg=;
        h=From:To:Cc:Subject:Date:From;
        b=qaqjghi4B/VtzJItUzaAtvw3g2ib6txROQ1HyZbBHUdQ4X7wopW76EcqqAQ/+esFM
         1V+liOkpqk/ME5bRKCOlMzKAFatvwMQMVZt/qLeDH2QgBU75moxRQPUG3Y+wd1NUSk
         AyJEg5PHq+JhpQqN1lsAhF25F109Sie03MhI5kDuhfzB+nUrXJOvCLKpCZLGpY/0fS
         /411kPLTPYSI+jWW3P3vlXl0NwS6jjdUNinMEraCJhgo+SGtSb3v7nk/u9leKnSY62
         /IPVbcHT2P6aJjvqt0xowque+pBzSeK8BWmUOScBBxPuv0DKEbfQR0z6YtI7i6vong
         7iaMslN5M+oLQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: run GCs synchronously given user requests
Date:   Wed,  8 Jun 2022 09:21:53 -0700
Message-Id: <20220608162153.2035396-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When users set GC_URGENT or GC_MID, they expected to do GCs right away.
But, there's a condition to bypass it. Let's indicate we need to do now
in the thread.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d5fb426e0747..f4aa3c88118b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -37,7 +37,6 @@ static int gc_thread_func(void *data)
 	unsigned int wait_ms;
 	struct f2fs_gc_control gc_control = {
 		.victim_segno = NULL_SEGNO,
-		.should_migrate_blocks = false,
 		.err_gc_skipped = false };
 
 	wait_ms = gc_th->min_sleep_time;
@@ -113,7 +112,10 @@ static int gc_thread_func(void *data)
 				sbi->gc_mode == GC_URGENT_MID) {
 			wait_ms = gc_th->urgent_sleep_time;
 			f2fs_down_write(&sbi->gc_lock);
+			gc_control.should_migrate_blocks = true;
 			goto do_gc;
+		} else {
+			gc_control.should_migrate_blocks = false;
 		}
 
 		if (foreground) {
@@ -139,7 +141,9 @@ static int gc_thread_func(void *data)
 		if (!foreground)
 			stat_inc_bggc_count(sbi->stat_info);
 
-		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
+		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC ||
+				sbi->gc_mode == GC_URGENT_HIGH ||
+				sbi->gc_mode == GC_URGENT_MID;
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
 		if (foreground)
-- 
2.36.1.476.g0c4daa206d-goog

