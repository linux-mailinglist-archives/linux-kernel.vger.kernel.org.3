Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1102951D79E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391848AbiEFMav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391851AbiEFMaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:30:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC16928A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651839995; x=1683375995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tdoy23mMly4Ibperfn5sSaXEfcOXxc99ArGlk0Wgz3U=;
  b=Y10OoDhPz2GkSxC25uBqzRkAJZWddkUSaGjlMRvYWU+nju0g8D1ErRhQ
   gKOKAOBgNvncBuuyAL/fKQ5ybq428GaOzEAjTgV7tOTEcHQjLXCb2Yvod
   gKodXGYcEUv6L1hZPB0QXzNxt8BsxsttBXDkVd318ZufYKKtur6Op5IEH
   TtxSk35RQKGhefWosv9tsOs3drsERarFWXrJB6p9PQoT2WC1HP8XMQnEP
   1zg6Be6u57cDoQ0hEY988vssI9wLHwfaUVSkm0cQgZEbaBRURY+x5yRmY
   WhQEycXIcLY4Ht0Z7S/QzOO+TgAKN9mqUPF7En7Ieb2G5drkNEmS2qsuB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045818"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440927"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:33 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 12/23] perf evlist: Factor out evlist__dummy_event()
Date:   Fri,  6 May 2022 15:25:50 +0300
Message-Id: <20220506122601.367589-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506122601.367589-1-adrian.hunter@intel.com>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out evlist__dummy_event() so it can be reused.

Acked-by: Ian Rogers <irogers@google.com>
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

