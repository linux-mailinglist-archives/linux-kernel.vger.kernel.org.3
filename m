Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3999052BDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbiEROjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbiEROjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:39:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2521C0F38;
        Wed, 18 May 2022 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652884746; x=1684420746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=azzlWtN3/N+H67AfO794QZqeEtYcvV6vWBrUyjqwnbc=;
  b=agHCK1NDLmCMAyaA0pc0QuE+KihknAXe5/1b55E19yFtIexljd2DUKHB
   rQTwyAZueEbMBUR8gwC/Ii1mCMa3mUc3+nWnSPioN4uD5nRb7h9VXO7Gp
   0Q+Hp/IGz/k6npAEfuI/9SPrmksEMx/KFFxAybasi7YP7950BErRycap0
   BzKQWB3sJkBS+wqV3BK7fwkg4Y5NhCyqpeOyx7nyrUQuiX1FjV3tW7Bat
   z6eXwqFPUeqqtvXCoqa09j8xz0gCtURsn33w9xDe6KIzBfI/TcegPLjbz
   Uee8KzoWREblvDVelFFvGNaiHvxjpU/papYAXTs1gA4sj6qe794Mq9Yw2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="332321840"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="332321840"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="714455504"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2022 07:39:05 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/4] perf stat: Always keep perf metrics topdown events in a group
Date:   Wed, 18 May 2022 07:38:58 -0700
Message-Id: <20220518143900.1493980-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518143900.1493980-1-kan.liang@linux.intel.com>
References: <20220518143900.1493980-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Factor out evsel__remove_from_group() to only remove the regular events
from the group.

Remove evsel__must_be_in_group(), since no one use it anymore.

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
 tools/perf/builtin-stat.c |  7 ++-----
 tools/perf/util/evlist.c  |  6 +-----
 tools/perf/util/evsel.c   | 13 +++++++++++--
 tools/perf/util/evsel.h   |  2 +-
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a96f106dc93a..f058e8cddfa8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -271,11 +271,8 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 			pr_warning("     %s: %s\n", evsel->name, buf);
 		}
 
-		for_each_group_evsel(pos, leader) {
-			evsel__set_leader(pos, pos);
-			pos->core.nr_members = 0;
-		}
-		evsel->core.leader->nr_members = 0;
+		for_each_group_evsel(pos, leader)
+			evsel__remove_from_group(pos, leader);
 	}
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index dfa65a383502..7fc544330fea 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1795,11 +1795,7 @@ struct evsel *evlist__reset_weak_group(struct evlist *evsel_list, struct evsel *
 			 * them. Some events, like Intel topdown, require being
 			 * in a group and so keep these in the group.
 			 */
-			if (!evsel__must_be_in_group(c2) && c2 != leader) {
-				evsel__set_leader(c2, c2);
-				c2->core.nr_members = 0;
-				leader->core.nr_members--;
-			}
+			evsel__remove_from_group(c2, leader);
 
 			/*
 			 * Set this for all former members of the group
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b98882cbb286..deb428ee5e50 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3083,7 +3083,16 @@ bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __maybe_unuse
 	return false;
 }
 
-bool evsel__must_be_in_group(const struct evsel *evsel)
+/*
+ * Remove an event from a given group (leader).
+ * Some events, e.g., perf metrics Topdown events,
+ * must always be grouped. Ignore the events.
+ */
+void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader)
 {
-	return arch_evsel__must_be_in_group(evsel);
+	if (!arch_evsel__must_be_in_group(evsel) && evsel != leader) {
+		evsel__set_leader(evsel, evsel);
+		evsel->core.nr_members = 0;
+		leader->core.nr_members--;
+	}
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a36172ed4cf6..47f65f8e7c74 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -483,7 +483,7 @@ bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
 bool evsel__is_leader(struct evsel *evsel);
 void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
 int evsel__source_count(const struct evsel *evsel);
-bool evsel__must_be_in_group(const struct evsel *evsel);
+void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader);
 
 bool arch_evsel__must_be_in_group(const struct evsel *evsel);
 
-- 
2.35.1

