Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800ED4B94EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiBQAXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:23:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiBQAXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:23:15 -0500
Received: from outbound-smtp15.blacknight.com (outbound-smtp15.blacknight.com [46.22.139.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5021137005
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:23:00 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 3A38F1C424E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:22:59 +0000 (GMT)
Received: (qmail 22882 invoked from network); 17 Feb 2022 00:22:58 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 17 Feb 2022 00:22:58 -0000
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
Subject: [PATCH 2/6] mm/page_alloc: Track range of active PCP lists during bulk free
Date:   Thu, 17 Feb 2022 00:22:23 +0000
Message-Id: <20220217002227.5739-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220217002227.5739-1-mgorman@techsingularity.net>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_pcppages_bulk() frees pages in a round-robin fashion. Originally,
this was dealing only with migratetypes but storing high-order pages
means that there can be many more empty lists that are uselessly
checked. Track the minimum and maximum active pindex to reduce the
search space.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 08de32cfd9bb..85cc1fe8bcc5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1450,6 +1450,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 					struct per_cpu_pages *pcp)
 {
 	int pindex = 0;
+	int min_pindex = 0;
+	int max_pindex = NR_PCP_LISTS - 1;
 	int batch_free = 0;
 	int nr_freed = 0;
 	unsigned int order;
@@ -1475,13 +1477,20 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		 */
 		do {
 			batch_free++;
-			if (++pindex == NR_PCP_LISTS)
-				pindex = 0;
+			if (++pindex > max_pindex)
+				pindex = min_pindex;
 			list = &pcp->lists[pindex];
-		} while (list_empty(list));
+			if (!list_empty(list))
+				break;
+
+			if (pindex == max_pindex)
+				max_pindex--;
+			if (pindex == min_pindex)
+				min_pindex++;
+		} while (1);
 
 		/* This is the only non-empty list. Free them all. */
-		if (batch_free == NR_PCP_LISTS)
+		if (batch_free >= max_pindex - min_pindex)
 			batch_free = count;
 
 		order = pindex_to_order(pindex);
-- 
2.31.1

