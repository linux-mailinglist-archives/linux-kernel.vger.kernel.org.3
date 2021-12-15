Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6DF475928
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbhLOMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:55:08 -0500
Received: from foss.arm.com ([217.140.110.172]:51220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242667AbhLOMzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:55:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DD27ED1;
        Wed, 15 Dec 2021 04:55:01 -0800 (PST)
Received: from e126387.extremechicken.org (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62DF43F774;
        Wed, 15 Dec 2021 04:55:00 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Subject: [PATCH 06/12] perf test: Add tests to re-use the thread loop test to check aux data
Date:   Wed, 15 Dec 2021 12:54:03 +0000
Message-Id: <20211215125409.61488-6-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
References: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

This checks to see that the thread_loop tests produces sensible
amounts of aux coresight data.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 .../tests/shell/coresight_thread_loop_2.sh     | 18 ++++++++++++++++++
 .../tests/shell/coresight_thread_loop_25.sh    | 18 ++++++++++++++++++
 .../tests/shell/coresight_thread_loop_250.sh   | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100755 tools/perf/tests/shell/coresight_thread_loop_2.sh
 create mode 100755 tools/perf/tests/shell/coresight_thread_loop_25.sh
 create mode 100755 tools/perf/tests/shell/coresight_thread_loop_250.sh

diff --git a/tools/perf/tests/shell/coresight_thread_loop_2.sh b/tools/perf/tests/shell/coresight_thread_loop_2.sh
new file mode 100755
index 000000000000..6d790b870a67
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_thread_loop_2.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Thread Loop 2 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="thread_loop"
+. $(dirname $0)/lib/coresight.sh
+ARGS="2 20"
+DATV="2th"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 724 11 11
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_thread_loop_25.sh b/tools/perf/tests/shell/coresight_thread_loop_25.sh
new file mode 100755
index 000000000000..cce74202e4db
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_thread_loop_25.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Thread Loop 25 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="thread_loop"
+. $(dirname $0)/lib/coresight.sh
+ARGS="25 2"
+DATV="25th"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 388121 1255 1255
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_thread_loop_250.sh b/tools/perf/tests/shell/coresight_thread_loop_250.sh
new file mode 100755
index 000000000000..55f271462a4d
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_thread_loop_250.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Thread Loop 250 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="thread_loop"
+. $(dirname $0)/lib/coresight.sh
+ARGS="250 1"
+DATV="250th"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 724 11 11
+
+err=$?
+exit $err
-- 
2.32.0

