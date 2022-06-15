Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367C254C11E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiFOFZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiFOFZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:25:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A7A49909
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655270732; x=1686806732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MO0KS2YphkZ1/QDHpSdxx9IO4iT8qrm+MdGB8kYbpJ4=;
  b=EfQbLzxau/78beBnLZEdjlD96KfLxxBXEW/etX1pVR5KXWttxash9XoF
   4GDojMOPftQ6FDBly0e2317F4jT5po8Pberq7JyvHGM73oxQ1bMMBGA/A
   RnpkRS5LKZw2qGkCvrViBBjso3n6tkLQ/DVG2KhnnGs7R+4aMzwHx+gVi
   MK9LlAHTovLET3PaFGYzJ6OOnEdiWTNoDl8Q9Lr/eghGIQ+4irik6MOkc
   HcIl/2VvvZEub4Zlz9iPj1ppnFgNmnO+u5X+xQ5HYd3mfQQ0hs7nm7ekC
   ZNwe+gGRy2j7oISBNxmhuwsoheKPpO8mA5Lc+1TLS1jZVHzRfASRlaaJu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279882828"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="279882828"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 22:25:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="618303150"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.32.80])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 22:25:30 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] perf record: Add new option to sample identifier
Date:   Wed, 15 Jun 2022 08:25:11 +0300
Message-Id: <20220615052511.4441-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAP-5=fVWOeqZ+BePoe3Te1fCaru_O5u+E0Lah8pGvSOfLDQaWQ@mail.gmail.com>
References: <CAP-5=fVWOeqZ+BePoe3Te1fCaru_O5u+E0Lah8pGvSOfLDQaWQ@mail.gmail.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
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

In preparation for recording sideband events in a virtual machine guest so
that they can be injected into a host perf.data file.

Add an option to always include sample type PERF_SAMPLE_IDENTIFIER.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	Extend documntation for --sample-identifier


 tools/perf/Documentation/perf-record.txt | 5 +++++
 tools/perf/builtin-record.c              | 2 ++
 tools/perf/util/record.c                 | 2 +-
 tools/perf/util/record.h                 | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index cf8ad50f3de1..6bd6d07021ba 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -313,6 +313,11 @@ OPTIONS
 --sample-cpu::
 	Record the sample cpu.
 
+--sample-identifier::
+	Record the sample identifier i.e. PERF_SAMPLE_IDENTIFIER bit set in
+	the sample_type member of the struct perf_event_attr argument to the
+	perf_event_open system call.
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

