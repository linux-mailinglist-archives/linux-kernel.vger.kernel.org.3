Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB7D51E23A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444979AbiEFXYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355980AbiEFXYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:24:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1490747AEF
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A82A5B82164
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDB1C385AE;
        Fri,  6 May 2022 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651879236;
        bh=JhOY5jQYZ0kMCKxk2E2Oa1KKHlQS0zvgZSIVhTOL09Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ox9zIlJQXm+flQVsd5sWotVo8KA1c16jziEiQ7i04XzoSj+iQvtwc5zof32Dpzp9p
         DmVCjpc0I4VO9I7FJlf5tPeG48rxYIjrUADoj1MXMXhrHFQxF1axzToaL/ehWoIemi
         VL9PDIhCkdwsiORKe16vBIC2zQb8w4lkkSPl7PzmSRsrjH8waJneaWBpiu+qHr8v94
         HrDfPC1N1zf+LCrKivpgyI5czb6MceacQB1OfrtZK3DUoY0R5poU1JsRNKZq0TBkjA
         d+PgTouNyCgYsXWlJW4+gfSRm7WsKSVkFrTgcJ/2JcZGNlyB2D60UX6w9wc2jpWP5+
         ZldaQMDCd26tg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: keep wait_ms if EAGAIN happens
Date:   Fri,  6 May 2022 16:20:30 -0700
Message-Id: <20220506232032.1264078-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220506232032.1264078-1-jaegeuk@kernel.org>
References: <20220506232032.1264078-1-jaegeuk@kernel.org>
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

In f2fs_gc thread, let's keep wait_ms when sec_freed was zero.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index aeffcc1d5c02..ec3f6f876e76 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -37,7 +37,8 @@ static int gc_thread_func(void *data)
 	unsigned int wait_ms;
 	struct f2fs_gc_control gc_control = {
 		.victim_segno = NULL_SEGNO,
-		.should_migrate_blocks = false };
+		.should_migrate_blocks = false,
+		.err_gc_skipped = false };
 
 	wait_ms = gc_th->min_sleep_time;
 
@@ -146,7 +147,6 @@ static int gc_thread_func(void *data)
 
 		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
 		gc_control.no_bg_gc = foreground;
-		gc_control.err_gc_skipped = sync_mode;
 
 		/* if return value is not zero, no victim was selected */
 		if (f2fs_gc(sbi, &gc_control))
-- 
2.36.0.512.ge40c2bad7a-goog

