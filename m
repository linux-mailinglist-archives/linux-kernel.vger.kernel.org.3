Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D842851A2FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351800AbiEDPGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351797AbiEDPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:06:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6E2436320;
        Wed,  4 May 2022 08:02:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D9E612FC;
        Wed,  4 May 2022 08:02:45 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A0843F885;
        Wed,  4 May 2022 08:02:43 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] perf cs_etm: Set the time field in the synthetic samples
Date:   Wed,  4 May 2022 16:02:15 +0100
Message-Id: <20220504150216.581281-5-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504150216.581281-1-german.gomez@arm.com>
References: <20220504150216.581281-1-german.gomez@arm.com>
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

If virtual timestamps are detected, set sample time field accordingly,
otherwise warn the user that the samples will not include the time data.

 | Test notes (FEAT_TRF platform)
 |
 | $ ./perf record -e cs_etm//u -a -- sleep 4
 | $ ./perf script --fields +time
 | 	    perf   422 [000]   163.375100:          1 branches:uH:                 0 [unknown] ([unknown])
 | 	    perf   422 [000]   163.375100:          1 branches:uH:      ffffb8009544 ioctl+0x14 (/lib/aarch64-linux-gnu/libc-2.27.so)
 | 	    perf   422 [000]   163.375100:          1 branches:uH:      aaaaab6bebf4 perf_evsel__run_ioctl+0x90 (/home/german/linux/tools/perf/perf)
 | [...]
 | 	    perf   422 [000]   167.393100:          1 branches:uH:      aaaaab6bda00 __xyarray__entry+0x74 (/home/german/linux/tools/perf/perf)
 | 	    perf   422 [000]   167.393099:          1 branches:uH:      aaaaab6bda0c __xyarray__entry+0x80 (/home/german/linux/tools/perf/perf)
 | 	    perf   422 [000]   167.393099:          1 branches:uH:      ffffb8009538 ioctl+0x8 (/lib/aarch64-linux-gnu/libc-2.27.so)
 |
 | The time from the first sample to the last sample is 4 seconds

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/cs-etm.c | 80 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index e883ef6d9c75..ace4ba3256df 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -35,6 +35,7 @@
 #include "tool.h"
 #include "thread.h"
 #include "thread-stack.h"
+#include "tsc.h"
 #include <tools/libc_compat.h>
 #include "util/synthetic-events.h"
 
@@ -46,10 +47,12 @@ struct cs_etm_auxtrace {
 	struct perf_session *session;
 	struct machine *machine;
 	struct thread *unknown_thread;
+	struct perf_tsc_conversion tc;
 
 	u8 timeless_decoding;
 	u8 snapshot_mode;
 	u8 data_queued;
+	u8 has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
 
 	int num_cpu;
 	u64 latest_kernel_timestamp;
@@ -1161,6 +1164,22 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 			   sample->insn_len, (void *)sample->insn);
 }
 
+static inline void cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
+					       struct cs_etm_traceid_queue *tidq,
+					       u64 *time)
+{
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
+
+	if (etm->timeless_decoding)
+		*time = 0;
+	else if (etm->has_virtual_ts)
+		*time = tsc_to_perf_time(packet_queue->cs_timestamp, &etm->tc);
+	else
+		*time = etm->latest_kernel_timestamp;
+
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1174,8 +1193,9 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
-	if (!etm->timeless_decoding)
-		sample.time = etm->latest_kernel_timestamp;
+	/* Set time field based con etm auxtrace config. */
+	cs_etm__resolve_sample_time(etmq, tidq, &sample.time);
+
 	sample.ip = addr;
 	sample.pid = tidq->pid;
 	sample.tid = tidq->tid;
@@ -1232,8 +1252,9 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
-	if (!etm->timeless_decoding)
-		sample.time = etm->latest_kernel_timestamp;
+	/* Set time field based con etm auxtrace config. */
+	cs_etm__resolve_sample_time(etmq, tidq, &sample.time);
+
 	sample.ip = ip;
 	sample.pid = tidq->pid;
 	sample.tid = tidq->tid;
@@ -2899,12 +2920,46 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
 	return 0;
 }
 
+/*
+ * Loop through the ETMs and complain if we find at least one where ts_source != 1 (virtual
+ * timestamps).
+ */
+static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
+{
+	int j;
+
+	for (j = 0; j < num_cpu; j++) {
+
+#define HAS_PARAM(j, type, param) (metadata[(j)][CS_ETM_NR_TRC_PARAMS] <= (CS_##type##_##param - CS_ETM_COMMON_BLK_MAX_V1))
+
+		switch (metadata[j][CS_ETM_MAGIC]) {
+		case __perf_cs_etmv4_magic:
+			if (HAS_PARAM(j, ETMV4, TS_SOURCE) || metadata[j][CS_ETMV4_TS_SOURCE] != 1)
+				return false;
+			break;
+		case __perf_cs_ete_magic:
+			if (HAS_PARAM(j, ETE, TS_SOURCE) || metadata[j][CS_ETE_TS_SOURCE] != 1)
+				return false;
+			break;
+		default:
+			/* Unknown / unsupported magic number. */
+			return false;
+		}
+
+#undef HAS_PARAM
+
+	}
+
+	return true;
+}
+
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct cs_etm_auxtrace *etm = NULL;
 	struct int_node *inode;
+	struct perf_record_time_conv *tc = &session->time_conv;
 	unsigned int pmu_type;
 	int event_header_size = sizeof(struct perf_event_header);
 	int info_header_size;
@@ -3071,6 +3126,13 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->auxtrace_type = auxtrace_info->type;
 	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
 
+	/* Use virtual timestamps if all ETMs report ts_source = 1 */
+	etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
+
+	if (!etm->has_virtual_ts)
+		ui__warning("Virtual timestamps are not enabled, or not supported by the traced system.\n\n"
+			    "The time field of the samples will not be set.\n\n");
+
 	etm->auxtrace.process_event = cs_etm__process_event;
 	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
 	etm->auxtrace.flush_events = cs_etm__flush_events;
@@ -3100,6 +3162,16 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		goto err_delete_thread;
 	}
 
+	etm->tc.time_shift = tc->time_shift;
+	etm->tc.time_mult = tc->time_mult;
+	etm->tc.time_zero = tc->time_zero;
+	if (event_contains(*tc, time_cycles)) {
+		etm->tc.time_cycles = tc->time_cycles;
+		etm->tc.time_mask = tc->time_mask;
+		etm->tc.cap_user_time_zero = tc->cap_user_time_zero;
+		etm->tc.cap_user_time_short = tc->cap_user_time_short;
+	}
+
 	if (dump_trace) {
 		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
 	}
-- 
2.25.1

