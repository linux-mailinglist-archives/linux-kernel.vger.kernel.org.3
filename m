Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B21456CB8D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiGIVRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGIVQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:16:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ED2E0AB;
        Sat,  9 Jul 2022 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657401410; x=1688937410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mcUr7Iz5FrBDHo5wxQ9FyfKWElcKrhXuqIyIE9pRGv4=;
  b=DjPAUafUvera2wo7zgKme5icpc07kp2uXq55ZuLZAG0VgLIblxweCOSK
   Elxb2fjHSMdiCOBpTPTXFul4mxFpDoBEuiV5n0UGnuCiNqYRZ7vg0ohcM
   Q6ASGGoajmfshIMjQ8MMcaBE3iQr3FfkOUjjroS0laUdVXtS2pSuhvB5V
   KzQRPJewBrnbcjuh4sU1XvSkxx3HShnQLzmq8k6jEdDg6Cudho9ViGNoK
   1PC1d1P0kalClzrsPGnevOheyOTJauKXS5pr0N5OaW8CCdrYmLrPNPY4z
   z4dX0gCqC0+vSpjnLUgB2NXkwOtksT6yj/x16gc7+joeUwrEzWC9LEd7U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="264872816"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="264872816"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 14:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="591884918"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2022 14:16:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B9A921A0; Sun, 10 Jul 2022 00:16:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/6] platform/x86: serial-multi-instantiate: Improve autodetection
Date:   Sun, 10 Jul 2022 00:16:48 +0300
Message-Id: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Instead of calling specific resource counter, let just probe each
of the type and see what it says. Return -ENOENT if no resources
found.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: squashed patch 1, restored behaviour, added comment, dropped message (Hans)
 .../platform/x86/serial-multi-instantiate.c   | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 1e8063b7c169..366087a9fce2 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -100,7 +100,7 @@ static int smi_spi_probe(struct platform_device *pdev, struct acpi_device *adev,
 	if (ret < 0)
 		return ret;
 	else if (!ret)
-		return -ENODEV;
+		return -ENOENT;
 
 	count = ret;
 
@@ -184,7 +184,7 @@ static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev,
 	if (ret < 0)
 		return ret;
 	else if (!ret)
-		return -ENODEV;
+		return -ENOENT;
 
 	count = ret;
 
@@ -232,6 +232,7 @@ static int smi_probe(struct platform_device *pdev)
 	const struct smi_node *node;
 	struct acpi_device *adev;
 	struct smi *smi;
+	int ret;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
@@ -255,15 +256,21 @@ static int smi_probe(struct platform_device *pdev)
 	case SMI_SPI:
 		return smi_spi_probe(pdev, adev, smi, node->instances);
 	case SMI_AUTO_DETECT:
-		if (i2c_acpi_client_count(adev) > 0)
-			return smi_i2c_probe(pdev, adev, smi, node->instances);
-		else
-			return smi_spi_probe(pdev, adev, smi, node->instances);
+		/*
+		 * For backwards-compatibility with the existing nodes I2C
+		 * is checked first and if such entries are found ONLY I2C
+		 * devices are created. Since some existing nodes that were
+		 * already handled by this driver could also contain unrelated
+		 * SpiSerialBus nodes that were previously ignored, and this
+		 * preserves that behavior.
+		 */
+		ret = smi_i2c_probe(pdev, adev, smi, node->instances);
+		if (ret != -ENOENT)
+			return ret;
+		return smi_spi_probe(pdev, adev, smi, node->instances);
 	default:
 		return -EINVAL;
 	}
-
-	return 0; /* never reached */
 }
 
 static int smi_remove(struct platform_device *pdev)
-- 
2.35.1

