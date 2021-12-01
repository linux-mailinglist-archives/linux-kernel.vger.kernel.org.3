Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195104643FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345836AbhLAAme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbhLAAmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:42:31 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F26C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:39:11 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n26so22436447pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1GF36lcVvznUsbgFIAjPkbcwTuMBJ40XJi+6TuxQD4g=;
        b=PDaMLXay0vcg32pfoGyk7GHeEA8WsGSi6bQXOK0k5MlxYSRYHCr8ZncpQASskCL67c
         r/9Bvtam1YtgRGD7IWWG6SjcN6d2NlyndOoJ2TwfPGUq0oUbIcsmmIjrG4MMjy11VIhR
         JvhLKZxTMKUNePJNt3AeEBkUrr2UB56Nl3USDFruozgwXSeAKjdKbZccbRAu7mKKi+3d
         kwNBRhaaAQOVRUwJm8J9X0ng/WZNaleJX7FfDQCDLFLVNAehUxXwOLdczHLhTo3HoezK
         Ids8V8lPv752v9ymq6Pk78sFscdHRSI5CZ1pEnCz3NRiei6LjfE2+UQciEp91PjTdbc9
         NQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1GF36lcVvznUsbgFIAjPkbcwTuMBJ40XJi+6TuxQD4g=;
        b=kYAgDyLACtgEwYrPgWUghEx9XDMFEY+2s1ef6v4gheyuS/Gw5DH2iIVD6OKRCvNNqq
         vj8KQywkWB6IUAH+GT2UCL09fTzifpm9q+wQ+Ug40Puh6fxcvgeadpN2+DnTUoenypVc
         Bt6KbH6AuQZPikzTusgX0qMDSvRd5in4IipOHMZdTEbzK6WV41+pZDRaCu/IujsSiGuY
         LN9xu+YYJ5jtGwdyCsDmKKq4tB0WjnGkG96QFVQE/RCNzNsSIsJGbCDT9Yst7tHNHzP/
         mQthcF8Jd1RxTapyT4heH+6Ci4ytp0RbbRsVuf4D3s+05abjZoA8jUS6E3HtqpRD62Au
         6pjA==
X-Gm-Message-State: AOAM532O0ZXl0RpNgwYPfBxvB190JR8bWlTcAGe0foTWdvz4rV8YCVXr
        BOY5KTbYQecJJdZBuMx07p8=
X-Google-Smtp-Source: ABdhPJzdhb3cb4j8PCazwFUfBymTN8hbWUZAuwO+9mUq6CQsGfAubKaMV2iPgKrnhof5kqKFtJUAxQ==
X-Received: by 2002:a05:6a00:10cf:b0:4a3:124d:bb81 with SMTP id d15-20020a056a0010cf00b004a3124dbb81mr2477321pfu.75.1638319150978;
        Tue, 30 Nov 2021 16:39:10 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:269b:74fc:eb29:f3e5])
        by smtp.gmail.com with ESMTPSA id m18sm23513996pfk.68.2021.11.30.16.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 16:39:10 -0800 (PST)
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
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] perf tools: Add SPE total latency as PERF_SAMPLE_WEIGHT
Date:   Tue, 30 Nov 2021 16:39:08 -0800
Message-Id: <20211201003908.1200945-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
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
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
 tools/perf/util/arm-spe.c                         | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

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
index 4748bcfe61de..a756325c72a7 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -317,6 +317,7 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
 	sample.addr = record->virt_addr;
 	sample.phys_addr = record->phys_addr;
 	sample.data_src = data_src;
+	sample.weight = record->latency;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -980,7 +981,8 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
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
2.34.0.rc2.393.gf8c9666880-goog

