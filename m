Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94645564F76
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiGDIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiGDIL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:11:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFDFB1E1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:11:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v14so12273543wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U50rZuxIKcDyH6WCrUs5gy3BPn7+6cStMsPigtR0Cnw=;
        b=TlL5fN2u1hMHkBXyo0T9bg+w/2FnSGw3S7p+PUIrq2HVUIxhT2dJmfcX2iM6yUbOMo
         plIXQkVCtXfY+ozK6Vc6Z1YcCOnKpXNwp3SA1noaevLiB1hM8QX/ge4RjFJjU9EtARwU
         3PH8aTWO4qDquViRqSiXLskWyQ2F6jH2Q1I0iCyJDJYrRSkiDmezA6jWgL6EZPuEYdmv
         0Pi508ochtpDkcfjN11g6EY4yg/c13BgkKZrg2RpjEEQdYAaG40JtnGlPQXfGI9Wnt/a
         ZnYnuTHeNrQpUHk833AIJ2GvJ9olErY0g/+Yar8OwXGsyYHnm348igDNYRK7hTp4Oq+V
         q/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U50rZuxIKcDyH6WCrUs5gy3BPn7+6cStMsPigtR0Cnw=;
        b=tISyqqEniq2oZFkhzMa2L57JCriHaM5a97QiKZFfLS93mxszhejvuCK8k2qtomEfEs
         21P2m4Xv7O3N5WmUgDj9xaJCRYvsFRu19fpjLUFgDopx4Is7DeTRuQn+V3+6qWn+I/7O
         x0T67WfMfzcnCO1qZo+Cjcm8p0WZN2t4MLo0ebAdiZJtku9G/WCxjqqIesSYvNXD+QRz
         Psj9Day5VEtecjrSmZ7vUoMjMDCw9hxMhEQcJv9FureARxc2ahA1k9Y9NPIrMjIXwFoH
         JS3p9fD6OelFDdelwsVwRDQhbh0lFK2WErTehOA9MsXlsf35TAOr2PBuzshVBVwr7PyZ
         wUTA==
X-Gm-Message-State: AJIora8Oi78tX3GYk7Lk+xShyD6/CO5PtxtQ6R5iqzx6CSIMFzPQI6Nm
        3F0FReI+7msYi/NSpRqa2qgZEA==
X-Google-Smtp-Source: AGRyM1t5p/dQFBSowEC4EVhbXgaZYU7RsUiPNxLT/4u8FeYgwHiArbQ8m3Phklcl+B16EhJX3nA1OQ==
X-Received: by 2002:a5d:62c4:0:b0:21b:c031:a94b with SMTP id o4-20020a5d62c4000000b0021bc031a94bmr25682399wrv.624.1656922316781;
        Mon, 04 Jul 2022 01:11:56 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:11:56 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 05/13] coresight: etm3x: Update ETM3 driver to use Trace ID API
Date:   Mon,  4 Jul 2022 09:11:41 +0100
Message-Id: <20220704081149.16797-6-mike.leach@linaro.org>
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

Use the TraceID API to allocate ETM trace IDs dynamically.

As with the etm4x we allocate on enable / disable for perf,
allocate on enable / reset for sysfs.

Additionally we allocate on sysfs file read as both perf and sysfs
can read the ID before enabling the hardware.

Remove sysfs option to write trace ID - which is inconsistent with
both the dynamic allocation method and the fixed allocation method
previously used.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h   |  2 +
 .../coresight/coresight-etm3x-core.c          | 68 +++++++++++++++++--
 .../coresight/coresight-etm3x-sysfs.c         | 28 +++-----
 3 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index f3ab96eaf44e..3667428d38b6 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -287,4 +287,6 @@ int etm_get_trace_id(struct etm_drvdata *drvdata);
 void etm_set_default(struct etm_config *config);
 void etm_config_trace_mode(struct etm_config *config);
 struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
+int etm_read_alloc_trace_id(struct etm_drvdata *drvdata);
+void etm_release_trace_id(struct etm_drvdata *drvdata);
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index d0ab9933472b..273f37be322b 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -32,6 +32,7 @@
 
 #include "coresight-etm.h"
 #include "coresight-etm-perf.h"
+#include "coresight-trace-id.h"
 
 /*
  * Not really modular but using module_param is the easiest way to
@@ -490,18 +491,61 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
+int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * This will allocate a trace ID to the cpu,
+	 * or return the one currently allocated.
+	 */
+	spin_lock(&drvdata->spinlock);
+	trace_id = drvdata->traceid;
+	if (!trace_id) {
+		trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+		if (trace_id > 0)
+			drvdata->traceid = (u8)trace_id;
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
+void etm_release_trace_id(struct etm_drvdata *drvdata)
+{
+	spin_lock(&drvdata->spinlock);
+	coresight_trace_id_put_cpu_id(drvdata->cpu);
+	drvdata->traceid = 0;
+	spin_unlock(&drvdata->spinlock);
+}
+
 static int etm_enable_perf(struct coresight_device *csdev,
 			   struct perf_event *event)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int ret;
 
 	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
 		return -EINVAL;
 
 	/* Configure the tracer based on the session's specifics */
 	etm_parse_event_config(drvdata, event);
+
+	/* allocate a trace ID */
+	ret = etm_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		return ret;
+
 	/* And enable it */
-	return etm_enable_hw(drvdata);
+	ret = etm_enable_hw(drvdata);
+
+	if (ret)
+		etm_release_trace_id(drvdata);
+	return ret;
 }
 
 static int etm_enable_sysfs(struct coresight_device *csdev)
@@ -510,6 +554,11 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	struct etm_enable_arg arg = { };
 	int ret;
 
+	/* allocate a trace ID */
+	ret = etm_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		return ret;
+
 	spin_lock(&drvdata->spinlock);
 
 	/*
@@ -532,6 +581,8 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 
 	if (!ret)
 		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
+	else
+		etm_release_trace_id(drvdata);
 	return ret;
 }
 
@@ -611,6 +662,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	coresight_disclaim_device_unlocked(csdev);
 
 	CS_LOCK(drvdata->base);
+
+	etm_release_trace_id(drvdata);
 }
 
 static void etm_disable_sysfs(struct coresight_device *csdev)
@@ -635,6 +688,13 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
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
 
@@ -781,11 +841,6 @@ static void etm_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static void etm_init_trace_id(struct etm_drvdata *drvdata)
-{
-	drvdata->traceid = coresight_get_trace_id(drvdata->cpu);
-}
-
 static int __init etm_hp_setup(void)
 {
 	int ret;
@@ -871,7 +926,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (etm_arch_supported(drvdata->arch) == false)
 		return -EINVAL;
 
-	etm_init_trace_id(drvdata);
 	etm_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 68fcbf4ce7a8..962d6ac96d64 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -86,6 +86,8 @@ static ssize_t reset_store(struct device *dev,
 
 		etm_set_default(config);
 		spin_unlock(&drvdata->spinlock);
+		/* release trace id outside the spinlock as this fn uses it */
+		etm_release_trace_id(drvdata);
 	}
 
 	return size;
@@ -1189,30 +1191,16 @@ static DEVICE_ATTR_RO(cpu);
 static ssize_t traceid_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	unsigned long val;
-	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	val = etm_get_trace_id(drvdata);
-
-	return sprintf(buf, "%#lx\n", val);
-}
-
-static ssize_t traceid_store(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t size)
-{
-	int ret;
-	unsigned long val;
+	int trace_id;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	ret = kstrtoul(buf, 16, &val);
-	if (ret)
-		return ret;
+	trace_id = etm_read_alloc_trace_id(drvdata);
+	if (trace_id < 0)
+		return trace_id;
 
-	drvdata->traceid = val & ETM_TRACEID_MASK;
-	return size;
+	return sprintf(buf, "%#x\n", trace_id);
 }
-static DEVICE_ATTR_RW(traceid);
+static DEVICE_ATTR_RO(traceid);
 
 static struct attribute *coresight_etm_attrs[] = {
 	&dev_attr_nr_addr_cmp.attr,
-- 
2.17.1

