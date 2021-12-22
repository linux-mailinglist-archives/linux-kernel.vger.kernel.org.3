Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA9247D476
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbhLVP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:57:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:28384 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241582AbhLVP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640188655; x=1671724655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Bu50qtTOTojY1kLhf5L6JDQtk4kCn6zrEZoyyOYPRo=;
  b=hi8dRdGxvgt6YGiXhyB3IUumfRy7kq4B5pQl4jMDbdezMRp9TLEPTWX+
   6CahdvPz+zO4CWUeRQfmvIKfxU3BoXyKbJlCE1RM3jjP23AuuOXU6Iak6
   f/eDIMsNT/hvAzN+iBWPpau1plX6Eq02TyOXF1Hzx7kP3O/MwuBsPpOnj
   BareTt9azmtTfeG5jqcJ/xAEDscH1gau8MP2weN8yw+SDCSq9yoI7AbkF
   B3tBuDn4WFEqt4BaPM+mp8xK320ObZ8kBUvVPfi6RcI6l2yT/I3F6juZm
   KaZqLtqu5Wf2QlhOQVI9ZYL6VOCKUHFDiJHU//fkvMceYmm8vbcfIlyMi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240871442"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240871442"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 07:57:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="607449551"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Dec 2021 07:57:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20D7C120; Wed, 22 Dec 2021 17:57:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 3/3] spi: pxa2xx: Propagate firmware node
Date:   Wed, 22 Dec 2021 17:57:39 +0200
Message-Id: <20211222155739.7699-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222155739.7699-1-andriy.shevchenko@linux.intel.com>
References: <20211222155739.7699-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate firmware node by using a specific API call, i.e. device_set_node().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/spi/spi-pxa2xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b3186bd0c2a8..e88f86274eeb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1664,8 +1664,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	drv_data->controller_info = platform_info;
 	drv_data->ssp = ssp;
 
-	controller->dev.of_node = dev->of_node;
-	controller->dev.fwnode = dev->fwnode;
+	device_set_node(&controller->dev, dev_fwnode(dev));
 
 	/* The spi->mode bits understood by this driver: */
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
-- 
2.34.1

