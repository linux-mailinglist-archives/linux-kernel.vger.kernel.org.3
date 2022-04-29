Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0670C51505A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378850AbiD2QKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378834AbiD2QJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D85A27D9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E7E8B83642
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC0FC385B0;
        Fri, 29 Apr 2022 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248378;
        bh=Hcue4UkSxQRyEUzwbaytE02Er4fLlaTR3fDdxJ0RqWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9FMxOBbdtErkeAclj4pzR65QPA31ltzHi4e6XJQM1s+FcZkV8NW3jZrxHT2kHkF4
         lv5UHIsB+Z2ImbsF3l86/aSgp1oqfUZV43FKtLrX6hFKGqcvEbeKeazCUwW2kZ1IKK
         jSULCIeRy4oSW72G6pLsH8tUo0EKls6kOFv5KYp5cp0u/7ywvBllY90Xnz60L3qZnp
         HDDWHwiMC7WTAkIdr3X+rIv7Y0ZxKo21GeHrtCtuWW+LmijIvl7cff6mPLYYd6v8ts
         xDzEupUY0o8tb8JzJQ5pewg8RwoVHk3636mxTHYuJtX2PicCTnfLlLvuC4WC5W9I+o
         l7sWU07sJhCgg==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 06/14] mm/damon/sysfs: prohibit multiple physical address space monitoring targets
Date:   Fri, 29 Apr 2022 16:05:58 +0000
Message-Id: <20220429160606.127307-7-sj@kernel.org>
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

Having multiple targets for physical address space monitoring makes no
sense.  This commit prohibits such a ridiculous DAMON context setup my
making the DAMON context build function to check and return an error for
the case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 767ab8c33e4d..988247d35862 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2124,6 +2124,10 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 {
 	int i, err;
 
+	/* Multiple physical address space monitoring targets makes no sense */
+	if (ctx->ops.id == DAMON_OPS_PADDR && sysfs_targets->nr > 1)
+		return -EINVAL;
+
 	for (i = 0; i < sysfs_targets->nr; i++) {
 		struct damon_sysfs_target *sys_target =
 			sysfs_targets->targets_arr[i];
-- 
2.25.1

