Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2C14D93F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344976AbiCOFh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344953AbiCOFhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:37:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FF4E48E68;
        Mon, 14 Mar 2022 22:36:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59BBE1476;
        Mon, 14 Mar 2022 22:36:04 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.34.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A0673F766;
        Mon, 14 Mar 2022 22:35:58 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, acme@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 06/10] perf/tools: Add irq and exception return branch types
Date:   Tue, 15 Mar 2022 11:05:12 +0530
Message-Id: <20220315053516.431515-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315053516.431515-1-anshuman.khandual@arm.com>
References: <20220315053516.431515-1-anshuman.khandual@arm.com>
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

This updates the perf tool with generic branch type classification with two
new branch types i.e irq (PERF_BR_IRQ) and exception return (PERF_BR_ERET)
which got updated earlier in the kernel. This also updates corresponding
branch type strings in branch_type_name().

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 tools/perf/util/branch.c              | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 82858b697c05..d37629dbad72 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -251,6 +251,8 @@ enum {
 	PERF_BR_SYSRET		= 8,	/* syscall return */
 	PERF_BR_COND_CALL	= 9,	/* conditional function call */
 	PERF_BR_COND_RET	= 10,	/* conditional function return */
+	PERF_BR_ERET		= 11,	/* exception return */
+	PERF_BR_IRQ		= 12,	/* irq */
 	PERF_BR_MAX,
 };
 
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 2285b1eb3128..a9a909db8cc7 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -49,7 +49,9 @@ const char *branch_type_name(int type)
 		"SYSCALL",
 		"SYSRET",
 		"COND_CALL",
-		"COND_RET"
+		"COND_RET",
+		"ERET",
+		"IRQ"
 	};
 
 	if (type >= 0 && type < PERF_BR_MAX)
-- 
2.25.1

