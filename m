Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56E553D87B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 22:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbiFDTvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiFDTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1DD30565
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8C961016
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 19:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59A6C385B8;
        Sat,  4 Jun 2022 19:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654372264;
        bh=iQ//p9c/Jarv4oc2irqnX8yb/qL+olIDk7ZmaJFDVzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGZUpulpWojW0NV2I0rfR8FwABz0mwJuzwrvy3E9SYeiLV8GxE3vMsOBxOF7lJVS8
         /lYgQGuHFKZMBzzXoPG2IMa07+3V12DeV6Uf/xG4ojlV6fxpQ9QoBz1VBrhAsksxK/
         MV8uDYBATHl0BN3YQ1V6SUokrTJEfkmzG3RcGUEb9Y0o1D7EKk5zDIhQJgDiaLsWfD
         7QsW+YOEXidk0EsDjgFJe7D5viaV/SCl+1PTfrbS4P/K8qhGxzgFg1aqQhS+p1YUdj
         25cwL9kA0McJgHRz7lGGdqdOXK6Mp76gQ1gGxiBHTyq612go2i+4rAcnMuTqxAyfOk
         kO0zUJlbgBVeQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     tuhailong@gmail.com, gwhite@kupulau.com, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon/reclaim: schedule 'damon_reclaim_timer' only after 'system_wq' is initialized
Date:   Sat,  4 Jun 2022 19:50:51 +0000
Message-Id: <20220604195051.1589-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604192222.1488-1-sj@kernel.org>
References: <20220604192222.1488-1-sj@kernel.org>
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

Commit 059342d1dd4e ("mm/damon/reclaim: fix the timer always stays
active") made DAMON_RECLAIM's 'enabled' parameter store callback,
'enabled_store()', to schedule 'damon_reclaim_timer'.  The scheduling
uses 'system_wq', which is initialized in 'workqueue_init_early()'.  As
kernel parameters parsing function ('parse_args()') is called before
'workqueue_init_early()', 'enabled_store()' can be executed before
'workqueue_init_early()' and end up accessing the uninitialized
'system_wq'.  As a result, the booting hang[1].  This commit fixes the
issue by checking if the initialization is done before scheduling the
timer.

[1] https://lkml.kernel.org/20220604192222.1488-1-sj@kernel.org/

Fixes: 059342d1dd4e ("mm/damon/reclaim: fix the timer always stays active")
Reported-by: Greg White <gwhite@kupulau.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 8efbfb24f3a1..4b07c29effe9 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -374,6 +374,8 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
 
+static bool damon_reclaim_initialized;
+
 static int enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
@@ -382,6 +384,10 @@ static int enabled_store(const char *val,
 	if (rc < 0)
 		return rc;
 
+	/* system_wq might not initialized yet */
+	if (!damon_reclaim_initialized)
+		return rc;
+
 	if (enabled)
 		schedule_delayed_work(&damon_reclaim_timer, 0);
 
@@ -449,6 +455,8 @@ static int __init damon_reclaim_init(void)
 	damon_add_target(ctx, target);
 
 	schedule_delayed_work(&damon_reclaim_timer, 0);
+
+	damon_reclaim_initialized = true;
 	return 0;
 }
 
-- 
2.25.1

