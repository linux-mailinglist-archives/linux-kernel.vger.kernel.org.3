Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340424D22E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350309AbiCHUvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350282AbiCHUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D07831528
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:50:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so2146412wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PHSx/CGWMYUlu4wfKzSTY+tbrWqGA6GP82ZeBxk1Lzk=;
        b=FFxv76yzgplTv6GmbwjqP2KTAP0fO1pv6j9vKEfaNA7rjuHxVYNoqcO/hv3Kd38I6N
         8V6f5WCHhE4xVDac3cAJ09smoBshtV2NA7Dz8jS2aWwm1e5QX0dUlN8+T5Ob4pYgidUr
         C8MyOlY/Cd4PJOJCUeX5DkcXPcH0ClvPqxvSP+3pa8+uUmtpTz6QcoG8NaD6ZGaCYP3y
         h3SHHWfn965L0dc8bFOzdsoQoWOVzrq0ONOxyMJQreSQCnvOWbVvbztEYimxmhDBkamn
         NKSmAuSRzMXLgDmTGtNaVcVpdZZWEUTkv37rC9BKeR1aKvf+aPnpbCmMGi/EhkRSAQp4
         tpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PHSx/CGWMYUlu4wfKzSTY+tbrWqGA6GP82ZeBxk1Lzk=;
        b=4WbdRPhjiCbu5czfq3O2zQS/a8LuZL1nHfcqOzziJPfBMPhhZbxeaEnq2bEYYqBDJC
         li3iOGp8Rq5Y7jab7wayP2PQIh7zufShB5JWiVeU2Z79TObqcC+Tj2lm1GwNn1Tz/J3C
         aui4q5eEaGa+Lcr2lpe2QhnSJWhM4Ddtr3eDWKjpSB2zcWTZ0K1JJ2Wk+9F64AZbJF2S
         XIRO+FtSF3P00GVemni8aXLZpcSwGi7P9RMBT0mntNZP0BXZHFFT/Bh2e6rGVN+TZI8i
         rYV81aoA4oYk4GE8kztSBNt6sHMczJLoaJuUVRqFwt/UXZJj7pBFyabAp5AgANrc50qD
         oLXg==
X-Gm-Message-State: AOAM5308BP9iPoKQcrF8lPWLRjmY1BeDwqeb642miEKqC3/paJ2+SwMb
        uC60xClbk5haz+cu70WolzL1gA==
X-Google-Smtp-Source: ABdhPJxuIeR2m4zNxfUyYASFYOKIh8/CDI0v7ZJC7WkpdaLt1APzLOJJGd+g+c1MY0JYa5bD9EkHBQ==
X-Received: by 2002:a1c:7c0a:0:b0:389:8d53:260e with SMTP id x10-20020a1c7c0a000000b003898d53260emr857663wmc.69.1646772608200;
        Tue, 08 Mar 2022 12:50:08 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:07 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 04/10] coresight: etm4x: Use trace ID API to dynamically allocate trace ID
Date:   Tue,  8 Mar 2022 20:49:54 +0000
Message-Id: <20220308205000.27646-5-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220308205000.27646-1-mike.leach@linaro.org>
References: <20220308205000.27646-1-mike.leach@linaro.org>
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
 .../coresight/coresight-etm4x-core.c          | 63 +++++++++++++++++--
 .../coresight/coresight-etm4x-sysfs.c         | 32 +++++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
 3 files changed, 89 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 7f416a12000e..aa7ea5ad8b06 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -42,6 +42,7 @@
 #include "coresight-etm4x-cfg.h"
 #include "coresight-self-hosted-trace.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static int boot_enable;
 module_param(boot_enable, int, 0444);
@@ -234,6 +235,36 @@ static int etm4_trace_id(struct coresight_device *csdev)
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
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu,
+						 coresight_get_trace_id_map());
+	if (trace_id > 0) {
+		spin_lock(&drvdata->spinlock);
+		drvdata->trcid = (u8)trace_id;
+		spin_unlock(&drvdata->spinlock);
+	} else {
+		pr_err("Failed to allocate trace ID for %s on CPU%d\n",
+		       dev_name(&drvdata->csdev->dev), drvdata->cpu);
+	}
+	return trace_id;
+}
+
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
+{
+	coresight_trace_id_put_cpu_id(drvdata->cpu,
+				      coresight_get_trace_id_map());
+	spin_lock(&drvdata->spinlock);
+	drvdata->trcid = 0;
+	spin_unlock(&drvdata->spinlock);
+}
+
 struct etm4_enable_arg {
 	struct etmv4_drvdata *drvdata;
 	int rc;
@@ -717,9 +748,18 @@ static int etm4_enable_perf(struct coresight_device *csdev,
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
@@ -739,6 +779,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 			return ret;
 	}
 
+	/* allocate a trace ID */
+	ret = etm4_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		return ret;
+
 	spin_lock(&drvdata->spinlock);
 
 	/*
@@ -756,6 +801,8 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 
 	if (!ret)
 		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
+	else
+		etm4_release_trace_id(drvdata);
 	return ret;
 }
 
@@ -883,6 +930,9 @@ static int etm4_disable_perf(struct coresight_device *csdev,
 	/* TRCVICTLR::SSSTATUS, bit[9] */
 	filters->ssstatus = (control & BIT(9));
 
+	/* release trace ID - this may pend release if perf session is still active */
+	etm4_release_trace_id(drvdata);
+
 	return 0;
 }
 
@@ -908,6 +958,13 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
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
 
@@ -1596,11 +1653,6 @@ static int etm4_dying_cpu(unsigned int cpu)
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
@@ -2005,7 +2057,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 21687cc1e4e2..bb69a203b833 100644
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
@@ -2355,6 +2356,31 @@ static struct attribute *coresight_etmv4_attrs[] = {
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
@@ -2491,7 +2517,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
 	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
 	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
-	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
+	&dev_attr_trctraceid.attr.attr,
 	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
 	NULL,
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 3c4d69b096ca..64976a00c839 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1010,4 +1010,7 @@ static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
 {
 	return drvdata->arch >= ETM_ARCH_ETE;
 }
+
+int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata);
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata);
 #endif
-- 
2.17.1

