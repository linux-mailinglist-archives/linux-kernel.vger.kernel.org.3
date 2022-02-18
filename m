Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678C84BBC09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiBRPYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:24:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiBRPYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:24:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13382B2C4F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645197825; x=1676733825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nkpL5GKev/ZvhnoE00/TgmFOGz/kd9fIkQQmYa6/KmE=;
  b=FELS3HT5s9DLmKZtN9iYmJBGgTubyEsBpYyOcXci9l/QCHVyMYrK4PgD
   Ot24hndEzJ1z/jAC6EwJoTOytcqw/q9mxeCBmFP/hYe8K6uQz+U1KRCvq
   uXeG5sXDh4W5Qqm5ybFDya1jezUEBhnD6ZtJTi0G9oeZvvj5CyBlkOXEv
   BZOWBv8Vy8nwC+T3DItiEGaWsD8acZ+fl2j7eS5CPChj8OfWPQcFlZYFl
   WpPKrWQwibuTZ3d3l11zL+kaxWZ9wTwT2nrfs/+HltdFQXnSBA+qbIpdH
   41FvBmiF0cDkS77Q2NbtUDiCTrn61gshvzal7AOCUuAUugls+k7DE2T0/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250900608"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="250900608"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 07:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="546317525"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2022 07:23:42 -0800
From:   Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH core] perf data: Adding error message if perf_data__create_dir fails
Date:   Fri, 18 Feb 2022 18:23:40 +0300
Message-Id: <20220218152341.5197-1-alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no notification about data directory creation failure. Add it.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0bc6529814b2..0306d5911de2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1186,8 +1186,10 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (record__threads_enabled(rec)) {
 		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
-		if (ret)
+		if (ret) {
+			pr_err("Failed to create data directory: %s\n", strerror(errno));
 			return ret;
+		}
 		for (i = 0; i < evlist->core.nr_mmaps; i++) {
 			if (evlist->mmap)
 				evlist->mmap[i].file = &rec->data.dir.files[i];
-- 
2.19.0

