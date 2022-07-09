Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046F156CB8A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiGIVQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGIVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:16:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79AEE00;
        Sat,  9 Jul 2022 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657401409; x=1688937409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ODL0ihpJOJMeR1VFcTWoFyzMX5xrZaVdhQBAJthOmEw=;
  b=NDZsVC747Ujmj0Me2Kh105mz7ammD+Dn6SGS6FOaSrFYcuFl+z1jBjHw
   17o6kY4LBce3HbqRpU/ADz10W1P0Fv7xIvMowTbXmwL8lowaiqCa0JADA
   oHiOD44s4pQ7FfXH2NyxkcCJPfqwSx4UTGMsd7NTkELBwH3ATiEypKlvh
   7OF3EPKVUn69fd2lVnCHl7uyO6j4sgsNEtulmly010/4KiBQ8ApUNVKt5
   U97aln54nOB0l/sKqGbfpUwiXtdwULLR6RqnVaLNBq8X0TxiL1v+vPYFm
   7CsT+W1n2KZy4uZX6FSV85oN1MCG1EMHvGpXpqiMu3Tk1OWxbym9WZ8Y2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="348445247"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="348445247"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 14:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="621623591"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2022 14:16:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C759E400; Sun, 10 Jul 2022 00:16:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/6] platform/x86: serial-multi-instantiate: Improve dev_err_probe() messaging
Date:   Sun, 10 Jul 2022 00:16:50 +0300
Message-Id: <20220709211653.18938-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
References: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2: added tag (Hans)
 drivers/platform/x86/serial-multi-instantiate.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index a1e04be858c5..970ede0ff002 100644
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

