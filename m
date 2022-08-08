Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C79258CF3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244369AbiHHUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbiHHUeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:34:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318521ADA8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659990850; x=1691526850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z30L/V2A5WB2cpGU23rJkCjAIqpAUcu0upDHufAxbU0=;
  b=Vn3C7ClxxrNDbUxs2erwfB4ab2fJKFke0E6fqECPXWq+yojuHskKkujR
   NiXrRGKW57FzqUscjmMM0ZmVc8nfhubcxVJIaDmoCLyTc13OFy3yLlsfa
   yh/E4ne3IW/yVjvRo6VZIDav2X4ypJ15A5byoSap7QpqRSIPTssMpHxbk
   wjjQEXd3AyPbSjicbbwYe3pc0XxVYVizuG1kLpkEk0MPSRY9TY7pA7a4w
   L5vGLpw2l9hTQ1a2irfscGRAXNW6E3jA8CJfAUHaWf/JL9At5wWpFNVMa
   D09xHwlmkRAB9XwpqjmqR472vnzVp6TAe2yRbHGcHa279z3QmimJJu0Up
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="352414544"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="352414544"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="780623938"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2022 13:34:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AEB381AA; Mon,  8 Aug 2022 23:34:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 4/4] regmap: mmio: Fix MMIO accessors to avoid talking to IO port
Date:   Mon,  8 Aug 2022 23:34:00 +0300
Message-Id: <20220808203401.35153-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
References: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
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

Currently regmap MMIO is inconsistent with IO accessors. I.e.
the Big Endian counterparts are using ioreadXXbe() / iowriteXXbe()
which are not clean implementations of readXXbe().

That said, reimplement current Big Endian MMIO accessors by replacing
ioread()/iowrite() with respective read()/write() and swab() calls.

Note, there are no current in-kernel users that may utilize the
functionality of the IO ports on Big Endian hardware. All drivers
that use regmap MMIO either Little Endian, or they don't map IO
ports in a way that ioreadXX()/iowriteXX() may be utilized.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-mmio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 37f79e912d01..eed488aad1b0 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -104,7 +104,7 @@ static void regmap_mmio_write16be(struct regmap_mmio_context *ctx,
 				  unsigned int reg,
 				  unsigned int val)
 {
-	iowrite16be(val, ctx->regs + reg);
+	writew(swab16(val), ctx->regs + reg);
 }
 
 static void regmap_mmio_iowrite16be(struct regmap_mmio_context *ctx,
@@ -137,7 +137,7 @@ static void regmap_mmio_write32be(struct regmap_mmio_context *ctx,
 				  unsigned int reg,
 				  unsigned int val)
 {
-	iowrite32be(val, ctx->regs + reg);
+	writel(swab32(val), ctx->regs + reg);
 }
 
 static void regmap_mmio_iowrite32be(struct regmap_mmio_context *ctx,
@@ -204,7 +204,7 @@ static unsigned int regmap_mmio_ioread16le(struct regmap_mmio_context *ctx,
 static unsigned int regmap_mmio_read16be(struct regmap_mmio_context *ctx,
 				         unsigned int reg)
 {
-	return ioread16be(ctx->regs + reg);
+	return swab16(readw(ctx->regs + reg));
 }
 
 static unsigned int regmap_mmio_ioread16be(struct regmap_mmio_context *ctx,
@@ -234,7 +234,7 @@ static unsigned int regmap_mmio_ioread32le(struct regmap_mmio_context *ctx,
 static unsigned int regmap_mmio_read32be(struct regmap_mmio_context *ctx,
 				         unsigned int reg)
 {
-	return ioread32be(ctx->regs + reg);
+	return swab32(readl(ctx->regs + reg));
 }
 
 static unsigned int regmap_mmio_ioread32be(struct regmap_mmio_context *ctx,
-- 
2.35.1

