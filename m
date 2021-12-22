Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83F947D33D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245525AbhLVNyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:54:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:7722 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245495AbhLVNyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640181275; x=1671717275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/LCx+xvLLN5kzI6YWKdSJp5PTvYYMmIuEFe0+SvGyRw=;
  b=UuKmv1IstPIoufMZ9wDkq0i60Zqy48PLrstOYhvAac122AsD47lbJD+z
   63c9LHMEdl9z662PR+BqJ5ER1OPKZ+OOtzJQushLZSA/QURmtaKe4TUKy
   JrkplDCRtyiECKGtZGAr9bYIwU3U8m76Yuva1ISkBp/wtCrm+1iVGUqQH
   lotpv7PMUFZ3K0WSRqEsOW4UVtCtUG/dHddPFGwjiUbf9Dd03el9AvuFY
   zHvk+bQLKHFsVCZxLygwMvczEiwJSUTyuT71UB5H336Gcval7GWPiIIWX
   MCRDgTyciRuTxXKMRnEEN9T8wVKp9wfVLrr6ByRgg4nlg8HEMwy4IlnMP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="220633013"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="220633013"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 05:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="664276990"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 05:54:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EA50B23E; Wed, 22 Dec 2021 15:54:27 +0200 (EET)
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
Subject: [PATCH v1 1/3] spi: dln2: Propagate firmware node
Date:   Wed, 22 Dec 2021 15:54:21 +0200
Message-Id: <20211222135423.62487-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate firmware node by using a specific API call, i.e. device_set_node().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dln2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 3ff63ab82f4f..ac83b406151d 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -688,6 +688,8 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	device_set_node(&master->dev, dev_fwnode(dev));
+
 	platform_set_drvdata(pdev, master);
 
 	dln2 = spi_master_get_devdata(master);
@@ -699,7 +701,6 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	}
 
 	dln2->master = master;
-	dln2->master->dev.of_node = dev->of_node;
 	dln2->pdev = pdev;
 	dln2->port = pdata->port;
 	/* cs/mode can never be 0xff, so the first transfer will set them */
-- 
2.34.1

