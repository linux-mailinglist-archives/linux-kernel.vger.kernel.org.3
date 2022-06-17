Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94554FFFB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiFQWbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiFQWba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:31:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B145A62128
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70051B82B1E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 22:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A54C3411B;
        Fri, 17 Jun 2022 22:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655505087;
        bh=lPh3hZRcFpvlW3S4ihSANExlRpTo4MEmTcXEXEF5gwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9SQK8kXbd1PD4oOEk/AkRKMAfUWzR9HGV3sD3jPI1GK4omVa/RgZ3pEsHAD1g0T+
         c3157Dyg/rcK7+WYL4gqwsRTD3wRUVfkyBCclstkE6OjElKS6Y9y2au9auZ0F7kWyU
         RXUWvazndA/MhcXPFIZYZPbKXt1DRpPw9nQOLCkqzmlLfZFjjNxFv7Q1RA2AKz/jCa
         CllrJeFWYF29JdvU4HU/Wt4WF+cr6hg6OX+0OXdtDPQj/S7NyaleO/AKg7D2MO1fpF
         QsBTxgmh2r3JsPd5ZKE/bPnU2EGC/bme3m+/6XqnOrrPdYW2P8tQaFYP0mW6twoKT2
         pyy9xT4okgeNg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: run GCs synchronously given user requests
Date:   Fri, 17 Jun 2022 15:31:05 -0700
Message-Id: <20220617223106.3517374-2-jaegeuk@kernel.org>
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

