Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1272E497A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbiAXIml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242305AbiAXImb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013751; x=1674549751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4LyUL4N9bPfNWdHsrAxUZNbbJy6F+CZLUfTNd2mpc9g=;
  b=RgmkSuhNZyv21uyXOPvR2IpLHR0LpC+v67ag4CWUWECxCl6owbFhdkWQ
   oJn45VWwuUBOZ9zoh9VaBOJmlhWFjflXU5rrZaz3iO8h3FO+JHr+Exe18
   KX7vZ3oITwulPOSk4Cg5C8aunv9sWXDVoOBccVAH2tnclSYK0pTIWLCLe
   DC5M/CrRM0SruS0VhEQLl9CQaXK8LkhR2YgX9MpfTowlebwde59mSlPlD
   xq++YSb7RZUUGfOFt3i8AVrHk6BXkNHRqzRG4DUZ3EnZ/p4IQzUfVPOGz
   mnfzUiMJ27hsWYks+AqC2ScgiHFMK9UFxrTsl80snpnFpXBPy1YZabmbu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778428"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778428"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417123"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:29 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/25] perf auxtrace: Add itrace option "I"
Date:   Mon, 24 Jan 2022 10:41:48 +0200
Message-Id: <20220124084201.2699795-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add itrace option "I" to synthesize interrupt or similar (asynchronous)
events. This will be used for Intel PT Event Trace events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt | 2 ++
 tools/perf/util/auxtrace.c          | 4 ++++
 tools/perf/util/auxtrace.h          | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index c52755481e2f..6b189669c450 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -7,6 +7,8 @@
 		p	synthesize power events (incl. PSB events for Intel PT)
 		o	synthesize other events recorded due to the use
 			of aux-output (refer to perf record)
+		I	synthesize interrupt or similar (asynchronous) events
+			(e.g. Intel PT Event Trace)
 		e	synthesize error events
 		d	create a debug log
 		f	synthesize first level cache events
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 825336304a37..9e48652662d4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1333,6 +1333,7 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->ptwrites = true;
 	synth_opts->pwr_events = true;
 	synth_opts->other_events = true;
+	synth_opts->intr_events = true;
 	synth_opts->errors = true;
 	synth_opts->flc = true;
 	synth_opts->llc = true;
@@ -1479,6 +1480,9 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 		case 'o':
 			synth_opts->other_events = true;
 			break;
+		case 'I':
+			synth_opts->intr_events = true;
+			break;
 		case 'e':
 			synth_opts->errors = true;
 			if (get_flags(&p, &synth_opts->error_plus_flags,
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 19910b9011f3..dc38b6f57232 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -76,6 +76,7 @@ enum itrace_period_type {
  * @pwr_events: whether to synthesize power events
  * @other_events: whether to synthesize other events recorded due to the use of
  *                aux_output
+ * @intr_events: whether to synthesize interrupt events
  * @errors: whether to synthesize decoder error events
  * @dont_decode: whether to skip decoding entirely
  * @log: write a decoding log
@@ -120,6 +121,7 @@ struct itrace_synth_opts {
 	bool			ptwrites;
 	bool			pwr_events;
 	bool			other_events;
+	bool			intr_events;
 	bool			errors;
 	bool			dont_decode;
 	bool			log;
@@ -636,6 +638,8 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				p:	    		synthesize power events\n"			\
 "				o:			synthesize other events recorded due to the use\n" \
 "							of aux-output (refer to perf record)\n"	\
+"				I:			synthesize interrupt or similar (asynchronous) events\n" \
+"							(e.g. Intel PT Event Trace)\n" \
 "				e[flags]:		synthesize error events\n" \
 "							each flag must be preceded by + or -\n" \
 "							error flags are: o (overflow)\n" \
-- 
2.25.1

