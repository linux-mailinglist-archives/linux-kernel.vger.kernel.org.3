Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9360F555209
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359504AbiFVRLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiFVRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:11:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F983AB;
        Wed, 22 Jun 2022 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655917907; x=1687453907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fcA9AcB3NWmPG6Co6bXGd9pKtVTF1zImy8268NHVjQw=;
  b=GkSn3rjXM3lrm4TPkO+1m2WIsh3LyT+pfmQtpb0FA5bZsw5AyyuFWPJ4
   eY6HkXq8HQG7MhBBTGcvZcJ5xO+06rG1bYHP9EDBn3rU/If36PGrMQ32C
   h30HshODapwxu7fvoRqsxv/3RjW4yKTPba/0ZNxToE5UjUzicom1LERua
   zj9uxaAWHY5D/fxlFKhcynY+MO/V95vOQCVEqE9dDDtmuLRqVqU/70t3C
   IMy6dAO1TWJ5MuBq7Jtu4cBosOl/Rg6s5Je2Gz/xiHIoimLRDFwRPsJMe
   LDFPehyBnqjJK7ayFu5s035TiF9tK8OD3MTGp5rFXFrRPlyPY1jlIw8Ro
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281555212"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281555212"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="690599907"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2022 10:11:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6729E136; Wed, 22 Jun 2022 20:11:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] clk: Remove never used devm_clk_*unregister()
Date:   Wed, 22 Jun 2022 20:11:47 +0300
Message-Id: <20220622171147.85603-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

For the entire history of the devm_clk_*unregister() existence they were
used only once (*) in 2015. Remove them.

*) The commit 264e3b75de4e ("clk: s2mps11: Simplify s2mps11_clk_probe unwind
   paths") exactly supports the point of the change proposed here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: removed now unused match() functions as well
 drivers/clk/clk.c            | 48 ------------------------------------
 include/linux/clk-provider.h |  2 --
 2 files changed, 50 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f00d4c1158d7..7fc191c15507 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4279,54 +4279,6 @@ int devm_clk_hw_register(struct device *dev, struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register);
 
-static int devm_clk_match(struct device *dev, void *res, void *data)
-{
-	struct clk *c = res;
-	if (WARN_ON(!c))
-		return 0;
-	return c == data;
-}
-
-static int devm_clk_hw_match(struct device *dev, void *res, void *data)
-{
-	struct clk_hw *hw = res;
-
-	if (WARN_ON(!hw))
-		return 0;
-	return hw == data;
-}
-
-/**
- * devm_clk_unregister - resource managed clk_unregister()
- * @dev: device that is unregistering the clock data
- * @clk: clock to unregister
- *
- * Deallocate a clock allocated with devm_clk_register(). Normally
- * this function will not need to be called and the resource management
- * code will ensure that the resource is freed.
- */
-void devm_clk_unregister(struct device *dev, struct clk *clk)
-{
-	WARN_ON(devres_release(dev, devm_clk_unregister_cb, devm_clk_match, clk));
-}
-EXPORT_SYMBOL_GPL(devm_clk_unregister);
-
-/**
- * devm_clk_hw_unregister - resource managed clk_hw_unregister()
- * @dev: device that is unregistering the hardware-specific clock data
- * @hw: link to hardware-specific clock data
- *
- * Unregister a clk_hw registered with devm_clk_hw_register(). Normally
- * this function will not need to be called and the resource management
- * code will ensure that the resource is freed.
- */
-void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw)
-{
-	WARN_ON(devres_release(dev, devm_clk_hw_unregister_cb, devm_clk_hw_match,
-				hw));
-}
-EXPORT_SYMBOL_GPL(devm_clk_hw_unregister);
-
 static void devm_clk_release(struct device *dev, void *res)
 {
 	clk_put(*(struct clk **)res);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c10dc4c659e2..72d937c03a3e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1176,10 +1176,8 @@ int __must_check devm_clk_hw_register(struct device *dev, struct clk_hw *hw);
 int __must_check of_clk_hw_register(struct device_node *node, struct clk_hw *hw);
 
 void clk_unregister(struct clk *clk);
-void devm_clk_unregister(struct device *dev, struct clk *clk);
 
 void clk_hw_unregister(struct clk_hw *hw);
-void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw);
 
 /* helper functions */
 const char *__clk_get_name(const struct clk *clk);
-- 
2.35.1

