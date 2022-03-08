Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9B4D22E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350371AbiCHUvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350317AbiCHUvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D60136E37
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:50:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so296116wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MM4EmkpbqCFdFxxd9GgbYGC5CZg14rKLljTmThXZPjg=;
        b=sR2qDcSTn/QrrRvC7tDPq3cB3qglIulDBC4pwgEW6YgF+zTEPRRMsvD/qAkX27iW4G
         t019Neq/9RrAIlHrw3dmUqJuh7L5/K46d01FZXPASJiSwMPJFqLImoD7Mu59Pe/C4mLC
         aoFVcfi3ZDRixHISwKhYkgTD64xfyDCCf1rh5Uv6qzvtVjI0t2gKR/7Mve1mdfen22gm
         pM4di5EsTmJPwqAiAoT6VO43/v1P113xqJIYoRgWbTR3xJs5YtAkLQqa2gZd1IExO/k7
         6IZlsv2Qh1gTg8GXdFgkgeVhE+rqG9Z2PDFT2edl5VKN1h4Wvt92ZNiFmYtDwyhrr3Bg
         Qt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MM4EmkpbqCFdFxxd9GgbYGC5CZg14rKLljTmThXZPjg=;
        b=qWNn3SNoEKmq7Rn20Xs9/IgMmtdY9DvzgoWgGjPx6op8P2tWPxaU/0ehdmNaRMJbwZ
         VcRSZycBzJJKJFFJSL4NuyLZ3AWMhEuAZ4BMmmIYq3I0WA1elq5EG396s01AtpcfAATC
         D+VfMbQsQZeNkz4jDsABgdCco9E93RQAnau1ec/LSZG3NuywGFwoeQbjkpTlkDbY5jCn
         HehiJw0tVujGCvZXwhdhpcHFuhY9llYDr4p3B0iQXS8yzSLawek4XD4SDmmFx3p+H1Q2
         CSPZF9xiK86q04Meubka9fNq+V9s0UpuWO+sgME0oy6xCsLc3FxnHH9amg06kG5ZR1fs
         +C1A==
X-Gm-Message-State: AOAM533Nv4IssvDDFPm5VRLRYUiG0LzWDMzgFkvhMg5PMFnfJRMOjrmu
        rOp8OKx32EColyDXIhzjTEYxGg==
X-Google-Smtp-Source: ABdhPJzGFhXp/2CodsJvLCxofK1VbSGwJL/tOn4J0/ZvBH8o4nrDRRmiNjEJ3mSythvPL0q2EYQ1Gw==
X-Received: by 2002:a1c:7302:0:b0:381:1f9a:a22b with SMTP id d2-20020a1c7302000000b003811f9aa22bmr884036wmb.78.1646772612033;
        Tue, 08 Mar 2022 12:50:12 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:11 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 09/10] coresight: etmX.X: stm: Remove unused legacy source trace ID ops
Date:   Tue,  8 Mar 2022 20:49:59 +0000
Message-Id: <20220308205000.27646-10-mike.leach@linaro.org>
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

CoreSight sources provide a callback (.trace_id) in the standard source
ops which returns the ID to the core code. This was used to check that
sources all had a unique Trace ID.

Uniqueness is now gauranteed by the Trace ID allocation system, and the
check code has been removed from the core.

This patch removes the unneeded and unused .trace_id source ops
from the ops structure and implementations in etm3x, etm4x and stm.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h   |  1 -
 .../coresight/coresight-etm3x-core.c          | 37 -------------------
 .../coresight/coresight-etm4x-core.c          |  8 ----
 drivers/hwtracing/coresight/coresight-stm.c   |  8 ----
 include/linux/coresight.h                     |  3 --
 5 files changed, 57 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 3667428d38b6..9a0d08b092ae 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -283,7 +283,6 @@ static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
 }
 
 extern const struct attribute_group *coresight_etm_groups[];
-int etm_get_trace_id(struct etm_drvdata *drvdata);
 void etm_set_default(struct etm_config *config);
 void etm_config_trace_mode(struct etm_config *config);
 struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 98213503bd09..4cfb8ed699df 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -455,42 +455,6 @@ static int etm_cpu_id(struct coresight_device *csdev)
 	return drvdata->cpu;
 }
 
-int etm_get_trace_id(struct etm_drvdata *drvdata)
-{
-	unsigned long flags;
-	int trace_id = -1;
-	struct device *etm_dev;
-
-	if (!drvdata)
-		goto out;
-
-	etm_dev = drvdata->csdev->dev.parent;
-	if (!local_read(&drvdata->mode))
-		return drvdata->traceid;
-
-	pm_runtime_get_sync(etm_dev);
-
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-
-	CS_UNLOCK(drvdata->base);
-	trace_id = (etm_readl(drvdata, ETMTRACEIDR) & ETM_TRACEID_MASK);
-	CS_LOCK(drvdata->base);
-
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(etm_dev);
-
-out:
-	return trace_id;
-
-}
-
-static int etm_trace_id(struct coresight_device *csdev)
-{
-	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	return etm_get_trace_id(drvdata);
-}
-
 int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
 {
 	int trace_id;
@@ -719,7 +683,6 @@ static void etm_disable(struct coresight_device *csdev,
 
 static const struct coresight_ops_source etm_source_ops = {
 	.cpu_id		= etm_cpu_id,
-	.trace_id	= etm_trace_id,
 	.enable		= etm_enable,
 	.disable	= etm_disable,
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index aa7ea5ad8b06..565947de702a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -228,13 +228,6 @@ static int etm4_cpu_id(struct coresight_device *csdev)
 	return drvdata->cpu;
 }
 
-static int etm4_trace_id(struct coresight_device *csdev)
-{
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	return drvdata->trcid;
-}
-
 int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
 {
 	int trace_id;
@@ -998,7 +991,6 @@ static void etm4_disable(struct coresight_device *csdev,
 
 static const struct coresight_ops_source etm4_source_ops = {
 	.cpu_id		= etm4_cpu_id,
-	.trace_id	= etm4_trace_id,
 	.enable		= etm4_enable,
 	.disable	= etm4_disable,
 };
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 6c2c29ae99fe..6aa6eb9e4090 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -281,15 +281,7 @@ static void stm_disable(struct coresight_device *csdev,
 	}
 }
 
-static int stm_trace_id(struct coresight_device *csdev)
-{
-	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	return drvdata->traceid;
-}
-
 static const struct coresight_ops_source stm_source_ops = {
-	.trace_id	= stm_trace_id,
 	.enable		= stm_enable,
 	.disable	= stm_disable,
 };
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 9f445f09fcfe..247147c11231 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -314,14 +314,11 @@ struct coresight_ops_link {
  * Operations available for sources.
  * @cpu_id:	returns the value of the CPU number this component
  *		is associated to.
- * @trace_id:	returns the value of the component's trace ID as known
- *		to the HW.
  * @enable:	enables tracing for a source.
  * @disable:	disables tracing for a source.
  */
 struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
-	int (*trace_id)(struct coresight_device *csdev);
 	int (*enable)(struct coresight_device *csdev,
 		      struct perf_event *event,  u32 mode);
 	void (*disable)(struct coresight_device *csdev,
-- 
2.17.1

