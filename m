Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3F4572C93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiGME3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiGME3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:29:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3080C2A9;
        Tue, 12 Jul 2022 21:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657686538; x=1689222538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NoB13u4fK3Q3uVQDxAOnHpTJ7tm+CsyAuJJu2/m52q4=;
  b=dcuAMsXd37tlk+gEz/FaYDgKVSeF6n4/szxOoJonJPjgzr5iSlQDgD91
   bSy3DajDv0WOKFvI0GYFtDeon/4lE4UGkGPhpk0tfgPqVESBXtwYaASgP
   MlMpl0mQAqLL8qZKBPfZ9vEryG1Sq2/6Iul+qpawJcupxx6KP14XNsP2P
   68YmTnQSAKADmYI9m82iWm82iI2NAWCr5WIIEzx/+HmSuCR0Tt7ipWbzl
   JQ5xptNkcj1+F8RAB+PfNrL4Psp/VSDypNd1c/APQvQrgAH7eK2m12XXt
   xEXTNooiC5cBbLlPRVJUUjO8HlxjdLkPsGrcjkDt1oaO9YRiv8ph4WEmb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="264894399"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="264894399"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 21:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570463292"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2022 21:28:54 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v6 4/4] spi: dw: Add support for Intel Thunder Bay SPI controller
Date:   Wed, 13 Jul 2022 12:22:23 +0800
Message-Id: <20220713042223.1458-5-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713042223.1458-1-nandhini.srikandan@intel.com>
References: <20220713042223.1458-1-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add support for Intel Thunder Bay SPI controller, which uses DesignWare
DWC_ssi core and also add common init function for both Keem Bay and
Thunder Bay.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/spi/spi-dw-mmio.c | 8 ++++----
 drivers/spi/spi-dw.h      | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 5101c4c6017b..26c40ea6dd12 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -214,11 +214,10 @@ static int dw_spi_hssi_init(struct platform_device *pdev,
 	return 0;
 }
 
-static int dw_spi_keembay_init(struct platform_device *pdev,
-			       struct dw_spi_mmio *dwsmmio)
+static int dw_spi_intel_init(struct platform_device *pdev,
+			     struct dw_spi_mmio *dwsmmio)
 {
 	dwsmmio->dws.ip = DW_HSSI_ID;
-	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST;
 
 	return 0;
 }
@@ -349,7 +348,8 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_pssi_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_hssi_init},
-	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
+	{ .compatible = "intel,keembay-ssi", .data = dw_spi_intel_init},
+	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ /* end of table */}
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 8b8f924ac410..9e8eb2b52d5c 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -31,8 +31,7 @@
 
 /* DW SPI controller capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
-#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
-#define DW_SPI_CAP_DFS32		BIT(2)
+#define DW_SPI_CAP_DFS32		BIT(1)
 
 /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
 #define DW_SPI_CTRLR0			0x00
-- 
2.17.1

