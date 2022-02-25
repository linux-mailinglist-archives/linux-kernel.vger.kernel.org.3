Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864C04C4C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbiBYRZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbiBYRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:24:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D91A8052;
        Fri, 25 Feb 2022 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809848; x=1677345848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q5ByLcewtILeNFeZF/m+uYsB2G/oXs3txUj2ZiVryFw=;
  b=Ub0VxlS5BSVsGzzn/ljaQYhRE6Ky9lAJiu+LQlPfYPZPvDwMGwjCQkSR
   QlR1kswPo6izszFzVCAFZqhP8GDtoJvHhjbUVZ5TuuSAftSa7gnYhtlVQ
   9F8IxzJUqixsgykt7dGXCVi2DRZmWDhCTkhiBB+2BTD9hQpFsSgbaoU5+
   khbmagqdLV2Nt4OjESkD6OP3X5Egn7BoTMt8L3ZMYdGu42ADDo/uOur92
   ipJNCLgRcZeYTEdXenhqTE+hR6cZviYC2qddfHiJpXkuEgmoixmAYICod
   AzWpeRgYj7sTMMlFNCTM2TNyC0ylCDqp9Gr+Loct1apnxTn3H6oUP7rrG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232513155"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="232513155"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="549342139"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2022 09:24:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4465194; Fri, 25 Feb 2022 19:24:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 02/11] spi: pxa2xx-pci: Refactor Quark X1000 to use ->setup()
Date:   Fri, 25 Feb 2022 19:23:41 +0200
Message-Id: <20220225172350.69797-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
References: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor Quark X1000 handling code to use ->setup() instead of using
the configuration data structure directly.

It will allow to refactor further to avoid intermediate storage for
the used configuration parameters.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index bd20379d9342..4d617ad72bca 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -167,6 +167,14 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	return 0;
 }
 
+static int qrk_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
+{
+	c->num_chipselect = 1;
+	c->max_clk_rate = 50000000;
+
+	return 0;
+}
+
 static struct pxa_spi_info spi_info_configs[] = {
 	[PORT_CE4100] = {
 		.type = PXA25x_SSP,
@@ -209,8 +217,7 @@ static struct pxa_spi_info spi_info_configs[] = {
 	[PORT_QUARK_X1000] = {
 		.type = QUARK_X1000_SSP,
 		.port_id = -1,
-		.num_chipselect = 1,
-		.max_clk_rate = 50000000,
+		.setup = qrk_spi_setup,
 	},
 	[PORT_LPT0] = {
 		.type = LPSS_LPT_SSP,
-- 
2.34.1

