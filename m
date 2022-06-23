Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C87557943
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiFWL5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiFWL50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:57:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952924D276;
        Thu, 23 Jun 2022 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655985443; x=1687521443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mI9mt75QXhUeT6LsBxQ1V+xM5AdpA//Kax74MdUgl40=;
  b=AY3uyZbYTConN7cusLyUD8jq0ihuTp5zwe0g9GI8+QI6eWT+aXkpult3
   BfMr7Vnkw5AMiaxDbpuOA9O843Xyteb2UokPkZtIlabI02moh2RRtjhoR
   XTlK9kzyDgotF+XfSVVDQ0iUF/VRJZA97dZkq5yqSiCeUDecEfzK5FAvS
   4bxskAtFgmeVhOPCRyVcJrGaDQ4+YTmn8N7tlDapMa6oBzgZ2nNBXHNpb
   ygsSA/DnEkqW5MpxW/vEnbp9uw4JQcZa9L+BgHTex96N08hHJkihWz8eY
   U4Qd+a2CIOthVJuN1gApNEYykk/7G61Na6MANvnkad2ij6TOOwc091r4o
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281776425"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281776425"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 04:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="915159597"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2022 04:57:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30A7249; Thu, 23 Jun 2022 14:57:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 2/3] clkdev: Remove never used devm_clk_release_clkdev()
Date:   Thu, 23 Jun 2022 14:57:18 +0300
Message-Id: <20220623115719.52683-2-andriy.shevchenko@linux.intel.com>
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

For the entire history of the devm_clk_release_clkdev() existence
(since 2018) it was never used. Remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/clkdev.c   | 34 ----------------------------------
 include/linux/clkdev.h |  2 --
 2 files changed, 36 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7f397a09877d..716bb1710b89 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -353,40 +353,6 @@ static void devm_clkdev_release(struct device *dev, void *res)
 	clkdev_drop(*(struct clk_lookup **)res);
 }
 
-static int devm_clk_match_clkdev(struct device *dev, void *res, void *data)
-{
-	struct clk_lookup **l = res;
-
-	return *l == data;
-}
-
-/**
- * devm_clk_release_clkdev - Resource managed clkdev lookup release
- * @dev: device this lookup is bound
- * @con_id: connection ID string on device
- * @dev_id: format string describing device name
- *
- * Drop the clkdev lookup created with devm_clk_hw_register_clkdev.
- * Normally this function will not need to be called and the resource
- * management code will ensure that the resource is freed.
- */
-void devm_clk_release_clkdev(struct device *dev, const char *con_id,
-			     const char *dev_id)
-{
-	struct clk_lookup *cl;
-	int rval;
-
-	mutex_lock(&clocks_mutex);
-	cl = clk_find(dev_id, con_id);
-	mutex_unlock(&clocks_mutex);
-
-	WARN_ON(!cl);
-	rval = devres_release(dev, devm_clkdev_release,
-			      devm_clk_match_clkdev, cl);
-	WARN_ON(rval);
-}
-EXPORT_SYMBOL(devm_clk_release_clkdev);
-
 /**
  * devm_clk_hw_register_clkdev - managed clk lookup registration for clk_hw
  * @dev: device this lookup is bound
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index 8a8423eb8e9a..45570bc21a43 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -46,6 +46,4 @@ int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
 
 int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
 				const char *con_id, const char *dev_id);
-void devm_clk_release_clkdev(struct device *dev, const char *con_id,
-			     const char *dev_id);
 #endif
-- 
2.35.1

