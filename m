Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4B1475418
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbhLOIIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:08:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:41315 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240724AbhLOIIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639555698; x=1671091698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FkK9L8kDVwHDZsYVRlbM9Nbi4Cr7jGhF6yDZmNRsECk=;
  b=Rh5j05ugFeuQHrAJDMQcJ1eo2y5jX86Ft7dRZbPURLeTMH7IIPaNQGZW
   oin47HN/QSdZO4Uq6jU0VdrPfgn+Z5kp8Nt8polISeYMuXbut8VlqplEI
   1PIQgLftz5s93vkyFOirS57EjdqsoaZm0aWP1QqAI+iR/oD+rVOxTQOHH
   dSo79Rsntmpl/2muTejKVuTcB1KoWEBQt0DmSgIDMXD8XneqUoElqOxoX
   TnPPzoVe+EF5RdM47D2EWVs3uuFlrwd6yAkTneVHDbp74QOwZL9t8naRt
   VRxJWOXjDvlPpthemoLkfhvVY53R2Hk45mdyMrMFUEhSibsa5BBmxKcq1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="302550188"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="302550188"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 00:06:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505699450"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 00:06:45 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 3/3] perf scripts python: intel-pt-events.py: Fix printing of switch events
Date:   Wed, 15 Dec 2021 10:06:36 +0200
Message-Id: <20211215080636.149562-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215080636.149562-1-adrian.hunter@intel.com>
References: <20211215080636.149562-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel-pt-events.py script displays only the last of consecutive switch
statements but that may not be the last switch event for the CPU. Fix by
keeping a dictionary of last context switch keyed by CPU, and make it
possible to see all switch events by adding option --all-switch-events.

Fixes: a92bf335fd82e ("perf scripts python: intel-pt-events.py: Add branches to script")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/intel-pt-events.py | 23 +++++++++++---------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 1d3a189a9a54..66452a8ec358 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -32,8 +32,7 @@ try:
 except:
 	broken_pipe_exception = IOError
 
-glb_switch_str		= None
-glb_switch_printed	= True
+glb_switch_str		= {}
 glb_insn		= False
 glb_disassembler	= None
 glb_src			= False
@@ -70,6 +69,7 @@ def trace_begin():
 	ap = argparse.ArgumentParser(usage = "", add_help = False)
 	ap.add_argument("--insn-trace", action='store_true')
 	ap.add_argument("--src-trace", action='store_true')
+	ap.add_argument("--all-switch-events", action='store_true')
 	global glb_args
 	global glb_insn
 	global glb_src
@@ -256,10 +256,6 @@ def print_srccode(comm, param_dict, sample, symbol, dso, with_insn):
 	print(start_str, src_str)
 
 def do_process_event(param_dict):
-	global glb_switch_printed
-	if not glb_switch_printed:
-		print(glb_switch_str)
-		glb_switch_printed = True
 	event_attr = param_dict["attr"]
 	sample	   = param_dict["sample"]
 	raw_buf	   = param_dict["raw_buf"]
@@ -274,6 +270,11 @@ def do_process_event(param_dict):
 	dso    = get_optional(param_dict, "dso")
 	symbol = get_optional(param_dict, "symbol")
 
+	cpu = sample["cpu"]
+	if cpu in glb_switch_str:
+		print(glb_switch_str[cpu])
+		del glb_switch_str[cpu]
+
 	if name[0:12] == "instructions":
 		if glb_src:
 			print_srccode(comm, param_dict, sample, symbol, dso, True)
@@ -336,8 +337,6 @@ def auxtrace_error(typ, code, cpu, pid, tid, ip, ts, msg, cpumode, *x):
 		sys.exit(1)
 
 def context_switch(ts, cpu, pid, tid, np_pid, np_tid, machine_pid, out, out_preempt, *x):
-	global glb_switch_printed
-	global glb_switch_str
 	if out:
 		out_str = "Switch out "
 	else:
@@ -350,6 +349,10 @@ def context_switch(ts, cpu, pid, tid, np_pid, np_tid, machine_pid, out, out_pree
 		machine_str = ""
 	else:
 		machine_str = "machine PID %d" % machine_pid
-	glb_switch_str = "%16s %5d/%-5d [%03u] %9u.%09u %5d/%-5d %s %s" % \
+	switch_str = "%16s %5d/%-5d [%03u] %9u.%09u %5d/%-5d %s %s" % \
 		(out_str, pid, tid, cpu, ts / 1000000000, ts %1000000000, np_pid, np_tid, machine_str, preempt_str)
-	glb_switch_printed = False
+	if glb_args.all_switch_events:
+		print(switch_str);
+	else:
+		global glb_switch_str
+		glb_switch_str[cpu] = switch_str
-- 
2.25.1

