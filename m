Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB27F59F453
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiHXH3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiHXH2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:28:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1A9569B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661326128; x=1692862128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cqkndv1Yn7D3YXugKtRw1N3dr5xiJQHYcNHcQTNkS5k=;
  b=MGDwso7v9o4B9FMiLF5XnlDQtkX81k+oAa+uKuLCmcNgI1fA5UKiv9G8
   dQdkFmdpHkIFE5WNd8/ZqMSrOLVOKff9Udv0YIRww6oO59dS3JmAKXTTq
   LFBxXcTEhNlXcZkpX01n6VACF2A+iqJZ38+d+a8dpN6pnNjPcQj8ayQdv
   pqYxXyBDq3x5Cy1pQssnk9gtd6NOugqAoFFZtQIJ9d6dhjnDch+h9ZxwQ
   bN7IhCi5U81mvZM+K2zcnn+ySU9PQvIeaHuCPGCY0jXMvepCaoL2WPmfy
   UiXhkYcIouY8LHk0qHS4ePUz8uQUYUGnS6rztNhhnCVSz6CfCIahERqXH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="295173982"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="295173982"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:28:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="605939172"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:28:46 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] perf evlist: Add evlist__{en/dis}able_non_dummy()
Date:   Wed, 24 Aug 2022 10:28:13 +0300
Message-Id: <20220824072814.16422-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824072814.16422-1-adrian.hunter@intel.com>
References: <20220824072814.16422-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dummy events are used to provide sideband information like MMAP events that
are always needed even when main events are disabled. Add functions that
take that into account.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evlist.c | 30 ++++++++++++++++++++++++------
 tools/perf/util/evlist.h |  2 ++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4c5e6e9f8d11..3cfe730c12b8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -480,7 +480,7 @@ static int evlist__is_enabled(struct evlist *evlist)
 	return false;
 }
 
-static void __evlist__disable(struct evlist *evlist, char *evsel_name)
+static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl_dummy)
 {
 	struct evsel *pos;
 	struct evlist_cpu_iterator evlist_cpu_itr;
@@ -502,6 +502,8 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 				continue;
 			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
 				continue;
+			if (excl_dummy && evsel__is_dummy_event(pos))
+				continue;
 			if (pos->immediate)
 				has_imm = true;
 			if (pos->immediate != imm)
@@ -518,6 +520,8 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 			continue;
 		if (!evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
+		if (excl_dummy && evsel__is_dummy_event(pos))
+			continue;
 		pos->disabled = true;
 	}
 
@@ -533,15 +537,20 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 
 void evlist__disable(struct evlist *evlist)
 {
-	__evlist__disable(evlist, NULL);
+	__evlist__disable(evlist, NULL, false);
+}
+
+void evlist__disable_non_dummy(struct evlist *evlist)
+{
+	__evlist__disable(evlist, NULL, true);
 }
 
 void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
 {
-	__evlist__disable(evlist, evsel_name);
+	__evlist__disable(evlist, evsel_name, false);
 }
 
-static void __evlist__enable(struct evlist *evlist, char *evsel_name)
+static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_dummy)
 {
 	struct evsel *pos;
 	struct evlist_cpu_iterator evlist_cpu_itr;
@@ -560,6 +569,8 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 			continue;
 		if (!evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
+		if (excl_dummy && evsel__is_dummy_event(pos))
+			continue;
 		evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 	}
 	affinity__cleanup(affinity);
@@ -568,6 +579,8 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 			continue;
 		if (!evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
+		if (excl_dummy && evsel__is_dummy_event(pos))
+			continue;
 		pos->disabled = false;
 	}
 
@@ -581,12 +594,17 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 
 void evlist__enable(struct evlist *evlist)
 {
-	__evlist__enable(evlist, NULL);
+	__evlist__enable(evlist, NULL, false);
+}
+
+void evlist__enable_non_dummy(struct evlist *evlist)
+{
+	__evlist__enable(evlist, NULL, true);
 }
 
 void evlist__enable_evsel(struct evlist *evlist, char *evsel_name)
 {
-	__evlist__enable(evlist, evsel_name);
+	__evlist__enable(evlist, evsel_name, false);
 }
 
 void evlist__toggle_enable(struct evlist *evlist)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 3a464585d397..3a8474406738 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -205,6 +205,8 @@ void evlist__enable(struct evlist *evlist);
 void evlist__toggle_enable(struct evlist *evlist);
 void evlist__disable_evsel(struct evlist *evlist, char *evsel_name);
 void evlist__enable_evsel(struct evlist *evlist, char *evsel_name);
+void evlist__disable_non_dummy(struct evlist *evlist);
+void evlist__enable_non_dummy(struct evlist *evlist);
 
 void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
 
-- 
2.25.1

