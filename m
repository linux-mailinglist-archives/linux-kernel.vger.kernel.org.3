Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F324BED63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiBUWtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:49:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiBUWtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:49:15 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6526B22B32;
        Mon, 21 Feb 2022 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1645483732; x=1677019732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UNqAMTAVydknhHstqyu4WYIg/j3vKUO81xt/oxFzZ8c=;
  b=QQWh32Z4n875LIE8R4NmB6FJVuOJN6JrNhv1CZytkhjrNRIXbbL30QOR
   9ujhcNWH2D+G6NmRHT/bFpTIeICffxTlu8CVl53SozCcF7eOLvGaqIWT6
   GKwLRQ11z3RzKJako48Ae6dMsu2ONBqKbUX7/O9ib9owhwkpystxEbshl
   g=;
X-IronPort-AV: E=Sophos;i="5.88,386,1635206400"; 
   d="scan'208";a="178631464"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-98691110.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 21 Feb 2022 22:48:51 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-98691110.us-east-1.amazon.com (Postfix) with ESMTPS id 3F4FD85227;
        Mon, 21 Feb 2022 22:48:44 +0000 (UTC)
Received: from EX13D02UWC002.ant.amazon.com (10.43.162.6) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 21 Feb 2022 22:48:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02UWC002.ant.amazon.com (10.43.162.6) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 21 Feb 2022 22:48:20 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Mon, 21 Feb 2022 22:48:19
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 6A34417C4; Mon, 21 Feb 2022 22:48:19 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <german.gomez@arm.com>,
        <leo.yan@linaro.org>
CC:     <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        "Will Deacon" <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "James Clark" <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>
Subject: [PATCH v2 2/2] perf mem: Support HITM for when mem_lvl_num is used
Date:   Mon, 21 Feb 2022 22:48:00 +0000
Message-ID: <20220221224807.18172-2-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220221224807.18172-1-alisaidi@amazon.com>
References: <20220221224807.18172-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code only support HITM statistics for last level cache (LLC)
when mem_lvl encodes the level. On existing Arm64 machines there are as
many as four levels cache and this change supports decoding l1, l2, and
llc hits from the mem_lvl_num data. Given that the mem_lvl namespace is
being deprecated take this opportunity to encode the neoverse data into
mem_lvl_num.

For loads that hit in a the LLC snoop filter and are fullfilled from a
higher level cache, it's not usually clear what the true level of the
cache the data came from (i.e. a transfer from a core could come from
it's L1 or L2). Instead of making an assumption of where the line came
from, add support for incrementing HITM if the source is CACHE_ANY.

Since other architectures don't seem to populate the mem_lvl_num field
here there shouldn't be a change in functionality.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/util/mem-events.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ed0ab838bcc5..6c3fd4aac7ae 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -485,6 +485,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
 	u64 daddr  = mi->daddr.addr;
 	u64 op     = data_src->mem_op;
 	u64 lvl    = data_src->mem_lvl;
+	u64 lnum   = data_src->mem_lvl_num;
 	u64 snoop  = data_src->mem_snoop;
 	u64 lock   = data_src->mem_lock;
 	u64 blk    = data_src->mem_blk;
@@ -527,16 +528,18 @@ do {				\
 			if (lvl & P(LVL, UNC)) stats->ld_uncache++;
 			if (lvl & P(LVL, IO))  stats->ld_io++;
 			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
-			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
-			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
-			if (lvl & P(LVL, L3 )) {
+			if (lvl & P(LVL, L1) || lnum == P(LVLNUM, L1))
+				stats->ld_l1hit++;
+			if (lvl & P(LVL, L2) || lnum == P(LVLNUM, L2))
+				stats->ld_l2hit++;
+			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L4)) {
 				if (snoop & P(SNOOP, HITM))
 					HITM_INC(lcl_hitm);
 				else
 					stats->ld_llchit++;
 			}
 
-			if (lvl & P(LVL, LOC_RAM)) {
+			if (lvl & P(LVL, LOC_RAM) || lnum == P(LVLNUM, RAM)) {
 				stats->lcl_dram++;
 				if (snoop & P(SNOOP, HIT))
 					stats->ld_shared++;
@@ -564,6 +567,9 @@ do {				\
 				HITM_INC(rmt_hitm);
 		}
 
+		if (lnum == P(LVLNUM, ANY_CACHE) && snoop & P(SNOOP, HITM))
+			HITM_INC(lcl_hitm);
+
 		if ((lvl & P(LVL, MISS)))
 			stats->ld_miss++;
 
-- 
2.32.0

