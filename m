Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB24D7A94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiCNGBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbiCNGBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:01:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1926B403D7;
        Sun, 13 Mar 2022 23:00:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8857D6E;
        Sun, 13 Mar 2022 23:00:21 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.33.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9AA73F7D7;
        Sun, 13 Mar 2022 23:00:14 -0700 (PDT)
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
Subject: [PATCH V3 10/10] perf/tools: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform
Date:   Mon, 14 Mar 2022 11:28:57 +0530
Message-Id: <20220314055857.125421-11-anshuman.khandual@arm.com>
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

This updates the perf tool with arch specific branch type classification
used for BRBE on arm64 platform as added in the kernel earlier.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/include/uapi/linux/perf_event.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 193dba2ecdc1..37276a737a97 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -282,6 +282,14 @@ enum {
 	PERF_BR_PRIV_HV		= 3,
 };
 
+#ifdef CONFIG_ARM64
+#define PERF_BR_NEW_FIQ		PERF_BR_NEW_ARCH_1
+#define PERF_BR_NEW_DEBUG_HALT	PERF_BR_NEW_ARCH_2
+#define PERF_BR_NEW_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
+#define PERF_BR_NEW_DEBUG_INST	PERF_BR_NEW_ARCH_4
+#define PERF_BR_NEW_DEBUG_DATA	PERF_BR_NEW_ARCH_5
+#endif
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
-- 
2.25.1

