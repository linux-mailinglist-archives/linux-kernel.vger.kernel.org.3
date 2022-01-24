Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A09C497A86
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiAXIn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:62668 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242393AbiAXInK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013790; x=1674549790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pqE1c0GPx7HHb6iG99OWBfb5ZGWqVwXg1A1M59qD240=;
  b=PvP3fBeks3Jap4spwz3VvQYj2RpRCrBXesKRzyKkVGMS6IcwNmtZU3Hr
   CaS2ffChwuEcPwXALec49GbIkBVVMTOnJKelYe19YG0RrawjRAEU1pUOr
   LMBQrSbmM0Nk7Dg8Wdb13NBRvCXjCWDiqspWBAsUjQzdMJK64BosPDghs
   /JWHmcYWW8awcNwMpPHTf2gMuKj+wWQ6QqDGqMLcxyTaUVYAe6nCohpTV
   FqX9Gy4oukrZ0A54uXwAc8VN/OG9/QncI9kvNfvFUvTFbfdbrLRLktq46
   pHlsjY/2puw1kagJVKXZWTiujALXXlErTL9O2UvPr5eSlvICLpFEJGPH/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778476"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778476"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417239"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:47 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 20/25] perf script: Display new D and t flags
Date:   Mon, 24 Jan 2022 10:41:56 +0200
Message-Id: <20220124084201.2699795-21-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amend the display to include D and t flags in the same way as the x flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-script.txt | 13 ++++++++-----
 tools/perf/builtin-script.c              | 24 ++++++++++++++++--------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index b0070718784d..afd4718475c9 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -195,16 +195,19 @@ OPTIONS
 	At this point usage is displayed, and perf-script exits.
 
 	The flags field is synthesized and may have a value when Instruction
-	Trace decoding. The flags are "bcrosyiABExgh" which stand for branch,
+	Trace decoding. The flags are "bcrosyiABExghDt" which stand for branch,
 	call, return, conditional, system, asynchronous, interrupt,
-	transaction abort, trace begin, trace end, in transaction, VM-Entry, and VM-Exit
-	respectively. Known combinations of flags are printed more nicely e.g.
+	transaction abort, trace begin, trace end, in transaction, VM-Entry,
+	VM-Exit, interrupt disabled and interrupt disable toggle respectively.
+	Known combinations of flags are printed more nicely e.g.
 	"call" for "bc", "return" for "br", "jcc" for "bo", "jmp" for "b",
 	"int" for "bci", "iret" for "bri", "syscall" for "bcs", "sysret" for "brs",
 	"async" for "by", "hw int" for "bcyi", "tx abrt" for "bA", "tr strt" for "bB",
 	"tr end" for "bE", "vmentry" for "bcg", "vmexit" for "bch".
-	However the "x" flag will be displayed separately in those
-	cases e.g. "jcc     (x)" for a condition branch within a transaction.
+	However the "x", "D" and "t" flags will be displayed separately in those
+	cases e.g. "jcc     (xD)" for a condition branch within a transaction
+	with interrupts disabled. Note, interrupts becoming disabled is "t",
+	whereas interrupts becoming enabled is "Dt".
 
 	The callindent field is synthesized and may have a value when
 	Instruction Trace decoding. For calls and returns, it will display the
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 517d5f7a7d39..9e032343f1c6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1579,26 +1579,34 @@ static const char *sample_flags_to_name(u32 flags)
 
 int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
 {
+	u32 xf = PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_INTR_DISABLE |
+		 PERF_IP_FLAG_INTR_TOGGLE;
 	const char *chars = PERF_IP_FLAG_CHARS;
 	const size_t n = strlen(PERF_IP_FLAG_CHARS);
-	bool in_tx = flags & PERF_IP_FLAG_IN_TX;
 	const char *name = NULL;
 	size_t i, pos = 0;
+	char xs[16] = {0};
 
-	name = sample_flags_to_name(flags & ~PERF_IP_FLAG_IN_TX);
+	if (flags & xf)
+		snprintf(xs, sizeof(xs), "(%s%s%s)",
+			 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
+			 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
+			 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
+
+	name = sample_flags_to_name(flags & ~xf);
 	if (name)
-		return snprintf(str, sz, "%-15s%4s", name, in_tx ? "(x)" : "");
+		return snprintf(str, sz, "%-15s%6s", name, xs);
 
 	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
-		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_BEGIN));
+		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_BEGIN));
 		if (name)
-			return snprintf(str, sz, "tr strt %-7s%4s", name, in_tx ? "(x)" : "");
+			return snprintf(str, sz, "tr strt %-7s%6s", name, xs);
 	}
 
 	if (flags & PERF_IP_FLAG_TRACE_END) {
-		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_END));
+		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_END));
 		if (name)
-			return snprintf(str, sz, "tr end  %-7s%4s", name, in_tx ? "(x)" : "");
+			return snprintf(str, sz, "tr end  %-7s%6s", name, xs);
 	}
 
 	for (i = 0; i < n; i++, flags >>= 1) {
@@ -1620,7 +1628,7 @@ static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 	char str[SAMPLE_FLAGS_BUF_SIZE];
 
 	perf_sample__sprintf_flags(flags, str, sizeof(str));
-	return fprintf(fp, "  %-19s ", str);
+	return fprintf(fp, "  %-21s ", str);
 }
 
 struct printer_data {
-- 
2.25.1

