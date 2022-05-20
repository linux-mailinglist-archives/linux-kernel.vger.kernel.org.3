Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51E252ED0C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344015AbiETNYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349779AbiETNYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:24:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE551498C4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653053062; x=1684589062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U4srRq5yE5CT++6h1AC80Vn5y1NUKDalEuopQN1pxhA=;
  b=lIh8zbOYfpveYI2JcgGja+iJ70qqdsf8NIugKDFW+V8G9aXhSGPdzRiI
   4BZKhRFTPCGpVEkJA53FaeusLQENuvfe0eT7E+SHKBkQVjLnHemS63Kdt
   G4ktNtwN4/YmydNiBnEste0Y85Wi0sZtlWCZLSzQxAN9eKlaDBeGQc4R1
   w2m9BTUaVtrQRYREyluqOGQGetmSiFyisq56rMOON1rUyAGxrVz4czHKL
   9dOjTrIUp7aXEbjPW4zl7VAVZYufGtQoQHIT2BBRqnMWYGhj0iFh4O/Sy
   ZelV0ko5wfiTPWNPal9+PnXLwEkIAgjVjwXu2JmazHHvTtGR+vU6yKKgS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="335661013"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="335661013"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="715530812"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.124])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] libperf: Add preadn()
Date:   Fri, 20 May 2022 16:24:01 +0300
Message-Id: <20220520132404.25853-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520132404.25853-1-adrian.hunter@intel.com>
References: <20220520132404.25853-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add preadn() to provide pread() and readn() semantics.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/include/internal/lib.h |  2 ++
 tools/lib/perf/lib.c                  | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/lib/perf/include/internal/lib.h b/tools/lib/perf/include/internal/lib.h
index 5175d491b2d4..85471a4b900f 100644
--- a/tools/lib/perf/include/internal/lib.h
+++ b/tools/lib/perf/include/internal/lib.h
@@ -9,4 +9,6 @@ extern unsigned int page_size;
 ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
 
+ssize_t preadn(int fd, void *buf, size_t n, off_t offs);
+
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/lib/perf/lib.c b/tools/lib/perf/lib.c
index 18658931fc71..ecc8035a3ae3 100644
--- a/tools/lib/perf/lib.c
+++ b/tools/lib/perf/lib.c
@@ -38,6 +38,26 @@ ssize_t readn(int fd, void *buf, size_t n)
 	return ion(true, fd, buf, n);
 }
 
+ssize_t preadn(int fd, void *buf, size_t n, off_t offs)
+{
+	ssize_t ret;
+	off_t cur;
+
+	cur = lseek(fd, 0, SEEK_CUR);
+	if (cur < 0)
+		return -1;
+
+	if (lseek(fd, offs, SEEK_SET) < 0)
+		return -1;
+
+	ret = readn(fd, buf, n);
+
+	if (lseek(fd, cur, SEEK_CUR) < 0)
+		return -1;
+
+	return ret;
+}
+
 /*
  * Write exactly 'n' bytes or return an error.
  */
-- 
2.25.1

