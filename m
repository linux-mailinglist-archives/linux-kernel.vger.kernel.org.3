Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D9E4BE07D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378336AbiBURLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:11:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiBURLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:11:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09C5525EB0;
        Mon, 21 Feb 2022 09:10:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5E041042;
        Mon, 21 Feb 2022 09:10:51 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADD103F70D;
        Mon, 21 Feb 2022 09:10:49 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf arm-spe: Use advertised caps/min_interval as default sample_period
Date:   Mon, 21 Feb 2022 17:10:42 +0000
Message-Id: <20220221171042.58460-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
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

When recording SPE traces, the default sample_period is currently being
set to 1 in the perf_event_attr fields, instead of the value advertised
in '/sys/devices/arm_spe_0/caps/min_interval':

Before:

$ perf record -e arm_spe// -vv -- sleep 1
[...]
  { sample_period, sample_freq }   1
[...]

Use the value from the above sysfs location as a more sensible default
(it was already being read, but the value not being used)

After:

$ perf record -e arm_spe// -vv -- sleep 1
[...]
  { sample_period, sample_freq }   1024
[...]

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 2100d46cc..5860bbaea 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -158,7 +158,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 				return -EINVAL;
 			}
 			evsel->core.attr.freq = 0;
-			evsel->core.attr.sample_period = 1;
+			evsel->core.attr.sample_period = arm_spe_pmu->default_config->sample_period;
 			arm_spe_evsel = evsel;
 			opts->full_auxtrace = true;
 		}
-- 
2.25.1

