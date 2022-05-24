Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F17532480
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiEXHzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiEXHzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE4994FB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378906; x=1684914906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aVe5Alf9ZT6tdqHH9037XewXVE8SDzq+3LR9QmuSdYQ=;
  b=BmZoMvIDulbDQK+rL/W2NCv9XUN+7rApcoX55WqHCYlEEmkaBpi87We1
   +oMKSfk41JExX+xeze85c5V42NQSp/LpOlKbKOU6+53QnNXRJ29+U0fkE
   9MAZclZs8jFjn5k9U8xik9iW12vlMH9dQEuuh+9reXsretJMEx2cOGVbh
   OBlsVAfqU3FUehoT6kNb4y77k+yR0gZgBroTuPRIwjz7RSg2ss+mpETFn
   uCaz8tFXIZN1lg5uIfbu9NcWhuIQIrOpeNZ/UgwgPTti9p5tTqRjPkotD
   HYJujA4jwvxkSSKCL3Z3598AKdowZpjxV6CBWU4/aBeFSFJ0+NIlLqUgn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455416"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455416"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072341"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 01/15] perf intel-pt: Add a test for system-wide side band
Date:   Tue, 24 May 2022 10:54:22 +0300
Message-Id: <20220524075436.29144-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524075436.29144-1-adrian.hunter@intel.com>
References: <20220524075436.29144-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for system-wide side band even when tracing selected CPUs.

The test fails before the patches up to "perf tools: Allow system-wide
events to keep their own CPUs" are applied, passes afterwards.

Tested-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

