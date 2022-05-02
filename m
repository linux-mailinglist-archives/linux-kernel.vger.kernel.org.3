Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DE5517608
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386714AbiEBRot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353062AbiEBRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:44:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B129D3892
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:41:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a1so17432497edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=beiWtwdiGWYk/hX7L3DDscFJwlG+JFeoOEip16GPsIE=;
        b=QB50uPlIo9HDo64a8kt4QPJs2cUwPj/QpH1HECDURTr9QWD2OwIbdZ9lx8lA5y0EAv
         yClo0pszipB9+u4b+g5F8jv1CHNgshlhzGW7HVClTAMrHLw8szi0UWWvTWlI3sbqGBVu
         XlikmqFfBXhrfwdsziU+WIHN+Nw7TCfSqAUohVOrNl3yIgt/2YDsB9Wgf5oFUlUiwB6x
         CCtH0n9NthXcA5XcJr/lLUlPwxMSzaR5YOQc2/AmR0K4AWOjq/mpIml8AM5Ty+LMnKp0
         WJfvhEKeCta9uNUwPLbxZy80u+BTW+T4sGjQkFjXWNQrSENoD4eCNA0bbSOrDJhC9m5j
         bFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beiWtwdiGWYk/hX7L3DDscFJwlG+JFeoOEip16GPsIE=;
        b=qhkFuv1eB4SLKBdAo9syOFVHn13uweNyCwREyyB90sZhaV/kX6cdMMp6Czqym17E1V
         0J1xflUElCGmWKTjdNxqeZWvgReZy//arVAmzo19usu7PK33YzQ793yAT17B9a8KAwFB
         mlQ+sOeuvL8hX1+30V7Mu6YHarynihM8qA6WHuy/gvENhMNIWCudAqH3ZqukI2NGPkug
         N+aIs82yujjEDD503R7x3hX+fh1Zd5uBSpMuDc7/cywqWIcf8kagC1mLmmHnXkQC+nPf
         lymx7QIP6wFfAD9nmmQfiNlrneNkwtoiU1IxtAESvtblnQ6VyM+sizUOwIklK4o0gV7u
         /mcg==
X-Gm-Message-State: AOAM531C8ytolrRqbjOwj3PunCAYi/3C1aFnV+20t5MO9y3OzvU0oPh/
        Mw3UvlpiMMtNnSeDorQMztQwLQ==
X-Google-Smtp-Source: ABdhPJx0GN9oTTGmzHFdazr7S6WfbsW6MtVs9fLXv0OCXgtqppi07lbJ3CafAhZEq2zVvUUBa8aRrg==
X-Received: by 2002:a05:6402:1d90:b0:425:dd36:447c with SMTP id dk16-20020a0564021d9000b00425dd36447cmr14524632edb.347.1651513261965;
        Mon, 02 May 2022 10:41:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n9-20020aa7c689000000b0042617ba639csm6908547edq.38.2022.05.02.10.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 10:41:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH 3/4] soc: qcom: icc-bwmon: Add bandwidth monitoring driver
Date:   Mon,  2 May 2022 19:40:45 +0200
Message-Id: <20220502174046.139234-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220502174046.139234-1-krzysztof.kozlowski@linaro.org>
References: <20220502174046.139234-1-krzysztof.kozlowski@linaro.org>
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

Bandwidth monitoring h/w sits between various subsytems like cpu, gpu
etc and ddr subsystem. This h/w can be configured to monitor the data
traffic between ddr and other subsytems. The bandwidth values obtained
from this monitoring is used to bump up or down the corresponding
interconnect speeds.

Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS                  |   7 +
 drivers/soc/qcom/Kconfig     |  10 ++
 drivers/soc/qcom/Makefile    |   1 +
 drivers/soc/qcom/icc-bwmon.c | 328 +++++++++++++++++++++++++++++++++++
 4 files changed, 346 insertions(+)
 create mode 100644 drivers/soc/qcom/icc-bwmon.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6157e706ed02..bc123f706256 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16376,6 +16376,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
 F:	drivers/i2c/busses/i2c-qcom-cci.c
 
+QUALCOMM INTERCONNECT BWMON DRIVER
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
+F:	drivers/soc/qcom/icc-bwmon.c
+
 QUALCOMM IOMMU
 M:	Rob Clark <robdclark@gmail.com>
 L:	iommu@lists.linux-foundation.org
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e718b8735444..04375824e71a 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -228,4 +228,14 @@ config QCOM_APR
 	  application processor and QDSP6. APR is
 	  used by audio driver to configure QDSP6
 	  ASM, ADM and AFE modules.
+
+config QCOM_ICC_BWMON
+	tristate "QCOM Interconnect Bandwidth Monitor driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	select PM_OPP
+	help
+	  Sets up driver monitoring bandwidth on various interconnects and
+	  based on that voting for interconnect bandwidth, adjusting their
+	  speed to current demand.
+
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 70d5de69fd7b..d66604aff2b0 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
 obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
+obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
new file mode 100644
index 000000000000..6df8d9f6e6e1
--- /dev/null
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2022 Linaro Ltd
+ */
+#include <linux/interconnect.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/sizes.h>
+#include <linux/time64.h>
+
+#define HW_TIMER_HZ				19200000
+
+#define BWMON_GLOBAL_IRQ_STATUS			0x0
+#define BWMON_GLOBAL_IRQ_CLEAR			0x8
+#define BWMON_GLOBAL_IRQ_ENABLE			0xc
+#define BWMON_GLOBAL_IRQ_ENABLE_ENABLE		BIT(0)
+
+#define BWMON_IRQ_STATUS			0x100
+#define BWMON_IRQ_CLEAR				0x108
+#define BWMON_IRQ_ENABLE			0x10c
+#define BWMON_IRQ_ENABLE_ZONE1_SHIFT		5
+#define BWMON_IRQ_ENABLE_ZONE3_SHIFT		7
+
+#define BWMON_ENABLE				0x2a0
+#define BWMON_ENABLE_ENABLE			BIT(0)
+
+#define BWMON_CLEAR				0x2a4
+#define BWMON_CLEAR_CLEAR			BIT(0)
+
+#define BWMON_SAMPLE_WINDOW			0x2a8
+#define BWMON_THRESHOLD_HIGH			0x2ac
+#define BWMON_THRESHOLD_MED			0x2b0
+#define BWMON_THRESHOLD_LOW			0x2b4
+
+#define BWMON_ZONE_ACTIONS			0x2b8
+#define BWMON_ZONE_ACTIONS_DEFAULT		0x95250901
+
+#define BWMON_THRESHOLD_COUNT			0x2bc
+#define BWMON_THRESHOLD_COUNT_ZONE1_SHIFT	8
+#define BWMON_THRESHOLD_COUNT_ZONE2_SHIFT	16
+#define BWMON_THRESHOLD_COUNT_ZONE3_SHIFT	24
+#define BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT	0xFF
+#define BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT     0xFF
+
+/* BWMON registers count data in MB/s */
+#define BWMON_ZONE_COUNT			0x2d8
+#define BWMON_ZONE_MAX(zone)			(0x2e0 + 4 * (zone))
+
+struct icc_bwmon_data {
+	unsigned int sample_ms;
+	unsigned int default_highbw_kbps;
+	unsigned int default_medbw_kbps;
+	unsigned int default_lowbw_kbps;
+	u8 zone1_thres_count;
+	u8 zone3_thres_count;
+};
+
+struct icc_bwmon {
+	struct device *dev;
+	void __iomem *base;
+	int irq;
+
+	unsigned int sample_ms;
+	unsigned int max_bw_kbps;
+	unsigned int min_bw_kbps;
+	unsigned int target_kbps;
+	unsigned int current_kbps;
+};
+
+static void bwmon_clear(struct icc_bwmon *bwmon)
+{
+	/*
+	 * Clear zone and global interrupts. The order and barriers are
+	 * important. Quoting downstream Qualcomm msm-4.9 tree:
+	 *
+	 * Synchronize the local interrupt clear in mon_irq_clear()
+	 * with the global interrupt clear here. Otherwise, the CPU
+	 * may reorder the two writes and clear the global interrupt
+	 * before the local interrupt, causing the global interrupt
+	 * to be retriggered by the local interrupt still being high.
+	 *
+	 * Similarly, because the global registers are in a different
+	 * region than the local registers, we need to ensure any register
+	 * writes to enable the monitor after this call are ordered with the
+	 * clearing here so that local writes don't happen before the
+	 * interrupt is cleared.
+	 */
+	writel(0xa0, bwmon->base + BWMON_IRQ_CLEAR);
+	writel(BIT(0), bwmon->base + BWMON_GLOBAL_IRQ_CLEAR);
+
+	/* Clear counters */
+	writel(BWMON_CLEAR_CLEAR, bwmon->base + BWMON_CLEAR);
+}
+
+static void bwmon_disable(struct icc_bwmon *bwmon)
+{
+	/* Disable interrupts. Strict ordering, see bwmon_clear(). */
+	writel(0x0, bwmon->base + BWMON_GLOBAL_IRQ_ENABLE);
+	writel(0x0, bwmon->base + BWMON_IRQ_ENABLE);
+
+	/* Disable bwmon */
+	writel(0x0, bwmon->base + BWMON_ENABLE);
+}
+
+static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
+{
+	/* Enable interrupts */
+	writel(BWMON_GLOBAL_IRQ_ENABLE_ENABLE,
+	       bwmon->base + BWMON_GLOBAL_IRQ_ENABLE);
+	writel(irq_enable, bwmon->base + BWMON_IRQ_ENABLE);
+
+	/* Enable bwmon */
+	writel(BWMON_ENABLE_ENABLE, bwmon->base + BWMON_ENABLE);
+}
+
+static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
+				unsigned int kbps)
+{
+	unsigned int mbps = kbps / SZ_1K;
+	unsigned int thres;
+
+	thres = mult_frac(mbps, bwmon->sample_ms, MSEC_PER_SEC);
+	writel_relaxed(thres, bwmon->base + reg);
+}
+
+static void bwmon_start(struct icc_bwmon *bwmon,
+			const struct icc_bwmon_data *data)
+{
+	unsigned int thres_count, irq_enable;
+	int window;
+
+	bwmon_clear(bwmon);
+
+	window = mult_frac(bwmon->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
+	writel_relaxed(window, bwmon->base + BWMON_SAMPLE_WINDOW);
+
+	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_HIGH,
+			    data->default_highbw_kbps);
+	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_MED,
+			    data->default_medbw_kbps);
+	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_LOW,
+			    data->default_lowbw_kbps);
+
+	thres_count = data->zone3_thres_count << BWMON_THRESHOLD_COUNT_ZONE3_SHIFT |
+			BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT << BWMON_THRESHOLD_COUNT_ZONE2_SHIFT |
+			data->zone1_thres_count << BWMON_THRESHOLD_COUNT_ZONE1_SHIFT |
+			BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT;
+	writel_relaxed(thres_count, bwmon->base + BWMON_THRESHOLD_COUNT);
+	writel_relaxed(BWMON_ZONE_ACTIONS_DEFAULT,
+		       bwmon->base + BWMON_ZONE_ACTIONS);
+
+	/* Write barriers in bwmon_clear() */
+	irq_enable = BIT(BWMON_IRQ_ENABLE_ZONE1_SHIFT) |
+			BIT(BWMON_IRQ_ENABLE_ZONE3_SHIFT);
+	bwmon_clear(bwmon);
+	bwmon_enable(bwmon, irq_enable);
+}
+
+static irqreturn_t bwmon_intr(int irq, void *dev_id)
+{
+	struct icc_bwmon *bwmon = dev_id;
+	unsigned int status, max;
+	int zone;
+
+	status = readl(bwmon->base + BWMON_IRQ_STATUS);
+
+	if (!status)
+		return IRQ_NONE;
+
+	bwmon_disable(bwmon);
+
+	zone = get_bitmask_order(status >> 4) - 1;
+	max = readl(bwmon->base + BWMON_ZONE_MAX(zone)) * SZ_1K;
+	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->sample_ms);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
+{
+	struct icc_bwmon *bwmon = dev_id;
+	unsigned int irq_enable = 0;
+	struct dev_pm_opp *opp, *target_opp;
+	unsigned int bw_kbps, up_kbps, down_kbps;
+
+	bw_kbps = bwmon->target_kbps;
+
+	target_opp = dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_kbps, 0);
+	if (IS_ERR(target_opp) && PTR_ERR(target_opp) == -ERANGE)
+		target_opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
+
+	bwmon->target_kbps = bw_kbps;
+
+	bw_kbps--;
+	opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
+	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
+		down_kbps = bwmon->target_kbps;
+	else
+		down_kbps = bw_kbps;
+
+	up_kbps = bwmon->target_kbps + 1;
+
+	if (bwmon->target_kbps >= bwmon->max_bw_kbps)
+		irq_enable = BIT(BWMON_IRQ_ENABLE_ZONE1_SHIFT);
+	else if (bwmon->target_kbps <= bwmon->min_bw_kbps)
+		irq_enable = BIT(BWMON_IRQ_ENABLE_ZONE3_SHIFT);
+	else
+		irq_enable = BIT(BWMON_IRQ_ENABLE_ZONE1_SHIFT) |
+				BIT(BWMON_IRQ_ENABLE_ZONE3_SHIFT);
+
+	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_HIGH, up_kbps);
+	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_MED, down_kbps);
+	bwmon_clear(bwmon);
+	bwmon_enable(bwmon, irq_enable);
+
+	if (bwmon->target_kbps == bwmon->current_kbps)
+		goto out;
+
+	dev_pm_opp_set_opp(bwmon->dev, target_opp);
+	bwmon->current_kbps = bwmon->target_kbps;
+
+out:
+	dev_pm_opp_put(target_opp);
+	if (!IS_ERR(opp))
+		dev_pm_opp_put(opp);
+
+	return IRQ_HANDLED;
+}
+
+static int bwmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dev_pm_opp *opp;
+	struct icc_bwmon *bwmon;
+	const struct icc_bwmon_data *data;
+	int ret;
+
+	bwmon = devm_kzalloc(dev, sizeof(*bwmon), GFP_KERNEL);
+	if (!bwmon)
+		return -ENOMEM;
+
+	data = of_device_get_match_data(dev);
+
+	bwmon->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(bwmon->base)) {
+		dev_err(dev, "failed to map bwmon registers\n");
+		return PTR_ERR(bwmon->base);
+	}
+
+	bwmon->irq = platform_get_irq(pdev, 0);
+	if (bwmon->irq < 0) {
+		dev_err(dev, "failed to acquire bwmon IRQ\n");
+		return bwmon->irq;
+	}
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add OPP table\n");
+
+	bwmon->max_bw_kbps = UINT_MAX;
+	opp = dev_pm_opp_find_bw_floor(dev, &bwmon->max_bw_kbps, 0);
+	if (IS_ERR(opp))
+		return dev_err_probe(dev, ret, "failed to find max peak bandwidth\n");
+
+	bwmon->min_bw_kbps = 0;
+	opp = dev_pm_opp_find_bw_ceil(dev, &bwmon->min_bw_kbps, 0);
+	if (IS_ERR(opp))
+		return dev_err_probe(dev, ret, "failed to find min peak bandwidth\n");
+
+	bwmon->sample_ms = data->sample_ms;
+	bwmon->dev = dev;
+
+	bwmon_disable(bwmon);
+	ret = devm_request_threaded_irq(dev, bwmon->irq, bwmon_intr,
+					bwmon_intr_thread,
+					IRQF_ONESHOT, dev_name(dev), bwmon);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request IRQ\n");
+
+	platform_set_drvdata(pdev, bwmon);
+	bwmon_start(bwmon, data);
+
+	return 0;
+}
+
+static int bwmon_remove(struct platform_device *pdev)
+{
+	struct icc_bwmon *bwmon = platform_get_drvdata(pdev);
+
+	bwmon_disable(bwmon);
+
+	return 0;
+}
+
+/* BWMON v4 */
+static const struct icc_bwmon_data sdm845_bwmon_data = {
+	.sample_ms = 4,
+	.default_highbw_kbps = 4800 * SZ_1K,
+	.default_medbw_kbps = 512 * SZ_1K,
+	.default_lowbw_kbps = 0,
+	.zone1_thres_count = 0x10,
+	.zone3_thres_count = 0x1,
+};
+
+static const struct of_device_id bwmon_of_match[] = {
+	{ .compatible = "qcom,sdm845-cpu-bwmon", .data = &sdm845_bwmon_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bwmon_of_match);
+
+static struct platform_driver bwmon_driver = {
+	.probe = bwmon_probe,
+	.remove = bwmon_remove,
+	.driver = {
+		.name = "qcom-bwmon",
+		.of_match_table = bwmon_of_match,
+	},
+};
+module_platform_driver(bwmon_driver);
+
+MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>")
+MODULE_DESCRIPTION("QCOM BWMON driver");
+MODULE_LICENSE("GPL");
-- 
2.32.0

