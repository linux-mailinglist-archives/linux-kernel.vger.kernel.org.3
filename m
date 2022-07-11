Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41887563335
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiGAMJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiGAMJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:09:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F15671BE1;
        Fri,  1 Jul 2022 05:09:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A1A1113E;
        Fri,  1 Jul 2022 05:09:02 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.71.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DB223F792;
        Fri,  1 Jul 2022 05:09:00 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH 02/14] perf test: Add CoreSight shell lib shared code for future tests
Date:   Fri,  1 Jul 2022 13:07:51 +0100
Message-Id: <20220701120804.3226396-3-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
References: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
Reply-To: carsten.haitzler@foss.arm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>

This adds a library of shell "code" to be shared and used by future
tests that target quality testing for Arm CoreSight support in perf
and the Linux kernel.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/shell/lib/coresight.sh | 122 ++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/coresight.sh

diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
new file mode 100644
index 000000000000..1d6c90c3b8c1
--- /dev/null
+++ b/tools/perf/tests/shell/lib/coresight.sh
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+# This is sourced from a driver script so no need for #!/bin... etc. at the
+# top - the assumption below is that it runs as part of sourcing after the
+# test sets up some basic env vars to say what it is.
+
+# perf record options for the perf tests to use
+PERFRECMEM="-m ,16M"
+PERFRECOPT="$PERFRECMEM -e cs_etm//u"
+
+TOOLS=$(dirname $0)
+DIR="$TOOLS/$TEST"
+BIN="$DIR/$TEST"
+# If the test tool/binary does not exist and is executable then skip the test
+if ! test -x "$BIN"; then exit 2; fi
+DATD="."
+# If the data dir env is set then make the data dir use that instead of ./
+if test -n "$PERF_TEST_CORESIGHT_DATADIR"; then
+	DATD="$PERF_TEST_CORESIGHT_DATADIR";
+fi
+# If the stat dir env is set then make the data dir use that instead of ./
+STATD="."
+if test -n "$PERF_TEST_CORESIGHT_STATDIR"; then
+	STATD="$PERF_TEST_CORESIGHT_STATDIR";
+fi
+
+# Called if the test fails - error code 2
+err() {
+	echo "$1"
+	exit 1
+}
+
+# Check that some statistics from our perf
+check_val_min() {
+	STATF="$4"
+	if test "$2" -lt "$3"; then
+		echo ", FAILED" >> "$STATF"
+		err "Sanity check number of $1 is too low ($2 < $3)"
+	fi
+}
+
+perf_dump_aux_verify() {
+	# Some basic checking that the AUX chunk contains some sensible data
+	# to see that we are recording something and at least a minimum
+	# amount of it. We should almost always see F3 atoms in just about
+	# anything but certainly we will see some trace info and async atom
+	# chunks.
+	DUMP="$DATD/perf-tmp-aux-dump.txt"
+	perf report --stdio --dump -i "$1" | \
+		grep -o -e I_ATOM_F3 -e I_ASYNC -e I_TRACE_INFO > "$DUMP"
+	# Simply count how many of these atoms we find to see that we are
+	# producing a reasonable amount of data - exact checks are not sane
+	# as this is a lossy  process where we may lose some blocks and the
+	# compiler may produce different code depending on the compiler and
+	# optimization options, so this is rough  just to see if we're
+	# either missing almost all the data or all of it
+	ATOM_F3_NUM=`grep I_ATOM_F3 "$DUMP" | wc -l`
+	ATOM_ASYNC_NUM=`grep I_ASYNC "$DUMP" | wc -l`
+	ATOM_TRACE_INFO_NUM=`grep I_TRACE_INFO "$DUMP" | wc -l`
+	rm -f "$DUMP"
+
+	# Arguments provide minimums for a pass
+	CHECK_F3_MIN="$2"
+	CHECK_ASYNC_MIN="$3"
+	CHECK_TRACE_INFO_MIN="$4"
+
+	# Write out statistics, so over time you can track results to see if
+	# there is a pattern - for example we have less "noisy" results that
+	# produce more consistent amounts of data each run, to see if over
+	# time any techinques to  minimize data loss are having an effect or
+	# not
+	STATF="$STATD/stats-$TEST-$DATV.csv"
+	if ! test -f "$STATF"; then
+		echo "ATOM F3 Count, Minimum, ATOM ASYNC Count, Minimum, TRACE INFO Count, Minimum" > "$STATF"
+	fi
+	echo -n "$ATOM_F3_NUM, $CHECK_F3_MIN, $ATOM_ASYNC_NUM, $CHECK_ASYNC_MIN, $ATOM_TRACE_INFO_NUM, $CHECK_TRACE_INFO_MIN" >> "$STATF"
+
+	# Actually check to see if we passed or failed.
+	check_val_min "ATOM_F3" "$ATOM_F3_NUM" "$CHECK_F3_MIN" "$STATF"
+	check_val_min "ASYNC" "$ATOM_ASYNC_NUM" "$CHECK_ASYNC_MIN" "$STATF"
+	check_val_min "TRACE_INFO" "$ATOM_TRACE_INFO_NUM" "$CHECK_TRACE_INFO_MIN" "$STATF"
+	echo ", Ok" >> "$STATF"
+}
+
+perf_dump_aux_tid_verify() {
+	# Specifically crafted test will produce a list of Tread ID's to
+	# stdout that need to be checked to  see that they have had trace
+	# info collected in AUX blocks in the perf data. This will go
+	# through all the TID's that are listed as CID=0xabcdef and see
+	# that all the Thread IDs the test tool reports are  in the perf
+	# data AUX chunks
+
+	# The TID test tools will print a TID per stdout line that are being
+	# tested
+	TIDS=`cat "$2"`
+	# Scan the perf report to find the TIDs that are actually CID in hex
+	# and build a list of the ones found
+	FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
+			grep -o "CID=0x[0-9a-z]\+" | sed 's/CID=//g' | \
+			uniq | sort | uniq`
+
+	# Iterate over the list of TIDs that the test says it has and find
+	# them in the TIDs found in the perf report
+	MISSING=""
+	for TID2 in $TIDS; do
+		FOUND=""
+		for TIDHEX in $FOUND_TIDS; do
+			TID=`printf "%i" $TIDHEX`
+			if test "$TID" -eq "$TID2"; then
+				FOUND="y"
+				break
+			fi
+		done
+		if test -z "$FOUND"; then
+			MISSING="$MISSING $TID"
+		fi
+	done
+	if test -n "$MISSING"; then
+		err "Thread IDs $MISSING not found in perf AUX data"
+	fi
+}
-- 
2.32.0

