Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C768F55794C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiFWL5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiFWL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:57:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A554D614;
        Thu, 23 Jun 2022 04:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655985445; x=1687521445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ce43flTutdWp+lJ4X2FWdJd4XMwCf5ChCFOwzmnicV8=;
  b=Oy1Xox+fe6er+VthNJppUZSxy/ov+pys5nPlQavM3J6FySXGoI19sgMC
   vOy7fGqhBTno8o6pF9Gr9uKFmEUjocIr+/xOE7GIUKOYdg3XEDpUzpj+r
   79EjKrDlCLYrubUB8zQRwWzvIV6C7ryhIM356UvcdXCMti/6BLqcUJsGH
   Wu2orW3omclFEApH8MZ3mW/XlRILIl/Kh0lnQt5ZCQSXAqM1Nu248ImJm
   ZQ/cM7htuSln6uH8O3P00UOyVX7sdOFUfM5BK54UFmCo7t4i1b9KHQGKI
   VyBKgH76dLednk8WKxVhCzgi0+aoyVfUUud4rO/2+u7lc/W1RSf8qe7os
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281776426"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281776426"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 04:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644704180"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jun 2022 04:57:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3A458152; Thu, 23 Jun 2022 14:57:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 3/3] clkdev: Simplify devm_clk_hw_register_clkdev() function
Date:   Thu, 23 Jun 2022 14:57:19 +0300
Message-Id: <20220623115719.52683-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623115719.52683-1-andriy.shevchenko@linux.intel.com>
References: <20220623115719.52683-1-andriy.shevchenko@linux.intel.com>
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

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/clkdev.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 716bb1710b89..b5eed37dc71a 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -348,9 +348,9 @@ int clk_hw_register_clkdev(struct clk_hw *hw, const char *con_id,
 }
 EXPORT_SYMBOL(clk_hw_register_clkdev);
 
-static void devm_clkdev_release(struct device *dev, void *res)
+static void devm_clkdev_release(void *res)
 {
-	clkdev_drop(*(struct clk_lookup **)res);
+	clkdev_drop(res);
 }
 
 /**
@@ -371,17 +371,13 @@ static void devm_clkdev_release(struct device *dev, void *res)
 int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
 				const char *con_id, const char *dev_id)
 {
-	int rval = -ENOMEM;
-	struct clk_lookup **cl;
-
-	cl = devres_alloc(devm_clkdev_release, sizeof(*cl), GFP_KERNEL);
-	if (cl) {
-		rval = do_clk_register_clkdev(hw, cl, con_id, dev_id);
-		if (!rval)
-			devres_add(dev, cl);
-		else
-			devres_free(cl);
-	}
-	return rval;
+	struct clk_lookup *cl;
+	int rval;
+
+	rval = do_clk_register_clkdev(hw, &cl, con_id, dev_id);
+	if (rval)
+		return rval;
+
+	return devm_add_action_or_reset(dev, devm_clkdev_release, cl);
 }
 EXPORT_SYMBOL(devm_clk_hw_register_clkdev);
-- 
2.35.1

