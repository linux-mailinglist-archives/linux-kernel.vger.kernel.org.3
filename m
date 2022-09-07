Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7595B0031
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIGJTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIGJTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:19:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69C3E55B3;
        Wed,  7 Sep 2022 02:19:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37EB8139F;
        Wed,  7 Sep 2022 02:19:49 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EF9D3F73D;
        Wed,  7 Sep 2022 02:20:07 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org
Subject: [PATCH V3 2/4] perf/core: Assert PERF_EVENT_FLAG_ARCH does not overlap with generic flags
Date:   Wed,  7 Sep 2022 14:49:22 +0530
Message-Id: <20220907091924.439193-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907091924.439193-1-anshuman.khandual@arm.com>
References: <20220907091924.439193-1-anshuman.khandual@arm.com>
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

This just ensures that PERF_EVENT_FLAG_ARCH does not overlap with generic
hardware event flags.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3f51fbf4a595..10e23a0f9db0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -140,6 +140,8 @@ struct hw_perf_event_extra {
 #define PERF_EVENT_FLAG_ARCH			0x000fffff
 #define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000
 
+static_assert((PERF_EVENT_FLAG_USER_READ_CNT & PERF_EVENT_FLAG_ARCH) == 0);
+
 /**
  * struct hw_perf_event - performance event hardware details:
  */
-- 
2.25.1

