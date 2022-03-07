Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16834D0442
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244230AbiCGQj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiCGQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:39:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D88C113D;
        Mon,  7 Mar 2022 08:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646671113; x=1678207113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IfQ7fUZWr3XgnvGdQWUlNhHFxPBWxM6ZoBtW01GY8so=;
  b=eV6DHvLlr+Bj0rNI4jrcbqscaXQaqIu55JAWUz5ud5WocS6xfGXld4WB
   yedMyvGrHRDosCU1KHkwz30ThZYduFNvB8ykNnXAsrzSHHh/XDEAHx2jI
   gaQOOjM7mswtvgUyXGtadIvRFQjH0cEBHs9ZIU8ZFV0J8sb2JvqSBGiyc
   Z7S2Yx+oF1oQAo9PPnecD5cM+qJU8gUr2ZorysRvUKbSVU+jNTIRX2BSZ
   hg9sk5rtW+2wqcMdlHzt/AlHTmV2M56X52guRwQYstp+qV7NGzuHb4R6q
   3/St403RgZQoqAQn5BTu/LHbRSWO/08IAhYWKThA++Mnkn+dmZ75krE/3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254377477"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254377477"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 08:38:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="546946690"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 07 Mar 2022 08:38:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6D7982AF; Mon,  7 Mar 2022 18:38:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpio: sim: Declare gpio_sim_hog_config_item_ops static
Date:   Mon,  7 Mar 2022 18:38:40 +0200
Message-Id: <20220307163840.64495-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler is not happy:

  warning: symbol 'gpio_sim_hog_config_item_ops' was not declared. Should it be static?

Fixes: cb8c474e79be ("gpio: sim: new testing module")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 153fe79e1bf3..bb9bb595c1a8 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -1322,7 +1322,7 @@ static void gpio_sim_hog_config_item_release(struct config_item *item)
 	kfree(hog);
 }
 
-struct configfs_item_operations gpio_sim_hog_config_item_ops = {
+static struct configfs_item_operations gpio_sim_hog_config_item_ops = {
 	.release	= gpio_sim_hog_config_item_release,
 };
 
-- 
2.34.1

