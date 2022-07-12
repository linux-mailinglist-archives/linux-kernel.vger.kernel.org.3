Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B59571BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiGLN7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiGLN66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:58:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9E93BE30;
        Tue, 12 Jul 2022 06:58:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9499C1AC1;
        Tue, 12 Jul 2022 06:58:39 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.72.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051763F73D;
        Tue, 12 Jul 2022 06:58:37 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH 12/14] perf test: Add unroll thread test shell script
Date:   Tue, 12 Jul 2022 14:57:48 +0100
Message-Id: <20220712135750.2212005-13-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
References: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
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

This adds scripts to drive the unroll thread tests to compare perf
output against a minimum bar of content/quality.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 .../shell/coresight/unroll_loop_thread_10.sh   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh

diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
new file mode 100755
index 000000000000..f48c85230b15
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# CoreSight / Unroll Loop Thread 10
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="unroll_loop_thread"
+. $(dirname $0)/../lib/coresight.sh
+ARGS="10"
+DATV="10"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 10 10 10
+
+err=$?
+exit $err
-- 
2.32.0

