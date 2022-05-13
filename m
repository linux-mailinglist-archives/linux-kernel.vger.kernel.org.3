Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC15265D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381878AbiEMPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350280AbiEMPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:16:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188315A0BF;
        Fri, 13 May 2022 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652454966; x=1683990966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NDrXSu1JZN2Qn0vkeSf7Zhq/N60jq8iWu8H5Bfn2kII=;
  b=cjhIIeyKc+p/a/sJr9uPSdCZlMt/GLI4RFAsijnj/1rZN1CnpH6wQbeY
   H4H4wM1kAzKXsveO7CcFf6tc7MYx3+iozPMfs68/2n5lF4AGGGRmi3eeB
   Gj9kkaR0gyHAJtytkS/WdYT2ECrs6Bca6Uq5I9Nackhcx+qF3Dm2Dqlu8
   bx2GXmp+Xck9/fpFa5QyKFSvdUlmeXH4B3s2NdUX8BSD2czloxDiZ65sa
   Hbnqf3bvVQt54ZxdbEEFak2HSGqM4ZPsw8i6VmfJDxb4S2XLoTr1SmMeB
   pmz3tMdU8tN4eeJuBD5mDRhL4VkPevCsNDV2E39Mc9YQk+G9El9S/Zoxo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="269160149"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="269160149"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 08:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="698518055"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 08:16:02 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/4] perf stat: Always keep perf metrics topdown events in a group
Date:   Fri, 13 May 2022 08:15:52 -0700
Message-Id: <20220513151554.1054452-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513151554.1054452-1-kan.liang@linux.intel.com>
References: <20220513151554.1054452-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

If any member in a group has a different cpu mask than the other
members, the current perf stat disables group. when the perf metrics
topdown events are part of the group, the below <not supported> error
will be triggered.

$ perf stat -e "{slots,topdown-retiring,uncore_imc_free_running_0/dclk/}" -a sleep 1
WARNING: grouped events cpus do not match, disabling group:
  anon group { slots, topdown-retiring, uncore_imc_free_running_0/dclk/ }

 Performance counter stats for 'system wide':

       141,465,174      slots
   <not supported>      topdown-retiring
     1,605,330,334      uncore_imc_free_running_0/dclk/

The perf metrics topdown events must always be grouped with a slots
event as leader.

With the patch, the topdown events aren't broken from the group for the
splitting.

$ perf stat -e "{slots,topdown-retiring,uncore_imc_free_running_0/dclk/}" -a sleep 1
WARNING: grouped events cpus do not match, disabling group:
  anon group { slots, topdown-retiring, uncore_imc_free_running_0/dclk/ }

 Performance counter stats for 'system wide':

       346,110,588      slots
       124,608,256      topdown-retiring
     1,606,869,976      uncore_imc_free_running_0/dclk/

       1.003877592 seconds time elapsed

Fixes: a9a1790247bd ("perf stat: Ensure group is defined on top of the same cpu mask")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-stat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a96f106dc93a..af2248868a4f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -272,8 +272,11 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 		}
 
 		for_each_group_evsel(pos, leader) {
-			evsel__set_leader(pos, pos);
-			pos->core.nr_members = 0;
+			if (!evsel__must_be_in_group(pos) && pos != leader) {
+				evsel__set_leader(pos, pos);
+				pos->core.nr_members = 0;
+				leader->core.nr_members--;
+			}
 		}
 		evsel->core.leader->nr_members = 0;
 	}
-- 
2.35.1

