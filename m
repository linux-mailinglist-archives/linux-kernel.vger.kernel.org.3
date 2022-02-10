Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D14B09E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbiBJJtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:49:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbiBJJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:49:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56141DE4;
        Thu, 10 Feb 2022 01:49:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m14so8423357wrg.12;
        Thu, 10 Feb 2022 01:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eI3fCFf37CCoQJRBAcmDJpz8mE50p5tBxfje5+tt4pg=;
        b=Xi1f3pZq+klAMhE3RIy6dcglxD+vh1ffEqI/q4ThVpJY4UUKwU8IAXrll5CTnQzodI
         A5aDTZrdPwYwLLCI0Z9XeiiV9cgwHI8QmGmrNQXaHVSWmlrtccB1OsczH/MBSJX7p1jp
         BO1X9LpkyG6Y9XO+Gl7wiC7dbsv9f3DKnMtyoKdtR82Mvql5QWPMFPWC41dhMDq0/xzJ
         +DGJn3c/vi7yZcBMA6FMZDJGS93jNgvDW+rS4ja/XbW4XfOOXuhWCJV/k9T0MfD3F1r/
         rxuVTjRYccrTqLv9WdEWYmcLzyQ1Me6ATbTIoCFVwT24IRTFX1LWRpIZ/YhG21/nSwWx
         IPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eI3fCFf37CCoQJRBAcmDJpz8mE50p5tBxfje5+tt4pg=;
        b=42TTTrKg/AHq3LOA0d7G7U0etqXt+y+tsUfZsvNvppZO0+7XyXyHqN0nt/jvnsh10X
         yqFT1qg/GBSQg96Bw52BrwNOdD0w3lKNLAf7rRdij/B8+IX9tRXykQ6wFXrIEOsDX0sx
         K+BvL19V054Lw9dI1YQByewOW1EmPJzS0lIY1B1607RtU/TCCUYIhRptHnWHb+3wRNmF
         ioLwYka1CDiQd6S2qyYzmMDF0af0voT7QBpKN/b5C+q6/EIpDoAHHMWpCr8y0tnHdsLH
         rigUPp6ZZcjY/A2DFqfhRcPAT88PRiP9wTZuSDNqBUCpO1b2kl7Kqig3SDdd6E8lEi1u
         wFtA==
X-Gm-Message-State: AOAM532JSUkvMA7Ym2p+w0jHfif+8a14pW8DRnv8kC/J5eB/sG3DBIMJ
        n7thXlAHqRxF1grEy0KQWOx+WPQxzBM=
X-Google-Smtp-Source: ABdhPJw1khVqZkbk0yx0tHKDjJfm/laxlwndE2gAJXpxHvGe4EbZ1IuVaQ7GdrTL1Q0CCfKagYTChA==
X-Received: by 2002:a05:6000:168c:: with SMTP id y12mr5518658wrd.265.1644486543616;
        Thu, 10 Feb 2022 01:49:03 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id j6sm6636601wrt.70.2022.02.10.01.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 01:49:03 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Subject: [PATCH v9 2/2] clk: ralink: make system controller node a reset provider
Date:   Thu, 10 Feb 2022 10:48:59 +0100
Message-Id: <20220210094859.927868-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210094859.927868-1-sergio.paracuellos@gmail.com>
References: <20220210094859.927868-1-sergio.paracuellos@gmail.com>
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

MT7621 system controller node is already providing the clocks for the whole
system but must also serve as a reset provider. Hence, add reset controller
related code to the clock driver itself. To get resets properly ready for
the rest of the world we need to move platform driver initialization process
to 'arch_initcall'.

CC: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/clk-mt7621.c | 92 ++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ralink/clk-mt7621.c b/drivers/clk/ralink/clk-mt7621.c
index a2c045390f00..99256659dd96 100644
--- a/drivers/clk/ralink/clk-mt7621.c
+++ b/drivers/clk/ralink/clk-mt7621.c
@@ -11,14 +11,17 @@
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <dt-bindings/clock/mt7621-clk.h>
+#include <dt-bindings/reset/mt7621-reset.h>
 
 /* Configuration registers */
 #define SYSC_REG_SYSTEM_CONFIG0         0x10
 #define SYSC_REG_SYSTEM_CONFIG1         0x14
 #define SYSC_REG_CLKCFG0		0x2c
 #define SYSC_REG_CLKCFG1		0x30
+#define SYSC_REG_RESET_CTRL		0x34
 #define SYSC_REG_CUR_CLK_STS		0x44
 #define MEMC_REG_CPU_PLL		0x648
 
@@ -398,6 +401,82 @@ static void __init mt7621_clk_init(struct device_node *node)
 }
 CLK_OF_DECLARE_DRIVER(mt7621_clk, "mediatek,mt7621-sysc", mt7621_clk_init);
 
+struct mt7621_rst {
+	struct reset_controller_dev rcdev;
+	struct regmap *sysc;
+};
+
+static struct mt7621_rst *to_mt7621_rst(struct reset_controller_dev *dev)
+{
+	return container_of(dev, struct mt7621_rst, rcdev);
+}
+
+static int mt7621_assert_device(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct mt7621_rst *data = to_mt7621_rst(rcdev);
+	struct regmap *sysc = data->sysc;
+
+	return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), BIT(id));
+}
+
+static int mt7621_deassert_device(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct mt7621_rst *data = to_mt7621_rst(rcdev);
+	struct regmap *sysc = data->sysc;
+
+	return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), 0);
+}
+
+static int mt7621_reset_device(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	int ret;
+
+	ret = mt7621_assert_device(rcdev, id);
+	if (ret < 0)
+		return ret;
+
+	return mt7621_deassert_device(rcdev, id);
+}
+
+static int mt7621_rst_xlate(struct reset_controller_dev *rcdev,
+			    const struct of_phandle_args *reset_spec)
+{
+	unsigned long id = reset_spec->args[0];
+
+	if (id == MT7621_RST_SYS || id >= rcdev->nr_resets)
+		return -EINVAL;
+
+	return id;
+}
+
+static const struct reset_control_ops reset_ops = {
+	.reset = mt7621_reset_device,
+	.assert = mt7621_assert_device,
+	.deassert = mt7621_deassert_device
+};
+
+static int mt7621_reset_init(struct device *dev, struct regmap *sysc)
+{
+	struct mt7621_rst *rst_data;
+
+	rst_data = devm_kzalloc(dev, sizeof(*rst_data), GFP_KERNEL);
+	if (!rst_data)
+		return -ENOMEM;
+
+	rst_data->sysc = sysc;
+	rst_data->rcdev.ops = &reset_ops;
+	rst_data->rcdev.owner = THIS_MODULE;
+	rst_data->rcdev.nr_resets = 32;
+	rst_data->rcdev.of_reset_n_cells = 1;
+	rst_data->rcdev.of_xlate = mt7621_rst_xlate;
+	rst_data->rcdev.of_node = dev_of_node(dev);
+
+	return devm_reset_controller_register(dev, &rst_data->rcdev);
+}
+
 static int mt7621_clk_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -424,6 +503,12 @@ static int mt7621_clk_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = mt7621_reset_init(dev, priv->sysc);
+	if (ret) {
+		dev_err(dev, "Could not init reset controller\n");
+		return ret;
+	}
+
 	count = ARRAY_SIZE(mt7621_clks_base) +
 		ARRAY_SIZE(mt7621_fixed_clks) + ARRAY_SIZE(mt7621_gates);
 	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, count),
@@ -485,4 +570,9 @@ static struct platform_driver mt7621_clk_driver = {
 		.of_match_table = mt7621_clk_of_match,
 	},
 };
-builtin_platform_driver(mt7621_clk_driver);
+
+static int __init mt7621_clk_reset_init(void)
+{
+	return platform_driver_register(&mt7621_clk_driver);
+}
+arch_initcall(mt7621_clk_reset_init);
-- 
2.25.1

