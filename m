Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2C54775D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbhLPPY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:24:56 -0500
Received: from foss.arm.com ([217.140.110.172]:45084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238499AbhLPPYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:24:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918E81435;
        Thu, 16 Dec 2021 07:24:53 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8018E3F73B;
        Thu, 16 Dec 2021 07:24:51 -0800 (PST)
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
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] perf arm-spe: Synthesize SPE instruction events
Date:   Thu, 16 Dec 2021 15:24:04 +0000
Message-Id: <20211216152404.52474-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesize instruction events for every ARM SPE record.

Arm SPE implements a hardware-based sample period, and perf implements a
software-based one. Add a warning message to inform the user of this.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
Changes since v2
  - Rebase patch on top of https://lore.kernel.org/r/20211201220855.1260688-1-namhyung@kernel.org
  - Don't error out when using unsupported sample period type.
  - Store instructions_sample_period into samples.
Changes since v1 [https://lore.kernel.org/all/20211117142833.226629-1-german.gomez@arm.com]
  - Generate events with "--itrace=i" instead of "--itrace=o".
  - Generate events with virt_addr, phys_addr, and data_src values.
---
 tools/perf/util/arm-spe.c | 62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 8a3828f86901..d2b64e3f588b 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -58,6 +58,8 @@ struct arm_spe {
 	u8				sample_branch;
 	u8				sample_remote_access;
 	u8				sample_memory;
+	u8				sample_instructions;
+	u64				instructions_sample_period;
 
 	u64				l1d_miss_id;
 	u64				l1d_access_id;
@@ -68,6 +70,7 @@ struct arm_spe {
 	u64				branch_miss_id;
 	u64				remote_access_id;
 	u64				memory_id;
+	u64				instructions_id;
 
 	u64				kernel_start;
 
@@ -90,6 +93,7 @@ struct arm_spe_queue {
 	u64				time;
 	u64				timestamp;
 	struct thread			*thread;
+	u64				period_instructions;
 };
 
 static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
@@ -202,6 +206,7 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
 	speq->pid = -1;
 	speq->tid = -1;
 	speq->cpu = -1;
+	speq->period_instructions = 0;
 
 	/* params set */
 	params.get_trace = arm_spe_get_trace;
@@ -353,6 +358,35 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
+static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
+					     u64 spe_events_id, u64 data_src)
+{
+	struct arm_spe *spe = speq->spe;
+	struct arm_spe_record *record = &speq->decoder->record;
+	union perf_event *event = speq->event_buf;
+	struct perf_sample sample = { .ip = 0, };
+
+	/*
+	 * Handles perf instruction sampling period.
+	 */
+	speq->period_instructions++;
+	if (speq->period_instructions < spe->instructions_sample_period)
+		return 0;
+	speq->period_instructions = 0;
+
+	arm_spe_prep_sample(spe, speq, event, &sample);
+
+	sample.id = spe_events_id;
+	sample.stream_id = spe_events_id;
+	sample.addr = record->virt_addr;
+	sample.phys_addr = record->phys_addr;
+	sample.data_src = data_src;
+	sample.period = spe->instructions_sample_period;
+	sample.weight = record->latency;
+
+	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
+}
+
 #define SPE_MEM_TYPE	(ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
 			 ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
 			 ARM_SPE_REMOTE_ACCESS)
@@ -482,6 +516,12 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 			return err;
 	}
 
+	if (spe->sample_instructions) {
+		err = arm_spe__synth_instruction_sample(speq, spe->instructions_id, data_src);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -1110,7 +1150,29 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 			return err;
 		spe->memory_id = id;
 		arm_spe_set_event_name(evlist, id, "memory");
+		id += 1;
+	}
+
+	if (spe->synth_opts.instructions) {
+		if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS) {
+			pr_warning("Only instruction-based sampling period is currently supported by Arm SPE.\n");
+			goto synth_instructions_out;
+		}
+		if (spe->synth_opts.period > 1)
+			pr_warning("Arm SPE has a hardware-based sample period.\n"
+				   "Additional instruction events will be discarded by --itrace\n");
+
+		spe->sample_instructions = true;
+		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
+		attr.sample_period = spe->synth_opts.period;
+		spe->instructions_sample_period = attr.sample_period;
+		err = arm_spe_synth_event(session, &attr, id);
+		if (err)
+			return err;
+		spe->instructions_id = id;
+		arm_spe_set_event_name(evlist, id, "instructions");
 	}
+synth_instructions_out:
 
 	return 0;
 }
-- 
2.25.1

