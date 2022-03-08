Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599F34D22EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349438AbiCHUvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350287AbiCHUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:07 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7CE3207D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:50:10 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso2004429wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3UYsDt0yevSXQ6U7sc5n3heP9iPsGQbfHAheP1SRQC0=;
        b=auI060en4E3ZPAf8X25iTbQJE8jh5ycpsEJ5Q8k7glIQpTu8k3NDu6+Qv7ksLDRFxi
         7tOUzoOCvNJDXLw42STAF1r+vkHThpNcFIEe7bOQ9/f89XwPXxexWwaew2CGGsRHF3eq
         qgjwsx72XgAmSrIs9mDQImHczWZSxZPsAcUfmAVM+ZosIfrxVQ4B+Rx/d+iEv5NBN+e4
         xqnHbdf/ICU1VMl1Dp3NKNQUUrRqBGlQPxYsEKAtGNi0E5DJdZTBEwt2TG4p4Qx5NsaG
         RLTNPpCPB0ijF0HN4rX3O1RMFjP2iWHfmqjfnIT3LbAKzSpP3hcZZYLZOzH/bxtFE1wg
         a6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3UYsDt0yevSXQ6U7sc5n3heP9iPsGQbfHAheP1SRQC0=;
        b=yEkK8r0kuaAEKf760CS3j6VNyeJWMZ4fesYDiNSaVkjIfoMD7VaUh6kw4fLBTIs/nj
         2N7Ba7rQuX7BLTbcA0T8ePymXnqhcjwMa4Sc7dPqbft5MMq1drT6STmOlflKLg4dSQk2
         HEtNi+KrT7oHsFr+o/JF67GvlKr/OBAoA/TeYgiOVhJQ0BrEpqexSQT5ko/k1eWe/QrA
         VjuYh1GExpRXKv7BZsArjMKGoPRHl0Mq9+6AkxniNIS05CRqcWIRy0vZ/4VVqivxkGWQ
         PbuHu4p0I40WLXuplzmgwwhuvhzHByMY/GCJUEvGRuw1GFBAtMVRQkUH+3qavjyzvE/V
         sFGA==
X-Gm-Message-State: AOAM532sHSlK5AZtozy/li7bOb2yEBklY+68peYyX0ol7YrtFtHe0Z09
        Y62JspNZwH05vblK7JRlgzu3fg==
X-Google-Smtp-Source: ABdhPJy4EpWC1e2s5DMrlTr7d8Uw23sh3sZffOhSADmfSzqqHMRWiAp9osQRbbcU/vCgll2yOS2sNg==
X-Received: by 2002:a05:600c:b4d:b0:382:ab98:f470 with SMTP id k13-20020a05600c0b4d00b00382ab98f470mr890047wmr.8.1646772608956;
        Tue, 08 Mar 2022 12:50:08 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:08 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 05/10] coresight: etm3x: Use trace ID API to allocate IDs
Date:   Tue,  8 Mar 2022 20:49:55 +0000
Message-Id: <20220308205000.27646-6-mike.leach@linaro.org>
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
 .../coresight/coresight-etm3x-core.c          | 72 ++++++++++++++++---
 .../coresight/coresight-etm3x-sysfs.c         | 28 +++-----
 3 files changed, 71 insertions(+), 31 deletions(-)

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
index 7d413ba8b823..98213503bd09 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -32,6 +32,7 @@
 
 #include "coresight-etm.h"
 #include "coresight-etm-perf.h"
+#include "coresight-trace-id.h"
 
 /*
  * Not really modular but using module_param is the easiest way to
@@ -490,18 +491,57 @@ static int etm_trace_id(struct coresight_device *csdev)
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
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu,
+						 coresight_get_trace_id_map());
+	if (trace_id > 0) {
+		spin_lock(&drvdata->spinlock);
+		drvdata->traceid = (u8)trace_id;
+		spin_unlock(&drvdata->spinlock);
+	} else {
+		pr_err("Failed to allocate trace ID for %s on CPU%d\n",
+		       dev_name(&drvdata->csdev->dev), drvdata->cpu);
+	}
+	return trace_id;
+}
+
+void etm_release_trace_id(struct etm_drvdata *drvdata)
+{
+	coresight_trace_id_put_cpu_id(drvdata->cpu,
+				      coresight_get_trace_id_map());
+	spin_lock(&drvdata->spinlock);
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
 
+	ret = etm_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		return ret;
+
 	/* Configure the tracer based on the session's specifics */
 	etm_parse_event_config(drvdata, event);
 	/* And enable it */
-	return etm_enable_hw(drvdata);
+	ret = etm_enable_hw(drvdata);
+
+	if (ret)
+		etm_release_trace_id(drvdata);
+	return ret;
 }
 
 static int etm_enable_sysfs(struct coresight_device *csdev)
@@ -510,6 +550,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	struct etm_enable_arg arg = { };
 	int ret;
 
+	ret = etm_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		return ret;
+
 	spin_lock(&drvdata->spinlock);
 
 	/*
@@ -532,6 +576,8 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 
 	if (!ret)
 		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
+	else
+		etm_release_trace_id(drvdata);
 	return ret;
 }
 
@@ -611,6 +657,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	coresight_disclaim_device_unlocked(csdev);
 
 	CS_LOCK(drvdata->base);
+
+	etm_release_trace_id(drvdata);
 }
 
 static void etm_disable_sysfs(struct coresight_device *csdev)
@@ -781,11 +829,6 @@ static void etm_init_arch_data(void *info)
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
@@ -871,7 +914,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (etm_arch_supported(drvdata->arch) == false)
 		return -EINVAL;
 
-	etm_init_trace_id(drvdata);
 	etm_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
@@ -891,10 +933,12 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(drvdata->csdev);
 
 	ret = etm_perf_symlink(drvdata->csdev, true);
-	if (ret) {
-		coresight_unregister(drvdata->csdev);
-		return ret;
-	}
+	if (ret)
+		goto cs_unregister;
+
+	ret = etm_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		goto cs_unregister;
 
 	etmdrvdata[drvdata->cpu] = drvdata;
 
@@ -907,6 +951,10 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	return 0;
+
+cs_unregister:
+	coresight_unregister(drvdata->csdev);
+	return ret;
 }
 
 static void clear_etmdrvdata(void *info)
@@ -922,6 +970,8 @@ static void etm_remove(struct amba_device *adev)
 
 	etm_perf_symlink(drvdata->csdev, false);
 
+	etm_release_trace_id(drvdata);
+
 	/*
 	 * Taking hotplug lock here to avoid racing between etm_remove and
 	 * CPU hotplug call backs.
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index e8c7649f123e..3ee70b174240 100644
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

