Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C532D564F7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiGDIMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiGDIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:12:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA651B48D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:12:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so5136451wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jVURNUygCeW21dF6Em3WQRHaxEsapZQYIGA6mQ8Wh5Q=;
        b=xtC6GuwCyAlyb/Zr988UgFE2vSgoZVJSqHHdAbdoCn2zXTTQ95bcxpfeRtuATBDlcR
         ugx4TMAyenDTPaFmGks19eHk2LlsMtEcga5TUTWYvyhDU2Dvo9P5JtDTEt34gXFV9o0d
         aQctUj7kAgLvyXixRFaCHlTUAQVingSCGnKW/5fNUHOGJQUWvGIz0AVwODty3IPI8JkG
         wEX8ibacACiG1/J5ABwyFx4tDjFtnrNVkSDJ4sSwUyGGEKiGsS/RnSHEJnXPmblXHWWO
         3TbhXgvCiKMkwKNBTPRzkZt2hi503wi+9uD0dAWkczQ74VGxLRLAUkn/KD6QLW5AJ4iO
         cYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jVURNUygCeW21dF6Em3WQRHaxEsapZQYIGA6mQ8Wh5Q=;
        b=w2xSrcFFYjcdrVHM5ChEmrDjUea9Qt8flOizxi4rZ89+Y4f0eRmuEK6DrTa1XgxjEn
         A1NohBlreCWwaBUSEjA2A71EBsxczhugXwqJGSylb7TRWWLb0Gy2ivD7cLlra9Nenim2
         9ty9EfM2l0/byKz1lbxodVzhOJy2CoGJmyBAv14EDxOEbC9012gFBhGJDx1H8pBcaRQX
         0T6IzFas/ZCZ2kpiGX3PSUlb8HjCCiOLF7Le66pDpJa9sbbXhICfTglgRwaRyXcrr2E8
         91L0llTHPF86YdQIkjw+C8fDSfa9WX5NUAjp8DeaL/y/fKRFmKY9PVTLMZwNEKa6Z3fO
         5zow==
X-Gm-Message-State: AJIora8lh4LtKjmmS7Fis/E55H23f9YOW1cmdJIkkRPQCDxH7hCVXt+2
        k10boMp9frQbuML6PWmFLd8Nf6isCYp95A==
X-Google-Smtp-Source: AGRyM1vdQ5X/T4qTaulT8bVJRKWtoOJXrVUMmSl2XW9gC5Pqms/iIBwspD7l1h7ZCr/tZDOy9g/NTw==
X-Received: by 2002:a05:600c:4e49:b0:3a0:4c17:c67f with SMTP id e9-20020a05600c4e4900b003a04c17c67fmr32310009wmq.1.1656922323276;
        Mon, 04 Jul 2022 01:12:03 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:12:02 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 12/13] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
Date:   Mon,  4 Jul 2022 09:11:48 +0100
Message-Id: <20220704081149.16797-13-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704081149.16797-1-mike.leach@linaro.org>
References: <20220704081149.16797-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/hwtracing/coresight/coresight-etm-perf.c | 10 ++++++++++
 include/linux/coresight-pmu.h                    | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index ad3fdc07c60b..531f5d42272b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/bitfield.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/cpumask.h>
@@ -437,6 +438,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
 	struct list_head *path;
+	u64 hw_id;
 
 	if (!csdev)
 		goto fail;
@@ -482,6 +484,11 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
 		goto fail_disable_path;
 
+	/* output cpu / trace ID in perf record */
+	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION) |
+		FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_get_cpu_id(cpu));
+	perf_report_aux_output_id(event, hw_id);
+
 out:
 	/* Tell the perf core the event is alive */
 	event->hw.state = 0;
@@ -600,6 +607,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
 
 	/* Disabling the path make its elements available to other sessions */
 	coresight_disable_path(path);
+
+	/* release the trace ID we read on event start */
+	coresight_trace_id_put_cpu_id(cpu);
 }
 
 static int etm_event_add(struct perf_event *event, int mode)
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 9f7ee380266b..5572d0e10822 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -7,6 +7,8 @@
 #ifndef _LINUX_CORESIGHT_PMU_H
 #define _LINUX_CORESIGHT_PMU_H
 
+#include <linux/bits.h>
+
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 
 /*
@@ -38,4 +40,16 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
+/*
+ * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
+ * Used to associate a CPU with the CoreSight Trace ID.
+ * [63:16] - unused SBZ
+ * [15:08] - Trace ID
+ * [07:00] - Version
+ */
+#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(7, 0)
+#define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(15, 8)
+
+#define CS_AUX_HW_ID_CURR_VERSION 0
+
 #endif
-- 
2.17.1

