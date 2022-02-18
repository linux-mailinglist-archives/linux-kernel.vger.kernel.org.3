Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77F44BB815
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiBRLac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:30:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiBRLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:30:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9632A2AF93C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645183814; x=1676719814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KGo8lcJ4F56kenYAwLaTbI82s91drMBP5GcCwMezJx8=;
  b=A/PiPf+EIvZffJNRgRcKqWOSvOERH03meykXbNTaq4IPLyRkgPkwjdOh
   6LhODio+tx/Cy6BzIcjyI0V6hxx8sq2WBTFM27DxNrpmhyG14V+6If0D9
   MGFuwY5ZWb3wCL2uKHmf9GPBeR+VXiBYZJSxQe7fK8lizXyAGX+akzaag
   dTSAlK4QpCr9BjeWuVSHk3fCparaGm5lRWeImFPnY4sZmdXKHuSJW/8dv
   25hIiDQUxRNGTjauhrgCrC8CSYG6/6XeTfY1Z7JHT+0MzBdIYEHKNOFQk
   2uqTzzjhFLZ887aRJkfW0kEVZC9aegw6woZbTO8WAXyi8G8bpMEyC7UEg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="337553335"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="337553335"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 03:30:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="775265393"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga006.fm.intel.com with ESMTP; 18 Feb 2022 03:30:10 -0800
From:   Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH] perf data: Fix double free in perf_session__delete
Date:   Fri, 18 Feb 2022 14:30:08 +0300
Message-Id: <20220218113008.24416-1-alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf_data__create_dir fails, it calls close_dir, but
perf_session__delete also calls close_dir and since dir.version and
dir.nr was initialized by perf_data__create_dir, a double free occurs.
This patch moves the initialization of dir.version and dir.nr after
successful initialization of dir.files, that prevents double freeing.
This behavior is already implemented in perf_data__open_dir. The patch
also adds a missing error message in case data directory creation fails.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 4 +++-
 tools/perf/util/data.c      | 7 +++----
 2 files changed, 6 insertions(+), 5 deletions(-)

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
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index f5d260b1df4d..15a4547d608e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -44,10 +44,6 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	if (!files)
 		return -ENOMEM;
 
-	data->dir.version = PERF_DIR_VERSION;
-	data->dir.files   = files;
-	data->dir.nr      = nr;
-
 	for (i = 0; i < nr; i++) {
 		struct perf_data_file *file = &files[i];
 
@@ -62,6 +58,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 		file->fd = ret;
 	}
 
+	data->dir.version = PERF_DIR_VERSION;
+	data->dir.files   = files;
+	data->dir.nr      = nr;
 	return 0;
 
 out_err:
-- 
2.19.0

