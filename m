Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC6F54659D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbiFJLeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349311AbiFJLdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:33:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD466D971
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654860825; x=1686396825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kf7/+6h+TKchnxu3qzFXkCkggkGUpmXXxa1pbt5obz4=;
  b=GUCtUTHTRTCw+warPjtRW/fwzGr4BxXt8AjxR6KKHRb4+Wg2sAIfGbdK
   tf89fzHGxb1oDKiCtmXJ/pkkjtDNN329GLnetsxVaqyDiXAf+4qYvCykL
   JlnkN1uopitMZrXP5jTBtT1XTxi/CmBF3J9RrUvo5+wjoZClRPoaurYkw
   dVdYmYtRgY9w2GL3qccyedzcYkzovZhroGxsT8Lx1VMiLde54dM2US3p7
   aE95Y97NXJ4BEJWnwPt4vpJoJjMt7jdVwVbtegZ52cLU8H0gN5OXqPsJS
   rkG0g6nq7l95IPYRLb4xQfTuPYhFsG9KBK4A1WEDarDdrtcBHqNusO+gD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="275134394"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="275134394"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="616446336"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:42 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] perf script: Add some missing event dumps
Date:   Fri, 10 Jun 2022 14:33:16 +0300
Message-Id: <20220610113316.6682-6-adrian.hunter@intel.com>
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

When the -D option is used, the details of thread-map, cpu-map and
event-update events are not currently dumped. Add prints so that they are.

Example:

 # perf record --kcore sleep 0.1
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.021 MB perf.data (7 samples) ]
 # perf script -D | grep 'THREAD\|CPU'
 0 0x4950 [0x28]: PERF_RECORD_THREAD_MAP nr: 1 thread: 35116
 0 0x4978 [0x20]: PERF_RECORD_CPU_MAP: 0-7
 # perf script -D | grep -A4 'UPDATE'
 0 0x4920 [0x30]: PERF_RECORD_EVENT_UPDATE
 ... id:    147
 ... 0-7

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 6 ++++++
 tools/perf/util/header.c    | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c689054002cc..7cf21ab16f4f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3633,6 +3633,9 @@ int process_thread_map_event(struct perf_session *session,
 	struct perf_tool *tool = session->tool;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 
+	if (dump_trace)
+		perf_event__fprintf_thread_map(event, stdout);
+
 	if (script->threads) {
 		pr_warning("Extra thread map event, ignoring.\n");
 		return 0;
@@ -3652,6 +3655,9 @@ int process_cpu_map_event(struct perf_session *session,
 	struct perf_tool *tool = session->tool;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 
+	if (dump_trace)
+		perf_event__fprintf_cpu_map(event, stdout);
+
 	if (script->cpus) {
 		pr_warning("Extra cpu map event, ignoring.\n");
 		return 0;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 53332da100e8..de5b7a023e9e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4349,6 +4349,9 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 	struct evsel *evsel;
 	struct perf_cpu_map *map;
 
+	if (dump_trace)
+		perf_event__fprintf_event_update(event, stdout);
+
 	if (!pevlist || *pevlist == NULL)
 		return -EINVAL;
 
-- 
2.25.1

