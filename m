Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFF7522B72
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiEKFFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiEKFFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:05:12 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 May 2022 22:05:10 PDT
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C4C1F9A38
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:05:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="71958777"
X-IronPort-AV: E=Sophos;i="5.91,216,1647270000"; 
   d="scan'208";a="71958777"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 11 May 2022 14:04:04 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C6026E5BA1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:04:02 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 199391416A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:04:02 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id D5879200B3AF;
        Wed, 11 May 2022 14:04:01 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vvghjk1234@gmail.com,
        aquini@redhat.com, ddutile@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yamamoto.rei@jp.fujitsu.com
Subject: [PATCH] mm, compaction: fast_find_migrateblock() should return pfn in the target zone
Date:   Wed, 11 May 2022 13:43:00 +0900
Message-Id: <20220511044300.4069-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent returning a pfn outside the target zone in case that not
aligned with pageblock boundary.
Otherwise isolate_migratepages_block() would handle pages not in
the target zone.

Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
---
 mm/compaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index fe915db6149b..de42b8e48758 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1858,6 +1858,8 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 
 				update_fast_start_pfn(cc, free_pfn);
 				pfn = pageblock_start_pfn(free_pfn);
+				if (pfn < cc->zone->zone_start_pfn)
+					pfn = cc->zone->zone_start_pfn;
 				cc->fast_search_fail = 0;
 				found_block = true;
 				set_pageblock_skip(freepage);
-- 
2.27.0

