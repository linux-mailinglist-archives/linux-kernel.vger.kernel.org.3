Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB68151C58B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382393AbiEERBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382356AbiEERBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2425D19C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769859; x=1683305859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3ZSVX63/s5yaZQxGEWHbqwz2MM9wxr6WnJ4e9be/eY=;
  b=jPtrZus0s55VAjr3dqgkA42KotgqkWGYGzVg8v/tMCBbX56PC31/fAxC
   oL9GIXxMWpuKbHtoM543C9eGERw4P98kiZ5oHLKzKBa63MEHyR33LlQtP
   ACmQ3ElQZTnHKRic8kcEezpnVLjOOWKRY7SpZ/xZuwVdQVqzL8brwXjfr
   ZnKagHGXn5cyAE4Q++eN/f8hASzsIG21YBICGmyeo70+TwhzAalQ7tDfl
   mxmeba+AEopp88SNLRhU9rAhe9ncFNj6RpiIC3B1tGVJJQ3SI2K0ab6ep
   uBLMUf3U8tLPfQIIz5xqORBNSByErj8TZBOrSiJKcjUyZOSnjSvT0Iw1A
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248718089"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248718089"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032872"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:57:11 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 12/23] perf evlist: Factor out evlist__dummy_event()
Date:   Thu,  5 May 2022 19:56:28 +0300
Message-Id: <20220505165639.361733-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505165639.361733-1-adrian.hunter@intel.com>
References: <20220505165639.361733-1-adrian.hunter@intel.com>
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

Factor out evlist__dummy_event() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evlist.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 25eae096bdac..78c47cbafbc2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -242,14 +242,20 @@ int __evlist__add_default(struct evlist *evlist, bool precise)
 	return 0;
 }
 
-int evlist__add_dummy(struct evlist *evlist)
+static struct evsel *evlist__dummy_event(struct evlist *evlist)
 {
 	struct perf_event_attr attr = {
 		.type	= PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
 	};
-	struct evsel *evsel = evsel__new_idx(&attr, evlist->core.nr_entries);
+
+	return evsel__new_idx(&attr, evlist->core.nr_entries);
+}
+
+int evlist__add_dummy(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__dummy_event(evlist);
 
 	if (evsel == NULL)
 		return -ENOMEM;
-- 
2.25.1

