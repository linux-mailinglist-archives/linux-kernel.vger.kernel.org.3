Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF803574A52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbiGNKPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbiGNKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:14:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD6715815;
        Thu, 14 Jul 2022 03:14:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l23so2550050ejr.5;
        Thu, 14 Jul 2022 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjPNXHGNYQ7YMS2A4tRFMJTbj/NaSdag9rNv+sruCtA=;
        b=oiIoMnLwWum4pTNrpc648NsSigLla94rUPDgSzVTJTkbHaqLhiiHBaDLx36LcMvrdp
         IOe3DXybeQJxrCbWhjX87zrIKPcezaAGOgA7VKVMtHznvdEuajGxQlYVncv55PP3bLWV
         IYPEGKoYSG+6GU+4rbHxpfgWHEKH1UnI6OD1OxTbkZGsfE0d46hHMnMD7WqQDM/GQR28
         DhTxO82mVZb9m2PKy8tg6BV06xZkTu+GCuKkKnVRvLxG8y40cX5xA1UGZe3fajXXnfzh
         54jBo3l77+4g4XiHdCzC7qNIK1tRxrTjj5qVeaBbKzga+/WZOVE4CQYqOJjQtXbmaWdg
         a2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjPNXHGNYQ7YMS2A4tRFMJTbj/NaSdag9rNv+sruCtA=;
        b=ej+4sBWgdGEJ29eB39FP22/lHjz82ntyrYfHLrkFgUByKkK9evwVtirratCmicR6O5
         HcsdDHrZSp46+oyBpt199N8TQsybSpEFL53uPG4etxq0KZBdFesQ3rdLTWj/AqeRiRHk
         c7A9HHR9k3XBRc0LX51gmM1SqFoN+49/ykducP4CiTWpByN811kmi8veT0TdQALAllL2
         aGLxL7aCiweE0IcwCFi55KFsAD7c4mu1O/H9cmj4w6Zacn8xkoc6W6gfGQu3SGVvynb5
         QAFU/TBx1bkQqUvuV1ZiTIvsdRUgKphCtvjrA2b24WmnkNXtAtoLhxIwyzJ0mSpnCSY3
         7zXQ==
X-Gm-Message-State: AJIora/wvn09Scr3+smYW4WHKo4iDBVs75UL5EiZmZptJtlVvAFeakzr
        aW3w7ZEG+bK+B+/dAZ5I7Sc=
X-Google-Smtp-Source: AGRyM1tMtaiMSKgSMA6iPnq3NR0tnapx6Fo4WOoDXHrNZ+DJTvdD+trHAPZBWjZ/VLQocbBMtDCGcQ==
X-Received: by 2002:a17:907:6d1d:b0:72b:6d8a:ca64 with SMTP id sa29-20020a1709076d1d00b0072b6d8aca64mr7753729ejc.371.1657793696699;
        Thu, 14 Jul 2022 03:14:56 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-197.xnet.hr. [88.207.98.197])
        by smtp.googlemail.com with ESMTPSA id gr19-20020a170906e2d300b0072b592ee073sm535313ejb.147.2022.07.14.03.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:14:56 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 2/5] drivers: thermal: tsens: Add support for combined interrupt
Date:   Thu, 14 Jul 2022 12:14:48 +0200
Message-Id: <20220714101451.198211-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714101451.198211-1-robimarko@gmail.com>
References: <20220714101451.198211-1-robimarko@gmail.com>
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
Changes in v6:
* Check critical IRQ handler return, simplify up/low return
---
 drivers/thermal/qcom/tsens-8960.c |  1 +
 drivers/thermal/qcom/tsens-v0_1.c |  1 +
 drivers/thermal/qcom/tsens-v1.c   |  1 +
 drivers/thermal/qcom/tsens-v2.c   |  1 +
 drivers/thermal/qcom/tsens.c      | 38 ++++++++++++++++++++++++++-----
 drivers/thermal/qcom/tsens.h      |  2 ++
 6 files changed, 38 insertions(+), 6 deletions(-)

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
index 7963ee33bf75..5c7f9ec6ab1c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -532,6 +532,27 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
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
+	if (ret != IRQ_HANDLED)
+		return ret;
+
+	return tsens_irq_thread(irq, data);
+}
+
 static int tsens_set_trips(void *_sensor, int low, int high)
 {
 	struct tsens_sensor *s = _sensor;
@@ -1083,13 +1104,18 @@ static int tsens_register(struct tsens_priv *priv)
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

