Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFC655FEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiF2Lim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiF2Lij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:38:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B332076;
        Wed, 29 Jun 2022 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656502718; x=1688038718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jvQQGBLtP2lMYjK15fTYrTMQlaw8xtvzDZjwyhz2efQ=;
  b=csmzP7C/q9as80NazEbKJsSOl5rL4eYUlBADXbYRA+7tbi0sKRjTKEWr
   3tlul+aMWJCIsGhcfYsDhwxVuGqOZIGp+4xxSWd2RqEpgr41ykIYee31u
   8anMHa2WCg6sAVL98SQXjtsi45ZrFRlJrUExwVWQ3EPlLuISjTvCCmPTj
   2iy9OkzryugCZdxXfN8+ag88ltSziAr7viBrlCSSRaWzrCk/0GjnT69c6
   nmfzOawgUfVT/dDfCPm/OezWLspac9/Cho+diXqe3p7e28g9lSA1zbbCV
   Y9f8FUoK06/wBOZTwFBwU3pVXVUuDHO2fX5lBqKIwKQFzdrbNBiTkiuVP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="283103045"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="283103045"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="623279570"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 29 Jun 2022 04:38:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 88935F1; Wed, 29 Jun 2022 14:38:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frank.rowand@sony.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] of: unittest: Switch to use fwnode instead of of_node
Date:   Wed, 29 Jun 2022 14:38:39 +0300
Message-Id: <20220629113839.4604-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node, so
switch the module to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/of/unittest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7f6bba18c515..03052ffb16e2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1602,7 +1602,7 @@ static int unittest_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, devptr);
 
-	devptr->chip.of_node = pdev->dev.of_node;
+	devptr->chip.fwnode = dev_fwnode(&pdev->dev);
 	devptr->chip.label = "of-unittest-gpio";
 	devptr->chip.base = -1; /* dynamic allocation */
 	devptr->chip.ngpio = 5;
-- 
2.35.1

