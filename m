Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C1564F79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiGDIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiGDIMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:12:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9623B1FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:12:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so5136360wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O0T6iSxIoNn8Gu/FxWaC6WvogLfn9QCdL/z8tiUr0ks=;
        b=N2WHXyk2+zP/vYzR1T2MOhfZGFijkVFfzaRR82FrfOQGY/7ezaU7j94KlC1Z///RDR
         UFu6dTuPwMYttwKj1Nht5wSahuHlIIHV5VhsuUQE8qLT+pZNg88pzqnXVOQIQ75DwoxD
         c1aKGMXgzHh7g8kPCGAY8iNqbuoGicdN06m3BPmxiLlTVJ8na0slgJdSwpSVRHoQtZIm
         GuZobYP4jnz7keEPEhN2X3L+1ufXKg6dmI+c+yp64AvTKnYiWtglUIW8qGLkTtRuiTAW
         Z5VvYlU4Vos+eGePHzw1CFLKfrWkFq2T4C27sRuzweoYaHwiBuff5d+4T6kEyedfSn0j
         2Jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O0T6iSxIoNn8Gu/FxWaC6WvogLfn9QCdL/z8tiUr0ks=;
        b=6oZ6LnL0/DQ90bRFtzKmpiEF1Jg6utOXeLVkfMzxQkZOw/0kZd48j1EKkTsOx2pUBM
         vLbHxqKoyASCodIRh+o8a26EoBgod2CyfljLwSQp/OrccaEox46A6u3tZbgxxfpSi2c1
         roM1yn8rejQrOrJOcO+nlDaXs1jCee4ddCieMYYY3M21AEgtnAbsgIFDF6dQs7VTFgZz
         wwlIRFuGtAtNrCwXw6s3JslHSd6Pr3v6qOio/UdOFZUuKs4DoombOnyjJY26Dd/VqZBl
         Ngs9gOYt9WDQUMmNrkb5k2Os+5r1z+Nj3yOuJ0o/iDTO632iqtO47WCWd8XNcQ5vXqC7
         fpRA==
X-Gm-Message-State: AJIora/jGHi5ra55nLj6NCbzXuFO3NgWq/N7pHzuoSPXBXjRSWn5Kt37
        kANWmReqKeP6MZsTY4ArMu+TSw==
X-Google-Smtp-Source: AGRyM1vyZRYXOjBVB9DRfkXD+EUlfDYeLN4AeTBJSnU/FigvnmKIqmrXouU3ruaOFHQTpcPFSAOd1g==
X-Received: by 2002:a05:600c:3d96:b0:3a1:8681:cc80 with SMTP id bi22-20020a05600c3d9600b003a18681cc80mr22311366wmb.192.1656922320417;
        Mon, 04 Jul 2022 01:12:00 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:11:59 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 09/13] perf: cs-etm: Update record event to use new Trace ID protocol
Date:   Mon,  4 Jul 2022 09:11:45 +0100
Message-Id: <20220704081149.16797-10-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704081149.16797-1-mike.leach@linaro.org>
References: <20220704081149.16797-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace IDs are now dynamically allocated.

Previously used the static association algorithm that is no longer
used. The 'cpu * 2 + seed' was outdated and broken for systems with high
core counts (>46). as it did not scale and was broken for larger
core counts.

Trace ID is  as unknown in AUXINFO record, and the ID / CPU association
will now be sent in PERF_RECORD_AUX_OUTPUT_HW_ID record.

Remove legacy Trace ID allocation algorithm.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 include/linux/coresight-pmu.h       | 19 +++++++------------
 tools/include/linux/coresight-pmu.h | 19 +++++++------------
 tools/perf/arch/arm/util/cs-etm.c   | 21 ++++++++++++---------
 3 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 4ac5c081af93..9f7ee380266b 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -8,7 +8,13 @@
 #define _LINUX_CORESIGHT_PMU_H
 
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
-#define CORESIGHT_ETM_PMU_SEED  0x10
+
+/*
+ * Metadata now contains an unused trace ID - IDs are transmitted using a
+ * PERF_RECORD_AUX_OUTPUT_HW_ID record.
+ * Value architecturally defined as reserved in CoreSight.
+ */
+#define CS_UNUSED_TRACE_ID 0x7F
 
 /*
  * Below are the definition of bit offsets for perf option, and works as
@@ -32,15 +38,4 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
-static inline int coresight_get_trace_id(int cpu)
-{
-	/*
-	 * A trace ID of value 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits and go from there.  Since
-	 * the common convention is to have data trace IDs be I(N) + 1,
-	 * set instruction trace IDs as a function of the CPU number.
-	 */
-	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
-}
-
 #endif
diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 6c2fd6cc5a98..31d007fab3a6 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -8,7 +8,13 @@
 #define _LINUX_CORESIGHT_PMU_H
 
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
-#define CORESIGHT_ETM_PMU_SEED  0x10
+
+/*
+ * Metadata now contains an unused trace ID - IDs are transmitted using a
+ * PERF_RECORD_AUX_OUTPUT_HW_ID record.
+ * Value architecturally defined as reserved in CoreSight.
+ */
+#define CS_UNUSED_TRACE_ID 0x7F
 
 /*
  * Below are the definition of bit offsets for perf option, and works as
@@ -34,15 +40,4 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
-static inline int coresight_get_trace_id(int cpu)
-{
-	/*
-	 * A trace ID of value 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits and go from there.  Since
-	 * the common convention is to have data trace IDs be I(N) + 1,
-	 * set instruction trace IDs as a function of the CPU number.
-	 */
-	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
-}
-
 #endif
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 1b54638d53b0..2d68e6a722ed 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -421,13 +421,16 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	evlist__to_front(evlist, cs_etm_evsel);
 
 	/*
-	 * In the case of per-cpu mmaps, we need the CPU on the
-	 * AUX event.  We also need the contextID in order to be notified
+	 * get the CPU on the sample - need it to associate trace ID in the
+	 * AUX_OUTPUT_HW_ID event, and the AUX event for per-cpu mmaps.
+	 */
+	evsel__set_sample_bit(cs_etm_evsel, CPU);
+
+	/*
+	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
 	 * when a context switch happened.
 	 */
 	if (!perf_cpu_map__empty(cpus)) {
-		evsel__set_sample_bit(cs_etm_evsel, CPU);
-
 		err = cs_etm_set_option(itr, cs_etm_evsel,
 					BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS));
 		if (err)
@@ -633,8 +636,9 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 
 	/* Get trace configuration register */
 	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
-	/* Get traceID from the framework */
-	data[CS_ETMV4_TRCTRACEIDR] = coresight_get_trace_id(cpu);
+	/* traceID set to unused */
+	data[CS_ETMV4_TRCTRACEIDR] = CS_UNUSED_TRACE_ID;
+
 	/* Get read-only information from sysFS */
 	data[CS_ETMV4_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
 					       metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
@@ -681,9 +685,8 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 		magic = __perf_cs_etmv3_magic;
 		/* Get configuration register */
 		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
-		/* Get traceID from the framework */
-		info->priv[*offset + CS_ETM_ETMTRACEIDR] =
-						coresight_get_trace_id(cpu);
+		/* traceID set to unused */
+		info->priv[*offset + CS_ETM_ETMTRACEIDR] = CS_UNUSED_TRACE_ID;
 		/* Get read-only information from sysFS */
 		info->priv[*offset + CS_ETM_ETMCCER] =
 			cs_etm_get_ro(cs_etm_pmu, cpu,
-- 
2.17.1

