Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8080E58B387
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 05:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiHFDcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 23:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiHFDcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 23:32:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9719C11
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 20:32:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso9829636pjf.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 20:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tg4NqtSjU5XuVyDQiVNzVWf9P9SeByvm1yWNtEyxPVc=;
        b=fxgTY/Vjxw5wi7/JasXkvEFil2jV0OHHXJTvu2o7ec0Ho6BHNtW+E2EUsOKbf0bttA
         hmVmRa5NUSZJMpdRKaGH2Rk5vj36TkQs6xoJEiD++Nj2s6hW/eQPIVkJZEVyz6c+Ze+M
         pVz8+6bBZTB0xFcOiaCGFwyCk9CBMoMlFo+1CFkPBSplf8B49bKcjwH+yRjVqiiqfZ3N
         l8yU/zQPdi0+2k44KYpvDxE66e27tn5oB25bEyks/5lGKfwxVcirgK7Alz6KXt6p/qvd
         uOVFc4nkhY5wXmkrqyiT4IGmxeqyBgcJBQfOkYpB3Z+vbRYKTOUWmu+rZsTXRGeCMaTn
         OFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tg4NqtSjU5XuVyDQiVNzVWf9P9SeByvm1yWNtEyxPVc=;
        b=kwS7vFQE/ADSJvSQGK2kMZmg21ebbaHxgEA6+k2JOFKE1TP2xoRDiILvE5spiCI+De
         mPa8vZ779tWETZfytG/P3msjpCzXoyLYVBHY/JS31DaaDZVDI+wsH0imOKlWh+FPC50T
         1n9aB1FCXoOwK0hYgLcUimwnAZjl4L9e42Atk9+gNJmLV+M+nZJCAl+fCVpjIFI4paio
         itGFpTqt5RrG9PQQI/+qed0qgFlk7Q88kXpPb1RJSeWE3g2JI9riNzZZP8fe8khuPnGw
         Q1IzSkCdgnX5fo+pHKI0jqFlp/vR+Jp/4TeRTPdY8DelXIz2Q+TrbvMG23dPAQfRjbao
         zOIQ==
X-Gm-Message-State: ACgBeo2NRw1A7H/pUMnavFOVKs+8Lmz4Drk7Bize1SmgBKf3VbUNFJrZ
        1txA22iIpeQGKMIxyGTvOfVG4Q==
X-Google-Smtp-Source: AA6agR4M3DVrnATT7rSwbZDjb+owoi+595hWPep9TEfDL344GrMNcwwVGwVkUrASwgeEH9UqbNQ0Wg==
X-Received: by 2002:a17:902:d2c3:b0:16e:ea56:7840 with SMTP id n3-20020a170902d2c300b0016eea567840mr9535113plc.142.1659756759202;
        Fri, 05 Aug 2022 20:32:39 -0700 (PDT)
Received: from localhost (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id y2-20020aa793c2000000b0052d27ccea39sm3986012pff.19.2022.08.05.20.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 20:32:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] perf test: Introduce script for data symbol testing
Date:   Sat,  6 Aug 2022 11:32:34 +0800
Message-Id: <20220806033234.121781-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a shell script for data symbol testing.

The testing is designed a data structure with 64-byte alignment, it has
two fields "data1" and "data2", and other fields are reserved.

Using "perf mem" command, we can record and report memory samples for a
self-contained workload with 1 second duration.  If have no any memory
sample for the data structure "buf1", it reports failure;  and by
checking the offset in structure "buf1", if any memory accessing is not
for "data1" and "data2" fields, it means wrong data symbol parsing and
returns failure.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Changes from v1:
- Removed "killall" since the test has no child process (Ian);
- Used "char" instead of "long" in the buf structure.

 tools/perf/tests/shell/test_data_symbol.sh | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_data_symbol.sh

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
new file mode 100755
index 000000000000..d007513ecfbe
--- /dev/null
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -0,0 +1,92 @@
+#!/bin/bash
+# Test data symbol
+
+# SPDX-License-Identifier: GPL-2.0
+# Leo Yan <leo.yan@linaro.org>, 2022
+
+skip_if_no_mem_event() {
+	perf mem record -e list 2>&1 | egrep -q 'available' && return 0
+	return 2
+}
+
+skip_if_no_mem_event || exit 2
+
+# skip if there's no compiler
+if ! [ -x "$(command -v cc)" ]; then
+	echo "skip: no compiler, install gcc"
+	exit 2
+fi
+
+TEST_PROGRAM_SOURCE=$(mktemp /tmp/__perf_test.program.XXXXX.c)
+TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+check_result() {
+	# The memory report format is as below:
+	#    99.92%  ...  [.] buf1+0x38  ...
+	result=$(perf mem report -i ${PERF_DATA} --stdio 2>&1 | egrep "buf1" | \
+		awk '{ for (i = 1; i <= NF; i++) { if ($i ~ /^buf1/) { print $i; break; } } }')
+
+	# Testing is failed if has no any sample for "buf1"
+	[ -z "$result" ] && return 1
+
+	while IFS= read -r line; do
+		# The "data1" and "data2" fields in structure "buf1" have
+		# offset "0x0" and "0x38", returns failure if detect any
+		# other offset value.
+		if [ "$line" != "buf1+0x0" ] && [ "$line" != "buf1+0x38" ]; then
+			return 1
+		fi
+	done <<< "$result"
+
+	return 0
+}
+
+cleanup_files()
+{
+	echo "Cleaning up files..."
+	rm -f ${PERF_DATA}
+	rm -f ${TEST_PROGRAM_SOURCE}
+	rm -f ${TEST_PROGRAM}
+}
+
+trap cleanup_files exit term int
+
+# compile test program
+cat << EOF > $TEST_PROGRAM_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+typedef struct _buf {
+	char data1;
+	char reserved[55];
+	char data2;
+} buf __attribute__((aligned(64)));
+
+static buf buf1;
+
+int main() {
+	int i;
+	for (;;) {
+		buf1.data1++;
+		buf1.data2 += buf1.data1;
+	}
+	return 0;
+}
+EOF
+
+echo "Compiling test program..."
+cc $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
+
+echo "Recording workload..."
+perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
+PERFPID=$!
+
+sleep 1
+
+kill $PERFPID
+wait $PERFPID
+
+check_result
+exit $?
-- 
2.25.1

