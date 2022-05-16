Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E575D5288B6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245298AbiEPPYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiEPPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:24:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B673BF8F;
        Mon, 16 May 2022 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652714685; x=1684250685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AkUng3hq2aUzIGEkrrJfWuMFjhuDTcDzFpA1oGYCNuA=;
  b=TiISzL1oYQzdFwKp96pC0plraTNM2Bw7ehxgB97nj+Rf3dbFA3ZUHAX9
   31F6knjaeJ6hUocYhMx3xxNAzmB/BGXTi5EwZueWuOPu2rdm1FreTqt87
   2kBVdd3YBZIvlOduUJDgQ8oDjxJ9BIbaRpv07EMZuy9sikPGu7R7rky4h
   hLn3zQOm49/Feh1pERrWzPVXKtOB+zfvVwr/QfzFXjHkZOFQ+c34DUbbe
   8FlOujq2wWlAmRqw2T20DFIUF5QX/1ssFweXt72a99m6Wc20Kt0GZeziS
   WCbfBwWxhMO8ONPE0XFmkkyguKLtXQiyviyCL0EFwZ9yzIkGl4bgXJnkM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270561298"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="270561298"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 08:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="741290205"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2022 08:24:43 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/4] perf stat: Always keep perf metrics topdown events in a group
Date:   Mon, 16 May 2022 08:24:34 -0700
Message-Id: <20220516152436.1104757-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516152436.1104757-1-kan.liang@linux.intel.com>
References: <20220516152436.1104757-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 tools/perf/builtin-stat.c |  7 +++----
 tools/perf/util/evlist.c  |  6 +-----
 tools/perf/util/evsel.c   | 13 +++++++++++--
 tools/perf/util/evsel.h   |  2 +-
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a96f106dc93a..75c88c7939b1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -271,10 +271,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 			pr_warning("     %s: %s\n", evsel->name, buf);
 		}
 
-		for_each_group_evsel(pos, leader) {
-			evsel__set_leader(pos, pos);
-			pos->core.nr_members = 0;
-		}
+		for_each_group_evsel(pos, leader)
+			evsel__remove_from_group(pos, leader);
+
 		evsel->core.leader->nr_members = 0;
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

