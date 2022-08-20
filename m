Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF359B022
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiHTT7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiHTT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:59:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72773E749
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so7842780pjl.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=JiyrU7bw57u1rFni+wiLP4qKYiNoNSNHOlgru8EmCkI=;
        b=QX1FYycbL51RjFebGUKzoBma/PYZmlsThnbTYCjK+3h1NdEC76WbSo9EkatI8QntbP
         udLp/6tZWmyKBSvBzhTPEY6CbmHnHW83+fBYWBM+Rm1ILyVEYRRigcZBKjmhQGfdtIUb
         DziU0cjzpvTWm8yOiicqn5QmCABKnocag/XzVPrR3maPJVWZT5rifaFOf7em7z5WWPiU
         cX0/IDQyjB27T1jaaLxKuZfkpn6hLKoReHcCr0ab2u3p/0AZW7hapcDIyBJsLfh6p0si
         uvo5gTk88IbrrGP+5ujrVZ309Xyu/+8b8ezcb9v8AKN+UUMtufwi1i+yk1btV8iKzxuq
         TBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=JiyrU7bw57u1rFni+wiLP4qKYiNoNSNHOlgru8EmCkI=;
        b=ILXAaaoz8Z/g8ebF2S6hWrRid1SSNqheCk8Ech3gwtbyMy3mxRazM9OlVVUJhS/nOJ
         +yOzf6ovX/CxU6t/Z/1KVwjnK2g9GBThCEw07AY10d1MYoWxuwRUNIyAVXnz+NpcsqLa
         H/iSd4OttdwGn+Cq6CQqW/LpjgYsoYAz9QD5aYSBbe5YUNnYgvxwS9AWzKVi3CGRXvar
         pfrZPgFhK7lzQS1uOzvA0q7zadLqQG0hjc7177t9wUg3qRN8lMbKXHWN0hQrOfVKKQD6
         /a567t5QL8mHZJOMpwpdYfsvOmp8YhIYUsyeOLsXnFl0TbcvZHg3cE3K/xuhiFV9j5Zs
         DPXQ==
X-Gm-Message-State: ACgBeo0KsmA/ffIbAaF6zB2R6zXuaY88Ylozwe3YpvnI8+dN7GaY9noJ
        f3V5l+w4gtiBY5oFl6AgeKkQSw==
X-Google-Smtp-Source: AA6agR5uejzjoQx30vBRh6AOoe/m8stB9Mk2E3iWTR6qTazTDGAk1s1vfJmlH6QzD+7dm5tJ+7/A0Q==
X-Received: by 2002:a17:90b:350a:b0:1f5:6a5e:5d12 with SMTP id ls10-20020a17090b350a00b001f56a5e5d12mr20917220pjb.46.1661025535087;
        Sat, 20 Aug 2022 12:58:55 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:54 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 16/17] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
Date:   Sat, 20 Aug 2022 12:57:49 -0700
Message-Id: <20220820195750.70861-17-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add support for AMD Pensando Elba SoC which explicitly
controls byte-lane enables on writes.

Select MMC_SDHCI_IO_ACCESSORS for MMC_SDHCI_CADENCE which
allows Elba SoC sdhci_elba_ops to overwrite the SDHCI
IO memory accessors.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 drivers/mmc/host/Kconfig         |   1 +
 drivers/mmc/host/sdhci-cadence.c | 132 ++++++++++++++++++++++++++++---
 2 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 10c563999d3d..9af316d5bca4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -244,6 +244,7 @@ config MMC_SDHCI_CADENCE
 	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Cadence SD/SDIO/eMMC driver.
 
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 708d4297f241..c662c63d49fa 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -66,6 +66,8 @@ struct sdhci_cdns_phy_param {
 
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
+	void __iomem *ctl_addr;	/* write control */
+	spinlock_t wrlock;	/* write lock */
 	bool enhanced_strobe;
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
 	unsigned int nr_phy_params;
@@ -77,6 +79,11 @@ struct sdhci_cdns_phy_cfg {
 	u8 addr;
 };
 
+struct sdhci_cdns_drv_data {
+	int (*init)(struct platform_device *pdev);
+	const struct sdhci_pltfm_data pltfm_data;
+};
+
 static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
 	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
@@ -316,6 +323,92 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 		sdhci_set_uhs_signaling(host, timing);
 }
 
+/* Elba control register bits [6:3] are byte-lane enables */
+#define ELBA_BYTE_ENABLE_MASK(x)	((x) << 3)
+
+/*
+ * The Pensando Elba SoC explicitly controls byte-lane enabling on writes
+ * which includes writes to the HRS registers.
+ */
+static void elba_priv_writel(struct sdhci_cdns_priv *priv, u32 val,
+			     void __iomem *reg)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);
+	writel(val, reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
+{
+	elba_priv_writel(sdhci_cdns_priv(host), val, host->ioaddr + reg);
+}
+
+static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	u32 byte_enables;
+	unsigned long flags;
+
+	byte_enables = GENMASK(1, 0) << (reg & 0x3);
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
+	writew(val, host->ioaddr + reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	u32 byte_enables;
+	unsigned long flags;
+
+	byte_enables = BIT(0) << (reg & 0x3);
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
+	writeb(val, host->ioaddr + reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static const struct sdhci_ops sdhci_elba_ops = {
+	.write_l = elba_write_l,
+	.write_w = elba_write_w,
+	.write_b = elba_write_b,
+	.set_clock = sdhci_set_clock,
+	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
+};
+
+static int elba_drv_init(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct resource *iomem;
+	void __iomem *ioaddr;
+
+	host->mmc->caps |= (MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA);
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!iomem)
+		return -ENOMEM;
+
+	/* Byte-lane control register */
+	ioaddr = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(ioaddr))
+		return PTR_ERR(ioaddr);
+
+	priv->ctl_addr = ioaddr;
+	priv->priv_writel = elba_priv_writel;
+	spin_lock_init(&priv->wrlock);
+	writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);
+
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
@@ -325,13 +418,24 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
 };
 
-static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns_ops,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
+};
+
+static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
+	.init = elba_drv_init,
+	.pltfm_data = {
+		.ops = &sdhci_elba_ops,
+	},
 };
 
-static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
+static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns_ops,
+	},
 };
 
 static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
@@ -357,7 +461,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
-	const struct sdhci_pltfm_data *data;
+	const struct sdhci_cdns_drv_data *data;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
@@ -376,10 +480,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	if (!data)
-		data = &sdhci_cdns_pltfm_data;
+		data = &sdhci_cdns_drv_data;
 
 	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
-	host = sdhci_pltfm_init(pdev, data,
+	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
 				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
@@ -388,7 +492,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->clk = clk;
-
 	priv = sdhci_pltfm_priv(pltfm_host);
 	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
@@ -397,6 +500,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
+	if (data->init) {
+		ret = data->init(pdev);
+		if (ret)
+			goto free;
+	}
 	sdhci_enable_v4_mode(host);
 	__sdhci_read_caps(host, &version, NULL, NULL);
 
@@ -461,7 +569,11 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
 static const struct of_device_id sdhci_cdns_match[] = {
 	{
 		.compatible = "socionext,uniphier-sd4hc",
-		.data = &sdhci_cdns_uniphier_pltfm_data,
+		.data = &sdhci_cdns_uniphier_drv_data,
+	},
+	{
+		.compatible = "amd,pensando-elba-sd4hc",
+		.data = &sdhci_elba_drv_data,
 	},
 	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
-- 
2.17.1

