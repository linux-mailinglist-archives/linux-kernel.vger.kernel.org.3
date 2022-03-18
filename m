Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C144DE20E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiCRUAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiCRUAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:00:47 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45718BCF9;
        Fri, 18 Mar 2022 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1647633568; x=1679169568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1aGAs4aOCqD0J3jbovdMWXZkUVXFuAQ6wuBY9SWJsI=;
  b=poHisdT+hOicmpV83I0mY7iwvxQqEYcwG0YU70rhh8EUBTORS2NAd3Hz
   EYb9BCeYddfezRIYx+aonpoKoTpdK/8OzcOmONb5/ZZr+cZh/7ATYUkEi
   zcMAgR7MVSjqA1BlahCFSfWUcUlMJvJBzwmBbQRxe8vdpoNTMOLExATjg
   Y=;
X-IronPort-AV: E=Sophos;i="5.90,192,1643673600"; 
   d="scan'208";a="1000596690"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-31df91b1.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 18 Mar 2022 19:59:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-31df91b1.us-west-2.amazon.com (Postfix) with ESMTPS id 6004E41DEE;
        Fri, 18 Mar 2022 19:59:27 +0000 (UTC)
Received: from EX13D02UWB003.ant.amazon.com (10.43.161.48) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 18 Mar 2022 19:59:27 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D02UWB003.ant.amazon.com (10.43.161.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 18 Mar 2022 19:59:26 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Fri, 18 Mar 2022 19:59:26
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 8841A17C0; Fri, 18 Mar 2022 19:59:25 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <german.gomez@arm.com>,
        <leo.yan@linaro.org>
CC:     <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
        <Nick.Forrington@arm.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <andrew.kilroy@arm.com>,
        <james.clark@arm.com>, <john.garry@huawei.com>, <jolsa@kernel.org>,
        <kjain@linux.ibm.com>, <lihuafei1@huawei.com>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: [PATCH v3 2/3] perf mem: Support mem_lvl_num in c2c command
Date:   Fri, 18 Mar 2022 19:59:12 +0000
Message-ID: <20220318195913.17459-3-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318195913.17459-1-alisaidi@amazon.com>
References: <20220318195913.17459-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to summarizing data encoded in mem_lvl also support data
encoded in mem_lvl_num.

Since other architectures don't seem to populate the mem_lvl_num field
here there shouldn't be a change in functionality.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/util/mem-events.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ed0ab838bcc5..e5e405185498 100644
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
+			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L3)) {
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
-- 
2.32.0

