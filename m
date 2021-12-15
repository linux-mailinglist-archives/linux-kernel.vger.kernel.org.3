Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271BA475B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbhLOPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:12:24 -0500
Received: from foss.arm.com ([217.140.110.172]:54638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243811AbhLOPMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:12:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 310D01435;
        Wed, 15 Dec 2021 07:12:21 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 18F2B3F774;
        Wed, 15 Dec 2021 07:12:18 -0800 (PST)
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
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 5/6] perf tools: Refactor SMPL_REG macro in perf_regs.h
Date:   Wed, 15 Dec 2021 15:11:37 +0000
Message-Id: <20211215151139.40854-6-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215151139.40854-1-german.gomez@arm.com>
References: <20211215151139.40854-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the SAMPL_REG macro so that it can be used in a followup commit
to obtain the masks for ARM64 registers.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/perf_regs.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 4e6b1299c571..ce1127af05e4 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -11,8 +11,11 @@ struct sample_reg {
 	const char *name;
 	uint64_t mask;
 };
-#define SMPL_REG(n, b) { .name = #n, .mask = 1ULL << (b) }
-#define SMPL_REG2(n, b) { .name = #n, .mask = 3ULL << (b) }
+
+#define SMPL_REG_MASK(b) (1ULL << (b))
+#define SMPL_REG(n, b) { .name = #n, .mask = SMPL_REG_MASK(b) }
+#define SMPL_REG2_MASK(b) (3ULL << (b))
+#define SMPL_REG2(n, b) { .name = #n, .mask = SMPL_REG2_MASK(b) }
 #define SMPL_REG_END { .name = NULL }
 
 enum {
-- 
2.25.1

