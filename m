Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8512515057
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiD2QJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245744AbiD2QJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49657996BD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D95A46229E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1535C385A7;
        Fri, 29 Apr 2022 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248376;
        bh=dPUAlly+rInfVlu/ufebngY5ioNrRJjd5E6QpTd4Srg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYTSY51Ulp0QzoV2sDDdn8KZsT+ADsb++kwqoUqlkbCnn1OiUkZP/5BnOm1IrdGg0
         apCvBrHNZHDI1Lk0CSW2zYGJIYZFPp805kh9YUf1lb6uVDV3MBFc3HSee/xCOQW1wo
         3nch0GQE60Agc3hIYAjae0fzGvrUKnCITX0A1JwsmT+NZXaR4MSmre0HnoFnBEmB54
         fUhIrZuVC9p0iigmRl5oLwLkJ/hLX1ddk+YMSaXXPa5cH/YgUkrZuft+N2S0zaU6Ox
         fDWjnElzn3XPezgyVBs2eakE3exicQTJaP4cv9mwonlBwbBgbDDpSK5kPb5iNMtKdl
         EjO9Mgdm3wDzg==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 02/14] mm/damon/core: finish kdamond as soon as any callback returns an error
Date:   Fri, 29 Apr 2022 16:05:54 +0000
Message-Id: <20220429160606.127307-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429160606.127307-1-sj@kernel.org>
References: <20220429160606.127307-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

When 'after_sampling()' or 'after_aggregation()' DAMON callbacks return
an error, kdamond continues the remaining loop once.  It makes no much
sense to run the remaining part while something wrong already happened.
The context might be corrupted or having invalid data.  This commit
therefore makes kdamond skips the remaining works and immediately finish
in the cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e28fbc3a1969..18c08e90563e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1141,8 +1141,10 @@ static int kdamond_fn(void *data)
 		if (ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
 		if (ctx->callback.after_sampling &&
-				ctx->callback.after_sampling(ctx))
+				ctx->callback.after_sampling(ctx)) {
 			done = true;
+			continue;
+		}
 
 		kdamond_usleep(ctx->sample_interval);
 
@@ -1154,8 +1156,10 @@ static int kdamond_fn(void *data)
 					max_nr_accesses / 10,
 					sz_limit);
 			if (ctx->callback.after_aggregation &&
-					ctx->callback.after_aggregation(ctx))
+					ctx->callback.after_aggregation(ctx)) {
 				done = true;
+				continue;
+			}
 			kdamond_apply_schemes(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
-- 
2.25.1

