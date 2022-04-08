Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547094F985A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiDHOnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbiDHOnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:43:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7927ED9F5;
        Fri,  8 Apr 2022 07:41:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D9BD113E;
        Fri,  8 Apr 2022 07:41:05 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.11.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6204A3F73B;
        Fri,  8 Apr 2022 07:41:02 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.com
Cc:     German.Gomez@arm.com, James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm-spe: Fix perf report --mem-mode
Date:   Fri,  8 Apr 2022 15:40:56 +0100
Message-Id: <20220408144056.1955535-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
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

Since commit bb30acae4c4d ("perf report: Bail out --mem-mode if mem info
is not available") "perf mem report" and "perf report --mem-mode" don't
allow opening the file unless one of the events has PERF_SAMPLE_DATA_SRC
set.

SPE doesn't have this set even though synthetic memory data is generated
after it is decoded. Fix this issue by setting DATA_SRC on SPE events.
This has no effect on the data collected because the SPE driver doesn't
do anything with that flag and doesn't generate samples.

Fixes: bb30acae4c4d ("perf report: Bail out --mem-mode if mem info is not available")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 86e2e926aa0e..a1419e6341c0 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -239,6 +239,12 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		arm_spe_set_timestamp(itr, arm_spe_evsel);
 	}
 
+	/*
+	 * Set this only so that perf report knows that SPE generates memory info. It has no effect
+	 * on the opening of the event or the SPE data produced.
+	 */
+	evsel__set_sample_bit(arm_spe_evsel, DATA_SRC);
+
 	/* Add dummy event to keep tracking */
 	err = parse_events(evlist, "dummy:u", NULL);
 	if (err)
@@ -523,6 +529,5 @@ struct perf_event_attr
 
 	arm_spe_pmu->selectable = true;
 	arm_spe_pmu->is_uncore = false;
-
 	return attr;
 }
-- 
2.28.0

