Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B994D14E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbiCHKfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345904AbiCHKf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:35:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8842483;
        Tue,  8 Mar 2022 02:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646735672; x=1678271672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JsCodzOmII512dLTHpv/v1yXZod+ZMLo+DfZJQcuPHc=;
  b=VdwXGtsQHJSNlKSeemaW/nE8TDaSpbAjqG9/WqTAvjiz5ibym3QjGL+r
   cMKmf/UpaIWQaqyQQwToclb0HJBRKJGsTuoOkAjLilCfQDRpJ57FuW8ks
   Oxyh52dCIq7eZMqD+YoYFakxM2aAxFRZwge+Va7zfCWDZzJq5xbkKoPTX
   aSf4InJdMZS+MUUTJvMZJqeMJOfXvl34ezishWn9ECYjiTvRDXk46izlJ
   mXoFN1pES+xyyninsfhrloRhsHTXQwQpGFBrZ+LWEh5WiCiDUHHD4XqOK
   YII8VjLcSeghQDzZsZdQm6GOFNs0FdpWCyS4gbkn3KWLbDk42+bcDiNMa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234605611"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="234605611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="643612241"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 02:34:28 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v4 2/3] spi: dw: Add support for Intel Thunder Bay SPI controller
Date:   Tue,  8 Mar 2022 18:33:30 +0800
Message-Id: <20220308103331.4116-3-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220308103331.4116-1-nandhini.srikandan@intel.com>
References: <20220308103331.4116-1-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/spi/spi-dw-mmio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.17.1

