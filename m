Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888D0552BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbiFUHV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346909AbiFUHVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:21:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D22252C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fu3so25522858ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M7igW8eszoZT6WZ3jDv76+6QMOtlL+86zPzbbKCOfSA=;
        b=eCQeZXQB7xHXjg5HtLoVc2TBHIMAHPj9t7+hAnRAUCOSZy4FapwHBeTK+seVoxtqJJ
         6rQCKTF7n8sOSOPNBoEGJHgc2aJ+9EA3RVcEaK2772ILxOAXVcyIRraQ8zkW9EWmKjDZ
         ass9XC8I659suvHKM+CGqadKqHljxn3TK4m6VMMOeYr3mUI/Ski0gWDlvSyuZQo+MwEx
         7wsF7oWJRcnn3srgcQGIYSPH+jOstEl/RLIvzrr8AlYA3SViC21qMIR83sJmHQEDf9Fb
         bvxfFZAR64p7yuW2pPJtgVU7dQUOGU+pKb5aEc9JeIFR3Skd0i2Px8D82jm8TSEgff14
         YhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7igW8eszoZT6WZ3jDv76+6QMOtlL+86zPzbbKCOfSA=;
        b=DkoqMaWidUc07ot9bxUw+Gw0vHsqausIokkoK5N4dZbvhUEaia2FtHRR5GT2L/yYwb
         G+0ILVV6C0xpo/EeSw5wTuw6lOiTKokGye8e1X/CubdlZEcplvqzGPX/OWBTYvF/SGYK
         2twaZJD8hbclXHIfKq/if2L4rbD2WDJoU5eSVuefQxzXhBeBy5U7mGCINWBPpFDKwjWY
         kQILtHu2FKegMRIPTYRscGXeKpnNwatvilwp+gu4Qla0B1YIpx7SdiDivlBuKV9Ti2oG
         t37I4BQopSR58RrehApVfS/+M2TjZtM/6jDJYzzVP1pxJ7X8MFbJW0f1yWZeSdisDCrK
         LWhQ==
X-Gm-Message-State: AJIora+2pGrl3E1KtUkIQjX6+w9bE/TilN1pKt+au0Zt2FBcGLBnNf9/
        ZlrzovhvSJMWYIE5GGW7JQbJ1HjN4k0=
X-Google-Smtp-Source: AGRyM1v1tW2mODL88pIyRoU3mVOnBn6xxAxaFrLbYGlVQ9TPCoJgVAwG+uQU40Icvlmuf14MrGxgFA==
X-Received: by 2002:a17:906:5187:b0:712:477:df9b with SMTP id y7-20020a170906518700b007120477df9bmr24526440ejk.424.1655796076836;
        Tue, 21 Jun 2022 00:21:16 -0700 (PDT)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090653c100b00722e771007fsm50711ejo.37.2022.06.21.00.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 00:21:15 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP)
Subject: [PATCH v2 2/4] drm/etnaviv: add loadavg accounting
Date:   Tue, 21 Jun 2022 09:20:48 +0200
Message-Id: <20220621072050.76229-3-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621072050.76229-1-christian.gmeiner@gmail.com>
References: <20220621072050.76229-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU has an idle state register where each bit represents the idle
state of a sub-GPU component like FE or TX. Sample this register
every 10ms and calculate a simple moving average over the sub-GPU
component idle states with a total observation time frame of 1s.

This provides us with a percentage based load of each sub-GPU
component.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 14 ++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 64 ++++++++++++++++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h | 37 ++++++++++++++++
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 1d2b4fb4bcf8..d5c6115e56bd 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -46,6 +46,19 @@ static void load_gpu(struct drm_device *dev)
 	}
 }
 
+static void unload_gpu(struct drm_device *dev)
+{
+	struct etnaviv_drm_private *priv = dev->dev_private;
+	unsigned int i;
+
+	for (i = 0; i < ETNA_MAX_PIPES; i++) {
+		struct etnaviv_gpu *g = priv->gpu[i];
+
+		if (g)
+			etnaviv_gpu_shutdown(g);
+	}
+}
+
 static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct etnaviv_drm_private *priv = dev->dev_private;
@@ -557,6 +570,7 @@ static void etnaviv_unbind(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct etnaviv_drm_private *priv = drm->dev_private;
 
+	unload_gpu(drm);
 	drm_dev_unregister(drm);
 
 	component_unbind_all(dev, drm);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 37018bc55810..202002ae75ee 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -27,6 +27,8 @@
 #include "state_hi.xml.h"
 #include "cmdstream.xml.h"
 
+static const ktime_t loadavg_polling_frequency = 10 * NSEC_PER_MSEC;
+
 static const struct platform_device_id gpu_ids[] = {
 	{ .name = "etnaviv-gpu,2d" },
 	{ },
@@ -745,6 +747,32 @@ static void etnaviv_gpu_hw_init(struct etnaviv_gpu *gpu)
 	gpu_write(gpu, VIVS_HI_INTR_ENBL, ~0U);
 }
 
+static enum hrtimer_restart etnaviv_loadavg_function(struct hrtimer *t)
+{
+	struct etnaviv_gpu *gpu = container_of(t, struct etnaviv_gpu, loadavg_timer);
+	const u32 idle = gpu_read(gpu, VIVS_HI_IDLE_STATE);
+	int i;
+
+	gpu->loadavg_last_sample_time = ktime_get();
+
+	for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++)
+		if ((idle & etna_idle_module_names[i].bit))
+			sma_loadavg_add(&gpu->loadavg_value[i], 0);
+		else
+			sma_loadavg_add(&gpu->loadavg_value[i], 100);
+
+	spin_lock(&gpu->loadavg_spinlock);
+
+	for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++)
+		gpu->loadavg_percentage[i] = sma_loadavg_read(&gpu->loadavg_value[i]);
+
+	spin_unlock(&gpu->loadavg_spinlock);
+
+	hrtimer_forward_now(t, loadavg_polling_frequency);
+
+	return HRTIMER_RESTART;
+}
+
 int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 {
 	struct etnaviv_drm_private *priv = gpu->drm->dev_private;
@@ -839,6 +867,11 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	for (i = 0; i < ARRAY_SIZE(gpu->event); i++)
 		complete(&gpu->event_free);
 
+	/* Setup loadavg timer */
+	hrtimer_init(&gpu->loadavg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_SOFT);
+	gpu->loadavg_timer.function = etnaviv_loadavg_function;
+	hrtimer_start(&gpu->loadavg_timer, loadavg_polling_frequency, HRTIMER_MODE_ABS_SOFT);
+
 	/* Now program the hardware */
 	mutex_lock(&gpu->lock);
 	etnaviv_gpu_hw_init(gpu);
@@ -859,6 +892,11 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	return ret;
 }
 
+void etnaviv_gpu_shutdown(struct etnaviv_gpu *gpu)
+{
+	hrtimer_cancel(&gpu->loadavg_timer);
+}
+
 #ifdef CONFIG_DEBUG_FS
 struct dma_debug {
 	u32 address[2];
@@ -1585,6 +1623,8 @@ int etnaviv_gpu_wait_idle(struct etnaviv_gpu *gpu, unsigned int timeout_ms)
 static int etnaviv_gpu_hw_suspend(struct etnaviv_gpu *gpu)
 {
 	if (gpu->initialized && gpu->fe_running) {
+		hrtimer_cancel(&gpu->loadavg_timer);
+
 		/* Replace the last WAIT with END */
 		mutex_lock(&gpu->lock);
 		etnaviv_buffer_end(gpu);
@@ -1608,7 +1648,8 @@ static int etnaviv_gpu_hw_suspend(struct etnaviv_gpu *gpu)
 #ifdef CONFIG_PM
 static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
 {
-	int ret;
+	s64 missing_samples;
+	int ret, i, j;
 
 	ret = mutex_lock_killable(&gpu->lock);
 	if (ret)
@@ -1617,7 +1658,27 @@ static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
 	etnaviv_gpu_update_clock(gpu);
 	etnaviv_gpu_hw_init(gpu);
 
+	/* Update loadavg based on delta of suspend and resume ktime.
+	 *
+	 * Our SMA algorithm uses a fixed size of 100 items to be able
+	 * to calculate the mean over one second as we sample every 10ms.
+	 */
+	missing_samples = div_s64(ktime_ms_delta(ktime_get(), gpu->loadavg_last_sample_time), 10);
+	missing_samples = min(missing_samples, (s64)100);
+
+	spin_lock_bh(&gpu->loadavg_spinlock);
+
+	for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++) {
+		struct sma_loadavg *loadavg = &gpu->loadavg_value[i];
+
+		for (j = 0; j < missing_samples; j++)
+			sma_loadavg_add(loadavg, 0);
+	}
+
+	spin_unlock_bh(&gpu->loadavg_spinlock);
+
 	mutex_unlock(&gpu->lock);
+	hrtimer_start(&gpu->loadavg_timer, loadavg_polling_frequency, HRTIMER_MODE_ABS_SOFT);
 
 	return 0;
 }
@@ -1787,6 +1848,7 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	gpu->dev = &pdev->dev;
 	mutex_init(&gpu->lock);
 	mutex_init(&gpu->fence_lock);
+	spin_lock_init(&gpu->loadavg_spinlock);
 
 	/* Map registers: */
 	gpu->mmio = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 85eddd492774..881f071f640e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -10,6 +10,8 @@
 #include "etnaviv_gem.h"
 #include "etnaviv_mmu.h"
 #include "etnaviv_drv.h"
+#include "etnaviv_sma.h"
+#include "state_hi.xml.h"
 
 struct etnaviv_gem_submit;
 struct etnaviv_vram_mapping;
@@ -91,6 +93,33 @@ struct clk;
 
 #define ETNA_NR_EVENTS 30
 
+DECLARE_SMA(loadavg, 100)
+
+static const struct {
+    const char *name;
+    u32 bit;
+} etna_idle_module_names[] = {
+    { "FE", VIVS_HI_IDLE_STATE_FE },
+    { "DE", VIVS_HI_IDLE_STATE_DE },
+    { "PE", VIVS_HI_IDLE_STATE_PE },
+    { "SH", VIVS_HI_IDLE_STATE_SH },
+    { "PA", VIVS_HI_IDLE_STATE_PA },
+    { "SE", VIVS_HI_IDLE_STATE_SE },
+    { "RA", VIVS_HI_IDLE_STATE_RA },
+    { "TX", VIVS_HI_IDLE_STATE_TX },
+    { "VG", VIVS_HI_IDLE_STATE_VG },
+    { "IM", VIVS_HI_IDLE_STATE_IM },
+    { "FP", VIVS_HI_IDLE_STATE_FP },
+    { "TS", VIVS_HI_IDLE_STATE_TS },
+    { "BL", VIVS_HI_IDLE_STATE_BL },
+    { "ASYNCFE", VIVS_HI_IDLE_STATE_ASYNCFE },
+    { "MC", VIVS_HI_IDLE_STATE_MC },
+    { "PPA", VIVS_HI_IDLE_STATE_PPA },
+    { "WD", VIVS_HI_IDLE_STATE_WD },
+    { "NN", VIVS_HI_IDLE_STATE_NN },
+    { "TP", VIVS_HI_IDLE_STATE_TP },
+};
+
 struct etnaviv_gpu {
 	struct drm_device *drm;
 	struct thermal_cooling_device *cooling;
@@ -147,6 +176,13 @@ struct etnaviv_gpu {
 	unsigned int freq_scale;
 	unsigned long base_rate_core;
 	unsigned long base_rate_shader;
+
+	/* Loadavg: */
+	struct hrtimer loadavg_timer;
+	spinlock_t loadavg_spinlock;
+	ktime_t loadavg_last_sample_time;
+	struct sma_loadavg loadavg_value[ARRAY_SIZE(etna_idle_module_names)];
+	unsigned int loadavg_percentage[ARRAY_SIZE(etna_idle_module_names)];
 };
 
 static inline void gpu_write(struct etnaviv_gpu *gpu, u32 reg, u32 data)
@@ -162,6 +198,7 @@ static inline u32 gpu_read(struct etnaviv_gpu *gpu, u32 reg)
 int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value);
 
 int etnaviv_gpu_init(struct etnaviv_gpu *gpu);
+void etnaviv_gpu_shutdown(struct etnaviv_gpu *gpu);
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu);
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.36.1

