Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE828546597
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349314AbiFJLdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348119AbiFJLdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:33:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7D86D4CC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654860820; x=1686396820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e1vhPHLiSQValJAhw3CDZixau0Aa6PRtpiOeWk3R4o8=;
  b=avtAGkNR/Q9JneoeB12FmzaWFY5837LbWmiLWvPeyRAHF8gKYa/Qvd5z
   NwPcBSIdZAK/tAoUWoJVw393IZwiR4/UAAVjXNMRLkul8lcGR33548jhG
   GccTdwAtkHnFb5bpG1eA6CQpf2/8UkkNi5z9GZI9GFXN2hHf55WM4W53A
   ty5LcX+pfqBc/QWYGsYSV3ayLeUvQ9Rq2eps2pd323k89zzhSQUhbF1u/
   Vm6lFLYtCGrBOOJekj72HdQEGxX9D7z5pYEnuYOHRMO7oo1N/gGWSrIcB
   1nV0P2OxPICjJZCbv3/5fRiqtguBd7AYc2c0+xSWuI1XgFin4PGUcyrh8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="275134355"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="275134355"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="616446327"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] perf record: Add new option to sample identifier
Date:   Fri, 10 Jun 2022 14:33:14 +0300
Message-Id: <20220610113316.6682-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610113316.6682-1-adrian.hunter@intel.com>
References: <20220610113316.6682-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for recording sideband events in a virtual machine guest so
that they can be injected into a host perf.data file.

Add an option to always include sample type PERF_SAMPLE_IDENTIFIER.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-record.txt | 3 +++
 tools/perf/builtin-record.c              | 2 ++
 tools/perf/util/record.c                 | 2 +-
 tools/perf/util/record.h                 | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index cf8ad50f3de1..8fcea74fe3c2 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -313,6 +313,9 @@ OPTIONS
 --sample-cpu::
 	Record the sample cpu.
 
+--sample-identifier::
+	Record the sample identifier.
+
 -n::
 --no-samples::
 	Don't sample.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 00c2a6cdf1be..40dca1fba4e3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3191,6 +3191,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "code-page-size", &record.opts.sample_code_page_size,
 		    "Record the sampled code address (ip) page size"),
 	OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
+	OPT_BOOLEAN(0, "sample-identifier", &record.opts.sample_identifier,
+		    "Record the sample identifier"),
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
 			"Record the sample timestamps"),
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 5b09ecbb05dc..b529636ab3ea 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -121,7 +121,7 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
 	evlist__for_each_entry(evlist, evsel)
 		evsel__config_leader_sampling(evsel, evlist);
 
-	if (opts->full_auxtrace) {
+	if (opts->full_auxtrace || opts->sample_identifier) {
 		/*
 		 * Need to be able to synthesize and parse selected events with
 		 * arbitrary sample types, which requires always being able to
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index be9a957501f4..4269e916f450 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -28,6 +28,7 @@ struct record_opts {
 	bool	      sample_time;
 	bool	      sample_time_set;
 	bool	      sample_cpu;
+	bool	      sample_identifier;
 	bool	      period;
 	bool	      period_set;
 	bool	      running_time;
-- 
2.25.1

