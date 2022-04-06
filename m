Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AD34F6EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbiDFXjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiDFXjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:39:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4301FD54C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:37:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r66so3506106pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cuQ6cH3FdjOcaRdutCDBUNNLdP9J4Yf1fCyH25zHJ5U=;
        b=Pw4R6CmXeAQbDYwcKkLrvbhWq2wGyV/2j7AMDLKCoHmRgmyVLk20QRkc8+1nRqHS9O
         Kgj1xtsHL9nWlp2aoJ5V4b8LDpPyYx7kMOQ9SmV0b3dUry7aFCYiStUctv7NON0w7wsR
         +e+fLg5VL2Toi1O5U3ckFc0oqaSZIr7MiOEHTMk1ZPlwAD+b9fBRRjfWiMA+383XCPNr
         WJCQihkbMNG+d5R88kzkWqIzpiFIeEWcHz/BaUocsfQubgOXItG76F3/puXiIR+MR8hZ
         x7MUSkt9i++cKTxtefYDFedKJ6qntwXpcXFMPsz/lGOkKXDN1u7gfNJ42F8ZQ9Li6T5w
         4vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cuQ6cH3FdjOcaRdutCDBUNNLdP9J4Yf1fCyH25zHJ5U=;
        b=wQYOvGWSnq4rpIj7L8X/o8dAnp76wubLRkOJhTtQAqk3RDojV4T6rkVVXMBmuTrX2Y
         UHzkhobIKRmUXjVn3iFBHbYpHPF2ryIsA7xy7N/6Xft5ksqg3VnJ3ecP+wqmglbFyTYJ
         yfmurYg5fNyq7rOJH3ED/iiejOCJU8CiJA1rePNjYJHLMnvv5J3Eww0ZTFyfC/LrX5U4
         MbsTmJySMjlYfGIcA9jPCb8/fvhWADMuZwdVFARxvrZB0Ecl72pffWKkcF+DVlCPbXpq
         D5Thx4STfgKzY4FaZKiup0Aaqqvy7vMm/kITYLPGQa2Hb3YoZcwlTprDx5J47v7UY7lS
         d/OA==
X-Gm-Message-State: AOAM530G1sjEi34dVgqnMsGt+N02K/y+YNwwvu/OJNfy1oU0IaVn2mBw
        N7zNeH2G5/aVgZvgRwJc1ATSjQ==
X-Google-Smtp-Source: ABdhPJy+4usAsbPkyt2T8ZHoj3676HFJTS97qdVKEELrRKQTTFRorrj/mWwzzm15tkPPFCTuPSUmbA==
X-Received: by 2002:a05:6a00:b4a:b0:4fa:ecee:6eb2 with SMTP id p10-20020a056a000b4a00b004faecee6eb2mr11334618pfo.22.1649288242082;
        Wed, 06 Apr 2022 16:37:22 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:21 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] spi: dw: Add support for Pensando Elba SoC
Date:   Wed,  6 Apr 2022 16:36:47 -0700
Message-Id: <20220406233648.21644-11-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406233648.21644-1-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pensando Elba SoC includes a DW apb_ssi v4 controller
with device specific chip-select control.  The Elba SoC
provides four chip-selects where the native DW IP supports
two chip-selects.  The Elba DW_SPI instance has two native
CS signals that are always overridden.

Signed-off-by: Brad Larson <brad@pensando.io>
---
Change from V3:
- Use more descriptive dt property pensando,syscon-spics
- Minor changes from review input

 drivers/spi/spi-dw-mmio.c | 85 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 5101c4c6017b..f4636b271818 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -53,6 +53,24 @@ struct dw_spi_mscc {
 	void __iomem        *spi_mst; /* Not sparx5 */
 };
 
+struct dw_spi_elba {
+	struct regmap *regmap;
+	unsigned int reg;
+};
+
+/*
+ * Elba SoC does not use ssi, pin override is used for cs 0,1 and
+ * gpios for cs 2,3 as defined in the device tree.
+ *
+ * cs:  |       1               0
+ * bit: |---3-------2-------1-------0
+ *      |  cs1   cs1_ovr   cs0   cs0_ovr
+ */
+#define ELBA_SPICS_SHIFT(cs)		(2 * (cs))
+#define ELBA_SPICS_MASK(cs)		(0x3 << ELBA_SPICS_SHIFT(cs))
+#define ELBA_SPICS_SET(cs, val)	\
+			((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(cs))
+
 /*
  * The Designware SPI controller (referred to as master in the documentation)
  * automatically deasserts chip select when the tx fifo is empty. The chip
@@ -238,6 +256,72 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
 	return 0;
 }
 
+static void elba_spics_set_cs(struct dw_spi_elba *dwselba, int cs, int enable)
+{
+	regmap_update_bits(dwselba->regmap, dwselba->reg, ELBA_SPICS_MASK(cs),
+			   ELBA_SPICS_SET(cs, enable));
+}
+
+static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+	struct dw_spi_elba *dwselba = dwsmmio->priv;
+	u8 cs;
+
+	cs = spi->chip_select;
+	if (cs < 2) {
+		/* overridden native chip-select */
+		elba_spics_set_cs(dwselba, spi->chip_select, enable);
+	}
+
+	/*
+	 * The DW SPI controller needs a native CS bit selected to start
+	 * the serial engine and the platform may have fewer native CSs
+	 * than needed, so use CS0 always.
+	 */
+	spi->chip_select = 0;
+	dw_spi_set_cs(spi, enable);
+	spi->chip_select = cs;
+}
+
+static int dw_spi_elba_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
+{
+	struct of_phandle_args args;
+	struct dw_spi_elba *dwselba;
+	struct regmap *regmap;
+	int rc;
+
+	rc = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+			"pensando,syscon-spics", 1, 0, &args);
+	if (rc) {
+		dev_err(&pdev->dev, "could not find spics\n");
+		return rc;
+	}
+
+	regmap = syscon_node_to_regmap(args.np);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
+				     "could not map spics");
+
+	dwselba = devm_kzalloc(&pdev->dev, sizeof(*dwselba), GFP_KERNEL);
+	if (!dwselba)
+		return -ENOMEM;
+
+	dwselba->regmap = regmap;
+	dwselba->reg = args.args[0];
+
+	/* deassert cs */
+	elba_spics_set_cs(dwselba, 0, 1);
+	elba_spics_set_cs(dwselba, 1, 1);
+
+	dwsmmio->priv = dwselba;
+	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -352,6 +436,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+	{ .compatible = "pensando,elba-spi", .data = dw_spi_elba_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.17.1

