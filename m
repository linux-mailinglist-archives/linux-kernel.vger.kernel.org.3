Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23734C4C06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbiBYRZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiBYRZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:25:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF671AAA43;
        Fri, 25 Feb 2022 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809869; x=1677345869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OlurqVaDNqAkiulsXHgdN0qyGkN75qpZRRBUn3kZErg=;
  b=H66otDR65GatZVxkB1xllDxbIWgCj3bOVGWnoE7yLWDEJiFtWFzpx2FA
   QsLtD9QlQNOw4u6LLle+pg2y4WenwDGXxCPCs9s01JwpG++fhu10zgzpu
   CI3n4XB9vrnY8SmmrQXD8iwG9DjfXBDUxYP6AfgZMhgJj+kDA0w7wQSka
   XtopMpZ90ViPQgAtsIGTswH7iNM9EM7rnEz4lvzPFjCdYF8sE2+70/QxZ
   36eYbfLZtoVlkYsRlzx/vv5lUWQD9e33Ckw/LnEp4sS7Dj3SmZamwlEGu
   ijhYbfylFuZtB/0FgGUrq7ZpewZSrWE+MBbNlB7fAudhVJg/QK1OXeeRL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252736969"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="252736969"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="707929863"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 25 Feb 2022 09:23:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9D20894; Fri, 25 Feb 2022 19:24:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 01/11] spi: pxa2xx-pci: Refactor CE4100 to use ->setup()
Date:   Fri, 25 Feb 2022 19:23:40 +0200
Message-Id: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor CE4100 handling code to use ->setup() instead of spreading
potentially confusing conditional.

Besides that, it will allow to refactor further to avoid intermediate
storage for the used configuration parameters.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 6d60972e4e20..bd20379d9342 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -30,7 +30,7 @@ enum {
 struct pxa_spi_info {
 	enum pxa_ssp_type type;
 	int port_id;
-	int num_chipselect;
+	unsigned int num_chipselect;
 	unsigned long max_clk_rate;
 
 	/* DMA channel request parameters */
@@ -114,6 +114,14 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	return 0;
 }
 
+static int ce4100_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
+{
+	c->num_chipselect = dev->devfn;
+	c->max_clk_rate = 3686400;
+
+	return 0;
+}
+
 static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 {
 	struct dw_dma_slave *tx, *rx;
@@ -163,8 +171,7 @@ static struct pxa_spi_info spi_info_configs[] = {
 	[PORT_CE4100] = {
 		.type = PXA25x_SSP,
 		.port_id =  -1,
-		.num_chipselect = -1,
-		.max_clk_rate = 3686400,
+		.setup = ce4100_spi_setup,
 	},
 	[PORT_BYT] = {
 		.type = LPSS_BYT_SSP,
@@ -248,7 +255,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	}
 
 	memset(&spi_pdata, 0, sizeof(spi_pdata));
-	spi_pdata.num_chipselect = (c->num_chipselect > 0) ? c->num_chipselect : dev->devfn;
+	spi_pdata.num_chipselect = c->num_chipselect;
 	spi_pdata.dma_filter = c->dma_filter;
 	spi_pdata.tx_param = c->tx_param;
 	spi_pdata.rx_param = c->rx_param;
-- 
2.34.1

