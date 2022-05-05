Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C160851C57D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382170AbiEERAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351619AbiEERAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:00:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A2A4E3A2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769805; x=1683305805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gidd+fKa1j+WmPIU8bQdjxMylZvp+S5jUstGmkaU0Bk=;
  b=jHOVWQdOZ8dqLTTd9yVi5lIjvDoYCvuKC8HF7zAgsSjOYCOulxCslnB/
   GNeKtoLU3vBmUmqy1QZegwaQEnRDNGAXUD0MLt/HmZU4Ldhv1lDshbQ/w
   GR6sDG1vDJfmrsecDgSIJuSgWHecX3kWyazVSZoDptMaX2evnFjEOZqPZ
   iO0sjjn4ktRZREc7IatTnCmLQXMlv0DcZbDsjFvIhPAUgzZWna3ZyXb50
   CypXEGhwlsrbXe/gsPVIEAPsj9dAYUgWpzSHYJF+3P0hqvpX4Co2kZmvu
   bcScHm/Ct6WXZERl5NKNd4MxlGWsqB7c4r9XV19ZH3zARwfvXH5vHe3Wk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248717802"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248717802"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032718"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:56:42 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 01/23] perf intel-pt: Add a test for system-wide side band
Date:   Thu,  5 May 2022 19:56:17 +0300
Message-Id: <20220505165639.361733-2-adrian.hunter@intel.com>
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

Add a test for system-wide side band even when tracing selected CPUs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 71 +++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_intel_pt.sh

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
new file mode 100755
index 000000000000..a3298643884d
--- /dev/null
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+# Miscellaneous Intel PT testing
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# Skip if no Intel PT
+perf list | grep -q 'intel_pt//' || exit 2
+
+skip_cnt=0
+ok_cnt=0
+err_cnt=0
+
+tmpfile=`mktemp`
+perfdatafile=`mktemp`
+
+can_cpu_wide()
+{
+	perf record -o ${tmpfile} -B -N --no-bpf-event -e dummy:u -C $1 true 2>&1 >/dev/null || return 2
+	return 0
+}
+
+test_system_wide_side_band()
+{
+	# Need CPU 0 and CPU 1
+	can_cpu_wide 0 || return $?
+	can_cpu_wide 1 || return $?
+
+	# Record on CPU 0 a task running on CPU 1
+	perf record -B -N --no-bpf-event -o ${perfdatafile} -e intel_pt//u -C 0 -- taskset --cpu-list 1 uname
+
+	# Should get MMAP events from CPU 1 because they can be needed to decode
+	mmap_cnt=`perf script -i ${perfdatafile} --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`
+
+	if [ ${mmap_cnt} -gt 0 ] ; then
+		return 0
+	fi
+
+	echo "Failed to record MMAP events on CPU 1 when tracing CPU 0"
+	return 1
+}
+
+count_result()
+{
+	if [ $1 -eq 2 ] ; then
+		skip_cnt=`expr ${skip_cnt} \+ 1`
+		return
+	fi
+	if [ $1 -eq 0 ] ; then
+		ok_cnt=`expr ${ok_cnt} \+ 1`
+		return
+	fi
+	err_cnt=`expr ${err_cnt} \+ 1`
+}
+
+test_system_wide_side_band
+
+count_result $?
+
+rm -f ${tmpfile}
+rm -f ${perfdatafile}
+
+if [ ${err_cnt} -gt 0 ] ; then
+	exit 1
+fi
+
+if [ ${ok_cnt} -gt 0 ] ; then
+	exit 0
+fi
+
+exit 2
-- 
2.25.1

