Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB946489711
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbiAJLLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244449AbiAJLKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:10:44 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12411C06173F;
        Mon, 10 Jan 2022 03:10:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id x4so851453wru.7;
        Mon, 10 Jan 2022 03:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ICLpvIKc6Y/daWQpRiyo0jffnPkaJB8CpiTYNoD1sk=;
        b=hmaVuoel0i48fMrYMjoukOnx0rmHDSsZr3ZfN8NpjTpceUFxKS1f6uO/570VySWYGp
         n7OEQmZKkYIVbKWQmbs4gSBf5d1SVGxlpHj6m2gphbvGCLnu9+Z4lTo5bSrKtxd8Nxhe
         ygploc+4djnPTcifUfo8oSEoQMhSEE6OH562BF4fBUjjJyfic1lGbKZPUDEHB2XVXxqp
         wmPxlA37ZpWiIHX7rxQtTVSm/ie6m4mYWXkA9nmJcsuOr7BwfwVEKyjWk5+JFluGLJe7
         7tLD4Ki+sP9SFDjIX9xVviKCwV54aAGrFKyaIYd8zBdFd92nM7Bm8BdiQ6T/zpUOGI2Y
         YsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ICLpvIKc6Y/daWQpRiyo0jffnPkaJB8CpiTYNoD1sk=;
        b=M9rRT0SBomYdhxVd6PiP5dnVr7n1ZQY/dUl88Q+jwPQjf2CRMNKFF74tABqCYdZsOv
         WHWMa6dDObW/7qB4S8EjgYCXaqbM3D0i1NpJojqOR5GxKaVmyLTURUFVqw/g6+XDSA6p
         qZYkAqa0IAV3Q0aF2vZr8XXnRYa6dsWk89EK+GaLk1VHaLRU7C+PvObnHLOf/GAho6Hq
         JnIyhLhsy5MdYTYpD6PBq22J3RwY5q140ndhzz1/umDE8X4twGhSbWdSEOmHhZ4O3OAH
         vHBZJtnVY4gFCWXOpCs1RDpyLH4qXxgD0YB5YV80g7eDBNKuoMdh7g4ARI5wPpVP10rt
         RHoQ==
X-Gm-Message-State: AOAM531EtCBHWRdKVtdviBT76+6DVIb12PogBtreRAhyKlb8d/SRZKmr
        jKdynqan7QcGImxAXwU/DFYZFks8XsB4/Q==
X-Google-Smtp-Source: ABdhPJy+XL48SiTYf3Hj0SWhysnGZ5qzWV1JknCWr7TscmkiSjwTRq8/F01apZqfJOFoLqBYWbsv8w==
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr64121032wry.406.1641813042437;
        Mon, 10 Jan 2022 03:10:42 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id x8sm6256733wmj.44.2022.01.10.03.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:10:42 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Subject: [PATCH v7 3/4] clk: ralink: make system controller node a reset provider
Date:   Mon, 10 Jan 2022 12:10:35 +0100
Message-Id: <20220110111036.1380288-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
References: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7621 system controller node is already providing the clocks for the whole
system but must also serve as a reset provider. Hence, add reset controller
related code to the clock driver itself. To get resets properly ready for
the rest of the world we need to move platform driver initialization process
to 'arch_initcall'.

CC: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/clk-mt7621.c | 92 ++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ralink/clk-mt7621.c b/drivers/clk/ralink/clk-mt7621.c
index a2c045390f00..7ed121574bad 100644
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
+	if (id == MT7621_RST_SYS)
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

