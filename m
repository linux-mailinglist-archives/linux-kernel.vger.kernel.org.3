Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79F24BBC0A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiBRPYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:24:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbiBRPYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:24:06 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340B22B2C63
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645197828; x=1676733828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tys8vO5jpeQwCnqRIjfr24bGhzNHl5EH73fMc8XJTZA=;
  b=dr1soqJDNySDfeytT+SUSwi5p1nY7jmd8TmSc0L0WXZMGjpPrJsiRN0F
   6m13Yg/lWkZHYrHsZyYWx+mCi6Ininikv6nWOBpDXowZQOqZ9LrXbVKR7
   lGFrvm8BlNWFWzzU+TeqtAa/WN1SE0pRHzcweS+aSF/mELRte2AgPvv1f
   mNy5ct2bn8Q/Y/gwpxigJRK0lMHOV/IVXEzjcSaPeqCIQjYdC+bnLyHek
   AA9Tfvsh9WqiIe+fWHZAruWvxe1Bs3hXO+iOqNJh5xparMLcxUo7FNxYg
   E0U+MohkElsZFIY23rQGysyqjEfk+0oT98T7K9dKq0ZXBegxmOUI+Rh9F
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250900614"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="250900614"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 07:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="546317536"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2022 07:23:45 -0800
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
Subject: [PATCH urgent] perf data: Fix double free in perf_session__delete
Date:   Fri, 18 Feb 2022 18:23:41 +0300
Message-Id: <20220218152341.5197-2-alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20220218152341.5197-1-alexey.v.bayduraev@linux.intel.com>
References: <20220218152341.5197-1-alexey.v.bayduraev@linux.intel.com>
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

When perf_data__create_dir fails, it calls close_dir, but
perf_session__delete also calls close_dir and since dir.version and
dir.nr was initialized by perf_data__create_dir, a double free occurs.
This patch moves the initialization of dir.version and dir.nr after
successful initialization of dir.files, that prevents double freeing.
This behavior is already implemented in perf_data__open_dir.

Fixes: 145520631130bd64 ("perf data: Add perf_data__(create_dir|close_dir) functions")
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/data.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

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

