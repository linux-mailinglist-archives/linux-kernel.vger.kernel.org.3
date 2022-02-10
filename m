Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC96D4B16B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbiBJUGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:06:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiBJUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:06:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4DBE5595;
        Thu, 10 Feb 2022 12:06:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62BE3D6E;
        Thu, 10 Feb 2022 12:06:33 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.18.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E2F23F70D;
        Thu, 10 Feb 2022 12:06:29 -0800 (PST)
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
Subject: [PATCH 1/2] perf: cs-etm: No-op refactor of synth opt usage
Date:   Thu, 10 Feb 2022 20:06:19 +0000
Message-Id: <20220210200620.1227232-1-james.clark@arm.com>
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

sample_branches and sample_instructions are already saved in the
synth_opts struct. Other usages like synth_opts.last_branch don't save
a value, so make this more consistent by always going through synth_opts
and not saving duplicate values.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4f672f7d008c..796a065a500e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -50,8 +50,6 @@ struct cs_etm_auxtrace {
 	u8 timeless_decoding;
 	u8 snapshot_mode;
 	u8 data_queued;
-	u8 sample_branches;
-	u8 sample_instructions;
 
 	int num_cpu;
 	u64 latest_kernel_timestamp;
@@ -410,8 +408,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 {
 	struct cs_etm_packet *tmp;
 
-	if (etm->sample_branches || etm->synth_opts.last_branch ||
-	    etm->sample_instructions) {
+	if (etm->synth_opts.branches || etm->synth_opts.last_branch ||
+	    etm->synth_opts.instructions) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
@@ -1365,7 +1363,6 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		err = cs_etm__synth_event(session, &attr, id);
 		if (err)
 			return err;
-		etm->sample_branches = true;
 		etm->branches_sample_type = attr.sample_type;
 		etm->branches_id = id;
 		id += 1;
@@ -1389,7 +1386,6 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		err = cs_etm__synth_event(session, &attr, id);
 		if (err)
 			return err;
-		etm->sample_instructions = true;
 		etm->instructions_sample_type = attr.sample_type;
 		etm->instructions_id = id;
 		id += 1;
@@ -1420,7 +1416,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	    tidq->prev_packet->last_instr_taken_branch)
 		cs_etm__update_last_branch_rb(etmq, tidq);
 
-	if (etm->sample_instructions &&
+	if (etm->synth_opts.instructions &&
 	    tidq->period_instructions >= etm->instructions_sample_period) {
 		/*
 		 * Emit instruction sample periodically
@@ -1503,7 +1499,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		}
 	}
 
-	if (etm->sample_branches) {
+	if (etm->synth_opts.branches) {
 		bool generate_sample = false;
 
 		/* Generate sample for tracing on packet */
@@ -1582,7 +1578,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 
 	}
 
-	if (etm->sample_branches &&
+	if (etm->synth_opts.branches &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
 		err = cs_etm__synth_branch_sample(etmq, tidq);
 		if (err)
-- 
2.28.0

