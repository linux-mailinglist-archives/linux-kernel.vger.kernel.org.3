Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2911D564F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiGDIMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiGDIL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:11:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BBCB1EC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:11:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k7so12244349wrc.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gldn9rvF6v1FgHyQMd21plWEViWV+KFAmS14f6XtzZ8=;
        b=xMxPTKOf1wg8vITKGGApEvdQ1jKdas7OPRBZRHS6Nx8gbSDEMgjC9n/DAhCB1njjPS
         s928TQ08Du9RvmKK3Kv40GhgqNaoBRbO9XBZR7QdTnlrxSwCxcr/7H5fl80yKELH82B/
         r6VIAAm9qAs+pHCN02FHe+4CkXYxg8fqi8JZcS+q5R5QBl+QLGdRJgJKDJ7dcySZMVj6
         ysxm3yA0TsdwKVQpEDIvb6yywQMl7AzKl9YkKIA+/MCfC1WaC9Cs5obSM68CltmuUDmB
         nJFrh3R9ms0CWQ8GPrWQDnuCw6R65nlKX5HFxINC9swTrH55Wxiuol3Jap0Exeq4JGOv
         KKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gldn9rvF6v1FgHyQMd21plWEViWV+KFAmS14f6XtzZ8=;
        b=uDl3I4j29Ye0iG1IfCa7s2393WB6Ev5D72zyL0LqLGBUTXFJ3hZ+4jL/bo68LDMckJ
         yPr/Ls04ReqKodPzDYjcuprhY2VoGFhfcC3uaazFcwhyfklE03zwrKynzvAAgBLWRBmZ
         XVMvAwbnogfKvJot6X+yHaJVErr0VmyPCJQjEqOlMlWSfX0RTrNlfs8s3O13nBT55SkN
         vOa9GAvxcYymSEPEdD8MoYEqD2oSPKCikotHb7gwdyg9RAQtfc7caPHBfHTqTp7MxB48
         Qs60WZKfjnIsH1YWdtkvcfG6naIKsnDmTFtx24wEvsRdNB7Mc6x7trp3dCC+1RayI1aY
         se/A==
X-Gm-Message-State: AJIora/tY/JCsWpWTvEw2rr2UHb9/QG4g1QZcRkWo2DzvMgjTKW6Urou
        gNZB2RPC8uvwdG4BG23Q7MRHrg==
X-Google-Smtp-Source: AGRyM1sQedCuyj1o4tY5NnYeJ6qJzio2bvEnjJbR+u8HH+6e5GsxAfDR9qB6V8PNLxFmZLPxKU+yzQ==
X-Received: by 2002:a5d:47c8:0:b0:21d:2295:6a05 with SMTP id o8-20020a5d47c8000000b0021d22956a05mr25526635wrc.302.1656922315828;
        Mon, 04 Jul 2022 01:11:55 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:11:55 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 04/13] coresight: etm4x: Update ETM4 driver to use Trace ID API
Date:   Mon,  4 Jul 2022 09:11:40 +0100
Message-Id: <20220704081149.16797-5-mike.leach@linaro.org>
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

The trace ID API is now used to allocate trace IDs for ETM4.x / ETE
devices.

For perf sessions, these will be allocated on enable, and released on
disable.

For sysfs sessions, these will be allocated on enable, but only released
on reset. This allows the sysfs session to interrogate the Trace ID used
after the session is over - maintaining functional consistency with the
previous allocation scheme.

The trace ID will also be allocated on read of the mgmt/trctraceid file.
This ensures that if perf or sysfs read this before enabling trace, the
value will be the one used for the trace session.

Trace ID initialisation is removed from the _probe() function.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 65 +++++++++++++++++--
 .../coresight/coresight-etm4x-sysfs.c         | 32 ++++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
 3 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 87299e99dabb..3f4f7ddd14ec 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -42,6 +42,7 @@
 #include "coresight-etm4x-cfg.h"
 #include "coresight-self-hosted-trace.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static int boot_enable;
 module_param(boot_enable, int, 0444);
@@ -234,6 +235,38 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	return drvdata->trcid;
 }
 
+int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * This will allocate a trace ID to the cpu,
+	 * or return the one currently allocated.
+	 */
+	spin_lock(&drvdata->spinlock);
+	trace_id = drvdata->trcid;
+	if (!trace_id) {
+		trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+		if (trace_id > 0)
+			drvdata->trcid = (u8)trace_id;
+	}
+	spin_unlock(&drvdata->spinlock);
+
+	if (trace_id <= 0)
+		pr_err("Failed to allocate trace ID for %s on CPU%d\n",
+		       dev_name(&drvdata->csdev->dev), drvdata->cpu);
+
+	return trace_id;
+}
+
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
+{
+	spin_lock(&drvdata->spinlock);
+	coresight_trace_id_put_cpu_id(drvdata->cpu);
+	drvdata->trcid = 0;
+	spin_unlock(&drvdata->spinlock);
+}
+
 struct etm4_enable_arg {
 	struct etmv4_drvdata *drvdata;
 	int rc;
@@ -715,9 +748,18 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 	ret = etm4_parse_event_config(csdev, event);
 	if (ret)
 		goto out;
+
+	/* allocate a trace ID */
+	ret =  etm4_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		goto out;
+
 	/* And enable it */
 	ret = etm4_enable_hw(drvdata);
 
+	/* failed to enable */
+	if (ret)
+		etm4_release_trace_id(drvdata);
 out:
 	return ret;
 }
@@ -737,6 +779,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 			return ret;
 	}
 
+	/* allocate a trace ID */
+	ret = etm4_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		return ret;
+
 	spin_lock(&drvdata->spinlock);
 
 	/*
@@ -754,6 +801,8 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 
 	if (!ret)
 		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
+	else
+		etm4_release_trace_id(drvdata);
 	return ret;
 }
 
@@ -881,6 +930,9 @@ static int etm4_disable_perf(struct coresight_device *csdev,
 	/* TRCVICTLR::SSSTATUS, bit[9] */
 	filters->ssstatus = (control & BIT(9));
 
+	/* release trace ID - this may pend release if perf session is still active */
+	etm4_release_trace_id(drvdata);
+
 	return 0;
 }
 
@@ -906,6 +958,13 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
+	/*
+	 * unlike for perf session - we only release trace IDs when resetting
+	 * sysfs. This permits sysfs users to read the trace ID after the trace
+	 * session has completed. This maintains operational behaviour with
+	 * prior trace id allocation method
+	 */
+
 	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
 }
 
@@ -1548,11 +1607,6 @@ static int etm4_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
-{
-	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
-}
-
 static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
@@ -1957,7 +2011,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 6ea8181816fc..c7f896a020d9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -266,10 +266,11 @@ static ssize_t reset_store(struct device *dev,
 	config->vmid_mask0 = 0x0;
 	config->vmid_mask1 = 0x0;
 
-	drvdata->trcid = drvdata->cpu + 1;
-
 	spin_unlock(&drvdata->spinlock);
 
+	/* for sysfs - only release trace id when resetting */
+	etm4_release_trace_id(drvdata);
+
 	cscfg_csdev_reset_feats(to_coresight_device(dev));
 
 	return size;
@@ -2363,6 +2364,31 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	NULL,
 };
 
+/*
+ * Trace ID allocated dynamically on enable - but also allocate on read
+ * in case sysfs or perf read before enable to ensure consistent metadata
+ * information for trace decode
+ */
+static ssize_t trctraceid_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int trace_id;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	trace_id = etm4_read_alloc_trace_id(drvdata);
+	if (trace_id < 0)
+		return trace_id;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", trace_id);
+}
+
+/* mgmt group uses extended attributes - no standard macro available */
+static struct dev_ext_attribute dev_attr_trctraceid = {
+		__ATTR(trctraceid, 0444, trctraceid_show, NULL),
+		(void *)(unsigned long)TRCTRACEIDR
+};
+
 struct etmv4_reg {
 	struct coresight_device *csdev;
 	u32 offset;
@@ -2499,7 +2525,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
 	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
 	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
-	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
+	&dev_attr_trctraceid.attr.attr,
 	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
 	NULL,
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 33869c1d20c3..e0a9d334375d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1094,4 +1094,7 @@ static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
 {
 	return drvdata->arch >= ETM_ARCH_ETE;
 }
+
+int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata);
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata);
 #endif
-- 
2.17.1

