Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8220F5AF07F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiIFQf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbiIFQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:34:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608BB81B00;
        Tue,  6 Sep 2022 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662480636; x=1694016636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gedYZwo4u48DyQIx4AvZM58SsPLraSGOxPfVfqmenhw=;
  b=OzTCVFSs8olnZXWnjCsQ13tnHOF7usEDhxuvr3YKSI4ie18wtGvZqgkz
   eyk+sByDBlf0Er1xUH/oh9cKlgQtJDkUQcyhWwUNz06YwH6mmAU5cbpiP
   GmJnLf2jIGy3jc24F84p2PxSf/9je0h6D3jj8alC129YYzx206VDak64B
   8YLMElcIc+spq3He4vrXWvc/sWLcbZaqcjlZusnF55VNG7guJ7Xrc7ncN
   ZG87IVzec8exyZ3oz+iF7cTNeIpdU/++4v6impdoJkfIbTHFVQRzxPG/Q
   KzLDhwhbdUoivzYdH756DxObbiImf6psXFuqvhUjJYMwr1+PYvgwTRZx5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276373799"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276373799"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 09:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942510315"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2022 09:10:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AC18986; Tue,  6 Sep 2022 19:10:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: nxp-fspi: Do not dereference fwnode in struct device
Date:   Tue,  6 Sep 2022 19:10:48 +0300
Message-Id: <20220906161048.39953-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

In order to make the underneath API easier to change in the future,
prevent users from dereferencing fwnode from struct device. Instead,
use the specific dev_fwnode() API for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-nxp-fspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 2b0301fc971c..d6a65a989ef8 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -588,7 +588,7 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
 {
 	int ret;
 
-	if (is_acpi_node(f->dev->fwnode))
+	if (is_acpi_node(dev_fwnode(f->dev)))
 		return 0;
 
 	ret = clk_prepare_enable(f->clk_en);
@@ -606,7 +606,7 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
 
 static int nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
 {
-	if (is_acpi_node(f->dev->fwnode))
+	if (is_acpi_node(dev_fwnode(f->dev)))
 		return 0;
 
 	clk_disable_unprepare(f->clk);
@@ -1100,7 +1100,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, f);
 
 	/* find the resources - configuration register address space */
-	if (is_acpi_node(f->dev->fwnode))
+	if (is_acpi_node(dev_fwnode(f->dev)))
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	else
 		res = platform_get_resource_byname(pdev,
@@ -1113,7 +1113,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	}
 
 	/* find the resources - controller memory mapped space */
-	if (is_acpi_node(f->dev->fwnode))
+	if (is_acpi_node(dev_fwnode(f->dev)))
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	else
 		res = platform_get_resource_byname(pdev,
-- 
2.35.1

