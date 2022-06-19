Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4354A550C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiFSQuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 12:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiFSQuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:50:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617B63C5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s1so11655755wra.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2U26d1RUDN40F8pXZDx2og6vajjIrs72J5qYfLoOCUY=;
        b=a/KqKSDua/YhHcpIKxVc8N8J0GVZLdyKnxxK3no+G+TEd54zlxZbnLXf6+9OWzvsxq
         DOd0uguBWie7LqV06kD7ZewrXbZPCniZgbyif/L35ANFqGvpRp3UwzXxwM1ScFl1R0+R
         28pxiiOS0ZDKMTZk0Qk2yfnP6ng/hJ5fwURg02GE+LwyOBgbhADUjLuaQv4os/xaHTBT
         IFzNk/9XQwZJ/2Tno4ftGaxnf95/ShVfH4KNIDRQFq9WF/zVnQWNH1uLrncHDmAmS3CZ
         91gn5GRHKWbHzpo6+ol9JmDwsRhcIqpRtwZLgaOyidCrvd9kWy3GZFXCjX0xopx+CIeq
         CzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2U26d1RUDN40F8pXZDx2og6vajjIrs72J5qYfLoOCUY=;
        b=IO3mHHWEQvaI3NHxIxmDPOycLv+KggaEozmKtmtDWnxoIhT6qJxbqEVng0cpf/7Wk9
         PhWYbFPcAe/W2weMBKZxNpQHVNWxesI7/EMATk2wIld7kuPKpjH9Mc+Yt3M3XfqjR2CV
         0BAtHFlZ7RXV2Oz1wtUeZw5IP8dLCHvMQiXqX6P2iobUh91kerTbKS2vDSyD7DUYbnQz
         CziFNYFZr5C4eqvbc23xjM0luyLBWxE5GtBHdUVvw3SFa0p11NKJ4fY+RuRJ1YzOVhXF
         GQ/2MXvnhw0FkZDShLvjdqMRffhIgzwWhR3EdgkE09jAwI6aFjwZlUvO9lv8XVSjCOkp
         ILnQ==
X-Gm-Message-State: AJIora8/Imx3015Ao2vjZx7dXnzMNJyaJtBypdBzRleLmOeKoT6A0n5E
        j45Q/y7V1+UgRYtVVLzUMcy88w==
X-Google-Smtp-Source: AGRyM1u2F06uLF9I1C9pTm9cF8MTa7GrTptuqR0ZCQFATDOGJcdnLqgdR8SoNllm822PnnzCYlk8BA==
X-Received: by 2002:adf:de8d:0:b0:21a:23e0:6881 with SMTP id w13-20020adfde8d000000b0021a23e06881mr18743406wrl.291.1655657420799;
        Sun, 19 Jun 2022 09:50:20 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id m14-20020adfdc4e000000b0021a3c960214sm9189510wrj.6.2022.06.19.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 09:50:20 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC 3/6] clk: microchip: mpfs: add reset controller
Date:   Sun, 19 Jun 2022 17:49:33 +0100
Message-Id: <20220619164935.1492823-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619164935.1492823-1-mail@conchuod.ie>
References: <20220619164935.1492823-1-mail@conchuod.ie>
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

From: Conor Dooley <conor.dooley@microchip.com>

Add a reset controller to PolarFire SoC's clock driver. This reset
controller is registered as an aux device and read/write functions
exported to the drivers namespace so that the reset controller can
access the peripheral device reset register.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/Kconfig    |   1 +
 drivers/clk/microchip/clk-mpfs.c | 118 ++++++++++++++++++++++++++++---
 include/soc/microchip/mpfs.h     |   8 +++
 3 files changed, 116 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kconfig
index a5a99873c4f5..b46e864b3bd8 100644
--- a/drivers/clk/microchip/Kconfig
+++ b/drivers/clk/microchip/Kconfig
@@ -6,5 +6,6 @@ config COMMON_CLK_PIC32
 config MCHP_CLK_MPFS
 	bool "Clk driver for PolarFire SoC"
 	depends on (RISCV && SOC_MICROCHIP_POLARFIRE) || COMPILE_TEST
+	select AUXILIARY_BUS
 	help
 	  Supports Clock Configuration for PolarFire SoC
diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 070c3b896559..19a9f8cd12ff 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -3,12 +3,15 @@
  * Daire McNamara,<daire.mcnamara@microchip.com>
  * Copyright (C) 2020 Microchip Technology Inc.  All rights reserved.
  */
+#include "linux/device.h"
+#include <linux/auxiliary_bus.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <dt-bindings/clock/microchip,mpfs-clock.h>
+#include <soc/microchip/mpfs.h>
 
 /* address offset of control registers */
 #define REG_MSSPLL_REF_CR	0x08u
@@ -28,6 +31,7 @@
 #define MSSPLL_FIXED_DIV	4u
 
 struct mpfs_clock_data {
+	struct device *dev;
 	void __iomem *base;
 	void __iomem *msspll_base;
 	struct clk_hw_onecell_data hw_data;
@@ -302,10 +306,6 @@ static int mpfs_periph_clk_enable(struct clk_hw *hw)
 
 	spin_lock_irqsave(&mpfs_clk_lock, flags);
 
-	reg = readl_relaxed(base_addr + REG_SUBBLK_RESET_CR);
-	val = reg & ~(1u << periph->shift);
-	writel_relaxed(val, base_addr + REG_SUBBLK_RESET_CR);
-
 	reg = readl_relaxed(base_addr + REG_SUBBLK_CLOCK_CR);
 	val = reg | (1u << periph->shift);
 	writel_relaxed(val, base_addr + REG_SUBBLK_CLOCK_CR);
@@ -339,12 +339,9 @@ static int mpfs_periph_clk_is_enabled(struct clk_hw *hw)
 	void __iomem *base_addr = periph_hw->sys_base;
 	u32 reg;
 
-	reg = readl_relaxed(base_addr + REG_SUBBLK_RESET_CR);
-	if ((reg & (1u << periph->shift)) == 0u) {
-		reg = readl_relaxed(base_addr + REG_SUBBLK_CLOCK_CR);
-		if (reg & (1u << periph->shift))
-			return 1;
-	}
+	reg = readl_relaxed(base_addr + REG_SUBBLK_CLOCK_CR);
+	if (reg & (1u << periph->shift))
+		return 1;
 
 	return 0;
 }
@@ -438,6 +435,99 @@ static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_c
 	return 0;
 }
 
+/*
+ * Peripheral clock resets
+ */
+
+#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
+
+u32 mpfs_reset_read(struct device *dev)
+{
+	struct mpfs_clock_data *clock_data = dev_get_drvdata(dev->parent);
+
+	return readl_relaxed(clock_data->base + REG_SUBBLK_RESET_CR);
+}
+EXPORT_SYMBOL_NS_GPL(mpfs_reset_read, MCHP_CLK_MPFS);
+
+void mpfs_reset_write(struct device *dev, u32 val)
+{
+	struct mpfs_clock_data *clock_data = dev_get_drvdata(dev->parent);
+
+	writel_relaxed(val, clock_data->base + REG_SUBBLK_RESET_CR);
+}
+EXPORT_SYMBOL_NS_GPL(mpfs_reset_write, MCHP_CLK_MPFS);
+
+static void mpfs_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+}
+
+static void mpfs_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	auxiliary_device_uninit(adev);
+
+	kfree(adev->name);
+	kfree(adev);
+}
+
+static struct auxiliary_device *mpfs_reset_adev_alloc(struct mpfs_clock_data *clk_data)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return ERR_PTR(-ENOMEM);
+
+	adev->name = "reset-mpfs";
+	adev->dev.parent = clk_data->dev;
+	adev->dev.release = mpfs_reset_adev_release;
+	adev->id = 666u;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(adev);
+		return ERR_PTR(ret);
+	}
+
+	return adev;
+}
+
+static int mpfs_reset_controller_register(struct mpfs_clock_data *clk_data)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = mpfs_reset_adev_alloc(clk_data);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(clk_data->dev, mpfs_reset_unregister_adev, adev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+#else /* !CONFIG_RESET_CONTROLLER */
+
+static int mpfs_reset_controller_register(struct mpfs_clock_data *clk_data)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_RESET_CONTROLLER */
+
 static int mpfs_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -462,6 +552,8 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(clk_data->msspll_base);
 
 	clk_data->hw_data.num = num_clks;
+	clk_data->dev = dev;
+	dev_set_drvdata(dev, clk_data);
 
 	ret = mpfs_clk_register_mssplls(dev, mpfs_msspll_clks, ARRAY_SIZE(mpfs_msspll_clks),
 					clk_data);
@@ -481,6 +573,10 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = mpfs_reset_controller_register(clk_data);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
@@ -488,7 +584,7 @@ static const struct of_device_id mpfs_clk_of_match_table[] = {
 	{ .compatible = "microchip,mpfs-clkcfg", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, mpfs_clk_match_table);
+MODULE_DEVICE_TABLE(of, mpfs_clk_of_match_table);
 
 static struct platform_driver mpfs_clk_driver = {
 	.probe = mpfs_clk_probe,
diff --git a/include/soc/microchip/mpfs.h b/include/soc/microchip/mpfs.h
index 6466515262bd..f916dcde457f 100644
--- a/include/soc/microchip/mpfs.h
+++ b/include/soc/microchip/mpfs.h
@@ -40,4 +40,12 @@ struct mpfs_sys_controller *mpfs_sys_controller_get(struct device *dev);
 
 #endif /* if IS_ENABLED(CONFIG_POLARFIRE_SOC_SYS_CTRL) */
 
+#if IS_ENABLED(CONFIG_MCHP_CLK_MPFS)
+
+u32 mpfs_reset_read(struct device *dev);
+
+void mpfs_reset_write(struct device *dev, u32 val);
+
+#endif /* if IS_ENABLED(CONFIG_MCHP_CLK_MPFS) */
+
 #endif /* __SOC_MPFS_H__ */
-- 
2.36.1

