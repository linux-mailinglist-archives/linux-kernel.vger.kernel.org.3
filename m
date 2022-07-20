Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367D957BE89
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiGTT2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiGTT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:28:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F446491C5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w17so22297634ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKQlASJDNB8KX8KOIq3/Tp+D1y8NR4kuLeFGb4T83OQ=;
        b=CyyWZFzm5nufKc0U7YbJhVC9vU5unts1zarZaBW91gS8hvxbfH/F9WZUv4Kn9PjfIz
         C2+pw8QfbUyTQhlGzUThxMZhlFL7amGTNKj33xPz2eziF4ku9Ds0naFQ44lfavA/UQ8O
         Tbrs/Q6nW44W2t4kY6IIJmVTjf0/iE3sOm5NqmTPsNjkqmdiw6dXR+/cdPon5zPu64p7
         mpJoOnThPQkmAVTMvjaxt7Tv0YAwrY59bsT4mqBayldif/f4qD6ugY+svvGwJ8ZojT8n
         XxHUT0BmAo9aOLvsM6twv6Ed/71C+f+tkM7Tka+CbTjVMGhR2lNppDkoieiyjOjs9fgR
         E0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKQlASJDNB8KX8KOIq3/Tp+D1y8NR4kuLeFGb4T83OQ=;
        b=nxkw9ZSHJBpWe6FPHk4Ef+HAWSwt+7CiUV++AOZNULJOp+37aEGdR2n0WI5LCX+kvc
         z0WhtptbHTrMYDg3tsrUhtL++0sgklBypsUccRy9D+PcHvz+Kes2i+ERDBb88qJwE5a+
         gIQW46jFvo8d5drFE0P3KRKfDXVPXnuLxk2pR8jIAUO06R4r7yAble7phlStYLID6LNr
         c0etu2mjeBC4uxdFN3PyUP9aKFcD8DpgK6tuxlRopsPyfLrWkqKyqdvDj5fT4pWfRgCS
         zu+vqklc9kpzeEV/7VHtJvM+1mBTBVR5cWseCUSG8TsBuQb9a/9Az1p9Xol+ZlOSSmaA
         Wgiw==
X-Gm-Message-State: AJIora+jiGDGDOdCCn7i8bBLU2srpVdEDGKN/Pegmgk61YeutLIW9ASn
        ++/PRofVwrFHFDS6lRluFDzMWg==
X-Google-Smtp-Source: AGRyM1sp1smy5tHca3wy0W38/cjfnOPyIqc1LFSPd2aZk69fURv32FmimnuYYmTgOQzuS+Ur+0GbMg==
X-Received: by 2002:a2e:8247:0:b0:25d:b515:92e with SMTP id j7-20020a2e8247000000b0025db515092emr8282569ljh.527.1658345301249;
        Wed, 20 Jul 2022 12:28:21 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h32-20020a0565123ca000b0047fac0f34absm3985771lfv.196.2022.07.20.12.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:28:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 07/10] soc: qcom: icc-bwmon: use regmap and prepare for BWMON v5
Date:   Wed, 20 Jul 2022 21:28:04 +0200
Message-Id: <20220720192807.130098-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code to prepare it for supporting BWMON v5 which comes with
different register layout by:
1. Adding use of MMIO regmap and regmap fields which allows to keep one
   code logic with different register maps.
2. The "clear" type registers do not allow reading, therefore regmap
   requires using cache with default values.
3. regmap has an effect of introducing barriers after each readl/writel,
   which should negligible effect as only few writes were relaxed.
4. Additionally usage of regmap fields removes need of shifting the
   register values.
5. Add "V4" prefix to names of all defines with register addresses (so
   BWMON_V4_xxx) to differentiate it from V5.  The actual register values
   are shared so keep their naming.
6. While changing the defines, pad register addresses to three digits
   for readability.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 299 ++++++++++++++++++++++++++---------
 1 file changed, 224 insertions(+), 75 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 9a99e0fd1140..a3bebd4f0c95 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -5,6 +5,8 @@
  * Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, based on
  *         previous work of Thara Gopinath and msm-4.9 downstream sources.
  */
+
+#include <linux/err.h>
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -13,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/regmap.h>
 #include <linux/sizes.h>
 
 /*
@@ -31,34 +34,34 @@
 /* Internal sampling clock frequency */
 #define HW_TIMER_HZ				19200000
 
-#define BWMON_GLOBAL_IRQ_STATUS			0x0
-#define BWMON_GLOBAL_IRQ_CLEAR			0x8
-#define BWMON_GLOBAL_IRQ_ENABLE			0xc
-#define BWMON_GLOBAL_IRQ_ENABLE_ENABLE		BIT(0)
-
-#define BWMON_IRQ_STATUS			0x100
-#define BWMON_IRQ_STATUS_ZONE_SHIFT		4
-#define BWMON_IRQ_CLEAR				0x108
-#define BWMON_IRQ_ENABLE			0x10c
-#define BWMON_IRQ_ENABLE_ZONE1_SHIFT		5
-#define BWMON_IRQ_ENABLE_ZONE2_SHIFT		6
-#define BWMON_IRQ_ENABLE_ZONE3_SHIFT		7
-#define BWMON_IRQ_ENABLE_MASK			(BIT(BWMON_IRQ_ENABLE_ZONE1_SHIFT) | \
-						 BIT(BWMON_IRQ_ENABLE_ZONE3_SHIFT))
-
-#define BWMON_ENABLE				0x2a0
+#define BWMON_V4_GLOBAL_IRQ_STATUS		0x000
+#define BWMON_V4_GLOBAL_IRQ_CLEAR		0x008
+#define BWMON_V4_GLOBAL_IRQ_ENABLE		0x00c
+/*
+ * All values here and further are matching regmap fields, so without absolute
+ * register offsets.
+ */
+#define BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE	BIT(0)
+
+#define BWMON_V4_IRQ_STATUS			0x100
+#define BWMON_V4_IRQ_CLEAR			0x108
+
+#define BWMON_V4_IRQ_ENABLE			0x10c
+#define BWMON_IRQ_ENABLE_MASK			(BIT(1) | BIT(3))
+
+#define BWMON_V4_ENABLE				0x2a0
 #define BWMON_ENABLE_ENABLE			BIT(0)
 
-#define BWMON_CLEAR				0x2a4
+#define BWMON_V4_CLEAR				0x2a4
 #define BWMON_CLEAR_CLEAR			BIT(0)
 #define BWMON_CLEAR_CLEAR_ALL			BIT(1)
 
-#define BWMON_SAMPLE_WINDOW			0x2a8
-#define BWMON_THRESHOLD_HIGH			0x2ac
-#define BWMON_THRESHOLD_MED			0x2b0
-#define BWMON_THRESHOLD_LOW			0x2b4
+#define BWMON_V4_SAMPLE_WINDOW			0x2a8
+#define BWMON_V4_THRESHOLD_HIGH			0x2ac
+#define BWMON_V4_THRESHOLD_MED			0x2b0
+#define BWMON_V4_THRESHOLD_LOW			0x2b4
 
-#define BWMON_ZONE_ACTIONS			0x2b8
+#define BWMON_V4_ZONE_ACTIONS			0x2b8
 /*
  * Actions to perform on some zone 'z' when current zone hits the threshold:
  * Increment counter of zone 'z'
@@ -84,27 +87,48 @@
 						 BWMON_ZONE_ACTIONS_CLEAR(2) | \
 						 BWMON_ZONE_ACTIONS_CLEAR(1) | \
 						 BWMON_ZONE_ACTIONS_CLEAR(0))
-/* Value for BWMON_ZONE_ACTIONS */
-#define BWMON_ZONE_ACTIONS_DEFAULT		(BWMON_ZONE_ACTIONS_ZONE0 | \
-						 BWMON_ZONE_ACTIONS_ZONE1 << 8 | \
-						 BWMON_ZONE_ACTIONS_ZONE2 << 16 | \
-						 BWMON_ZONE_ACTIONS_ZONE3 << 24)
 
 /*
- * There is no clear documentation/explanation of BWMON_THRESHOLD_COUNT
+ * There is no clear documentation/explanation of BWMON_V4_THRESHOLD_COUNT
  * register. Based on observations, this is number of times one threshold has to
  * be reached, to trigger interrupt in given zone.
  *
  * 0xff are maximum values meant to ignore the zones 0 and 2.
  */
-#define BWMON_THRESHOLD_COUNT			0x2bc
-#define BWMON_THRESHOLD_COUNT_ZONE1_SHIFT	8
-#define BWMON_THRESHOLD_COUNT_ZONE2_SHIFT	16
-#define BWMON_THRESHOLD_COUNT_ZONE3_SHIFT	24
+#define BWMON_V4_THRESHOLD_COUNT		0x2bc
 #define BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT	0xff
 #define BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT	0xff
 
-#define BWMON_ZONE_MAX(zone)			(0x2e0 + 4 * (zone))
+#define BWMON_V4_ZONE_MAX(zone)			(0x2e0 + 4 * (zone))
+
+enum bwmon_fields {
+	F_GLOBAL_IRQ_STATUS,
+	F_GLOBAL_IRQ_CLEAR,
+	F_GLOBAL_IRQ_ENABLE,
+	F_IRQ_STATUS,
+	F_IRQ_CLEAR,
+	F_IRQ_ENABLE,
+	F_ENABLE,
+	F_CLEAR,
+	F_SAMPLE_WINDOW,
+	F_THRESHOLD_HIGH,
+	F_THRESHOLD_MED,
+	F_THRESHOLD_LOW,
+	F_ZONE_ACTIONS_ZONE0,
+	F_ZONE_ACTIONS_ZONE1,
+	F_ZONE_ACTIONS_ZONE2,
+	F_ZONE_ACTIONS_ZONE3,
+	F_THRESHOLD_COUNT_ZONE0,
+	F_THRESHOLD_COUNT_ZONE1,
+	F_THRESHOLD_COUNT_ZONE2,
+	F_THRESHOLD_COUNT_ZONE3,
+	F_ZONE0_MAX,
+	F_ZONE1_MAX,
+	F_ZONE2_MAX,
+	F_ZONE3_MAX,
+
+	F_NUM_FIELDS
+};
 
 struct icc_bwmon_data {
 	unsigned int sample_ms;
@@ -114,20 +138,106 @@ struct icc_bwmon_data {
 	unsigned int default_lowbw_kbps;
 	u8 zone1_thres_count;
 	u8 zone3_thres_count;
+
+	const struct regmap_config *regmap_cfg;
+	const struct reg_field *regmap_fields;
 };
 
 struct icc_bwmon {
 	struct device *dev;
 	const struct icc_bwmon_data *data;
-	void __iomem *base;
 	int irq;
 
+	struct regmap *regmap;
+	struct regmap_field *regs[F_NUM_FIELDS];
+
 	unsigned int max_bw_kbps;
 	unsigned int min_bw_kbps;
 	unsigned int target_kbps;
 	unsigned int current_kbps;
 };
 
+/* BWMON v4 */
+static const struct reg_field msm8998_bwmon_reg_fields[] = {
+	[F_GLOBAL_IRQ_STATUS]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_STATUS, 0, 0),
+	[F_GLOBAL_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR, 0, 0),
+	[F_GLOBAL_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE, 0, 0),
+	[F_IRQ_STATUS]		= REG_FIELD(BWMON_V4_IRQ_STATUS, 4, 7),
+	[F_IRQ_CLEAR]		= REG_FIELD(BWMON_V4_IRQ_CLEAR, 4, 7),
+	[F_IRQ_ENABLE]		= REG_FIELD(BWMON_V4_IRQ_ENABLE, 4, 7),
+	/* F_ENABLE covers entire register to disable other features */
+	[F_ENABLE]		= REG_FIELD(BWMON_V4_ENABLE, 0, 31),
+	[F_CLEAR]		= REG_FIELD(BWMON_V4_CLEAR, 0, 1),
+	[F_SAMPLE_WINDOW]	= REG_FIELD(BWMON_V4_SAMPLE_WINDOW, 0, 23),
+	[F_THRESHOLD_HIGH]	= REG_FIELD(BWMON_V4_THRESHOLD_HIGH, 0, 11),
+	[F_THRESHOLD_MED]	= REG_FIELD(BWMON_V4_THRESHOLD_MED, 0, 11),
+	[F_THRESHOLD_LOW]	= REG_FIELD(BWMON_V4_THRESHOLD_LOW, 0, 11),
+	[F_ZONE_ACTIONS_ZONE0]	= REG_FIELD(BWMON_V4_ZONE_ACTIONS, 0, 7),
+	[F_ZONE_ACTIONS_ZONE1]	= REG_FIELD(BWMON_V4_ZONE_ACTIONS, 8, 15),
+	[F_ZONE_ACTIONS_ZONE2]	= REG_FIELD(BWMON_V4_ZONE_ACTIONS, 16, 23),
+	[F_ZONE_ACTIONS_ZONE3]	= REG_FIELD(BWMON_V4_ZONE_ACTIONS, 24, 31),
+	[F_THRESHOLD_COUNT_ZONE0]	= REG_FIELD(BWMON_V4_THRESHOLD_COUNT, 0, 7),
+	[F_THRESHOLD_COUNT_ZONE1]	= REG_FIELD(BWMON_V4_THRESHOLD_COUNT, 8, 15),
+	[F_THRESHOLD_COUNT_ZONE2]	= REG_FIELD(BWMON_V4_THRESHOLD_COUNT, 16, 23),
+	[F_THRESHOLD_COUNT_ZONE3]	= REG_FIELD(BWMON_V4_THRESHOLD_COUNT, 24, 31),
+	[F_ZONE0_MAX]		= REG_FIELD(BWMON_V4_ZONE_MAX(0), 0, 11),
+	[F_ZONE1_MAX]		= REG_FIELD(BWMON_V4_ZONE_MAX(1), 0, 11),
+	[F_ZONE2_MAX]		= REG_FIELD(BWMON_V4_ZONE_MAX(2), 0, 11),
+	[F_ZONE3_MAX]		= REG_FIELD(BWMON_V4_ZONE_MAX(3), 0, 11),
+};
+
+static const struct regmap_range msm8998_bwmon_reg_noread_ranges[] = {
+	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR, BWMON_V4_GLOBAL_IRQ_CLEAR),
+	regmap_reg_range(BWMON_V4_IRQ_CLEAR, BWMON_V4_IRQ_CLEAR),
+	regmap_reg_range(BWMON_V4_CLEAR, BWMON_V4_CLEAR),
+};
+
+static const struct regmap_access_table msm8998_bwmon_reg_read_table = {
+	.no_ranges	= msm8998_bwmon_reg_noread_ranges,
+	.n_no_ranges	= ARRAY_SIZE(msm8998_bwmon_reg_noread_ranges),
+};
+
+static const struct regmap_range msm8998_bwmon_reg_volatile_ranges[] = {
+	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_STATUS, BWMON_V4_GLOBAL_IRQ_STATUS),
+	regmap_reg_range(BWMON_V4_IRQ_STATUS, BWMON_V4_IRQ_STATUS),
+	regmap_reg_range(BWMON_V4_ZONE_MAX(0), BWMON_V4_ZONE_MAX(3)),
+};
+
+static const struct regmap_access_table msm8998_bwmon_reg_volatile_table = {
+	.yes_ranges	= msm8998_bwmon_reg_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(msm8998_bwmon_reg_volatile_ranges),
+};
+
+/*
+ * Fill the cache for non-readable registers only as rest does not really
+ * matter and can be read from the device.
+ */
+static const struct reg_default msm8998_bwmon_reg_defaults[] = {
+	{ BWMON_V4_GLOBAL_IRQ_CLEAR, 0x0 },
+	{ BWMON_V4_IRQ_CLEAR, 0x0 },
+	{ BWMON_V4_CLEAR, 0x0 },
+};
+
+static const struct regmap_config msm8998_bwmon_regmap_cfg = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	/*
+	 * No concurrent access expected - driver has one interrupt handler,
+	 * regmap is not shared, no driver or user-space API.
+	 */
+	.disable_locking	= true,
+	.rd_table		= &msm8998_bwmon_reg_read_table,
+	.volatile_table		= &msm8998_bwmon_reg_volatile_table,
+	.reg_defaults		= msm8998_bwmon_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(msm8998_bwmon_reg_defaults),
+	/*
+	 * Cache is necessary for using regmap fields with non-readable
+	 * registers.
+	 */
+	.cache_type		= REGCACHE_RBTREE,
+};
+
 static void bwmon_clear_counters(struct icc_bwmon *bwmon, bool clear_all)
 {
 	unsigned int val = BWMON_CLEAR_CLEAR;
@@ -142,7 +252,7 @@ static void bwmon_clear_counters(struct icc_bwmon *bwmon, bool clear_all)
 	 * region. So, we need to make sure the counter clear is completed
 	 * before we try to clear the IRQ or do any other counter operations.
 	 */
-	writel(val, bwmon->base + BWMON_CLEAR);
+	regmap_field_force_write(bwmon->regs[F_CLEAR], val);
 }
 
 static void bwmon_clear_irq(struct icc_bwmon *bwmon)
@@ -163,33 +273,33 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
 	 * clearing here so that local writes don't happen before the
 	 * interrupt is cleared.
 	 */
-	writel(BWMON_IRQ_ENABLE_MASK, bwmon->base + BWMON_IRQ_CLEAR);
-	writel(BWMON_GLOBAL_IRQ_ENABLE_ENABLE,
-	       bwmon->base + BWMON_GLOBAL_IRQ_CLEAR);
+	regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], BWMON_IRQ_ENABLE_MASK);
+	regmap_field_force_write(bwmon->regs[F_GLOBAL_IRQ_CLEAR],
+				 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
 }
 
 static void bwmon_disable(struct icc_bwmon *bwmon)
 {
 	/* Disable interrupts. Strict ordering, see bwmon_clear_irq(). */
-	writel(0x0, bwmon->base + BWMON_GLOBAL_IRQ_ENABLE);
-	writel(0x0, bwmon->base + BWMON_IRQ_ENABLE);
+	regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE], 0x0);
+	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], 0x0);
 
 	/*
 	 * Disable bwmon. Must happen before bwmon_clear_irq() to avoid spurious
 	 * IRQ.
 	 */
-	writel(0x0, bwmon->base + BWMON_ENABLE);
+	regmap_field_write(bwmon->regs[F_ENABLE], 0x0);
 }
 
 static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
 {
 	/* Enable interrupts */
-	writel(BWMON_GLOBAL_IRQ_ENABLE_ENABLE,
-	       bwmon->base + BWMON_GLOBAL_IRQ_ENABLE);
-	writel(irq_enable, bwmon->base + BWMON_IRQ_ENABLE);
+	regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE],
+			   BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], irq_enable);
 
 	/* Enable bwmon */
-	writel(BWMON_ENABLE_ENABLE, bwmon->base + BWMON_ENABLE);
+	regmap_field_write(bwmon->regs[F_ENABLE], BWMON_ENABLE_ENABLE);
 }
 
 static unsigned int bwmon_kbps_to_count(struct icc_bwmon *bwmon,
@@ -198,43 +308,51 @@ static unsigned int bwmon_kbps_to_count(struct icc_bwmon *bwmon,
 	return kbps / bwmon->data->count_unit_kb;
 }
 
-static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
-				unsigned int kbps)
+static void bwmon_set_threshold(struct icc_bwmon *bwmon,
+				struct regmap_field *reg, unsigned int kbps)
 {
 	unsigned int thres;
 
 	thres = mult_frac(bwmon_kbps_to_count(bwmon, kbps),
 			  bwmon->data->sample_ms, MSEC_PER_SEC);
-	writel_relaxed(thres, bwmon->base + reg);
+	regmap_field_write(reg, thres);
 }
 
 static void bwmon_start(struct icc_bwmon *bwmon)
 {
 	const struct icc_bwmon_data *data = bwmon->data;
-	unsigned int thres_count;
 	int window;
 
 	bwmon_clear_counters(bwmon, true);
 
 	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
 	/* Maximum sampling window: 0xfffff */
-	writel_relaxed(window, bwmon->base + BWMON_SAMPLE_WINDOW);
+	regmap_field_write(bwmon->regs[F_SAMPLE_WINDOW], window);
 
-	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_HIGH,
+	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH],
 			    data->default_highbw_kbps);
-	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_MED,
+	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED],
 			    data->default_medbw_kbps);
-	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_LOW,
+	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW],
 			    data->default_lowbw_kbps);
 
-	thres_count = data->zone3_thres_count << BWMON_THRESHOLD_COUNT_ZONE3_SHIFT |
-		      BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT << BWMON_THRESHOLD_COUNT_ZONE2_SHIFT |
-		      data->zone1_thres_count << BWMON_THRESHOLD_COUNT_ZONE1_SHIFT |
-		      BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT;
-	writel_relaxed(thres_count, bwmon->base + BWMON_THRESHOLD_COUNT);
-	writel_relaxed(BWMON_ZONE_ACTIONS_DEFAULT,
-		       bwmon->base + BWMON_ZONE_ACTIONS);
-	/* Write barriers in bwmon_clear_irq() */
+	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE0],
+			   BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT);
+	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE1],
+			   data->zone1_thres_count);
+	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE2],
+			   BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT);
+	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE3],
+			   data->zone3_thres_count);
+
+	regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE0],
+			   BWMON_ZONE_ACTIONS_ZONE0);
+	regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE1],
+			   BWMON_ZONE_ACTIONS_ZONE1);
+	regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE2],
+			   BWMON_ZONE_ACTIONS_ZONE2);
+	regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE3],
+			   BWMON_ZONE_ACTIONS_ZONE3);
 
 	bwmon_clear_irq(bwmon);
 	bwmon_enable(bwmon, BWMON_IRQ_ENABLE_MASK);
@@ -246,7 +364,9 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
 	unsigned int status, max;
 	int zone;
 
-	status = readl(bwmon->base + BWMON_IRQ_STATUS);
+	if (regmap_field_read(bwmon->regs[F_IRQ_STATUS], &status))
+		return IRQ_NONE;
+
 	status &= BWMON_IRQ_ENABLE_MASK;
 	if (!status) {
 		/*
@@ -263,13 +383,16 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
 
 	bwmon_disable(bwmon);
 
-	zone = get_bitmask_order(status >> BWMON_IRQ_STATUS_ZONE_SHIFT) - 1;
+	zone = get_bitmask_order(status) - 1;
 	/*
 	 * Zone max bytes count register returns count units within sampling
 	 * window.  Downstream kernel for BWMONv4 (called BWMON type 2 in
 	 * downstream) always increments the max bytes count by one.
 	 */
-	max = readl(bwmon->base + BWMON_ZONE_MAX(zone)) + 1;
+	if (regmap_field_read(bwmon->regs[F_ZONE0_MAX + zone], &max))
+		return IRQ_NONE;
+
+	max += 1;
 	max *= bwmon->data->count_unit_kb;
 	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->data->sample_ms);
 
@@ -301,15 +424,16 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
 	up_kbps = bwmon->target_kbps + 1;
 
 	if (bwmon->target_kbps >= bwmon->max_bw_kbps)
-		irq_enable = BIT(BWMON_IRQ_ENABLE_ZONE1_SHIFT);
+		irq_enable = BIT(1);
 	else if (bwmon->target_kbps <= bwmon->min_bw_kbps)
-		irq_enable = BIT(BWMON_IRQ_ENABLE_ZONE3_SHIFT);
+		irq_enable = BIT(3);
 	else
 		irq_enable = BWMON_IRQ_ENABLE_MASK;
 
-	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_HIGH, up_kbps);
-	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_MED, down_kbps);
-	/* Write barriers in bwmon_clear_counters() */
+	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH],
+			    up_kbps);
+	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED],
+			    down_kbps);
 	bwmon_clear_counters(bwmon, false);
 	bwmon_clear_irq(bwmon);
 	bwmon_enable(bwmon, irq_enable);
@@ -328,6 +452,32 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int bwmon_init_regmap(struct platform_device *pdev,
+			     struct icc_bwmon *bwmon)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	struct regmap *map;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "failed to map bwmon registers\n");
+
+	map = devm_regmap_init_mmio(dev, base, bwmon->data->regmap_cfg);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "failed to initialize regmap\n");
+
+	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_reg_fields) != F_NUM_FIELDS);
+	ret = devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
+					   bwmon->data->regmap_fields,
+					   F_NUM_FIELDS);
+
+	return ret;
+}
+
 static int bwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -341,11 +491,9 @@ static int bwmon_probe(struct platform_device *pdev)
 
 	bwmon->data = of_device_get_match_data(dev);
 
-	bwmon->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(bwmon->base)) {
-		dev_err(dev, "failed to map bwmon registers\n");
-		return PTR_ERR(bwmon->base);
-	}
+	ret = bwmon_init_regmap(pdev, bwmon);
+	if (ret)
+		return ret;
 
 	bwmon->irq = platform_get_irq(pdev, 0);
 	if (bwmon->irq < 0) {
@@ -391,7 +539,6 @@ static int bwmon_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/* BWMON v4 */
 static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.sample_ms = 4,
 	.count_unit_kb = 64,
@@ -400,6 +547,8 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.default_lowbw_kbps = 0,
 	.zone1_thres_count = 16,
 	.zone3_thres_count = 1,
+	.regmap_fields = msm8998_bwmon_reg_fields,
+	.regmap_cfg = &msm8998_bwmon_regmap_cfg,
 };
 
 static const struct of_device_id bwmon_of_match[] = {
-- 
2.34.1

