Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECFB4C23A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiBXFhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiBXFhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:37:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 970B570F4E;
        Wed, 23 Feb 2022 21:37:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E7F106F;
        Wed, 23 Feb 2022 21:37:03 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.48.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C497E3F66F;
        Wed, 23 Feb 2022 21:36:58 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf: Add irq and exception return branch types
Date:   Thu, 24 Feb 2022 11:06:54 +0530
Message-Id: <1645681014-3346-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This expands generic branch type classification by adding two more entries
there in i.e irq and exception return. Also updates the x86 implementation
to process X86_BR_IRET and X86_BR_IRQ records as appropriate. This changes
branch types reported to user space on x86 platform but it should not be a
problem. The possible scenarios and impacts are enumerated here.

--------------------------------------------------------------------------
| kernel | perf tool |                     Impact                        |
--------------------------------------------------------------------------
|   old  |    old    |  Works as before                                  |
--------------------------------------------------------------------------
|   old  |    new    |  PERF_BR_UNKNOWN is processed                     |
--------------------------------------------------------------------------
|   new  |    old    |  PERF_BR_ERET/IRQ are blocked via old PERF_BR_MAX |
--------------------------------------------------------------------------
|   new  |    new    |  PERF_BR_ERET/IRQ are recognized                  |
--------------------------------------------------------------------------

When PERF_BR_ERET/IRQ are blocked via old PERF_BR_MAX (new kernel with old
perf tool) the user space might throw up an warning complaining about some
unrecognized branch types being reported, but it is expected. PERF_BR_ERET
and PERF_BR_IRQ branch types will be used for BRBE implementation on arm64
platform.

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
This applies on v5.17-rc5

These two new branch types expands generic branch type classification but
still leaves another three entries in 'type' field for later. Please refer
a previous discussion [1] for some further context.

[1] https://lore.kernel.org/all/1643348653-24367-1-git-send-email-anshuman.khandual@arm.com/

 arch/x86/events/intel/lbr.c           | 4 ++--
 include/uapi/linux/perf_event.h       | 2 ++
 tools/include/uapi/linux/perf_event.h | 2 ++
 tools/perf/util/branch.c              | 4 +++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 669c2be14784..fe1742c4ca49 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1329,10 +1329,10 @@ static int branch_map[X86_BR_TYPE_MAP_MAX] = {
 	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
 	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
 	PERF_BR_UNKNOWN,	/* X86_BR_INT */
-	PERF_BR_UNKNOWN,	/* X86_BR_IRET */
+	PERF_BR_ERET,		/* X86_BR_IRET */
 	PERF_BR_COND,		/* X86_BR_JCC */
 	PERF_BR_UNCOND,		/* X86_BR_JMP */
-	PERF_BR_UNKNOWN,	/* X86_BR_IRQ */
+	PERF_BR_IRQ,		/* X86_BR_IRQ */
 	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
 	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
 	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 82858b697c05..d37629dbad72 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -251,6 +251,8 @@ enum {
 	PERF_BR_SYSRET		= 8,	/* syscall return */
 	PERF_BR_COND_CALL	= 9,	/* conditional function call */
 	PERF_BR_COND_RET	= 10,	/* conditional function return */
+	PERF_BR_ERET		= 11,	/* exception return */
+	PERF_BR_IRQ		= 12,	/* irq */
 	PERF_BR_MAX,
 };
 
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

