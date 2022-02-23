Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C084C1C14
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244355AbiBWTUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBWTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:20:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF95245AEF;
        Wed, 23 Feb 2022 11:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645643974; x=1677179974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pDgw7OCRc/lpOELn0dBUMVTTBUjbmk7Aeld/Q7TbFbM=;
  b=ifPg2ITfJn1N1xRI35ZFLc1ASMPsJLWrNAIFyD94yX2uh6mrupkTajqf
   223bzkA+T+XGswVoZNnVYKWZf2cS3kTNIYm2H0HI9BAW/UeJm9qSReMEc
   Sz+9gP8yyfnmhwjgL5iRNySG5oVEg0hEL2SA4WcqzZ87ge17wbz5c24qa
   PAmqo3kpvA30cCV8k1JO+NbHLRTEpUbyOnugupTSpJsIHKhcLBaLc5J9J
   JR4h2BPgkmMFfHPzKx1HljTRuv8yBAbOtt/amKAl7Vhk5nSUM5DaNmJFJ
   YXzb8uSkpL79wChEHVpv8zDyIwruznKspH4QB/d1Tt0QzDdYbBwY0Hu/U
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="249642364"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="249642364"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:19:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="591820678"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2022 11:19:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 32D6894; Wed, 23 Feb 2022 21:19:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/1] spi: pxa2xx-pci: Do not dereference fwnode in struct device
Date:   Wed, 23 Feb 2022 21:19:48 +0200
Message-Id: <20220223191948.31325-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make the underneath API easier to change in the future,
prevent users from dereferencing fwnode from struct device.
Instead, use the specific dev_fwnode() API for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 6502fda6243e..6d60972e4e20 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -276,7 +276,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		return PTR_ERR(ssp->clk);
 
 	memset(&pi, 0, sizeof(pi));
-	pi.fwnode = dev->dev.fwnode;
+	pi.fwnode = dev_fwnode(&dev->dev);
 	pi.parent = &dev->dev;
 	pi.name = "pxa2xx-spi";
 	pi.id = ssp->port_id;
-- 
2.34.1

