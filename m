Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328F3546598
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349326AbiFJLdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiFJLdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:33:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0BB6D4CC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654860818; x=1686396818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NcnXb+DwGIBsEjgZbwiIKWIgHUj+IhZGk6fraGSrh4Y=;
  b=lAgmnUyskujTvt6jzVUSiDnhgbmBx2mt4lWrn7zJYb8Mf/BcDdwl8hcO
   Xbxb0/MG+cvAY5V8iDZzeq/eX7ANm84YuvKwnmBGYpChBN5jR/tEkzYFt
   I1g4h4Ba2UGzBbUs2sP+dL6h3HB73OhnZKbBI4ovZQ4fT7I0TOkX0P991
   iNfUJZiIK1Oo3wSfOHif39BZou5aunKDO6ba5+0BWWNLU8aFh61tEcm/X
   47sShVKdPOIKpQSqFPOjBgsMJApBabaYwqHo/YJRyCcqwtO2iRq4gcyRY
   ChDuUyZTh4pSFoFgFN44EcaYXRF/UYquOfh012hqlF/U8yQKqqhdczw9E
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="275134346"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="275134346"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="616446316"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:33:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] perf record: Always record id index
Date:   Fri, 10 Jun 2022 14:33:13 +0300
Message-Id: <20220610113316.6682-3-adrian.hunter@intel.com>
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

Adjust the logic so that if there are IDs then the id index is recorded.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c        | 12 +++++-------
 tools/perf/util/synthetic-events.c |  7 +++++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3959a1b86afb..00c2a6cdf1be 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1834,13 +1834,11 @@ static int record__synthesize(struct record *rec, bool tail)
 		goto out;
 
 	/* Synthesize id_index before auxtrace_info */
-	if (rec->opts.auxtrace_sample_mode || rec->opts.full_auxtrace) {
-		err = perf_event__synthesize_id_index(tool,
-						      process_synthesized_event,
-						      session->evlist, machine);
-		if (err)
-			goto out;
-	}
+	err = perf_event__synthesize_id_index(tool,
+					      process_synthesized_event,
+					      session->evlist, machine);
+	if (err)
+		goto out;
 
 	if (rec->opts.full_auxtrace) {
 		err = perf_event__synthesize_auxtrace_info(rec->itr, tool,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 27acdc5e5723..d75074486a55 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1719,14 +1719,17 @@ int perf_event__synthesize_id_index(struct perf_tool *tool, perf_event__handler_
 	size_t nr = 0, i = 0, sz, max_nr, n;
 	int err;
 
-	pr_debug2("Synthesizing id index\n");
-
 	max_nr = (UINT16_MAX - sizeof(struct perf_record_id_index)) /
 		 sizeof(struct id_index_entry);
 
 	evlist__for_each_entry(evlist, evsel)
 		nr += evsel->core.ids;
 
+	if (!nr)
+		return 0;
+
+	pr_debug2("Synthesizing id index\n");
+
 	n = nr > max_nr ? max_nr : nr;
 	sz = sizeof(struct perf_record_id_index) + n * sizeof(struct id_index_entry);
 	ev = zalloc(sz);
-- 
2.25.1

