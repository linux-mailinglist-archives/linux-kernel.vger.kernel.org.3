Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2BC5AC9D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiIEFnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiIEFn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:43:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 359A42FFD2;
        Sun,  4 Sep 2022 22:43:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 139E6D6E;
        Sun,  4 Sep 2022 22:43:27 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 36B7A3F73D;
        Sun,  4 Sep 2022 22:43:43 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH V2 4/4] x86/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH
Date:   Mon,  5 Sep 2022 11:12:39 +0530
Message-Id: <20220905054239.324029-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905054239.324029-1-anshuman.khandual@arm.com>
References: <20220905054239.324029-1-anshuman.khandual@arm.com>
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

Ensure all platform specific event flags are within PERF_EVENT_FLAG_ARCH.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/events/perf_event.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ba3d24a6a4ec..12136a33e9b7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -86,6 +86,26 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_AMD_BRS		0x10000 /* AMD Branch Sampling */
 #define PERF_X86_EVENT_PEBS_LAT_HYBRID	0x20000 /* ld and st lat for hybrid */
 
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LDLAT) == PERF_X86_EVENT_PEBS_LDLAT);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_ST) == PERF_X86_EVENT_PEBS_ST);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_ST_HSW) == PERF_X86_EVENT_PEBS_ST_HSW);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LD_HSW) == PERF_X86_EVENT_PEBS_LD_HSW);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_NA_HSW) == PERF_X86_EVENT_PEBS_NA_HSW);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_EXCL) == PERF_X86_EVENT_EXCL);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_DYNAMIC) == PERF_X86_EVENT_DYNAMIC);
+
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_EXCL_ACCT) == PERF_X86_EVENT_EXCL_ACCT);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_AUTO_RELOAD) == PERF_X86_EVENT_AUTO_RELOAD);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_LARGE_PEBS) == PERF_X86_EVENT_LARGE_PEBS);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_VIA_PT) == PERF_X86_EVENT_PEBS_VIA_PT);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PAIR) == PERF_X86_EVENT_PAIR);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_LBR_SELECT) == PERF_X86_EVENT_LBR_SELECT);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_TOPDOWN) == PERF_X86_EVENT_TOPDOWN);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_STLAT) == PERF_X86_EVENT_PEBS_STLAT);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_AMD_BRS) == PERF_X86_EVENT_AMD_BRS);
+static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LAT_HYBRID)
+				   == PERF_X86_EVENT_PEBS_LAT_HYBRID);
+
 static inline bool is_topdown_count(struct perf_event *event)
 {
 	return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
-- 
2.25.1

