Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119C553EDD5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiFFSXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiFFSXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:23:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D8910655B;
        Mon,  6 Jun 2022 11:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E35AB81AF1;
        Mon,  6 Jun 2022 18:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C751BC385A9;
        Mon,  6 Jun 2022 18:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654539800;
        bh=zzYotTKEGLDprg9+poMHiWB57TXnLs8veIXqbVZJakQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxG50trjbZk11hd8BkFPwMnPsdUMaKaDxA2TDSM1UP6LsoVQ2+0tCUFnSFT9JTdgi
         /Lfe0F+d4rorgHfn5Dn1QZm0yd2Of6JsN4IBr2lSKmC05oOsOFOKb9RXwNYBUX3sNz
         jccl9HwJ5MX8yhA+qInAi3jwKf9gVkYG0SB5R4cJOQfzGvXYDNq+kEXV8PuK5rGnre
         7Ne08FyMzxIoQvddB01DsviJGOfNDDCKiqalHx8+QnvFVUzsqzqilvFWYw0I9e+WGj
         7YZe6OK5GXKeiLIZqpS5L2VACnDfO3ic+5RciciQeU/GEi2W+xdaXzBT3/cNwJtX2C
         tbYobf3tbGxGQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 5/6] mm/damon/reclaim: make 'enabled' checking timer simpler
Date:   Mon,  6 Jun 2022 18:23:09 +0000
Message-Id: <20220606182310.48781-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606182310.48781-1-sj@kernel.org>
References: <20220606182310.48781-1-sj@kernel.org>
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

DAMON_RECLAIM's 'enabled' parameter store callback ('enabled_store()')
schedules the parameter check timer ('damon_reclaim_timer') if the
parameter is set as 'Y'.  Then, the timer schedules itself to check if
user has set the parameter as 'N'.  It's unnecessarily complex.

This commit makes it simpler by making the parameter store callback to
schedule the timer regardless of the parameter value and disabling the
timer's self scheduling.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index c2ed962db23f..38da28803d75 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -353,7 +353,6 @@ static int damon_reclaim_turn(bool on)
 	return 0;
 }
 
-#define ENABLE_CHECK_INTERVAL_MS	1000
 static struct delayed_work damon_reclaim_timer;
 static void damon_reclaim_timer_fn(struct work_struct *work)
 {
@@ -367,10 +366,6 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
 		else
 			enabled = last_enabled;
 	}
-
-	if (enabled)
-		schedule_delayed_work(&damon_reclaim_timer,
-			msecs_to_jiffies(ENABLE_CHECK_INTERVAL_MS));
 }
 static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
 
@@ -388,9 +383,7 @@ static int enabled_store(const char *val,
 	if (!damon_reclaim_initialized)
 		return rc;
 
-	if (enabled)
-		schedule_delayed_work(&damon_reclaim_timer, 0);
-
+	schedule_delayed_work(&damon_reclaim_timer, 0);
 	return 0;
 }
 
-- 
2.25.1

