Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791F35A8815
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiHaV1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiHaV1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:27:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD256F4935
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661981254; x=1693517254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A565lb58KgWO0fhy6LRVycKv9iu0nYHIAJ0fWZliGWo=;
  b=IBImEEDTSlpbZhTERXOx5x/nfETcBua8movROoguDYb9fUGdVkSteWAE
   P1kr/zyvviJiOsKl4Q1UB42MHyZu5XK9bGKYbZLzNFzOyQbzT5DzeUMoM
   w9ac2yRkReYePsUc+/h1ClHA7VVhHxXvBFSG3t+HTLZtxyzi3Ck4Lm/ds
   UC8he3ORMg/3aNzdO6D0uHglCuAGPgT3ZccMD6w+ezfXJSMeZeqr579+8
   ATMsw+chbWdTgJJp8wtaMMMGHDPNlJOVKVq+XA54ZgaaBCi241NPJzsVG
   tV1qmnk5C1JzIhynNTPxJ3Y10rrRi835q86S5UzhrRoNelo8bBFlIsrEE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296828927"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="296828927"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="612236179"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2022 14:27:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 860CFAD; Thu,  1 Sep 2022 00:27:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 2/3] regmap: mmio: Use swabXX_array() helpers
Date:   Thu,  1 Sep 2022 00:27:43 +0300
Message-Id: <20220831212744.56435-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com>
References: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com>
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

Since we have a few helpers to swab elements of a given size in an array
use them instead of open coded variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/base/regmap/regmap-mmio.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index e8d2675463ac..66f92caa2fa2 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/swab.h>
 
 #include "internal.h"
 
@@ -345,7 +346,6 @@ static int regmap_mmio_noinc_read(void *context, unsigned int reg,
 {
 	struct regmap_mmio_context *ctx = context;
 	int ret = 0;
-	int i;
 
 	if (!IS_ERR(ctx->clk)) {
 		ret = clk_enable(ctx->clk);
@@ -382,27 +382,15 @@ static int regmap_mmio_noinc_read(void *context, unsigned int reg,
 	if (ctx->big_endian && (ctx->val_bytes > 1)) {
 		switch (ctx->val_bytes) {
 		case 2:
-		{
-			u16 *valp = (u16 *)val;
-			for (i = 0; i < val_count; i++)
-				valp[i] = swab16(valp[i]);
+			swab16_array(val, val_count);
 			break;
-		}
 		case 4:
-		{
-			u32 *valp = (u32 *)val;
-			for (i = 0; i < val_count; i++)
-				valp[i] = swab32(valp[i]);
+			swab32_array(val, val_count);
 			break;
-		}
 #ifdef CONFIG_64BIT
 		case 8:
-		{
-			u64 *valp = (u64 *)val;
-			for (i = 0; i < val_count; i++)
-				valp[i] = swab64(valp[i]);
+			swab64_array(val, val_count);
 			break;
-		}
 #endif
 		default:
 			ret = -EINVAL;
-- 
2.35.1

