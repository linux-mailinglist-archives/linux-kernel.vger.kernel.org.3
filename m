Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915964BF470
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiBVJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiBVJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:14:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65C4B2E37
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645521262; x=1677057262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pbF6h5/JRvB69EoY6dAw7sNIOxY/mjvl2exO4UXL1x0=;
  b=jqFkkoZ4LTY8/sXh7QYfuxO061lDYNSEjFPfPF2Ws5KGiq2rOd1m0gMO
   s24zyxizCp5bSE8TlJYxrSGDskZlFgF8cJ97iGcIrsC0qosp1viRHrjK/
   GAxujlxlDCha6KpjfyxaFJt++TDHCkj3kOuYTOcg9UnKWIwURD7ZNPTyl
   Vuuk6QaWdc2rsI8z4tEFtxJFiF3v52GXlPifjMsxr5wNiLRl66BrBggUX
   33ieMF9VgIx08L5C8kC5sV/gKlHeZrY7iB+pVhl9RzS/JYTFijiBDBQBN
   FE/cXVChHdGE3bfZxkWoyr6Tl4zVXng9ne1Jj62amZQ87wuiSGVsesNJi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251597897"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251597897"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 01:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="636936393"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2022 01:14:18 -0800
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
Subject: [PATCH core v2] perf data: Adding error message if perf_data__create_dir fails
Date:   Tue, 22 Feb 2022 12:14:17 +0300
Message-Id: <20220222091417.11020-1-alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding proper return codes for all cases of data directory creation
failure and adding error message output based on these codes.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 4 +++-
 tools/perf/util/data.c      | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0bc6529814b2..0b4abed555d8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1186,8 +1186,10 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (record__threads_enabled(rec)) {
 		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
-		if (ret)
+		if (ret) {
+			pr_err("Failed to create data directory: %s\n", strerror(-ret));
 			return ret;
+		}
 		for (i = 0; i < evlist->core.nr_mmaps; i++) {
 			if (evlist->mmap)
 				evlist->mmap[i].file = &rec->data.dir.files[i];
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index f5d260b1df4d..dc5d82ea1c30 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -52,12 +52,16 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 		struct perf_data_file *file = &files[i];
 
 		ret = asprintf(&file->path, "%s/data.%d", data->path, i);
-		if (ret < 0)
+		if (ret < 0) {
+			ret = -ENOMEM;
 			goto out_err;
+		}
 
 		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
-		if (ret < 0)
+		if (ret < 0) {
+			ret = -errno;
 			goto out_err;
+		}
 
 		file->fd = ret;
 	}
-- 
2.19.0

