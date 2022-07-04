Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1C0564F75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiGDIMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGDIMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:12:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED7BB493
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:12:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so7441813wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PTooRwbsdLD3OOIuzOYJzIkCxcUPBK7VZILGtwDxgv8=;
        b=PQ4bNkRRVNU2cYS7j7W1mfEhb+fKztLHPOlexnGD/LLD5abRR2eteBvUPs0dD8PpxK
         njYPHJncc7vU7yD8ODW5mtlpu6LExnSOvJxyJ4zuavRr7KMPVE1gLRwzzPBpacjopt3c
         rQ7Q1SQfFk7rTHU4MVAN5u62VHSuEpmSXQQiHuGNom8Q88Y9QJcAQz8CWHUNcga5Ogxk
         QkovaD/tjndCQHIZ1crG9I/i7IEWel3qBQzL9/bCO3J8n97eah+qDBJbyxybJMPeeuE3
         6lNP2niosAGtY/8yYGxmt9MhxMFYofi164Y6r3s4mnQbMQKzt5qgGZeIZQ1gK/sVjj2e
         IBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PTooRwbsdLD3OOIuzOYJzIkCxcUPBK7VZILGtwDxgv8=;
        b=1k0/N+4EEmk1hlv6c46QK4E6iWhIf71hfYOgtYG0WDZ8udjmu3OsJ/IyTE83Jhp5R6
         2NjHZdxrfKs+28oiHKXaDPVUzX0+024HvnYO+1YGzGaoCNcnsWCfR+U8szqTkuu07InW
         UjVx/Ld/bgcmsqRCoUxIfzkLTGdMRgmycyl1E+r7+8Jc5BtGQLe0T9O5dcAzYGfUQdJv
         vFBvTguYvNldrsXaUmbFuu2EZ1xhyfCuh+hn2tbdFVUOJzCZGJa5xa/LfWxosZ7J+Fzu
         CKkwIwh/fl3Z6mG4ajq9CONEF1K+u6I4skFsgn6oDQY6fXr0j0y6phJt+yQl37uLumBy
         ZVaA==
X-Gm-Message-State: AJIora98GTkIZF5+7KV3Q8p90MpiGVMs/lPCzFIojL1YdVIDptJUlcCP
        HRRaSuVKILcvrRp4xMPZn8FYBw==
X-Google-Smtp-Source: AGRyM1tjEn71qrKmNMS7wp3T3S+d/t0dVPqKJQezpaQfm5B9v8Y+F+k95yPYU5LV/RIbsvx/NRnIZQ==
X-Received: by 2002:a05:600c:1c21:b0:3a1:9608:1ffb with SMTP id j33-20020a05600c1c2100b003a196081ffbmr11837879wms.163.1656922324210;
        Mon, 04 Jul 2022 01:12:04 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:12:03 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 13/13] coresight: trace-id: Add debug & test macros to Trace ID allocation
Date:   Mon,  4 Jul 2022 09:11:49 +0100
Message-Id: <20220704081149.16797-14-mike.leach@linaro.org>
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

Adds in a number of pr_debug macros to allow the debugging and test of
the trace ID allocation system.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-trace-id.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index dac9c89ae00d..841307e0d899 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -71,6 +71,27 @@ static int coresight_trace_id_find_new_id(struct coresight_trace_id_map *id_map)
 	return id;
 }
 
+/* #define TRACE_ID_DEBUG 1 */
+#ifdef TRACE_ID_DEBUG
+static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
+					  const char *func_name)
+{
+	/* currently 2 u64s are sufficient to hold all the ids */
+	pr_debug("%s id_map::\n", func_name);
+	pr_debug("Avial= 0x%016lx%016lx\n", id_map->avail_ids[1], id_map->avail_ids[0]);
+	pr_debug("Pend = 0x%016lx%016lx\n", id_map->pend_rel_ids[1], id_map->pend_rel_ids[0]);
+}
+#define DUMP_ID_MAP(map)   coresight_trace_id_dump_table(map, __func__)
+#define DUMP_ID_CPU(cpu, id) pr_debug("%s called;  cpu=%d, id=%d\n", __func__, cpu, id)
+#define DUMP_ID(id)   pr_debug("%s called; id=%d\n", __func__, id)
+#define PERF_SESSION(n) pr_debug("%s perf count %d\n", __func__, n)
+#else
+#define DUMP_ID_MAP(map)
+#define DUMP_ID(id)
+#define DUMP_ID_CPU(cpu, id)
+#define PERF_SESSION(n)
+#endif
+
 /* release all pending IDs for all current maps & clear CPU associations */
 static void coresight_trace_id_release_all_pending(void)
 {
@@ -81,6 +102,7 @@ static void coresight_trace_id_release_all_pending(void)
 		clear_bit(bit, id_map->avail_ids);
 		clear_bit(bit, id_map->pend_rel_ids);
 	}
+	DUMP_ID_MAP(id_map);
 
 	for_each_possible_cpu(cpu) {
 		if (per_cpu(cpu_ids, cpu).pend_rel) {
@@ -126,6 +148,8 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 
 get_cpu_id_out:
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -151,6 +175,8 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
 
  put_cpu_id_out:
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
@@ -164,6 +190,8 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
 		coresight_trace_id_set_inuse(id, id_map);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -174,6 +202,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 	spin_lock_irqsave(&id_map_lock, flags);
 	coresight_trace_id_clear_inuse(id, id_map);
 	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 }
 
 /* API functions */
@@ -207,6 +238,7 @@ void coresight_trace_id_perf_start(void)
 
 	spin_lock_irqsave(&id_map_lock, flags);
 	perf_cs_etm_session_active++;
+	PERF_SESSION(perf_cs_etm_session_active);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
@@ -217,6 +249,7 @@ void coresight_trace_id_perf_stop(void)
 
 	spin_lock_irqsave(&id_map_lock, flags);
 	perf_cs_etm_session_active--;
+	PERF_SESSION(perf_cs_etm_session_active);
 	if (!perf_cs_etm_session_active)
 		coresight_trace_id_release_all_pending();
 	spin_unlock_irqrestore(&id_map_lock, flags);
-- 
2.17.1

