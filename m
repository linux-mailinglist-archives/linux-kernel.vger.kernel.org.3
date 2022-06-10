Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D36545AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346236AbiFJDv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiFJDvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:51:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01F0C38A280;
        Thu,  9 Jun 2022 20:51:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD83712FC;
        Thu,  9 Jun 2022 20:51:20 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94D903F766;
        Thu,  9 Jun 2022 20:51:15 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, acme@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V6 1/8] perf: Add system error and not in transaction branch types
Date:   Fri, 10 Jun 2022 09:20:54 +0530
Message-Id: <20220610035101.424112-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610035101.424112-1-anshuman.khandual@arm.com>
References: <20220610035101.424112-1-anshuman.khandual@arm.com>
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

This expands generic branch type classification by adding two more entries
there in i.e system error and not in transaction. This also updates the x86
implementation to process X86_BR_NO_TX records as appropriate. This changes
branch types reported to user space on x86 platform but it should not be a
problem. The possible scenarios and impacts are enumerated here.

--------------------------------------------------------------------------
| kernel | perf tool |                     Impact                        |
--------------------------------------------------------------------------
|   old  |    old    |  Works as before                                  |
--------------------------------------------------------------------------
|   old  |    new    |  PERF_BR_UNKNOWN is processed                     |
--------------------------------------------------------------------------
|   new  |    old    |  PERF_BR_NO_TX is blocked via old PERF_BR_MAX     |
--------------------------------------------------------------------------
|   new  |    new    |  PERF_BR_NO_TX is recognized                      |
--------------------------------------------------------------------------

When PERF_BR_NO_TX is blocked via old PERF_BR_MAX (new kernel with old perf
tool) the user space might throw up an warning complaining about an
unrecognized branch types being reported, but it's expected. PERF_BR_SERROR
& PERF_BR_NO_TX branch types will be used for BRBE implementation on arm64
platform.

PERF_BR_NO_TX complements 'abort' and 'in_tx' elements in perf_branch_entry
which represent other transaction states for a given branch record. Because
this completes the transaction state classification.

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
 arch/x86/events/intel/lbr.c     | 2 +-
 include/uapi/linux/perf_event.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 13179f31fe10..0a506c85b53e 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1334,7 +1334,7 @@ static int branch_map[X86_BR_TYPE_MAP_MAX] = {
 	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
 	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
 	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
-	PERF_BR_UNKNOWN,	/* X86_BR_NO_TX */
+	PERF_BR_NO_TX,		/* X86_BR_NO_TX */
 	PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
 	PERF_BR_UNKNOWN,	/* X86_BR_CALL_STACK */
 	PERF_BR_IND,		/* X86_BR_IND_JMP */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d37629dbad72..26d8f0b5ac0d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -253,6 +253,8 @@ enum {
 	PERF_BR_COND_RET	= 10,	/* conditional function return */
 	PERF_BR_ERET		= 11,	/* exception return */
 	PERF_BR_IRQ		= 12,	/* irq */
+	PERF_BR_SERROR		= 13,	/* system error */
+	PERF_BR_NO_TX		= 14,	/* not in transaction */
 	PERF_BR_MAX,
 };
 
-- 
2.25.1

