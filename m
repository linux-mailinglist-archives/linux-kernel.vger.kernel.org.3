Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76F557F4F4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiGXMZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiGXMYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:24:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3858D15FE4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:24:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y15so8119471plp.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6iOQlRmdbJTpHfNsjYsIeuk02p2ItiNyg2ruDmQq+BY=;
        b=zsh/PeAJJoYBaQeHrhQuMayAwzEvVGr97bdjqPOfoZz5Yz0wf89DcFFnrL3OoGXvB1
         cVBAotkKgLusZPlFyVF/kDJFwtJq9YSknp7/aUNTprf93+os2Dp2429HGAbgLdTRezvz
         Ceo6NbVdePo0xSCkpA6DW+UbAHYC9GeClirJKOLc/iXuPEK4k6TOxbcY3yoKWCDrR7DS
         2mtd5jsesuBZ9wAk0ygnzH+MFqFTNVfuw6rqeW+D8fFOXlJrWLEVZrxXnH51gUkjdwyV
         b1mLZbGXpOlLEfcX5H0Irew8XC+kHwQ+stvvzmdRtAxymys7ZxCk3ULFhuJChhKPnl4F
         mX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iOQlRmdbJTpHfNsjYsIeuk02p2ItiNyg2ruDmQq+BY=;
        b=ksyX3wsTfaSa4PDRrvgOxqswIuomlmMYd7G8URAaCc6XM34ANEU2Nwjf+/w+ps68+J
         h8d+LjzwpPiLPvLuZ5b1EjBO4kX+z0TRgmmAsYHUfZokoDh5fEosmm0Ngkkdlx5VNdYG
         kJQBbNWiHV4vjyb4xLvddmPoSIijnv4mb8eUKi8kf18VjK32MrxGQdvYySjHQdiTvsmZ
         6N8Oo5bmxqxVxqrsPo1TieIO6YO8ljD4rGlehIocLE1woRB1SJP0rZSQwZ8fNZtZ9crB
         OCPJktTNkzPRcZh7pfh24bNAl95DhfdsvupouPqo7h0yE7P1icsd92TQuXaPkePCPKgq
         gdpg==
X-Gm-Message-State: AJIora9zAqFCtvgCO/FZOst74Uhwyx5tHsuG0O6+TvcaOUA10rD2AIcD
        OVTWatu/3QF/fxlrNdTlEeO7EQ==
X-Google-Smtp-Source: AGRyM1vJafhRN/xHd5t1GoTSnXJ8kzHtCNRRaRbXw6TE4LuNgTApmdlBx91bN/WVccFIoWL0jYWzbg==
X-Received: by 2002:a17:902:8543:b0:16b:fbd1:9f68 with SMTP id d3-20020a170902854300b0016bfbd19f68mr7910318plo.101.1658665486534;
        Sun, 24 Jul 2022 05:24:46 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b0016c0474fbd0sm7048133plb.34.2022.07.24.05.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 05:24:46 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v2 3/5] thermal: qcom: tsens: Add driver support for re-initialization quirk
Date:   Sun, 24 Jul 2022 17:54:22 +0530
Message-Id: <20220724122424.2509021-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220724122424.2509021-1-bhupesh.sharma@linaro.org>
References: <20220724122424.2509021-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for some Qualcomm tsens controllers, its suggested to
monitor the controller health periodically and in case an
issue is detected, to re-initialize the tsens controller
via trustzone, add the support for the same in the
qcom tsens driver.

Note that once the tsens controller is reset using scm call,
all SROT and TM region registers will enter the reset mode.

While all the SROT registers will be re-programmed and
re-enabled in trustzone prior to the scm call exit, the TM
region registers will not re-initialized in trustzone and thus
need to be handled by the tsens driver.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c |   3 +
 drivers/thermal/qcom/tsens.c    | 197 ++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h    |  12 ++
 3 files changed, 212 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index b293ed32174b..f521e4479cc5 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -88,6 +88,9 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 
 	/* TRDY: 1=ready, 0=in progress */
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
+
+	/* FIRST_ROUND_COMPLETE: 1=complete, 0=not complete */
+	[FIRST_ROUND_COMPLETE] = REG_FIELD(TM_TRDY_OFF, 3, 3),
 };
 
 static const struct tsens_ops ops_generic_v2 = {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index e49f58e83513..c2d085fb5447 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -7,6 +7,7 @@
 #include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/qcom_scm.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
@@ -594,6 +595,113 @@ static void tsens_disable_irq(struct tsens_priv *priv)
 	regmap_field_write(priv->rf[INT_EN], 0);
 }
 
+static int tsens_reenable_hw_after_scm(struct tsens_priv *priv)
+{
+	/*
+	 * Re-enable watchdog, unmask the bark and
+	 * disable cycle completion monitoring.
+	 */
+	regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
+	regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
+	regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
+	regmap_field_write(priv->rf[CC_MON_MASK], 1);
+
+	/* Re-enable interrupts */
+	tsens_enable_irq(priv);
+
+	return 0;
+}
+
+static int tsens_health_check_and_reinit(struct tsens_priv *priv,
+					 int hw_id)
+{
+	int ret, trdy, first_round, sw_reg;
+	unsigned long timeout;
+
+	/* First check if TRDY is SET */
+	ret = regmap_field_read(priv->rf[TRDY], &trdy);
+	if (ret)
+		goto err;
+
+	if (!trdy) {
+		ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE], &first_round);
+		if (ret)
+			goto err;
+
+		if (!first_round) {
+			WARN_ON(!mutex_is_locked(&priv->reinit_mutex));
+
+			/* Wait for 2 ms for tsens controller to recover */
+			timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
+			do {
+				ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE],
+						&first_round);
+				if (ret)
+					goto err;
+
+				if (first_round) {
+					dev_dbg(priv->dev, "tsens controller recovered\n");
+					return 0; /* success */
+				}
+			} while (time_before(jiffies, timeout));
+
+			spin_lock(&priv->reinit_lock);
+
+			/*
+			 * Invoke SCM call only if SW register write is
+			 * reflecting in controller. Try it for 2 ms.
+			 * In case that fails mark the tsens controller
+			 * as unrecoverable.
+			 */
+			timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
+			do {
+				ret = regmap_field_write(priv->rf[INT_EN], CRITICAL_INT_EN);
+				if (ret)
+					goto err;
+
+				ret = regmap_field_read(priv->rf[INT_EN], &sw_reg);
+				if (ret)
+					goto err;
+			} while ((sw_reg & CRITICAL_INT_EN) && (time_before(jiffies, timeout)));
+
+			if (!(sw_reg & CRITICAL_INT_EN)) {
+				ret = -ENOTRECOVERABLE;
+				goto err;
+			}
+
+			/*
+			 * tsens controller did not recover,
+			 * proceed with SCM call to re-init it.
+			 */
+			ret = qcom_scm_tsens_reinit();
+			if (ret) {
+				dev_err(priv->dev, "tsens reinit scm call failed (%d)\n", ret);
+				goto err;
+			}
+
+			/*
+			 * After the SCM call, we need to re-enable
+			 * the interrupts and also set active threshold
+			 * for each sensor.
+			 */
+			ret = tsens_reenable_hw_after_scm(priv);
+			if (ret) {
+				dev_err(priv->dev,
+					"tsens re-enable after scm call failed (%d)\n", ret);
+				goto err;
+			}
+
+			/* Notify reinit wa worker */
+			queue_work(system_highpri_wq, &priv->reinit_wa_notify);
+
+			spin_unlock(&priv->reinit_lock);
+		}
+	}
+
+err:
+	return ret;
+}
+
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
@@ -607,6 +715,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	if (tsens_version(priv) == VER_0)
 		goto get_temp;
 
+	/*
+	 * For some tsens controllers, its suggested to
+	 * monitor the controller health periodically
+	 * and in case an issue is detected to reinit
+	 * tsens controller via trustzone.
+	 */
+	if (priv->needs_reinit_wa) {
+		mutex_lock(&priv->reinit_mutex);
+		ret = tsens_health_check_and_reinit(priv, hw_id);
+		mutex_unlock(&priv->reinit_mutex);
+
+		if (ret)
+			return ret;
+	}
+
 	/* Valid bit is 0 for 6 AHB clock cycles.
 	 * At 19.2MHz, 1 AHB clock is ~60ns.
 	 * We should enter this loop very, very rarely.
@@ -739,6 +862,40 @@ static const struct regmap_config tsens_srot_config = {
 	.reg_stride	= 4,
 };
 
+static void __tsens_reinit_worker(struct tsens_priv *priv)
+{
+	int ret, temp;
+	unsigned int i;
+	struct tsens_irq_data d;
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		const struct tsens_sensor *s = &priv->sensor[i];
+		u32 hw_id = s->hw_id;
+
+		if (!s->tzd)
+			continue;
+		if (!tsens_threshold_violated(priv, hw_id, &d))
+			continue;
+
+		ret = get_temp_tsens_valid(s, &temp);
+		if (ret) {
+			dev_err(priv->dev, "[%u] error reading sensor during reinit\n", hw_id);
+			continue;
+		}
+
+		tsens_read_irq_state(priv, hw_id, s, &d);
+
+		if ((d.up_thresh < temp) || (d.low_thresh > temp)) {
+			dev_dbg(priv->dev, "[%u] TZ update trigger during reinit (%d mC)\n",
+				hw_id, temp);
+			thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
+		} else {
+			dev_dbg(priv->dev, "[%u] no violation during reinit (%d)\n",
+				hw_id, temp);
+		}
+	}
+}
+
 int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
@@ -860,6 +1017,14 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
+	priv->rf[FIRST_ROUND_COMPLETE] = devm_regmap_field_alloc(dev,
+								priv->tm_map,
+								priv->fields[FIRST_ROUND_COMPLETE]);
+	if (IS_ERR(priv->rf[FIRST_ROUND_COMPLETE])) {
+		ret = PTR_ERR(priv->rf[FIRST_ROUND_COMPLETE]);
+		goto err_put_device;
+	}
+
 	/* This loop might need changes if enum regfield_ids is reordered */
 	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
 		for (i = 0; i < priv->feat->max_sensors; i++) {
@@ -1082,6 +1247,14 @@ static int tsens_register(struct tsens_priv *priv)
 	return ret;
 }
 
+static void tsens_reinit_worker_notify(struct work_struct *work)
+{
+	struct tsens_priv *priv = container_of(work, struct tsens_priv,
+					       reinit_wa_notify);
+
+	__tsens_reinit_worker(priv);
+}
+
 static int tsens_probe(struct platform_device *pdev)
 {
 	int ret, i;
@@ -1123,6 +1296,11 @@ static int tsens_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 	priv->num_sensors = num_sensors;
+	priv->needs_reinit_wa = data->needs_reinit_wa;
+
+	if (priv->needs_reinit_wa && !qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
 	priv->ops = data->ops;
 	for (i = 0;  i < priv->num_sensors; i++) {
 		if (data->hw_ids)
@@ -1138,6 +1316,25 @@ static int tsens_probe(struct platform_device *pdev)
 	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
 		return -EINVAL;
 
+	/*
+	 * Reinitialization workaround is currently supported only for
+	 * tsens controller versions v2.
+	 *
+	 * If incorrect platform data is passed to this effect, ignore
+	 * the requested setting and move forward.
+	 */
+	if (priv->needs_reinit_wa && (tsens_version(priv) < VER_2_X)) {
+		dev_warn(dev,
+			 "%s: Reinit quirk available only for tsens v2\n", __func__);
+		priv->needs_reinit_wa = false;
+	}
+
+	mutex_init(&priv->reinit_mutex);
+	spin_lock_init(&priv->reinit_lock);
+
+	if (priv->needs_reinit_wa)
+		INIT_WORK(&priv->reinit_wa_notify, tsens_reinit_worker_notify);
+
 	ret = priv->ops->init(priv);
 	if (ret < 0) {
 		dev_err(dev, "%s: init failed\n", __func__);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 92787017c6ab..900d2a74d25e 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -14,9 +14,12 @@
 #define SLOPE_FACTOR		1000
 #define SLOPE_DEFAULT		3200
 #define TIMEOUT_US		100
+#define RESET_TIMEOUT_MS	2
 #define THRESHOLD_MAX_ADC_CODE	0x3ff
 #define THRESHOLD_MIN_ADC_CODE	0x0
 
+#define CRITICAL_INT_EN		(BIT(2))
+
 #include <linux/interrupt.h>
 #include <linux/thermal.h>
 #include <linux/regmap.h>
@@ -165,6 +168,7 @@ enum regfield_ids {
 	/* ----- TM ------ */
 	/* TRDY */
 	TRDY,
+	FIRST_ROUND_COMPLETE,
 	/* INTERRUPT ENABLE */
 	INT_EN,	/* v2+ has separate enables for crit, upper and lower irq */
 	/* STATUS */
@@ -564,6 +568,14 @@ struct tsens_priv {
 	u32				tm_offset;
 	bool				needs_reinit_wa;
 
+	struct work_struct		reinit_wa_notify;
+
+	/* protects reinit related serialization */
+	struct mutex			reinit_mutex;
+
+	/* lock for reinit workaround */
+	spinlock_t			reinit_lock;
+
 	/* lock for upper/lower threshold interrupts */
 	spinlock_t			ul_lock;
 
-- 
2.35.3

