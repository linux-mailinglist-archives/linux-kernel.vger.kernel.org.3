Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B791A58B0F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbiHEUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiHEUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:53:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C82DAA5
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659732809; x=1691268809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CLG8QBig6W7Ufvc9XUaDUl99OZkPYep3DAnZgBl/kZk=;
  b=HeRSyptQZmW3z1DT24ZuhzAMMk1x5yEH0F5LqL9lzke4eeD7Sz3qrFN3
   gJ9IU06IPg2ML0gm2LVZDB0psUCgwqgy3YWTb+3isc14oyCGXgwP91WKn
   yLtLz8mhP3Snd2IpaQ90/v/USd28FLsKGAvBu0fPOoXfhvEmUqozmnIbJ
   bzXRJcI8oRkIvrZPYExjfRqqzzli+I2FNj6fP+XGTxKl+ePIbpmoyXZGw
   gOkBb+nfDGX8/9BLIkWzl5elwF4VSmNfEPFHEFTCgrcSWVaiJ8vdInNCz
   /oDPkjJ3Em1P96Iclhkz7qvxwxrKTO+FhT2AZmvZEOI20PuGYFCCQ+SCD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289047570"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="289047570"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579631437"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2022 13:53:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3705AF7; Fri,  5 Aug 2022 23:53:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/5] regmap: mmio: Don't unprepare attached clock
Date:   Fri,  5 Aug 2022 23:53:17 +0300
Message-Id: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
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

The commit eb4a219d19fd ("regmap: Skip clk_put for attached clocks when
freeing context") oexcluded clk_put() call on regmap freeing. But the
same is needed for clk_unprepare() since the regmap MMIO users should
call regmap_mmio_detach_clk() which does unprepare the clock. Update
the code accordingly, so neither clk_put() nor clk_unprepare() would
be called for the attached clock.

Fixes: eb4a219d19fd ("regmap: Skip clk_put for attached clocks when freeing context")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-mmio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 71f16be7e717..e83a2c3ba95a 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -245,10 +245,9 @@ static void regmap_mmio_free_context(void *context)
 {
 	struct regmap_mmio_context *ctx = context;
 
-	if (!IS_ERR(ctx->clk)) {
+	if (!IS_ERR(ctx->clk) && !ctx->attached_clk) {
 		clk_unprepare(ctx->clk);
-		if (!ctx->attached_clk)
-			clk_put(ctx->clk);
+		clk_put(ctx->clk);
 	}
 	kfree(context);
 }
-- 
2.35.1

