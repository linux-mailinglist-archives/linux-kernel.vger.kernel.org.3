Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6D529F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiEQKWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344825AbiEQKV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:21:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 269AA4BFDA;
        Tue, 17 May 2022 03:20:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E270213D5;
        Tue, 17 May 2022 03:20:22 -0700 (PDT)
Received: from e121896.warwick.arm.com (e121896.warwick.arm.com [10.32.33.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B5003F66F;
        Tue, 17 May 2022 03:20:20 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org
Cc:     german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] perf tools: Use dynamic register set for Dwarf unwind
Date:   Tue, 17 May 2022 11:20:03 +0100
Message-Id: <20220517102005.3022017-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220517102005.3022017-1-james.clark@arm.com>
References: <20220517102005.3022017-1-james.clark@arm.com>
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

Architectures can detect availability of extra registers at
runtime so use this more complete set for unwinding. This
will include the VG register on arm64 in a later commit.

If the function isn't implemented then PERF_REGS_MASK is
returned and there is no change.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5fd7924f8eb3..787bbcbcd2ae 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -896,7 +896,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
 					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
 			} else {
-				attr->sample_regs_user |= PERF_REGS_MASK;
+				attr->sample_regs_user |= arch__user_reg_mask();
 			}
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
-- 
2.28.0

