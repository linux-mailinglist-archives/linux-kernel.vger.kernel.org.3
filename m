Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEEF522CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiEKHDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242598AbiEKHCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:02:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F71D80AE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652252527; x=1683788527;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=XMfB6fl3lfG1WnmVl6y/3ydLmCc+Z/Vpx7kECSUFDxQ=;
  b=Aa0w8MVVwZgNCq3Ahcv54QF9Mxlr5CHRMDvyAm+e9p7KEUdKHeIqHaEQ
   bTAU6cz70l/D6utasc8onZywagpjVNf9Z3ku+xLDTJnmLg20DaHgernq+
   07jN2G4IX7Ei5KdeQGcRRLCnNPaDTMO7SHh3NOdDRb2cUZOU6BdjOs22q
   yWG/TIt1zfXPu5kFFtaZd8qN5i+/RD+jopuPLxoqKjrb0ZV6UIE9yMvoJ
   L0nwS3+eyTwcv9nRLXvj3NgZO/J4Hs37ymMb6afHvkQVd/0p/DDjOh7oC
   vn4rS4GOM3JzxEatyvCr15Dr5qoeut6fexwvoKdLlihR9JJQl4PwGlj9E
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269546206"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="269546206"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:02:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="593967898"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.107])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:02:04 -0700
Message-ID: <543ef9a8-9743-b547-104e-5fc3fadfe091@intel.com>
Date:   Wed, 11 May 2022 10:01:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: [PATCH V3 10/23] perf auxtrace: Add mmap_needed to
 auxtrace_mmap_params
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-11-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220506122601.367589-11-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmap_needed to auxtrace_mmap_params.

Currently an auxtrace mmap is always attempted even if the event is not an
auxtrace event. That works because, when AUX area tracing, there is always
an auxtrace event first for every mmap. Prepare for that not being the
case, which it won't be when sideband tracking events are allowed on
all CPUs even when auxtrace is limited to selected CPUs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in V3: Amended mmap_needed comment

 tools/perf/util/auxtrace.c | 10 ++++++++--
 tools/perf/util/auxtrace.h | 11 +++++++++--
 tools/perf/util/evlist.c   |  5 +++--
 tools/perf/util/mmap.c     |  1 +
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b11549ae39df..b446cfa66469 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -125,7 +125,7 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 	mm->tid = mp->tid;
 	mm->cpu = mp->cpu.cpu;
 
-	if (!mp->len) {
+	if (!mp->len || !mp->mmap_needed) {
 		mm->base = NULL;
 		return 0;
 	}
@@ -168,9 +168,15 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 }
 
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
-				   struct evlist *evlist, int idx,
+				   struct evlist *evlist,
+				   struct evsel *evsel, int idx,
 				   bool per_cpu)
 {
+	mp->mmap_needed = evsel->needs_auxtrace_mmap;
+
+	if (!mp->mmap_needed)
+		return;
+
 	mp->idx = idx;
 
 	if (per_cpu) {
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index dc38b6f57232..695591b73ae1 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -344,6 +344,10 @@ struct auxtrace_mmap {
  * @idx: index of this mmap
  * @tid: tid for a per-thread mmap (also set if there is only 1 tid on a per-cpu
  *       mmap) otherwise %0
+ * @mmap_needed: set to %false for non-auxtrace events. This is needed because
+ *               auxtrace mmapping is done in the same code path as non-auxtrace
+ *               mmapping but not every evsel that needs non-auxtrace mmapping
+ *               also needs auxtrace mmapping.
  * @cpu: cpu number for a per-cpu mmap otherwise %-1
  */
 struct auxtrace_mmap_params {
@@ -353,6 +357,7 @@ struct auxtrace_mmap_params {
 	int		prot;
 	int		idx;
 	pid_t		tid;
+	bool		mmap_needed;
 	struct perf_cpu	cpu;
 };
 
@@ -490,7 +495,8 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 				unsigned int auxtrace_pages,
 				bool auxtrace_overwrite);
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
-				   struct evlist *evlist, int idx,
+				   struct evlist *evlist,
+				   struct evsel *evsel, int idx,
 				   bool per_cpu);
 
 typedef int (*process_auxtrace_t)(struct perf_tool *tool,
@@ -863,7 +869,8 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 				unsigned int auxtrace_pages,
 				bool auxtrace_overwrite);
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
-				   struct evlist *evlist, int idx,
+				   struct evlist *evlist,
+				   struct evsel *evsel, int idx,
 				   bool per_cpu);
 
 #define ITRACE_HELP ""
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7ae56b062f44..996bdc203616 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -747,15 +747,16 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 
 static void
 perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
-			 struct perf_evsel *_evsel __maybe_unused,
+			 struct perf_evsel *_evsel,
 			 struct perf_mmap_param *_mp,
 			 int idx)
 {
 	struct evlist *evlist = container_of(_evlist, struct evlist, core);
 	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
 	bool per_cpu = !perf_cpu_map__empty(_evlist->user_requested_cpus);
+	struct evsel *evsel = container_of(_evsel, struct evsel, core);
 
-	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
+	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, evsel, idx, per_cpu);
 }
 
 static struct perf_mmap*
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 50502b4a7ca4..de59c4da852b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -62,6 +62,7 @@ void __weak auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp __maybe_u
 
 void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __maybe_unused,
 					  struct evlist *evlist __maybe_unused,
+					  struct evsel *evsel __maybe_unused,
 					  int idx __maybe_unused,
 					  bool per_cpu __maybe_unused)
 {
-- 
2.25.1

