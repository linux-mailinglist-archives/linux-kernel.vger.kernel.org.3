Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E97C4D14ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345920AbiCHKfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345918AbiCHKfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:35:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A004348E;
        Tue,  8 Mar 2022 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646735675; x=1678271675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=818ZiUqupFKx30M4QQyr2CZvlTpag7QHU9v/hFaDbMM=;
  b=O1JAu2sgxKODjeBJSgX0ggf7LowM4PUNMnn25Bn5o+hVMmPBqTsvx7sV
   tB9gUwDODtaQBW5cDbfue9mFm1Fbd/9c0g4NKcGEQcFdvJaDXndDun1Xw
   Tb5+pZJJN1wxNifPLHJOi9Z8bdQGIKRD936Ed2J7PjAEJXwhUOEBcILAi
   UZ/N99rlG6QxDyhJpLydMdmihLMstshjBWR2M7ELsDTwAvCrSv1fBbHOE
   A8D3cU6M7autkVg2Os59+C55QTSGhmD26ILXyJ551g2v3Exd9Tk/wnVb4
   Jg8KDowC/FLJISQodi+jwSZgwnWVv5Og5TJcxn7Ci7XCPJpmi15bSx+F3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234605624"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="234605624"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:34:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="643612251"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 02:34:32 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v4 3/3] spi: dw: Add support for master mode selection for DWC SSI controller
Date:   Tue,  8 Mar 2022 18:33:31 +0800
Message-Id: <20220308103331.4116-4-nandhini.srikandan@intel.com>
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

Add support to select the controller mode as master mode by setting
Bit 31 of CTRLR0 register. This feature is supported for controller
versions above v1.02.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 drivers/spi/spi-dw-core.c | 4 ++--
 drivers/spi/spi-dw.h      | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index ecea471ff42c..68bfdf2c4dc7 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -307,8 +307,8 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 		if (spi->mode & SPI_LOOP)
 			cr0 |= DW_HSSI_CTRLR0_SRL;
 
-		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
-			cr0 |= DW_HSSI_CTRLR0_KEEMBAY_MST;
+		/* CTRLR0[31] MST */
+		cr0 |= DW_HSSI_CTRLR0_MST;
 	}
 
 	return cr0;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index d5ee5130601e..2583b7314c41 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -23,7 +23,7 @@
 	((_dws)->ip == DW_ ## _ip ## _ID)
 
 #define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
-	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
+	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ ## _ver)
 
 #define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip, _ver, ==)
 
@@ -31,8 +31,7 @@
 
 /* DW SPI controller capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
-#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
-#define DW_SPI_CAP_DFS32		BIT(2)
+#define DW_SPI_CAP_DFS32		BIT(1)
 
 /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
 #define DW_SPI_CTRLR0			0x00
@@ -100,7 +99,7 @@
  * 0: SSI is slave
  * 1: SSI is master
  */
-#define DW_HSSI_CTRLR0_KEEMBAY_MST		BIT(31)
+#define DW_HSSI_CTRLR0_MST			BIT(31)
 
 /* Bit fields in CTRLR1 */
 #define DW_SPI_NDF_MASK				GENMASK(15, 0)
-- 
2.17.1

