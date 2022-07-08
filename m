Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FB356BAB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiGHN3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiGHN3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:29:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435AC2CC99;
        Fri,  8 Jul 2022 06:29:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id os14so7491505ejb.4;
        Fri, 08 Jul 2022 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uKpz2hIFkMSX8+Jn3dQ6G5odMPV44ms8vUCSjM1Q8xE=;
        b=R2T851vRAWZbPMbQshMB1K4HXXvQGKLBfFMP4eYektBWPKFN4TeFTJzE6xg2ttgT+K
         wDZChTcbOdi/0w9w2iV9Izxaq+uQ2k+Qvr1rPZWfF9afaypiFpJ9HxaMsCNuv2DiSlpB
         bBXB9y2XV0xlDpSSOSJfeAfx9dERK8g9EBejf+RjHeiiSHTtBhCYiA0QtXt1+olLbGVJ
         vT3Vi8l9zd1C4Xn/vXB4PCiOFEb+9j8FZutF28c4eLkNCLwQwH0YsO5LEmj10yA9693k
         ffnlppw7IkoXp3H5YavG5ypMd/7vGi8bV1jsD122UGp2LWJY2IIH2Y3ea6cgIXPH97yC
         G77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKpz2hIFkMSX8+Jn3dQ6G5odMPV44ms8vUCSjM1Q8xE=;
        b=4lWEpbqoip/u3lXBbamYqwKZc3bgdvM3QdKQHmNajUvKJ2xehU5tQNzMl4AZLMqW11
         3SGJ1o9r+QxIWDl66aFgOpVMn25DBEqhtvUB9ZDFtC6a9RkFxRB0Jt7SKDNyUUKDxvKO
         bPJF4CcqL1qOwmYbH8fQtHHgbSZkMsYk+k+Z4wXPR/fjXpO6y35ypWXDZOBiGQFuY7qH
         O3doYReZJoTmgHdsfMPlHVnw+ay9F9xmzgoqBnzPAy5cbq80lf4qCUFyd7Y/dZoklCt7
         AgYwg8VJrPoU6hsUclR2cZa0vLxHJMrjAt+QyP9+ZSuW5EO/VGExCwRMEy5rYUsGjXy9
         iAWQ==
X-Gm-Message-State: AJIora8ADir6zuP2yr3YMhY0Sva9QPJn6Qr3XaYUZgOIREPGLfoK7Eul
        vlOylcSvLUzyiNq6VFXm4QTdXLWokQxpeQ==
X-Google-Smtp-Source: AGRyM1v8wrUxFSLlQjG3zZ+CFLAKsVWRTzldotgyH0w9zklfx99kiM0osVvik7zfy7qzUbIFD6Bksw==
X-Received: by 2002:a17:906:8a4a:b0:72a:3de2:1268 with SMTP id gx10-20020a1709068a4a00b0072a3de21268mr3722941ejc.152.1657286973811;
        Fri, 08 Jul 2022 06:29:33 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id q4-20020a1709064cc400b006fec4ee28d0sm20170398ejt.189.2022.07.08.06.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:29:33 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 2/5] drivers: thermal: tsens: Add support for combined interrupt
Date:   Fri,  8 Jul 2022 15:29:27 +0200
Message-Id: <20220708132930.595897-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708132930.595897-1-robimarko@gmail.com>
References: <20220708132930.595897-1-robimarko@gmail.com>
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

Despite using tsens v2.3 IP, IPQ8074 and IPQ6018 only have one IRQ for
signaling both up/low and critical trips.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c |  1 +
 drivers/thermal/qcom/tsens-v0_1.c |  1 +
 drivers/thermal/qcom/tsens-v1.c   |  1 +
 drivers/thermal/qcom/tsens-v2.c   |  1 +
 drivers/thermal/qcom/tsens.c      | 37 ++++++++++++++++++++++++++-----
 drivers/thermal/qcom/tsens.h      |  2 ++
 6 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 67c1748cdf73..ee584e5b07e5 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -269,6 +269,7 @@ static const struct tsens_ops ops_8960 = {
 static struct tsens_features tsens_8960_feat = {
 	.ver_major	= VER_0,
 	.crit_int	= 0,
+	.combo_int	= 0,
 	.adc		= 1,
 	.srot_split	= 0,
 	.max_sensors	= 11,
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index f136cb350238..6effb822bf3c 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -539,6 +539,7 @@ static int calibrate_9607(struct tsens_priv *priv)
 static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
 	.crit_int	= 0,
+	.combo_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
 	.max_sensors	= 11,
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 573e261ccca7..a4f561a6e582 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -302,6 +302,7 @@ static int calibrate_8976(struct tsens_priv *priv)
 static struct tsens_features tsens_v1_feat = {
 	.ver_major	= VER_1_X,
 	.crit_int	= 0,
+	.combo_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
 	.max_sensors	= 11,
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index b293ed32174b..129cdb247381 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -31,6 +31,7 @@
 static struct tsens_features tsens_v2_feat = {
 	.ver_major	= VER_2_X,
 	.crit_int	= 1,
+	.combo_int	= 0,
 	.adc		= 0,
 	.srot_split	= 1,
 	.max_sensors	= 16,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 7963ee33bf75..8029cd1172bd 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -532,6 +532,26 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/**
+ * tsens_combined_irq_thread - Threaded interrupt handler for combined interrupts
+ * @irq: irq number
+ * @data: tsens controller private data
+ *
+ * Handle the combined interrupt as if it were 2 separate interrupts, so call the
+ * critical handler first and then the up/low one.
+ *
+ * Return: IRQ_HANDLED
+ */
+static irqreturn_t tsens_combined_irq_thread(int irq, void *data)
+{
+	irqreturn_t ret;
+
+	ret = tsens_critical_irq_thread(irq, data);
+	ret = tsens_irq_thread(irq, data);
+
+	return ret;
+}
+
 static int tsens_set_trips(void *_sensor, int low, int high)
 {
 	struct tsens_sensor *s = _sensor;
@@ -1083,13 +1103,18 @@ static int tsens_register(struct tsens_priv *priv)
 				   tsens_mC_to_hw(priv->sensor, 0));
 	}
 
-	ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
-	if (ret < 0)
-		return ret;
+	if (priv->feat->combo_int) {
+		ret = tsens_register_irq(priv, "combined",
+					 tsens_combined_irq_thread);
+	} else {
+		ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
+		if (ret < 0)
+			return ret;
 
-	if (priv->feat->crit_int)
-		ret = tsens_register_irq(priv, "critical",
-					 tsens_critical_irq_thread);
+		if (priv->feat->crit_int)
+			ret = tsens_register_irq(priv, "critical",
+						 tsens_critical_irq_thread);
+	}
 
 	return ret;
 }
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 1471a2c00f15..4614177944d6 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -495,6 +495,7 @@ enum regfield_ids {
  * struct tsens_features - Features supported by the IP
  * @ver_major: Major number of IP version
  * @crit_int: does the IP support critical interrupts?
+ * @combo_int: does the IP use one IRQ for up, low and critical thresholds?
  * @adc:      do the sensors only output adc code (instead of temperature)?
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
@@ -504,6 +505,7 @@ enum regfield_ids {
 struct tsens_features {
 	unsigned int ver_major;
 	unsigned int crit_int:1;
+	unsigned int combo_int:1;
 	unsigned int adc:1;
 	unsigned int srot_split:1;
 	unsigned int has_watchdog:1;
-- 
2.36.1

