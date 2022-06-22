Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9665E5551C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376511AbiFVQyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377492AbiFVQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:54:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882D7634A;
        Wed, 22 Jun 2022 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655916781; x=1687452781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TSFLA2qyuJA9wYZda6wrVZj9J7j1LtYkgSeLmW6I7HY=;
  b=PqkWooUiXqRAwbFYj8ljJcqbO4ma1bdUH+JrP+YAuzGMkvny4/aMEBEU
   dshZCdLLgDQzVSfhyokQ0USV4Jb+WiuQ9YIdF4W75uHMlWjJ6IxbMP+pw
   72b7lGU1Wc12Pf+GXg/GYfZU50CZsc6m32Zclf0S3nySGUBLpM8jNclBl
   bacdK0d70yJM7ju1rvDq9QujpjhNZZyCyUnN9YHtxmDL/fcSI6bcqVGf9
   oFzAetaZiYqxQ4i//EztajbOQk4EtG8xRIzPSNvaTIuuRbcttbGsky1CB
   b+8j39lsGcRCyUc4VCHzthM6SZQP/tBvdhPbJmVOJoISxbJvRNyjF4GQr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344464393"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="344464393"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 09:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="655754028"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2022 09:52:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D6044136; Wed, 22 Jun 2022 19:53:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] clk: Remove never used devm_clk_*unregister()
Date:   Wed, 22 Jun 2022 19:52:54 +0300
Message-Id: <20220622165254.85184-1-andriy.shevchenko@linux.intel.com>
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
 drivers/clk/clk.c            | 31 -------------------------------
 include/linux/clk-provider.h |  2 --
 2 files changed, 33 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f00d4c1158d7..d1ab3c9161eb 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4296,37 +4296,6 @@ static int devm_clk_hw_match(struct device *dev, void *res, void *data)
 	return hw == data;
 }
 
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

