Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1351246C257
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhLGSKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:10:53 -0500
Received: from foss.arm.com ([217.140.110.172]:38008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240374AbhLGSKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:10:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D3811FB;
        Tue,  7 Dec 2021 10:07:21 -0800 (PST)
Received: from e127744.cambridge.arm.com (e127744.cambridge.arm.com [10.1.37.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10E493F73B;
        Tue,  7 Dec 2021 10:07:17 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/3] perf tools: Prevent out-of-bounds access to registers
Date:   Tue,  7 Dec 2021 18:06:50 +0000
Message-Id: <20211207180653.1147374-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207180653.1147374-1-german.gomez@arm.com>
References: <20211207180653.1147374-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of the cache of register values is arch-dependant
(PERF_REGS_MAX). This has the potential of causing an out-of-bounds
access in the function "perf_reg_value" if the local architecture
contains less registers than the one the perf.data file was recorded on.

Since the maximum number of registers is bound by the bitmask "u64
cache_mask", and the size of the cache when running under x86 systems is
64 already, fix the size to 64 and add a range-check to the function
"perf_reg_value" to prevent out-of-bounds access.

Reported-by: Alexandre Truong <alexandre.truong@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/event.h     | 5 ++++-
 tools/perf/util/perf_regs.c | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 95ffed663..c59331eea 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -44,13 +44,16 @@ struct perf_event_attr;
 /* perf sample has 16 bits size limit */
 #define PERF_SAMPLE_MAX_SIZE (1 << 16)
 
+/* number of register is bound by the number of bits in regs_dump::mask (64) */
+#define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
+
 struct regs_dump {
 	u64 abi;
 	u64 mask;
 	u64 *regs;
 
 	/* Cached values/mask filled by first register access. */
-	u64 cache_regs[PERF_REGS_MAX];
+	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
 	u64 cache_mask;
 };
 
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 5ee47ae15..06a7461ba 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -25,6 +25,9 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
 	int i, idx = 0;
 	u64 mask = regs->mask;
 
+	if ((u64)id >= PERF_SAMPLE_REGS_CACHE_SIZE)
+		return -EINVAL;
+
 	if (regs->cache_mask & (1ULL << id))
 		goto out;
 
-- 
2.25.1

