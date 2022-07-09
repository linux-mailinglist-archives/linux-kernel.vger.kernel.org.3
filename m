Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815B56C536
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiGIAHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiGIAHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:07:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CF066AD2;
        Fri,  8 Jul 2022 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657325201; x=1688861201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvEDI+ai1OrcRj7WFdr6nyI9idPf7b4xeWPMJtotAKg=;
  b=jkC3tKS4V9NPw8EGUv1/vNGkNtY9pc5l+2+xivk5+4LywmzJCESY+W9r
   Q8E86SoToI0RyVW0I/cKJurZ6i6KzW4Tg4skxJ4VtI3CUkjvRGRmqXeUw
   E7HHKDj/WRv99xn57ZEmNd041KERITfyiJRfPGrw6kSwVyAHmzQye4/uZ
   oHdOOG6Mz0lV2asBPa6DOOwqgzM7GFmZUUR8SIn3mdo8kZZYXfSYhcVB8
   3RkJ5VrGaMH7xUlJEgvOs9JxGa67DmjBXf/2W14IcN8kIVyy+pyUM4eBL
   Aca0BtPwiWsgTZstyllg/24tqbr4cyr1prQBxR0W2414E1oXhV+pE4QEE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="264802885"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="264802885"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="683821845"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2022 17:06:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 96C5E400; Sat,  9 Jul 2022 03:06:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/7] platform/x86: serial-multi-instantiate: Improve dev_err_probe() messaging
Date:   Sat,  9 Jul 2022 03:06:33 +0300
Message-Id: <20220709000636.35550-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
References: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicate print of returned value in the messages and use pattern
return dev_err_probe(...) where it's possible.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/serial-multi-instantiate.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index ceb0e414b9f5..520236b11b2c 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -61,10 +61,9 @@ static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
 	default:
 		return 0;
 	}
-
 	if (ret < 0)
-		dev_err_probe(&pdev->dev, ret, "Error requesting irq at index %d: %d\n",
-			      inst->irq_idx, ret);
+		return dev_err_probe(&pdev->dev, ret, "Error requesting irq at index %d\n",
+				     inst->irq_idx);
 
 	return ret;
 }
@@ -112,9 +111,8 @@ static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
 
 		spi_dev = acpi_spi_device_alloc(NULL, adev, i);
 		if (IS_ERR(spi_dev)) {
-			ret = PTR_ERR(spi_dev);
-			dev_err_probe(dev, ret, "failed to allocate SPI device %s from ACPI: %d\n",
-				      dev_name(&adev->dev), ret);
+			ret = dev_err_probe(dev, PTR_ERR(spi_dev), "failed to allocate SPI device %s from ACPI\n",
+					    dev_name(&adev->dev));
 			goto error;
 		}
 
@@ -135,9 +133,8 @@ static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
 
 		ret = spi_add_device(spi_dev);
 		if (ret) {
-			dev_err_probe(&ctlr->dev, ret,
-				      "failed to add SPI device %s from ACPI: %d\n",
-				      dev_name(&adev->dev), ret);
+			dev_err_probe(&ctlr->dev, ret, "failed to add SPI device %s from ACPI\n",
+				      dev_name(&adev->dev));
 			spi_dev_put(spi_dev);
 			goto error;
 		}
-- 
2.35.1

