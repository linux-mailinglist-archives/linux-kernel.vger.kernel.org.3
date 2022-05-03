Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44399518DD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiECUJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbiECUJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:09:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A6DDECC;
        Tue,  3 May 2022 13:05:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ba17so1022381edb.5;
        Tue, 03 May 2022 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+eMLjPmv21j+ZuXo0i7+LUfQbAtuG1QpwI0dmuzd58=;
        b=okkB+MhzfIwi+k7+ZYCEnx2kpYqBLfEnc9YFun9n0tCa1036H1C8nLK1aYFMv+wyLM
         TU08gZypoqEOnj3gZzhm8LAxMd0yDT0MGi9Ry13NXqhKA3jDhJ2tEJR399MPnrx509I1
         hzyqCg8AEOgy3slPgTh4ur9jR+WJt0igD5rVlZts3dIRSxUBNVhLuBVGFsw80FmUtFS6
         A7R0U98YrNsEEKbFUySjBKGmIQHrEEAdLF0KmXoSx0hTgY9k66o2JimpBfW1P95SCg7g
         UF0kQoU5FihwoZFRZOj2dOOERsdZoesHef86KPlYyP/WroNeftqSdP2eKfh6SsUQHI50
         EdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+eMLjPmv21j+ZuXo0i7+LUfQbAtuG1QpwI0dmuzd58=;
        b=l2dyWGlo/X0DFdNeiooCmNekMOwilPF7TohWtC+NjQhjg1qyUM2piSNpPujKKoU8d4
         dHqh+S39x1b/u78A4pB1Bvrfm6WiNS2O5S9rolAjc4KRxppRU0+NVxdWY5RBUc6jPVnP
         PdDBhMpGeOlynX8BxUx59Y92WvU2jFBdFaGH859kXpsEu5j130HGCYqPoBhK9//Pjs8B
         ZN7Y+Iy+Uv3tebtoFIRMT5uMCXoUQUBf+dfErkWOnOSxJDPhqNy9YeAA08evT8sTFPpQ
         wkYoSe5wetzvEEiU0rjaCr3MZ7fGPSX/5sjddwj8fMMQet+dz8qD7LZ01+dqVzN6Gc5c
         cnrw==
X-Gm-Message-State: AOAM533DaUYjAbhOJxodCn2LlgTVYlgXnwtT17neTtz09Lh0osYRvYUg
        4bFKuGxphprRVUgP6NxfiFhL8lzCj3OgHg==
X-Google-Smtp-Source: ABdhPJySMNruLqy1XHHLitiiSgotWk9KKKlnzrpBQMT1UJ9YdW1xSSSnq4764LosT6L3n7a2+XcH2w==
X-Received: by 2002:a05:6402:3488:b0:427:b4ec:991b with SMTP id v8-20020a056402348800b00427b4ec991bmr15321880edc.319.1651608335265;
        Tue, 03 May 2022 13:05:35 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id ee47-20020a056402292f00b0041d893ed437sm8688450edb.2.2022.05.03.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:05:34 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 2/5] drivers: thermal: tsens: Add support for combined interrupt
Date:   Tue,  3 May 2022 22:05:27 +0200
Message-Id: <20220503200530.4019673-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200530.4019673-1-robimarko@gmail.com>
References: <20220503200530.4019673-1-robimarko@gmail.com>
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
index 154d3cb19c88..69b6f7b97e9e 100644
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
@@ -1080,13 +1100,18 @@ static int tsens_register(struct tsens_priv *priv)
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
2.35.1

