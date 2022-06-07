Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8370D53F363
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiFGBeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiFGBeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:34:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2241DCEB91;
        Mon,  6 Jun 2022 18:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654565642; x=1686101642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/8EgY/pJmgMDqnUWYT+qbvnallyCFOehMnrLBUE2uaw=;
  b=PW7Kyzlf2eMhe3SlmIdYooI87+TmV5lrIjnnEzQHBaHksuN/xsuqa2vM
   xEpAVi98HywWOiNaYRlqlkh8ME98EPNEa7brw6WevgXxbpL5yXbjwQgyf
   HvwSars+bhhiLVo+/C5VwrXqzQxTrtEP46D93pfDUTZti4qknpYBFi9B8
   NwO3KR0lqOUzAuvudcoH/2E92YNaR5xDntniXUSmVrAzvCVvilzlKto6o
   EYm/SVUBi00X4dgjGg33/VFh8K1ouKRbBo3W6wwj6+PsrNTNYYzG6apgW
   QpdofArrq4fTnngIrtxLmqfE9tkdvEVSZj7E2P8JRcZv4P+Sw8m2xk7+j
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="257145860"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="257145860"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="669760269"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2022 18:33:58 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH 3/5] perf evlist: Always use arch_evlist__add_default_attrs()
Date:   Tue,  7 Jun 2022 09:33:13 +0800
Message-Id: <20220607013315.1956301-4-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607013315.1956301-1-zhengjun.xing@linux.intel.com>
References: <20220607013315.1956301-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current perf stat uses the evlist__add_default_attrs() to add the
generic default attrs, and uses arch_evlist__add_default_attrs()
to add the Arch specific default attrs, e.g., Topdown for X86.

It works well for the non-hybrid platforms. However, for a hybrid
platform, the hard code generic default attrs don't work.

Uses arch_evlist__add_default_attrs() to replace the
evlist__add_default_attrs(). The arch_evlist__add_default_attrs() is
modified to invoke the same __evlist__add_default_attrs() for the
generic default attrs. No functional change.

Add default_null_attrs[] to indicate the Arch specific attrs.
No functional change for the Arch specific default attrs either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 tools/perf/arch/x86/util/evlist.c | 7 ++++++-
 tools/perf/builtin-stat.c         | 6 +++++-
 tools/perf/util/evlist.c          | 9 +++++++--
 tools/perf/util/evlist.h          | 7 +++++--
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 68f681ad54c1..777bdf182a58 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -8,8 +8,13 @@
 #define TOPDOWN_L1_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
 #define TOPDOWN_L2_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
 
-int arch_evlist__add_default_attrs(struct evlist *evlist)
+int arch_evlist__add_default_attrs(struct evlist *evlist,
+				   struct perf_event_attr *attrs,
+				   size_t nr_attrs)
 {
+	if (nr_attrs)
+		return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
+
 	if (!pmu_have_event("cpu", "slots"))
 		return 0;
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6ac79d95f3b5..837c3ca91af1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1777,6 +1777,9 @@ static int add_default_attributes(void)
 	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
 	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
 };
+
+	struct perf_event_attr default_null_attrs[] = {};
+
 	/* Set attrs if no event is selected and !null_run: */
 	if (stat_config.null_run)
 		return 0;
@@ -1958,7 +1961,8 @@ static int add_default_attributes(void)
 			return -1;
 
 		stat_config.topdown_level = TOPDOWN_MAX_LEVEL;
-		if (arch_evlist__add_default_attrs(evsel_list) < 0)
+		/* Platform specific attrs */
+		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
 			return -1;
 	}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 48af7d379d82..efa5f006b5c6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -342,9 +342,14 @@ int __evlist__add_default_attrs(struct evlist *evlist, struct perf_event_attr *a
 	return evlist__add_attrs(evlist, attrs, nr_attrs);
 }
 
-__weak int arch_evlist__add_default_attrs(struct evlist *evlist __maybe_unused)
+__weak int arch_evlist__add_default_attrs(struct evlist *evlist,
+					  struct perf_event_attr *attrs,
+					  size_t nr_attrs)
 {
-	return 0;
+	if (!nr_attrs)
+		return 0;
+
+	return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
 }
 
 struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1bde9ccf4e7d..129095c0fe6d 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -107,10 +107,13 @@ static inline int evlist__add_default(struct evlist *evlist)
 int __evlist__add_default_attrs(struct evlist *evlist,
 				     struct perf_event_attr *attrs, size_t nr_attrs);
 
+int arch_evlist__add_default_attrs(struct evlist *evlist,
+				   struct perf_event_attr *attrs,
+				   size_t nr_attrs);
+
 #define evlist__add_default_attrs(evlist, array) \
-	__evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
+	arch_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
 
-int arch_evlist__add_default_attrs(struct evlist *evlist);
 struct evsel *arch_evlist__leader(struct list_head *list);
 
 int evlist__add_dummy(struct evlist *evlist);
-- 
2.25.1

