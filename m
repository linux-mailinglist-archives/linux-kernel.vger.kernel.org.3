Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A5E59DC61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356417AbiHWKu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356650AbiHWKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:42:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D55AA3FF
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so7376078wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=b8QxQCJ25QZgAW9TMuRyRpDmgZMECJ+/SrX42m5XPuc=;
        b=lkpoDcMfFmaKMd/sRC30ovKRuPWk7lYabCy0ASCYU3O+oRYk873S/sh3o5T05Ra7dn
         Ymq5Oq4F4OK6HzQUnUP4jH4X4Lipwa4w6cNYK/MgJGpu/fr0JosjaCNwTQQUV2bXKqZx
         YiH2+nkYlaojGs3yurhtuJ3O2Bp39Bc8OC/IjomgHzFRrzHcDyBrfsl6gNBUG/X4pfFv
         jPB2ttrwKAbdjQfw8SmFu3ucgKVs4JYEn8+Pl+l2nVYFF0KyMJdkchfbnaEK9Zqs+AWB
         ajzKIeVv+sJaaG0s9UQaPnuDE9BQcuhh8A9zJe7Sg/Q2uQfXmOJhHSt8S/a+MnObiMFm
         YwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=b8QxQCJ25QZgAW9TMuRyRpDmgZMECJ+/SrX42m5XPuc=;
        b=bDSQYJghpzbUe/L/FRbOns6rsCLwc/X4nzQWjF6+J6Avj7+ewPp4Y5wyDqUL2RoNAG
         XTVAEEeyyVqND5zfZh5QzeqpFniwSZKKGxl/ANfe2PYOU2Pzb2vAv3joR9SL/2f/mGOH
         7i6FWjhfVDa6HE7ptHYbO8JvhfIuV5UxY19V2q2pc8i7n9989dVIGLbvL+E+1xzzMEeW
         aWD51TWbszkhd8r6JacOrOiEIGOfTSuk97/V+2KggOGDdQ2PLx11CmxGixGBvrmDKr8V
         D5PASJNyrX5Gxmy0LA9zMQHNQnfLeY9UsoMC4yXnYsEhMwSQjkRp+Hy5rduTwfum419I
         Vkfg==
X-Gm-Message-State: ACgBeo3BwmbqnMGlQhVW16PpDSVesWxqxBWZn7VSlhSuOb6tpxyjD03e
        O+N9co7Loz/3D3biw2u7hDQORg==
X-Google-Smtp-Source: AA6agR6vinJOf8bdMMjFtTGJXGihegT4t4tbYjVUa60nuu1M0gxNhKqCOcdTa7yMvUj6J8rPgukAlQ==
X-Received: by 2002:a1c:7518:0:b0:3a5:1681:b175 with SMTP id o24-20020a1c7518000000b003a51681b175mr1445390wmc.139.1661245814503;
        Tue, 23 Aug 2022 02:10:14 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:13 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 01/13] coresight: trace-id: Add API to dynamically assign Trace ID values
Date:   Tue, 23 Aug 2022 10:09:57 +0100
Message-Id: <20220823091009.14121-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing mechanism to assign Trace ID values to sources is limited
and does not scale for larger multicore / multi trace source systems.

The API introduces functions that reserve IDs based on availabilty
represented by a coresight_trace_id_map structure. This records the
used and free IDs in a bitmap.

CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id /
coresight_trace_id_put_cpu_id pair of functions. The API will record
the ID associated with the CPU. This ensures that the same ID will be
re-used while perf events are active on the CPU. The put_cpu_id function
will pend release of the ID until all perf cs_etm sessions are complete.

Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
coresight_trace_id_put_system_id.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |   4 +
 .../hwtracing/coresight/coresight-trace-id.c  | 230 ++++++++++++++++++
 .../hwtracing/coresight/coresight-trace-id.h  |  78 ++++++
 include/linux/coresight-pmu.h                 |  23 +-
 5 files changed, 324 insertions(+), 13 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index b6c4a48140ec..329a0c704b87 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
 		coresight-cfg-preload.o coresight-cfg-afdo.o \
-		coresight-syscfg-configfs.o
+		coresight-syscfg-configfs.o coresight-trace-id.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 1edfec1e9d18..c7b7c518a0a3 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -22,6 +22,7 @@
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static DEFINE_MUTEX(coresight_mutex);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
@@ -1775,6 +1776,9 @@ static int __init coresight_init(void)
 	if (ret)
 		goto exit_bus_unregister;
 
+	/* initialise the trace ID allocator */
+	coresight_trace_id_init();
+
 	/* initialise the coresight syscfg API */
 	ret = cscfg_init();
 	if (!ret)
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
new file mode 100644
index 000000000000..ac9092896dec
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+#include <linux/coresight-pmu.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "coresight-trace-id.h"
+
+/* need to keep data on ids & association with cpus. */
+struct cpu_id_info {
+	atomic_t id;
+	bool pend_rel;
+};
+
+/* default trace ID map. Used for systems that do not require per sink mappings */
+static struct coresight_trace_id_map id_map_default;
+
+/* maintain a record of the current mapping of cpu IDs */
+static DEFINE_PER_CPU(struct cpu_id_info, cpu_ids);
+
+/* perf session active counter */
+static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
+
+/* lock to protect id_map and cpu data  */
+static DEFINE_SPINLOCK(id_map_lock);
+
+/*
+ * allocate new ID and set in use
+ * if @preferred_id is a valid id then try to use that value if available.
+ */
+static int coresight_trace_id_alloc_new_id(struct coresight_trace_id_map *id_map,
+					   int preferred_id)
+{
+	int id;
+
+	/* for backwards compatibility reasons, cpu Ids may have a preferred value */
+	if (IS_VALID_ID(preferred_id) && !test_bit(preferred_id, id_map->used_ids))
+		id = preferred_id;
+	else {
+		/* skip reserved bit 0, look from bit 1 to CORESIGHT_TRACE_ID_RES_TOP */
+		id = find_next_zero_bit(id_map->used_ids, 1, CORESIGHT_TRACE_ID_RES_TOP);
+		if (id >= CORESIGHT_TRACE_ID_RES_TOP)
+			return -EINVAL;
+	}
+
+	/* mark as used */
+	set_bit(id, id_map->used_ids);
+	return id;
+}
+
+static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_map)
+{
+	if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
+		return;
+	if (WARN(!test_bit(id, id_map->used_ids),
+		 "%s: Freeing unused ID %d\n", __func__, id))
+		return;
+	clear_bit(id, id_map->used_ids);
+}
+
+static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
+{
+	if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
+		return;
+	set_bit(id, id_map->pend_rel_ids);
+}
+
+/* release all pending IDs for all current maps & clear CPU associations */
+static void coresight_trace_id_release_all_pending(void)
+{
+	struct coresight_trace_id_map *id_map = &id_map_default;
+	unsigned long flags;
+	int cpu, bit;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_ID_RES_TOP) {
+		clear_bit(bit, id_map->used_ids);
+		clear_bit(bit, id_map->pend_rel_ids);
+	}
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(cpu_ids, cpu).pend_rel) {
+			per_cpu(cpu_ids, cpu).pend_rel = false;
+			atomic_set(&per_cpu(cpu_ids, cpu).id, 0);
+		}
+	}
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+
+static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int id;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+
+	/* check for existing allocation for this CPU */
+	id = atomic_read(&per_cpu(cpu_ids, cpu).id);
+	if (id)
+		goto get_cpu_id_out;
+
+	/*
+	 * Find a new ID.
+	 *
+	 * Use legacy values where possible in the dynamic trace ID allocator to
+	 * allow tools like Android simpleperf to continue working if they are not
+	 * upgraded at the same time as the kernel drivers.
+	 *
+	 * If the generated legacy ID is invalid, or not available then the next
+	 * available dynamic ID will be used.
+	 */
+	id = coresight_trace_id_alloc_new_id(id_map, CORESIGHT_LEGACY_CPU_TRACE_ID(cpu));
+	if (IS_VALID_ID(id)) {
+		/* got a valid new ID - save details */
+		atomic_set(&per_cpu(cpu_ids, cpu).id, id);
+		per_cpu(cpu_ids, cpu).pend_rel = false;
+		clear_bit(id, id_map->pend_rel_ids);
+	}
+
+get_cpu_id_out:
+	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	return id;
+}
+
+static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int id;
+
+	/* check for existing allocation for this CPU */
+	id = atomic_read(&per_cpu(cpu_ids, cpu).id);
+	if (!id)
+		goto put_cpu_id_out;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+
+	if (atomic_read(&perf_cs_etm_session_active)) {
+		/* set release at pending if perf still active */
+		coresight_trace_id_set_pend_rel(id, id_map);
+		per_cpu(cpu_ids, cpu).pend_rel = true;
+	} else {
+		/* otherwise clear id */
+		coresight_trace_id_free(id, id_map);
+		atomic_set(&per_cpu(cpu_ids, cpu).id, 0);
+	}
+
+	spin_unlock_irqrestore(&id_map_lock, flags);
+put_cpu_id_out:
+}
+
+static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int id;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	id = coresight_trace_id_alloc_new_id(id_map, 0);
+	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	return id;
+}
+
+static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *id_map, int id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	coresight_trace_id_free(id, id_map);
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+
+/* API functions */
+int coresight_trace_id_get_cpu_id(int cpu)
+{
+	return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
+
+void coresight_trace_id_put_cpu_id(int cpu)
+{
+	coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
+
+int coresight_trace_id_read_cpu_id(int cpu)
+{
+	return atomic_read(&per_cpu(cpu_ids, cpu).id);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
+
+int coresight_trace_id_get_system_id(void)
+{
+	return coresight_trace_id_map_get_system_id(&id_map_default);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
+
+void coresight_trace_id_put_system_id(int id)
+{
+	coresight_trace_id_map_put_system_id(&id_map_default, id);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
+
+void coresight_trace_id_perf_start(void)
+{
+	atomic_inc(&perf_cs_etm_session_active);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
+
+void coresight_trace_id_perf_stop(void)
+{
+	if (!atomic_dec_return(&perf_cs_etm_session_active))
+		coresight_trace_id_release_all_pending();
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
+
+void coresight_trace_id_init(void)
+{
+	int cpu;
+
+	/* initialise the atomic trace ID values */
+	for_each_possible_cpu(cpu) {
+		per_cpu(cpu_ids, cpu).pend_rel = false;
+		atomic_set(&per_cpu(cpu_ids, cpu).id, 0);
+	}
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_init);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
new file mode 100644
index 000000000000..0172f83a80bb
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(C) 2022 Linaro Limited. All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_TRACE_ID_H
+#define _CORESIGHT_TRACE_ID_H
+
+/*
+ * Coresight trace ID allocation API
+ *
+ * With multi cpu systems, and more additional trace sources a scalable
+ * trace ID reservation system is required.
+ *
+ * The system will allocate Ids on a demand basis, and allow them to be
+ * released when done.
+ *
+ * In order to ensure that a consistent cpu / ID matching is maintained
+ * throughout a perf cs_etm event session - a session in progress flag will
+ * be maintained, and released IDs not cleared until the perf session is
+ * complete. This allows the same CPU to be re-allocated its prior ID.
+ *
+ *
+ * Trace ID maps will be created and initialised to prevent architecturally
+ * reserved IDs from being allocated.
+ *
+ * API permits multiple maps to be maintained - for large systems where
+ * different sets of cpus trace into different independent sinks.
+ */
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+
+/* architecturally we have 128 IDs some of which are reserved */
+#define CORESIGHT_TRACE_IDS_MAX 128
+
+/* ID 0 is reserved */
+#define CORESIGHT_TRACE_ID_RES_0 0
+
+/* ID 0x70 onwards are reserved */
+#define CORESIGHT_TRACE_ID_RES_TOP 0x70
+
+/* check an ID is in the valid range */
+#define IS_VALID_ID(id)	\
+	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
+
+/**
+ * Trace ID map.
+ *
+ * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
+ *		Initialised so that the reserved IDs are permanently marked as in use.
+ * @pend_rel_ids: CPU IDs that have been released by the trace source but not yet marked
+ *                as available, to allow re-allocation to the same CPU during a perf session.
+ */
+struct coresight_trace_id_map {
+	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
+	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
+};
+
+/* Allocate and release IDs for a single default trace ID map */
+int coresight_trace_id_get_cpu_id(int cpu);
+int coresight_trace_id_get_system_id(void);
+void coresight_trace_id_put_cpu_id(int cpu);
+void coresight_trace_id_put_system_id(int id);
+
+/* read without allocate */
+int coresight_trace_id_read_cpu_id(int cpu);
+
+/* notifiers for perf session start and stop */
+void coresight_trace_id_perf_start(void);
+void coresight_trace_id_perf_stop(void);
+
+/* initialisation */
+void coresight_trace_id_init(void);
+
+#endif /* _CORESIGHT_TRACE_ID_H */
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 6c2fd6cc5a98..99bc3cc6bf2d 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -8,7 +8,17 @@
 #define _LINUX_CORESIGHT_PMU_H
 
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
-#define CORESIGHT_ETM_PMU_SEED  0x10
+
+/*
+ * The legacy Trace ID system based on fixed calculation from the cpu
+ * number. This has been replaced by drivers using a dynamic allocation
+ * system - but need to retain the legacy algorithm for backward comparibility
+ * in certain situations:-
+ * a) new perf running on older systems that generate the legacy mapping
+ * b) older tools e.g. simpleperf in Android, that may not update at the same
+ *    time as the kernel.
+ */
+#define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
 
 /*
  * Below are the definition of bit offsets for perf option, and works as
@@ -34,15 +44,4 @@
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
-- 
2.17.1

