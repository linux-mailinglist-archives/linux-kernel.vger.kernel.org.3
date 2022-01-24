Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494F5497A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbiAXIn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242423AbiAXInr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013827; x=1674549827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ypc+Qxk9ekX5hM/PA7q7iXC6k9blbnTC+nul8hX0Bbc=;
  b=GnIAnp+NDWON6YTA1cGJJ/Vr1r4CG6QnYUVGs8k3GVVY31uGm7Mv/Yir
   YvHzomWuvRAG+uRS64INGNW0dEOl1/FFZESDKY/LPwRNcEmaRDBI54Oam
   HIZPxaPetyvZGuTq71by9tokRQ7zNjkHgy+mYiKoYUJEZWE3cJk1iIjt0
   8ljgoIPDcp+Ydpb3mxLStmvxSfOuARSQPDmimk54BdaS7e42d2H6t2Ivk
   qTZqY/gsblG01eX4Ql3qFR37yvkzbHtz30Mb7HeQAhfV54ZuMLJPt6B7N
   IGNjvyDycQ1xdDqYJJuThFZn3zbGMNqkWiHhUnbIrSGZrJBH+7w2h1V2G
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778520"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778520"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417308"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:56 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] perf scripts python: export-to-postgresql.py: Export all sample flags
Date:   Mon, 24 Jan 2022 10:42:00 +0200
Message-Id: <20220124084201.2699795-25-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sample flags to the PostgreSQL database definition and export.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../perf/scripts/python/export-to-postgresql.py | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index d187e46c2683..3a6bdcd74e60 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -399,7 +399,8 @@ if branches:
 		'in_tx		boolean,'
 		'call_path_id	bigint,'
 		'insn_count	bigint,'
-		'cyc_count	bigint)')
+		'cyc_count	bigint,'
+		'flags		integer)')
 else:
 	do_query(query, 'CREATE TABLE samples ('
 		'id		bigint		NOT NULL,'
@@ -425,7 +426,8 @@ else:
 		'in_tx		boolean,'
 		'call_path_id	bigint,'
 		'insn_count	bigint,'
-		'cyc_count	bigint)')
+		'cyc_count	bigint,'
+		'flags		integer)')
 
 if perf_db_export_calls or perf_db_export_callchains:
 	do_query(query, 'CREATE TABLE call_paths ('
@@ -604,7 +606,8 @@ do_query(query, 'CREATE VIEW samples_view AS '
 		'in_tx,'
 		'insn_count,'
 		'cyc_count,'
-		'CASE WHEN cyc_count=0 THEN CAST(0 AS NUMERIC(20, 2)) ELSE CAST((CAST(insn_count AS FLOAT) / cyc_count) AS NUMERIC(20, 2)) END AS IPC'
+		'CASE WHEN cyc_count=0 THEN CAST(0 AS NUMERIC(20, 2)) ELSE CAST((CAST(insn_count AS FLOAT) / cyc_count) AS NUMERIC(20, 2)) END AS IPC,'
+		'flags'
 	' FROM samples')
 
 do_query(query, 'CREATE VIEW ptwrite_view AS '
@@ -804,7 +807,7 @@ def trace_begin():
 	comm_table(0, "unknown", 0, 0, 0)
 	dso_table(0, 0, "unknown", "unknown", "")
 	symbol_table(0, 0, 0, 0, 0, "unknown")
-	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
+	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 	if perf_db_export_calls or perf_db_export_callchains:
 		call_path_table(0, 0, 0, 0)
 		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
@@ -1025,11 +1028,11 @@ def branch_type_table(branch_type, name, *x):
 	value = struct.pack(fmt, 2, 4, branch_type, n, name)
 	branch_type_file.write(value)
 
-def sample_table(sample_id, evsel_id, machine_id, thread_id, comm_id, dso_id, symbol_id, sym_offset, ip, time, cpu, to_dso_id, to_symbol_id, to_sym_offset, to_ip, period, weight, transaction, data_src, branch_type, in_tx, call_path_id, insn_cnt, cyc_cnt, *x):
+def sample_table(sample_id, evsel_id, machine_id, thread_id, comm_id, dso_id, symbol_id, sym_offset, ip, time, cpu, to_dso_id, to_symbol_id, to_sym_offset, to_ip, period, weight, transaction, data_src, branch_type, in_tx, call_path_id, insn_cnt, cyc_cnt, flags, *x):
 	if branches:
-		value = struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiiiBiqiqiq", 20, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 4, branch_type, 1, in_tx, 8, call_path_id, 8, insn_cnt, 8, cyc_cnt)
+		value = struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiiiBiqiqiqii", 21, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 4, branch_type, 1, in_tx, 8, call_path_id, 8, insn_cnt, 8, cyc_cnt, 4, flags)
 	else:
-		value = struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiqiqiqiqiiiBiqiqiq", 24, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 8, period, 8, weight, 8, transaction, 8, data_src, 4, branch_type, 1, in_tx, 8, call_path_id, 8, insn_cnt, 8, cyc_cnt)
+		value = struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiqiqiqiqiiiBiqiqiqii", 25, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 8, period, 8, weight, 8, transaction, 8, data_src, 4, branch_type, 1, in_tx, 8, call_path_id, 8, insn_cnt, 8, cyc_cnt, 4, flags)
 	sample_file.write(value)
 
 def call_path_table(cp_id, parent_id, symbol_id, ip, *x):
-- 
2.25.1

