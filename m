Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99158E34A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiHIWe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiHIWeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE865800
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:34:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso142298wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/OsA5X/bOD4Ipj0eF/XSnZXUjtlhNlSz1/VMfuWWkwE=;
        b=ES1ZFKi0g4qKPib4LAahQHRFjacZd/XacW9I2cOZOyxO3Czr3NwXo9IsgvPV5l+F/I
         QVWGwewqaROZg16M/YWiDiTvYQ5KtiyRwKMl4cKauAfrL3XA+/5TIYA5r5j8MuGUizny
         6LPh+w0d1ztimWYKurKDuPSLVHBTPoMHxuELJkSnMaoQh3UKTxxol8FyCvAOOJjP/pDe
         WvEhq+ogJ02euxDqtzjwsp6LTpwBTJNtArkmhDXpuOptbsWyzy6PrQw+Pa+Riw9k+XaL
         TyYRSfOdrGL+RtU56jhPRFGyNGX2klqodtyc5ZH3rMnELFthgzMAwFbk8FSUpSECnTTH
         GXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/OsA5X/bOD4Ipj0eF/XSnZXUjtlhNlSz1/VMfuWWkwE=;
        b=ygZjZkQVoVaw3V1Pt0/9ZYhtWWPgtnbTcoPrs0jvPZBqp3vkqxn++4+ZsLubHVWbMZ
         5N/IC4w4nxFnqDGCbmNcqoonNBX+V9BLwRg5QlfYift2n5jvTKTGTWj+XaRT+IH4C+S+
         50O0wciIa+dO58M7rLFjMy82HmEClTeg9xpCavKYBUeOBJZyu53u1bPFqBhvdUh0lYtk
         fg2MboyhPscR2MXahR3MDQx6pB8MPqri9H9ZtftqbgUlUPQH65m6dk4iBTjqv9N2vBNR
         Oy9JAyZLfWw6ye7gxxDUi9+F9dysJzI4xUUYAGRWmYTc1MZ/SQKjGNh5R9y9x5PUyZKu
         4Czw==
X-Gm-Message-State: ACgBeo1n7s0uONtrmWjwsQv1sD/4H5stYRtuYIMhLZur8BwX1kz9hIAO
        4n2x1HJx97L9Dv0JQvhKdsZUjfbEamrzBH+N
X-Google-Smtp-Source: AA6agR6BhxetOyLfzUfMZmgRJcr1Kd3KRWXrzg4MM2p3PwOktw9CpzBd5IDPrnDU1BSnFaDdwWyIfg==
X-Received: by 2002:a7b:c402:0:b0:3a5:3c7:9741 with SMTP id k2-20020a7bc402000000b003a503c79741mr330155wmi.72.1660084452199;
        Tue, 09 Aug 2022 15:34:12 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:11 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 06/13] coresight: etmX.X: stm: Remove trace_id() callback
Date:   Tue,  9 Aug 2022 23:33:54 +0100
Message-Id: <20220809223401.24599-7-mike.leach@linaro.org>
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

CoreSight sources provide a callback (.trace_id) in the standard source
ops which returns the ID to the core code. This was used to check that
sources all had a unique Trace ID.

Uniqueness is now gauranteed by the Trace ID allocation system, and the
check code has been removed from the core.

This patch removes the unneeded and unused .trace_id source ops
from the ops structure and implementations in etm3x, etm4x and stm.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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
index c4e7b3337a5c..181a95cb6cf8 100644
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
@@ -740,7 +704,6 @@ static void etm_disable(struct coresight_device *csdev,
 
 static const struct coresight_ops_source etm_source_ops = {
 	.cpu_id		= etm_cpu_id,
-	.trace_id	= etm_trace_id,
 	.enable		= etm_enable,
 	.disable	= etm_disable,
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index b4fb28ce89fd..0648dea4053f 100644
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
@@ -1026,7 +1019,6 @@ static void etm4_disable(struct coresight_device *csdev,
 
 static const struct coresight_ops_source etm4_source_ops = {
 	.cpu_id		= etm4_cpu_id,
-	.trace_id	= etm4_trace_id,
 	.enable		= etm4_enable,
 	.disable	= etm4_disable,
 };
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 9ef3e923a930..f4b4232614b0 100644
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

