Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD7053F362
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiFGBd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiFGBd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:33:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC214CC172;
        Mon,  6 Jun 2022 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654565634; x=1686101634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7wFVUBzJrL05xEAan5oFvszvrLiZW/edmcpeZyJPLOQ=;
  b=Fv1xTdZ/1NSjm7AXbwQlNHRX+OZxjbX3UWg0JGML3BQqSFj9eGM5HkrU
   FUXXI5EagzIi4ClLTOntCu+BRCnlQJHxDE62lSQgRHcPxEGAJpmgKxj1r
   hdtYLMZR95mGvhFnE1EdovP+UwajBRDQELyBekLCnFIKhYs3BVflopLRI
   nxMRjjAPa0eLn3RoUJcptUI8CiJpQvNt9omi4kaaP2tMuts3D9AFzGN+h
   bZqBX9JfzplsA97qFNBBJ7wYvxlDfUCsZ8qvgPDPZf6YdZXY44blOhtar
   zK6Fs0A7ClFYi+SyF6/u+l87qqvItRU4RP+SOrjgBsaqXHOyqArSzpAh8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277264889"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="277264889"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="669760234"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2022 18:33:50 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH 2/5] perf evsel: Add arch_evsel__hw_name()
Date:   Tue,  7 Jun 2022 09:33:12 +0800
Message-Id: <20220607013315.1956301-3-zhengjun.xing@linux.intel.com>
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

The commit 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and
PERF_TYPE_HW_CACHE") extends the two types to become PMU aware types for
a hybrid system. However, current evsel__hw_name doesn't take the PMU
type into account. It mistakenly returns the "unknown-hardware" for the
hardware event with a specific PMU type.

Add an Arch specific arch_evsel__hw_name() to specially handle the PMU
aware hardware event.

Currently, the extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE is only
supported by X86. Only implement the specific arch_evsel__hw_name() for
X86 in the patch.

Nothing is changed for the other Archs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 tools/perf/arch/x86/util/evsel.c | 20 ++++++++++++++++++++
 tools/perf/util/evsel.c          |  7 ++++++-
 tools/perf/util/evsel.h          |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 3501399cef35..f6feb61d98a0 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -61,3 +61,23 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 		(strcasestr(evsel->name, "slots") ||
 		 strcasestr(evsel->name, "topdown"));
 }
+
+int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
+{
+	u64 event = evsel->core.attr.config & PERF_HW_EVENT_MASK;
+	u64 pmu = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+	const char *event_name;
+
+	if (event < PERF_COUNT_HW_MAX && evsel__hw_names[event])
+		event_name = evsel__hw_names[event];
+	else
+		event_name = "unknown-hardware";
+
+	/* The PMU type is not required for the non-hybrid platform. */
+	if (!pmu)
+		return  scnprintf(bf, size, "%s", event_name);
+
+	return scnprintf(bf, size, "%s/%s/",
+			 evsel->pmu_name ? evsel->pmu_name : "cpu",
+			 event_name);
+}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ce499c5da8d7..782be377208f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -593,9 +593,14 @@ static int evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
 	return r;
 }
 
+int __weak arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
+{
+	return scnprintf(bf, size, "%s", __evsel__hw_name(evsel->core.attr.config));
+}
+
 static int evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 {
-	int r = scnprintf(bf, size, "%s", __evsel__hw_name(evsel->core.attr.config));
+	int r = arch_evsel__hw_name(evsel, bf, size);
 	return r + evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 73ea48e94079..8dd3f04a5bdb 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -271,6 +271,7 @@ extern const char *const evsel__hw_names[PERF_COUNT_HW_MAX];
 extern const char *const evsel__sw_names[PERF_COUNT_SW_MAX];
 extern char *evsel__bpf_counter_events;
 bool evsel__match_bpf_counter_events(const char *name);
+int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
 
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
-- 
2.25.1

