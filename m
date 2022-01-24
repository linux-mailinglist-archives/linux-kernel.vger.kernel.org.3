Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3057497A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbiAXIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:62624 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242438AbiAXInu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013830; x=1674549830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5j5TJCoGxF4CAqoY0fyuwuUeKSolXVQK42ITi5wrZag=;
  b=d69RjDpPDJuqRSGyW34xyocFm9rinqpfzJnuEKj+S9zZ1VPPY0o8D3CN
   ar+A2nzhLAmROR6N/FyEser+srJqwMwf0KCS3RVQanvNOqK/i65xwEv0+
   YQdZ30aRqQRtJgdBrIh4k8XHlfhO20DVhoABOI05YCBevS0+uty9TUJYS
   30+oGRfuh5Tnjw67+7lNEsbr5Bp8ElRq9g8y6aKRex9beMjwX8TJJzKVS
   SJpz0wLjDCeiXOvtzt+ql00PuWjTgM0O9iFLRVtuH4p2rTypmHCnRrnmn
   U7QJ6+xLD+4IcJ6W2vzfDjUvl8LuwoJJ5syux7tIcUDCCbDFeVrjcZAt7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778524"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778524"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:43:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417322"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:58 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] perf intel-pt: Add documentation for Event Trace and TNT disable
Date:   Mon, 24 Jan 2022 10:42:01 +0200
Message-Id: <20220124084201.2699795-26-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Event Trace and TNT disable to the perf Intel PT man
page.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 104 ++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index cbb920f5d056..ff58bd4c381b 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -108,9 +108,10 @@ displayed as follows:
 
 	perf script --itrace=ibxwpe -F+flags
 
-The flags are "bcrosyiABExgh" which stand for branch, call, return, conditional,
+The flags are "bcrosyiABExghDt" which stand for branch, call, return, conditional,
 system, asynchronous, interrupt, transaction abort, trace begin, trace end,
-in transaction, VM-entry, and VM-exit respectively.
+in transaction, VM-entry, VM-exit, interrupt disabled, and interrupt disable
+toggle respectively.
 
 perf script also supports higher level ways to dump instruction traces:
 
@@ -483,6 +484,30 @@ pwr_evt		Enable power events.  The power events provide information about
 		which contains "1" if the feature is supported and
 		"0" otherwise.
 
+event		Enable Event Trace.  The events provide information about asynchronous
+		events.
+
+		Support for this feature is indicated by:
+
+			/sys/bus/event_source/devices/intel_pt/caps/event_trace
+
+		which contains "1" if the feature is supported and
+		"0" otherwise.
+
+notnt		Disable TNT packets.  Without TNT packets, it is not possible to walk
+		executable code to reconstruct control flow, however FUP, TIP, TIP.PGE
+		and TIP.PGD packets still indicate asynchronous control flow, and (if
+		return compression is disabled - see noretcomp) return statements.
+		The advantage of eliminating TNT packets is reducing the size of the
+		trace and corresponding tracing overhead.
+
+		Support for this feature is indicated by:
+
+			/sys/bus/event_source/devices/intel_pt/caps/tnt_disable
+
+		which contains "1" if the feature is supported and
+		"0" otherwise.
+
 
 AUX area sampling option
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -876,6 +901,8 @@ The letters are:
 	p	synthesize "power" events (incl. PSB events)
 	c	synthesize branches events (calls only)
 	r	synthesize branches events (returns only)
+	o	synthesize PEBS-via-PT events
+	I	synthesize Event Trace events
 	e	synthesize tracing error events
 	d	create a debug log
 	g	synthesize a call chain (use with i or x)
@@ -1371,6 +1398,79 @@ There were none.
           :17006 17006 [001] 11500.262869216:  ffffffff8220116e error_entry+0xe ([guest.kernel.kallsyms])               pushq  %rax
 
 
+Event Trace
+-----------
+
+Event Trace records information about asynchronous events, for example interrupts,
+faults, VM exits and entries.  The information is recorded in CFE and EVD packets,
+and also the Interrupt Flag is recorded on the MODE.Exec packet.  The CFE packet
+contains a type field to identify one of the following:
+
+	 1	INTR		interrupt, fault, exception, NMI
+	 2	IRET		interrupt return
+	 3	SMI		system management interrupt
+	 4	RSM		resume from system management mode
+	 5	SIPI		startup interprocessor interrupt
+	 6	INIT		INIT signal
+	 7	VMENTRY		VM-Entry
+	 8	VMEXIT		VM-Entry
+	 9	VMEXIT_INTR	VM-Exit due to interrupt
+	10	SHUTDOWN	Shutdown
+
+For more details, refer to the Intel 64 and IA-32 Architectures Software
+Developer Manuals (version 076 or later).
+
+The capability to do Event Trace is indicated by the
+/sys/bus/event_source/devices/intel_pt/caps/event_trace file.
+
+Event trace is selected for recording using the "event" config term. e.g.
+
+	perf record -e intel_pt/event/u uname
+
+Event trace events are output using the --itrace I option. e.g.
+
+	perf script --itrace=Ie
+
+perf script displays events containing CFE type, vector and event data,
+in the form:
+
+	  evt:   hw int            (t)  cfe: INTR IP: 1 vector: 3 PFA: 0x8877665544332211
+
+The IP flag indicates if the event binds to an IP, which includes any case where
+flow control packet generation is enabled, as well as when CFE packet IP bit is
+set.
+
+perf script displays events containing changes to the Interrupt Flag in the form:
+
+	iflag:   t                      IFLAG: 1->0 via branch
+
+where "via branch" indicates a branch (interrupt or return from interrupt) and
+"non branch" indicates an instruction such as CFI, STI or POPF).
+
+In addition, the current state of the interrupt flag is indicated by the presence
+or absence of the "D" (interrupt disabled) perf script flag.  If the interrupt
+flag is changed, then the "t" flag is also included i.e.
+
+		no flag, interrupts enabled IF=1
+	t	interrupts become disabled IF=1 -> IF=0
+	D	interrupts are disabled IF=0
+	Dt	interrupts become enabled  IF=0 -> IF=1
+
+The intel-pt-events.py script illustrates how to access Event Trace information
+using a Python script.
+
+
+TNT Disable
+-----------
+
+TNT packets are disabled using the "notnt" config term. e.g.
+
+	perf record -e intel_pt/notnt/u uname
+
+In that case the --itrace q option is forced because walking executable code
+to reconstruct the control flow is not possible.
+
+
 
 SEE ALSO
 --------
-- 
2.25.1

