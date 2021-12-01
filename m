Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405544658EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353398AbhLAWMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhLAWMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:12:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F3BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 14:08:57 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so834691pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 14:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2t6UPLkpgLpFXNXvlINJ9j4Lw79kGG//UDCLbmlNlYQ=;
        b=gCBm1qWZGM3jMPBSEakcrYdaIRaZ+1Vjbg7M64Pv6PCa9HjnAX1bDoVGGaKsETefs+
         mIF5J64/uzIhyOKBmL+0lRzEQ4mCmh+BcfkPVqKoj94p0vZBacyCM3WynyQJRVwg60xy
         aR86NWnfTVsLIcqbfTgmoBiGPW5fJVXcDKrJkSq9KWgcmv9MwsqvgIS+A3eyAUQpcSBQ
         oObfJc4tqzQakaeJAfwMf+nGx2/V/opzBS+UYRAZaaoeNZdMyBb0+Wl3PB9POFgi+09x
         taTVNHI/6nkR/EnUZb/uR2zyFQFtIUpPT6FzZbiTImMsmxIQ2/AmfMAT8WZ6c1ak4NZa
         7oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2t6UPLkpgLpFXNXvlINJ9j4Lw79kGG//UDCLbmlNlYQ=;
        b=DtfPpVaok0bXtIPGEqvkIoBGPzLqDKgClOjwisVEhCmx58kMRjDzwtuO5GeKRZalKJ
         MxG/zGl6wWy2g2d1lpnXv/WfoS5eD4+xT4Tr+J2XFuNRtZRNavasEju4PRnCVp/89Wf4
         3nPt1HJMiteED8w8RwedC6nmp3XePkQN+ZBftGM4VMxWURwOfPjDVYQU0WQaEFU9I7o0
         ivKXNJh4rZqWkQVSiOLp6Yy9gPPDMlASB5QvhVY/2XGuzk3JySD7Z8b5M+EjL2r7aMqX
         J+1+SDsaPxoLI5h5+UH/dB614F2LYVxFc9nB2cg96Ch1pDr3qFpsPnMo/ObhyXJKo5x/
         eaVg==
X-Gm-Message-State: AOAM531zyruQbuwTzRKB/fyoUSmz7toJuaYVT8LGvl1UYfrm3JHskaXi
        lFF341xQEdTOSbNZ4nz/H4k=
X-Google-Smtp-Source: ABdhPJwybaz/71PxVLBKZvm8VeRkuF2q8ouTJrg14ur5agT04jDnMaI/IGg/b8F8cHymlJGeiAiO8w==
X-Received: by 2002:a17:902:ee95:b0:141:f28f:7296 with SMTP id a21-20020a170902ee9500b00141f28f7296mr10686163pld.50.1638396537354;
        Wed, 01 Dec 2021 14:08:57 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:e6ea:3b3b:5788:f38f])
        by smtp.gmail.com with ESMTPSA id n71sm823102pfd.50.2021.12.01.14.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:08:56 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] perf tools: Add SPE total latency as PERF_SAMPLE_WEIGHT
Date:   Wed,  1 Dec 2021 14:08:55 -0800
Message-Id: <20211201220855.1260688-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use total latency info in the SPE counter packet as sample weight so
that we can see it in local_weight and (global) weight sort keys.

Maybe we can use PERF_SAMPLE_WEIGHT_STRUCT to support ins_lat as well
but I'm not sure which latency it matches.  So just adding total
latency first.

Cc: German Gomez <german.gomez@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
 tools/perf/util/arm-spe.c                         | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 3fc528c9270c..5e390a1a79ab 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -179,6 +179,8 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 				decoder->record.phys_addr = ip;
 			break;
 		case ARM_SPE_COUNTER:
+			if (idx == SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT)
+				decoder->record.latency = payload;
 			break;
 		case ARM_SPE_CONTEXT:
 			decoder->record.context_id = payload;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 46a8556a9e95..69b31084d6be 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -33,6 +33,7 @@ struct arm_spe_record {
 	enum arm_spe_sample_type type;
 	int err;
 	u32 op;
+	u32 latency;
 	u64 from_ip;
 	u64 to_ip;
 	u64 timestamp;
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 4748bcfe61de..82c08f2a60d0 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -317,6 +317,7 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
 	sample.addr = record->virt_addr;
 	sample.phys_addr = record->phys_addr;
 	sample.data_src = data_src;
+	sample.weight = record->latency;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -334,6 +335,7 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	sample.id = spe_events_id;
 	sample.stream_id = spe_events_id;
 	sample.addr = record->to_ip;
+	sample.weight = record->latency;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -980,7 +982,8 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	attr.type = PERF_TYPE_HARDWARE;
 	attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
 	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
-			    PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC;
+			    PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC |
+			    PERF_SAMPLE_WEIGHT;
 	if (spe->timeless_decoding)
 		attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
 	else
-- 
2.34.0.384.gca35af8252-goog

