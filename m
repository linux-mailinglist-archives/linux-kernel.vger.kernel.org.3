Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188A95AC9D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiIEFnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiIEFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:43:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AD0F2F037;
        Sun,  4 Sep 2022 22:43:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41B06ED1;
        Sun,  4 Sep 2022 22:43:11 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC08E3F73D;
        Sun,  4 Sep 2022 22:43:28 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: [PATCH V2 1/4] perf/core: Expand PERF_EVENT_FLAG_ARCH
Date:   Mon,  5 Sep 2022 11:12:36 +0530
Message-Id: <20220905054239.324029-2-anshuman.khandual@arm.com>
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

Two hardware event flags on x86 platform has overshot PERF_EVENT_FLAG_ARCH
(0x0000ffff). These flags are PERF_X86_EVENT_PEBS_LAT_HYBRID (0x20000) and
PERF_X86_EVENT_AMD_BRS (0x10000). Lets expand PERF_EVENT_FLAG_ARCH mask to
accommodate those flags, and also create room for two more in the future.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ee8b9ecdc03b..3f51fbf4a595 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -137,7 +137,7 @@ struct hw_perf_event_extra {
  * PERF_EVENT_FLAG_ARCH bits are reserved for architecture-specific
  * usage.
  */
-#define PERF_EVENT_FLAG_ARCH			0x0000ffff
+#define PERF_EVENT_FLAG_ARCH			0x000fffff
 #define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000
 
 /**
-- 
2.25.1

