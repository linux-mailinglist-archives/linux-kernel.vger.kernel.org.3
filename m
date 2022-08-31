Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15EF5A80AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiHaOyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:54:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717ECC325
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957640; x=1693493640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WewXyGWrkI6CZTGTDosl2FVOiN/jXKLyzIyy1dbYklA=;
  b=d05o4mJY8SvuMKOpNQj/Ep2RGCPIWDx5lIUYJmHdb1bpi+R3ulBmvHBG
   c+u7q6y4Jo95IbDXUJ20Xoom75UygNftFe2W6aOaLGGdvcWJKhW1Jp345
   UWyVoVlzg7BUcVHzy5gFI8LR46ld+MkN44XbBLbBkL7cGSeJNHEZSbYuw
   SjS+Lv00+obfbISBs3IX+B2KaH7BjotsHw2eYG/WSi3PS080TwWcBkow0
   yCwAJ26O/vTn7DDZOfDco1j1ZYeBEIAjCk8zOUJRC8Up3myjZ4YqvmXTd
   op9g5Uya2E9fAiWv6eA1vE4nh+qTvYQ7oDdTrEooqIkqVGGzOj8QKvxFq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296744343"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296744343"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="589056893"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2022 07:53:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D69EDAD; Wed, 31 Aug 2022 17:54:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/3] regmap: mmio: Use swabXX_array() helpers
Date:   Wed, 31 Aug 2022 17:54:06 +0300
Message-Id: <20220831145407.78166-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831145407.78166-1-andriy.shevchenko@linux.intel.com>
References: <20220831145407.78166-1-andriy.shevchenko@linux.intel.com>
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

