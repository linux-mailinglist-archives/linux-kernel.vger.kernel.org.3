Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40587583DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiG1Li3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbiG1LiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:38:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B67063906
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:38:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b16so2419849lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xiJMl7C79xr0uHwTRN2FfN+Mp4vk2K6luyXQ4lnoiyQ=;
        b=F83HUXra9QSfs56ky9Gv9QOjjjrKG3g6gvP9B7GeVDtr/bDyzArXKIF8cd7YCM5f38
         ToWuyPVBV9MBBpfXHpEz6TE8oWfPB/YhUqmYBijS8BHZ/QPyQYa1qchCT8n3sYXbdE+p
         v6ZeQAqQ77TxyMMxOIPXdiQGR/BU20GTOZ8roMn2MwNbO8qbUQCKZT5X1E1BWlFklW6n
         jVCYR0CXgYuE5/fN7njPJ7ZSkR7mSK/AVQx2/XVCyjDOAdw2WDiOSBzArs/AkL83V3wW
         trY2yUmyHUYZFymBFwb3JXZsXNAAaLTt/kl7t9C4R2FlzooTlw6WG36oBWHqOwX0NBoq
         Ip5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xiJMl7C79xr0uHwTRN2FfN+Mp4vk2K6luyXQ4lnoiyQ=;
        b=pDu7HogKmvw7agOBUFoE+/q4FkN6DzN3LoSj+xTjPBpUAuu7XYPYD1bofY5bsqOf2V
         IuLqUc9hheqg4S8mWBT7Tdh9vvR/33L4zv3CPf0ZqaecA+3hHAzoSRWUYX+q/u8cHbXZ
         VYDZUxgfPh8ItIR68gZSZgefoBy74wLh8FExyqN8aQicxD9Ipd2ZgjptNeBRKWm0o5ub
         UKS5YaKJO8N5VUpvQ35HlpmIJ9lqHQqhtAkFGGiMa1eOD+NO1KSfawkn3/CYoT+9CIaY
         b4qlXGY6DprQtASrw6QOKOW63gaAYEM1YErczBPySzKFVwju5xQ7O9DkRBvaZia2fJyX
         28gA==
X-Gm-Message-State: AJIora/EMV1yb9ir2SHltg1+BEEwoSVVNouA9JSlQfDSa+PVNw/VwVEp
        LvU2h4eOP3qyHq5vdIYIjHyaNQ==
X-Google-Smtp-Source: AGRyM1stG7My2MOIQi20LMGXtJEpLVhIXWYUYZEl98xhXV1xTyexpeupCYVnZRw3wPm+qsonJ7WPLQ==
X-Received: by 2002:a05:6512:3b0f:b0:48a:b122:8205 with SMTP id f15-20020a0565123b0f00b0048ab1228205mr3522339lfv.136.1659008282643;
        Thu, 28 Jul 2022 04:38:02 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id l12-20020a2ea80c000000b0025e0396786dsm98192ljq.93.2022.07.28.04.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:38:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v2 07/11] soc: qcom: icc-bwmon: use regmap and prepare for BWMON v5
Date:   Thu, 28 Jul 2022 13:37:44 +0200
Message-Id: <20220728113748.170548-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
References: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
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
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 294 ++++++++++++++++++++++++++---------
 1 file changed, 220 insertions(+), 74 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 7fd0e41c63e6..058c35d8dbbe 100644
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
@@ -31,33 +34,33 @@
 /* Internal sampling clock frequency */
 #define HW_TIMER_HZ				19200000
 
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
@@ -83,27 +86,47 @@
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
@@ -113,20 +136,104 @@ struct icc_bwmon_data {
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
@@ -141,7 +248,7 @@ static void bwmon_clear_counters(struct icc_bwmon *bwmon, bool clear_all)
 	 * region. So, we need to make sure the counter clear is completed
 	 * before we try to clear the IRQ or do any other counter operations.
 	 */
-	writel(val, bwmon->base + BWMON_CLEAR);
+	regmap_field_force_write(bwmon->regs[F_CLEAR], val);
 }
 
 static void bwmon_clear_irq(struct icc_bwmon *bwmon)
@@ -162,33 +269,33 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
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
@@ -197,43 +304,51 @@ static unsigned int bwmon_kbps_to_count(struct icc_bwmon *bwmon,
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
@@ -245,7 +360,9 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
 	unsigned int status, max;
 	int zone;
 
-	status = readl(bwmon->base + BWMON_IRQ_STATUS);
+	if (regmap_field_read(bwmon->regs[F_IRQ_STATUS], &status))
+		return IRQ_NONE;
+
 	status &= BWMON_IRQ_ENABLE_MASK;
 	if (!status) {
 		/*
@@ -262,13 +379,16 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
 
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
 
@@ -300,15 +420,16 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
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
@@ -327,6 +448,32 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
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
@@ -340,11 +487,9 @@ static int bwmon_probe(struct platform_device *pdev)
 
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
@@ -390,7 +535,6 @@ static int bwmon_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/* BWMON v4 */
 static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.sample_ms = 4,
 	.count_unit_kb = 64,
@@ -399,6 +543,8 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.default_lowbw_kbps = 0,
 	.zone1_thres_count = 16,
 	.zone3_thres_count = 1,
+	.regmap_fields = msm8998_bwmon_reg_fields,
+	.regmap_cfg = &msm8998_bwmon_regmap_cfg,
 };
 
 static const struct of_device_id bwmon_of_match[] = {
-- 
2.34.1

