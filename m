Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198E148130B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbhL2NKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbhL2NKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:10:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:10:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 498D5614AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 13:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5916AC36AF0;
        Wed, 29 Dec 2021 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640783432;
        bh=Tqc33p9GRUSgtrjHIQAmSM+HAYm5FH9FB0Llx5PwAqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPhi3v/kMUPXv96TQTW22OOl8z+JEHoDL1BPsEH8asi285cOnODkyp5IjDv8+9DPU
         Z2CB0VeK0gOamZH4joyCUv+w4HgJA/QhErfStJJ6rz3DQ4dF1DPEkAWcUU+meSEbnX
         iKEc0CYSIqe3NX6G0S8GxwF6BurG7ASPRlyekHHB8rXSrVzxO8vmykLeJWzNSUobTU
         lGHFBM3KMTj9wKKyZXPb4LJmeMh2lL9jnJPjl7QWbLrvcDcc5SIP5xzYrFzUnmdmzH
         KALCME/O8ZfLPh48LfI5bC/2+oAj5Y7uHSsBMMLzDfmpuxjO/e5QwBQPL0U9cZORfj
         VW9fkQv3VY+Ug==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/4] mm/damon/vaddr: Hide kernel pointer from damon_va_three_regions() failure log
Date:   Wed, 29 Dec 2021 13:10:15 +0000
Message-Id: <20211229131016.23641-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211229131016.23641-1-sj@kernel.org>
References: <20211229131016.23641-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The failure log message for 'damon_va_three_regions()' prints the target
id, which is a 'struct pid' pointer in the case.  To avoid exposing the
kernel pointer via the log, this commit makes the log to use the index
of the target in the context's targets list instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 7997e1c000ed..73ee9719f8ba 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -232,13 +232,19 @@ static int damon_va_three_regions(struct damon_target *t,
 static void __damon_va_init_regions(struct damon_ctx *ctx,
 				     struct damon_target *t)
 {
+	struct damon_target *ti;
 	struct damon_region *r;
 	struct damon_addr_range regions[3];
 	unsigned long sz = 0, nr_pieces;
-	int i;
+	int i, tidx = 0;
 
 	if (damon_va_three_regions(t, regions)) {
-		pr_debug("Failed to get three regions of target %lu\n", t->id);
+		damon_for_each_target(ti, ctx) {
+			if (ti == t)
+				break;
+			tidx++;
+		}
+		pr_debug("Failed to get three regions of %dth target\n", tidx);
 		return;
 	}
 
-- 
2.17.1

