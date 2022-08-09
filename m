Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7040F58D522
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiHIIH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiHIIHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:07:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9D11C106
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660032442; x=1691568442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SylMqoKOWrf2MW7OX48Aajomhu4Plo4sbDq0KYybMac=;
  b=kq2gSXatMKLj/rZYPOmrneKdo9A6c84vyA2EFGAr8znesErYgvhHTmuh
   DMF+8ItWXqsR+yuhKwEQZohlBjnlr3/N2J8UwhxMtlc6K/SC5cP/W1Ihy
   o/AWx1rM1A2GbKZfSy4eUZdl6sWPHxN7si3EFM9RfYNck8yrnGcsGo+bw
   pQA0Qgq9zkDXv5xkDrfsZSeRVt2pH0VHQ/L9BLgsNOV+AlScSnUvC8P5b
   016f59msgcfnDu0/hKDsNQetcHnlgfvp9ecgcTR64TOnG6Ixoq5KLRAHV
   Ueob+4W/EJ8VOFcoXHTwJkbGlU3Ze3eDyXbjUwo1FRRqN94GWRWsgJSR5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="289537546"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="289537546"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:07:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="633242852"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.48.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:07:19 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] perf parse-events: Fix segfault when event parser gets an error
Date:   Tue,  9 Aug 2022 11:07:00 +0300
Message-Id: <20220809080702.6921-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809080702.6921-1-adrian.hunter@intel.com>
References: <20220809080702.6921-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parse_events() is often called with parse_events_error set to NULL.
Make parse_events_error__handle() not segfault in that case.

A subsequent patch changes to avoid passing NULL in the first place.

Fixes: 43eb05d06679 ("perf tests: Support 'Track with sched_switch' test for hybrid")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/parse-events.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 206c76623c06..dfc7d7a0ec4e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2256,9 +2256,12 @@ void parse_events_error__exit(struct parse_events_error *err)
 void parse_events_error__handle(struct parse_events_error *err, int idx,
 				char *str, char *help)
 {
-	if (WARN(!str, "WARNING: failed to provide error string\n")) {
-		free(help);
-		return;
+	if (WARN(!str, "WARNING: failed to provide error string\n"))
+		goto out_free;
+	if (!err) {
+		/* Assume caller does not want message printed */
+		pr_debug("event syntax error: %s\n", str);
+		goto out_free;
 	}
 	switch (err->num_errors) {
 	case 0:
@@ -2284,6 +2287,11 @@ void parse_events_error__handle(struct parse_events_error *err, int idx,
 		break;
 	}
 	err->num_errors++;
+	return;
+
+out_free:
+	free(str);
+	free(help);
 }
 
 #define MAX_WIDTH 1000
-- 
2.25.1

