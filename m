Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A781358B0F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiHEUxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiHEUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:53:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A727914D0F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659732810; x=1691268810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUK1ZmvLOiqFQ/6rctVM5qooY+a4+dohGMG8XKuCOX4=;
  b=dPGDMhAOWn6vFm/LTftLYMvymCQjUp23DL7LS50mYyxA19z4R3hVdjpv
   bqBs7Kv5Rx0vWz/T5nLhtnl0uR4qlHJ6NcubiIKQcvAJMXfBR51uAGA0L
   Q2lI1F0mLTdTgOa2YKoMSKr6jst1v14YaNdVti56HXSnTaIRTCjc1QO6V
   FxJCBxdb4MicPitjV3TJ5tEf2ZfT68BTj1maM5hsXwqzIpyYSvGjCIQoK
   SDacfr7YYhr5jCT7lWA6rsT85bgG64VxyCdzY3ia6zOQ5g3IycAtv6d7D
   9+ZNzTYpLCWsGaRPlLsFTeGleEdY/1iVNuo8ZOR0P3mCGj6kHbyreKy4y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="287853562"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287853562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="706735347"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Aug 2022 13:53:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 41B9CD9; Fri,  5 Aug 2022 23:53:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/5] regmap: mmio: Drop unneeded and duplicative checks around CLK calls
Date:   Fri,  5 Aug 2022 23:53:18 +0300
Message-Id: <20220805205321.19452-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
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

The commit 6b8e090ecc3d ("regmap: use IS_ERR() to check clk_get()
results") assumes that CLK calls return the error pointer when clock
is not found. However in the current code the described situation
is simply impossible, because the regmap won't be created with
missed clock if requested. The only way when it can be the case is
what the above mentioned commit introduced by itself, when clock is
not provided.

Taking above into consideration, effectively revert the commit
6b8e090ecc3d and while at it, drop unneeded NULL checks since CLK
calls are NULL-aware.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-mmio.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index e83a2c3ba95a..e1923506a89a 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -146,16 +146,13 @@ static int regmap_mmio_write(void *context, unsigned int reg, unsigned int val)
 	struct regmap_mmio_context *ctx = context;
 	int ret;
 
-	if (!IS_ERR(ctx->clk)) {
-		ret = clk_enable(ctx->clk);
-		if (ret < 0)
-			return ret;
-	}
+	ret = clk_enable(ctx->clk);
+	if (ret < 0)
+		return ret;
 
 	ctx->reg_write(ctx, reg, val);
 
-	if (!IS_ERR(ctx->clk))
-		clk_disable(ctx->clk);
+	clk_disable(ctx->clk);
 
 	return 0;
 }
@@ -227,16 +224,13 @@ static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
 	struct regmap_mmio_context *ctx = context;
 	int ret;
 
-	if (!IS_ERR(ctx->clk)) {
-		ret = clk_enable(ctx->clk);
-		if (ret < 0)
-			return ret;
-	}
+	ret = clk_enable(ctx->clk);
+	if (ret < 0)
+		return ret;
 
 	*val = ctx->reg_read(ctx, reg);
 
-	if (!IS_ERR(ctx->clk))
-		clk_disable(ctx->clk);
+	clk_disable(ctx->clk);
 
 	return 0;
 }
@@ -245,7 +239,7 @@ static void regmap_mmio_free_context(void *context)
 {
 	struct regmap_mmio_context *ctx = context;
 
-	if (!IS_ERR(ctx->clk) && !ctx->attached_clk) {
+	if (!ctx->attached_clk) {
 		clk_unprepare(ctx->clk);
 		clk_put(ctx->clk);
 	}
@@ -290,7 +284,6 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 	ctx->regs = regs;
 	ctx->val_bytes = config->val_bits / 8;
 	ctx->relaxed_mmio = config->use_relaxed_mmio;
-	ctx->clk = ERR_PTR(-ENODEV);
 
 	switch (regmap_get_val_endian(dev, &regmap_mmio, config)) {
 	case REGMAP_ENDIAN_DEFAULT:
-- 
2.35.1

