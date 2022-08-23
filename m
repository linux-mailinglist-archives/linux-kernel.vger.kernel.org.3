Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6E59DD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356798AbiHWKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355774AbiHWKoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:44:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC62AB07C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so389218wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=00nZRcZGH0Ch9kf2FG017OBarf3WrFRyr4+E06yZjt4=;
        b=HpDVHm11YxrrBB9xsaNFKAhRf3RMEuMDCYt/ZksGm4V2FqeiOg0HxpYQNLjepXXUvO
         T0A/Qs6JxvhXH/RbxYObI7rbn9urv4ibf+Q6OouveJTkDLkw1dqZvezYIEP/BH+a7tiW
         nyjMap+JtyCGZLy32XdhzDJNETOf86ByMkQHNE2veSJ5EPGcGd3TuMXEOLAbDDqN5Su8
         sGVWBhu3VFMUdQ1jZbSukiV8AszKnOsbo/tK9GNopSYAIi6KTWfceIOHgsdsah7WmIsJ
         ChRmUoT4AjQQZPDDV/rCCqWQjLO4CbKVzIPIlvidTtvJdXcMrL4G+BNNAahfjU14mXcx
         viRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=00nZRcZGH0Ch9kf2FG017OBarf3WrFRyr4+E06yZjt4=;
        b=mTMPIuuUKxAfhBdttmdjCby7M75/cfcbDMnK+frkmtij5tpxLDPXVqr+Hk4mfoxQpQ
         6uPvjjZN+r9LmC7FaRnPR6Sry6yAP4qfWEe2sVW91WrUFysZN7MkQQIpO+2GpOz7hZDC
         p701M2MmNFL3SLLiVf0i1bCrG58xON//Ti70REB16pD2q0jOkG1JiAQpst81TEVEjcF4
         5OhqgooUQaVzG7d6KLCA64rYBT/umUxzkE7Sfvmkpe9vsN7/K3N9lISrSYkGjd1kEPvl
         vhmkyls2RXNh7DO9td7iqaGtvPjzmlUUt0sh+IMfBJDxptumq/JbQFZakbZEHwULhM3V
         0naw==
X-Gm-Message-State: ACgBeo0zkv1ijU7OikHcBFP1QSj3Gj52NfDXgKddlbCLgAO9pakDkyKh
        yyKEwJVSfbLLLe6+MC41GHK4RQ==
X-Google-Smtp-Source: AA6agR4IyoYCMb8Rm017id592w1HTMLhZsUXS8pSrQLfOj5pTWDvOcRMSxJATztL4ntF4BhAcHH6Aw==
X-Received: by 2002:a7b:ca4c:0:b0:3a5:bbf1:9e3e with SMTP id m12-20020a7bca4c000000b003a5bbf19e3emr1545407wml.5.1661245826465;
        Tue, 23 Aug 2022 02:10:26 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:26 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 12/13] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
Date:   Tue, 23 Aug 2022 10:10:08 +0100
Message-Id: <20220823091009.14121-13-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the perf_report_aux_output_id() call to output the CoreSight trace ID
and associated CPU as a PERF_RECORD_AUX_OUTPUT_HW_ID record in the
perf.data file.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c |  7 +++++++
 include/linux/coresight-pmu.h                    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6166f716a6ac..59a2ad95c1dc 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/bitfield.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/cpumask.h>
@@ -448,6 +449,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
 	struct list_head *path;
+	u64 hw_id;
 
 	if (!csdev)
 		goto fail;
@@ -493,6 +495,11 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
 		goto fail_disable_path;
 
+	/* output cpu / trace ID in perf record */
+	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION) |
+		FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_read_cpu_id(cpu));
+	perf_report_aux_output_id(event, hw_id);
+
 out:
 	/* Tell the perf core the event is alive */
 	event->hw.state = 0;
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 99bc3cc6bf2d..9aafafff219a 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -7,6 +7,8 @@
 #ifndef _LINUX_CORESIGHT_PMU_H
 #define _LINUX_CORESIGHT_PMU_H
 
+#include <linux/bits.h>
+
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 
 /*
@@ -44,4 +46,16 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
+/*
+ * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
+ * Used to associate a CPU with the CoreSight Trace ID.
+ * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
+ * [59:08] - Unused (SBZ)
+ * [63:60] - Version
+ */
+#define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
+#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
+
+#define CS_AUX_HW_ID_CURR_VERSION 0
+
 #endif
-- 
2.17.1

