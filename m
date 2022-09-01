Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBB95A9526
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiIAKzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiIAKyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:54:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416031348B9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:54:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w2so16774708pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0SHo6OixBYLl5f1CcBGhyTfpbNp9C9ObDkRBknfANgo=;
        b=a/Kqe3liSeaVfqTXOyiqV0v3O8IMto/n4wptEy1A99SajwLYVRNNItD1B0jwChJ7Ff
         AxrjJf/a715pHaDo0Oe86gZUAc6Hb5z2W3kHIsX+KVsYTo81eZ7O2jn2Gs2r4GB91A+a
         cEda7Ee8BOn/cQT6LkJef1wm29155Q5pIJlKIwnO+H19XUzdo8hUee0iCutE1Gj5F4s9
         qqAoKXd8CMbukHfD8UPE+mH3ledgAZlndcsxt9iXLduBuTfMJSVXvSa6wZMjwVEC0OGr
         Y/knRMcypS+XGLe/YZD6mXqRpLEsrSGKmubeox+k6/vGm68QMJDFkArMj91G8Yy/VOsV
         cp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0SHo6OixBYLl5f1CcBGhyTfpbNp9C9ObDkRBknfANgo=;
        b=x4YU6iD7RxL8msWL6JMdrfwjCm1gLRkmy2oANspvj5RXDkP+Qc2xkZot8Lpj7Zx+FH
         F0QbxGDA28x+3KdFc222MkL/HYE3jrGIz0hBs0aSfFsexk4X3donJ0vbMh7TEZFWTBJx
         6aCEe8GhXDwfmFeRbUQ/nxWBwnD0LnG/SY9Dq8oySfvG2rNVCNiUfpLXMNCO6xdbA2dg
         FYR4QqU5CK5Suzl9WT4g4fr9oeewxFo6a+GiwG0Quy8/07xfEB0EyErlUZFZSuMSPwIt
         onKbjRei8gegGJmwjbiHbJ1CBOqbaCs5ZJH9PNVVt632aPSD+o4tAcFzZGsu3l3U5EBK
         R1Jw==
X-Gm-Message-State: ACgBeo1LM0sy55OSX9XxX7WA/l0Wci7bh1UbI5TTlDwjNqAzFhyJ6Ecd
        d/DEn4LM9bgJbe02RzKVyw2tsw==
X-Google-Smtp-Source: AA6agR5Td9OaLIjW5v+rGoMJ54Jxx+IAKemsK7IOKn71sway8bd2Xjszf7wFOOKp1PYIoGxKNRnzow==
X-Received: by 2002:a17:902:6b42:b0:174:4308:ce52 with SMTP id g2-20020a1709026b4200b001744308ce52mr27682121plt.81.1662029681584;
        Thu, 01 Sep 2022 03:54:41 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:8069:f46:34af:eb19])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b0016c57657977sm13508910plb.41.2022.09.01.03.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 03:54:41 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v4 3/4] thermal: qcom: tsens: Add driver support for re-initialization quirk
Date:   Thu,  1 Sep 2022 16:24:13 +0530
Message-Id: <20220901105414.1171813-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
References: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c |   3 +
 drivers/thermal/qcom/tsens.c    | 190 ++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h    |  12 ++
 3 files changed, 205 insertions(+)

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
index b1b10005fb28..ecf544683e73 100644
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
@@ -594,6 +595,107 @@ static void tsens_disable_irq(struct tsens_priv *priv)
 	regmap_field_write(priv->rf[INT_EN], 0);
 }
 
+static void tsens_reenable_hw_after_scm(struct tsens_priv *priv)
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
+}
+
+static int tsens_health_check_and_reinit(struct tsens_priv *priv,
+					 int hw_id)
+{
+	int ret, trdy, first_round, sw_reg;
+	unsigned long timeout;
+
+	/* Check early if the mutex is in locked state */
+	WARN_ON(!mutex_is_locked(&priv->reinit_mutex));
+
+	/* First check if TRDY is SET */
+	ret = regmap_field_read(priv->rf[TRDY], &trdy);
+	if (ret)
+		goto err;
+
+	if (trdy)
+		return 0; /* success */
+
+	ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE], &first_round);
+	if (ret)
+		goto err;
+
+	if (first_round)
+		return 0; /* success */
+
+	/* Wait for 2 ms for tsens controller to recover */
+	ret = regmap_field_read_poll_timeout(priv->rf[FIRST_ROUND_COMPLETE],
+					     first_round, first_round, 100,
+					     RESET_TIMEOUT_MS * USEC_PER_MSEC);
+	if (ret == 0) {
+		dev_dbg(priv->dev, "tsens controller recovered\n");
+		return 0; /* success */
+	}
+
+	if (ret)
+		goto err;
+
+	spin_lock(&priv->reinit_lock);
+
+	/*
+	 * Invoke SCM call only if SW register write is reflecting in controller.
+	 * Try it for 2 ms. In case that fails mark the tsens controller as
+	 * unrecoverable.
+	 */
+	timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
+	do {
+		ret = regmap_field_write(priv->rf[INT_EN], CRITICAL_INT_EN);
+		if (ret)
+			goto err_unlock;
+
+		ret = regmap_field_read(priv->rf[INT_EN], &sw_reg);
+		if (ret)
+			goto err_unlock;
+	} while ((sw_reg & CRITICAL_INT_EN) && (time_before(jiffies, timeout)));
+
+	if (!(sw_reg & CRITICAL_INT_EN)) {
+		ret = -ENOTRECOVERABLE;
+		goto err_unlock;
+	}
+
+	/* tsens controller did not recover, proceed with SCM call to re-init it. */
+	ret = qcom_scm_tsens_reinit();
+	if (ret) {
+		dev_err(priv->dev, "tsens reinit scm call failed (%d)\n", ret);
+		goto err_unlock;
+	}
+
+	/*
+	 * After the SCM call, we need to re-enable the interrupts and also set
+	 * active threshold for each sensor.
+	 */
+	tsens_reenable_hw_after_scm(priv);
+
+	/* Notify reinit wa worker */
+	queue_work(system_highpri_wq, &priv->reinit_wa_notify);
+
+	spin_unlock(&priv->reinit_lock);
+
+	return 0; /* success */
+
+err_unlock:
+	spin_unlock(&priv->reinit_lock);
+
+err:
+	return ret;
+}
+
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
@@ -607,6 +709,20 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	if (tsens_version(priv) == VER_0)
 		goto get_temp;
 
+	/*
+	 * For some tsens controllers, its suggested to monitor the controller
+	 * health periodically and in case an issue is detected to reinit tsens
+	 * controller via trustzone.
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
@@ -739,6 +855,40 @@ static const struct regmap_config tsens_srot_config = {
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
@@ -860,6 +1010,14 @@ int __init init_common(struct tsens_priv *priv)
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
@@ -1082,6 +1240,14 @@ static int tsens_register(struct tsens_priv *priv)
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
@@ -1123,6 +1289,11 @@ static int tsens_probe(struct platform_device *pdev)
 
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
@@ -1138,6 +1309,25 @@ static int tsens_probe(struct platform_device *pdev)
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
2.37.1

