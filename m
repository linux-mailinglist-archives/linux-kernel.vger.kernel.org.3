Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC5B4D266B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiCIDi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiCIDi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:38:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 586B532999;
        Tue,  8 Mar 2022 19:37:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23D8D1655;
        Tue,  8 Mar 2022 19:37:29 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.52.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 857B43FA4D;
        Tue,  8 Mar 2022 19:37:23 -0800 (PST)
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
Subject: [PATCH V2 4/8] perf: Capture branch privilege information
Date:   Wed,  9 Mar 2022 09:06:38 +0530
Message-Id: <20220309033642.144769-5-anshuman.khandual@arm.com>
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

Platforms like arm64 could capture privilege level information for all the
branch records. Hence this adds a new element in the struct branch_entry to
record the privilege level information, which could be requested through a
new event.attr.branch_sample_type based flag PERF_SAMPLE_BRANCH_PRIV_SAVE.
This flag helps user choose whether privilege information is captured.

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
 include/uapi/linux/perf_event.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d29280adc3c4..0e96e2017f68 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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
-- 
2.25.1

