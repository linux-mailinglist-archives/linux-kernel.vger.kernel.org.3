Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44CA48130A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhL2NKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbhL2NKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:10:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF87C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:10:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEA4E61416
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 13:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA207C36AEF;
        Wed, 29 Dec 2021 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640783432;
        bh=J6ZMpaN2aHN46NtgTZHJCKdNW2n5fbVEwYw8XD91LhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qo+mEMLVm+mY10GwS6gaWaS4LWzHzZ5uYVH+x9k2MWivYxaDiOZS2m0iXl2j3LfSp
         Jq3SAt4k2l76kgapOiNPAgpsMTWqhhXgHqty7C/DMPq8l8xfk7jsPafg95sC5yl2sd
         eLlp2CsWIG1DKm+RPZkQ0A/Lc3QM8zqvGFv/1W3DVTBBqro5F4X8rOa8ibgw7azsVL
         jswaGK6sVWdlKQtFWxSGxHb14yc4KH/Tu2ulkRYJ0HEnwJNckuqVAgyexAMLtnNDVM
         nEpOzXzJKjkA14QuIx2qrJFQzBVDg+0SNV78wBRg2isf2xQiP/nt0Jzws5jkiyrd4M
         z3PZ96Qr5rGTA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/4] mm/damon/vaddr: Use pr_debug() for damon_va_three_regions() failure logging
Date:   Wed, 29 Dec 2021 13:10:14 +0000
Message-Id: <20211229131016.23641-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211229131016.23641-1-sj@kernel.org>
References: <20211229131016.23641-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failure of 'damon_va_three_regions()' is logged using 'pr_err()'.  But,
the function can fail in legal situations.  To avoid making users be
surprised and to keep the kernel clean, this commit makes the log to be
printed using 'pr_debug()'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 9e213a1d60c9..7997e1c000ed 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -238,7 +238,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 	int i;
 
 	if (damon_va_three_regions(t, regions)) {
-		pr_err("Failed to get three regions of target %lu\n", t->id);
+		pr_debug("Failed to get three regions of target %lu\n", t->id);
 		return;
 	}
 
-- 
2.17.1

