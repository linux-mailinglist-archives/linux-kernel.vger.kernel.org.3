Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4B51382A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349013AbiD1PXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348684AbiD1PX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:23:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E27924BF7;
        Thu, 28 Apr 2022 08:20:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E92251474;
        Thu, 28 Apr 2022 08:20:10 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A70873F774;
        Thu, 28 Apr 2022 08:20:10 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     james.clark@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] perf tests: Fix coresight `perf test` failure.
Date:   Thu, 28 Apr 2022 10:19:47 -0500
Message-Id: <20220428151947.290146-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the `perf test` always fails the coresight test like:

89: Check Arm CoreSight trace data recording and synthesized samples: FAILED!

That is because the test_arm_coresight.sh is attempting to SIGINT the
parent but is using $$ rather than $PPID and it sigint's itself when
run under the perf test framework. Since this is done in a trap clause
it ends up returning a non zero return. Since $PPID is a bash ism and
not all distros are linking /bin/sh to bash, the alternative
parent pid lookups are uglier than just dropping the kill, and its
not strictly needed, lets pick the simple solution and drop the sigint.

Fixes: 133fe2e617e4 ("perf tests: Improve temp file cleanup in test_arm_coresight.sh")
Cc: James Clark <james.clark@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 6de53b7ef5ff..e4cb4f1806ff 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -29,7 +29,6 @@ cleanup_files()
 	rm -f ${file}
 	rm -f "${perfdata}.old"
 	trap - exit term int
-	kill -2 $$
 	exit $glb_err
 }
 
-- 
2.35.1

