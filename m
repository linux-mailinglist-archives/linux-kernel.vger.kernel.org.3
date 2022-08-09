Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5545758E348
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiHIWes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHIWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F056564F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:34:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso146796wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wxLiAf3ETI1pUKkDvOtNy10A8Mz8Sbg3o01abH5defc=;
        b=KCzNW6iXx+JciL+nW7HaUSlGA+h6fhknRlk7v5x16rl9fhYKRigN3OYnHoy6S8h+hd
         pORhebL+Ewn5nfuEY+eiaQvSgW7T8HlMuEVKPG1LFhxvXLFxxAKuHQVumeLZsvx9S2jm
         qsyNkS7rJo9wSNoPLwi8tOuG+WCt50PhpYSxnFix1AWxAdZThJ6buvl9emjSEFXzrFOX
         4ZPzoGNGHIi5QzQ8m5s7TQtOBiKjxMYNat0m5/oIKcBECORF5jOWFCzvJnf57CcZssQR
         91c//uP3dWkPktHrweC/h0St/Tz5oi9FNwqEo1fnbIOigrgS1sSXqCgotEaw9nyOCPTV
         4EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wxLiAf3ETI1pUKkDvOtNy10A8Mz8Sbg3o01abH5defc=;
        b=FTrcILpD7wKKZMkesdwh84XccirClxAmUZLPNqU99hM/gqc30fz3rlh+eTBSt90smG
         NW3VuHG7ElhenMuJAOHLEBpoWrX+4v8jzL7K8acbFqBjExe0soWfqwWs93HJ0yEf1MLL
         UZpNCOvKbqNA42eHqg8iQ3NPiihPc4F9/OMzpn+ftIggjd1I7EADXyeUUwhxFcTX70Ls
         PVtYa8vyQ3SbRaB+GTZJEkb3URcZz666mT0dImxhIegNjFHiDT2reqRzj8Qfwr1w82wZ
         mnsOPIiu8ZRNB50QiCTOkBATZA7GebL4YWhUJzFGGr3x+DcvlYRDFGc2Ri64qquROZIN
         we0Q==
X-Gm-Message-State: ACgBeo2+cWRkF9ft8sNxislC+YrQQ1Ujkru/ECIyrEulpXlvErLSM977
        8X/VvDwfPik9AVeGkfjLRfsODIZF9SCB0mrs
X-Google-Smtp-Source: AA6agR5bZ/JM9HGE4LUMq0ZpCB/ENuYlI66QngS58tZ2ghWduxWK4pJhqZi3PTZi6Kx9U5URLNpgDg==
X-Received: by 2002:a05:600c:4f0e:b0:3a3:44ee:d40b with SMTP id l14-20020a05600c4f0e00b003a344eed40bmr297237wmq.199.1660084450264;
        Tue, 09 Aug 2022 15:34:10 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:09 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 04/13] coresight: etm4x: Update ETM4 driver to use Trace ID API
Date:   Tue,  9 Aug 2022 23:33:52 +0100
Message-Id: <20220809223401.24599-5-mike.leach@linaro.org>
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
 .../coresight/coresight-etm4x-core.c          | 79 +++++++++++++++++--
 .../coresight/coresight-etm4x-sysfs.c         | 27 ++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
 3 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index cf249ecad5a5..b4fb28ce89fd 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -42,6 +42,7 @@
 #include "coresight-etm4x-cfg.h"
 #include "coresight-self-hosted-trace.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static int boot_enable;
 module_param(boot_enable, int, 0444);
@@ -234,6 +235,50 @@ static int etm4_trace_id(struct coresight_device *csdev)
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
+	/* trace id function has its own lock */
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+	if (IS_VALID_ID(trace_id))
+		drvdata->trcid = (u8)trace_id;
+	else
+		dev_err(&drvdata->csdev->dev,
+			"Failed to allocate trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+	return trace_id;
+}
+
+static int etm4_set_current_trace_id(struct etmv4_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * Set the currently allocated trace ID - perf allocates IDs
+	 * as part of setup_aux for all CPUs it may use.
+	 */
+	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
+	if (IS_VALID_ID(trace_id)) {
+		drvdata->trcid = (u8)trace_id;
+		return 0;
+	}
+
+	dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
+		dev_name(&drvdata->csdev->dev), drvdata->cpu);
+
+	return -EINVAL;
+}
+
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
+{
+	coresight_trace_id_put_cpu_id(drvdata->cpu);
+}
+
 struct etm4_enable_arg {
 	struct etmv4_drvdata *drvdata;
 	int rc;
@@ -729,6 +774,15 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 	ret = etm4_parse_event_config(csdev, event);
 	if (ret)
 		goto out;
+
+	/*
+	 * perf allocates cpu ids as part of setup - device needs to use
+	 * the allocated ID.
+	 */
+	ret = etm4_set_current_trace_id(drvdata);
+	if (ret < 0)
+		goto out;
+
 	/* And enable it */
 	ret = etm4_enable_hw(drvdata);
 
@@ -753,6 +807,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 
 	spin_lock(&drvdata->spinlock);
 
+	/* sysfs needs to read and allocate a trace ID */
+	ret = etm4_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		goto unlock_sysfs_enable;
+
 	/*
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
 	 * ensures that register writes occur when cpu is powered.
@@ -764,6 +823,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 		ret = arg.rc;
 	if (!ret)
 		drvdata->sticky_enable = true;
+
+	if (ret)
+		etm4_release_trace_id(drvdata);
+
+unlock_sysfs_enable:
 	spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
@@ -895,6 +959,8 @@ static int etm4_disable_perf(struct coresight_device *csdev,
 	/* TRCVICTLR::SSSTATUS, bit[9] */
 	filters->ssstatus = (control & BIT(9));
 
+	/* The perf event will release trace ids when it is destroyed */
+
 	return 0;
 }
 
@@ -920,6 +986,13 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
+	/*
+	 * we only release trace IDs when resetting sysfs.
+	 * This permits sysfs users to read the trace ID after the trace
+	 * session has completed. This maintains operational behaviour with
+	 * prior trace id allocation method
+	 */
+
 	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
 }
 
@@ -1562,11 +1635,6 @@ static int etm4_dying_cpu(unsigned int cpu)
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
@@ -1971,7 +2039,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 6ea8181816fc..d3c27c521d43 100644
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
@@ -2363,6 +2364,26 @@ static struct attribute *coresight_etmv4_attrs[] = {
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
+	return sysfs_emit(buf, "0x%x\n", trace_id);
+}
+static DEVICE_ATTR_RO(trctraceid);
+
 struct etmv4_reg {
 	struct coresight_device *csdev;
 	u32 offset;
@@ -2499,7 +2520,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
 	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
 	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
-	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
+	&dev_attr_trctraceid.attr,
 	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
 	NULL,
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index a7bfea31f7d8..793c361841d4 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1095,4 +1095,7 @@ static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
 {
 	return drvdata->arch >= ETM_ARCH_ETE;
 }
+
+int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata);
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata);
 #endif
-- 
2.17.1

