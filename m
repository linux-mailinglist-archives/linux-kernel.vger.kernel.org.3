Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0221251D78F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391774AbiEFM3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391761AbiEFM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:29:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879165D66F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651839967; x=1683375967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rRbkAr1BIOzpeZas4yCHwVNVqZdJqraIQSO9bKjifNk=;
  b=dfdbt7SDCgsr+/MFGHwV4gmPxsB64KW9JlOwpJaw0VHO0KU4mHwZsTZA
   kC5TldTofNYSGoI480dRbPgbC5ye8wHE+VRgdwfQSMiNfk2heMGQYLrdm
   TWn2TBqtY2M3uFoNY0me2ik7UKdcsAb2Zl2bJaM2XNF6OcSKQToiKa9am
   uAOkqGcnjzVsUfPydjTB5UoPd85yxLzG2eeAE+gOlSt6PbzXMqTk42xdJ
   Op3WMY/ycVEl7nyqAvOOFdViunHDn836rnd6/ojwE8wFdfshXvPfzH+8Y
   hP3zgVALnu0P9txB61XluDFTblhrdS+P4W1Ud4qypQEK5SwtiXjqXBedQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045728"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045728"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440658"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:05 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/23] perf intel-pt: Add a test for system-wide side band
Date:   Fri,  6 May 2022 15:25:39 +0300
Message-Id: <20220506122601.367589-2-adrian.hunter@intel.com>
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

Add a test for system-wide side band even when tracing selected CPUs.

Tested-by: Ian Rogers <irogers@google.com>
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

