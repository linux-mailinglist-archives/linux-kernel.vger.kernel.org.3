Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A9B59DB49
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356571AbiHWKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244067AbiHWKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:42:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153ABAA4E9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so9174385wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=s1EeLgM9kmSebPjS86MgOK+PT8HNs6EofGCOKia2Zv0=;
        b=A/VivTv0tmHpvTMHjhv03oCsogkIBukvZ5v8alYzyRyZxcMgYuV601G8z0jtReE8MS
         U8CpoEgdzWukWN0v6e5cX1EiCcDSI6OkX8QALjtjgeY41csjWDx3eI4qzPA4/cMMnUk4
         jgVsQm1iMe1oxYMgTwN1tysWbC0jU+4PhFnHgwIntZPStpTpacv+0gip7oemCyNp4O2O
         xuTqsG44lllN2MB31GhqZ3mnk+6fYAT5yaE3A+Kv9jBqfFhuLd/VoUOBu6Epm9Z9WGqp
         ncVS6ACKMEU9/T9tTPzEUJX9IJdkmXjVoPrMnKSVSvlVEGuWpNRRvUc9WERcWl+TGkUA
         nw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=s1EeLgM9kmSebPjS86MgOK+PT8HNs6EofGCOKia2Zv0=;
        b=S+PLja7JryqxyHsd6qOXuSuruuRNFn40pL3qORAehs2HQ8JltlGzNCjLM4PtBtqeh8
         nIpcSdyd2jpXvI1ED9qifTNbo1FK31OnCchw/Gpn+89U3Qqu5khv0RnrPjA7QRpLg+0s
         eZt7oQccjR+hPt78iZjjMXevSbnJY2j4bL/mRttmkmlLr3jbuN17msMY5OWrlqlR9nnS
         IObDnFCwzNsuK2zHHn896dYQzx2m6fexNmB5M3yWyIAiS7CPagvuV3T580GKrpvEAG6/
         WrxLoWIYltfOsqNxv5IIG2OnewLxe20bVu/QnRHVvicv5QYx5Xg8IMPFGuVW+WZGLgHg
         aJBg==
X-Gm-Message-State: ACgBeo3fxB0YOhthBv7IbubW80QmIbE0D3n68nlbZSYlghZp+pzGSbXq
        +lxL3AT2bj3SXJ55OC4bSmMaew==
X-Google-Smtp-Source: AA6agR4AxJdpaTP7RG64YNWjhyx7hVNMllwLfxR5nqmRB8+sTKknFKfG7Y2Z45ybYUGuVU1TeqAIpw==
X-Received: by 2002:a05:600c:4f90:b0:3a6:2bda:dc19 with SMTP id n16-20020a05600c4f9000b003a62bdadc19mr1464375wmq.17.1661245820123;
        Tue, 23 Aug 2022 02:10:20 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:19 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 06/13] coresight: etmX.X: stm: Remove trace_id() callback
Date:   Tue, 23 Aug 2022 10:10:02 +0100
Message-Id: <20220823091009.14121-7-mike.leach@linaro.org>
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
index 245804cb29d5..c91008f060e6 100644
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

