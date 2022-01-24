Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E8A497A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiAXInz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:62668 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242424AbiAXInr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013827; x=1674549827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wuSr8gsqw7dsz4rThO8aX99+YLV64Z6bw2AGjlT33GM=;
  b=PYunpwSrMsQGBiK/pgeVV9W6NWZ4lj3hAYiWV9EZxK7w9AC828mCGxKZ
   4PCgNhnQH4uWV2igCZfhpAW7su8NZCZ04pywsC4sZ9OniqOruiLP8sgGA
   3qaGKBvP5eihrfxZxVyi/+vvRe1Srjp3o58nPXx9ukkv2GSYiztzwaHEZ
   WMNzm0gVfxM4+e6TwAvEvMm9EHL2utifRE8R6qBGfbwUcJ5TYPsio/zXl
   4qbSXARaaWrDcGL+sJGqyIDisuCaMBh0A603VpVH5M9GqK3m1RM8CXQC1
   oTpCqCujfVHoNXKMuJVyqf73D+Yr4t+NTgE5oOOsiBjMkLhnK08/k0dKV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778512"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778512"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417293"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:54 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 23/25] perf scripts python: export-to-sqlite.py: Export all sample flags
Date:   Mon, 24 Jan 2022 10:41:59 +0200
Message-Id: <20220124084201.2699795-24-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sample flags to the SQLite database definition and export.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 8043a7272a56..73c992feb1b9 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -223,7 +223,8 @@ if branches:
 		'in_tx		boolean,'
 		'call_path_id	bigint,'
 		'insn_count	bigint,'
-		'cyc_count	bigint)')
+		'cyc_count	bigint,'
+		'flags		integer)')
 else:
 	do_query(query, 'CREATE TABLE samples ('
 		'id		integer		NOT NULL	PRIMARY KEY,'
@@ -249,7 +250,8 @@ else:
 		'in_tx		boolean,'
 		'call_path_id	bigint,'
 		'insn_count	bigint,'
-		'cyc_count	bigint)')
+		'cyc_count	bigint,'
+		'flags		integer)')
 
 if perf_db_export_calls or perf_db_export_callchains:
 	do_query(query, 'CREATE TABLE call_paths ('
@@ -442,7 +444,8 @@ do_query(query, 'CREATE VIEW samples_view AS '
 		'in_tx,'
 		'insn_count,'
 		'cyc_count,'
-		'CASE WHEN cyc_count=0 THEN CAST(0 AS FLOAT) ELSE ROUND(CAST(insn_count AS FLOAT) / cyc_count, 2) END AS IPC'
+		'CASE WHEN cyc_count=0 THEN CAST(0 AS FLOAT) ELSE ROUND(CAST(insn_count AS FLOAT) / cyc_count, 2) END AS IPC,'
+		'flags'
 	' FROM samples')
 
 do_query(query, 'CREATE VIEW ptwrite_view AS '
@@ -584,9 +587,9 @@ branch_type_query = QSqlQuery(db)
 branch_type_query.prepare("INSERT INTO branch_types VALUES (?, ?)")
 sample_query = QSqlQuery(db)
 if branches:
-	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
+	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 else:
-	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
+	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 if perf_db_export_calls or perf_db_export_callchains:
 	call_path_query = QSqlQuery(db)
 	call_path_query.prepare("INSERT INTO call_paths VALUES (?, ?, ?, ?)")
@@ -618,7 +621,7 @@ def trace_begin():
 	comm_table(0, "unknown", 0, 0, 0)
 	dso_table(0, 0, "unknown", "unknown", "")
 	symbol_table(0, 0, 0, 0, 0, "unknown")
-	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
+	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 	if perf_db_export_calls or perf_db_export_callchains:
 		call_path_table(0, 0, 0, 0)
 		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
@@ -703,11 +706,11 @@ def sample_table(*x):
 	if branches:
 		for xx in x[0:15]:
 			sample_query.addBindValue(str(xx))
-		for xx in x[19:24]:
+		for xx in x[19:25]:
 			sample_query.addBindValue(str(xx))
 		do_query_(sample_query)
 	else:
-		bind_exec(sample_query, 24, x)
+		bind_exec(sample_query, 25, x)
 
 def call_path_table(*x):
 	bind_exec(call_path_query, 4, x)
-- 
2.25.1

