Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C34B94E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiBQAXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:23:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBQAXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:23:34 -0500
Received: from outbound-smtp42.blacknight.com (outbound-smtp42.blacknight.com [46.22.139.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E5137005
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:23:21 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id 78F3720F2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:23:20 +0000 (GMT)
Received: (qmail 23542 invoked from network); 17 Feb 2022 00:23:20 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 17 Feb 2022 00:23:20 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/6] mm/page_alloc: Drain the requested list first during bulk free
Date:   Thu, 17 Feb 2022 00:22:25 +0000
Message-Id: <20220217002227.5739-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220217002227.5739-1-mgorman@techsingularity.net>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to the series, pindex 0 (order-0 MIGRATE_UNMOVABLE) was always
skipped first and the precise reason is forgotten. A potential reason may
have been to artificially preserve MIGRATE_UNMOVABLE but there is no reason
why that would be optimal as it depends on the workload. The more likely
reason is that it was less complicated to do a pre-increment instead of
a post-increment in terms of overall code flow. As free_pcppages_bulk()
now typically receives the pindex of the PCP list that exceeded high,
always start draining that list.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dfc347a58ea6..635a4e0f70b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1463,6 +1463,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	 * below while (list_empty(list)) loop.
 	 */
 	count = min(pcp->count, count);
+
+	/* Ensure requested pindex is drained first. */
+	pindex = pindex - 1;
+
 	while (count > 0) {
 		struct list_head *list;
 		int nr_pages;
-- 
2.31.1

