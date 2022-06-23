Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B7055793A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiFWL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiFWL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:57:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23FF4D608;
        Thu, 23 Jun 2022 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655985443; x=1687521443;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rFzp9FJ0Hi0BvdZQ2nyFZrp7Abz1SQG22Ug72RhOvrw=;
  b=Wb3HMytS9EwKCkpsukehAgyPHfmNGFYlPS15fDHAemhUJxmxuGLLxslQ
   WfRP1C1SuArc08PcZ4QXw+2ucFb/w4pCxA1JuhKW3tZk6risfJCqcuV7n
   2ztMJQeiSu4J93c/Fajm0Gyx+nwYQLzUK0p075KtSZDLnBr8k01l7h4Mc
   vozDBeJSTvtZ6wOQVnkoLhkvwHx2cK7SZlwBhsAEJxJCJWJNwduOhKGub
   VqGbyUssS/z0xvm+ftL/CxcALEYqVfgXVDB49XsPtqyAzPJzj6Yv4JVUq
   nTqRVI8HImQ6OFREjvQZXlvSe0H8OyKA/p6vKFPNTyDNOWDf3jYskWlU/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280745085"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="280745085"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 04:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="586128577"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 23 Jun 2022 04:57:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 218AC136; Thu, 23 Jun 2022 14:57:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 1/3] clk: Remove never used devm_of_clk_del_provider()
Date:   Thu, 23 Jun 2022 14:57:17 +0300
Message-Id: <20220623115719.52683-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the entire history of the devm_of_clk_del_provider) existence
(since 2017) it was never used. Remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/clk.c            | 26 --------------------------
 include/linux/clk-provider.h |  4 ++--
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5cbf21acb1a8..1a9dd980f74a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4751,32 +4751,6 @@ void of_clk_del_provider(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_clk_del_provider);
 
-static int devm_clk_provider_match(struct device *dev, void *res, void *data)
-{
-	struct device_node **np = res;
-
-	if (WARN_ON(!np || !*np))
-		return 0;
-
-	return *np == data;
-}
-
-/**
- * devm_of_clk_del_provider() - Remove clock provider registered using devm
- * @dev: Device to whose lifetime the clock provider was bound
- */
-void devm_of_clk_del_provider(struct device *dev)
-{
-	int ret;
-	struct device_node *np = get_clk_provider_node(dev);
-
-	ret = devres_release(dev, devm_of_clk_release_provider,
-			     devm_clk_provider_match, np);
-
-	WARN_ON(ret);
-}
-EXPORT_SYMBOL(devm_of_clk_del_provider);
-
 /**
  * of_parse_clkspec() - Parse a DT clock specifier for a given device node
  * @np: device node to parse clock specifier from
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 72d937c03a3e..8ad92a4a748f 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1420,7 +1420,7 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 						 void *data),
 			   void *data);
 void of_clk_del_provider(struct device_node *np);
-void devm_of_clk_del_provider(struct device *dev);
+
 struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
 				  void *data);
 struct clk_hw *of_clk_hw_simple_get(struct of_phandle_args *clkspec,
@@ -1457,7 +1457,7 @@ static inline int devm_of_clk_add_hw_provider(struct device *dev,
 	return 0;
 }
 static inline void of_clk_del_provider(struct device_node *np) {}
-static inline void devm_of_clk_del_provider(struct device *dev) {}
+
 static inline struct clk *of_clk_src_simple_get(
 	struct of_phandle_args *clkspec, void *data)
 {
-- 
2.35.1

