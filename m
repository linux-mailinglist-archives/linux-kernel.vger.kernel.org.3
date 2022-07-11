Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C029456333D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiGAMJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiGAMJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:09:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB1177D1C5;
        Fri,  1 Jul 2022 05:09:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBBB1113E;
        Fri,  1 Jul 2022 05:09:13 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.71.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E57E3F792;
        Fri,  1 Jul 2022 05:09:12 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH 10/14] perf test: Add thread loop test shell scripts
Date:   Fri,  1 Jul 2022 13:07:59 +0100
Message-Id: <20220701120804.3226396-11-carsten.haitzler@foss.arm.com>
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

Add a script to drive the thread loop test that gathers data so
it passes a minimum bar (in this case do we get any perf context data
for every thread).

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 .../coresight/thread_loop_check_tid_10.sh     | 19 +++++++++++++++++++
 .../coresight/thread_loop_check_tid_2.sh      | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
 create mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh

diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
new file mode 100755
index 000000000000..7c13636fc778
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
@@ -0,0 +1,19 @@
+#!/bin/sh -e
+# CoreSight / Thread Loop 10 Threads - Check TID
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="thread_loop"
+. $(dirname $0)/../lib/coresight.sh
+ARGS="10 1"
+DATV="check-tid-10th"
+DATA="$DATD/perf-$TEST-$DATV.data"
+STDO="$DATD/perf-$TEST-$DATV.stdout"
+
+SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
+
+perf_dump_aux_tid_verify "$DATA" "$STDO"
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
new file mode 100755
index 000000000000..a067145af43c
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
@@ -0,0 +1,19 @@
+#!/bin/sh -e
+# CoreSight / Thread Loop 2 Threads - Check TID
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="thread_loop"
+. $(dirname $0)/../lib/coresight.sh
+ARGS="2 20"
+DATV="check-tid-2th"
+DATA="$DATD/perf-$TEST-$DATV.data"
+STDO="$DATD/perf-$TEST-$DATV.stdout"
+
+SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
+
+perf_dump_aux_tid_verify "$DATA" "$STDO"
+
+err=$?
+exit $err
-- 
2.32.0

