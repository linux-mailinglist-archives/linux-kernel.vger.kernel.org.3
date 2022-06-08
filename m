Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C76542BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiFHJoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiFHJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:43:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34071BF155;
        Wed,  8 Jun 2022 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654679428; x=1686215428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eMX2xcf/+FT6Cb05u89O2IkB0tmxuxLjMOtDqe8J9zA=;
  b=jxqwDbLe2RxKm9sh3UCLnbPpRQIsZxMt4TrK5V3Ttddep/+ayfqZSAeC
   WSvBnh+1Pkvij4lZueXBBe3n43hdLVvsVQWiz0+tMV7WyzXDXxpkkiK6D
   sXJK/AyLFSXW1QRL9IhWyUGftXp6Ei8kRH2VOeCJwqpeAdi7Gixo3DCqF
   tiCMAXmjbuRd/i6m3a9KvN5ZycC9qribtv44zmlwKUcq7GcJDu/LUBwlT
   oQcD2XwvIg6CDxe4lUEzmY47gk62XwVWuM3xwFYCea+JmvQw7XFS6wS+X
   Hs3GjPDdYbX0JsOmHJnsrAlvql5nYjGtJOlZvfTYcJBpXmEeY2Usoqan0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="363158274"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="363158274"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:10:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636697466"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:10:09 -0700
From:   Yanfei Xu <yanfei.xu@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/core: remove a meaningless pair of rcu_read_{,un}lock()
Date:   Wed,  8 Jun 2022 17:09:38 +0800
Message-Id: <20220608090938.2178624-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the codes, this pair of rcu_read_{,un}lock() protects nothing.
Let's remove it.

Further, the variable "pmu" is safe as it is in the SRCU read-side
critical scope of "pmus_srcu" and perf_pmu_unregister() delete it
after calling synchronize_srcu.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 kernel/events/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 950b25c3f210..36b0df6feab4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11296,9 +11296,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	}
 
 again:
-	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
-	rcu_read_unlock();
 	if (pmu) {
 		if (event->attr.type != type && type != PERF_TYPE_RAW &&
 		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
-- 
2.32.0

