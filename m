Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2DE4D2794
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiCIDi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiCIDi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:38:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34CFE36B77;
        Tue,  8 Mar 2022 19:37:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 974DC1650;
        Tue,  8 Mar 2022 19:37:54 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.52.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27F323FA4D;
        Tue,  8 Mar 2022 19:37:48 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, acme@kernel.org
Cc:     james.clark@arm.com, suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 8/8] perf/tools: Add branch privilege information request flag
Date:   Wed,  9 Mar 2022 09:06:42 +0530
Message-Id: <20220309033642.144769-9-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309033642.144769-1-anshuman.khandual@arm.com>
References: <20220309033642.144769-1-anshuman.khandual@arm.com>
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

This updates the perf tools with branch privilege information request flag
i.e PERF_SAMPLE_BRANCH_PRIV_SAVE that has been added earlier in the kernel.
This also updates 'perf record' documentation, branch_modes[], and generic
branch privilege level enumeration as added earlier in the kernel.

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
 tools/include/uapi/linux/perf_event.h    | 13 ++++++++++++-
 tools/perf/Documentation/perf-record.txt |  1 +
 tools/perf/util/parse-branch-options.c   |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index d29280adc3c4..0e96e2017f68 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
 
+	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privillege mode */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -233,6 +235,8 @@ enum perf_branch_sample_type {
 
 	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
 
+	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -271,6 +275,12 @@ enum {
 	PERF_BR_NEW_MAX,
 };
 
+enum {
+	PERF_BR_USER	= 0,
+	PERF_BR_KERNEL	= 1,
+	PERF_BR_HV	= 2,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1386,7 +1396,8 @@ struct perf_branch_entry {
 		cycles:16,  /* cycle count to last branch */
 		type:4,     /* branch type */
 		new_type:4, /* additional branch type */
-		reserved:36;
+		priv:2,     /* privilege level */
+		reserved:34;
 };
 
 union perf_sample_weight {
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 9ccc75935bc5..3e33686977a1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -387,6 +387,7 @@ following filters are defined:
 	- abort_tx: only when the target is a hardware transaction abort
 	- cond: conditional branches
 	- save_type: save branch type during sampling in case binary is not available later
+	- priv: save privilege state during sampling in case binary is not available later
 
 +
 The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index bb4aa88c50a8..00588b9db474 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -32,6 +32,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
 	BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
 	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
+	BRANCH_OPT("priv", PERF_SAMPLE_BRANCH_PRIV_SAVE),
 	BRANCH_END
 };
 
-- 
2.25.1

