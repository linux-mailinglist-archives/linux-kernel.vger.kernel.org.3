Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBECE47D338
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245493AbhLVNy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:54:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:16792 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234159AbhLVNyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640181265; x=1671717265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dVTnm7Vj85GUu0rogxumgYtqYxX+kTZ7Uoxyo2KfUh0=;
  b=RAdNxK8uZKBNeOEK/hKThoePw/DxDG5rsYTtGlQCyWNmcCbFhGfMbu+W
   xGOh6Nkf6kDNvcZFG9+F2f2mkxVwqIuZUrQAHpuVRU66NbtVLXA3qGaS7
   6WMHSzM3ML++Q426qnTRU5IuuvQNjCKc6KjhyvlJquUzBF1BFysLHP2X1
   PeVEmGcl7Al+LJp0O1W7e7M2dR8nfzKdtuQIEiT7CVawhmhgOcmRgOIkv
   dSWGEk561DZ2NBlEFG54XvW/Wk1I8kXc78xDsnNORJd0wXZYEJm1m2vBP
   bQTBbxgXSzIrmK2W06H6S0y4EP8ZGS6fPBAOTCLepxQPNTsoIcfM1zVBf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240845054"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240845054"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 05:54:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="484761402"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Dec 2021 05:54:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 23AD0331; Wed, 22 Dec 2021 15:54:30 +0200 (EET)
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
Subject: [PATCH v1 3/3] spi: pxa2xx: Propagate firmware node
Date:   Wed, 22 Dec 2021 15:54:23 +0200
Message-Id: <20211222135423.62487-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222135423.62487-1-andriy.shevchenko@linux.intel.com>
References: <20211222135423.62487-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate firmware node by using a specific API call, i.e. device_set_node().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

