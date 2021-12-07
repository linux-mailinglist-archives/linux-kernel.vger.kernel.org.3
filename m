Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81B946C259
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhLGSLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:11:00 -0500
Received: from foss.arm.com ([217.140.110.172]:38028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240384AbhLGSK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:10:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDC9F13A1;
        Tue,  7 Dec 2021 10:07:27 -0800 (PST)
Received: from e127744.cambridge.arm.com (e127744.cambridge.arm.com [10.1.37.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A8D33F73B;
        Tue,  7 Dec 2021 10:07:23 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
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
Subject: [PATCH v2 2/3] perf tools: Rename perf_event_arm_regs for ARM64 registers
Date:   Tue,  7 Dec 2021 18:06:51 +0000
Message-Id: <20211207180653.1147374-3-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207180653.1147374-1-german.gomez@arm.com>
References: <20211207180653.1147374-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The registers for ARM and ARM64 are enumerated using two enums that have
the same name. In order to be able to import both headers, the name of
one can be replaced using the C preprocessor like so:

  #define perf_event_arm_regs perf_event_arm64_regs
  #include <asm/perf_regs.h>
  #undef perf_event_arm_regs

This patch updates all imports of ARM64's perf_regs.h in order to
prevent the naming collision.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/arch/arm64/include/perf_regs.h | 2 ++
 tools/perf/util/libunwind/arm64.c         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
index fa3e07459..1f0d78b9f 100644
--- a/tools/perf/arch/arm64/include/perf_regs.h
+++ b/tools/perf/arch/arm64/include/perf_regs.h
@@ -4,7 +4,9 @@
 
 #include <stdlib.h>
 #include <linux/types.h>
+#define perf_event_arm_regs perf_event_arm64_regs
 #include <asm/perf_regs.h>
+#undef perf_event_arm_regs
 
 void perf_regs_load(u64 *regs);
 
diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
index c397be0c2..15f60fd09 100644
--- a/tools/perf/util/libunwind/arm64.c
+++ b/tools/perf/util/libunwind/arm64.c
@@ -23,7 +23,9 @@
 
 #include "unwind.h"
 #include "libunwind-aarch64.h"
+#define perf_event_arm_regs perf_event_arm64_regs
 #include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
+#undef perf_event_arm_regs
 #include "../../arch/arm64/util/unwind-libunwind.c"
 
 /* NO_LIBUNWIND_DEBUG_FRAME is a feature flag for local libunwind,
-- 
2.25.1

