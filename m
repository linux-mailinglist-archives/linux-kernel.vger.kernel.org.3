Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBE6588171
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiHBR6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiHBR6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:58:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C3150044
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:58:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n20-20020a05600c3b9400b003a4f2261a7eso240871wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UjGXyUyDLmjMDOf8jNJMvPEYFg/F977ZxHxgmhAvnmc=;
        b=Qh2sccOhKOymfr5Qop+pGzCH8T+687LGQLFRfVvoM3mFqaGCRJEm0wRxg98se49s0U
         N+wb1c9mjaL4yVirYDILB0P0YX4NPYi9DAHEV9Eg2iI0V0j1C/dHTMTtSmubquYBNiE7
         DDnG2uqIJDUgkqbyvgCoOMvk0rA64gM0k18LqPAeHBOB7RprdaxP2Dly/I1A27INmgug
         J9/3qEKHS2ciOpZsH7KiXSf/iiUZ3lvfArqouhz/x1xSOUF95ftI6SHX2sRSodB3Rnx4
         vh5gK7ye8THHoD7z30L9YwPyRms6IcJ/FeyrpKmOO3bf4EVLHbxK1WRpsFHzzyT/4nMi
         ezJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UjGXyUyDLmjMDOf8jNJMvPEYFg/F977ZxHxgmhAvnmc=;
        b=nsMIHt2I/i3O3cb4lfkNRbrENkS625IKQhPhlKUPdtlKZzunD2IwWSi9ubW+odX/Be
         oO6+wxDARsh6RgKzWe36MDjmfHfosvr96Slmt0QSIVlAo5puHnYP52Lgpkz8Fq+n3ztd
         WcHX1fWhaIRxshLrgKZbfRWNEhNU7Rctp5OJCE8UfYnWRoCHfo1VYIHisLPewO5CJsSa
         wyma4IwueQGzPND2zHaWvHOqp0XNTy3GizYyw5n+U04DNmuGjR/6PFt8Q3HCbG5CatdI
         MQCWIsMO5hZ9/bV6rJWKTAElkU4iCftXrZl2Al460PbFCwdhVIZMKPxufpdMixOvmiqq
         RkDQ==
X-Gm-Message-State: ACgBeo24Rixh2NhkMUhx4y08fN4nx6arIZhSGe6JrVml7c9sJ3XN9/r3
        gqhbPHxPLl/UEKJ+R1J8xqby3NYXTTbe1g==
X-Google-Smtp-Source: AA6agR4jqgI7Xs6iYK8jzlkHDKEuwOrDweCr7U8C/ikyOQNCqpvpyUePii/sxWpyirqjvlfe+oPfuA==
X-Received: by 2002:a05:600c:19d2:b0:3a3:2cdb:cc02 with SMTP id u18-20020a05600c19d200b003a32cdbcc02mr382332wmq.182.1659463117937;
        Tue, 02 Aug 2022 10:58:37 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:58:37 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH 03/11] spi: dw: define spi_frf for dual/quad/octal modes
Date:   Tue,  2 Aug 2022 18:57:47 +0100
Message-Id: <20220802175755.6530-4-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
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

The SPI mode needs to be mentioned in CTRLR0[23:22] register. Define a
configuration variable to keep the mode based on the buswidth, which will
then be used to update CR0. If the transfer is using dual/quad/octal
mode then mark enhanced_spi as true.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 29 +++++++++++++++++++++++++++++
 drivers/spi/spi-dw.h      |  7 +++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 77529e359b6d..8c84a2e991b5 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -333,6 +333,14 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 		/* CTRLR0[11:10] Transfer Mode */
 		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_TMOD_MASK, cfg->tmode);
 
+	if (dws->caps & DW_SPI_CAP_EXT_SPI) {
+		if (cfg->spi_frf)
+			cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,
+				cfg->spi_frf);
+		else
+			cr0 &= ~DW_HSSI_CTRLR0_SPI_FRF_MASK;
+	}
+
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
@@ -679,10 +687,31 @@ static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
 static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(mem->spi->controller);
+	bool enhanced_spi = false;
 	struct dw_spi_cfg cfg;
 	unsigned long flags;
 	int ret;
 
+	if (dws->caps & DW_SPI_CAP_EXT_SPI) {
+		switch (op->data.buswidth) {
+		case 2:
+			cfg.spi_frf = DW_SSI_CTRLR0_SPI_FRF_DUAL_SPI;
+			enhanced_spi = true;
+			break;
+		case 4:
+			cfg.spi_frf = DW_SSI_CTRLR0_SPI_FRF_QUAD_SPI;
+			enhanced_spi = true;
+			break;
+		case 8:
+			cfg.spi_frf = DW_SSI_CTRLR0_SPI_FRF_OCT_SPI;
+			enhanced_spi = true;
+			break;
+		default:
+			cfg.spi_frf = 0;
+			break;
+		}
+	}
+
 	/*
 	 * Collect the outbound data into a single buffer to speed the
 	 * transmission up at least on the initial stage.
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 71d18e9291a3..b8cc20e0deaa 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -96,6 +96,12 @@
 #define DW_HSSI_CTRLR0_SRL			BIT(13)
 #define DW_HSSI_CTRLR0_MST			BIT(31)
 
+/* Bit fields in CTRLR0 for enhanced SPI */
+#define DW_HSSI_CTRLR0_SPI_FRF_MASK		GENMASK(23, 22)
+#define DW_SSI_CTRLR0_SPI_FRF_DUAL_SPI		0x1
+#define DW_SSI_CTRLR0_SPI_FRF_QUAD_SPI		0x2
+#define DW_SSI_CTRLR0_SPI_FRF_OCT_SPI		0x3
+
 /* Bit fields in CTRLR1 */
 #define DW_SPI_NDF_MASK				GENMASK(15, 0)
 
@@ -136,6 +142,7 @@ struct dw_spi_cfg {
 	u8 dfs;
 	u32 ndf;
 	u32 freq;
+	u8 spi_frf;
 };
 
 struct dw_spi;
-- 
2.30.2

