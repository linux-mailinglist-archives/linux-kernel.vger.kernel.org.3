Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831175AB83A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiIBSa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIBSa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:30:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CEF12AE0;
        Fri,  2 Sep 2022 11:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143428; x=1693679428;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Q0ymAdm6otN/gngzS3FLjUFevWcyueCxj1MBaH9yisg=;
  b=NNadTbJBM1Xpovc+CyI3O5xJp85hMGEk898e/FTYiAqeCFe9MKMrXwOt
   ITlHk21CSs0ASrlZPX5Ry3i84KS5zOobVDYt8Ggmo6YKJ0tuAM8TUgcbo
   w4yZgQbsYKW3tK7sl08mkbySZopO3KEmwUNRyoyaT6bktRLYR/HXjvwsi
   HSaLrpq/uB47wbAXHpqX8RwtImSgy/G7dmfJutjq4r1FNGgGHasr8eHNf
   ISZt4AkPTfBSWJLHbQ7SCQyXqc/H48APVlD6sSdF4BHJ+5A/4gnjKTxej
   a5G27T8oQUjF/DukE2clZ7pMvaVZE5KiYzUaRAYonpzU94oitGIMR3veg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296056318"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="296056318"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="858319714"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Sep 2022 11:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5877F725; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 14/17] pinctrl: cy8c95x0: support ACPI device found on Galileo Gen1
Date:   Fri,  2 Sep 2022 21:26:47 +0300
Message-Id: <20220902182650.83098-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
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

Add support of the expander found on Intel Galileo Gen1 board.
The platform information comes from ACPI.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 699da63d9c39..5d8a7d236e62 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1330,10 +1330,17 @@ static int cy8c95x0_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct acpi_device_id cy8c95x0_acpi_ids[] = {
+	{ "INT3490", 40, },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cy8c95x0_acpi_ids);
+
 static struct i2c_driver cy8c95x0_driver = {
 	.driver = {
 		.name	= "cy8c95x0-pinctrl",
 		.of_match_table = cy8c95x0_dt_ids,
+		.acpi_match_table = cy8c95x0_acpi_ids,
 	},
 	.probe_new	= cy8c95x0_probe,
 	.remove		= cy8c95x0_remove,
-- 
2.35.1

