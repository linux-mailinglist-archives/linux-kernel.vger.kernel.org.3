Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CEA57C4C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiGUG4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiGUG4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:56:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67A9785BE;
        Wed, 20 Jul 2022 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658386593; x=1689922593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rCLkHftZqk4e364yx+hk1nw/VxB/Pjvb/PlsshXJLj4=;
  b=dBAIWTjjAQ3cHl21lVZ55tq7kdGIlkqxkzk/UeSs42leVJj2J9ryxY7f
   sTmI2cWi2NTZ/dnykw9ZuqGPCHPuJIQfaxkre6KiSVcGlRARGE43HQhh6
   oQiYticWpDvO0JADGO6rSBKFBeQSplvh0A8W7nAZXx6JFrQompBiEqzyW
   57eO430VVIvczePaIpkllVSS8DwxV5NL00symQvPNSXZwR3i1r8DhpB0K
   EfOstt0lkgoWPYXlf9xZlXCwkUEigNE6y04n636fg8kTneA+JeW41Iyaj
   OMeRc9RvBBELBEUQUEn81zMfzpbRy9eWkj2GoPNCL2r6GR+Zm5hw784iV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="285732489"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="285732489"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 23:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="602217331"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2022 23:56:30 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH v4 2/5] perf evsel: Add arch_evsel__hw_name()
Date:   Thu, 21 Jul 2022 14:57:03 +0800
Message-Id: <20220721065706.2886112-3-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721065706.2886112-1-zhengjun.xing@linux.intel.com>
References: <20220721065706.2886112-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
Change log:
  v4:
    * Adds Acked-by from Namhyung Kim <namhyung@kernel.org>
    * Rebase code to the latest perf/core branch
  v3:
    * no change since v1.

 tools/perf/arch/x86/util/evsel.c | 20 ++++++++++++++++++++
 tools/perf/util/evsel.c          |  7 ++++++-
 tools/perf/util/evsel.h          |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 882c1a8c1ded..ea3972d785d1 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -66,6 +66,26 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 		 strcasestr(evsel->name, "topdown"));
 }
 
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
+
 static void ibs_l3miss_warn(void)
 {
 	pr_warning(
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8fea51a9cd90..8199774a1dc2 100644
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
index 92bed8e2f7d8..9ec48049ee68 100644
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

