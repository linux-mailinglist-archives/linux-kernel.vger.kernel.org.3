Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE754659E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbiFJLd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349292AbiFJLdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:33:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66936D94D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654860822; x=1686396822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DP04M9CvR3YFdJBU75oAgWcXukIu95k8odDTFy6luJA=;
  b=TLy906fwYzshGKGEU/OmnJkRp7jMfJaWvhGYkGUlPdP+hiVYHk1fl4ko
   2BSRmVsytVWW5QiG7K7mJCLnRaAef/c1os8GzGzXtAayn6RHVaP+TioAX
   7i7vGUyU3lDbjxPx68HGMPb2xyHTuHBnGDwVIJWQxjUuqTnSCSBoJtRDn
   yECqLT1FnN6MzFH6fn6KzkgG2xlDON+cm7Lw+aFAjLRgqxl7aiAyoEmha
   3JqWbKwxAJqzJUBo9z3RXejdEqGiin14jQHoPKpRds2KZck5dL2rFj/5q
   s4jfZVLQ6M7oILKQ9L/pNHH6Iyppg9Mso1Qc9WNWJslZVxVQqv/qKNJKW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="275134376"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="275134376"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="616446333"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] perf record: Add finished init event
Date:   Fri, 10 Jun 2022 14:33:15 +0300
Message-Id: <20220610113316.6682-5-adrian.hunter@intel.com>
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

This is needed to enable injecting events after the initial synthesized
user events (that have an all zero id sample) but before regular events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/include/perf/event.h |  1 +
 tools/perf/builtin-inject.c         |  1 +
 tools/perf/builtin-record.c         | 27 +++++++++++++++++++++++++++
 tools/perf/util/event.c             |  1 +
 tools/perf/util/session.c           |  4 ++++
 tools/perf/util/tool.h              |  3 ++-
 6 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index e7758707cadd..9f7ca070da87 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -389,6 +389,7 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_TIME_CONV			= 79,
 	PERF_RECORD_HEADER_FEATURE		= 80,
 	PERF_RECORD_COMPRESSED			= 81,
+	PERF_RECORD_FINISHED_INIT		= 82,
 	PERF_RECORD_HEADER_MAX
 };
 
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a75bf11585b5..42e2918fd1cc 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1059,6 +1059,7 @@ int cmd_inject(int argc, const char **argv)
 			.stat		= perf_event__repipe_op2_synth,
 			.stat_round	= perf_event__repipe_op2_synth,
 			.feature	= perf_event__repipe_op2_synth,
+			.finished_init	= perf_event__repipe_op2_synth,
 			.compressed	= perf_event__repipe_op4_synth,
 			.auxtrace	= perf_event__repipe_auxtrace,
 		},
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 40dca1fba4e3..cf5c5379ceaa 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1388,6 +1388,11 @@ static struct perf_event_header finished_round_event = {
 	.type = PERF_RECORD_FINISHED_ROUND,
 };
 
+static struct perf_event_header finished_init_event = {
+	.size = sizeof(struct perf_event_header),
+	.type = PERF_RECORD_FINISHED_INIT,
+};
+
 static void record__adjust_affinity(struct record *rec, struct mmap *map)
 {
 	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
@@ -1696,6 +1701,14 @@ static int record__synthesize_workload(struct record *rec, bool tail)
 	return err;
 }
 
+static int write_finished_init(struct record *rec, bool tail)
+{
+	if (rec->opts.tail_synthesize != tail)
+		return 0;
+
+	return record__write(rec, NULL, &finished_init_event, sizeof(finished_init_event));
+}
+
 static int record__synthesize(struct record *rec, bool tail);
 
 static int
@@ -1710,6 +1723,8 @@ record__switch_output(struct record *rec, bool at_exit)
 
 	record__aio_mmap_read_sync(rec);
 
+	write_finished_init(rec, true);
+
 	record__synthesize(rec, true);
 	if (target__none(&rec->opts.target))
 		record__synthesize_workload(rec, true);
@@ -1764,6 +1779,7 @@ record__switch_output(struct record *rec, bool at_exit)
 		 */
 		if (target__none(&rec->opts.target))
 			record__synthesize_workload(rec, false);
+		write_finished_init(rec, false);
 	}
 	return fd;
 }
@@ -2419,6 +2435,15 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	trigger_ready(&auxtrace_snapshot_trigger);
 	trigger_ready(&switch_output_trigger);
 	perf_hooks__invoke_record_start();
+
+	/*
+	 * Must write FINISHED_INIT so it will be seen after all other
+	 * synthesized user events, but before any regular events.
+	 */
+	err = write_finished_init(rec, false);
+	if (err < 0)
+		goto out_child;
+
 	for (;;) {
 		unsigned long long hits = thread->samples;
 
@@ -2563,6 +2588,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n",
 			record__waking(rec));
 
+	write_finished_init(rec, true);
+
 	if (target__none(&rec->opts.target))
 		record__synthesize_workload(rec, true);
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0476bb3a4188..1fa14598b916 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -76,6 +76,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_TIME_CONV]			= "TIME_CONV",
 	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
 	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
+	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
 };
 
 const char *perf_event__name(unsigned int id)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0aa818977d2b..37f833c3c81b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -562,6 +562,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->feature = process_event_op2_stub;
 	if (tool->compressed == NULL)
 		tool->compressed = perf_session__process_compressed_event;
+	if (tool->finished_init == NULL)
+		tool->finished_init = process_event_op2_stub;
 }
 
 static void swap_sample_id_all(union perf_event *event, void *data)
@@ -1706,6 +1708,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		if (err)
 			dump_event(session->evlist, event, file_offset, &sample, file_path);
 		return err;
+	case PERF_RECORD_FINISHED_INIT:
+		return tool->finished_init(session, event);
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index f2352dba1875..c957fb849ac6 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -76,7 +76,8 @@ struct perf_tool {
 			stat_config,
 			stat,
 			stat_round,
-			feature;
+			feature,
+			finished_init;
 	event_op4	compressed;
 	event_op3	auxtrace;
 	bool		ordered_events;
-- 
2.25.1

