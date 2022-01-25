Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5043849BCF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiAYUXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiAYUXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:23:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A772C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:23:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C8F6B81A74
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C622C340E0;
        Tue, 25 Jan 2022 20:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643142179;
        bh=Vhh6AI4AOoZbcGx6PVrCy7EGGWcFf1i53vnevyRykCo=;
        h=From:To:Cc:Subject:Date:From;
        b=NmzIsqN96Zg6fxi4BZY2TWYOEVleoJD1jo7JKczg/RyCInirH07JtTy2/UXDtsOat
         rOEHc2nE/Tf7e4NUqLpwTZ5cu3tIY0yVgrP1EZTGanBU9mlM7Cp3Yli6ujkTbxpZOY
         +XdHAyXNXGkT3U7KWcIL6E5ZH47xxt0eD5nvPRwf2UeeHk5fMiF5ILumfqK1zZAd2T
         sD73gLddkBXAsFlNdjPDYM+S1kLf1pwMLRVSpOEeYXdd4Y5B8WtnxcwCrUu/RoGDCB
         Sg9VENPaQu5aCj7ZyMH50De11f9GC2n2HLtZqkgmICTuqDNRUr61r9g1Jm659BNq1Z
         qsSC7BGiSxNxg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Konstantin Vyshetsky <vkon@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: move discard parameters into discard_cmd_control
Date:   Tue, 25 Jan 2022 12:22:53 -0800
Message-Id: <20220125202254.3111474-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Vyshetsky <vkon@google.com>

This patch unifies parameters related to how often discard is issued and
how many requests go out at the same time by placing them in
discard_cmd_control. The move will allow the parameters to be modified
in the future without relying on hard-coded values.

Signed-off-by: Konstantin Vyshetsky <vkon@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  4 ++++
 fs/f2fs/segment.c | 22 +++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8178a9152e49..63c90416364b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -398,6 +398,10 @@ struct discard_cmd_control {
 	struct mutex cmd_lock;
 	unsigned int nr_discards;		/* # of discards in the list */
 	unsigned int max_discards;		/* max. discards to be issued */
+	unsigned int max_discard_request;	/* max. discard request per round */
+	unsigned int min_discard_issue_time;	/* min. interval between discard issue */
+	unsigned int mid_discard_issue_time;	/* mid. interval between discard issue */
+	unsigned int max_discard_issue_time;	/* max. interval between discard issue */
 	unsigned int discard_granularity;	/* discard granularity */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
 	unsigned int next_pos;			/* next discard position */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 216538b57331..56211e201d51 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1156,14 +1156,14 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	dpolicy->ordered = false;
 	dpolicy->granularity = granularity;
 
-	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
+	dpolicy->max_requests = dcc->max_discard_request;
 	dpolicy->io_aware_gran = MAX_PLIST_NUM;
 	dpolicy->timeout = false;
 
 	if (discard_type == DPOLICY_BG) {
-		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
-		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
-		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
+		dpolicy->min_interval = dcc->min_discard_issue_time;
+		dpolicy->mid_interval = dcc->mid_discard_issue_time;
+		dpolicy->max_interval = dcc->max_discard_issue_time;
 		dpolicy->io_aware = true;
 		dpolicy->sync = false;
 		dpolicy->ordered = true;
@@ -1171,12 +1171,12 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 			dpolicy->granularity = 1;
 			if (atomic_read(&dcc->discard_cmd_cnt))
 				dpolicy->max_interval =
-					DEF_MIN_DISCARD_ISSUE_TIME;
+					dcc->min_discard_issue_time;
 		}
 	} else if (discard_type == DPOLICY_FORCE) {
-		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
-		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
-		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
+		dpolicy->min_interval = dcc->min_discard_issue_time;
+		dpolicy->mid_interval = dcc->mid_discard_issue_time;
+		dpolicy->max_interval = dcc->max_discard_issue_time;
 		dpolicy->io_aware = false;
 	} else if (discard_type == DPOLICY_FSTRIM) {
 		dpolicy->io_aware = false;
@@ -1781,7 +1781,7 @@ static int issue_discard_thread(void *data)
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	wait_queue_head_t *q = &dcc->discard_wait_queue;
 	struct discard_policy dpolicy;
-	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
+	unsigned int wait_ms = dcc->min_discard_issue_time;
 	int issued;
 
 	set_freezable();
@@ -2180,6 +2180,10 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	atomic_set(&dcc->discard_cmd_cnt, 0);
 	dcc->nr_discards = 0;
 	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
+	dcc->max_discard_request = DEF_MAX_DISCARD_REQUEST;
+	dcc->min_discard_issue_time = DEF_MIN_DISCARD_ISSUE_TIME;
+	dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
+	dcc->max_discard_issue_time = DEF_MAX_DISCARD_ISSUE_TIME;
 	dcc->undiscard_blks = 0;
 	dcc->next_pos = 0;
 	dcc->root = RB_ROOT_CACHED;
-- 
2.35.0.rc0.227.g00780c9af4-goog

