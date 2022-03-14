Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06774D7A93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiCNGBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiCNGBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:01:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A94C53FDA7;
        Sun, 13 Mar 2022 23:00:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EA3CD6E;
        Sun, 13 Mar 2022 23:00:07 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.33.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 023393F7D7;
        Sun, 13 Mar 2022 23:00:01 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, acme@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
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
Subject: [PATCH V3 08/10] perf/tools: Extend branch type classification
Date:   Mon, 14 Mar 2022 11:28:55 +0530
Message-Id: <20220314055857.125421-9-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314055857.125421-1-anshuman.khandual@arm.com>
References: <20220314055857.125421-1-anshuman.khandual@arm.com>
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

This updates the perf tool with generic branch type classification with new
ABI extender place holder i.e PERF_BR_EXTEND_ABI, the new 4 bit branch type
field i.e perf_branch_entry.new_type, new generic page fault related branch
types and some arch specific branch types as added earlier in the kernel.

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
 tools/include/uapi/linux/perf_event.h | 16 +++++++++++++++-
 tools/perf/util/branch.c              |  3 ++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 26d8f0b5ac0d..d29280adc3c4 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -255,9 +255,22 @@ enum {
 	PERF_BR_IRQ		= 12,	/* irq */
 	PERF_BR_SERROR		= 13,	/* system error */
 	PERF_BR_NO_TX		= 14,	/* not in transaction */
+	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
 	PERF_BR_MAX,
 };
 
+enum {
+	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
+	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
+	PERF_BR_NEW_FAULT_INST		= 2,    /* Inst fault */
+	PERF_BR_NEW_ARCH_1		= 3,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_2		= 4,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_3		= 5,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_4		= 6,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_5		= 7,    /* Architecture specific */
+	PERF_BR_NEW_MAX,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1372,7 +1385,8 @@ struct perf_branch_entry {
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
 		type:4,     /* branch type */
-		reserved:40;
+		new_type:4, /* additional branch type */
+		reserved:36;
 };
 
 union perf_sample_weight {
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index abc673347bee..4bd52de0527c 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -53,7 +53,8 @@ const char *branch_type_name(int type)
 		"ERET",
 		"IRQ",
 		"SERROR",
-		"NO_TX"
+		"NO_TX",
+		"EXTEND_ABI"
 	};
 
 	if (type >= 0 && type < PERF_BR_MAX)
-- 
2.25.1

