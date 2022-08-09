Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649C558E345
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiHIWfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiHIWe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085516582E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:34:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k17so90838wmr.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=00nZRcZGH0Ch9kf2FG017OBarf3WrFRyr4+E06yZjt4=;
        b=XnkN5+Q3VvUS+pWCQjNNkLvFEY3AVMmiqM0/+Gygmfy8PgeXVU6GWZIUNg/dKBhtPd
         5+kZ7gdPnz6wPRl0M1XZz0fjmt3OCToAtVfcdaP1cHCn0MAEnTXDll9w1kpo3TRzVbeI
         X9IKuad9nHCXcqdpr5Ja0I6LunimqxdehOV4ctCAqaKJqvfe8zFEt8oXHzbT2FP2SXxO
         mqsB7VU6VHOuJr6gRNGWBR06d6AO3qjuIWAb/046xR+fcnXLXSSptAH03NtNOVTJLt2h
         Fj23+q5EiyFucUN5KRG4ZLHUnLIMOc0jqFP/JaSt7jAn8pKuICZOTPAWyiaCY/HxSkUk
         Z0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=00nZRcZGH0Ch9kf2FG017OBarf3WrFRyr4+E06yZjt4=;
        b=ygK/1C3rpzbhv/Snp2ASGdhmyqJoWU0LLBU9p1Cd8pDbmp5T7aDWV5PS117aK6wNnw
         eFk3QzHKwBBRRcJFiIEQpfSDrCYWml8NMdjhwCQbBbNJh+m33KToG74r9Zk1Mg7Ky0Um
         TpRzYPN6SnpJYshnxMYciSynVAIn9g15sa3iRusG61dGrIymC69Q5XwEo60qJ6gvtqUU
         xvhs86h8AHsOnd1OxaRCzXQLZc9f2pJPUrkQv/hEB8II/+RpHEORAiI41WrfLAilG8lo
         e0LZZ3jOyy/aYXDM8DoIdLuUDhvUnN83va9U0N4uytRafBKfFGxj/GB0K3wKf/XKLXDO
         DnBA==
X-Gm-Message-State: ACgBeo0msBgeMIqZcdnuJrtW6LsJmIEnBUPFN51hqEzoGgg3WGZtmPuJ
        z9+vkr88Qw0zEUHC0QjGVM+pP0GdF6yjeJ72
X-Google-Smtp-Source: AA6agR74zdFgB6sJJNaJ1SoSy8Qp3kE85uWaEJ5Hnvu92VHKL5yIVbMl+mOvtxMZrSeKHnQNP9jIKg==
X-Received: by 2002:a05:600c:35d5:b0:3a3:2490:c984 with SMTP id r21-20020a05600c35d500b003a32490c984mr332807wmq.162.1660084458409;
        Tue, 09 Aug 2022 15:34:18 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:17 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 12/13] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
Date:   Tue,  9 Aug 2022 23:34:00 +0100
Message-Id: <20220809223401.24599-13-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220809223401.24599-1-mike.leach@linaro.org>
References: <20220809223401.24599-1-mike.leach@linaro.org>
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

