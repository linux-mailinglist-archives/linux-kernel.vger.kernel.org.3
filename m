Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3254D534086
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbiEYPlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245209AbiEYPlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:41:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 567E32983F;
        Wed, 25 May 2022 08:41:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBEE71474;
        Wed, 25 May 2022 08:41:47 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.8.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61F953F73D;
        Wed, 25 May 2022 08:41:44 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     broonie@kernel.org, german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/5] perf tools: arm64: Use perf's copy of kernel headers
Date:   Wed, 25 May 2022 16:41:10 +0100
Message-Id: <20220525154114.718321-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220525154114.718321-1-james.clark@arm.com>
References: <20220525154114.718321-1-james.clark@arm.com>
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

Fix this include path to use perf's copy of the kernel header
rather than the one from the root of the repo.

This fixes build errors when only applying the perf tools
part of a patchset rather than both sides.

Reported-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/libunwind/arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
index 15f60fd09424..014d82159656 100644
--- a/tools/perf/util/libunwind/arm64.c
+++ b/tools/perf/util/libunwind/arm64.c
@@ -24,7 +24,7 @@
 #include "unwind.h"
 #include "libunwind-aarch64.h"
 #define perf_event_arm_regs perf_event_arm64_regs
-#include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
+#include <../../../arch/arm64/include/uapi/asm/perf_regs.h>
 #undef perf_event_arm_regs
 #include "../../arch/arm64/util/unwind-libunwind.c"
 
-- 
2.28.0

