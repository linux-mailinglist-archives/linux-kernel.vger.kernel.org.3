Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2150B4D22EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350343AbiCHUvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350318AbiCHUvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451A539808
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:50:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so2185020wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xe7R99xlGwoKuAS3wrEqyXZp3yI8XEYJM9lw/vO8NYg=;
        b=tYKOgv1979h8LZb91Na6znYmERgLvMDR7BoDXLdax/BqQ5weQ/1uUEHgSLUszHDlD7
         jpvArASGGFcjWsazR23WkbFIGp+xXkEte8YuhAToaW5OLSP8xUQVzqBWShV7CYRFC17I
         iotPeM9M2Jfz4jVPc19tYkhb9putbA5hNz75MLVcwyGZNVpKrWPFGP83qWNa+2M3hOKX
         XYneBkZHPwRMyIH6fDSG6Eg/noA3nnO3qgQU9KZM9ItcnNb0kKp/+C28SKCP1sV3sGF4
         y2EFsy1+PuyjUcr/V99Sygk36cNEsxI12lislEK8hOhFdYc8LaEukpEzATYfuyL3IRNn
         MwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xe7R99xlGwoKuAS3wrEqyXZp3yI8XEYJM9lw/vO8NYg=;
        b=DXFIO0nHIbyh9UExfkIzenbDvOFtcrzxqKto5wUQFp9nVGLFqKlPSyrwN6sBQqno4i
         +umlPXLbvsksmucMmOerbmtFapQjFZ3vaCOdoUAM4/+U+DQsxByWVVtDOOOpCSJabKbd
         pGX7sj0RdwdbrNKoVm4Ef49vl5BqpRRUJJjGi3niZRqxMs+WMqiy/XVRhY4I/wlqe1Cx
         aH7nMhmQT9rMFfVzpMFbrd7D2u4QBC4uw5+eq7E56hVrhXWO0uVssghHaoz2IaTPSQGg
         7elHE9BuM7YTteyToBuPTokF6TzboOO+wA/wm18xaRbMKSXLoRoRbobxuEd3DkW4lE3z
         rcsA==
X-Gm-Message-State: AOAM532PjxN5dz60slgy+n4WzudxNIGMmmIVIirL3Wm43GjK/G4QBG49
        rhgJ4MZy33P8Gy5KxlFqwjnf2A==
X-Google-Smtp-Source: ABdhPJxCHJnxJZE/r6ZL7nJ0y7w9OoRJ4o+m2KyamsuT/8NnTRDXGrRnqDN1KOnJRNiJide62pdVkA==
X-Received: by 2002:a05:600c:3ac3:b0:389:adb4:e7a1 with SMTP id d3-20020a05600c3ac300b00389adb4e7a1mr852701wms.136.1646772612778;
        Tue, 08 Mar 2022 12:50:12 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:12 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 10/10] coresight: trace-id: Add debug & test macros to trace id allocation
Date:   Tue,  8 Mar 2022 20:50:00 +0000
Message-Id: <20220308205000.27646-11-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220308205000.27646-1-mike.leach@linaro.org>
References: <20220308205000.27646-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index ce6c7d7b55d6..8dcb698b8899 100644
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
@@ -82,6 +103,7 @@ static void coresight_trace_id_release_all_pending(void)
 			clear_bit(bit, id_map->avail_ids);
 			clear_bit(bit, id_map->pend_rel_ids);
 		}
+		DUMP_ID_MAP(id_map);
 	}
 
 	for_each_possible_cpu(cpu) {
@@ -112,6 +134,8 @@ int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map
 
 get_cpu_id_out:
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
@@ -138,6 +162,8 @@ void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_ma
 
  put_cpu_id_out:
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
 
@@ -152,6 +178,8 @@ int coresight_trace_id_get_system_id(struct coresight_trace_id_map *id_map)
 		coresight_trace_id_set_inuse(id, id_map);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
@@ -163,6 +191,9 @@ void coresight_trace_id_put_system_id(struct coresight_trace_id_map *id_map, int
 	spin_lock_irqsave(&id_map_lock, flags);
 	coresight_trace_id_clear_inuse(id, id_map);
 	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
 
@@ -172,6 +203,7 @@ void coresight_trace_id_perf_start(void)
 
 	spin_lock_irqsave(&id_map_lock, flags);
 	perf_cs_etm_session_active++;
+	PERF_SESSION(perf_cs_etm_session_active);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
@@ -182,6 +214,7 @@ void coresight_trace_id_perf_stop(void)
 
 	spin_lock_irqsave(&id_map_lock, flags);
 	perf_cs_etm_session_active--;
+	PERF_SESSION(perf_cs_etm_session_active);
 	if (!perf_cs_etm_session_active)
 		coresight_trace_id_release_all_pending();
 	spin_unlock_irqrestore(&id_map_lock, flags);
-- 
2.17.1

