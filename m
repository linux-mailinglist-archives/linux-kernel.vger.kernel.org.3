Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33F35B1908
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiIHJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiIHJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:43:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7A898355;
        Thu,  8 Sep 2022 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662630193; x=1694166193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kpIfZTKwE6KuJvJneNDW0kEXCF2mr7QRx33ruMCnGlY=;
  b=aQvCXZX6FM29T9j590avU2ai2W9FaH4/dw0i4gnnZ/67THQi5UXD3lb+
   Wc+oeViuZu1gijeolzrwhr7obdCsAPWI2I8D1Mhv+FcRAuXn9brIBmO2X
   xp4IYazhKMAva9DciF2ESY2VwWntTOHJDmNCh3kUPC66OuGMveynOwMNU
   A0f0b8bM/tX9TSl1ww3aTkyoBEMWAGrrCZLoSeupZMOHJIUYAChY7ufCI
   I05YHagD3NlNhlWTIjRU8U5KFnOy3IxRNgryMcUXTXdQBEIbT2wRl69X4
   wbXn+Kv280QVOdG+z4g5V999Z8BCu+1rVHvSeomurEMKJK+6GxbfgSFCv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="383418189"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="383418189"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 02:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="859976038"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 08 Sep 2022 02:43:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E2693F7; Thu,  8 Sep 2022 12:43:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: pistachio: Correct the fwnode_irq_get() return value check
Date:   Thu,  8 Sep 2022 12:43:23 +0300
Message-Id: <20220908094323.31965-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwnode_irq_get() may return all possible signed values, such as Linux
error code or 0. Fix the code to handle this properly.

Fixes: 1074e1d23a5c ("pinctrl: pistachio: Switch to use fwnode instead of")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-pistachio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index 940ed3fff63a..7ca4ecb6eb8d 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -1374,8 +1374,14 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 
 		ret = fwnode_irq_get(child, 0);
 		if (ret < 0) {
+			fwnode_handle_put(child);
+			dev_err(pctl->dev, "Failed to retrieve IRQ for bank %u\n", i);
+			goto err;
+		}
+		if (!ret) {
 			fwnode_handle_put(child);
 			dev_err(pctl->dev, "No IRQ for bank %u\n", i);
+			ret = -EINVAL;
 			goto err;
 		}
 		irq = ret;
-- 
2.35.1

