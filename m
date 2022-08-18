Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2AA598FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbiHRWC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244077AbiHRWCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:02:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1C8D1E05;
        Thu, 18 Aug 2022 15:02:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j8so5649328ejx.9;
        Thu, 18 Aug 2022 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hiV4y42dnIA6mPXuCbBBpHWG07YzKHvXkn6+dWOo700=;
        b=TQxrx66OuOwTD3mQ+PSiZ+iZ3IhVt290iN5xwOAnhm5hl8i0OqzMRIOiNPjg80omBs
         kkjGE/mkfJIB7xLvCz4rG5kgoCEsDxhNuN09Sfx7PiUvGvxLZBiNy9lsdLKwhDi94z4V
         wLhC8je/GQNbfZqOb/GaD1y3SkTUk3adtWEnOgxbHmNJWpYtcmts0dvf6SRPNTIlw9fi
         g7EuLF621FInR/wQ53mjeUYrSdtdhkITsWmKN+GW9gOAKBr+qRcDS1omPhdUYUgsm8NC
         eWd74PztNFOV7DuH8SPQUgGaMQ2krVZYPN8FLm1qsC5iDMc7Dz1HroMPaGVe+M+HAbYs
         yTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hiV4y42dnIA6mPXuCbBBpHWG07YzKHvXkn6+dWOo700=;
        b=Y0qk+POz9X40rpqTwRdZYSoFN08ULJs5Y2ZlGYzN8eVz5GloRJ4YLnAv0bpOO/kbRL
         c5NsrqUJBdrxUeGluuKP7IY+h4gVdV56eebRv28XUm4APpCIfVaRgzGE2M8vkbKiQik+
         b+eI6Rwruamcbe9DZr9DriJlF6ks04c9/9GmH7H2it52Eoi/qn8lvlvROAxXhwv+Skj+
         500yOZQAs4jzyuSe6Dk2Zeac5gChX3sln8Gf+sRJJx3sUtYshqsnr5I904ZhS0ZkQoxz
         SI8n5FUQgYM3/fqlvJYjhxTz+bGLP6YDOVZ06UgmYoyMuJ9cMnJlz3+HLKAXF9xMySD5
         nxYA==
X-Gm-Message-State: ACgBeo2/JoheYZQRiPE1tAKS38BIYTfuLrfqj5UB+icCE+xT67QG61CL
        qMFh4CBk1LLKDQkP0KIVTI/qW+EoeDA=
X-Google-Smtp-Source: AA6agR6J5vE8PxKqu1CN9GYv86qVb3QT8KNm4cWOKd3nOWer5JiBM60wqlJE8kmEu40c9mHsAv+w1g==
X-Received: by 2002:a17:906:93ef:b0:73c:cf83:5553 with SMTP id yl15-20020a17090693ef00b0073ccf835553mr472681ejb.441.1660860170739;
        Thu, 18 Aug 2022 15:02:50 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id l7-20020a170906230700b0072fa1571c99sm1379297eja.137.2022.08.18.15.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:02:50 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v7 2/5] drivers: thermal: tsens: Add support for combined interrupt
Date:   Fri, 19 Aug 2022 00:02:42 +0200
Message-Id: <20220818220245.338396-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220245.338396-1-robimarko@gmail.com>
References: <20220818220245.338396-1-robimarko@gmail.com>
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
Changes in v7:
* Rebase to apply on next-20220818

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
index b1b10005fb28..816769af8813 100644
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
 static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
 	struct tsens_sensor *s = tz->devdata;
@@ -1071,13 +1092,18 @@ static int tsens_register(struct tsens_priv *priv)
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
index ba05c8233356..1678c5e9e60b 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -493,6 +493,7 @@ enum regfield_ids {
  * struct tsens_features - Features supported by the IP
  * @ver_major: Major number of IP version
  * @crit_int: does the IP support critical interrupts?
+ * @combo_int: does the IP use one IRQ for up, low and critical thresholds?
  * @adc:      do the sensors only output adc code (instead of temperature)?
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
@@ -502,6 +503,7 @@ enum regfield_ids {
 struct tsens_features {
 	unsigned int ver_major;
 	unsigned int crit_int:1;
+	unsigned int combo_int:1;
 	unsigned int adc:1;
 	unsigned int srot_split:1;
 	unsigned int has_watchdog:1;
-- 
2.37.2

