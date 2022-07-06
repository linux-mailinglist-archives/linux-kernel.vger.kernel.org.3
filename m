Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AFE567D56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiGFE0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiGFE0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:26:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C71C928;
        Tue,  5 Jul 2022 21:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657081589; x=1688617589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TD+EcV7QHWo/7h2QaSDBHa9JniiobECtkUYXZk9C9nA=;
  b=D4fQ8opUH3d/CELwqoRPDMkZy/GbmVBDLnaGAk6houkTwWJxaQ3s7o9c
   5G0kMTlfIotAdiY6akkdWS/3PoVKzNT31ja9z20DU5aQMKd5cUTkdoPVP
   T0rcWwhbOoR88F6PnSMQuFBueOgaGRL0GZEyjbNd/qMCTDK7uzbbConIJ
   jD2z7aT++MZBVdLmCWB89KoNJR1H/K04CRdhe4EwqbIMBpY0W57O4lAHn
   g5nwnHBKl9GANLaD5UqyjTFT5OWy8H0N8iaPcO54cmjD7AUgmASKATNwN
   f+vkY6L3DXKj1NfTxzhYXkLF6NinD6KM6XM51y5Jr6bCFuYxxzZNWPFdN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="283663257"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="283663257"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 21:26:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="769895459"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2022 21:26:25 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v5 3/4] spi: dw: Add support for master mode selection for DWC SSI controller
Date:   Wed,  6 Jul 2022 12:20:38 +0800
Message-Id: <20220706042039.5763-4-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220706042039.5763-1-nandhini.srikandan@intel.com>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add support to select the controller mode as master mode by setting
Bit 31 of CTRLR0 register. This feature is supported for controller
versions above v1.02.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 drivers/spi/spi-dw-core.c | 5 +++--
 drivers/spi/spi-dw.h      | 8 +-------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index ecea471ff42c..41ae21e1b879 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -307,8 +307,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 		if (spi->mode & SPI_LOOP)
 			cr0 |= DW_HSSI_CTRLR0_SRL;
 
-		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
-			cr0 |= DW_HSSI_CTRLR0_KEEMBAY_MST;
+		/* CTRLR0[31] MST */
+		if (dw_spi_ver_is_ge(dws, HSSI, 102A))
+			cr0 |= DW_HSSI_CTRLR0_MST;
 	}
 
 	return cr0;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 79d853f6d192..8b8f924ac410 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -94,13 +94,7 @@
 #define DW_HSSI_CTRLR0_SCPOL			BIT(9)
 #define DW_HSSI_CTRLR0_TMOD_MASK		GENMASK(11, 10)
 #define DW_HSSI_CTRLR0_SRL			BIT(13)
-
-/*
- * For Keem Bay, CTRLR0[31] is used to select controller mode.
- * 0: SSI is slave
- * 1: SSI is master
- */
-#define DW_HSSI_CTRLR0_KEEMBAY_MST		BIT(31)
+#define DW_HSSI_CTRLR0_MST			BIT(31)
 
 /* Bit fields in CTRLR1 */
 #define DW_SPI_NDF_MASK				GENMASK(15, 0)
-- 
2.17.1

