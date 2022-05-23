Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9C053144C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiEWOuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiEWOuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:50:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C169580D0;
        Mon, 23 May 2022 07:50:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9C9F139F;
        Mon, 23 May 2022 07:50:05 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 256233F70D;
        Mon, 23 May 2022 07:50:04 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     james.clark@arm.com, leo.yan@linaro.org,
        German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH 1/1] perf test cs-etm: Add end-to-end tests for CoreSight decoding
Date:   Mon, 23 May 2022 15:49:52 +0100
Message-Id: <20220523144952.364370-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523144952.364370-1-german.gomez@arm.com>
References: <20220523144952.364370-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a shell script to test for regressions in the decoding of CoreSight
samples. The test uses supporting files which are not committed to the
linux repository. Instead they are downloaded from an external source:

[1] perf.data
[2] perf.data.inject
[3] perf.data.tar.bz2

File [1] is an example recording of a CoreSight trace. File [2] is the
output of running perf-inject on file [1] (i.e. the expected samples).
Lastly file [3] are the contents of the "~/.debug" directory.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/tests/shell/lib/arm_auxtrace.sh    | 21 +++++++
 .../tests/shell/test_arm_coresight_decoder.sh | 57 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/arm_auxtrace.sh
 create mode 100755 tools/perf/tests/shell/test_arm_coresight_decoder.sh

diff --git a/tools/perf/tests/shell/lib/arm_auxtrace.sh b/tools/perf/tests/shell/lib/arm_auxtrace.sh
new file mode 100644
index 0000000000000..5e117c33a4c98
--- /dev/null
+++ b/tools/perf/tests/shell/lib/arm_auxtrace.sh
@@ -0,0 +1,21 @@
+# TODO(german):
+#	This is a palceholder location, where the test data will/would reside.
+#	We need to find a suitable location to host the perf.data files used for testing
+GITHUB_REPO=https://github.com/ARM-software/data/raw/984cde8fb0bb22591e284826a80b338bb79c3655/perf/
+
+# download test files to the current working directory:
+# 	perf.data         (perf.data that contains auxtrace test data)
+# 	perf.data.inject  (output of perf inject -i perf.data)
+# 	perf.data.tar.bz2 (output of perf archive)
+arm_download_auxtrace_test_files() {
+	local data="$GITHUB_REPO/$1/perf.data"
+	local data_inject="$GITHUB_REPO/$1/perf.data.inject"
+	local data_debug="$GITHUB_REPO/$1/perf.data.tar.bz2"
+
+	# skip the test if the download fails for whetever reason
+	timeout 30 curl -LSs --fail "$data"		> perf.data		|| exit 2
+	timeout 30 curl -LSs --fail "$data_inject"	> perf.data.inject	|| exit 2
+	timeout 30 curl -LSs --fail "$data_debug"	> perf.data.tar.bz2	|| exit 2
+}
+
+export arm_download_auxtrace_test_files
diff --git a/tools/perf/tests/shell/test_arm_coresight_decoder.sh b/tools/perf/tests/shell/test_arm_coresight_decoder.sh
new file mode 100755
index 0000000000000..342a6bc70428f
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_coresight_decoder.sh
@@ -0,0 +1,57 @@
+#!/bin/bash
+# e2e test Arm CoreSight decoding
+
+# SPDX-License-Identifier: GPL-2.0
+# German Gomez <german.gomez@arm.com>, 2022
+
+set -e
+source $(dirname $0)/lib/arm_auxtrace.sh
+TEMP_DIR=$(mktemp -d)
+
+cleanup_files() {
+	rm -rf ${TEMP_DIR}
+}
+
+trap cleanup_files exit term int
+
+# This test compares the perf-script outputs of the files perf.data and perf.data.inject.
+# The former contains AUXTRACE events. The later contains the expected SAMPLE events.
+test_decoding() {
+	echo "Testing $1..."
+
+	cd $TEMP_DIR
+
+	arm_download_auxtrace_test_files "$1"
+
+	# unpack debug directory
+	rm -rf ~/.debug
+	mkdir ~/.debug
+	tar xf perf.data.tar.bz2 -C ~/.debug
+
+	perf script -i perf.data	$3 $2	| tr -s " " > perf.data.script
+	perf script -i perf.data.inject	$3	| tr -s " " > perf.data.inject.script
+
+	# Fail the test if there are any differences in the generated samples.
+	diff perf.data.script perf.data.inject.script > /dev/null
+}
+
+test_coresight() { 
+	# test only if perf has OpenCSD support
+	if ! ldd perf | grep -q "opencsd"
+	then
+		echo "[Skipped: missing OpenCSD support]"
+		return
+	fi
+
+	# the "--itrace" params must match the ones used to generate perf.data.inject files
+
+	test_decoding "coresight/sort_single_thread"		\
+		      "--itrace=i10ib"				\
+		      "--fields hw:cpu,pid,tid,ip,dso,addr,comm,event"
+
+	test_decoding "coresight/sort_multi_thread"		\
+		      "--itrace=i100ib"				\
+		      "--fields hw:cpu,pid,tid,ip,dso,addr,comm,event"
+}
+
+test_coresight
-- 
2.25.1

