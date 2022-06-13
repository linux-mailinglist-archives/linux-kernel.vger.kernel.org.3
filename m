Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4457A54A008
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbiFMUrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242348AbiFMUqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:46:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563411C23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so9818420pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ctYV5CtpweQWwhemRH689WvsToB4VjKXh88G2Mf0xQ=;
        b=KU4bwCyM432Sc7bUoksU95EBphe6ApddgD25OxO1uN7LgceYRVOSvwXLw2SxXYpDIn
         TCv9dD+ytgIhPrt1yUCgwwurS5WM5wy14NAeS5J71F83Blm3Y5S+kDuihn2JaYme1jug
         fSRv+qTWMz3yb6wcvxPz/UBxpUT/kpU4ScKYp1PARfEHAt6khFEBxavh/nXHM/slPzxk
         a4rYIjwN3vk+y328sZiAfBxb5ILwNpASm7Ssx0lQ9q2MxteA08/8G2ipKk91524cU4IL
         EI4kfJ6z2ANrjVhx6PKo0hed6/EEZcGkxE88A514wqlU9PRsciL0rY6her3vWu+e/rIK
         DTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ctYV5CtpweQWwhemRH689WvsToB4VjKXh88G2Mf0xQ=;
        b=LoMSR3FJMn4qmwTiUs9XTQlIFBM+GieE4Lvu6whZovKpoGP8QVs4WaJ4kEpbQw3ygY
         SsfJKaIxdYl3hmr63D3Nka0MfWWTBBlbgIEbZusXdzR9yP3aWJ9ybeEj/t4I+XC56/XU
         8O325hasStYFKMahadtL7vpKVP+IpiizvXeJpryidehbUW3Z5PpS4jon9I9sCtIYrKEb
         Xk2TuiUxwKibW0SrfTg8vzYSYd4gg7LuK5o9W3FxPeWDZlgp7fSAj0e1tkkcTAHvuVN9
         HXA/Spi4P7RZbThYilbES7js5Qox/HgwOl3tHO7whZXN6jj5q5lHeOEMS8I4Vcsdorsp
         g5sg==
X-Gm-Message-State: AJIora/mcRDSn5ED+ImoywZAfGeAjmwRXxJrL54ZMF3UBqcYDnu2lACy
        IBvEuwujp5IvaHXeLk7OXr2wLg==
X-Google-Smtp-Source: AGRyM1srdQbNwx41tXUnvYf3A9njwwFcL6cYLU2K1BmNaGiywHkukGrpzW0Jj2DIkNtoJHT5mf0eaQ==
X-Received: by 2002:a17:902:eccc:b0:167:5c6e:31e4 with SMTP id a12-20020a170902eccc00b001675c6e31e4mr753614plh.90.1655150265894;
        Mon, 13 Jun 2022 12:57:45 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:45 -0700 (PDT)
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
Subject: [PATCH v5 11/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
Date:   Mon, 13 Jun 2022 12:56:54 -0700
Message-Id: <20220613195658.5607-12-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

The AMD Pensando Elba SoC has the Cadence QSPI controller integrated.

The quirk CQSPI_NEEDS_APB_AHB_HAZARD_WAR is added and if enabled
a dummy readback from the controller is performed to ensure
synchronization.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 drivers/spi/spi-cadence-quadspi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 72b1a5a2298c..ebb77ea8e6ba 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -39,6 +39,7 @@
 #define CQSPI_DISABLE_DAC_MODE		BIT(1)
 #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(4)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -87,6 +88,7 @@ struct cqspi_st {
 	bool			use_dma_read;
 	u32			pd_dev_id;
 	bool			wr_completion;
+	bool			apb_ahb_hazard;
 };
 
 struct cqspi_driver_platdata {
@@ -952,6 +954,13 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->wr_delay)
 		ndelay(cqspi->wr_delay);
 
+	/*
+	 * If a hazard exists between the APB and AHB interfaces, perform a
+	 * dummy readback from the controller to ensure synchronization.
+	 */
+	if (cqspi->apb_ahb_hazard)
+		(void)readl(reg_base + CQSPI_REG_INDIRECTWR);
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1667,6 +1676,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->use_dma_read = true;
 		if (ddata->quirks & CQSPI_NO_SUPPORT_WR_COMPLETION)
 			cqspi->wr_completion = false;
+		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
+			cqspi->apb_ahb_hazard = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0"))
@@ -1789,6 +1800,10 @@ static const struct cqspi_driver_platdata versal_ospi = {
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
 
+static const struct cqspi_driver_platdata pen_cdns_qspi = {
+	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1814,6 +1829,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "intel,socfpga-qspi",
 		.data = &socfpga_qspi,
 	},
+	{
+		.compatible = "amd,pensando-elba-qspi",
+		.data = &pen_cdns_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.17.1

