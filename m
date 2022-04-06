Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A84F6ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbiDFXkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiDFXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:39:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEF5200359
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:37:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c2so3474137pga.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NHPrcfPX9j18H1X5A7gd0jrJ/hWGlXT1F/HI7wEXaE=;
        b=4Kw/aPfSNYshRbULidJg3mB/KOVPMiK0GCp5wH59VS/zYWvSwjEnXicMwj1WCeSWsl
         ffOVt81BMhOVDBedkEVUwIt96Q5O1IfLGGiBPoWxdTocmpqrvbhuOGg/lJjDx/TPtfDt
         tX0fbkYLBZN8v7/ZnmjjgYrZhc/Sg1kz4+JGb3v2ZmUz3DMLZAi1OiZxMucAzcIMYeOM
         RzyVlUG7tkOhpbK3Iee3tmClVejUMAp9Hp4gKWynCvgz/wbZ/gE89L+l26v/wFdsHezn
         0DEQFDaANZ04J4sBJUs6nUPand5rN70bCF3EWnGbe1JIMI3JCm+n6fLRR95Zqwm5cOtT
         J1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NHPrcfPX9j18H1X5A7gd0jrJ/hWGlXT1F/HI7wEXaE=;
        b=qm95bwS/PGqgdLQuzDzlqHlT6/KgZ+ar+C0Xz5/kRsE3Jlvdl7jEzTHbUqTqidE3kP
         eslUFh/qzrzP6wafAduUz5pCKXE+gFhMhSuDOVw+K9oqORyL6JPKTG8A0+gr9l+5krN0
         hh9yb+04x3klnHFsWj00xd8lUTy2EcorAB0DZIfygbnVBxQ0xLrfi2ciFBTAOyZy1iRl
         FeW2YIRC+cewn5xokeWm0Vk2fzz4ceO9bdSb58rn/fLZrAUIjQnILzm5WIrsnGoVyu42
         tsfwa0db2ncJm9Kk0by+qkcN519EPbFsWpYnMpQZwZ42s/Er3AxC+/6T3UfLlIbOwQTQ
         gWBQ==
X-Gm-Message-State: AOAM531oPE65XU8gzwttFR8o51UgNxeNfIA1iF5MtbtWWCndSNVNSUqJ
        GGFKhX2Oy0+VrwPsUUkViXPGJQ==
X-Google-Smtp-Source: ABdhPJyHjfczh9XOpxfDw4qG22iuv5BhD30drlpa3BlIyG2rSgrDCkxionp7n+48w9BDXCt6rELPcg==
X-Received: by 2002:a05:6a00:884:b0:4fe:134d:81cc with SMTP id q4-20020a056a00088400b004fe134d81ccmr11250729pfj.57.1649288238812;
        Wed, 06 Apr 2022 16:37:18 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:18 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] spi: cadence-quadspi: Add compatible for Pensando Elba SoC
Date:   Wed,  6 Apr 2022 16:36:45 -0700
Message-Id: <20220406233648.21644-9-brad@pensando.io>
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

The Pensando Elba SoC has the Cadence QSPI controller integrated.

The quirk CQSPI_NEEDS_APB_AHB_HAZARD_WAR is added and if enabled
a dummy readback from the controller is performed to ensure
synchronization.

Signed-off-by: Brad Larson <brad@pensando.io>
---
Change from V3:
- Update due to spi-cadence-quadspi.c changes

 drivers/spi/spi-cadence-quadspi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b0c9f62ccefb..e7bcd9d8ba37 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -38,6 +38,7 @@
 #define CQSPI_DISABLE_DAC_MODE		BIT(1)
 #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(4)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -88,6 +89,7 @@ struct cqspi_st {
 	bool			use_dma_read;
 	u32			pd_dev_id;
 	bool			wr_completion;
+	bool			apb_ahb_hazard;
 };
 
 struct cqspi_driver_platdata {
@@ -1043,6 +1045,13 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
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
 
@@ -1759,6 +1768,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->use_dma_read = true;
 		if (ddata->quirks & CQSPI_NO_SUPPORT_WR_COMPLETION)
 			cqspi->wr_completion = false;
+		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
+			cqspi->apb_ahb_hazard = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0"))
@@ -1882,6 +1893,10 @@ static const struct cqspi_driver_platdata versal_ospi = {
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
 
+static const struct cqspi_driver_platdata pen_cdns_qspi = {
+	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1907,6 +1922,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "intel,socfpga-qspi",
 		.data = (void *)&socfpga_qspi,
 	},
+	{
+		.compatible = "pensando,elba-qspi",
+		.data = &pen_cdns_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.17.1

