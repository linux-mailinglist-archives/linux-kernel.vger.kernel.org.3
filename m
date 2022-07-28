Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF7583DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiG1Lim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbiG1LiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:38:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352FC67C96
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:38:06 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p11so2436332lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYKgtXbC6M81o5n5MmlncGdoVxGwT+Tv4FLOQPkkTSw=;
        b=LSBAsFqR+mGes7JClitzRdjsmAMyXjboTZXQUi7m8mP+D+sR0Nny1XQ6MuVoUyhYqq
         fNc2vdDkWXVsaRbYC+OTfSM61PnKO4WxLZv8RCqM4TSPcFIhsvRo2vB379NndWG0V2Hx
         13O7YmOPXZYpH92OUuDQ2mEVZkUQJTzTT3Y+z0ilOiv4JjbpiPFvQo/m3d0M3SrXcRSP
         vpUf+m1VF2nQb3p7MwiVg6FBzZ3348gzuGYa91gmWJAO9MBY439v0crgDKixRKFQj6+D
         BPjkl8GJb6k0J47OMR9BLrFjItbqfzf6Bwu7Tdm2ysKaySI5Mezln2uaJ7Lfw4crM5q0
         eRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYKgtXbC6M81o5n5MmlncGdoVxGwT+Tv4FLOQPkkTSw=;
        b=QX6e1h6SPeu+UUMOumW/VctHpDk4/iDIwBcoJQpgJEriV33kNDIkjIj+8uUqOU7i45
         pWpMt5MxqCH26HqLy2PMKHQ1t7CuSdfDM3bN/bMxnFOCd6iWQ4SUyQzGhP3jXDd9DfQ5
         ZUzmnP4rowx2YNrY/lHHwnH400o1KHXjy0QlI/J+3oKmyZp6Hx+9k6Usbz0VvsFm8OTk
         4IgQYrXzUNrIgY9KU771yvWaMvg1g7nmV9x3CPBy+ICy1TnGPn5jHd/ZoMggNp99MR4f
         9EHO8I8un6xUR7qNwxg/6+rIjh3GZOJpuT5Lkv3I59B1Kp+Lv2raZDGL3Qsn1iFysJ8/
         bDEw==
X-Gm-Message-State: AJIora9hjGd4WsCHkBq+WxtzjE5SwbomlyQqlQS4ZowAQM2cML0rQnYK
        jI/1EjjENVZ/uaDToaHGqxquwg==
X-Google-Smtp-Source: AGRyM1sj7sUaasSDls9bccUugS6pNNyXcVo9IlKZaxHMLmQ+5W9C0tpzLQiSQFT46mzBdma27sXa+w==
X-Received: by 2002:a19:8c04:0:b0:48a:7683:3845 with SMTP id o4-20020a198c04000000b0048a76833845mr11129029lfd.297.1659008285467;
        Thu, 28 Jul 2022 04:38:05 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id l12-20020a2ea80c000000b0025e0396786dsm98192ljq.93.2022.07.28.04.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:38:04 -0700 (PDT)
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
Subject: [PATCH v2 09/11] soc: qcom: icc-bwmon: add support for SDM845 LLCC BWMON
Date:   Thu, 28 Jul 2022 13:37:46 +0200
Message-Id: <20220728113748.170548-10-krzysztof.kozlowski@linaro.org>
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

The SDM845 comes with few instances of Bandwidth Monitor.  The already
supported one monitors traffic between CPU and Last Level Cache
Controller (LLCC) and in downstream sources is called BWMON v4 (or v4 of
register layout).

SDM845 also has also BWMON instance measuring traffic between LLCC and
memory with different register layout: called v5.

Add support for this "LLCC" BWMON.  Differences against existing v4 one:
1. No global interrupts.
2. Different register layout.
3. Different shift of interrupt fields.
4. Smaller sampling window.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 113 ++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 2e4a0fdfbf54..266523a9e364 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -47,20 +47,31 @@
 
 #define BWMON_V4_IRQ_ENABLE			0x10c
 #define BWMON_IRQ_ENABLE_MASK			(BIT(1) | BIT(3))
+#define BWMON_V5_IRQ_STATUS			0x000
+#define BWMON_V5_IRQ_CLEAR			0x008
+#define BWMON_V5_IRQ_ENABLE			0x00c
 
 #define BWMON_V4_ENABLE				0x2a0
+#define BWMON_V5_ENABLE				0x010
 #define BWMON_ENABLE_ENABLE			BIT(0)
 
 #define BWMON_V4_CLEAR				0x2a4
+#define BWMON_V5_CLEAR				0x014
 #define BWMON_CLEAR_CLEAR			BIT(0)
 #define BWMON_CLEAR_CLEAR_ALL			BIT(1)
 
 #define BWMON_V4_SAMPLE_WINDOW			0x2a8
+#define BWMON_V5_SAMPLE_WINDOW			0x020
+
 #define BWMON_V4_THRESHOLD_HIGH			0x2ac
 #define BWMON_V4_THRESHOLD_MED			0x2b0
 #define BWMON_V4_THRESHOLD_LOW			0x2b4
+#define BWMON_V5_THRESHOLD_HIGH			0x024
+#define BWMON_V5_THRESHOLD_MED			0x028
+#define BWMON_V5_THRESHOLD_LOW			0x02c
 
 #define BWMON_V4_ZONE_ACTIONS			0x2b8
+#define BWMON_V5_ZONE_ACTIONS			0x030
 /*
  * Actions to perform on some zone 'z' when current zone hits the threshold:
  * Increment counter of zone 'z'
@@ -95,10 +106,12 @@
  * 0xff are maximum values meant to ignore the zones 0 and 2.
  */
 #define BWMON_V4_THRESHOLD_COUNT		0x2bc
+#define BWMON_V5_THRESHOLD_COUNT		0x034
 #define BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT	0xff
 #define BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT	0xff
 
 #define BWMON_V4_ZONE_MAX(zone)			(0x2e0 + 4 * (zone))
+#define BWMON_V5_ZONE_MAX(zone)			(0x044 + 4 * (zone))
 
 /* Quirks for specific BWMON types */
 #define BWMON_HAS_GLOBAL_IRQ			BIT(0)
@@ -238,6 +251,83 @@ static const struct regmap_config msm8998_bwmon_regmap_cfg = {
 	.cache_type		= REGCACHE_RBTREE,
 };
 
+/* BWMON v5 */
+static const struct reg_field sdm845_llcc_bwmon_reg_fields[] = {
+	[F_GLOBAL_IRQ_CLEAR]	= {},
+	[F_GLOBAL_IRQ_ENABLE]	= {},
+	[F_IRQ_STATUS]		= REG_FIELD(BWMON_V5_IRQ_STATUS, 0, 3),
+	[F_IRQ_CLEAR]		= REG_FIELD(BWMON_V5_IRQ_CLEAR, 0, 3),
+	[F_IRQ_ENABLE]		= REG_FIELD(BWMON_V5_IRQ_ENABLE, 0, 3),
+	/* F_ENABLE covers entire register to disable other features */
+	[F_ENABLE]		= REG_FIELD(BWMON_V5_ENABLE, 0, 31),
+	[F_CLEAR]		= REG_FIELD(BWMON_V5_CLEAR, 0, 1),
+	[F_SAMPLE_WINDOW]	= REG_FIELD(BWMON_V5_SAMPLE_WINDOW, 0, 19),
+	[F_THRESHOLD_HIGH]	= REG_FIELD(BWMON_V5_THRESHOLD_HIGH, 0, 11),
+	[F_THRESHOLD_MED]	= REG_FIELD(BWMON_V5_THRESHOLD_MED, 0, 11),
+	[F_THRESHOLD_LOW]	= REG_FIELD(BWMON_V5_THRESHOLD_LOW, 0, 11),
+	[F_ZONE_ACTIONS_ZONE0]	= REG_FIELD(BWMON_V5_ZONE_ACTIONS, 0, 7),
+	[F_ZONE_ACTIONS_ZONE1]	= REG_FIELD(BWMON_V5_ZONE_ACTIONS, 8, 15),
+	[F_ZONE_ACTIONS_ZONE2]	= REG_FIELD(BWMON_V5_ZONE_ACTIONS, 16, 23),
+	[F_ZONE_ACTIONS_ZONE3]	= REG_FIELD(BWMON_V5_ZONE_ACTIONS, 24, 31),
+	[F_THRESHOLD_COUNT_ZONE0]	= REG_FIELD(BWMON_V5_THRESHOLD_COUNT, 0, 7),
+	[F_THRESHOLD_COUNT_ZONE1]	= REG_FIELD(BWMON_V5_THRESHOLD_COUNT, 8, 15),
+	[F_THRESHOLD_COUNT_ZONE2]	= REG_FIELD(BWMON_V5_THRESHOLD_COUNT, 16, 23),
+	[F_THRESHOLD_COUNT_ZONE3]	= REG_FIELD(BWMON_V5_THRESHOLD_COUNT, 24, 31),
+	[F_ZONE0_MAX]		= REG_FIELD(BWMON_V5_ZONE_MAX(0), 0, 11),
+	[F_ZONE1_MAX]		= REG_FIELD(BWMON_V5_ZONE_MAX(1), 0, 11),
+	[F_ZONE2_MAX]		= REG_FIELD(BWMON_V5_ZONE_MAX(2), 0, 11),
+	[F_ZONE3_MAX]		= REG_FIELD(BWMON_V5_ZONE_MAX(3), 0, 11),
+};
+
+static const struct regmap_range sdm845_llcc_bwmon_reg_noread_ranges[] = {
+	regmap_reg_range(BWMON_V5_IRQ_CLEAR, BWMON_V5_IRQ_CLEAR),
+	regmap_reg_range(BWMON_V5_CLEAR, BWMON_V5_CLEAR),
+};
+
+static const struct regmap_access_table sdm845_llcc_bwmon_reg_read_table = {
+	.no_ranges	= sdm845_llcc_bwmon_reg_noread_ranges,
+	.n_no_ranges	= ARRAY_SIZE(sdm845_llcc_bwmon_reg_noread_ranges),
+};
+
+static const struct regmap_range sdm845_llcc_bwmon_reg_volatile_ranges[] = {
+	regmap_reg_range(BWMON_V5_IRQ_STATUS, BWMON_V5_IRQ_STATUS),
+	regmap_reg_range(BWMON_V5_ZONE_MAX(0), BWMON_V5_ZONE_MAX(3)),
+};
+
+static const struct regmap_access_table sdm845_llcc_bwmon_reg_volatile_table = {
+	.yes_ranges	= sdm845_llcc_bwmon_reg_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(sdm845_llcc_bwmon_reg_volatile_ranges),
+};
+
+/*
+ * Fill the cache for non-readable registers only as rest does not really
+ * matter and can be read from the device.
+ */
+static const struct reg_default sdm845_llcc_bwmon_reg_defaults[] = {
+	{ BWMON_V5_IRQ_CLEAR, 0x0 },
+	{ BWMON_V5_CLEAR, 0x0 },
+};
+
+static const struct regmap_config sdm845_llcc_bwmon_regmap_cfg = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	/*
+	 * No concurrent access expected - driver has one interrupt handler,
+	 * regmap is not shared, no driver or user-space API.
+	 */
+	.disable_locking	= true,
+	.rd_table		= &sdm845_llcc_bwmon_reg_read_table,
+	.volatile_table		= &sdm845_llcc_bwmon_reg_volatile_table,
+	.reg_defaults		= sdm845_llcc_bwmon_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(sdm845_llcc_bwmon_reg_defaults),
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
@@ -329,7 +419,7 @@ static void bwmon_start(struct icc_bwmon *bwmon)
 	bwmon_clear_counters(bwmon, true);
 
 	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
-	/* Maximum sampling window: 0xfffff */
+	/* Maximum sampling window: 0xffffff for v4 and 0xfffff for v5 */
 	regmap_field_write(bwmon->regs[F_SAMPLE_WINDOW], window);
 
 	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH],
@@ -474,6 +564,7 @@ static int bwmon_init_regmap(struct platform_device *pdev,
 				     "failed to initialize regmap\n");
 
 	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_reg_fields) != F_NUM_FIELDS);
+	BUILD_BUG_ON(ARRAY_SIZE(sdm845_llcc_bwmon_reg_fields) != F_NUM_FIELDS);
 	ret = devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
 					   bwmon->data->regmap_fields,
 					   F_NUM_FIELDS);
@@ -555,8 +646,26 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.regmap_cfg = &msm8998_bwmon_regmap_cfg,
 };
 
+static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
+	.sample_ms = 4,
+	.count_unit_kb = 1024,
+	.default_highbw_kbps = 800 * 1024, /* 800 MBps */
+	.default_medbw_kbps = 256 * 1024, /* 256 MBps */
+	.default_lowbw_kbps = 0,
+	.zone1_thres_count = 16,
+	.zone3_thres_count = 1,
+	.regmap_fields = sdm845_llcc_bwmon_reg_fields,
+	.regmap_cfg = &sdm845_llcc_bwmon_regmap_cfg,
+};
+
 static const struct of_device_id bwmon_of_match[] = {
-	{ .compatible = "qcom,msm8998-bwmon", .data = &msm8998_bwmon_data },
+	{
+		.compatible = "qcom,msm8998-bwmon",
+		.data = &msm8998_bwmon_data
+	}, {
+		.compatible = "qcom,sdm845-llcc-bwmon",
+		.data = &sdm845_llcc_bwmon_data
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, bwmon_of_match);
-- 
2.34.1

