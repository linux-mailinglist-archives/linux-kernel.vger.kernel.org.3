Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371D753C809
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243296AbiFCKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243279AbiFCKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:00:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B663AA55;
        Fri,  3 Jun 2022 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654250407; x=1685786407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WyWSCsSWPZ0+t965uEl8LVT+rA2XTwyfQj8wcm8FGQI=;
  b=eoyvc0hySCuZK0bnN8raTo4ehBRRhs49PAJd5GaMlar12HgPKkUmCInG
   WLPJpcHZPDco/Ssq2Nt0SKhC1O0y8A0k3vW45QR6XezFdVU6qEmlHcKR4
   3ybUdUk/hhy/0zoIM72RXbm0uXwhDLkk7eEjuH3ox4HIrXsey9ctlTwPX
   06PXnztaLkwruaY5B6MJ7xgAQkfKXbh1gcB9wHpou6HGWbwUZzgcw0Z3U
   8hgYOZVZAjehxz3XvrZXsS5t23vSbVxsLWuF55kbS+3YvN/1gIw4Sj7Eu
   3XixWp0N/lk2WoAC9DgzvUTqfx7zznYBpIJzP2CLtEWQAwPSMeOqHNX08
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="362587891"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="362587891"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 03:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="681081150"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2022 03:00:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 34FD3A97; Fri,  3 Jun 2022 13:00:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 4/6] iio: adc: meson_saradc: Use devm_clk_get_optional()
Date:   Fri,  3 Jun 2022 13:00:02 +0300
Message-Id: <20220603100004.70336-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded variants of devm_clk_get_optional().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
v3: no changes

 drivers/iio/adc/meson_saradc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 0d9aef362c5d..337517a8e1ac 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1222,23 +1222,13 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->core_clk),
 				     "failed to get core clk\n");
 
-	priv->adc_clk = devm_clk_get(&pdev->dev, "adc_clk");
-	if (IS_ERR(priv->adc_clk)) {
-		if (PTR_ERR(priv->adc_clk) == -ENOENT)
-			priv->adc_clk = NULL;
-		else
-			return dev_err_probe(&pdev->dev, PTR_ERR(priv->adc_clk),
-					     "failed to get adc clk\n");
-	}
+	priv->adc_clk = devm_clk_get_optional(dev, "adc_clk");
+	if (IS_ERR(priv->adc_clk))
+		return dev_err_probe(dev, PTR_ERR(priv->adc_clk), "failed to get adc clk\n");
 
-	priv->adc_sel_clk = devm_clk_get(&pdev->dev, "adc_sel");
-	if (IS_ERR(priv->adc_sel_clk)) {
-		if (PTR_ERR(priv->adc_sel_clk) == -ENOENT)
-			priv->adc_sel_clk = NULL;
-		else
-			return dev_err_probe(&pdev->dev, PTR_ERR(priv->adc_sel_clk),
-					     "failed to get adc_sel clk\n");
-	}
+	priv->adc_sel_clk = devm_clk_get_optional(dev, "adc_sel");
+	if (IS_ERR(priv->adc_sel_clk))
+		return dev_err_probe(dev, PTR_ERR(priv->adc_sel_clk), "failed to get adc_sel clk\n");
 
 	/* on pre-GXBB SoCs the SAR ADC itself provides the ADC clock: */
 	if (!priv->adc_clk) {
-- 
2.35.1

