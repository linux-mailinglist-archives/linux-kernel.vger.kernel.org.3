Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44BE5A6B83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiH3R7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiH3R7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:59:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4066586;
        Tue, 30 Aug 2022 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661882318; x=1693418318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c1bfzPlPnwcIaAydZuBk1LBtzOY1e4cy8A3W3XSpJms=;
  b=cSc+B+c5ce1JVHR4VGfOKGu5LDxCcbfATWx7CP+IIyzb+cSpO3/PBVtN
   yRQd3BoozdQLgLsNNn9Sp0AnEWcN6+IsHBEVzTdz6Wmj4CWETYE8DC8DZ
   JBSxOe1yRYzZi6H8/YMRkIQheOLCscfDs1RWJUzMqTW6txBwP4KnOyl19
   kQTout4rHT9UfYT6Pzd6u0BDgJLEpyYFY9MhgcpyGSk7zG3fYd5B5YRKF
   kX1FYcz4JMTr+hb+JrwKSqpmY4WYCZNuyhlC/90sWg4V6A4uIyV0/x/9U
   R/Jwxo/l9WRNK5iAHvvgbdoxTcbZyVzdMrbzzeuf9FHv5q1QKqCnePU/h
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="292837247"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="292837247"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 10:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="614710548"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2022 10:58:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E612AAD; Tue, 30 Aug 2022 20:58:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: mcp23s08: Drop assignment of default number of OF cells
Date:   Tue, 30 Aug 2022 20:58:50 +0300
Message-Id: <20220830175850.44770-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

The GPIO library code will assign default value for number of OF
cells, no need to repeat this in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 695236636d05..5f356edfd0fd 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -549,9 +549,6 @@ int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 	mcp->chip.get = mcp23s08_get;
 	mcp->chip.direction_output = mcp23s08_direction_output;
 	mcp->chip.set = mcp23s08_set;
-#ifdef CONFIG_OF_GPIO
-	mcp->chip.of_gpio_n_cells = 2;
-#endif
 
 	mcp->chip.base = base;
 	mcp->chip.can_sleep = true;
-- 
2.35.1

