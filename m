Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8711250BCE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445278AbiDVQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389635AbiDVQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2E4C5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644692; x=1682180692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3ZSVX63/s5yaZQxGEWHbqwz2MM9wxr6WnJ4e9be/eY=;
  b=LMKjjSOxZn40p8IC+WmW8t7/1UruEK7K1J7cONdyFMmFtSl1ey3oSrML
   0bBTzH4QLn45v+IGLA7nc/LwULt3IQ9/CUVIr7aG7ifmPuzYorUZS43WT
   Wx3Bj/K3R7EJpgOcfsATVoe/TrknFmqe2QhVdnF7SVFYgtu7lUtm6gSVe
   vrE1nxilnISuQBF2tJJF2OqqApZnN4p2tvP6lBMF6njhyaQtKdhQt4RXv
   SlWGYSmyjY0++upASuPHSMRTv7W1g16pYUVO64HqImdzWrSvqgQKBMgrl
   Rwt3beU2RHXTPvmxhvysF8NHZHENw/IjkWz6TayH3J2Mms3i6mZUJ6Yx1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885968"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885968"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978880"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 12/21] perf evlist: Factor out evlist__dummy_event()
Date:   Fri, 22 Apr 2022 19:23:53 +0300
Message-Id: <20220422162402.147958-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422162402.147958-1-adrian.hunter@intel.com>
References: <20220422162402.147958-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

