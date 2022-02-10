Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8FE4B16B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbiBJUGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:06:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbiBJUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:06:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B89F5F4F;
        Thu, 10 Feb 2022 12:06:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 451A5106F;
        Thu, 10 Feb 2022 12:06:36 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.18.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F11793F70D;
        Thu, 10 Feb 2022 12:06:33 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf: cs-etm: Fix corrupt inject files when only last branch option is enabled
Date:   Thu, 10 Feb 2022 20:06:20 +0000
Message-Id: <20220210200620.1227232-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220210200620.1227232-1-james.clark@arm.com>
References: <20220210200620.1227232-1-james.clark@arm.com>
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

Perf inject with Coresight data generates files that cannot be opened
when only the last branch option is specified:

  perf inject -i perf.data --itrace=l -o inject.data
  perf script -i inject.data
  0x33faa8 [0x8]: failed to process type: 9 [Bad address]

This is because cs_etm__synth_instruction_sample() is called even when
the sample type for instructions hasn't been setup. Last branch records
are attached to instruction samples so it doesn't make sense to generate
them when --itrace=i isn't specified anyway.

This change disables all calls of cs_etm__synth_instruction_sample()
unless --itrace=i is specified, resulting in a file with no samples if
only --itrace=l is provided, rather than a bad file.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 796a065a500e..8b95fb3c4d7b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1553,6 +1553,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 		goto swap_packet;
 
 	if (etmq->etm->synth_opts.last_branch &&
+	    etmq->etm->synth_opts.instructions &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
 		u64 addr;
 
@@ -1610,6 +1611,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 	 * the trace.
 	 */
 	if (etmq->etm->synth_opts.last_branch &&
+	    etmq->etm->synth_opts.instructions &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
 		u64 addr;
 
-- 
2.28.0

