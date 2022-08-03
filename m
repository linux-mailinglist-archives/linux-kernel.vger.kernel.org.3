Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70327588F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiHCPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiHCPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:07:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC32FFFB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:07:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z19so16668436plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 08:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZdPufNv7yDerMaHu8UNrCkIxv3ZM8aDx+A/G4DitU4=;
        b=tp2cehirVs+zbOm4bECh3bmIak37aqyRWHWgLwJFExkKI2U0zKMJmrAbjAQv4m47Uj
         GNgAHydYek1KfP8swkal+yD4MQ+82UftMf2ZcNQI9xvggLW8wRlaGVHDXQHOkNBOWm1y
         msef2A0yL1Ca75GxQKifzuFS7kxDhVGAMczjzHdBUJ5tQN3IhkIpV+iqVdTc0ofcXO/I
         G1F0AOFTsy+EhP4DbhR4eV+NdeTsg1PsDpH1oQ7tqMVt0J0RYC5CJLwIG0U49I4Uo++N
         CFgM2QZMKjCLJnQBYFLMWQbL434ZgFOKloH3K5jip8lceI7ECuedYsXXMmGkTSGULXB0
         gFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZdPufNv7yDerMaHu8UNrCkIxv3ZM8aDx+A/G4DitU4=;
        b=6LgwPzsrmPlIxZ2cAn6+Xp9zDFo4z/mPtfkSQBBJouO5QuAaSNd8igF2xCjI376m5G
         A8qldS0Tyx7cItwH0bHPUkvZy+kHPCjq7Y/n+NxZrbCMh5suYKBaVvLC5x2BFk6ne/6l
         3LKabd5lNyy1MY1LDz3fU9tPLHMVwIvI7VqyrOwQwGMIyYTcWIGko3yOxChV12lRjegP
         9xHCf2icakrp1NlijY1YyzNDcCO7uOr/aqTdwXwLpiOqb9QCWLShIyPNZE3AKJflGdGi
         AvRm3AWaHvxlKXRh1R1kG4MaEZOlNhxLE7bF7yYjioUhbdUIN/+R2S6KHqhFMCTEavyr
         GGRg==
X-Gm-Message-State: ACgBeo3Kk9xFUdl9BINRXWdrpP91rPVbzcPFvH99l1i4ylZnVaWXhk8x
        PdRd99p+MsxuUFXxH1pL4rYDxw==
X-Google-Smtp-Source: AA6agR7Gw7PLtGUqnDN56Gwqyo3f9eGti/0N0xixgqRO0/uYfAlrhLdMJk7dH4o8RNHv3sB19rrB4Q==
X-Received: by 2002:a17:90a:e295:b0:1f3:2ddb:9c53 with SMTP id d21-20020a17090ae29500b001f32ddb9c53mr5319858pjz.129.1659539271878;
        Wed, 03 Aug 2022 08:07:51 -0700 (PDT)
Received: from localhost (ec2-13-57-253-244.us-west-1.compute.amazonaws.com. [13.57.253.244])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090a064100b001f218ddd5e2sm1694029pje.32.2022.08.03.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:07:51 -0700 (PDT)
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
Subject: [PATCH v1] perf test: Introduce script for data symbol parsing
Date:   Wed,  3 Aug 2022 23:07:44 +0800
Message-Id: <20220803150744.133128-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a shell script for data symbol parsing.

The testing is designed a data structure with 64-byte alignment, and it
has two fields "data1" and "data2", and other fields are reserved.

Using "perf mem" command, it records and reports memory samples for a
workload with 1 second duration.  If have no any memory sample for the
data structure "buf1", it reports failure;  and any memory accessing for
the data structure is not for "data1" and "data2" filed, it also means
the wrong data symbol parsing and returns failure.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/test_data_symbol.sh | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_data_symbol.sh

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
new file mode 100755
index 000000000000..7039dae4e087
--- /dev/null
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -0,0 +1,94 @@
+#!/bin/bash
+# Check perf data symbol parsing
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
+	long data1;
+	long reserved[6];
+	long data2;
+} buf __attribute__((aligned (64)));
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
+# test program may leave an orphan process running the workload
+killall $(basename $TEST_PROGRAM)
+
+check_result "$variable_name"
+exit $?
-- 
2.25.1

