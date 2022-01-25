Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C2D49A8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1320230AbiAYDMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:12:06 -0500
Received: from out1.migadu.com ([91.121.223.63]:54341 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381110AbiAYC4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:56:16 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643079371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6AetOp+8FdkUYbmk8I3HLjqKFozMoot/fWYEIyFqQAQ=;
        b=clbsC5NJNdlePMqHXL4s852FIg7vc3ItTIg6HrAVwLXwvTRNoLA+YHvKj1XnwO7fJGTJv1
        Zvxk/7eprV2L9uimJkHH3tqmNEFBxjmjW0YfS+3j7TRSLDnThAFUu22eyicUA7tiYOzy+Y
        3W0nXra8eT2O8jCCEW/rfpf5mIvR14A=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm, hwpoison: remove obsolete comment
Date:   Tue, 25 Jan 2022 11:56:01 +0900
Message-Id: <20220125025601.3054511-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

With the introduction of mf_mutex, most of memory error handling
process is mutually exclusive, so the in-line comment about
subtlety about double-checking PageHWPoison is no more correct.
So remove it.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4c9bd1d37301..a6a1e02759e7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2146,12 +2146,6 @@ static int __soft_offline_page(struct page *page)
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
 
-	/*
-	 * Check PageHWPoison again inside page lock because PageHWPoison
-	 * is set by memory_failure() outside page lock. Note that
-	 * memory_failure() also double-checks PageHWPoison inside page lock,
-	 * so there's no race between soft_offline_page() and memory_failure().
-	 */
 	lock_page(page);
 	if (!PageHuge(page))
 		wait_on_page_writeback(page);
-- 
2.25.1

